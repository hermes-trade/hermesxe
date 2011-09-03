inherited frGenericTaskListView: TfrGenericTaskListView
  Left = 592
  Top = 272
  Caption = 'frGenericTaskListView'
  ClientHeight = 560
  ClientWidth = 886
  PixelsPerInch = 96
  TextHeight = 13
  inherited ViewControl: TcxGroupBox
    Height = 560
    Width = 886
    inherited pnButtons: TcxGroupBox
      Width = 882
    end
    inherited pnFilter: TcxGroupBox
      Width = 882
    end
    inherited tcStates: TcxTabControl
      Width = 882
      Height = 476
      ClientRectBottom = 476
      ClientRectRight = 882
      inherited grMain: TcxGrid
        Width = 882
        Height = 476
        inherited grMainViewDef: TcxGridDBBandedTableView
          OnCustomDrawCell = grMainViewDefCustomDrawCell
          OptionsView.FixedBandSeparatorWidth = 0
          Bands = <
            item
              Caption = #1047#1072#1076#1072#1095#1072
              Options.HoldOwnColumnsOnly = True
              Width = 772
            end
            item
              Caption = #1054#1089#1085#1086#1074#1072#1085#1080#1077
              Width = 526
            end>
          object grMainViewDefTASK_KIND_ID: TcxGridDBBandedColumn
            Caption = #1058#1080#1087' ('#1082#1086#1076')'
            DataBinding.FieldName = 'TASK_KIND_ID'
            Visible = False
            Position.BandIndex = 0
            Position.ColIndex = 7
            Position.RowIndex = 0
          end
          object grMainViewDefTASK_KIND_NAME: TcxGridDBBandedColumn
            Caption = #1058#1080#1087
            DataBinding.FieldName = 'TASK_KIND_NAME'
            Width = 53
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object grMainViewDefTASK_ID: TcxGridDBBandedColumn
            Caption = #8470
            DataBinding.FieldName = 'TASK_ID'
            Width = 59
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object grMainViewDefTASK_DAT: TcxGridDBBandedColumn
            Caption = #1057#1088#1086#1082
            DataBinding.FieldName = 'TASK_DAT'
            Width = 90
            Position.BandIndex = 0
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object grMainViewDefEVENT_NAME: TcxGridDBBandedColumn
            Caption = #1057#1086#1073#1099#1090#1080#1077
            DataBinding.FieldName = 'EVENT_NAME'
            Width = 169
            Position.BandIndex = 0
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object grMainViewDefACTIVITY_NAME: TcxGridDBBandedColumn
            Caption = #1055#1088#1086#1094#1077#1089#1089
            DataBinding.FieldName = 'ACTIVITY_NAME'
            Width = 100
            Position.BandIndex = 0
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object grMainViewDefEXECUTOR_NAMES: TcxGridDBBandedColumn
            Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100
            DataBinding.FieldName = 'EXECUTOR_NAMES'
            Width = 98
            Position.BandIndex = 0
            Position.ColIndex = 9
            Position.RowIndex = 0
          end
          object grMainViewDefTASK_RESULT_NAME: TcxGridDBBandedColumn
            Caption = #1056#1077#1096#1077#1085#1080#1077
            DataBinding.FieldName = 'TASK_RESULT_NAME'
            Visible = False
            Width = 93
            Position.BandIndex = 0
            Position.ColIndex = 5
            Position.RowIndex = 0
          end
          object grMainViewDefTASK_USTATE_ID: TcxGridDBBandedColumn
            DataBinding.FieldName = 'TASK_USTATE_ID'
            Position.BandIndex = 0
            Position.ColIndex = 10
            Position.RowIndex = 0
          end
          object grMainViewDefTASK_NEXT_ID: TcxGridDBBandedColumn
            Caption = #8470' '#1089#1083#1077#1076'. '#1079#1072#1076#1072#1095#1080
            DataBinding.FieldName = 'TASK_NEXT_ID'
            Visible = False
            Width = 90
            Position.BandIndex = 0
            Position.ColIndex = 6
            Position.RowIndex = 0
          end
          object grMainViewDefTASK_PREV_ID: TcxGridDBBandedColumn
            Caption = #8470' '#1087#1088#1077#1076'. '#1079#1072#1076#1072#1095#1080
            DataBinding.FieldName = 'TASK_PREV_ID'
            Visible = False
            Position.BandIndex = 0
            Position.ColIndex = 8
            Position.RowIndex = 0
          end
          object grMainViewDefDATA_META_NAME: TcxGridDBBandedColumn
            Caption = #1058#1080#1087
            DataBinding.FieldName = 'DATA_META_NAME'
            Width = 144
            Position.BandIndex = 1
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object grMainViewDefDATA_NUM: TcxGridDBBandedColumn
            Caption = #8470
            DataBinding.FieldName = 'DATA_NUM'
            Width = 53
            Position.BandIndex = 1
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object grMainViewDefDATA_DAT: TcxGridDBBandedColumn
            Caption = #1044#1072#1090#1072
            DataBinding.FieldName = 'DATA_DAT'
            Width = 75
            Position.BandIndex = 1
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object grMainViewDefDATA_NAME: TcxGridDBBandedColumn
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            DataBinding.FieldName = 'DATA_NAME'
            Width = 254
            Position.BandIndex = 1
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
        end
      end
    end
  end
end
