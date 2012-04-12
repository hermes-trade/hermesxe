unit SalTaskDeskPresenterWh;

interface
uses classes, sysutils, CoreClasses, CustomTaskItemPresenter, ShellIntf, UIClasses,
  Variants, BPMConst, BPMConstExt, EntityServiceIntf, CustomContentPresenter,
  db;

const
  ET_BARSCAN_BARCODE = 'events://barscan.barcode';
  ENT_INF_GID = 'INF_GID';
  ENT_INF_GID_OPER_DECODE = 'Decode';

  strTaskNotFound = 'Задача не найдена';

  constTask_Activity_Sal = 'Sal.Wh2';
  constTask_Stage_Issue = 'SAL.COMPLECT.2';

  Command_LoadTask = '{8CE37725-5DAA-4961-A948-549AB10AC9A7}';
  Command_AddExecutor = '{B4CA9A5C-0D4D-4DC6-B211-243A3BB32ABB}';
  Command_RemoveExecutor = '{447A5CCA-86A2-4EA3-8054-2A1607F4DC47}';
  Command_StageSet = '{E9028666-E870-425A-A2FA-1763C9667F26}';

type
  ISalTaskDeskViewWh = interface
  ['{BB183E3A-E771-4DDD-93D5-F9673F84CF66}']
    procedure SetTaskDataSet(ADataSet: TDataSet);
    procedure SetTaskExecutorsDataSet(ADataSet: TDataSet);
    procedure SetExecutorsDataSet(ADataSet: TDataSet);
  end;

  TSalTaskDeskPresenterWh = class(TCustomContentPresenter)
  private
    FTaskLoaded: boolean;
    FTaskID: Variant;
    function GetEVExecutors: IEntityView;
    function GetEVTaskExecutors: IEntityView;
    function GetEVTask: IEntityView;
    function GetTaskExecutor: Variant;
    function GetExecutor: Variant;
    procedure CmdLoadTask(Sender: TObject);
    procedure CmdAddExecutor(Sender: TObject);
    procedure CmdRemoveExecutor(Sender: TObject);
    procedure CmdStageSet(Sender: TObject);
    procedure BarCodeHandler(EventData: Variant);
    procedure ViewActivateHandler;
    procedure ViewDeactivateHandler;
  protected
    procedure OnViewReady; override;
  end;

implementation

{ TSalTaskDeskPresenterWh }

procedure TSalTaskDeskPresenterWh.BarCodeHandler(EventData: Variant);
var
  _barcode: string;
  gid_tablename: string;
  gid_data: integer;
  gidDataSet: TDataSet;
  executorID: Variant;
begin
  _barcode := EventData;
  if length(_barcode) <> 13 then exit;
  gidDataSet :=
    App.Entities[ENT_INF_GID].GetOper(ENT_INF_GID_OPER_DECODE, WorkItem).Execute([_barcode]);
  gid_tablename := gidDataSet['TABLENAME'];
  gid_data := gidDataSet['DATA'];

  if gid_tablename = GID_BPM_TASK then
  begin
    GetView.Value['TASK_ID'] := gid_data;
    WorkItem.Commands[Command_LoadTask].Execute;
  end
  else if (gid_tablename = GID_BPM_EXECUTOR) and FTaskLoaded then
  begin
    executorID :=
      App.Entities[ENT_BPM_EXECUTOR].
        GetOper(ENT_BPM_EXECUTOR_OPER_GET_BY_GID, WorkItem).Execute([_barcode])['ID'];

    App.Entities[ENT_BPM_TASK].
      GetOper(ENT_BPM_TASK_OPER_EXECUTOR_ADD, WorkItem).
         Execute([FTaskID, executorID]);
    GetEVTaskExecutors.Load;
  end;

end;

procedure TSalTaskDeskPresenterWh.CmdAddExecutor(Sender: TObject);
begin
  if FTaskLoaded and (not VarIsEmpty(GetExecutor)) then
  begin
    App.Entities[ENT_BPM_TASK].
      GetOper(ENT_BPM_TASK_OPER_EXECUTOR_ADD, WorkItem).
         Execute([FTaskID, GetExecutor]);
    GetEVTaskExecutors.Load;
  end;        
end;

procedure TSalTaskDeskPresenterWh.CmdLoadTask(Sender: TObject);
var
  vTaskID: Variant;
begin
  //if FTaskLoaded then
  //  if not App.MessageBox.ConfirmYesNo('Предыдущая задача не выдана! Загрузить новую задачу ?') then Exit;

  SetCommandStatus(Command_StageSet, false);
  SetCommandStatus(Command_AddExecutor, false);
  SetCommandStatus(Command_RemoveExecutor, false);

  vTaskID := GetView.Value['TASK_ID'];
  if Trim(VarToStr(vTaskID)) = '' then
  begin
    GetEVTask.Load([null]);
    GetEVTaskExecutors.Load([null]);
  end
  else
  begin
    GetEVTask.Load([vTaskID]);
    if not GetEVTask.DataSet.IsEmpty then
    begin
      FTaskID := GetEVTask.DataSet['TASK_ID'];
      FTaskLoaded := true;
      GetEVTaskExecutors.Load([FTaskID]);
      SetCommandStatus(Command_StageSet, true);
      SetCommandStatus(Command_AddExecutor, true);
      SetCommandStatus(Command_RemoveExecutor, true);
    end
    else
    begin
      FTaskID := Unassigned;
      GetEVTaskExecutors.Load([null]);
      if Trim(VarToStr(vTaskID)) <> '' then
        App.UI.MessageBox.ErrorMessage(strTaskNotFound);
    end
  end
end;

procedure TSalTaskDeskPresenterWh.CmdRemoveExecutor(Sender: TObject);
begin
  if FTaskLoaded and (not VarIsEmpty(GetTaskExecutor)) and
     App.UI.MessageBox.ConfirmYesNo('Исключить исполнителя?')  then
  begin
    App.Entities[ENT_BPM_TASK].
      GetOper(ENT_BPM_TASK_OPER_EXECUTOR_REMOVE, WorkItem).
         Execute([FTaskID, GetTaskExecutor]);
    GetEVTaskExecutors.Load;
  end;
end;

procedure TSalTaskDeskPresenterWh.CmdStageSet(Sender: TObject);
begin
  App.Entities[ENT_BPM_TASK].GetOper(ENT_BPM_TASK_OPER_STAGE_SET, WorkItem).
    Execute([FTaskID, constTask_Stage_Issue]);
  GetView.Value['TASK_ID'] := '';
  GetEVTask.Load([null]);
  GetEVTaskExecutors.Load([null]);
  FTaskLoaded := false;
  SetCommandStatus(Command_StageSet, false);
  SetCommandStatus(Command_AddExecutor, false);
  SetCommandStatus(Command_RemoveExecutor, false);  
end;

function TSalTaskDeskPresenterWh.GetEVExecutors: IEntityView;
begin
  Result := GetEView(ENT_BPM_TASK, ENT_BPM_TASK_VIEW_EXECUTOR_SELECT, []);
end;

function TSalTaskDeskPresenterWh.GetEVTask: IEntityView;
begin
  Result := App.Entities[ENT_BPM_TASK].
    GetView(ENT_BPM_TASK_VIEW_ITEM_ISSUE, WorkItem);
end;

function TSalTaskDeskPresenterWh.GetEVTaskExecutors: IEntityView;
begin
  Result := App.Entities[ENT_BPM_TASK].
    GetView(ENT_BPM_TASK_VIEW_EXECUTORS, WorkItem);
end;


function TSalTaskDeskPresenterWh.GetExecutor: Variant;
begin
  Result := GetView.Value['EXECUTOR_ID'];
end;

function TSalTaskDeskPresenterWh.GetTaskExecutor: Variant;
begin
  Result := GetView.Value['TASK_EXECUTOR_ID'];
end;

procedure TSalTaskDeskPresenterWh.OnViewReady;
begin
  ViewTitle := ACT_BPM_TASK_DESK_SAL_WH_CAPTION;
  FTaskID := Unassigned;
  FTaskLoaded := false;

  WorkItem.Commands[COMMAND_CLOSE].SetHandler(CmdClose);
  WorkItem.Commands[Command_LoadTask].SetHandler(CmdLoadTask);
  WorkItem.Commands[Command_AddExecutor].SetHandler(CmdAddExecutor);
  WorkItem.Commands[Command_RemoveExecutor].SetHandler(CmdRemoveExecutor);
  WorkItem.Commands[Command_StageSet].SetHandler(CmdStageSet);

  SetCommandStatus(Command_StageSet, false);
  SetCommandStatus(Command_AddExecutor, false);
  SetCommandStatus(Command_RemoveExecutor, false);

  (GetView as ISalTaskDeskViewWh).SetExecutorsDataSet(GetEVExecutors.DataSet);
  GetEVTask.Load([null]);
  (GetView as ISalTaskDeskViewWh).SetTaskDataSet(GetEVTask.DataSet);
  GetEVTaskExecutors.Load([null]);
  (GetView as ISalTaskDeskViewWh).SetTaskExecutorsDataSet(GetEVTaskExecutors.DataSet);

  GetView.SetActivateHandler(ViewActivateHandler);
  GetView.SetDeactivateHandler(ViewDeactivateHandler);


end;

procedure TSalTaskDeskPresenterWh.ViewActivateHandler;
begin
  WorkItem.Root.EventTopics[ET_BARSCAN_BARCODE].AddSubscription(Self, BarCodeHandler);
end;

procedure TSalTaskDeskPresenterWh.ViewDeactivateHandler;
begin
  WorkItem.Root.EventTopics[ET_BARSCAN_BARCODE].RemoveSubscription(Self, BarCodeHandler);
end;

end.
