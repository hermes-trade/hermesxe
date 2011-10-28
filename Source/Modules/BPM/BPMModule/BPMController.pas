unit BPMController;

interface
uses classes, CoreClasses, CustomUIController, BPMConst, ShellIntf,
  ActivityServiceIntf,  Variants, CustomTaskItemPresenter;

type
  TBPMController = class(TCustomUIController)
  private
    //Actions
    procedure ActionTaskItemOpen(Sender: IAction);
  protected
    procedure OnInitialize; override;
  end;


implementation

{ TBPMController }


procedure TBPMController.ActionTaskItemOpen(Sender: IAction);
var
  _activityCode: string;
  _viewURI: string;
  _presenterID: string;
  action: IAction;
  taskID: Variant;
begin
  taskID := (Sender.Data as TTaskItemPresenterData).ID;

  _activityCode :=
    App.Entities.Entity[ENT_BPM_ACTIVITY].
      GetOper(ENT_BPM_ACTIVITY_OPER_GETBYTASK, WorkItem).Execute([taskID])['CODE'];

  _viewURI := GetTaskItemView(_activityCode);
  if _viewURI <> '' then
  begin
    _presenterID := _viewURI + VarToStr(taskID);
    action := WorkItem.Actions[_viewURI];
    (action.Data as TTaskItemPresenterData).ID := taskID;
    (action.Data as TTaskItemPresenterData).PresenterID := _presenterID;
    action.Execute(WorkItem);
  end;

end;

procedure TBPMController.OnInitialize;
begin
  (WorkItem.Services[IActivityService] as IActivityService).
    RegisterActivityInfo(ACT_BPM_TASK_ITEM_OPEN);
  WorkItem.Root.Actions[ACT_BPM_TASK_ITEM_OPEN].SetHandler(ActionTaskItemOpen);
  WorkItem.Root.Actions[ACT_BPM_TASK_ITEM_OPEN].SetDataClass(TTaskItemPresenterData);
end;

end.
