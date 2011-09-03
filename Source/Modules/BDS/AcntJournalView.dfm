inherited frAcntJournalView: TfrAcntJournalView
  Left = 562
  Top = 289
  Caption = 'frAcntJournalView'
  PixelsPerInch = 96
  TextHeight = 13
  inherited ViewControl: TcxGroupBox
    object pcTotal: TcxPageControl
      Left = 2
      Top = 370
      Width = 761
      Height = 143
      ActivePage = cxTabSheet2
      Align = alBottom
      LookAndFeel.Kind = lfOffice11
      TabOrder = 2
      TabPosition = tpBottom
      ClientRectBottom = 119
      ClientRectRight = 761
      ClientRectTop = 0
      object cxTabSheet1: TcxTabSheet
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1089#1095#1077#1090#1072
        ImageIndex = 0
      end
      object cxTabSheet2: TcxTabSheet
        Caption = #1054#1073#1086#1088#1086#1090#1099' '#1080' '#1089#1072#1083#1100#1076#1086
        ImageIndex = 1
        object grBS: TcxDBVerticalGrid
          Left = 0
          Top = 0
          Width = 761
          Height = 119
          BorderStyle = cxcbsNone
          Align = alClient
          LayoutStyle = lsMultiRecordView
          LookAndFeel.Kind = lfOffice11
          OptionsView.CategoryExplorerStyle = True
          OptionsView.GridLineColor = clBtnText
          OptionsView.RowHeaderWidth = 169
          OptionsView.ValueWidth = 149
          TabOrder = 0
          DataController.DataSource = BSDataSource
          Version = 1
          object grBSTopCategory: TcxCategoryRow
            Options.Focusing = False
            Options.ShowExpandButton = False
            Options.TabStop = False
            Properties.HeaderAlignmentVert = vaCenter
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
          object grBSDBEditorRow2: TcxDBEditorRow
            Properties.Caption = #1060#1086#1088#1084#1072
            Properties.DataBinding.FieldName = 'MODE_NAME'
            Styles.Header = cxStyle1
            Styles.Content = cxStyle3
            ID = 1
            ParentID = -1
            Index = 1
            Version = 1
          end
          object grBSDBEditorRow3: TcxDBEditorRow
            Properties.Caption = #1057#1072#1083#1100#1076#1086' '#1085#1072' '#1085#1072#1095#1072#1083#1086
            Properties.DataBinding.FieldName = 'BS_BEG'
            ID = 2
            ParentID = -1
            Index = 2
            Version = 1
          end
          object grBSDBEditorRow4: TcxDBEditorRow
            Properties.Caption = #1055#1088#1080#1093#1086#1076
            Properties.DataBinding.FieldName = 'DT'
            ID = 3
            ParentID = -1
            Index = 3
            Version = 1
          end
          object grBSDBEditorRow5: TcxDBEditorRow
            Properties.Caption = #1056#1072#1089#1093#1086#1076
            Properties.DataBinding.FieldName = 'KT'
            ID = 4
            ParentID = -1
            Index = 4
            Version = 1
          end
          object grBSDBEditorRow1: TcxDBEditorRow
            Properties.Caption = #1057#1072#1083#1100#1076#1086' '#1085#1072' '#1082#1086#1085#1077#1094
            Properties.DataBinding.FieldName = 'BS_END'
            Styles.Header = cxStyle2
            Styles.Content = cxStyle2
            ID = 5
            ParentID = -1
            Index = 5
            Version = 1
          end
        end
      end
    end
    object cxSplitter1: TcxSplitter
      Left = 2
      Top = 362
      Width = 761
      Height = 8
      HotZoneClassName = 'TcxXPTaskBarStyle'
      AlignSplitter = salBottom
      Control = pcTotal
    end
    object pnInfo: TcxGroupBox
      Left = 2
      Top = 42
      Align = alTop
      PanelStyle.Active = True
      PanelStyle.CaptionIndent = 5
      PanelStyle.OfficeBackgroundKind = pobkStyleColor
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      Style.BorderStyle = ebsNone
      Style.Color = clInfoBk
      Style.Edges = [bLeft, bTop, bRight, bBottom]
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -16
      Style.Font.Name = 'MS Sans Serif'
      Style.Font.Style = []
      Style.LookAndFeel.Kind = lfOffice11
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      StyleDisabled.LookAndFeel.Kind = lfOffice11
      StyleFocused.LookAndFeel.Kind = lfOffice11
      StyleHot.LookAndFeel.Kind = lfOffice11
      TabOrder = 3
      Visible = False
      Height = 30
      Width = 761
    end
    object grList: TcxGrid
      Left = 2
      Top = 72
      Width = 761
      Height = 290
      Align = alClient
      TabOrder = 4
      LookAndFeel.Kind = lfOffice11
      object grJrnView: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        FilterBox.Position = fpTop
        OnCellDblClick = grJrnViewCellDblClick
        DataController.DataSource = JrnDataSource
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
        GridView = grJrnView
      end
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clInfoBk
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
    end
    object cxStyle3: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
    end
  end
  object BSDataSource: TDataSource
    Left = 42
    Top = 149
  end
  object JrnDataSource: TDataSource
    Left = 78
    Top = 146
  end
end
