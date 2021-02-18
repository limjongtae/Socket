unit ClientUnit;

interface

uses
  System.classes, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdGlobal, IdContext, Winapi.Windows, System.SysUtils,
  CSUtils, IdStack, System.Diagnostics, dxGDIPlusClasses, Syncobjs;

const
  WAITTIME = 1000; // 응답대기시간

type
  TClientStatus = record
  public
    Status: TIdStatus;
    Thread: Boolean;
  end;

  PClientStuats = ^TClientStatus;

  // User Event
  TClientReceivedEvent = procedure (Sender: TObject; Text: String; Image: TdxSmartImage) of object; // 서버로부터 데이터를 받았을때
  TClientStatusNotifyEvent = procedure (AStatus: PClientStuats) of object; // 클라이언트 상태 이벤트

  // Object
  TClientUnit = class; // foward 선언

  TClientThread = class(TThread)
  private
    FClient: TClientUnit;
  public
    constructor Create(AClient: TClientUnit);
    destructor Destroy; override;

    procedure Execute; override;

    property Client: TClientUnit Read FClient Write FClient;
  end;

  TClientUnit = class(TIdTCPClient)
  protected
    FOnReceived: TClientReceivedEvent;
    FOnStatusNotify: TClientStatusNotifyEvent;
  private
    FComputerName: ShortString;
    FClientStatus: PClientStuats;
    FClientThread: TClientThread;
    FUserData: TUserData;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Send(Text: String);
    procedure UserInformationResponese;

    procedure DoConnected(Sender: TObject);
    procedure DoDisconnected(Sender: TObject);

    procedure Received(Sender: TObject; Text: String; Image: TdxSmartImage); // 메세지 전송
    procedure StatusNotify(ClientStatus: PClientStuats); // 상태변경 알림
    procedure DoStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string); //

    property OnReceived: TClientReceivedEvent read FOnReceived write FOnReceived;
    property OnStatusNotify: TClientStatusNotifyEvent read FOnStatusNotify write FOnStatusNotify;

    property UserData: TUserData read FUserData;
  end;

implementation

{ TClientUnit }

uses ClientForm.View;

constructor TClientUnit.Create;
begin
  // Host Setting
  inherited Create;

  Host := '127.0.0.1';
  Port := 8090;
  OnConnected := DoConnected;
  OnStatus := DoStatus;

  ConnectTimeout := 5000;

  New(FClientStatus);

  // Read Thread Create
  FClientThread := TClientThread.Create(Self);
  FUserData := TUserData.Create;
end;

destructor TClientUnit.Destroy;
begin
  Dispose(FClientStatus);
  FClientThread.Free;
  FUserData.Free;
  inherited Destroy;
end;

procedure TClientUnit.DoConnected(Sender: TObject);
var
  MessageRecord: TMessage;
  CommandRecord: TCommand;
  CommandBuffer, MessageBuffer: TIdBytes;
  S: String;
begin
//  S := GetResponse('TEST');
    // Send Command
//  CommandRecord.Kind := TCommandKind.SEND_MESSAGE;
//  CommandRecord.TimeStamp := Now;
//
//  CommandBuffer := RawToBytes(CommandRecord, SizeOf(CommandRecord));
//  try
//    IOHandler.Write(CommandBuffer);
//  finally
//    SetLength(CommandBuffer, 0);
//  end;


end;

procedure TClientUnit.DoDisconnected(Sender: TObject);
begin
  //
end;

procedure TClientUnit.DoStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
begin
   case AStatus of
     hsResolving: ;
     hsConnecting: ;
     hsConnected:
       if FClientThread.Suspended then
         FClientThread.Resume;
     hsDisconnected:
       if not FClientThread.Suspended then
         FClientThread.Suspend;
     hsDisconnecting: ;
     hsStatusText: ;
     ftpTransfer: ;
     ftpReady: ;
     ftpAborted: ;
   end;

   FClientStatus.Status := AStatus;
   FClientStatus.Thread := FClientThread.Suspended;

   StatusNotify(FClientStatus);
end;

procedure TClientUnit.Received(Sender: TObject; Text: String; Image: TdxSmartImage);
begin
  if Assigned(FOnReceived) then
    FOnReceived(Sender, Text, Image);
end;

procedure TClientUnit.Send(Text: String);
var
  MessageRecord: TMessage;
  CommandRecord: TCommand;
  CommandBuffer, MessageBuffer: TIdBytes;
begin
  // Send Command
//  CommandRecord.Kind := TCommandKind.SEND_MESSAGE;
//  CommandRecord.TimeStamp := Now;
//
//  CommandBuffer := RawToBytes(CommandRecord, SizeOf(CommandRecord));
//  try
//    IOHandler.Write(CommandBuffer);
//  finally
//    SetLength(CommandBuffer, 0);
//  end;

  //SendMessage
//    MessageRecord.Kind := TMessageKind.TEXT;
//    MessageRecord.Msg := Text;
//
//    MessageBuffer := RawToBytes(MessageRecord, SizeOf(TMessage));
//    try
//      IOHandler.Write(MessageBuffer);
//    finally
//      SetLength(MessageBuffer, 0);
//    end;
  SendCmd('SENDCMD');
  if CheckResponse(LastCmdResult.NumericCode, [200]) = 200 then
    IOHandler.WriteLn('SUCCESS');
end;

procedure TClientUnit.StatusNotify(ClientStatus: PClientStuats);
begin
  if Assigned(FOnStatusNotify) then
    FOnStatusNotify(ClientStatus);
end;

procedure TClientUnit.UserInformationResponese;
var
  ResponeRecord: TMessage;
  Buffer: TIdBytes;
begin
  // Record Create
  ResponeRecord.Kind := TMessageKind.RESPONSE_USER_INFORMATION;
  try
    Buffer := RawToBytes(ResponeRecord, SizeOf(ResponeRecord));
    IOHandler.Write(Buffer);
  finally
    SetLength(Buffer, 0);
  end;
end;

{ TClientThread }

constructor TClientThread.Create(AClient: TClientUnit);
begin
  inherited Create(True);  // False 바로 수행
  FreeOnTerminate := False; // Thread 메모리 해제 방지
  Client := AClient; // Target
end;

destructor TClientThread.Destroy;
begin
  inherited Destroy;
end;

procedure TClientThread.Execute;
var
  StopWatch: TStopwatch; // 요청시간 계산
  ElapsedMillseconds, ReadStreamSize: Int64;
  MemoryStream: TMemoryStream;
  Image: TdxSmartImage;
  LBuffer: TIdBytes;
  MessageRecord: TMessage;
  CommandRecord: TCommand;
  S: String;
begin
  while not Terminated do
  begin
    StopWatch := TStopwatch.StartNew;
    repeat
      // 이걸 제거하면 스레드 재기동 문제가 해결되는데.. 제거하면 CPU 점유율이 미친듯이 올라감..
      // 어떻게 해결해야될까
      // CheckForDisconnect 메서드에 뭔가 문제가있는데.. 뭐지 ... 모르겟네
      // Client.IOHandler.CheckForDisconnect(True, True);

      Client.IOHandler.CheckForDataOnSource(100);

      if StopWatch.ElapsedMilliseconds > WAITTIME then // 진행시간 - 시작시간 > 3초보다크면 읽기 종료
      begin
        Client.Received(Self,  MESSAGEDATETIME + 'Reading....', nil);
        Break;
      end;
//      WaitForSingleObject( Handle, 10 );
    until not Client.IOHandler.InputBufferIsEmpty;

    if StopWatch.ElapsedMilliseconds > WAITTIME then
      Continue;

    StopWatch := TStopwatch.StartNew;
    try
      ElapsedMillseconds := StopWatch.ElapsedMilliseconds;

      Client.GetResponse('SENDCMD');
      if Client.LastCmdResult.NumericCode = 200 then
//      if Client.GetResponse([200]) = 200 then
        Client.Received(Self, MESSAGEDATETIME + Client.IOHandler.ReadLn + Format('[Byte / %d s ]', [ElapsedMillseconds]), nil);


      // 요청이 없을경우 ReadLn할 경우 정상적인 해제가 이루어지지 않음
      // 이유는 IOHandler가 메모리를 잡고있기때문인것 같음..

//      Client.IOHandler.ReadBytes(LBuffer, SizeOf(CommandRecord));
//      BytesToRaw(LBuffer, CommandRecord, SizeOf(CommandRecord));
////      ElapsedMillseconds := StopWatch.ElapsedMilliseconds;
//      SetLength(LBuffer, 0);
//
//      case CommandRecord.Kind of
//        TCommandKind.SEND_USER_INFORMATION :
//        begin
//          Client.IOHandler.ReadBytes(LBuffer, SizeOf(MessageRecord));
//          BytesToRaw(LBuffer, MessageRecord, SizeOf(MessageRecord));
//          SetLength(LBuffer, 0);
//          Client.Received(Self, MESSAGEDATETIME + MessageRecord.Msg + Format('[Byte / %d s ]', [ElapsedMillseconds]), nil);
//        end;
//      end;

//      ElapsedMillseconds := StopWatch.ElapsedMilliseconds;
//      Client.IOHandler.ReadBytes(LBuffer, SizeOf(LRecord));
//      BytesToRaw(LBuffer, LRecord, SizeOf(LRecord));
//      ElapsedMillseconds := StopWatch.ElapsedMilliseconds;
//
//      case LRecord.Kind of
//        TEXT : Client.Received(Self, MESSAGEDATETIME + LRecord.Msg + Format('[Byte / %d s ]', [ElapsedMillseconds]), nil);
//        REQUEST_USER_INFORMATION :
//        begin
////          Client.UserInformationResponese;
////          Client.Received(Self, MESSAGEDATETIME + LRecord.Msg + Format('[Byte / %d s ]', [ElapsedMillseconds]), nil);
//        end;
//      end;

    finally
      SetLength(LBuffer, 0); // BytesToRaw 메모리 할당영역 해제
    end;
//    MemoryStream := TMemoryStream.Create;
//    try
//      Client.IOHandler.LargeStream := True;
//      Client.IOHandler.ReadStream(MemoryStream);
//      MemoryStream.Position := 0;
//
//      Image := TdxSmartImage.Create;
//      Image.LoadFromStream(MemoryStream);
//
//      StopTime := GetTickCount;
//      ElapsedMillseconds := StopWatch.ElapsedMilliseconds;
//
////      Synchronize(nil,
////        procedure
////        begin
//           Client.Received(Self, MESSAGEDATETIME + ReadByte.ToString + Format('[ FileSize: %d Byte / %d s ]', [MemoryStream.Size, ElapsedMillseconds]), Image);
////        end
////      );
////      Queue(nil,
////        procedure
////        begin
////           Client.Received(Self, MESSAGEDATETIME + MemoryStream.ToString + Format('[ FileSize: %d Byte / %d s ]', [MemoryStream.Size, ElapsedMillseconds]), Image);
////        end
////      );
//
////      ClientForm1.cxImage1.Picture.Graphic.LoadFromStream(MemoryStream);
//
//    finally
//      MemoryStream.Free;
////      Image.Free;
//    end;

  end;
end;

end.
