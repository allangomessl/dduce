object frmDynamicRecords: TfrmDynamicRecords
  Left = 0
  Top = 0
  ClientHeight = 591
  ClientWidth = 716
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    716
    591)
  PixelsPerInch = 96
  TextHeight = 13
  object btnTestAssign: TButton
    Left = 8
    Top = 8
    Width = 83
    Height = 25
    Action = actTestAssign
    TabOrder = 0
  end
  object btnTestAssignTo: TButton
    Left = 8
    Top = 39
    Width = 83
    Height = 25
    Action = actTestAssignTo
    TabOrder = 1
  end
  object pgcMain: TPageControl
    Left = 97
    Top = 8
    Width = 611
    Height = 201
    ActivePage = tsContactObject
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    object tsContactObject: TTabSheet
      Caption = 'TContact object'
      object lblContact: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 597
        Height = 170
        Align = alClient
        AutoSize = False
        Color = clInfoBk
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Consolas'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Transparent = False
        ExplicitLeft = 13
        ExplicitTop = 33
        ExplicitWidth = 364
        ExplicitHeight = 200
      end
    end
    object tsDataSet: TTabSheet
      Caption = 'DataSet'
      ImageIndex = 1
      object grdTest: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 597
        Height = 167
        Align = alClient
        DataSource = dscTest
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'Name'
            Width = 66
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Capital'
            Width = 73
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Continent'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Area'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Population'
            Visible = True
          end>
      end
    end
    object tsTestClass: TTabSheet
      Caption = 'TTestClass'
      ImageIndex = 2
      object lblTestClass: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 597
        Height = 170
        Align = alClient
        AutoSize = False
        Color = clInfoBk
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Consolas'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Transparent = False
        ExplicitLeft = 37
        ExplicitTop = 0
        ExplicitWidth = 245
        ExplicitHeight = 364
      end
    end
    object tsTestRecord: TTabSheet
      Caption = 'TTestRecord'
      ImageIndex = 3
      object lblTestRecord: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 597
        Height = 170
        Align = alClient
        AutoSize = False
        Color = clInfoBk
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Consolas'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Transparent = False
        ExplicitLeft = 13
        ExplicitTop = 33
        ExplicitWidth = 364
        ExplicitHeight = 200
      end
    end
    object tsTRecord: TTabSheet
      Caption = 'TRecord'
      ImageIndex = 4
      object lblTestTRecord: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 597
        Height = 170
        Align = alClient
        AutoSize = False
        Color = clInfoBk
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Consolas'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        Transparent = False
        ExplicitLeft = 37
        ExplicitTop = 0
        ExplicitWidth = 245
        ExplicitHeight = 364
      end
    end
  end
  object pnlBottom: TGridPanel
    Left = 0
    Top = 215
    Width = 716
    Height = 376
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    ColumnCollection = <
      item
        Value = 37.500000000000000000
      end
      item
        Value = 62.500000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = pnlRecordInspector
        Row = 0
      end
      item
        Column = 1
        Control = pnlBottomRight
        Row = 0
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    RowCollection = <
      item
        Value = 100.000000000000000000
      end
      item
        SizeStyle = ssAuto
      end>
    TabOrder = 3
    object pnlRecordInspector: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 262
      Height = 370
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object pnlRecordInspectorHeader: TPanel
        Left = 0
        Top = 0
        Width = 262
        Height = 17
        Align = alTop
        BevelOuter = bvNone
        Caption = 'TRecord content'
        TabOrder = 0
      end
    end
    object pnlBottomRight: TPanel
      Left = 268
      Top = 0
      Width = 448
      Height = 376
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object pnlRightBottomHeader: TPanel
        Left = 0
        Top = 0
        Width = 448
        Height = 19
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Conversion methods'
        TabOrder = 0
      end
      object pnlTRecordRepresentations: TGridPanel
        Left = 0
        Top = 19
        Width = 448
        Height = 357
        Align = alClient
        BevelOuter = bvNone
        ColumnCollection = <
          item
            Value = 100.000000000000000000
          end>
        ControlCollection = <
          item
            Column = 0
            Control = grpAsCommaText
            Row = 0
          end
          item
            Column = 0
            Control = grpAsDelimitedText
            Row = 1
          end
          item
            Column = 0
            Control = grpToStrings
            Row = 2
          end
          item
            Column = 0
            Control = grpToString
            Row = 3
          end>
        RowCollection = <
          item
            Value = 25.113906109260300000
          end
          item
            Value = 24.947071570572670000
          end
          item
            Value = 24.948130782096440000
          end
          item
            Value = 24.990891538070580000
          end>
        TabOrder = 1
        object grpAsCommaText: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 442
          Height = 83
          Align = alClient
          Caption = 'AsCommaText'
          TabOrder = 0
          object lblAsCommaText: TLabel
            AlignWithMargins = True
            Left = 5
            Top = 18
            Width = 432
            Height = 63
            Align = alClient
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Consolas'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = False
            WordWrap = True
            ExplicitWidth = 6
            ExplicitHeight = 13
          end
        end
        object grpAsDelimitedText: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 92
          Width = 442
          Height = 83
          Align = alClient
          Caption = 'AsDelimitedText'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object lblAsDelimitedText: TLabel
            AlignWithMargins = True
            Left = 180
            Top = 18
            Width = 257
            Height = 63
            Align = alRight
            Anchors = [akLeft, akTop, akRight, akBottom]
            AutoSize = False
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Consolas'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = False
            WordWrap = True
            ExplicitWidth = 255
            ExplicitHeight = 62
          end
          object chkQuoteValues: TCheckBox
            Left = 11
            Top = 22
            Width = 83
            Height = 17
            Caption = 'Quote values'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = chkQuoteValuesClick
          end
          object edtDelimiter: TLabeledEdit
            Left = 61
            Top = 47
            Width = 64
            Height = 21
            EditLabel.Width = 45
            EditLabel.Height = 13
            EditLabel.Caption = 'Delimiter:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            LabelPosition = lpLeft
            ParentFont = False
            TabOrder = 1
            Text = ';'
            OnChange = edtDelimiterChange
          end
          object edtQuoteChar: TLabeledEdit
            Left = 157
            Top = 20
            Width = 17
            Height = 21
            EditLabel.Width = 58
            EditLabel.Height = 13
            EditLabel.Caption = 'Quote char:'
            LabelPosition = lpLeft
            MaxLength = 1
            TabOrder = 2
            Text = #39
            OnChange = edtQuoteCharChange
          end
        end
        object grpToStrings: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 181
          Width = 442
          Height = 83
          Align = alClient
          Caption = 'ToStrings'
          TabOrder = 2
          object lblToStrings: TLabel
            AlignWithMargins = True
            Left = 5
            Top = 18
            Width = 432
            Height = 63
            Align = alClient
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Consolas'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = False
            WordWrap = True
            ExplicitWidth = 6
            ExplicitHeight = 13
          end
        end
        object grpToString: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 270
          Width = 442
          Height = 84
          Align = alClient
          Caption = 'ToString'
          TabOrder = 3
          DesignSize = (
            442
            84)
          object lblToString: TLabel
            AlignWithMargins = True
            Left = 96
            Top = 18
            Width = 341
            Height = 64
            Anchors = [akLeft, akTop, akRight, akBottom]
            AutoSize = False
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Consolas'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = False
            WordWrap = True
            ExplicitWidth = 339
          end
          object chkAlignValues: TCheckBox
            Left = 11
            Top = 24
            Width = 79
            Height = 17
            Caption = 'Align values'
            Checked = True
            State = cbChecked
            TabOrder = 0
            OnClick = chkAlignValuesClick
          end
        end
      end
    end
  end
  object btnTestAssignTo1: TButton
    Left = 8
    Top = 70
    Width = 83
    Height = 25
    Action = actToStrings
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object btnTestData: TButton
    Left = 16
    Top = 101
    Width = 75
    Height = 25
    Action = actTestData
    Caption = 'TestData'
    TabOrder = 5
  end
  object aclMain: TActionList
    Left = 24
    Top = 160
    object actTestAssignTo: TAction
      Category = 'Test'
      Caption = 'AssignTo'
    end
    object actTestAssign: TAction
      Category = 'Test'
      Caption = 'Assign'
      OnExecute = actTestAssignExecute
    end
    object actToStrings: TAction
      Caption = 'ToStrings'
      OnExecute = actToStringsExecute
    end
    object actTestData: TAction
      Category = 'Test'
      Caption = 'TestData'#13#10
      OnExecute = actTestDataExecute
    end
  end
  object dsTest: TClientDataSet
    PersistDataPacket.Data = {
      5F0400009619E0BD010000001800000005001200000003000000CA00044E616D
      650100490010000100055749445448020002001800074361706974616C010049
      001000010005574944544802000200180009436F6E74696E656E740100490010
      000100055749445448020002001800044172656108000400100000000A506F70
      756C6174696F6E080004001000000003000D44454641554C545F4F5244455204
      00820001000000010000000B5052494D4152595F4B4559040082000100000001
      000000044C43494402000100090800000009417267656E74696E610C4275656E
      6F732041697265730D536F75746820416D6572696361000000806B3145410000
      0030BECD7E4100000007426F6C69766961064C612050617A0D536F7574682041
      6D6572696361000000004FC3304100000000E8D85B41000000064272617A696C
      0842726173696C69610D536F75746820416D657269636100000080DB3B604100
      000000D8EDA1410000000643616E616461064F74746177610D4E6F7274682041
      6D6572696361000000602A07634100000000BA457941000000054368696C6508
      53616E746961676F0D536F75746820416D6572696361000000009E1927410000
      0000502D694100000008436F6C6F6D626961064261676F74610D536F75746820
      416D657269636100000000DB60314100000000A4787F41000000044375626106
      486176616E610D4E6F72746820416D657269636100000000C0F5FB4000000000
      C83764410000000745637561646F7205517569746F0D536F75746820416D6572
      6963610000000038CD1B4100000000C83764410000000B456C2053616C766164
      6F720C53616E2053616C7661646F720D4E6F72746820416D6572696361000000
      004060D44000000000C837544100000006477579616E610A47656F726765746F
      776E0D536F75746820416D657269636100000000C83D0A4100000000006A2841
      000000074A616D61696361084B696E6773746F6E0D4E6F72746820416D657269
      6361000000000050C64000000000D0124341000000064D657869636F0B4D6578
      69636F20436974790D4E6F72746820416D6572696361000000004C043E410000
      0000B71F9541000000094E6963617261677561074D616E616775610D4E6F7274
      6820416D657269636100000000C0F700410000000030C14D4100000008506172
      6167756179084173756E63696F6E0D536F75746820416D657269636100000000
      C0D0184100000000C8C651410000000450657275044C696D610D536F75746820
      416D6572696361000000005F9C3341000000007099744100000018556E697465
      6420537461746573206F6620416D65726963610A57617368696E67746F6E0D4E
      6F72746820416D657269636100000040D7DB614100000000FBB4AD4100000007
      557275677561790A4D6F6E7465766964656F0D536F75746820416D6572696361
      00000000608005410000000048E746410000000956656E657A75656C61074361
      72616361730D536F75746820416D6572696361000000005ED52B410000000092
      C97241}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 176
  end
  object dscTest: TDataSource
    DataSet = dsTest
    OnDataChange = dscTestDataChange
    Left = 64
    Top = 168
  end
end
