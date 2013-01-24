inherited frSalRetDeskView: TfrSalRetDeskView
  Left = 636
  Top = 221
  Caption = 'frSalRetDeskView'
  ClientWidth = 1049
  ExplicitWidth = 1055
  ExplicitHeight = 543
  PixelsPerInch = 96
  TextHeight = 13
  inherited ViewControl: TcxGroupBox
    ExplicitWidth = 1049
    Width = 1049
    inherited pnButtons: TcxGroupBox
      TabOrder = 2
      ExplicitWidth = 1049
      Width = 1049
    end
    object cxGroupBox1: TcxGroupBox
      Left = 0
      Top = 40
      TabStop = True
      Align = alTop
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.LookAndFeel.Kind = lfOffice11
      StyleDisabled.LookAndFeel.Kind = lfOffice11
      StyleFocused.LookAndFeel.Kind = lfOffice11
      StyleHot.LookAndFeel.Kind = lfOffice11
      TabOrder = 0
      Height = 40
      Width = 1049
      object DOC_NUM: TcxButtonEdit
        Left = 198
        Top = 10
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ClickKey = 13
        Properties.OnButtonClick = DOC_NUMPropertiesButtonClick
        Style.LookAndFeel.Kind = lfOffice11
        StyleDisabled.LookAndFeel.Kind = lfOffice11
        StyleFocused.LookAndFeel.Kind = lfOffice11
        StyleHot.LookAndFeel.Kind = lfOffice11
        TabOrder = 0
        Width = 117
      end
      object cxLabel1: TcxLabel
        Left = 180
        Top = 12
        Caption = #8470
        Style.LookAndFeel.Kind = lfOffice11
        StyleDisabled.LookAndFeel.Kind = lfOffice11
        StyleFocused.LookAndFeel.Kind = lfOffice11
        StyleHot.LookAndFeel.Kind = lfOffice11
        Transparent = True
      end
      object DOC_KIND: TcxComboBox
        Left = 9
        Top = 10
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          #1056#1072#1089#1093#1086#1076#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103
          #1047#1072#1103#1074#1082#1072' '#1085#1072' '#1074#1086#1079#1074#1088#1072#1090)
        Style.LookAndFeel.Kind = lfOffice11
        StyleDisabled.LookAndFeel.Kind = lfOffice11
        StyleFocused.LookAndFeel.Kind = lfOffice11
        StyleHot.LookAndFeel.Kind = lfOffice11
        TabOrder = 2
        Width = 162
      end
      object cxLabel2: TcxLabel
        Left = 324
        Top = 12
        Caption = #1069#1082#1089#1087#1077#1076#1080#1090#1086#1088
        Style.LookAndFeel.Kind = lfOffice11
        StyleDisabled.LookAndFeel.Kind = lfOffice11
        StyleFocused.LookAndFeel.Kind = lfOffice11
        StyleHot.LookAndFeel.Kind = lfOffice11
        Transparent = True
      end
      object FORWARDER_NAME: TcxButtonEdit
        Left = 389
        Top = 10
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end
          item
            Caption = '-'
            Kind = bkText
          end>
        Properties.ClickKey = 13
        Properties.ViewStyle = vsHideCursor
        Properties.OnButtonClick = FORWARDER_NAMEPropertiesButtonClick
        Style.LookAndFeel.Kind = lfOffice11
        StyleDisabled.LookAndFeel.Kind = lfOffice11
        StyleFocused.LookAndFeel.Kind = lfOffice11
        StyleHot.LookAndFeel.Kind = lfOffice11
        TabOrder = 4
        Width = 225
      end
    end
    object grData: TcxDBVerticalGrid
      Left = 0
      Top = 80
      Width = 1049
      Height = 261
      Align = alTop
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
      TabOrder = 1
      DataController.DataSource = HeadDataSource
      Version = 1
    end
    object cxSplitter1: TcxSplitter
      Left = 0
      Top = 341
      Width = 1049
      Height = 8
      AlignSplitter = salTop
      Control = grData
    end
    object grDataRec: TcxGrid
      Left = 0
      Top = 349
      Width = 1049
      Height = 166
      Align = alClient
      TabOrder = 3
      LevelTabs.Style = 8
      LookAndFeel.Kind = lfOffice11
      object grDataRecView: TcxGridDBBandedTableView
        OnCustomDrawCell = grDataRecViewCustomDrawCell
        DataController.DataSource = RecDataSource
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.GoToNextCellOnEnter = True
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsView.ShowEditButtons = gsebForFocusedRecord
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        OptionsView.BandCaptionsInColumnAlternateCaption = True
        Bands = <
          item
            Caption = #1054#1090#1075#1088#1091#1079#1082#1072
            Options.HoldOwnColumnsOnly = True
            Width = 477
          end
          item
            Caption = #1042#1086#1079#1074#1088#1072#1090
            Options.HoldOwnColumnsOnly = True
            Width = 361
          end
          item
            Caption = #1053#1077#1076#1086#1074#1086#1079' / '#1055#1077#1088#1077#1089#1086#1088#1090
            Options.HoldOwnColumnsOnly = True
          end>
        object grDataRecViewGDS_ID: TcxGridDBBandedColumn
          Caption = #1082#1086#1076
          DataBinding.FieldName = 'GDS_ID'
          Width = 40
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object grDataRecViewGDS_NAME: TcxGridDBBandedColumn
          Caption = #1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'GDS_NAME'
          Width = 249
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object grDataRecViewSAL_QTY: TcxGridDBBandedColumn
          Caption = #1082#1086#1083'-'#1074#1086
          DataBinding.FieldName = 'SAL_QTY'
          Width = 63
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object grDataRecViewPRICE: TcxGridDBBandedColumn
          Caption = #1094#1077#1085#1072
          DataBinding.FieldName = 'PRICE'
          Width = 62
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object grDataRecViewSUMM: TcxGridDBBandedColumn
          Caption = #1089#1091#1084#1084#1072
          DataBinding.FieldName = 'SUMM'
          Width = 63
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object grDataRecViewQTY: TcxGridDBBandedColumn
          Caption = #1082' '#1074#1086#1079#1074#1088#1072#1090#1091
          DataBinding.FieldName = 'QTY'
          Styles.Content = cxStyleInfoBk
          Width = 84
          Position.BandIndex = 1
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object grDataRecViewQTY2: TcxGridDBBandedColumn
          Caption = #1082#1086#1085#1076#1080#1094#1080#1103
          DataBinding.FieldName = 'QTY2'
          Width = 69
          Position.BandIndex = 1
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object grDataRecViewQTY3: TcxGridDBBandedColumn
          Caption = #1073#1088#1072#1082
          DataBinding.FieldName = 'QTY3'
          Width = 70
          Position.BandIndex = 1
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object grDataRecViewQTY4: TcxGridDBBandedColumn
          Caption = #1074#1087
          DataBinding.FieldName = 'QTY4'
          Width = 69
          Position.BandIndex = 1
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object grDataRecViewQTY5: TcxGridDBBandedColumn
          Caption = #1091#1090#1080#1083#1080#1079#1072#1094#1080#1103
          DataBinding.FieldName = 'QTY5'
          Width = 69
          Position.BandIndex = 1
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object grDataRecViewQTY1: TcxGridDBBandedColumn
          Caption = #1085#1077#1076#1086#1074#1086#1079
          DataBinding.FieldName = 'QTY1'
          Styles.Content = cxStyleInfoBk
          Position.BandIndex = 2
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object grDataRecViewGDS2_NAME: TcxGridDBBandedColumn
          Caption = #1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'GDS2_ID'
          PropertiesClassName = 'TcxLookupComboBoxProperties'
          Properties.ClearKey = 46
          Properties.DropDownRows = 20
          Properties.KeyFieldNames = 'id'
          Properties.ListColumns = <
            item
              FieldName = 'name'
            end>
          Properties.ListOptions.GridLines = glNone
          Properties.ListOptions.ShowHeader = False
          Properties.ListSource = Gds2DataSource
          Width = 121
          Position.BandIndex = 2
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object grDataRecViewGDS2_QTY: TcxGridDBBandedColumn
          Caption = #1082#1086#1083'-'#1074#1086
          DataBinding.FieldName = 'GDS2_QTY'
          Position.BandIndex = 2
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
      end
      object grDataRecLevel1: TcxGridLevel
        GridView = grDataRecView
      end
    end
  end
  inherited ActionList: TActionList
    Left = 434
    Top = 56
  end
  object HeadDataSource: TDataSource
    Left = 32
    Top = 72
  end
  object RecDataSource: TDataSource
    Left = 32
    Top = 100
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 32
    Top = 128
    PixelsPerInch = 96
    object cxStyleInfoBk: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
    end
  end
  object Gds2DataSource: TDataSource
    Left = 60
    Top = 100
  end
end
