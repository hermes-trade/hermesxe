unit BPMConst;

interface
uses Classes, ShellIntf;

const

  ACT_CTG_JOURNALS = ShellIntf.MAIN_MENU_CATEGORY; //'Журналы и справочники';
  ACT_GROUP_DIRECTORIES = 'Справочники';
  ACT_GROUP_JOURNALS = 'Журналы';
  ACT_GROUP_OPERS = 'Операции';

//  ACT_CTG_BPM_CAPTION = 'Бизнес-процессы';

  ACT_GROUP_BPM_TASKS = 'Задачи';

  ACT_BPM_EXECUTOR_SELECT = 'views.BPM_EXECUTORS.PickList'; //'activities.bpm.executor.select';
  ACT_BPM_TASK_ITEM_OPEN = 'activities.bpm.task.item.open.';

//Entities
  GID_BPM_TASK = 'BPM_TASKS';
  GID_BPM_EXECUTOR = 'GLB_STAFF';

  ENT_BPM_TASK = 'BPM_Task';
  ENT_BPM_TASK_OPER_STATE_CHANGE = 'StateChange';
  ENT_BPM_TASK_OPER_EXECUTOR_ADD = 'ExecutorAdd';
  ENT_BPM_TASK_OPER_EXECUTOR_REMOVE = 'ExecutorRemove';
  ENT_BPM_TASK_OPER_REPORTS_GET = 'TaskReportsGet';
  ENT_BPM_TASK_OPER_UPDATE_PROCESS = 'UpdateProcess';
  ENT_BPM_TASK_OPER_STAGE_SET = 'StageSet';

  ENT_BPM_TASK_VIEW_ITEM = 'ItemDefault';
  ENT_BPM_TASK_VIEW_ITEM_ISSUE = 'ItemIssue';

  ENT_BPM_TASK_VIEW_EXECUTOR_SELECT = 'ExecutorSelect';
  ENT_BPM_TASK_VIEW_DATA = 'Data';
  ENT_BPM_TASK_VIEW_LINKS = 'Links';
  ENT_BPM_TASK_VIEW_UPDATES = 'Updates';
  ENT_BPM_TASK_VIEW_EXECUTORS = 'Executors';

  ENT_BPM_LANE = 'BPM_Lane';
  ENT_BPM_LANE_OPER_GET_CODE = 'GetCode';

  ENT_BPM_ACTIVITY = 'BPM_Activity';
  ENT_BPM_ACTIVITY_OPER_GETBYTASK = 'GetByTask';

  ENT_BPM_EXECUTOR = 'BPM_Executor';
  ENT_BPM_EXECUTOR_OPER_GET_BY_GID = 'GetByGID';
  
//

// TASK_STATES
  TASK_STATE_MONITOR = 0;
  TASK_STATE_NEW = 1;
  TASK_STATE_STARTED = 2;
  TASK_STATE_SUSPENDED = 3;
  TASK_STATE_FINISHED = 4;
  TASK_STATE_CANCELED = 5;

  TASK_USTATE_UNMODIFIED = 1;
  TASK_USTATE_MODIFIED = 2;

// TASK_KINDS
  TASK_KIND_NONE = 0;
  TASK_KIND_ORIG = 1;
  TASK_KIND_UPDATE = 2;
  TASK_KIND_SHIFT = 3;
  TASK_KIND_CANCEL = 4;

// VIEWS
  VIEW_BPM_EXECUTOR_SELECT = 'views.bpm.executor.select';

// OUT_KINDS
  OUT_KIND_REPORT_TASK = 3;

procedure RegisterTaskItemView(const BPMActivityCode, ViewURI: string);
function GetTaskItemView(const BPMActivityCode: string): string;

implementation

var
  ActivityCodeList: TStringList;
  ViewUriList: TStringList;

procedure RegisterTaskItemView(const BPMActivityCode, ViewURI: string);
var
  Idx: integer;
begin
  if not Assigned(ActivityCodeList) then
  begin
    ActivityCodeList := TStringList.Create;
    ViewUriList := TStringList.Create;
  end;

  idx := ActivityCodeList.IndexOf(BPMActivityCode);
  if idx = -1 then
  begin
    ActivityCodeList.Add(BPMActivityCode);
    ViewUriList.Add(ViewUri);
  end
  else
    ViewUriList[Idx] := ViewUri;
end;

function GetTaskItemView(const BPMActivityCode: string): string;
var
  Idx: integer;
begin
  if not Assigned(ActivityCodeList) then
  begin
    ActivityCodeList := TStringList.Create;
    ViewUriList := TStringList.Create;
  end;

  Idx := ActivityCodeList.IndexOf(BPMActivityCode);
  if Idx <> -1 then
    Result := ViewUriList[Idx]
  else
    Result := '';
end;

end.
