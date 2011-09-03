unit CustomTaskItemView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxLookAndFeelPainters, Menus, DB, ActnList,
  cxPC, StdCtrls, cxButtons, cxControls, cxContainer, cxEdit, cxGroupBox,
  cxStyles, cxGraphics, cxInplaceContainer, cxVGrid, cxDBVGrid,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGrid, cxButtonEdit,
  cxSplitter, cxGridDBTableView, BPMConst, cxLookAndFeels, CustomTaskItemPresenter,
  CustomContentView;

type
  TfrCustomTaskItemView = class(TfrCustomContentView, ICustomTaskItemView)
    DataDataSource: TDataSource;
    LinksDataSource: TDataSource;
    DataRecDataSource: TDataSource;
    UpdatesDataSource: TDataSource;
    pcMain: TcxPageControl;
    tsMain: TcxTabSheet;
    grMain: TcxDBVerticalGrid;
    tsData: TcxTabSheet;
    grData: TcxDBVerticalGrid;
    grDataRec: TcxGrid;
    grDataRecViewDef: TcxGridDBTableView;
    grMainLevel1: TcxGridLevel;
    cxSplitter1: TcxSplitter;
    tsTaskLinks: TcxTabSheet;
    grLinks: TcxGrid;
    grLinksViewDef: TcxGridDBBandedTableView;
    grLinksViewDefButtonOpenTask: TcxGridDBBandedColumn;
    cxGridLevel1: TcxGridLevel;
    tsUpdates: TcxTabSheet;
    grUpdates: TcxGrid;
    grUpdatesViewDef: TcxGridDBBandedTableView;
    grUpdatesViewDefButtonProcess: TcxGridDBBandedColumn;
    grUpdatesLevel2: TcxGridLevel;
    MainDataSource: TDataSource;
    procedure grLinksViewDefButtonOpenTaskPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure grLinksViewDefCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure grUpdatesViewDefCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure grUpdatesViewDefButtonProcessPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
  private
  protected
    procedure OnLinkDataSet(const AName: string; ADataSet: TDataSet); override;
    procedure OnGetValue(const AName: string; var AValue: Variant); override;
    procedure OnInitialize; override;
    //
    procedure LinkData(Task, Data, DataRec, Links, Updates: TDataSet);
  public

  end;


implementation

{$R *.dfm}

procedure TfrCustomTaskItemView.OnLinkDataSet(const AName: string;
  ADataSet: TDataSet);
var
  I: integer;
begin
  inherited;

  for I := 0 to grLinksViewDef.ColumnCount - 1 do
    grLinksViewDef.Columns[I].Options.Editing := false;
  grLinksViewDefButtonOpenTask.Options.Editing := true;

  for I := 0 to grUpdatesViewDef.ColumnCount - 1 do
    grUpdatesViewDef.Columns[I].Options.Editing := false;
  grUpdatesViewDefButtonProcess.Options.Editing := true;
end;

procedure TfrCustomTaskItemView.grLinksViewDefButtonOpenTaskPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  if grLinksViewDef.Controller.SelectedRowCount > 0 then
    WorkItem.Commands[Command_OpenTaskLinked].Execute;
end;

procedure TfrCustomTaskItemView.OnGetValue(const AName: string;
  var AValue: Variant);
begin
  if AName = VAL_TASK_LINKED_SELECTED then
  begin
    if grLinksViewDef.Controller.SelectedRowCount > 0 then
      AValue := grLinksViewDef.Controller.SelectedRecords[0].
        Values[grLinksViewDef.GetColumnByFieldName(grLinksViewDef.DataController.KeyFieldNames).Index];
  end
  else if AName = VAL_TASK_UPDATE_SELECTED then
    if grUpdatesViewDef.Controller.SelectedRowCount > 0 then
      AValue := grUpdatesViewDef.Controller.SelectedRecords[0].
        Values[grUpdatesViewDef.GetColumnByFieldName(grUpdatesViewDef.DataController.KeyFieldNames).Index];

  inherited;
end;

procedure TfrCustomTaskItemView.grLinksViewDefCellDblClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  if grLinksViewDef.Controller.SelectedRowCount > 0 then
    WorkItem.Commands[Command_OpenTaskLinked].Execute;

end;

procedure TfrCustomTaskItemView.grUpdatesViewDefCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  _StateID: Variant;
begin

  _StateID :=
    AViewInfo.GridRecord.Values[grUpdatesViewDef.DataController.GetItemByFieldName('STATE_ID').Index];
  if (_StateID <> TASK_STATE_FINISHED)then
  begin
    ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];
  end;

end;

procedure TfrCustomTaskItemView.grUpdatesViewDefButtonProcessPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  if grUpdatesViewDef.Controller.SelectedRowCount > 0 then
    WorkItem.Commands[Command_ProcessTaskUpdate].Execute;
end;

procedure TfrCustomTaskItemView.OnInitialize;
begin


end;

procedure TfrCustomTaskItemView.LinkData(Task, Data, DataRec, Links,
  Updates: TDataSet);
begin
  LinkDataSet(MainDataSource, Task);
  LinkDataSet(DataDataSource, Data);
  LinkDataSet(DataRecDataSource, DataRec);
  LinkDataSet(LinksDataSource, Links);
  LinkDataSet(UpdatesDataSource, Updates);
end;

end.
