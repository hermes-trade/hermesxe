inherited frTaskBulkItemView: TfrTaskBulkItemView
  Left = 597
  Top = 360
  Caption = 'frTaskBulkItemView'
  ExplicitWidth = 320
  PixelsPerInch = 96
  TextHeight = 13
  inherited ViewControl: TcxGroupBox
    object grHeader: TcxDBVerticalGrid
      Left = 2
      Top = 42
      Width = 761
      Height = 201
      Align = alTop
      LayoutStyle = lsMultiRecordView
      LookAndFeel.Kind = lfOffice11
      OptionsView.ShowEditButtons = ecsbAlways
      OptionsView.CategoryExplorerStyle = True
      OptionsView.GridLineColor = clBtnFace
      OptionsView.RowHeaderWidth = 300
      OptionsView.ValueWidth = 300
      OptionsBehavior.AlwaysShowEditor = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsData.Appending = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      TabOrder = 1
      DataController.DataSource = HeaderDataSource
      ExplicitWidth = 769
      Version = 1
    end
    object cxSplitter1: TcxSplitter
      Left = 2
      Top = 243
      Width = 761
      Height = 6
      AlignSplitter = salTop
      Control = grHeader
      ExplicitWidth = 769
    end
    object tcDetails: TcxTabControl
      Left = 2
      Top = 249
      Width = 761
      Height = 264
      Align = alClient
      Style = 8
      TabIndex = 0
      TabOrder = 3
      Tabs.Strings = (
        #1053#1077' '#1085#1072#1087#1077#1095#1072#1090#1072#1085#1085#1099#1077
        #1053#1072#1087#1077#1095#1072#1090#1072#1085#1085#1099#1077)
      ExplicitWidth = 769
      ExplicitHeight = 272
      ClientRectBottom = 264
      ClientRectRight = 761
      ClientRectTop = 24
      object grList: TcxGrid
        Left = 0
        Top = 24
        Width = 769
        Height = 248
        Align = alClient
        TabOrder = 0
        LookAndFeel.Kind = lfOffice11
        object grDetails: TcxGridDBTableView
          NavigatorButtons.ConfirmDelete = False
          FilterBox.Position = fpTop
          DataController.DataSource = DetailsDataSource
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.IncSearch = True
          OptionsBehavior.PullFocusing = True
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          OptionsSelection.MultiSelect = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
        end
        object grListLevel1: TcxGridLevel
          Caption = 'Table'
          GridView = grDetails
        end
      end
    end
  end
  inherited ActionList: TActionList
    object acPrintDef: TAction
      Caption = #1055#1077#1095#1072#1090#1100
      OnExecute = acPrintDefExecute
    end
    object acPrintBulkCollect: TAction
      Caption = #1047#1072#1073#1086#1088#1085#1099#1081' '#1083#1080#1089#1090
    end
    object acPrintCollectTask: TAction
      Caption = #1050#1086#1084#1087#1083#1077#1082#1090#1086#1074#1086#1095#1085#1099#1081' '#1083#1080#1089#1090
    end
  end
  object HeaderDataSource: TDataSource
    Left = 48
    Top = 144
  end
  object DetailsDataSource: TDataSource
    Left = 76
    Top = 144
  end
end
