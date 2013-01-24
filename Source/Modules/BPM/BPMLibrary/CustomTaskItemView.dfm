inherited frCustomTaskItemView: TfrCustomTaskItemView
  Left = 712
  Top = 442
  Caption = 'frCustomTaskItemView'
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited ViewControl: TcxGroupBox
    inherited pnButtons: TcxGroupBox
      TabOrder = 1
    end
    object pcMain: TcxPageControl
      Left = 0
      Top = 40
      Width = 765
      Height = 475
      Align = alClient
      TabOrder = 0
      Properties.ActivePage = tsMain
      LookAndFeel.Kind = lfOffice11
      ClientRectBottom = 471
      ClientRectLeft = 4
      ClientRectRight = 761
      ClientRectTop = 24
      object tsMain: TcxTabSheet
        Caption = #1054#1073#1097#1080#1077
        ImageIndex = 0
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object grMain: TcxDBVerticalGrid
          Left = 0
          Top = 0
          Width = 757
          Height = 447
          Align = alClient
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
          TabOrder = 0
          DataController.DataSource = MainDataSource
          Version = 1
        end
      end
      object tsData: TcxTabSheet
        Caption = #1054#1089#1085#1086#1074#1072#1085#1080#1077
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object grData: TcxDBVerticalGrid
          Left = 0
          Top = 0
          Width = 769
          Height = 225
          Align = alTop
          LayoutStyle = lsMultiRecordView
          LookAndFeel.Kind = lfOffice11
          OptionsView.BandsInterval = 0
          OptionsView.CategoryExplorerStyle = True
          OptionsView.GridLineColor = clBtnFace
          OptionsView.RowHeaderWidth = 259
          OptionsView.ValueWidth = 300
          OptionsData.Editing = False
          OptionsData.Appending = False
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          TabOrder = 0
          DataController.DataSource = DataDataSource
          Version = 1
        end
        object grDataRec: TcxGrid
          Left = 0
          Top = 232
          Width = 769
          Height = 223
          Align = alClient
          TabOrder = 1
          LookAndFeel.Kind = lfOffice11
          object grDataRecViewDef: TcxGridDBTableView
            DataController.DataSource = DataRecDataSource
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
          end
          object grMainLevel1: TcxGridLevel
            Caption = 'Table'
            GridView = grDataRecViewDef
          end
        end
        object cxSplitter1: TcxSplitter
          Left = 0
          Top = 225
          Width = 769
          Height = 7
          AlignSplitter = salTop
          Control = grData
        end
      end
      object tsTaskLinks: TcxTabSheet
        Caption = #1057#1074#1103#1079#1072#1085#1085#1099#1077' '#1079#1072#1076#1072#1095#1080
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object grLinks: TcxGrid
          Left = 0
          Top = 0
          Width = 769
          Height = 455
          Align = alClient
          TabOrder = 0
          LookAndFeel.Kind = lfOffice11
          object grLinksViewDef: TcxGridDBBandedTableView
            FilterBox.Position = fpTop
            OnCellDblClick = grLinksViewDefCellDblClick
            DataController.DataSource = LinksDataSource
            DataController.Options = [dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoFocusTopRowAfterSorting]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.CellHints = True
            OptionsBehavior.IncSearch = True
            OptionsBehavior.NavigatorHints = True
            OptionsBehavior.PullFocusing = True
            OptionsCustomize.ColumnsQuickCustomization = True
            OptionsData.Deleting = False
            OptionsData.Inserting = False
            OptionsSelection.MultiSelect = True
            OptionsView.CellEndEllipsis = True
            OptionsView.FooterMultiSummaries = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Bands = <
              item
                FixedKind = fkLeft
                Options.Moving = False
                Width = 74
              end>
            object grLinksViewDefButtonOpenTask: TcxGridDBBandedColumn
              Caption = #1054#1090#1082#1088#1099#1090#1100
              PropertiesClassName = 'TcxButtonEditProperties'
              Properties.Buttons = <
                item
                  Caption = #1054#1090#1082#1088#1099#1090#1100
                  Default = True
                  Kind = bkText
                end>
              Properties.ViewStyle = vsButtonsOnly
              Properties.OnButtonClick = grLinksViewDefButtonOpenTaskPropertiesButtonClick
              Options.Filtering = False
              Options.IncSearch = False
              Options.ShowEditButtons = isebAlways
              Options.Moving = False
              Options.ShowCaption = False
              Options.Sorting = False
              VisibleForCustomization = False
              Position.BandIndex = 0
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
          end
          object cxGridLevel1: TcxGridLevel
            Caption = 'Table'
            GridView = grLinksViewDef
          end
        end
      end
      object tsUpdates: TcxTabSheet
        Caption = #1054#1073#1085#1086#1074#1083#1077#1085#1080#1103
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object grUpdates: TcxGrid
          Left = 0
          Top = 0
          Width = 769
          Height = 455
          Align = alClient
          TabOrder = 0
          LookAndFeel.Kind = lfOffice11
          object grUpdatesViewDef: TcxGridDBBandedTableView
            FilterBox.Position = fpTop
            OnCellDblClick = grLinksViewDefCellDblClick
            OnCustomDrawCell = grUpdatesViewDefCustomDrawCell
            DataController.DataSource = UpdatesDataSource
            DataController.Options = [dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoFocusTopRowAfterSorting]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.CellHints = True
            OptionsBehavior.IncSearch = True
            OptionsBehavior.NavigatorHints = True
            OptionsBehavior.PullFocusing = True
            OptionsCustomize.ColumnSorting = False
            OptionsCustomize.ColumnsQuickCustomization = True
            OptionsData.Deleting = False
            OptionsData.Inserting = False
            OptionsSelection.MultiSelect = True
            OptionsView.CellEndEllipsis = True
            OptionsView.FooterMultiSummaries = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Bands = <
              item
                FixedKind = fkLeft
                Options.HoldOwnColumnsOnly = True
                Options.Moving = False
                VisibleForCustomization = False
                Width = 84
              end>
            object grUpdatesViewDefButtonProcess: TcxGridDBBandedColumn
              Caption = #1086#1073#1088#1072#1073#1086#1090#1072#1090#1100
              PropertiesClassName = 'TcxButtonEditProperties'
              Properties.Buttons = <
                item
                  Caption = #1086#1073#1088#1072#1073#1086#1090#1072#1090#1100
                  Default = True
                  Kind = bkText
                end>
              Properties.ViewStyle = vsButtonsOnly
              Properties.OnButtonClick = grUpdatesViewDefButtonProcessPropertiesButtonClick
              Options.Filtering = False
              Options.ShowEditButtons = isebAlways
              Options.Moving = False
              Options.ShowCaption = False
              Options.Sorting = False
              Position.BandIndex = 0
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
          end
          object grUpdatesLevel2: TcxGridLevel
            Caption = 'Table'
            GridView = grUpdatesViewDef
          end
        end
      end
    end
  end
  inherited ActionList: TActionList
    Left = 638
    Top = 8
  end
  object MainDataSource: TDataSource
    Left = 606
    Top = 6
  end
  object DataDataSource: TDataSource
    Left = 668
    Top = 8
  end
  object LinksDataSource: TDataSource
    Left = 64
    Top = 118
  end
  object DataRecDataSource: TDataSource
    Left = 24
    Top = 120
  end
  object UpdatesDataSource: TDataSource
    Left = 702
    Top = 8
  end
end
