unit DLVDeskpView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomContentView, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, ActnList, cxGroupBox,
  DLVDeskpPresenter, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  DB, cxDBData, cxSplitter, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Menus,
  StdCtrls, cxButtons, cxLabel, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxPCdxBarPopupMenu, cxPC, UIClasses;

type
  TfrDLVDeskpView = class(TfrCustomContentView, IDLVTripDeskView)
    cxSplitter1: TcxSplitter;
    dsTrips: TDataSource;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    grTrips: TcxGrid;
    grTripsView: TcxGridDBTableView;
    grTripsLevel1: TcxGridLevel;
    grTripTasks: TcxGrid;
    grTripTasksView: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxSplitter2: TcxSplitter;
    cxGroupBox3: TcxGroupBox;
    btDateInc: TcxButton;
    btDateDec: TcxButton;
    lbDate: TcxLabel;
    tcTasks: TcxTabControl;
    grTasks: TcxGrid;
    grTasksView: TcxGridDBTableView;
    cxGridLevel2: TcxGridLevel;
    dsTasks: TDataSource;
    dsTripTasks: TDataSource;
    procedure btDateIncClick(Sender: TObject);
    procedure btDateDecClick(Sender: TObject);
    procedure grTripsViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure tcTasksChange(Sender: TObject);
    procedure grTripsViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure grTasksViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure grTripTasksViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private

  protected
    //IDLVTripDeskView
    procedure SetDate(AValue: TDateTime);
    function GetTasksKind: integer;
    function GetActiveTrip: variant;
    function SelectedTasks: ISelection;
    function SelectedTripTasks: ISelection;
    procedure LinkData(Trips, Tasks, TripTasks: TDataSet);
  public
    { Public declarations }
  end;

var
  frDLVDeskpView: TfrDLVDeskpView;

implementation

{$R *.dfm}

{ TfrDLVTripDeskView }


procedure TfrDLVDeskpView.btDateDecClick(Sender: TObject);
begin
  WorkItem.Commands[COMMAND_DATE_DEC].Execute;
end;

procedure TfrDLVDeskpView.btDateIncClick(Sender: TObject);
begin
  WorkItem.Commands[COMMAND_DATE_INC].Execute;
end;

function TfrDLVDeskpView.GetActiveTrip: variant;
begin
  Result := Unassigned;

  if (grTripsView.ItemCount > 0) and (grTripsView.Controller.SelectedRowCount > 0) then
    Result := grTripsView.Controller.SelectedRecords[0].Values[0];
end;

function TfrDLVDeskpView.GetTasksKind: integer;
begin
  Result := tcTasks.TabIndex + 1;
end;

procedure TfrDLVDeskpView.grTasksViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  WorkItem.Commands[COMMAND_TASK_ADD].Execute;
end;

procedure TfrDLVDeskpView.grTripsViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  WorkItem.Commands[COMMAND_TRIP_EDIT].Execute;
end;

procedure TfrDLVDeskpView.grTripsViewFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  WorkItem.Commands[COMMAND_ACTIVE_TRIP_CHANGED].Execute;
end;

procedure TfrDLVDeskpView.grTripTasksViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  WorkItem.Commands[COMMAND_TASK_REMOVE].Execute;
end;

procedure TfrDLVDeskpView.LinkData(Trips, Tasks, TripTasks: TDataSet);
begin
  LinkDataSet(dsTrips, Trips);
  LinkDataSet(dsTasks, Tasks);
  LinkDataSet(dsTripTasks, TripTasks);
end;

function TfrDLVDeskpView.SelectedTasks: ISelection;
begin
  Result := GetChildInterface(grTasksView.Name) as ISelection;
end;

function TfrDLVDeskpView.SelectedTripTasks: ISelection;
begin
  Result := GetChildInterface(grTripTasksView.Name) as ISelection;
end;

procedure TfrDLVDeskpView.SetDate(AValue: TDateTime);
begin
  lbDate.Caption := DateToStr(AValue);
end;

procedure TfrDLVDeskpView.tcTasksChange(Sender: TObject);
begin
  WorkItem.Commands[COMMAND_CHANGE_TASKS_KIND].Execute;
end;

end.
