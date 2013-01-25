unit GenericTaskListView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomTaskListView, cxLookAndFeelPainters, Menus, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, ActnList, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxGrid, cxPC, StdCtrls, cxButtons, cxContainer,
  cxGroupBox, CustomView, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxLabel,  BPMConst, cxVGrid,
  cxInplaceContainer, cxCheckBox, cxLookAndFeels, cxPCdxBarPopupMenu;


type
  TfrGenericTaskListView = class(TfrCustomTaskListView)
    grMainViewDefTASK_ID: TcxGridDBBandedColumn;
    grMainViewDefACTIVITY_NAME: TcxGridDBBandedColumn;
    grMainViewDefTASK_KIND_NAME: TcxGridDBBandedColumn;
    grMainViewDefTASK_DAT: TcxGridDBBandedColumn;
    grMainViewDefTASK_RESULT_NAME: TcxGridDBBandedColumn;
    grMainViewDefDATA_META_NAME: TcxGridDBBandedColumn;
    grMainViewDefDATA_NUM: TcxGridDBBandedColumn;
    grMainViewDefDATA_DAT: TcxGridDBBandedColumn;
    grMainViewDefDATA_NAME: TcxGridDBBandedColumn;
    grMainViewDefEVENT_NAME: TcxGridDBBandedColumn;
    grMainViewDefTASK_NEXT_ID: TcxGridDBBandedColumn;
    grMainViewDefTASK_KIND_ID: TcxGridDBBandedColumn;
    grMainViewDefTASK_PREV_ID: TcxGridDBBandedColumn;
    grMainViewDefEXECUTOR_NAMES: TcxGridDBBandedColumn;
    grMainViewDefTASK_USTATE_ID: TcxGridDBBandedColumn;
    procedure grMainViewDefCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}



procedure TfrGenericTaskListView.grMainViewDefCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  _UStateID: integer;
begin
  _UStateID := AViewInfo.GridRecord.Values[grMainViewDefTASK_USTATE_ID.Index];
  if (_UStateID = TASK_USTATE_MODIFIED)then
    ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];


{  if (tcState.TabIndex = 1) not AViewInfo.GridRecord.Focused then
  begin
    try
      _dataDate := AViewInfo.GridRecord.Values[grMainViewDefDATA_DAT.Index];
    except
      _dataDate := Date;
    end;

    if _dataDate > Date then
      ACanvas.Brush.Color := clInfoBk;
  end;}
end;

end.
