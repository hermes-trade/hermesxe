unit CustomTaskListPresenter;

interface
uses CustomContentPresenter, classes, CoreClasses, ShellIntf, SysUtils, db,
  UIClasses, Variants, EntityServiceIntf, BPMConst,
  Controls, CustomTaskItemPresenter, UIStr;

const
  Command_ChangeState_Auto = '{59D529B3-E650-46A8-9428-FB5487478232}';
  Command_ChangeState_Started = '{A4CD6372-01FA-4C7F-9246-44C31698F15F}';
  Command_ChangeState_Suspended = '{B9AE060C-AC0C-4055-A0E6-BF7D60428001}';
  Command_ChangeState_Finished = '{62B2471C-E306-4B35-A57E-488DFD31782B}';

  Command_PrintTask = '{98E71B26-DE68-47AE-A35E-C8F6B007CFCC}';
  Command_ExecutorSet = '{5BF195D4-8B8B-4301-A912-6189AB1AB520}';
  Command_ExecutorClear = '{4446F39E-1BA8-4653-810E-7DB876D72107}';

  COMMAND_DATERANGE_CHANGED = '{8D2EE4A0-A499-4B87-8E8F-48BC56D581B8}';

type
  TValueStatus = (vsEnabled, vsDisabled, vsUnavailable);

  ICustomTaskListView = interface(IContentView)
  ['{3258CF87-43D8-4150-BABC-FC093281D041}']
    procedure LinkData(AData: TDataSet);
    function Tabs: ITabs;
    function Selection: ISelection;
    function GetDBEG: variant;
    procedure SetDBEG(AValue: variant);
    property DBEG: variant read GetDBEG write SetDBEG;
    function GetDEND: variant;
    procedure SetDEND(AValue: variant);
    property DEND: variant read GetDEND write SetDEND;

    procedure SetDateStatus(AStatus: TValueStatus);
  end;

  TCustomTaskListPresenter = class(TCustomContentPresenter)
  private
    FLaneCode: string;
    FAutoPrintTask: boolean;
    procedure ViewSelectionChangedHandler;
    procedure ViewStateTabChangedHandler;

    procedure CmdReload(Sender: TObject);
    procedure CmdOpenTask(Sender: TObject);
    procedure CmdChangeState(Sender: TObject);
    procedure CmdPrintTask(Sender: TObject);
    procedure CmdExecutorSet(Sender: TObject);
    procedure CmdExecutorClear(Sender: TObject);
    procedure CmdDateRangeChanged(Sender: TObject);
  protected
    function OnGetWorkItemState(const AName: string; var Done: boolean): Variant; override;
    function GetSelectedIDList: Variant;
    function View: ICustomTaskListView;
    //Должно возвращать значение из БД (BPM_LANES.ID)
    function GetLaneID: Variant; virtual; abstract;

    //Возвращает значение из БД (BPM_LANES.CODE)
    function GetLaneCode: string;

    // ID отчета печатающегося по комманде "Печать задачи"
    // при необходимости переопределить
    // по умолчанию: 'reports.bpm.' + GetLaneCode + '.task';
    function GetTaskReportID: string; virtual;

    // наименование EntityView для списка задачь
    function GetEVListName: string; virtual;

    function GetStateID: Integer;
    function GetEVList: IEntityView;
    function GetUseDateRange: integer;
    function GetOnlyUpdated: integer;

    procedure TaskListReload;
    procedure TaskListPrint(AIDList: Variant; AutoPrint: boolean);

    procedure OnViewReady; override;
    procedure DoSelectionChanged;
    procedure OnSelectionChanged; virtual;
    procedure DoStateTabChanged;

    procedure OnAfterChangeState(OldState, NewState: Integer; ATaskIDList: Variant); virtual;
  end;

implementation


{ TCustomTaskListPresenter }



function TCustomTaskListPresenter.GetStateID: Integer;
begin
  case View.Tabs.Active of
    0: Result := TASK_STATE_MONITOR;
    1: Result := TASK_STATE_NEW;
    2: Result := TASK_STATE_STARTED;
    3: Result := TASK_STATE_SUSPENDED;
    4: Result := TASK_STATE_FINISHED;
    5: Result := TASK_STATE_CANCELED;
    else
      raise Exception.Create('Task''s state unknown');
  end;
end;

function TCustomTaskListPresenter.GetEVList: IEntityView;
begin
  Result := App.Entities[ENT_BPM_TASK].GetView(GetEVListName, WorkItem);
end;


procedure TCustomTaskListPresenter.OnViewReady;
begin

  FAutoPrintTask := true;

  View.Tabs.Add('Обновленные');
  View.Tabs.Add('Новые');
  View.Tabs.Add('Выполняются');
  View.Tabs.Add('Отложенные');
  View.Tabs.Add('Завершенные');
  View.Tabs.Add('Отмененные');
  View.Tabs.Active := 1;

  WorkItem.Commands[COMMAND_CLOSE].SetHandler(CmdClose);
  (GetView as IContentView).CommandBar.AddCommand(COMMAND_CLOSE,
    GetLocaleString(@COMMAND_CLOSE_CAPTION), COMMAND_CLOSE_SHORTCUT);

  WorkItem.Commands[COMMAND_RELOAD].SetHandler(CmdReload);
  (GetView as IContentView).CommandBar.AddCommand(COMMAND_RELOAD,
    GetLocaleString(@COMMAND_RELOAD_CAPTION), COMMAND_RELOAD_SHORTCUT);

  WorkItem.Commands[COMMAND_OPEN].SetHandler(CmdOpenTask);
  (GetView as IContentView).CommandBar.AddCommand(COMMAND_OPEN,
    GetLocaleString(@COMMAND_OPEN_CAPTION), COMMAND_OPEN_SHORTCUT);

  WorkItem.Commands[Command_ChangeState_Auto].SetHandler(CmdChangeState);
  (GetView as IContentView).CommandBar.AddCommand(Command_ChangeState_Auto,
    'Сменить состояние (авто)', '', 'Сменить состояние', true);

  WorkItem.Commands[Command_ChangeState_Started].SetHandler(CmdChangeState);
  (GetView as IContentView).CommandBar.AddCommand(Command_ChangeState_Started,
    'Сменить состояние (выполнение)', '', 'Сменить состояние');

  WorkItem.Commands[Command_ChangeState_Suspended].SetHandler(CmdChangeState);
  (GetView as IContentView).CommandBar.AddCommand(Command_ChangeState_Suspended,
    'Сменить состояние (отложить)', '', 'Сменить состояние');

  WorkItem.Commands[Command_ChangeState_Finished].SetHandler(CmdChangeState);
  (GetView as IContentView).CommandBar.AddCommand(Command_ChangeState_Finished,
    'Сменить состояние (завершить)', '', 'Сменить состояние');

  WorkItem.Commands[Command_PrintTask].SetHandler(CmdPrintTask);
  (GetView as IContentView).CommandBar.AddCommand(Command_PrintTask,
    'Печать задачи', '', 'Печать', true);

  WorkItem.Commands[Command_ExecutorSet].SetHandler(CmdExecutorSet);
  (GetView as IContentView).CommandBar.AddCommand(Command_ExecutorSet,
    'Назначить исполнителя', '', 'Другие действия');

  WorkItem.Commands[Command_ExecutorClear].SetHandler(CmdExecutorClear);
  (GetView as IContentView).CommandBar.AddCommand(Command_ExecutorClear,
    'Исключить исполнителя', '', 'Другие действия');


  View.DBEG := Date;
  View.DEND := Date;

  View.SetDateStatus(vsDisabled);

  WorkItem.Commands[COMMAND_DATERANGE_CHANGED].SetHandler(CmdDateRangeChanged);

 // View.LinkDataSet('Main', GetEVList.DataSet);
  (View as ICustomTaskListView).LinkData(GetEVList.DataSet);
  inherited;


  View.Selection.SetSelectionChangedHandler(ViewSelectionChangedHandler);
  View.Tabs.SetTabChangedHandler(ViewStateTabChangedHandler);
  
  ViewStateTabChangedHandler;
  ViewSelectionChangedHandler;
end;

procedure TCustomTaskListPresenter.TaskListReload;
begin
  GetEVList.Load([GetLaneID, GetStateID, View.DBEG, View.DEND, GetUseDateRange, GetOnlyUpdated]);
end;

procedure TCustomTaskListPresenter.DoSelectionChanged;
var
  IsSelected: boolean;
begin

  IsSelected := View.Selection.Count <> 0;

  SetCommandStatus(Command_ChangeState_Auto,
    IsSelected and
    (GetStateID in [TASK_STATE_NEW, TASK_STATE_STARTED, TASK_STATE_SUSPENDED]));

  SetCommandStatus(Command_ChangeState_Started,
    IsSelected and
    (GetStateID in [TASK_STATE_NEW, TASK_STATE_SUSPENDED]));

  SetCommandStatus(Command_ChangeState_Suspended,
    IsSelected and
    (GetStateID in [TASK_STATE_NEW, TASK_STATE_STARTED]));

  SetCommandStatus(Command_ChangeState_Finished,
    IsSelected and
    (GetStateID in [TASK_STATE_NEW, TASK_STATE_STARTED, TASK_STATE_SUSPENDED]));

  SetCommandStatus(Command_PrintTask,IsSelected);

  SetCommandStatus(Command_Open,IsSelected);

  SetCommandStatus(Command_ExecutorSet,IsSelected);

  SetCommandStatus(Command_ExecutorClear,IsSelected);
    
  OnSelectionChanged;


end;

procedure TCustomTaskListPresenter.CmdChangeState(Sender: TObject);
var
  cmd: ICommand;
  I: integer;
  NewStateID: integer;
  StateChanged: integer;
  IDList: Variant;
begin

  Sender.GetInterface(ICommand, cmd);
  if cmd.Name = command_ChangeState_Auto then
    NewStateID := -1
  else if cmd.Name = command_ChangeState_Started then
    NewStateID := TASK_STATE_STARTED
  else if cmd.Name = command_ChangeState_Suspended then
    NewStateID := TASK_STATE_SUSPENDED
  else if cmd.Name = command_ChangeState_Finished then
    NewStateID := TASK_STATE_FINISHED
  else
    NewStateID := -1;

  if not App.UI.MessageBox.ConfirmYesNo('Сменить текущее состояние ?') then Exit;

  try
    IDList := VarArrayCreate([0, View.Selection.Count - 1], varVariant);
    for I := 0 to View.Selection.Count - 1 do
    begin
      StateChanged := App.Entities[ENT_BPM_TASK].
        GetOper(ENT_BPM_TASK_OPER_STATE_CHANGE, WorkItem).
          Execute([View.Selection[I], NewStateID])['STATE_CHANGED'];
      if StateChanged = 1 then
        IDList[I] := View.Selection.Items[I];

    end;
  finally
    TaskListReload;
  end;

  OnAfterChangeState(GetStateID, NewStateID, IDList);
end;

procedure TCustomTaskListPresenter.DoStateTabChanged;
begin
  if GetUseDateRange = 1 then
    View.SetDateStatus(vsEnabled)
  else
    View.SetDateStatus(vsDisabled);

  inherited;

  TaskListReload;
end;


procedure TCustomTaskListPresenter.CmdPrintTask(Sender: TObject);
begin
  TaskListPrint(GetSelectedIDList, false);
end;

function TCustomTaskListPresenter.GetTaskReportID: string;
begin
  Result := 'reports.bpm.' + GetLaneCode + '.task';
end;

function TCustomTaskListPresenter.GetLaneCode: string;
begin
  if FLaneCode = '' then
    FLaneCode := App.Entities[ENT_BPM_LANE].
      GetOper(ENT_BPM_LANE_OPER_GET_CODE, WorkItem).
        Execute([GetLaneID])['CODE'];
  Result := FLaneCode;
end;

function TCustomTaskListPresenter.GetEVListName: string;
begin
  Result := 'ListDefault';
end;

procedure TCustomTaskListPresenter.CmdExecutorSet(Sender: TObject);
var
  I: integer;
begin
  with WorkItem.Activities[ACT_BPM_EXECUTOR_SELECT] do
  begin
    Execute(WorkItem);

    if Outs[TViewActivityOuts.ModalResult] = mrOk then
    begin
      for I := 0 to View.Selection.Count - 1 do
      begin
        App.Entities[ENT_BPM_TASK].
            GetOper(ENT_BPM_TASK_OPER_EXECUTOR_ADD, WorkItem).
              Execute([View.Selection[I], Outs['ID']]);
        GetEVList.ReloadRecord(View.Selection[I]);
      end;
    end;
  end;
end;

procedure TCustomTaskListPresenter.CmdOpenTask(Sender: TObject);
begin
   with WorkItem.Activities[ACT_BPM_TASK_ITEM_OPEN] do
   begin
     Params['ID'] := WorkItem.State['ID'];
     Execute(WorkItem);
   end;
end;

procedure TCustomTaskListPresenter.OnAfterChangeState(OldState, NewState: Integer;
  ATaskIDList: Variant);
begin
  if FAutoPrintTask and (OldState = TASK_STATE_NEW) and
    ((NewState = TASK_STATE_STARTED) or (NewState = -1))   then
    TaskListPrint(ATaskIDList, true);
end;

procedure TCustomTaskListPresenter.TaskListPrint(AIDList: Variant; AutoPrint: boolean);
const
  LAUNCH_MODE = 'LaunchMode';
  LAUNCH_MODE_PREVIEW = 1;
  LAUNCH_MODE_HOLD = 3;
var
  I: integer;
  _count: integer;
  _rptData: TDataSet;
  _rptID: string;
begin
  _count := VarArrayHighBound(AIDList, 1);

  for I := 0 to _count do
  begin
    _rptData := App.Entities.Entity[ENT_BPM_TASK].
      GetOper(ENT_BPM_TASK_OPER_REPORTS_GET, WorkItem).Execute([AIDList[I]]);

    while not _rptData.Eof do
    begin
      _rptID := _rptData['Report_ID'];
      WorkItem.Activities[_rptID].Params['ID'] := VarToStr(AIDList[I]);
      WorkItem.Activities[_rptID].Params['OutCode'] := _rptData['Out_Code'];
      WorkItem.Activities[_rptID].Params[LAUNCH_MODE] := LAUNCH_MODE_PREVIEW;

      if _count = 0 then
        WorkItem.Activities[_rptID].CallMode := acmSingle
        //WorkItem.Activities[_rptID].Params[LAUNCH_MODE] := LAUNCH_MODE_PREVIEW
      else if I = 0 then
        WorkItem.Activities[_rptID].CallMode := acmBatchFirst
        //WorkItem.Activities[_rptID].Params[LAUNCH_MODE] := LAUNCH_MODE_HOLD
      else if I = _count then
        WorkItem.Activities[_rptID].CallMode := acmBatchLast
        //WorkItem.Activities[_rptID].Params[LAUNCH_MODE] := LAUNCH_MODE_PREVIEW
      else
        WorkItem.Activities[_rptID].CallMode := acmBatchNext;
        //WorkItem.Activities[_rptID].Params[LAUNCH_MODE] := LAUNCH_MODE_HOLD;



      WorkItem.Activities[_rptID].Execute(WorkItem);
      _rptData.Next;
    end;

  end;
end;

function TCustomTaskListPresenter.GetUseDateRange: integer;
begin
  if GetStateID in [TASK_STATE_FINISHED, TASK_STATE_CANCELED] then
    Result := 1
  else
    Result := 0;
end;

function TCustomTaskListPresenter.GetOnlyUpdated: integer;
begin
  if GetStateID in [TASK_STATE_MONITOR] then
    Result := 1
  else
    Result := 0;

end;


procedure TCustomTaskListPresenter.CmdDateRangeChanged(Sender: TObject);
begin
  TaskListReload;
end;

procedure TCustomTaskListPresenter.CmdExecutorClear(Sender: TObject);
var
  I: integer;
begin
  for I := 0 to View.Selection.Count - 1 do
  begin
    App.Entities[ENT_BPM_TASK].
      GetOper(ENT_BPM_TASK_OPER_EXECUTOR_REMOVE, WorkItem).
         Execute([View.Selection[I], -1]);
    GetEVList.ReloadRecord(View.Selection[I]);
  end;
end;


function TCustomTaskListPresenter.View: ICustomTaskListView;
begin
  Result := GetView as ICustomTaskListView;
end;

procedure TCustomTaskListPresenter.ViewSelectionChangedHandler;
begin

  DoSelectionChanged;

end;

procedure TCustomTaskListPresenter.ViewStateTabChangedHandler;
begin

  DoStateTabChanged;

end;

function TCustomTaskListPresenter.GetSelectedIDList: Variant;
var
  I: integer;
begin
  if View.Selection.Count > 0 then
  begin
    Result := VarArrayCreate([0, View.Selection.Count - 1], varVariant);
    for I := 0 to View.Selection.Count - 1 do
      Result[I] := View.Selection.Items[I];
  end
  else
    Result := Unassigned;

end;

procedure TCustomTaskListPresenter.OnSelectionChanged;
begin

end;

procedure TCustomTaskListPresenter.CmdReload(Sender: TObject);
begin
  GetEVList.Load(true, '-');
end;

function TCustomTaskListPresenter.OnGetWorkItemState(
  const AName: string; var Done: boolean): Variant;
var
  I: integer;
begin
  Done := true;
  if SameText(AName, 'ID') then
    Result := View.Selection.First
  else if SameText(AName, 'IDList') then
  begin
    Result := '';
    for I := 0 to View.Selection.Count - 1 do
      if Result = '' then
        Result := VarToStr(View.Selection[I])
      else
        Result := Result + ';' + VarToStr(View.Selection[I]);
  end
  else if SameText(Result, 'IDList2') then
  begin
    Result := '';
    for I := 0 to View.Selection.Count - 1 do
      if Result = '' then
        Result := VarToStr(View.Selection[I])
      else
        Result := Result + ',' + VarToStr(View.Selection[I]);
  end
  else
  begin
    Done := false;
    Result := inherited OnGetWorkItemState(AName, Done);
  end;
end;

end.
