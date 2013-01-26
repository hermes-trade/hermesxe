inherited frDLVDeskpView: TfrDLVDeskpView
  Caption = 'frDLVDeskpView'
  ClientHeight = 633
  ClientWidth = 924
  ExplicitWidth = 930
  ExplicitHeight = 661
  PixelsPerInch = 96
  TextHeight = 13
  inherited ViewControl: TcxGroupBox
    ExplicitWidth = 924
    ExplicitHeight = 633
    Height = 633
    Width = 924
    inherited pnButtons: TcxGroupBox
      ExplicitWidth = 924
      Width = 924
      object cxGroupBox3: TcxGroupBox
        Left = 712
        Top = 2
        Align = alRight
        PanelStyle.Active = True
        Style.BorderStyle = ebsNone
        Style.LookAndFeel.Kind = lfOffice11
        Style.TransparentBorder = False
        StyleDisabled.LookAndFeel.Kind = lfOffice11
        StyleFocused.LookAndFeel.Kind = lfOffice11
        StyleHot.LookAndFeel.Kind = lfOffice11
        TabOrder = 0
        Transparent = True
        Height = 36
        Width = 210
        object btDateInc: TcxButton
          Left = 162
          Top = 0
          Width = 48
          Height = 36
          Align = alRight
          Caption = '>>'
          LookAndFeel.Kind = lfOffice11
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 0
          OnClick = btDateIncClick
        end
        object btDateDec: TcxButton
          Left = 0
          Top = 0
          Width = 48
          Height = 36
          Align = alLeft
          Caption = '<<'
          LookAndFeel.Kind = lfOffice11
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 1
          OnClick = btDateDecClick
        end
        object edDate: TcxDateEdit
          AlignWithMargins = True
          Left = 51
          Top = 3
          TabStop = False
          Align = alClient
          ParentFont = False
          Properties.Alignment.Horz = taCenter
          Properties.Alignment.Vert = taVCenter
          Properties.AutoSelect = False
          Properties.DateButtons = [btnToday]
          Properties.DateOnError = deToday
          Properties.PostPopupValueOnTab = True
          Properties.ReadOnly = False
          Properties.UseLeftAlignmentOnEditing = False
          Properties.OnEditValueChanged = edDatePropertiesEditValueChanged
          Style.BorderStyle = ebsNone
          Style.Font.Charset = DEFAULT_CHARSET
          Style.Font.Color = clWindowText
          Style.Font.Height = -13
          Style.Font.Name = 'MS Sans Serif'
          Style.Font.Style = [fsBold]
          Style.LookAndFeel.Kind = lfOffice11
          Style.TransparentBorder = False
          Style.IsFontAssigned = True
          StyleDisabled.LookAndFeel.Kind = lfOffice11
          StyleFocused.LookAndFeel.Kind = lfOffice11
          StyleHot.LookAndFeel.Kind = lfOffice11
          TabOrder = 2
          ExplicitHeight = 21
          Width = 108
        end
      end
    end
    object cxSplitter1: TcxSplitter
      Left = 433
      Top = 40
      Width = 8
      Height = 593
      Control = cxGroupBox2
    end
    object cxGroupBox1: TcxGroupBox
      Left = 441
      Top = 40
      Align = alClient
      PanelStyle.Active = True
      Style.BorderStyle = ebsNone
      Style.LookAndFeel.Kind = lfOffice11
      Style.TextStyle = [fsBold]
      Style.TransparentBorder = False
      StyleDisabled.LookAndFeel.Kind = lfOffice11
      StyleFocused.LookAndFeel.Kind = lfOffice11
      StyleHot.LookAndFeel.Kind = lfOffice11
      TabOrder = 2
      Transparent = True
      Height = 593
      Width = 483
      object grTripTasks: TcxGrid
        Left = 0
        Top = 320
        Width = 483
        Height = 273
        Align = alBottom
        TabOrder = 0
        LookAndFeel.Kind = lfOffice11
        object grTripTasksView: TcxGridDBTableView
          OnCellDblClick = grTripTasksViewCellDblClick
          DataController.DataSource = dsTripTasks
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.PullFocusing = True
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.MultiSelect = True
          OptionsSelection.UnselectFocusedRecordOnExit = False
          OptionsView.GroupByBox = False
        end
        object cxGridLevel1: TcxGridLevel
          GridView = grTripTasksView
        end
      end
      object cxSplitter2: TcxSplitter
        Left = 0
        Top = 312
        Width = 483
        Height = 8
        AlignSplitter = salBottom
        Control = grTripTasks
      end
      object tcTasks: TcxTabControl
        Left = 0
        Top = 0
        Width = 483
        Height = 312
        Align = alClient
        TabOrder = 2
        Properties.TabIndex = 0
        Properties.Tabs.Strings = (
          #1044#1086#1089#1090#1072#1074#1082#1072
          #1042#1086#1079#1074#1088#1072#1090#1099
          #1055#1086#1089#1090#1072#1074#1082#1080)
        LookAndFeel.Kind = lfOffice11
        LookAndFeel.NativeStyle = False
        OnChange = tcTasksChange
        ClientRectBottom = 312
        ClientRectRight = 483
        ClientRectTop = 24
        object grTasks: TcxGrid
          Left = 0
          Top = 24
          Width = 483
          Height = 288
          Align = alClient
          TabOrder = 0
          LookAndFeel.Kind = lfOffice11
          object grTasksView: TcxGridDBTableView
            FilterBox.Position = fpTop
            OnCellDblClick = grTasksViewCellDblClick
            DataController.DataSource = dsTasks
            DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.PullFocusing = True
            OptionsCustomize.ColumnsQuickCustomization = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.MultiSelect = True
            OptionsSelection.UnselectFocusedRecordOnExit = False
            OptionsView.GroupByBox = False
          end
          object cxGridLevel2: TcxGridLevel
            Caption = #1044#1086#1089#1090#1072#1074#1082#1072
            GridView = grTasksView
          end
        end
      end
    end
    object cxGroupBox2: TcxGroupBox
      Left = 0
      Top = 40
      Align = alLeft
      PanelStyle.Active = True
      PanelStyle.OfficeBackgroundKind = pobkStyleColor
      Style.BorderStyle = ebsNone
      Style.Edges = [bLeft, bTop, bRight, bBottom]
      Style.LookAndFeel.Kind = lfOffice11
      Style.LookAndFeel.NativeStyle = True
      Style.TextStyle = [fsBold]
      Style.TransparentBorder = False
      StyleDisabled.LookAndFeel.Kind = lfOffice11
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.Kind = lfOffice11
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.Kind = lfOffice11
      StyleHot.LookAndFeel.NativeStyle = True
      TabOrder = 3
      Transparent = True
      Height = 593
      Width = 433
      object grTrips: TcxGrid
        Left = 0
        Top = 0
        Width = 433
        Height = 593
        Align = alClient
        TabOrder = 0
        LookAndFeel.Kind = lfOffice11
        object grTripsView: TcxGridDBTableView
          OnCellDblClick = grTripsViewCellDblClick
          OnEditChanged = grTripsViewEditChanged
          DataController.DataSource = dsTrips
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
        end
        object grTripsLevel1: TcxGridLevel
          GridView = grTripsView
        end
      end
    end
  end
  inherited ActionList: TActionList
    Left = 182
    Top = 206
  end
  object dsTrips: TDataSource
    Left = 64
    Top = 184
  end
  object dsTasks: TDataSource
    Left = 752
    Top = 184
  end
  object dsTripTasks: TDataSource
    Left = 664
    Top = 416
  end
end
