unit BPMController;

interface
uses classes, CoreClasses, BPMConst, ShellIntf, Variants, CustomTaskItemPresenter;

type
  TBPMController = class(TWorkItemController)
  protected
    procedure Initialize; override;
  type
    TTaskItemActivityHandler = class(TActivityHandler)
      procedure Execute(Sender: TWorkItem; Activity: IActivity); override;
    end;
  end;


implementation

{ TBPMController }

procedure TBPMController.Initialize;
begin
  WorkItem.Activities[ACT_BPM_TASK_ITEM_OPEN].
    RegisterHandler(TTaskItemActivityHandler.Create);
end;

{ TBPMController.TTaskItemActivityHandler }

procedure TBPMController.TTaskItemActivityHandler.Execute(Sender: TWorkItem;
  Activity: IActivity);
var
  _activityCode: string;
  _viewURI: string;
  _presenterID: string;
  taskID: Variant;
begin
  taskID := Activity.Params['ID'];

  _activityCode :=
    App.Entities.Entity[ENT_BPM_ACTIVITY].
      GetOper(ENT_BPM_ACTIVITY_OPER_GETBYTASK, Sender).Execute([taskID])['CODE'];

  _viewURI := GetTaskItemView(_activityCode);
  if _viewURI <> '' then
  begin
    _presenterID := _viewURI + VarToStr(taskID);
    with Sender.Activities[_viewURI] do
    begin
      Params['ID'] := taskID;
      Params['PresenterID'] := _presenterID;
      Execute(Sender);
    end;
  end;
end;

end.
