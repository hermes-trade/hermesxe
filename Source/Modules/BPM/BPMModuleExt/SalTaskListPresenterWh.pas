unit SalTaskListPresenterWh;

interface
uses CustomTaskListPresenter, classes, CoreClasses, ShellIntf, SysUtils, db,
  UIClasses, Variants, EntityServiceIntf, BPMConst, BPMConstExt;

const
  const_LaneID = 2;

  COMMAND_TASKBULK = '{ECACE9D4-18CB-432E-8CEA-42130136BBC7}';
  ENT_TASKBULK = 'BPM_TASKBULK';
  ENT_TASKBULK_OPER_CREATE_EMPTY = 'CreateEmpty';
  ENT_TASKBULK_OPER_DELETE = 'Delete';
  ENT_TASKBULK_OPER_TASK_ADD = 'TaskAdd';

type
  TSalTaskListPresenterWh = class(TCustomTaskListPresenter)
  private
    procedure CmdTaskBulk(Sender: TObject);
  protected
    procedure OnInit(Sender: IAction); override;
    procedure OnViewReady; override;
    procedure OnSelectionChanged; override;
    function GetLaneID: Variant; override;
    function GetEVListName: string; override;
  end;

implementation


{ TSalTaskListPresenterWh }

procedure TSalTaskListPresenterWh.CmdTaskBulk(Sender: TObject);
var
  I: integer;
  bulk_id: variant;
begin

  if not App.UI.MessageBox.ConfirmYesNo('Консолидировать выделенные задачи ?') then Exit;

  try
    bulk_id := App.Entities[ENT_TASKBULK].
        GetOper(ENT_TASKBULK_OPER_CREATE_EMPTY, WorkItem).Execute([])['ID'];
    try
      for I := 0 to View.Selection.Count - 1 do
        App.Entities[ENT_TASKBULK].
          GetOper(ENT_TASKBULK_OPER_TASK_ADD, WorkItem). Execute([bulk_id, View.Selection[I]]);
    except
      App.Entities[ENT_TASKBULK].
        GetOper(ENT_TASKBULK_OPER_DELETE, WorkItem).Execute([bulk_id]);
      raise;
    end
  finally
    TaskListReload;
  end;
end;

function TSalTaskListPresenterWh.GetEVListName: string;
begin
  Result := ENT_BPM_TASK_VIEW_LIST_SAL;
end;

function TSalTaskListPresenterWh.GetLaneID: Variant;
begin
  Result := const_LaneID;
end;

procedure TSalTaskListPresenterWh.OnInit(Sender: IAction);
begin
  inherited;
  ViewTitle := ACT_BPM_TASK_LIST_SAL_WH_CAPTION;
end;

procedure TSalTaskListPresenterWh.OnSelectionChanged;
begin
  SetCommandStatus(Command_TaskBulk,
    (View.Selection.Count <> 0) and (GetStateID in [TASK_STATE_NEW]) );
end;

procedure TSalTaskListPresenterWh.OnViewReady;
begin
  inherited;
  WorkItem.Commands[Command_TaskBulk].Caption := 'Консолидировать задачи';
  WorkItem.Commands[Command_TaskBulk].SetHandler(CmdTaskBulk);
  View.CommandBar.AddCommand(Command_TaskBulk, 'Другие действия');

  SetCommandStatus(Command_TaskBulk, false);
//    (View.Selection.Count <> 0) and (GetStateID in [TASK_STATE_NEW]) );
end;

end.
