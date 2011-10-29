inherited frCustomTaskListView: TfrCustomTaskListView
  Left = 564
  Top = 216
  Caption = 'frCustomTaskListView'
  ClientWidth = 1023
  ExplicitWidth = 320
  PixelsPerInch = 96
  TextHeight = 13
  inherited ViewControl: TcxGroupBox
    ExplicitWidth = 1023
    Width = 1023
    inherited pnButtons: TcxGroupBox
      ExplicitWidth = 1019
      Width = 1019
    end
    object pnFilter: TcxGroupBox
      Left = 2
      Top = 42
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.LookAndFeel.Kind = lfOffice11
      StyleDisabled.LookAndFeel.Kind = lfOffice11
      StyleFocused.LookAndFeel.Kind = lfOffice11
      StyleHot.LookAndFeel.Kind = lfOffice11
      TabOrder = 1
      Height = 40
      Width = 1019
      object cxGroupBox1: TcxGroupBox
        Left = 2
        Top = 2
        Align = alLeft
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.LookAndFeel.Kind = lfOffice11
        StyleDisabled.LookAndFeel.Kind = lfOffice11
        StyleFocused.LookAndFeel.Kind = lfOffice11
        StyleHot.LookAndFeel.Kind = lfOffice11
        TabOrder = 0
        Height = 36
        Width = 303
        object cxLabel1: TcxLabel
          Left = 6
          Top = 10
          Caption = #1057#1088#1086#1082':'
          Style.LookAndFeel.Kind = lfOffice11
          Style.TextStyle = []
          StyleDisabled.LookAndFeel.Kind = lfOffice11
          StyleFocused.LookAndFeel.Kind = lfOffice11
          StyleHot.LookAndFeel.Kind = lfOffice11
          Transparent = True
        end
        object DBeg: TcxDateEdit
          Left = 39
          Top = 8
          TabOrder = 1
          Width = 121
        end
        object DEnd: TcxDateEdit
          Left = 165
          Top = 8
          TabOrder = 2
          Width = 121
        end
      end
    end
    object tcStates: TcxTabControl
      Left = 2
      Top = 82
      Width = 1019
      Height = 431
      Align = alClient
      LookAndFeel.Kind = lfOffice11
      LookAndFeel.NativeStyle = False
      Style = 8
      TabOrder = 2
      ExplicitHeight = 439
      ClientRectBottom = 431
      ClientRectRight = 1019
      ClientRectTop = 0
      object grMain: TcxGrid
        Left = 0
        Top = 0
        Width = 1019
        Height = 439
        Align = alClient
        TabOrder = 0
        LookAndFeel.Kind = lfOffice11
        object grMainViewDef: TcxGridDBBandedTableView
          NavigatorButtons.ConfirmDelete = False
          FilterBox.Position = fpTop
          OnCellDblClick = grMainViewDefCellDblClick
          DataController.DataSource = MainDataSource
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
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.MultiSelect = True
          OptionsView.CellEndEllipsis = True
          OptionsView.FooterMultiSummaries = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          OptionsView.BandCaptionsInColumnAlternateCaption = True
          Bands = <
            item
            end>
        end
        object grMainLevel1: TcxGridLevel
          Caption = 'Table'
          GridView = grMainViewDef
        end
      end
    end
  end
  object ppmCreate: TPopupMenu [1]
    Left = 94
    Top = 158
  end
  object ppmGrid: TPopupMenu [2]
    Left = 124
    Top = 203
    object N2: TMenuItem
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' Excel'
    end
  end
  object ppmPrint: TPopupMenu [3]
    Left = 182
    Top = 158
  end
  object ppmActionExt: TPopupMenu [4]
    Left = 238
    Top = 158
  end
  object MainDataSource: TDataSource [5]
    Left = 30
    Top = 160
  end
  inherited ActionList: TActionList
    Left = 20
    Top = 186
  end
  object ppmOpen: TPopupMenu
    Left = 126
    Top = 158
  end
  object ppmChangeState: TPopupMenu
    Left = 210
    Top = 158
  end
end
