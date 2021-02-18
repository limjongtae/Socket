object ClientForm1: TClientForm1
  Left = 0
  Top = 0
  Caption = 'ClientForm1'
  ClientHeight = 625
  ClientWidth = 931
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    931
    625)
  PixelsPerInch = 96
  TextHeight = 13
  object cxGroupBox1: TcxGroupBox
    Left = 625
    Top = 8
    Anchors = [akTop, akRight]
    Caption = #53364#46972#51060#50616#53944' '#51221#48372
    TabOrder = 0
    Height = 217
    Width = 298
    object cxLabel1: TcxLabel
      Left = 16
      Top = 86
      Caption = #51217#49549#49345#53468
    end
    object cxLabel2: TcxLabel
      Left = 80
      Top = 86
      Caption = 'cxLabel1'
    end
    object cxLabel3: TcxLabel
      Left = 16
      Top = 23
      Caption = 'PC '#51060#47492
    end
    object cxLabel4: TcxLabel
      Left = 80
      Top = 23
      Caption = 'PC '#51060#47492
    end
    object cxLabel5: TcxLabel
      Left = 16
      Top = 44
      Caption = #50952#46020#50864#48260#51204
    end
    object cxLabel6: TcxLabel
      Left = 80
      Top = 44
      Caption = #50952#46020#50864#48260#51204
    end
    object cxLabel7: TcxLabel
      Left = 16
      Top = 197
      Caption = #54532#47196#44536#47016' '#48260#51204
    end
    object cxLabel8: TcxLabel
      Left = 95
      Top = 197
      Caption = 'cxLabel1'
    end
    object cxLabel9: TcxLabel
      Left = 16
      Top = 127
      Caption = #44228#51221#51221#48372
    end
    object cxLabel10: TcxLabel
      Left = 80
      Top = 127
      Caption = 'cxLabel1'
    end
    object cxLabel11: TcxLabel
      Left = 16
      Top = 150
      Caption = #49464#49496#53440#51076
    end
    object cxLabel12: TcxLabel
      Left = 80
      Top = 150
      Caption = 'cxLabel1'
    end
    object cxLabel13: TcxLabel
      Left = 16
      Top = 107
      Caption = #50416#47112#46300
    end
    object cxLabel14: TcxLabel
      Left = 80
      Top = 107
      Caption = 'cxLabel1'
    end
    object cxLabel15: TcxLabel
      Left = 16
      Top = 65
      Caption = #50500#51060#54588
    end
    object cxLabel16: TcxLabel
      Left = 80
      Top = 65
      Caption = #50500#51060#54588
    end
  end
  object cxMemo1: TcxMemo
    Left = 8
    Top = 8
    Anchors = [akLeft, akTop, akBottom]
    Properties.ReadOnly = True
    TabOrder = 1
    Height = 578
    Width = 611
  end
  object SendToServer: TcxTextEdit
    Left = 8
    Top = 592
    TabOrder = 2
    OnKeyDown = SendToServerKeyDown
    Width = 611
  end
  object cxButton2: TcxButton
    Left = 625
    Top = 559
    Width = 75
    Height = 25
    Caption = #50672#44208#54644#51228
    TabOrder = 3
    OnClick = cxButton2Click
  end
  object cxButton3: TcxButton
    Left = 625
    Top = 528
    Width = 75
    Height = 25
    Caption = #50672#44208
    TabOrder = 4
    OnClick = cxButton3Click
  end
  object cxImage1: TcxImage
    Left = 625
    Top = 234
    TabOrder = 5
    Height = 223
    Width = 224
  end
  object cxButton1: TcxButton
    Left = 752
    Top = 463
    Width = 75
    Height = 25
    Caption = 'cxButton1'
    TabOrder = 6
    OnClick = cxButton1Click
  end
  object cxButton4: TcxButton
    Left = 752
    Top = 512
    Width = 75
    Height = 25
    Caption = 'cxButton4'
    TabOrder = 7
    OnClick = cxButton4Click
  end
  object IdTCPClient1: TIdTCPClient
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 0
    ReadTimeout = -1
    Left = 664
    Top = 360
  end
end
