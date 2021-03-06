unit DLVDeskpView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomView, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, ActnList, cxGroupBox,
  DLVDeskpPresenter, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  DB, cxDBData, cxSplitter, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Menus,
  StdCtrls, cxButtons, cxLabel, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxPCdxBarPopupMenu, cxPC, UIClasses;

type
  TfrDLVDeskpView = class(TfrCustomView, IDLVTripDeskView)
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
    tcTasks: TcxTabControl;
    grTasks: TcxGrid;
    grTasksView: TcxGridDBTableView;
    cxGridLevel2: TcxGridLevel;
    dsTasks: TDataSource;
    dsTripTasks: TDataSource;
    edDate: TcxDateEdit;
    procedure btDateIncClick(Sender: TObject);
    procedure btDateDecClick(Sender: TObject);
    procedure grTripsViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure tcTasksChange(Sender: TObject);
    procedure grTasksViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure grTripTasksViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure grTripsViewEditChanged(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem);
    procedure edDatePropertiesEditValueChanged(Sender: TObject);
  private

  protected
    //IDLVTripDeskView
    procedure SetDate(AValue: TDateTime);
    function GetTasksKind: integer;
    function SelectedTrips: ISelection;
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


procedure TfrDLVDeskpView.edDatePropertiesEditValueChanged(Sender: TObject);
begin
  WorkItem.Commands[COMMAND_DATE_SET].Data['Date'] := edDate.Date;
  WorkItem.Commands[COMMAND_DATE_SET].Execute;
end;

function TfrDLVDeskpView.GetTasksKind: integer;
begin
  Result := tcTasks.TabIndex + 1;
end;

procedure TfrDLVDeskpView.grTasksViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  WorkItem.Commands[COMMAND_TASK_OPEN].Execute;
end;

procedure TfrDLVDeskpView.grTripsViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  WorkItem.Commands[COMMAND_TRIP_EDIT].Execute;
end;

procedure TfrDLVDeskpView.grTripsViewEditChanged(Sender: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem);
begin
  dsTrips.DataSet.Post;
end;

procedure TfrDLVDeskpView.grTripTasksViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  WorkItem.Commands[COMMAND_TRIP_TASK_OPEN].Execute;
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

function TfrDLVDeskpView.SelectedTrips: ISelection;
begin
  Result := GetChildInterface(grTripsView.Name) as ISelection;
end;

function TfrDLVDeskpView.SelectedTripTasks: ISelection;
begin
  Result := GetChildInterface(grTripTasksView.Name) as ISelection;
end;

procedure TfrDLVDeskpView.SetDate(AValue: TDateTime);
begin
//  lbDate.Caption := DateToStr(AValue);
//  edDate.Date := AValue;
  edDate.Properties.OnEditValueChanged := nil;
  edDate.Date := AValue;
  edDate.Properties.OnEditValueChanged := edDatePropertiesEditValueChanged;
end;

procedure TfrDLVDeskpView.tcTasksChange(Sender: TObject);
begin
  WorkItem.Commands[COMMAND_CHANGE_TASKS_KIND].Execute;
end;

end.
