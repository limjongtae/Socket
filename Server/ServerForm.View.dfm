object ServerForm1: TServerForm1
  Left = 0
  Top = 0
  Caption = 'ServerForm1'
  ClientHeight = 556
  ClientWidth = 729
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object cxMemo1: TcxMemo
    Left = 8
    Top = 8
    Properties.ReadOnly = True
    TabOrder = 0
    Height = 457
    Width = 417
  end
  object cxTextEdit1: TcxTextEdit
    Left = 96
    Top = 471
    TabOrder = 1
    OnKeyDown = cxTextEdit1KeyDown
    Width = 329
  end
  object cxGroupBox1: TcxGroupBox
    Left = 431
    Top = 8
    Caption = 'cxGroupBox1'
    TabOrder = 2
    Height = 129
    Width = 266
    object cxButton3: TcxButton
      Left = 138
      Top = 24
      Width = 71
      Height = 50
      Caption = 'START'
      TabOrder = 0
      OnClick = cxButton3Click
    end
    object cxLabel1: TcxLabel
      Left = 13
      Top = 78
      Caption = #51217#49549#51088#49688' :'
      Transparent = True
    end
    object cxLabel2: TcxLabel
      Left = 14
      Top = 101
      Caption = #49436#48260#49345#53468' :'
      Transparent = True
    end
    object cxTextEdit2: TcxTextEdit
      Left = 11
      Top = 24
      TabOrder = 3
      Text = '127.0.0.1'
      Width = 121
    end
    object cxTextEdit3: TcxTextEdit
      Left = 11
      Top = 51
      TabOrder = 4
      Text = '8090'
      Width = 121
    end
  end
  object cxGrid1: TcxGrid
    Left = 431
    Top = 143
    Width = 298
    Height = 322
    TabOrder = 3
    object cxGrid1TableView1: TcxGridTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGrid1TableView1Column1: TcxGridColumn
        Caption = #49464#49496'ID'
        HeaderAlignmentHorz = taCenter
        Width = 42
      end
      object cxGrid1TableView1Column2: TcxGridColumn
        Caption = 'IP'
        HeaderAlignmentHorz = taCenter
        Width = 43
      end
      object cxGrid1TableView1Column3: TcxGridColumn
        Caption = 'Port'
        HeaderAlignmentHorz = taCenter
        Width = 42
      end
      object cxGrid1TableView1Column5: TcxGridColumn
        Caption = #51217#49549#49345#53468
        PropertiesClassName = 'TdxToggleSwitchProperties'
        HeaderAlignmentHorz = taCenter
        Width = 75
      end
      object cxGrid1TableView1Column4: TcxGridColumn
        Caption = #51217#49549#49884#44036
        HeaderAlignmentHorz = taCenter
        Width = 46
      end
      object cxGrid1TableView1Column6: TcxGridColumn
        Caption = #54644#51228
        Width = 24
      end
      object cxGrid1TableView1Column7: TcxGridColumn
        Width = 24
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1TableView1
    end
  end
  object cxButton2: TcxButton
    Left = 350
    Top = 498
    Width = 75
    Height = 25
    Caption = #51204#52404#51333#47308
    TabOrder = 4
    OnClick = cxButton2Click
  end
  object cxImageComboBox1: TcxImageComboBox
    Left = 8
    Top = 471
    Properties.Items = <>
    TabOrder = 5
    Width = 82
  end
  object cxButton1: TcxButton
    Left = 264
    Top = 498
    Width = 75
    Height = 25
    Caption = 'cxButton1'
    TabOrder = 6
    OnClick = cxButton1Click
  end
  object cxButton4: TcxButton
    Left = 88
    Top = 512
    Width = 75
    Height = 25
    Caption = 'cxButton4'
    TabOrder = 7
    OnClick = cxButton4Click
  end
  object IdTCPServer1: TIdTCPServer
    Bindings = <>
    DefaultPort = 0
    Left = 536
    Top = 528
  end
  object dxSkinController1: TdxSkinController
    NativeStyle = False
    SkinName = 'DevExpressDarkStyle'
    Left = 472
    Top = 488
  end
  object OpenDialog1: TOpenDialog
    Left = 184
    Top = 504
  end
  object IdCmdTCPServer1: TIdCmdTCPServer
    Bindings = <>
    DefaultPort = 0
    CommandHandlers = <>
    ExceptionReply.Code = '500'
    ExceptionReply.Text.Strings = (
      'Unknown Internal Error')
    Greeting.Code = '200'
    Greeting.Text.Strings = (
      'Welcome')
    HelpReply.Code = '100'
    HelpReply.Text.Strings = (
      'Help follows')
    MaxConnectionReply.Code = '300'
    MaxConnectionReply.Text.Strings = (
      'Too many connections. Try again later.')
    ReplyTexts = <>
    ReplyUnknownCommand.Code = '400'
    ReplyUnknownCommand.Text.Strings = (
      'Unknown Command')
    Left = 552
    Top = 496
  end
end
