unit BPMControllerExt;

interface
uses classes, CoreClasses, BPMConst, BPMConstExt, ShellIntf, sysutils,
   UIClasses,  Variants,
  GenericTaskListView, GenericTaskItemView,
  SalTaskListPresenterWh, SalTaskItemPresenterWh,
  SalTaskListPresenterCert, SalTaskItemPresenterCert,
  SalTaskListPresenterDlv, SalTaskItemPresenterDlv,
  SalTaskDeskPresenterWh, SalTaskDeskViewWh;

type
  TBPMControllerExt = class(TWorkItemController)
  protected
    procedure Initialize; override;
  end;


implementation

{ TBPMControllerExt }

procedure TBPMControllerExt.Initialize;
begin
  WorkItem.Activities[VIEW_BPM_TASK_DESK_SAL_WH].
    RegisterHandler(TViewActivityHandler.Create(TSalTaskDeskPresenterWh, TfrSalTaskDeskViewWh));

  WorkItem.Activities[VIEW_BPM_TASK_LIST_SAL_CERT].
    RegisterHandler(TViewActivityHandler.Create(TSalTaskListPresenterCert, TfrGenericTaskListView));

  WorkItem.Activities[VIEW_BPM_TASK_LIST_SAL_WH].
    RegisterHandler(TViewActivityHandler.Create(TSalTaskListPresenterWh, TfrGenericTaskListView));

  WorkItem.Activities[VIEW_BPM_TASK_LIST_SAL_DLV].
    RegisterHandler(TViewActivityHandler.Create(TSalTaskListPresenterDlv, TfrGenericTaskListView));

  WorkItem.Activities[VIEW_BPM_TASK_ITEM_SAL_DLV].
    RegisterHandler(TViewActivityHandler.Create(TSalTaskItemPresenterCert, TfrGenericTaskItemView));

  WorkItem.Activities[VIEW_BPM_TASK_ITEM_SAL_CERT].
    RegisterHandler(TViewActivityHandler.Create(TSalTaskItemPresenterCert, TfrGenericTaskItemView));

  WorkItem.Activities[VIEW_BPM_TASK_ITEM_SAL_WH].
    RegisterHandler(TViewActivityHandler.Create(TSalTaskItemPresenterWh, TfrGenericTaskItemView));

  BPMConst.RegisterTaskItemView(BPM_ACTIVITY_CODE_SAL_DLV, VIEW_BPM_TASK_ITEM_SAL_DLV);
  BPMConst.RegisterTaskItemView(BPM_ACTIVITY_CODE_SAL_CERT, VIEW_BPM_TASK_ITEM_SAL_CERT);
  BPMConst.RegisterTaskItemView(BPM_ACTIVITY_CODE_SAL_WH2, VIEW_BPM_TASK_ITEM_SAL_WH);
  BPMConst.RegisterTaskItemView(BPM_ACTIVITY_CODE_SAL_WH3, VIEW_BPM_TASK_ITEM_SAL_WH);
  BPMConst.RegisterTaskItemView(BPM_ACTIVITY_CODE_SAL_WH7, VIEW_BPM_TASK_ITEM_SAL_WH);


end;

end.
