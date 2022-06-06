unit ClientForm.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, cxTextEdit, cxMemo, cxLabel, cxGroupBox,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, ClientUnit, Vcl.Menus, Vcl.StdCtrls, cxButtons, TypInfo, cxImage, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinOffice2016Colorful,
  dxSkinOffice2016Dark, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark, dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue,
  Jpeg, dxGDIPlusClasses, dxSkinOffice2019Colorful, dxSkinTheBezier,
  Vcl.ComCtrls, cxListView, cxCustomData, cxStyles, cxTL, cxTLdxBarBuiltInMenu,
  dximctrl, System.ImageList, Vcl.ImgList, cxImageList, cxInplaceContainer;

type
  TClientForm1 = class(TForm)
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    cxLabel9: TcxLabel;
    cxLabel10: TcxLabel;
    cxLabel11: TcxLabel;
    cxLabel12: TcxLabel;
    cxMemo1: TcxMemo;
    IdTCPClient1: TIdTCPClient;
    SendToServer: TcxTextEdit;
    cxButton2: TcxButton;
    cxButton3: TcxButton;
    cxLabel13: TcxLabel;
    cxLabel14: TcxLabel;
    cxLabel15: TcxLabel;
    cxLabel16: TcxLabel;
    cxImage1: TcxImage;
    cxButton1: TcxButton;
    cxButton4: TcxButton;
    cxImageList1: TcxImageList;
    dxImageListBox1: TdxImageListBox;
    cxButton5: TcxButton;
    cxTreeList1: TcxTreeList;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure SendToServerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure cxTreeList1Click(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
  private
    { Private declarations }
    FClientUnit: TClientUnit;
    procedure DoStatus(const AStatus: TIdStatus; const AStatusText: string);
  public
    { Public declarations }
    procedure StatusNotify(ClientStatus: PClientStuats);
    procedure OnReceived(ASender: TObject; Text: String; Image: TdxSmartImage);
    procedure OnMessage(ASender: TObject; AMessage: string);
    procedure OnItemList(ASender: TObject; AMemoryStream: TMemoryStream);
  end;

var
  ClientForm1: TClientForm1;

implementation

{$R *.dfm}

uses CSUtils;

procedure TClientForm1.cxButton1Click(Sender: TObject);
var
  MemoryStream: TMemoryStream;
  Jpeg: TJPEGImage;
begin
  MemoryStream := TMemoryStream.Create;
  try
    IdTCPClient1.IOHandler.LargeStream := True;
    IdTCPClient1.IOHandler.ReadStream(MemoryStream);

    MemoryStream.Position := 0;

    Jpeg := TJPEGImage.Create;
    Jpeg.LoadFromStream(MemoryStream);

    cxImage1.Picture.Graphic := Jpeg;
  finally
    MemoryStream.Free;
    Jpeg.Free;
  end;
end;

procedure TClientForm1.cxButton2Click(Sender: TObject);
begin
  FClientUnit.Disconnect;
end;

procedure TClientForm1.cxButton3Click(Sender: TObject);
begin
  FClientUnit.Connect;
end;

procedure TClientForm1.cxButton4Click(Sender: TObject);
begin
  if not IdTCPClient1.Connected then
  begin
    with IdTCPClient1 do
    begin
      Host := '127.0.0.1';
      Port := 8090;
      Connect;
    end;
  end;
end;


procedure TClientForm1.cxButton5Click(Sender: TObject);
var
  Node: TcxTreeListNode;
begin
  Node := TcxTreeListNode.Create(cxTreeList1);
end;

procedure TClientForm1.cxTreeList1Click(Sender: TObject);
var
  iTreeNode: TTreeNode;
begin
  ShowMessage(cxTreeList1.FocusedNode.Parent.Texts[0] + '/' + cxTreeList1.FocusedNode.Texts[0]);
end;

procedure TClientForm1.SendToServerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    FClientUnit.Send(SendToServer.Text);
    SendToServer.Text := EmptyStr;
  end;
end;

procedure TClientForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FClientUnit.Free;
end;

procedure TClientForm1.FormCreate(Sender: TObject);
begin
  FClientUnit := TClientUnit.Create;
  FClientUnit.OnReceived := OnReceived;
  FClientUnit.OnStatusNotify := StatusNotify;
  FClientUnit.OnClientMessage := OnMessage;
  FClientUnit.OnSendItemList := OnItemList;

  cxLabel4.Caption := CSUtils.GetComputerName;
  cxLabel6.Caption := TOSVersion.ToString;
  cxLabel16.Caption := FClientUnit.UserData.IP;


  FClientUnit.Connect;
end;

procedure TClientForm1.OnItemList(ASender: TObject; AMemoryStream: TMemoryStream);
begin
  AMemoryStream.Position := 0;
//  cxTreeList1.RestoreFromStream(AMemoryStream, True, True, 'TEST');
  cxTreeList1.LoadFromStream(AMemoryStream);
end;

procedure TClientForm1.OnMessage(ASender: TObject; AMessage: string);
begin
  cxMemo1.Lines.Add(AMessage);
end;

procedure TClientForm1.OnReceived(ASender: TObject; Text: String; Image: TdxSmartImage);
begin
  cxMemo1.Lines.Add(Text);
  if Image <> nil then
  begin
    cxImage1.Picture.Graphic := Image;
    Image.Free;
  end;
end;

procedure TClientForm1.StatusNotify(ClientStatus: PClientStuats);
begin
  cxLabel2.Caption := GetEnumName(TypeInfo(TIdStatus), Integer(ClientStatus.Status));
  cxLabel14.Caption := BoolToStr(ClientStatus.Thread);

  case ClientStatus.Status of
    hsConnected, hsConnecting:
    begin
      cxButton3.Enabled := False;
      cxButton2.Enabled := True;
    end;
    hsDisconnected, hsDisconnecting:
    begin
      cxButton2.Enabled := False;
      cxButton3.Enabled := True;
    end;
  end;
end;

procedure TClientForm1.DoStatus(const AStatus: TIdStatus; const AStatusText: string);
begin

end;

end.
