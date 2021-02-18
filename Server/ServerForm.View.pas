unit ServerForm.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinGolfzon, IdBaseComponent, IdComponent, IdCustomTCPServer,
  IdTCPServer, cxTextEdit, cxMemo, IdContext, ServerUnit, Vcl.Menus, Vcl.StdCtrls, cxButtons, IdGlobal, cxLabel, cxGroupBox, CSUtils, IdSocketHandle, cxStyles, dxSkinscxPCPainter, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator, cxGridCustomTableView, cxGridTableView, cxGridCustomView, cxClasses, cxGridLevel, cxGrid, cxMaskEdit, cxDropDownEdit, cxImageComboBox, IdAntiFreezeBase,
  Vcl.IdAntiFreeze, dxToggleSwitch, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle,
  dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp,
  dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine, dxSkinVisualStudio2013Blue,
  dxSkinVisualStudio2013Dark, dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, dxSkinsForm;

type
  TServerForm1 = class(TForm)
    cxMemo1: TcxMemo;
    cxTextEdit1: TcxTextEdit;
    cxButton3: TcxButton;
    cxTextEdit2: TcxTextEdit;
    cxTextEdit3: TcxTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxButton2: TcxButton;
    cxGrid1TableView1: TcxGridTableView;
    cxGrid1TableView1Column1: TcxGridColumn;
    cxGrid1TableView1Column2: TcxGridColumn;
    cxGrid1TableView1Column3: TcxGridColumn;
    cxGrid1TableView1Column4: TcxGridColumn;
    cxGrid1TableView1Column5: TcxGridColumn;
    cxImageComboBox1: TcxImageComboBox;
    cxButton1: TcxButton;
    IdAntiFreeze1: TIdAntiFreeze;
    cxGrid1TableView1Column6: TcxGridColumn;
    cxGrid1TableView1Column7: TcxGridColumn;
    IdTCPServer1: TIdTCPServer;
    dxSkinController1: TdxSkinController;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton2Click(Sender: TObject);
    procedure IdTCPServer1AfterBind(Sender: TObject);
    procedure IdTCPServer1Execute(AContext: TIdContext);
    procedure cxButton3Click(Sender: TObject);
    procedure cxTextEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IdTCPServer1Status(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
    procedure IdTCPServer1Connect(AContext: TIdContext);
  private
    { Private declarations }
    FServerUnit: TServerUnit;
    procedure DisPlay(text: String); overload;
    procedure DisPlay(text: Integer); overload;

    procedure DisPlayContextOnTheGrid; // 접속유저 그리드에 표시
    procedure DisPlayContextOnTheComboBox(ComboBox: TcxImageComboBox); // 접속유저 콤보박스에 표시
  public
    { Public declarations }
    procedure DoConnect(AContext: TIdContext);
    procedure DoDisconnect(AContext: TIdContext);
    procedure DoStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
    procedure DoExecute(AContext: TIdContext);
    procedure DoAfterBind(Sender: TObject);
    procedure DoContextCreated(AContext: TIdContext);
    procedure OnContextPrinting(Text: String);

    procedure DoActiveEvent(Sender: TObject);
  end;

var
  ServerForm1: TServerForm1;

implementation

{$R *.dfm}

{ TForm2 }

procedure TServerForm1.cxButton1Click(Sender: TObject);
var
  Stream: TStream;
  FileStream: TFileStream;
begin

  if OpenDialog1.Execute then
    FServerUnit.SendToFile(OpenDialog1.FileName);
end;

procedure TServerForm1.cxButton2Click(Sender: TObject);
begin
  FServerUnit.AllDisconnection;
end;

procedure TServerForm1.cxButton3Click(Sender: TObject);
begin
  FServerUnit.Bindings.Clear;
  FServerUnit.Bindings.Add.SetBinding(cxTextEdit2.Text, StrToInt(cxTextEdit3.Text));

  if FServerUnit.Active = True then
    FServerUnit.Active := False
  else
    FServerUnit.Active := True;
end;

procedure TServerForm1.cxTextEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    FServerUnit.SendToAll(TMessageKind.TEXT, cxTextEdit1.Text);
    cxTextEdit1.Text := EmptyStr;
  end;
end;

procedure TServerForm1.DisPlay(text: String);
begin
  cxMemo1.Lines.Add(Text);
end;

procedure TServerForm1.DisPlay(text: Integer);
begin
  cxMemo1.Lines.Add(IntToStr(Text));
end;

procedure TServerForm1.DisPlayContextOnTheComboBox(ComboBox: TcxImageComboBox);
var
  Index: Integer;
  ContextList: TList;
begin

  ContextList := FServerUnit.Contexts.LockList;

  ComboBox.Properties.Items.BeginUpdate;
  ComboBox.Properties.Items.Clear;

  try
      // 여기서 오류가남.. 이유를 모르겠음 .. 일단 스킵
//      with ComboBox.Properties.Items.Add do
//      begin
//        Description := 'ALL';
//        Value := 1123;
//      end;

    for Index := 0 to ContextList.Count -1 do
    begin
      with ComboBox.Properties.Items.Add do
      begin
        Description := IntToStr(TIdSocketHandle(TIdContext(ContextList.Items[Index]).Connection.Socket.Binding).PeerPort);
        Value := 1;
      end;
    end;
  finally
    ComboBox.ItemIndex := 0;
    ComboBox.Properties.Items.EndUpdate;
  end;
    FServerUnit.Contexts.UnlockList;
end;

procedure TServerForm1.DisPlayContextOnTheGrid;
var
  Index: Integer;
  ContextList: TList;
begin
  // DoConnected, DoDisconneted 이벤트에 넣을경우
  // Context가 락이걸려 정상적으로 출력되지 않을 수 있다
  cxGrid1TableView1.DataController.BeginUpdate;
  try
    ContextList := FServerUnit.Contexts.LockList;
    cxGrid1TableView1.DataController.ClearDetails;
    cxGrid1TableView1.DataController.RecordCount := ContextList.Count;
    try
      for Index := 0 to ContextList.Count - 1 do
      begin
        cxGrid1TableView1.DataController.SetValue(Index, cxGrid1TableView1Column1.Index, TIdSocketHandle(TIdContext(ContextList.Items[Index]).Connection.Socket.Binding).Handle);
        cxGrid1TableView1.DataController.SetValue(Index, cxGrid1TableView1Column2.Index, TIdSocketHandle(TIdContext(ContextList.Items[Index]).Connection.Socket.Binding).PeerIP);
        cxGrid1TableView1.DataController.SetValue(Index, cxGrid1TableView1Column3.Index, TIdSocketHandle(TIdContext(ContextList.Items[Index]).Connection.Socket.Binding).PeerPort);
        cxGrid1TableView1.DataController.SetValue(Index, cxGrid1TableView1Column5.Index, TIdContext(ContextList.Items[Index]).Connection.Connected);
      end;
    finally
      FServerUnit.Contexts.UnlockList;
    end;
  finally
    cxGrid1TableView1.DataController.EndUpdate;
  end;
end;

procedure TServerForm1.DoActiveEvent;
begin
  if FServerUnit.Active = True then
  begin
    cxButton3.Caption := 'STOP';
    cxTextEdit2.Enabled := False;
    cxTextEdit3.Enabled := False;
  end
  else
  begin
    cxButton3.Caption := 'START';
    cxTextEdit2.Enabled := True;
    cxTextEdit3.Enabled := True;
  end;
end;

procedure TServerForm1.DoAfterBind(Sender: TObject);
begin

end;

procedure TServerForm1.DoConnect(AContext: TIdContext);
var
  Index: Integer;
begin
  cxLabel1.Caption := Format( '접속자수 : %d 명',[FServerUnit.GetUserCount]);
  cxGrid1TableView1.DataController.BeginUpdate;
  try
    cxGrid1TableView1.DataController.RecordCount := cxGrid1TableView1.DataController.RecordCount + 1;
    Index := cxGrid1TableView1.DataController.RecordCount -1;

    cxGrid1TableView1.DataController.SetValue(Index, cxGrid1TableView1Column1.Index, TIdSocketHandle(TIdContext(AContext).Connection.Socket.Binding).Handle);
    cxGrid1TableView1.DataController.SetValue(Index, cxGrid1TableView1Column2.Index, TIdSocketHandle(TIdContext(AContext).Connection.Socket.Binding).PeerIP);
    cxGrid1TableView1.DataController.SetValue(Index, cxGrid1TableView1Column3.Index, TIdSocketHandle(TIdContext(AContext).Connection.Socket.Binding).PeerPort);
    cxGrid1TableView1.DataController.SetValue(Index, cxGrid1TableView1Column7.Index, TServerContext(AContext).UserData.IP);
    cxGrid1TableView1.DataController.SetValue(Index, cxGrid1TableView1Column5.Index, TIdContext(AContext).Connection.Connected);
  finally
    cxGrid1TableView1.DataController.EndUpdate;
  end;
end;

procedure TServerForm1.DoContextCreated(AContext: TIdContext);
begin
end;

procedure TServerForm1.DoDisconnect(AContext: TIdContext);
var
  FindIndex: ShortInt;
  PeerIP: ShortString;
begin
  cxLabel1.Caption := Format( '접속자수 : %d 명',[FServerUnit.GetUserCount]);
//  DisPlayContextOnTheGrid;
  PeerIP := IntToStr(TIdSocketHandle(TIdContext(AContext).Connection.Socket.Binding).PeerPort);

  FindIndex := cxGrid1TableView1.DataController.FindRecordIndexByText(0,cxGrid1TableView1Column3.Index, PeerIP, True, True, True);

  if FindIndex > -1 then
  begin
    cxGrid1TableView1.DataController.BeginUpdate;
    try
      cxGrid1TableView1.DataController.DeleteRecord(FindIndex);
    finally
      cxGrid1TableView1.DataController.EndUpdate;
    end;
  end;
end;

procedure TServerForm1.DoExecute(AContext: TIdContext);
var
  ReadString: String;
begin
  ReadString := AContext.Connection.IOHandler.ReadLn(enUTF8);

  cxMemo1.Lines.Add(MESSAGEDATETIME + ReadString);
end;

procedure TServerForm1.DoStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
begin
//  cxLabel2.Caption := AStatusText;

//  case AStatus of
//    hsConnected : cxLabel2.Caption := '접속';
//    hsConnecting : cxLabel2.Caption := '접속중';
//  end;
end;

procedure TServerForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FServerUnit)then
    FServerUnit.Free;
end;

procedure TServerForm1.FormCreate(Sender: TObject);
begin
  FServerUnit := TServerUnit.Create;

  // Event Create
  // Default Event
  FServerUnit.OnConnect := DoConnect;
  FServerUnit.OnDisconnect := DoDisconnect;
//  FServerUnit.OnExecute := DoExecute;
  FServerUnit.OnActiveEvent := DoActiveEvent;
  FServerUnit.OnAfterBind := DoAfterBind;
  FServerUnit.OnStatus := DoStatus;
  FServerUnit.OnContextCreated := DoContextCreated;

  // User Event
  FServerUnit.OnContentPringting := OnContextPrinting;

  cxGrid1TableView1.DataController.RecordCount := 0;

  cxButton3.Click;
end;

procedure TServerForm1.IdTCPServer1AfterBind(Sender: TObject);
begin
  cxMemo1.Lines.Add('AfterBind Event');
end;

procedure TServerForm1.IdTCPServer1Connect(AContext: TIdContext);
begin
  cxMemo1.Lines.Add('TCPServer1 Connect Event');
end;

procedure TServerForm1.IdTCPServer1Execute(AContext:TIdContext);
begin
 //
  cxMemo1.Lines.Add('TCPServer1 Execute Event');
end;

procedure TServerForm1.IdTCPServer1Status(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
begin
  cxLabel2.Caption := AStatusText;
end;

procedure TServerForm1.OnContextPrinting(Text: String);
begin
  cxMemo1.Lines.Add(Text);
end;

end.
