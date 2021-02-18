unit CSUtils;

interface
  uses
    System.Sysutils, System.Classes, Winapi.Windows, IdStack, IdGlobal;

  type
    TUserData = class; // forword 선언

    TUserConnectionState = (LOGIN, LOGOUT, DISCONNECT, UNNKOWN);
    TMessageKind = (TEXT, IMAGE, EVENT, PUSH, NOTICE, REQUEST_USER_INFORMATION, RESPONSE_USER_INFORMATION); // 메세지, 이미지, 이벤트, 푸시, 알림
    TCommandKind = (SEND_MESSAGE, SEND_IMAGE, SEND_USER_INFORMATION, RECV_MESSAGE, RECV_IMAGE, RECV_USER_INFORMATION);

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
      Msg: String[50]; // Message
    end;

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

  PMessage = ^TMessage;

  function MessageDateTime: String;
  function GetLocalIP: ShortString;
  function GetComputerName: ShortString;
  function GetWindowsVersion: ShortString;

implementation

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
begin

end;

end.
