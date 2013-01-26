unit SalTaskDeskViewWh;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxLookAndFeelPainters, ActnList, cxPC,
  cxControls, cxContainer, cxEdit, cxGroupBox, CustomView, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxGrid,
  cxSplitter, Menus, StdCtrls, cxButtons, cxGridDBTableView,
  cxInplaceContainer, cxVGrid, cxDBVGrid, ExtCtrls, cxTextEdit, cxMaskEdit,
  cxButtonEdit, UIClasses, cxLookAndFeels, cxLabel,
  SalTaskDeskPresenterWh;



type
  TfrSalTaskDeskViewWh = class(TfrCustomView, ISalTaskDeskViewWh)
    acAddExecutor: TAction;
    acRemoveExecutor: TAction;
    acAddTask: TAction;
    acRemoveTask: TAction;
    acTaskIssue: TAction;
    cxGroupBox3: TcxGroupBox;
    grExecutors: TcxGrid;
    grExecutorsViewDef: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxSplitter1: TcxSplitter;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox6: TcxGroupBox;
    grData: TcxDBVerticalGrid;
    cxSplitter2: TcxSplitter;
    cxGroupBox4: TcxGroupBox;
    grTaskExecutors: TcxGrid;
    grTaskExecutorsLevel1: TcxGridLevel;
    grTaskExecutorsViewDef: TcxGridDBTableView;
    ExecutorsDataSource: TDataSource;
    TaskExecutorsDataSource: TDataSource;
    TaskDataSource: TDataSource;
    btAddExecutor: TcxButton;
    btRemoveExecutor: TcxButton;
    cxButton6: TcxButton;
    cxLabel1: TcxLabel;
    TASK_ID: TcxButtonEdit;
    cxButton1: TcxButton;
    acClose: TAction;
    procedure TASK_IDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure grExecutorsViewDefCellDblClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure grTaskExecutorsViewDefCellDblClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
  protected
    //
    procedure SetTaskID(const AText: string);
    function GetTaskID: string;
    function GetExecutorID: variant;
    function GetTaskExecutorID: variant;
    procedure SetTaskDataSet(ADataSet: TDataSet);
    procedure SetTaskExecutorsDataSet(ADataSet: TDataSet);
    procedure SetExecutorsDataSet(ADataSet: TDataSet);
    //
    procedure Initialize; override;

  end;


implementation

{$R *.dfm}


{ TfrSalTaskDeskViewWh }


procedure TfrSalTaskDeskViewWh.TASK_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  task_id.PostEditValue;
  WorkItem.Commands[Command_LoadTask].Execute;
end;


function TfrSalTaskDeskViewWh.GetExecutorID: variant;
begin
  if grExecutorsViewDef.Controller.SelectedRowCount > 0 then
    Result := grExecutorsViewDef.Controller.SelectedRecords[0].
      Values[grExecutorsViewDef.GetColumnByFieldName(grExecutorsViewDef.DataController.KeyFieldNames).Index];

end;

function TfrSalTaskDeskViewWh.GetTaskExecutorID: variant;
begin
  if grTaskExecutorsViewDef.Controller.SelectedRowCount > 0 then
    Result := grTaskExecutorsViewDef.Controller.SelectedRecords[0].
      Values[grTaskExecutorsViewDef.GetColumnByFieldName(grTaskExecutorsViewDef.DataController.KeyFieldNames).Index];
end;

function TfrSalTaskDeskViewWh.GetTaskID: string;
begin
  Result := TASK_ID.Text;
end;

procedure TfrSalTaskDeskViewWh.grExecutorsViewDefCellDblClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  acAddExecutor.Update;
  acAddExecutor.Execute;
end;

procedure TfrSalTaskDeskViewWh.grTaskExecutorsViewDefCellDblClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  acRemoveExecutor.Update;
  acRemoveExecutor.Execute;
end;

procedure TfrSalTaskDeskViewWh.SetExecutorsDataSet(ADataSet: TDataSet);
begin
  LinkDataSet(ExecutorsDataSource, ADataSet);
end;

procedure TfrSalTaskDeskViewWh.SetTaskDataSet(ADataSet: TDataSet);
begin
  LinkDataSet(TaskDataSource, ADataSet);
end;

procedure TfrSalTaskDeskViewWh.SetTaskExecutorsDataSet(ADataSet: TDataSet);
begin
  LinkDataSet(TaskExecutorsDataSource, ADataSet);
end;

procedure TfrSalTaskDeskViewWh.SetTaskID(const AText: string);
begin
  TASK_ID.Text := AText;
end;

procedure TfrSalTaskDeskViewWh.Initialize;
begin
  WorkItem.Commands[Command_CLOSE].AddInvoker(acClose);
  WorkItem.Commands[Command_AddExecutor].AddInvoker(acAddExecutor);
  WorkItem.Commands[Command_RemoveExecutor].AddInvoker(acRemoveExecutor);
  WorkItem.Commands[Command_StageSet].AddInvoker(acTaskIssue);
end;

end.
