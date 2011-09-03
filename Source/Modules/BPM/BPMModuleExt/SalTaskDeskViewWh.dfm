inherited frSalTaskDeskViewWh: TfrSalTaskDeskViewWh
  Left = 792
  Top = 316
  Caption = 'frSalTaskDeskViewWh'
  ClientHeight = 657
  ClientWidth = 851
  PixelsPerInch = 96
  TextHeight = 13
  inherited ViewControl: TcxGroupBox
    PanelStyle.OfficeBackgroundKind = pobkOffice11Color
    Height = 657
    Width = 851
    inherited pnButtons: TcxGroupBox
      TabOrder = 1
      Width = 847
      object btAddExecutor: TcxButton
        Left = 94
        Top = 8
        Width = 150
        Height = 25
        Action = acAddExecutor
        TabOrder = 0
        LookAndFeel.Kind = lfOffice11
        SpeedButtonOptions.CanBeFocused = False
      end
      object btRemoveExecutor: TcxButton
        Left = 254
        Top = 8
        Width = 150
        Height = 25
        Action = acRemoveExecutor
        TabOrder = 1
        LookAndFeel.Kind = lfOffice11
        SpeedButtonOptions.CanBeFocused = False
      end
      object cxButton6: TcxButton
        Left = 414
        Top = 8
        Width = 150
        Height = 25
        Action = acTaskIssue
        TabOrder = 3
        LookAndFeel.Kind = lfOffice11
        SpeedButtonOptions.CanBeFocused = False
      end
      object cxLabel1: TcxLabel
        Left = 570
        Top = 12
        Caption = #8470
        Transparent = True
      end
      object TASK_ID: TcxButtonEdit
        Left = 586
        Top = 10
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ClickKey = 13
        Properties.OnButtonClick = TASK_IDPropertiesButtonClick
        Style.LookAndFeel.Kind = lfOffice11
        StyleDisabled.LookAndFeel.Kind = lfOffice11
        StyleFocused.LookAndFeel.Kind = lfOffice11
        StyleHot.LookAndFeel.Kind = lfOffice11
        TabOrder = 4
        Width = 169
      end
      object cxButton1: TcxButton
        Left = 5
        Top = 9
        Width = 83
        Height = 25
        Action = acClose
        TabOrder = 5
        LookAndFeel.Kind = lfOffice11
        SpeedButtonOptions.CanBeFocused = False
      end
    end
    object cxGroupBox3: TcxGroupBox
      Left = 2
      Top = 42
      Align = alLeft
      Caption = #1050#1086#1084#1087#1083#1077#1082#1090#1086#1074#1097#1080#1082#1080
      Style.BorderStyle = ebsNone
      Style.LookAndFeel.Kind = lfOffice11
      Style.TextStyle = [fsBold]
      Style.TransparentBorder = True
      StyleDisabled.LookAndFeel.Kind = lfOffice11
      StyleFocused.LookAndFeel.Kind = lfOffice11
      StyleHot.LookAndFeel.Kind = lfOffice11
      TabOrder = 0
      Height = 613
      Width = 319
      object grExecutors: TcxGrid
        Left = 2
        Top = 18
        Width = 315
        Height = 593
        Align = alClient
        TabOrder = 0
        LookAndFeel.Kind = lfOffice11
        object grExecutorsViewDef: TcxGridDBTableView
          NavigatorButtons.ConfirmDelete = False
          OnCellDblClick = grExecutorsViewDefCellDblClick
          DataController.DataSource = ExecutorsDataSource
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
        end
        object cxGridLevel1: TcxGridLevel
          Caption = 'Table'
          GridView = grExecutorsViewDef
        end
      end
    end
    object cxSplitter1: TcxSplitter
      Left = 321
      Top = 42
      Width = 8
      Height = 613
      Control = cxGroupBox3
    end
    object cxGroupBox1: TcxGroupBox
      Left = 329
      Top = 42
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.LookAndFeel.Kind = lfOffice11
      StyleDisabled.LookAndFeel.Kind = lfOffice11
      StyleFocused.LookAndFeel.Kind = lfOffice11
      StyleHot.LookAndFeel.Kind = lfOffice11
      TabOrder = 2
      Height = 613
      Width = 520
      object cxGroupBox6: TcxGroupBox
        Left = 2
        Top = 2
        Align = alTop
        Caption = #1047#1072#1076#1072#1095#1072
        Style.BorderStyle = ebsNone
        Style.LookAndFeel.Kind = lfOffice11
        Style.TextStyle = [fsBold]
        StyleDisabled.LookAndFeel.Kind = lfOffice11
        StyleFocused.LookAndFeel.Kind = lfOffice11
        StyleHot.LookAndFeel.Kind = lfOffice11
        TabOrder = 0
        Height = 355
        Width = 516
        object grData: TcxDBVerticalGrid
          Left = 2
          Top = 18
          Width = 512
          Height = 335
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          LookAndFeel.Kind = lfOffice11
          OptionsView.BandsInterval = 0
          OptionsView.CategoryExplorerStyle = True
          OptionsView.GridLineColor = clBtnFace
          OptionsView.RowHeaderWidth = 259
          OptionsData.Editing = False
          OptionsData.Appending = False
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          ParentFont = False
          TabOrder = 0
          DataController.DataSource = TaskDataSource
          Version = 1
        end
      end
      object cxSplitter2: TcxSplitter
        Left = 2
        Top = 357
        Width = 516
        Height = 8
        AlignSplitter = salTop
        Control = cxGroupBox6
      end
      object cxGroupBox4: TcxGroupBox
        Left = 2
        Top = 365
        Align = alClient
        Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100'('#1080')'
        Style.BorderStyle = ebsNone
        Style.LookAndFeel.Kind = lfOffice11
        Style.TextStyle = [fsBold]
        StyleDisabled.LookAndFeel.Kind = lfOffice11
        StyleFocused.LookAndFeel.Kind = lfOffice11
        StyleHot.LookAndFeel.Kind = lfOffice11
        TabOrder = 2
        Height = 246
        Width = 516
        object grTaskExecutors: TcxGrid
          Left = 2
          Top = 18
          Width = 512
          Height = 226
          Align = alClient
          TabOrder = 0
          LookAndFeel.Kind = lfOffice11
          object grTaskExecutorsViewDef: TcxGridDBTableView
            NavigatorButtons.ConfirmDelete = False
            OnCellDblClick = grTaskExecutorsViewDefCellDblClick
            DataController.DataSource = TaskExecutorsDataSource
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnsQuickCustomization = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
          end
          object grTaskExecutorsLevel1: TcxGridLevel
            Caption = 'Table'
            GridView = grTaskExecutorsViewDef
          end
        end
      end
    end
  end
  inherited ActionList: TActionList
    object acAddExecutor: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
    end
    object acRemoveExecutor: TAction
      Caption = #1048#1089#1082#1083#1102#1095#1080#1090#1100' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
    end
    object acAddTask: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1076#1072#1095#1091
    end
    object acRemoveTask: TAction
      Caption = #1048#1089#1082#1083#1102#1095#1080#1090#1100' '#1079#1072#1076#1072#1095#1091
    end
    object acTaskIssue: TAction
      Caption = #1042#1099#1076#1072#1090#1100' '#1079#1072#1076#1072#1095#1091
    end
    object acClose: TAction
      Caption = #1047#1072#1082#1088#1099#1090#1100
    end
  end
  object ExecutorsDataSource: TDataSource
    Left = 46
    Top = 150
  end
  object TaskExecutorsDataSource: TDataSource
    Left = 46
    Top = 182
  end
  object TaskDataSource: TDataSource
    Left = 46
    Top = 216
  end
end
