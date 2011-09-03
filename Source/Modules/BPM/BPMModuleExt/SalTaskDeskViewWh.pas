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
  cxButtonEdit, CommonViewIntf, cxLookAndFeels, CustomContentView, cxLabel,
  SalTaskDeskPresenterWh;



type
  TfrSalTaskDeskViewWh = class(TfrCustomContentView, ISalTaskDeskViewWh)
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
    procedure OnGetValue(const AName: string; var AValue: Variant); override;
    //
    procedure SetTaskDataSet(ADataSet: TDataSet);
    procedure SetTaskExecutorsDataSet(ADataSet: TDataSet);
    procedure SetExecutorsDataSet(ADataSet: TDataSet);
    //
    procedure OnInitialize; override;

  end;


implementation

{$R *.dfm}


{ TfrSalTaskDeskViewWh }

procedure TfrSalTaskDeskViewWh.OnGetValue(const AName: string;
  var AValue: Variant);
begin
  if AName = 'TASK_EXECUTOR_ID' then
  begin
    if grTaskExecutorsViewDef.Controller.SelectedRowCount > 0 then
      AValue := grTaskExecutorsViewDef.Controller.SelectedRecords[0].
        Values[grTaskExecutorsViewDef.GetColumnByFieldName(grTaskExecutorsViewDef.DataController.KeyFieldNames).Index];
  end
  else if AName = 'EXECUTOR_ID' then
    if grExecutorsViewDef.Controller.SelectedRowCount > 0 then
      AValue := grExecutorsViewDef.Controller.SelectedRecords[0].
        Values[grExecutorsViewDef.GetColumnByFieldName(grExecutorsViewDef.DataController.KeyFieldNames).Index];

  inherited;

end;

procedure TfrSalTaskDeskViewWh.TASK_IDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  task_id.PostEditValue;
  WorkItem.Commands[Command_LoadTask].Execute;
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

procedure TfrSalTaskDeskViewWh.OnInitialize;
begin
  WorkItem.Commands[Command_CLOSE].AddInvoker(acClose);
  WorkItem.Commands[Command_AddExecutor].AddInvoker(acAddExecutor);
  WorkItem.Commands[Command_RemoveExecutor].AddInvoker(acRemoveExecutor);
  WorkItem.Commands[Command_StageSet].AddInvoker(acTaskIssue);
end;

end.
