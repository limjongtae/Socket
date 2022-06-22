object ServerForm1: TServerForm1
  Left = 0
  Top = 0
  Caption = 'ServerForm1'
  ClientHeight = 750
  ClientWidth = 1176
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
    Width = 1176
    Height = 750
    Align = alClient
    ParentBackground = True
    TabOrder = 0
    Transparent = True
    LayoutLookAndFeel = dxLayoutSkinLookAndFeel1
    ExplicitWidth = 1238
    ExplicitHeight = 513
    object cxTreeList1: TcxTreeList
      Left = 19
      Top = 22
      Width = 254
      Height = 706
      Bands = <
        item
          Caption.Text = 'test'
        end>
      Navigator.Buttons.CustomButtons = <>
      TabOrder = 0
      object cxTreeList1Column1: TcxTreeListColumn
        Caption.Text = 'test'
        DataBinding.ValueType = 'String'
        Width = 100
        Position.ColIndex = 0
        Position.RowIndex = 0
        Position.BandIndex = 0
        Summary.FooterSummaryItems = <>
        Summary.GroupFooterSummaryItems = <>
      end
    end
    object cxMemo1: TcxMemo
      Left = 279
      Top = 22
      Properties.ReadOnly = True
      Style.HotTrack = False
      TabOrder = 1
      Height = 679
      Width = 248
    end
    object cxTextEdit1: TcxTextEdit
      Left = 279
      Top = 707
      Style.HotTrack = False
      TabOrder = 2
      OnKeyDown = cxTextEdit1KeyDown
      Width = 248
    end
    object cxGrid1: TcxGrid
      Left = 533
      Top = 22
      Width = 624
      Height = 235
      TabOrder = 4
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
    object cxButton5: TcxButton
      Left = 533
      Top = 703
      Width = 75
      Height = 25
      Caption = #50500#51060#53596#52628#44032
      TabOrder = 3
      OnClick = cxButton5Click
    end
    object dxRangeControl1: TdxRangeControl
      Left = 622
      Top = 520
      Width = 535
      Height = 90
      TabOrder = 8
      VisibleRangeMaxScaleFactor = 10.000000000000000000
    end
    object dxToggleSwitch1: TdxToggleSwitch
      Left = 995
      Top = 616
      Caption = 'dxToggleSwitch1'
      Checked = False
      Style.HotTrack = False
      TabOrder = 9
    end
    object dxSparklineEdit1: TdxSparklineEdit
      Left = 622
      Top = 472
      Properties.Series = <>
      Style.HotTrack = False
      TabOrder = 7
      Height = 42
      Width = 535
    end
    object dxActivityIndicator1: TdxActivityIndicator
      Left = 622
      Top = 263
      Width = 535
      Height = 100
      PropertiesClassName = 'TdxActivityIndicatorHorizontalDotsProperties'
      Active = True
    end
    object cxListBox1: TcxListBox
      Left = 622
      Top = 369
      Width = 535
      Height = 97
      ItemHeight = 13
      Items.Strings = (
        #12615#12615#12615#12615)
      TabOrder = 6
    end
    object dxLayoutControl1Group_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      ButtonOptions.Buttons = <>
      ItemIndex = 1
      LayoutDirection = ldHorizontal
      Index = -1
    end
    object dxLayoutItem1: TdxLayoutItem
      Parent = dxLayoutControl1Group_Root
      AlignHorz = ahLeft
      AlignVert = avClient
      Control = cxTreeList1
      ControlOptions.OriginalHeight = 540
      ControlOptions.OriginalWidth = 254
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
    object dxLayoutItem4: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup5
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
      ControlOptions.OriginalHeight = 235
      ControlOptions.OriginalWidth = 250
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItem7: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup1
      AlignHorz = ahLeft
      AlignVert = avBottom
      CaptionOptions.Visible = False
      Control = cxButton5
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutAutoCreatedGroup5: TdxLayoutAutoCreatedGroup
      Parent = dxLayoutControl1Group_Root
      AlignHorz = ahLeft
      AlignVert = avClient
      Index = 1
    end
    object dxLayoutAutoCreatedGroup1: TdxLayoutAutoCreatedGroup
      Parent = dxLayoutControl1Group_Root
      AlignHorz = ahClient
      AlignVert = avClient
      Index = 2
    end
    object dxLayoutItem3: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup1
      CaptionOptions.Text = 'dxRangeControl1'
      Control = dxRangeControl1
      ControlOptions.OriginalHeight = 90
      ControlOptions.OriginalWidth = 420
      ControlOptions.ShowBorder = False
      Index = 5
    end
    object dxLayoutItem6: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup1
      AlignHorz = ahRight
      CaptionOptions.Text = 'dxToggleSwitch1'
      CaptionOptions.Visible = False
      Control = dxToggleSwitch1
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 162
      ControlOptions.ShowBorder = False
      Index = 6
    end
    object dxLayoutItem8: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup1
      CaptionOptions.Text = 'dxSparklineEdit1'
      Control = dxSparklineEdit1
      ControlOptions.OriginalHeight = 42
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object dxLayoutItem9: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup1
      CaptionOptions.Text = #52980#54028#51068#51473
      Control = dxActivityIndicator1
      ControlOptions.OriginalHeight = 100
      ControlOptions.OriginalWidth = 300
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItem10: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup1
      AlignHorz = ahClient
      CaptionOptions.Text = #52572#44540' '#48320#44221#45236#50669
      Control = cxListBox1
      ControlOptions.OriginalHeight = 97
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 3
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
    Left = 480
    Top = 544
  end
  object dxLayoutLookAndFeelList1: TdxLayoutLookAndFeelList
    Left = 32
    Top = 80
    object dxLayoutSkinLookAndFeel1: TdxLayoutSkinLookAndFeel
      PixelsPerInch = 96
    end
  end
end
