inherited frCustomTaskListView: TfrCustomTaskListView
  Left = 564
  Top = 216
  Caption = 'frCustomTaskListView'
  ClientWidth = 1023
  ExplicitWidth = 1029
  ExplicitHeight = 543
  PixelsPerInch = 96
  TextHeight = 13
  inherited ViewControl: TcxGroupBox
    ExplicitWidth = 1023
    Width = 1023
    inherited pnButtons: TcxGroupBox
      ExplicitWidth = 1023
      Width = 1023
    end
    object pnFilter: TcxGroupBox
      Left = 0
      Top = 40
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.LookAndFeel.Kind = lfOffice11
      StyleDisabled.LookAndFeel.Kind = lfOffice11
      StyleFocused.LookAndFeel.Kind = lfOffice11
      StyleHot.LookAndFeel.Kind = lfOffice11
      TabOrder = 1
      Height = 40
      Width = 1023
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
          Properties.OnEditValueChanged = DBegPropertiesEditValueChanged
          TabOrder = 1
          Width = 121
        end
        object DEnd: TcxDateEdit
          Left = 165
          Top = 8
          Properties.OnEditValueChanged = DBegPropertiesEditValueChanged
          TabOrder = 2
          Width = 121
        end
      end
    end
    object tcStates: TcxTabControl
      Left = 0
      Top = 80
      Width = 1023
      Height = 435
      Align = alClient
      TabOrder = 2
      LookAndFeel.Kind = lfOffice11
      ClientRectBottom = 431
      ClientRectLeft = 4
      ClientRectRight = 1019
      ClientRectTop = 4
      object grMain: TcxGrid
        Left = 4
        Top = 4
        Width = 1015
        Height = 427
        Align = alClient
        TabOrder = 0
        LookAndFeel.Kind = lfOffice11
        object grMainViewDef: TcxGridDBBandedTableView
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
    Left = 150
    Top = 166
  end
  object ppmGrid: TPopupMenu [2]
    Left = 116
    Top = 267
    object N2: TMenuItem
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' Excel'
    end
  end
  object ppmPrint: TPopupMenu [3]
    Left = 182
    Top = 110
  end
  object ppmActionExt: TPopupMenu [4]
    Left = 430
    Top = 134
  end
  object MainDataSource: TDataSource [5]
    Left = 78
    Top = 136
  end
  inherited ActionList: TActionList
    Left = 52
    Top = 218
  end
  object ppmOpen: TPopupMenu
    Left = 222
    Top = 246
  end
  object ppmChangeState: TPopupMenu
    Left = 322
    Top = 110
  end
end
