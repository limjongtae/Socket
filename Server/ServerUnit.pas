unit ServerUnit;

interface

uses
  System.Classes, System.SysUtils, IdBaseComponent, IdComponent, IdCustomTCPServer, IdTCPServer, IdContext, IdSocketHandle, IdGlobal, CSUtils, Winapi.Windows
  ,System.Generics.Collections, IdIrcServer, IdReply, IdCmdTCPServer, IdCommandHandlers;

type

  TContentPrintingEvent = procedure (Text: String) of object; // 화면출력용 이벤트

  TServerContext = class(TIdServerContext)
  private
    FUserData: TUserData;
  public
    constructor Create;
    destructor Destroy; override;

    property UserData: TUserData read FUserData write FUserData;
  end;

  TServerUnit = class(TIdTCPServer) //TIdTCPServer TIdIrcServer
  published
    property OnExecute;
    property OnConnect;
    property OnDisConnect;
//    property OnStatus;
  private
    // CustomEvent
    FUserList: TList;
    FOnContextPrintingEvent: TContentPrintingEvent;
    FOnActiveEvent: TNotifyEvent;
    FUserCount: Integer;
    FUserData: TList<TUserData>; // Generic
  public
    constructor Create;
    destructor Destroy; override;

    // 접속체크
    // 접속해제체크

    // 기능
    // 전체 접속해제
    //


    // init
    function AllDisconnection: Boolean;

    //Eevent
    procedure DoStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
    procedure DoConnect(AContext: TIdContext); override;
    procedure DoDisConnect(AContext: TIdContext); override;

    procedure DoExecute(AContext: TIdContext);
    procedure DoAfterBind; override;
    procedure SetActive(AValue: Boolean); override;

    function GetUserCount: Integer;

    procedure OnContextPrinting(Text: String);
    procedure RequestUserInfomation(Context: TidContext);
    procedure Send(Context: TIdContext; MsgData: TMessageKind; Text: String);
//    procedure SendToAll(MsgData: TMessageKind; Text: String);
    procedure SendToAll(AKind: TMessageKind; AStream: TMemoryStream);

    // 1. Stream으로 모든 메세지 보내기
    // 2. 아이템 추가했을때 메세지 보내기
    // 3. 접속리스트 받기
    // 4. 클라이언트에서 작업상태 변경시 체크하기
    // 5. 클라이언트랑 통신체크 주기적으로하기
    // 6. 서버종료시 클라이언트 다 죽이고 종료하기
    // 7. 최근 변경폴더 찾아서 클라이언트한테 보내주기
    // 8. 컴파일 체크하기



    procedure SendToFile(FileName: String);
    procedure CommandTEST(ASender: TIdCommand);
    procedure SendCmd;
    function GetUserList: TList;

    // Event
    property UserList: TList Read GetUserList;
    property UserCount: Integer Read GetUserCount;
    // Event
    property OnContentPringting: TContentPrintingEvent read FOnContextPrintingEvent write FOnContextPrintingEvent;
    property OnActiveEvent: TNotifyEvent read FOnActiveEvent write FOnActiveEvent;
  end;

implementation

{ TServerUnit }

function TServerUnit.AllDisconnection: Boolean;
var
  i: Integer;
  ContextList: TList;
begin
  if Contexts.Count < 0 then Exit;

  ContextList := Contexts.LockList;

  for i := 0 to ContextList.Count - 1 do
  begin
    TIdContext(ContextList.Items[i]).Connection.IOHandler.WriteLn('서버에서 연결을 종료하였습니다');
    TIdContext(ContextList.Items[i]).Connection.IOHandler.WriteBufferClear;
    TIdContext(ContextList.Items[i]).Connection.IOHandler.InputBuffer.Clear;
    TIdContext(ContextList.Items[i]).Connection.IOHandler.Close;


    if TIdContext(ContextList.Items[i]).Connection.Connected then
      TIdContext(ContextList.Items[i]).Connection.Disconnect;
  end;

  Contexts.UnlockList;

  Result := (Contexts.Count = 0);
end;

procedure TServerUnit.CommandTEST(ASender: TIdCommand);
begin
//  ASender.Reply.SetReply(200,'TEST');
end;

constructor TServerUnit.Create;
var
  Reply: TIdReply;
  aCommand: TIdCommandHandler;
begin
  ContextClass := TServerContext;
  inherited Create;

  // Event Conneted
  OnExecute := DoExecute;
  OnConnect := DoConnect;
  OnDisConnect := DoDisconnect;

//  Greeting.Code := '200';
//  Greeting.Text.Text := 'Greeting Test';

//  aCommand := CommandHandlers.Add;
//  aCommand.Command := 'TEST';
//  aCommand.OnCommand := CommandTEST;

//  Reply := TIdReply.Create(nil);
//  Reply.SetReply(1000,'TEST');
//  ReplyTexts.Clear;
//  ReplyTexts.UpdateText(Reply);

//  FUserList := TList.Create;
end;

destructor TServerUnit.Destroy;
begin
//  AllDisconnection;
//  FUserList.Free;

  if not AllDisconnection then
    raise Exception.Create('모든클라이언트가 종료되지 않았습니다');
  
  inherited Destroy;
end;

procedure TServerUnit.DoAfterBind;
begin
  inherited;
end;

procedure TServerUnit.DoConnect(AContext: TIdContext);
var
  MessageRecord: TMessage;
  CommandRecord: TCommand;
  CommandBuffer, MessageBuffer: TIdBytes;
  S: SmallInt;
begin
//  S := AContext.Connection.GetResponse(200);

//  AContext.Connection.SendCmd('200');
  // Send Command
//  CommandRecord.Kind := TCommandKind.SEND_USER_INFORMATION;
//  CommandRecord.TimeStamp := Now;
//
//  CommandBuffer := RawToBytes(CommandRecord, SizeOf(CommandRecord));
//  try
//    AContext.Connection.IOHandler.Write(CommandBuffer);
//  finally
//    SetLength(CommandBuffer, 0);
//  end;

//  if AContext.Connection.SendCmd('TEST',1) = 1 then
//  begin
//    MessageRecord.Kind := TMessageKind.TEXT;
//    MessageRecord.Msg := 'TEST';
//
//    MessageBuffer := RawToBytes(MessageRecord, SizeOf(MessageRecord));
//    try
//      AContext.Connection.IOHandler.Write(MessageBuffer);
//    finally
//      SetLength(MessageBuffer, 0);
//    end;
//
    OnContextPrinting(MESSAGEDATETIME + 'LogInEvent ' + AContext.Binding.PeerIP + ':' + IntToStr(AContext.Binding.PeerPort));
//  end;
  // 연결 후 해당 클라이언트로부터 데이터 요청 푸시 보내기
//  RequestUserInfomation(AContext);
  // Execute 메서드에서 해당 클라이언트 정보 저장하기
end;

procedure TServerUnit.DoDisConnect(AContext: TIdContext);
begin
  OnContextPrinting(MESSAGEDATETIME + 'LogOutEvent ' + AContext.Binding.PeerIP + ':' + IntToStr(AContext.Binding.PeerPort));
end;

procedure TServerUnit.DoExecute(AContext: TIdContext);
var
  MessageRecord: TMessage;
  CommandRecord: TCommand;
  MessageBuffer, CommandBuffer: TIdBytes;
//  ACommand: TGenericRecord<TCommand>;
//  ARecord: TGenericRecord<TMessage>;
  Buffer: TIdBytes;
//  Buffer: TBytes;
  Text: String;
  C: Char;
  GenericRecord: TGenericRecord<TMessage>;
begin
////  AContext.Connection.IOHandler.ReadBytes(Buffer, SizeOf(Buffer));
////
////  ACommand := TGenericRecord<TCommand>.Create;
////  ACommand.Value := ACommand.ByteArrayToRecord(Buffer);
//
////  AContext.Connection.IOHandler.CheckForDataOnSource(100);
//
////  Text := AContext.Connection.IOHandler.ReadLn(IndyTextEncoding_UTF8);
//
////  C := AContext.Connection.IOHandler.ReadChar;
////  AContext.Connection.SendCmd()
////
////  if C = '1' then
////  begin
//    AContext.Connection.IOHandler.ReadBytes(MessageBuffer, SizeOf(TMessage));
//    BytesToRaw(MessageBuffer, MessageRecord, SizeOf(TMessage));
//    try
////      case MessageRecord.Kind of
////        TMessageKind.TEXT : OnContextPrinting(MESSAGEDATETIME + MessageRecord.Msg + AContext.Binding.PeerIP + ':' + IntToStr(AContext.Binding.PeerPort));
////      end;
//    finally
//      SetLength(MessageBuffer, 0); // BytesToRaw 메모리 할당영역 해제
//    end;
////  end;
//
//
//  OnContextPrinting(MESSAGEDATETIME + Text + AContext.Binding.PeerIP + ':' + IntToStr(AContext.Binding.PeerPort));
//
////  AContext.Connection.IOHandler.ReadBytes(CommandBuffer, SizeOf(CommandRecord));
////  BytesToRaw(CommandBuffer, CommandRecord, SizeOf(CommandRecord));
////  try
////    case CommandRecord.Kind of
////      SEND_MESSAGE :
////      begin
//        AContext.Connection.IOHandler.ReadBytes(MessageBuffer, SizeOf(TMessage));
//        BytesToRaw(MessageBuffer, MessageRecord, SizeOf(TMessage));
//        try
////          case MessageRecord.Kind of
////            TMessageKind.TEXT : OnContextPrinting(MESSAGEDATETIME + MessageRecord.Msg + AContext.Binding.PeerIP + ':' + IntToStr(AContext.Binding.PeerPort));
////          end;
//        finally
//          SetLength(MessageBuffer, 0); // BytesToRaw 메모리 할당영역 해제
//        end;
////      end;
////    end;
////  finally
////    SetLength(CommandBuffer, 0); // BytesToRaw 메모리 할당영역 해제
////  end;
//
////  if AContext.Connection.CheckResponse(AContext.Connection.LastCmdResult.NumericCode, [200]) = 200 then
////    AContext.Connection.IOHandler.WriteLn('SUCCESS');
///
///
//  GenericRecord := TGenericRecord<TMessage>.Create;
//  GenericRecord.Value := GenericRecord.ByteArrayToRecord(Buffer);
//
//  MessageRecord := GenericRecord.Value;
//
//  case MessageRecord.Kind of
//    TMessageKind.TEXT: ;
//  end;
end;

procedure TServerUnit.DoStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
begin
  if Assigned(FOnStatus) then
    OnStatus(ASender, AStatus, AStatusText);
end;

function TServerUnit.GetUserCount: Integer;
var
  i: Integer;
  ContextList: TList;
begin
  Result := 0;

  try
    ContextList := Contexts.LockList;
    if ContextList.Count < 0 then
      Exit;

    for i := 0 to ContextList.Count - 1 do
    begin
      if TIdContext(ContextList.Items[i]).Connection.Connected then
        Result := Result + 1;
    end;
  finally
    Contexts.UnlockList;
  end;
end;

function TServerUnit.GetUserList: TList;
var
  i: Integer;
begin
//  for i := 0 to Contexts.LockList.Count - 1 do
//   TIdContext(Contexts.LockList.Items[i]).Connection.Socket.
end;

procedure TServerUnit.OnContextPrinting(Text: String);
begin
  if Assigned(FOnContextPrintingEvent) then
    FOnContextPrintingEvent(Text);
end;

procedure TServerUnit.RequestUserInfomation(Context: TidContext);
var
  RequestRecord: TMessage;
  Buffer: TIdBytes;
begin
//  RequestRecord.Msg := '사용자 정보 요청';
//  RequestRecord.Kind := REQUEST_USER_INFORMATION;
//  Buffer := RawToBytes(RequestRecord, SizeOf(RequestRecord));
//  try
//    Context.Connection.IOHandler.Write(Buffer);
//  finally
//    SetLength(Buffer,0);
//  end;
end;

procedure TServerUnit.Send(Context: TIdContext; MsgData: TMessageKind; Text: String);
var
  ARecord: TMessage;
  LBuffer: TIdBytes;
  a: SmallInt;
begin

end;

procedure TServerUnit.SendCmd;
var
  i: Integer;
  ContextList: TList;
  ARecord: TMessage;
  LBuffer: TIdBytes;
  S: String;
begin
//  try
//    ContextList := Contexts.LockList;
//  finally
//    Contexts.UnlockList;
//  end;
//
//  if ContextList.Count <= 0 then
//    Exit;
//
//  for i := 0 to ContextList.Count - 1 do
//  begin
//    TIdContext(ContextList.Items[i]).Connection.SendCmd('SENDCMD');
//    if TIdContext(ContextList.Items[i]).Connection.CheckResponse(TIdContext(ContextList.Items[i]).Connection.LastCmdResult.NumericCode, [200]) = 200 then
//      TIdContext(ContextList.Items[i]).Connection.IOHandler.WriteLn('SUCCES');
//  end;
end;

//procedure TServerUnit.SendToAll(MsgData: TMessageKind; Text: String);
//var
//  i: Integer;
//  ContextList: TList;
//  ARecord: TMessage;
//  LBuffer: TIdBytes;
//begin
//  try
//    ContextList := Contexts.LockList;
//  finally
//    Contexts.UnlockList;
//  end;
//
//  if ContextList.Count <= 0 then
//    Exit;
//
//  // Record Create
////  ARecord.Msg := Text;
////  ARecord.Kind := TMessageKind.TEXT;
//
//  // LBuffer Assign
//  LBuffer := RawToBytes(ARecord, SizeOf(ARecord));
//  try
//    for i := 0 to ContextList.Count - 1 do
//      TIdContext(ContextList.Items[i]).Connection.IOHandler.Write(LBuffer);
//  finally
//    SetLength(LBuffer, 0);
//  end;
//end;

procedure TServerUnit.SendToFile(FileName: String);
var
  FileStream: TFileStream;
  i: Integer;
  ContextList: TList;
begin
  FileStream := TFileStream.Create(FileName, fmOpenRead);
  try
    ContextList := Contexts.LockList;
    try
      if ContextList.Count < 0 then
        Exit;

      for i := 0 to ContextList.Count - 1 do
      begin
        FileStream.Seek(0,soFromBeginning);
        TIdContext(ContextList.Items[i]).Connection.IOHandler.LargeStream := True;
        TIdContext(ContextList.Items[i]).Connection.IOHandler.Write(FileStream, FileStream.Size, True);
      end;
    finally
      Contexts.UnlockList;
    end;
  finally
    FileStream.Free;
  end;
end;

procedure TServerUnit.SendToAll(AKind: TMessageKind; AStream: TMemoryStream);
var
  i: Integer;
  ContextList: TList;
  _Message: PMessage;
  LBuffer: TIdBytes;
  MemoryStream: TMemoryStream;
  s1, s2: SmallInt;
  GenericRecord: TGenericRecord<TMessage>;
  MessageRecord: TMessage;
  Buffer: TIdBytes;
  Size: Int64;
begin
  try
    ContextList := Contexts.LockList;
    try
      if ContextList.Count < 0 then
        Exit;

      // Record Create
//      case AMessage of
//        TEXT: AStream.ReadBuffer(Pointer(AStream));
//      end;

//      _Message.Stream := AStream;
//      MemoryStream := TMemoryStream.Create;
//
//      New(_Message);
//
//      _Message.Kind := AKind;
//      _Message.Stream := AStream;
//
//      s1 := SizeOf(_Message.Kind);
//      s2 := SizeOf(_Message.Stream);
//
//      MemoryStream.Write(_Message, SizeOf(_Message));
//      MemoryStream.Position := 0;

//      _Message.Kind := AKind;
//      _Message.Stream := AStream;
//
//      // LBuffer Assign
//      LBuffer := RawToBytes(_Message, SizeOf(_Message));
//      try
//        for i := 0 to ContextList.Count - 1 do
//        begin
//          AStream.Seek(0,soFromBeginning);
//          TIdContext(ContextList.Items[i]).Connection.IOHandler.LargeStream := True;
//          TIdContext(ContextList.Items[i]).Connection.IOHandler.Write(LBuffer);
//        end;
//      finally
//        SetLength(LBuffer, 0);
//      end;
//      New(MessageRecord);

//      MessageRecord.Kind := AKind;
//      MessageRecord.Size := SizeOf(AStream);
//      AStream.Position := 0;
//      MessageRecord.Stream := TMemoryStream.Create;
//      MessageRecord.Stream := AStream;

//      LBuffer := RawToBytes(MessageRecord, MessageRecord.Size);
//      Size := SizeOf(MessageRecord.Kind);
//      Size := SizeOf(MessageRecord.Stream);
//      MessageRecord.Stream.CopyFrom(AStream, SizeOf(AStream));
//
//      GenericRecord := TGenericRecord<TMessage>.Create;
//      Buffer:= GenericRecord.RecordToByteArray(MessageRecord);

//      a := TGenericRecord<TMessage>.Create;
//      a.
      try
        for i := 0 to ContextList.Count - 1 do
        begin
          TIdContext(ContextList.Items[i]).Connection.IOHandler.LargeStream := True;
//          TIdContext(ContextList.Items[i]).Connection.IOHandler.Write(LBuffer, SizeOf(MessageRecord.Kind));
          TIdContext(ContextList.Items[i]).Connection.IOHandler.Write(AStream, 0, True);
//          TIdContext(ContextList.Items[i]).Connection.IOHandler.
        end;
      finally
//        FreeMem(MessageRecord);
//        SetLength(MessageRecord, 0);
//        MemoryStream.Free;
      end;
    finally
      Contexts.UnlockList;
//      GenericRecord.Free;
    end;
  finally
  end;
end;

procedure TServerUnit.SetActive(AValue: Boolean);
begin
  inherited;
  if Assigned(FOnActiveEvent) then
   FOnActiveEvent(Self);
end;

{ TServerContext }

constructor TServerContext.Create;
begin
  FUserData := TUserData.Create;
//  FUserData.ID :=
end;

destructor TServerContext.Destroy;
begin
  FUserData.Free;
  inherited;
end;

end.
