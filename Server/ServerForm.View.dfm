object ServerForm1: TServerForm1
  Left = 0
  Top = 0
  Caption = 'ServerForm1'
  ClientHeight = 513
  ClientWidth = 1238
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
  object dxLayoutControl1: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 1238
    Height = 513
    Align = alClient
    ParentBackground = True
    TabOrder = 0
    Transparent = True
    LayoutLookAndFeel = dxLayoutSkinLookAndFeel1
    object cxTreeList1: TcxTreeList
      Left = 10
      Top = 10
      Width = 243
      Height = 493
      Bands = <
        item
          Caption.Text = 'test'
        end>
      Navigator.Buttons.CustomButtons = <>
      TabOrder = 0
      object cxTreeList1Column1: TcxTreeListColumn
        Caption.Text = 'test'
        DataBinding.ValueType = 'String'
        Position.ColIndex = 0
        Position.RowIndex = 0
        Position.BandIndex = 0
        Summary.FooterSummaryItems = <>
        Summary.GroupFooterSummaryItems = <>
      end
    end
    object cxMemo1: TcxMemo
      Left = 575
      Top = 10
      Properties.ReadOnly = True
      Style.HotTrack = False
      TabOrder = 3
      Height = 466
      Width = 248
    end
    object cxImageComboBox1: TcxImageComboBox
      Left = 575
      Top = 482
      Properties.Items = <>
      Style.HotTrack = False
      TabOrder = 4
      Width = 121
    end
    object cxTextEdit1: TcxTextEdit
      Left = 702
      Top = 482
      Style.HotTrack = False
      TabOrder = 5
      OnKeyDown = cxTextEdit1KeyDown
      Width = 121
    end
    object cxGrid1: TcxGrid
      Left = 829
      Top = 10
      Width = 399
      Height = 288
      TabOrder = 6
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
    object cxGroupBox1: TcxGroupBox
      Left = 829
      Top = 304
      Caption = 'cxGroupBox1'
      ParentBackground = False
      ParentColor = False
      Style.Color = 7566195
      TabOrder = 7
      Transparent = True
      Height = 129
      Width = 399
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
    object cxButton5: TcxButton
      Left = 1153
      Top = 439
      Width = 75
      Height = 25
      Caption = #50500#51060#53596#52628#44032
      TabOrder = 12
      OnClick = cxButton5Click
    end
    object cxButton4: TcxButton
      Left = 1072
      Top = 439
      Width = 75
      Height = 25
      Caption = 'cxButton4'
      TabOrder = 11
      OnClick = cxButton4Click
    end
    object cxButton1: TcxButton
      Left = 991
      Top = 439
      Width = 75
      Height = 25
      Caption = 'cxButton1'
      TabOrder = 10
      OnClick = cxButton1Click
    end
    object cxButton2: TcxButton
      Left = 910
      Top = 439
      Width = 75
      Height = 25
      Caption = #51204#52404#51333#47308
      TabOrder = 9
      OnClick = cxButton2Click
    end
    object cxButton6: TcxButton
      Left = 829
      Top = 439
      Width = 75
      Height = 25
      Caption = #50500#51060#53596' '#45236#48372#45236#44592
      TabOrder = 8
      OnClick = cxButton6Click
    end
    object cxTreeList2: TcxTreeList
      Left = 319
      Top = 10
      Width = 250
      Height = 150
      Bands = <
        item
        end>
      Navigator.Buttons.CustomButtons = <>
      TabOrder = 1
      object cxTreeList2Column1: TcxTreeListColumn
        DataBinding.ValueType = 'String'
        Position.ColIndex = 0
        Position.RowIndex = 0
        Position.BandIndex = 0
        Summary.FooterSummaryItems = <>
        Summary.GroupFooterSummaryItems = <>
      end
    end
    object Button1: TButton
      Left = 494
      Top = 166
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 2
      OnClick = Button1Click
    end
    object dxLayoutControl1Group_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      ButtonOptions.Buttons = <>
      Hidden = True
      ItemIndex = 1
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItem1: TdxLayoutItem
      Parent = dxLayoutControl1Group_Root
      AlignHorz = ahClient
      AlignVert = avClient
      Control = cxTreeList1
      ControlOptions.OriginalHeight = 540
      ControlOptions.OriginalWidth = 417
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItem2: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup5
      AlignHorz = ahClient
      AlignVert = avClient
      Control = cxMemo1
      ControlOptions.OriginalHeight = 226
      ControlOptions.OriginalWidth = 248
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItem3: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup6
      AlignHorz = ahLeft
      Control = cxImageComboBox1
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItem4: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup6
      AlignHorz = ahRight
      Control = cxTextEdit1
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItem5: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup1
      AlignHorz = ahClient
      AlignVert = avTop
      Control = cxGrid1
      ControlOptions.OriginalHeight = 288
      ControlOptions.OriginalWidth = 250
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItem6: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup1
      CaptionOptions.Visible = False
      Control = cxGroupBox1
      ControlOptions.AutoColor = True
      ControlOptions.OriginalHeight = 129
      ControlOptions.OriginalWidth = 185
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItem7: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup7
      CaptionOptions.Visible = False
      Control = cxButton5
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object dxLayoutItem8: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup7
      CaptionOptions.Visible = False
      Control = cxButton4
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object dxLayoutItem9: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup7
      CaptionOptions.Visible = False
      Control = cxButton1
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItem10: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup7
      AlignVert = avClient
      CaptionOptions.Visible = False
      Control = cxButton2
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItem11: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup7
      AlignHorz = ahLeft
      CaptionOptions.Visible = False
      Control = cxButton6
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutAutoCreatedGroup5: TdxLayoutAutoCreatedGroup
      Parent = dxLayoutControl1Group_Root
      AlignHorz = ahLeft
      AlignVert = avClient
      Index = 2
    end
    object dxLayoutAutoCreatedGroup6: TdxLayoutAutoCreatedGroup
      Parent = dxLayoutAutoCreatedGroup5
      LayoutDirection = ldHorizontal
      Index = 1
    end
    object dxLayoutAutoCreatedGroup1: TdxLayoutAutoCreatedGroup
      Parent = dxLayoutControl1Group_Root
      AlignHorz = ahClient
      Index = 3
    end
    object dxLayoutAutoCreatedGroup7: TdxLayoutAutoCreatedGroup
      Parent = dxLayoutAutoCreatedGroup1
      LayoutDirection = ldHorizontal
      Index = 2
    end
    object dxLayoutItem12: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup2
      CaptionOptions.Text = 'cxTreeList2'
      Control = cxTreeList2
      ControlOptions.OriginalHeight = 150
      ControlOptions.OriginalWidth = 250
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItem13: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup2
      AlignHorz = ahRight
      CaptionOptions.Text = 'Button1'
      CaptionOptions.Visible = False
      Control = Button1
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutAutoCreatedGroup2: TdxLayoutAutoCreatedGroup
      Parent = dxLayoutControl1Group_Root
      Index = 1
    end
  end
  object IdTCPServer1: TIdTCPServer
    Active = True
    Bindings = <>
    DefaultPort = 0
    OnExecute = IdTCPServer1Execute
    Left = 536
    Top = 496
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
  object IdIRCServer1: TIdIRCServer
    Bindings = <>
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
    Left = 608
    Top = 496
  end
  object dxLayoutLookAndFeelList1: TdxLayoutLookAndFeelList
    object dxLayoutSkinLookAndFeel1: TdxLayoutSkinLookAndFeel
      PixelsPerInch = 96
    end
  end
end
