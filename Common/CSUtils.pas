unit CSUtils;

interface
  uses
    System.Sysutils, System.Classes, Winapi.Windows, IdStack, IdGlobal;

  type
    TUserData = class; // forword 선언

    TUserConnectionState = (LOGIN, LOGOUT, DISCONNECT, UNNKOWN);
    TMessageKind = (TEXT, IMAGE, EVENT, PUSH, NOTICE, REQUEST_USER_INFORMATION, RESPONSE_USER_INFORMATION, ITEM_LIST); // 메세지, 이미지, 이벤트, 푸시, 알림
    TCommandKind = (SEND_MESSAGE, SEND_IMAGE, SEND_USER_INFORMATION, RECV_MESSAGE, RECV_IMAGE, RECV_USER_INFORMATION);
    // 1. 상태변경

    TGenericRecord<TRecordType> = class
    private
      FValue: TRecordType;
    public
      function ByteArrayToRecord(ABuffer: TIdBytes): TRecordType;
      function RecordToByteArray(ARecord: TRecordType): TIdBytes;

      property Value: TRecordType read FValue write FValue;
    end;

    TCommand = record
      Kind: TCommandKind;
      TimeStamp: TDateTime;
    end;

    TMessage = packed record
      Kind: TMessageKind; // Message Kind
      Size: LongInt;
    end;

    PMessage = ^TMessage;

    TUserData = class
    private
      FID: ShortString;
      FName: ShortString;
      FGrant: Byte;
      FIP: ShortString;
      FSessionDateTime: TDateTime;
    public
      constructor Create;
      destructor Destory;

      property ID: ShortString read FID write FID;
      property Name: ShortString read FName write FName;
      property Grant: Byte read FGrant write FGrant;
      property SessionDatetime: TDateTime read FSessionDateTime write FSessionDateTime;
      property IP: ShortString read FIP write FIP;
    end;

    TUserList = class
    private
    public
      constructor Create;
      destructor Destroy; override;
    end;

  function MessageDateTime: String;
  function GetLocalIP: ShortString;
  function GetComputerName: ShortString;
  function GetWindowsVersion: ShortString;
  function StrToBytes(const AValue: WideString): TBytes;
  function BytesToStr(const AValue: TBytes): WideString;

implementation

function BytesToStr(const AValue: TBytes): WideString;
begin
  SetLength(Result, Length(AValue) div SizeOf(WideChar));

  if Length(Result) > 0 then
    Move(AValue[0], Result[1], Length(AValue));
end;

function StrToBytes(const AValue: WideString): TBytes;
begin
  SetLength(Result, Length(AValue) * SizeOf(WideChar));

  if Length(Result) > 0 then
    Move(AValue[1], Result[0], Length(Result));
end;

function MessageDateTime: String;
begin
  Result := FormatDateTime('[ yyyy-mm-dd hh:nn:ss ] :', Now);
end;

function GetLocalIP: ShortString;
begin
  TIdStack.IncUsage;
  try
    Result := GStack.LocalAddress;
  finally
    TIdStack.DecUsage;
  end;
end;

function GetComputerName: ShortString;
var
  buffer : array [0 .. MAX_COMPUTERNAME_LENGTH + 1] of Char;
  Size : Cardinal;
begin
  Size := MAX_COMPUTERNAME_LENGTH + 1;
  GetComputerNameW(@buffer, Size);

  Result := StrPas(buffer);
  // uses Winapi.Windows add
end;

function GetWindowsVersion: ShortString;
var
  OSVer : OSVERSIONINFOEX;
begin
  OSVer.dwOSVersionInfoSize := SizeOf(OSVERSIONINFOEX);
  GetVersionEx(OSVer);
  Result := IntToStr(OSVer.dwMajorVersion) + '.' + IntToStr(OSVer.dwMinorVersion);

  // 참조 https://docs.microsoft.com/ko-kr/windows/win32/sysinfo/operating-system-version
end;

{ TUserData }

constructor TUserData.Create;
begin
  ID := 'TEST';
  NAME := 'TEST';
  Grant := 1;
  IP := GetLocalIP;
  SessionDatetime := Now;
end;

destructor TUserData.Destory;
begin

end;

{ TUserList }

constructor TUserList.Create;
begin

end;

destructor TUserList.Destroy;
begin

  inherited;
end;

{ TGenericRecord<TRecordType> }

function TGenericRecord<TRecordType>.ByteArrayToRecord(ABuffer: TIdBytes): TRecordType;
var
  LDest: PAnsiChar;
begin
  LDest := PAnsiChar(@Result);
  Move(ABuffer[0], LDest[0], SizeOf(TRecordType));
end;

function TGenericRecord<TRecordType>.RecordToByteArray(ARecord: TRecordType): TIdBytes;
var
  LSource: PAnsiChar;
begin
  LSource := PAnsiChar(@aRecord);
  SetLength(Result, SizeOf(TRecordType));
  Move(LSource[0], Result[0], SizeOf(TRecordType));
end;

end.
