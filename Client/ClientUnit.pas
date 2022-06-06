unit ClientUnit;

interface

uses
  System.classes, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdGlobal, IdContext, Winapi.Windows, System.SysUtils,
  CSUtils, IdStack, System.Diagnostics, dxGDIPlusClasses, Syncobjs, IdReply;

const
  WAITTIME = 1000; // ������ð�

type
  TClientStatus = record
  public
    Status: TIdStatus;
    Thread: Boolean;
  end;

  PClientStuats = ^TClientStatus;

  // User Event
  TClientReceivedEvent = procedure (Sender: TObject; Text: String; Image: TdxSmartImage) of object; // �����κ��� �����͸� �޾�����
  TClientStatusNotifyEvent = procedure (AStatus: PClientStuats) of object; // Ŭ���̾�Ʈ ���� �̺�Ʈ
  TClientMessage = procedure (Sender: TObject; AMessage: string) of object;
  TSendItemList = procedure (Sender: TObject; AMemoryStream: TMemoryStream) of object;

  // Object
  TClientUnit = class; // foward ����

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
    FClientMessage: TClientMessage;
    FSendItemList: TSendItemList;
    FUserData: TUserData;

    procedure ClientMessage(ASender: TObject; AMessage: string);
    procedure SendItemList(ASender: TObject; AMemoryStream: TMemoryStream);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Send(Text: String);
    procedure UserInformationResponese;

    procedure DoConnected(Sender: TObject);
    procedure DoDisconnected(Sender: TObject);

    procedure Received(Sender: TObject; Text: String; Image: TdxSmartImage); // �޼��� ����
    procedure StatusNotify(ClientStatus: PClientStuats); // ���º��� �˸�
    procedure DoStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string); //


    property OnReceived: TClientReceivedEvent read FOnReceived write FOnReceived;
    property OnStatusNotify: TClientStatusNotifyEvent read FOnStatusNotify write FOnStatusNotify;
    property OnClientMessage: TClientMessage read FClientMessage write FClientMessage;
    property OnSendItemList: TSendItemList read FSendItemList write FSendItemList;

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

//  Greeting.Clear;
//  Greeting.SetReply(200,'SENDCMD');

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
  I: integer;
begin

//  i := GetResponse(200);
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

  ClientMessage(Sender, 'Connect');
end;

procedure TClientUnit.DoDisconnected(Sender: TObject);
begin
  ClientMessage(Sender, 'DisConnect');
end;

procedure TClientUnit.ClientMessage(ASender: TObject; AMessage: string);
begin
  if Assigned(FClientMessage) then
    FClientMessage(ASender, AMessage);
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
  MessageRecord.Kind := TMessageKind.TEXT;
//  MessageRecord.Msg := Text;

  MessageBuffer := RawToBytes(MessageRecord, SizeOf(TMessage));
  try
    IOHandler.Write(MessageBuffer);
  finally
    SetLength(MessageBuffer, 0);
  end;

//  if SendCmd('TEST') = 1000 then
//      IOHandler.WriteLn('SUCCESS');
//  if CheckResponse(LastCmdResult.NumericCode, [200]) = 200 then
//    IOHandler.WriteLn('SUCCESS');
end;

procedure TClientUnit.SendItemList(ASender: TObject; AMemoryStream: TMemoryStream);
begin
  if Assigned(OnSendItemList) then
    OnSendItemList(ASender, AMemoryStream);
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
  inherited Create(True);  // False �ٷ� ����
  FreeOnTerminate := False; // Thread �޸� ���� ����
  Client := AClient; // Target
end;

destructor TClientThread.Destroy;
begin
  inherited Destroy;
end;

procedure TClientThread.Execute;
var
  StopWatch: TStopwatch; // ��û�ð� ���
  ElapsedMillseconds, ReadStreamSize: Int64;
  Stream: TMemoryStream;
  Image: TdxSmartImage;
  LBuffer: TIdBytes;
  _Message: PMessage;
  CommandRecord: TCommand;
  S: String;
  I: integer;
  SendMessage: String;
  Size: TBytes;
  SendStream: TMemoryStream;
  GenericRecord: TGenericRecord<TMessage>;
  Buffer: TIdBytes;
  MessageRecord: TMessage;
  reader: TStreamReader;
begin
  while not Terminated do
  begin
    StopWatch := TStopwatch.StartNew;
    repeat
      // �̰� �����ϸ� ������ ��⵿ ������ �ذ�Ǵµ�.. �����ϸ� CPU �������� ��ģ���� �ö�..
      // ��� �ذ��ؾߵɱ�
      // CheckForDisconnect �޼��忡 ���� �������ִµ�.. ���� ... �𸣰ٳ�
      // Client.IOHandler.CheckForDisconnect(True, True);

      Client.IOHandler.CheckForDataOnSource(100);

      if StopWatch.ElapsedMilliseconds > WAITTIME then // ����ð� - ���۽ð� > 3�ʺ���ũ�� �б� ����
      begin
        Client.Received(Self,  MESSAGEDATETIME + 'Reading....', nil);
        Break;
      end;
//      WaitForSingleObject( Handle, 10 );
    until not Client.IOHandler.InputBufferIsEmpty;
//
//    until not Client.LastCmdResult.NumericCode > 0;

    if StopWatch.ElapsedMilliseconds > WAITTIME then
      Continue;

    StopWatch := TStopwatch.StartNew;
    try


      ElapsedMillseconds := StopWatch.ElapsedMilliseconds;
//      if Client.LastCmdResult.NumericCode = 200 then
//      if Client.GetResponse([200]) = 200 then
//      Client.DoClientMessage(nil, Client.IOHandler.ReadLn());
//        Client.Received(Self, MESSAGEDATETIME + Client.LastCmdResult.Text.Text + Format('[Byte / %d s ]', [ElapsedMillseconds]), nil);


      // ��û�� ������� ReadLn�� ��� �������� ������ �̷������ ����
      // ������ IOHandler�� �޸𸮸� ����ֱ⶧���ΰ� ����..

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

// 20220529 �����ҽ�
//      Client.IOHandler.ReadBytes(LBuffer, SizeOf(_Message));
//      BytesToRaw(LBuffer, _Message, SizeOf(_Message));
//      _Message := Default(PM);

//      New(_Message);
//      Stream := TMemoryStream.Create;
//      Client.IOHandler.ReadStream(Stream, SizeOf(_Message));
//      Stream.Position := 0;
//      Stream.ReadBuffer(Pointer(_Message.Kind)^, SizeOf(Pointer(_Message.Kind)^));
//      Stream.ReadBuffer(Pointer(_Message.Stream), SizeOf(Pointer(_Message.Stream)));
//Client.IOHandler.read
//      Client.IOHandler.ReadBytes(Buffer, SizeOf(Buffer));
//      reader := reader.Create(Stream);
//      while not reader.EndOfStream do
//        reader.

//      GenericRecord := TGenericRecord<TMessage>.Create;
//      GenericRecord.Value := GenericRecord.ByteArrayToRecord(Buffer);
//      MessageRecord.Stream := TMemoryStream.Create;
//      MessageRecord := GenericRecord.Value;
//      MessageRecord.Stream.
//      Stream := TMemoryStream.Create;
//      Client.IOHandler.ReadStream(Stream, SizeOf(MessageRecord));

//      Client.IOHandler.ReadStream(Stream, SizeOf(_Message));


//        Stream := TMemoryStream.Create;
//        Client.IOHandler.LargeStream := True;
//        Client.IOHandler.ReadStream(Stream, 205);
//        Stream.Position := 0;
//        Client.SendItemList(Self, Stream);
//        Client.ClientMessage(Self, MESSAGEDATETIME + 'ITEMLIST' + Format('[Byte / %d s ]', [ElapsedMillseconds]));
//        Stream.Free;

    Stream := TMemoryStream.Create;
    try
      Client.IOHandler.LargeStream := True;
      Client.IOHandler.ReadStream(Stream);
      Stream.Position := 0;
      Client.SendItemList(Self, Stream);
    finally
      Stream.Free;
//      Image.Free;
    end;



//      Client.IOHandler.ReadBytes(LBuffer, SizeOf(MessageRecord));
//      BytesToRaw(LBuffer, MessageRecord, SizeOf(MessageRecord));
//      MessageRecord.Stream.Position := 0;


//        MessageRecord.Stream.Position := 0;

//        Stream := TMemoryStream.Create;
//        Stream.LoadFromStream(MessageRecord.Stream);

//        case MessageRecord.Kind of
//          TEXT: Client.ClientMessage(Self, MESSAGEDATETIME + 'TEXT' + Format('[Byte / %d s ]', [ElapsedMillseconds]));
//          ITEM_LIST:
//          begin
//            Stream := TMemoryStream.Create;
//            Client.IOHandler.ReadStream(Stream, MessageRecord.Size);
//            Stream.Position := 0;
//            Client.SendItemList(Self, Stream);
//            Client.ClientMessage(Self, MESSAGEDATETIME + 'ITEMLIST' + Format('[Byte / %d s ]', [ElapsedMillseconds]));
//            Stream.Free;
//          end;
//        end;


//      MemoryStream.Read(_Message.Stream)
//      Client.IOHandler.LargeStream := True;
//      Client.IOHandler.ReadStream(MemoryStream, );


//      ElapsedMillseconds := StopWatch.ElapsedMilliseconds;

//      MemoryStream.ReadBuffer(Pointer(_Message.Stream)^, SizeOf(Pointer(_Message.Stream)^));
//      SetLength(_Message, SizeOf(Stream.Size));
//      Stream.ReadBuffer(Pointer(SendMessage)^, Stream.Size);
//      Stream.ReadData(_Message.Kind, SizeOf(_Message.Kind));
//      Stream.ReadBuffer(_Message.Kind, SizeOf(_Message.Kind));
//      Stream.ReadBuffer(_Message.Stream, SizeOf(_Message.Stream));
//      SizeOf(_Message.Kind);

//      case _Message.Kind of
//        TEXT :
//        begin
//          Stream.Position := 0;
//          Stream.ReadBuffer(Pointer(SendMessage), SizeOf(_Message.Stream));
//          Client.ClientMessage(Self, MESSAGEDATETIME + SendMessage + Format('[Byte / %d s ]', [ElapsedMillseconds]));
//        end;
//        ITEM_LIST :
//        begin
////          Stream.Position := 0;
////          Stream.Read(_Message, SizeOf(_Message));
////          SendStream.ReadBuffer(, SizeOf(_Message.Stream));
//          Client.SendItemList(Self, Stream);
////          SendStream.Free;
//        end
//        else
//          Client.ClientMessage(Self, MESSAGEDATETIME + '���ǵ������� �޼���' + Format('[Byte / %d s ]', [ElapsedMillseconds]));
////        REQUEST_USER_INFORMATION :
////        begin
////          Client.UserInformationResponese;
////          Client.Received(Self, MESSAGEDATETIME + LRecord.Msg + Format('[Byte / %d s ]', [ElapsedMillseconds]), nil);
////        end;
//      end;
//
////      _Message.Stream.Free;
//      FreeMem(_Message);
//      Stream.Free;
    finally
//      Stream.Free;
//      GenericRecord.Free;
//      SetLength(LBuffer, 0); // BytesToRaw �޸� �Ҵ翵�� ����
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
