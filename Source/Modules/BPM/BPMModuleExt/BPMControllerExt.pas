unit BPMControllerExt;

interface
uses classes, CoreClasses, CustomUIController, BPMConst, BPMConstExt, ShellIntf,
  ViewServiceIntf, CommonViewIntf, EntityCatalogIntf,
  ActivityServiceIntf, Variants,
  GenericTaskListView, GenericTaskItemView,
  SalTaskListPresenterWh, SalTaskItemPresenterWh,
  SalTaskListPresenterCert, SalTaskItemPresenterCert,
  SalTaskListPresenterDlv, SalTaskItemPresenterDlv,
  SalTaskDeskPresenterWh, SalTaskDeskViewWh,
  SalTaskBulkItemPresenter, SalTaskBulkItemView;

type
  TTaskBulkJournalExtension = class(TViewExtension, IExtensionCommand)
  private
    function View: IEntityJournalView;
    procedure CmdPrintBulkCollect(Sender: TObject);
    procedure CmdPrintCollectTask(Sender: TObject);
    procedure CmdNew(Sender: TObject);
    procedure CmdOpen(Sender: TObject);
  protected
    procedure CommandExtend;
    procedure CommandUpdate;
  end;

  TBPMControllerExt = class(TCustomUIController)
  protected
    procedure OnInitialize; override;
  end;


implementation

{ TBPMControllerExt }



procedure TBPMControllerExt.OnInitialize;
begin
  RegisterExtension(VIEW_BPM_TASK_BULK_SALE_COLLECT_JRN, TTaskBulkJournalExtension);

  RegisterActivity(VIEW_BPM_TASK_DESK_SAL_WH,
    ACT_CTG_JOURNALS, ACT_GROUP_BPM_TASKS, ACT_BPM_TASK_DESK_SAL_WH_CAPTION,
    TSalTaskDeskPresenterWh, TfrSalTaskDeskViewWh);

  RegisterView(VIEW_BPM_TASK_BULK_SALE_COLLECT_ITEM, TTaskBulkItemPresenter,
    TfrTaskBulkItemView);

  RegisterActivity(VIEW_BPM_TASK_LIST_SAL_CERT,
    ACT_CTG_JOURNALS, ACT_GROUP_BPM_TASKS, ACT_BPM_TASK_LIST_SAL_CERT_CAPTION,
    TSalTaskListPresenterCert, TfrGenericTaskListView);

  RegisterActivity(VIEW_BPM_TASK_LIST_SAL_WH,
    ACT_CTG_JOURNALS, ACT_GROUP_BPM_TASKS, ACT_BPM_TASK_LIST_SAL_WH_CAPTION,
    TSalTaskListPresenterWh, TfrGenericTaskListView);

  RegisterActivity(VIEW_BPM_TASK_LIST_SAL_DLV,
    ACT_CTG_JOURNALS, ACT_GROUP_BPM_TASKS, ACT_BPM_TASK_LIST_SAL_DLV_CAPTION,
    TSalTaskListPresenterDlv, TfrGenericTaskListView);

  RegisterView(VIEW_BPM_TASK_ITEM_SAL_DLV, TSalTaskItemPresenterCert, TfrGenericTaskItemView);
  RegisterView(VIEW_BPM_TASK_ITEM_SAL_CERT, TSalTaskItemPresenterCert, TfrGenericTaskItemView);
  RegisterView(VIEW_BPM_TASK_ITEM_SAL_WH, TSalTaskItemPresenterWh, TfrGenericTaskItemView);

  BPMConst.RegisterTaskItemView(BPM_ACTIVITY_CODE_SAL_DLV, VIEW_BPM_TASK_ITEM_SAL_DLV);
  BPMConst.RegisterTaskItemView(BPM_ACTIVITY_CODE_SAL_CERT, VIEW_BPM_TASK_ITEM_SAL_CERT);
  BPMConst.RegisterTaskItemView(BPM_ACTIVITY_CODE_SAL_WH2, VIEW_BPM_TASK_ITEM_SAL_WH);
  BPMConst.RegisterTaskItemView(BPM_ACTIVITY_CODE_SAL_WH3, VIEW_BPM_TASK_ITEM_SAL_WH);
  BPMConst.RegisterTaskItemView(BPM_ACTIVITY_CODE_SAL_WH7, VIEW_BPM_TASK_ITEM_SAL_WH);


end;

{ TTaskBulkJournalExtension }

procedure TTaskBulkJournalExtension.CmdNew(Sender: TObject);
begin
  try
    App.Entities['BPM_TASKBULK'].GetOper('Create', WorkItem).Execute([]);
  finally
    WorkItem.Commands[COMMAND_RELOAD].Execute;
  end;
end;

procedure TTaskBulkJournalExtension.CmdOpen(Sender: TObject);
var
  action: IAction;
begin
  if VarIsEmpty(WorkItem.State['ITEM_ID']) then Exit;
  action := WorkItem.Actions[VIEW_BPM_TASK_BULK_SALE_COLLECT_ITEM];
  (action.Data as TTaskBulkItemData).ID := WorkItem.State['ITEM_ID'];
  action.Execute(WorkItem);
end;

procedure TTaskBulkJournalExtension.CmdPrintBulkCollect(Sender: TObject);
begin
  App.Reports[COMMAND_PRINT_BULKCOLLECT].Params['ID'] := WorkItem.State['ITEM_ID'];
  App.Reports[COMMAND_PRINT_BULKCOLLECT].Execute(WorkItem);
end;

procedure TTaskBulkJournalExtension.CmdPrintCollectTask(Sender: TObject);
begin

end;

procedure TTaskBulkJournalExtension.CommandExtend;
begin
  WorkItem.Commands[COMMAND_NEW].SetHandler(CmdNew);
  WorkItem.Commands[COMMAND_OPEN].SetHandler(CmdOpen);

  WorkItem.Commands[COMMAND_PRINT_BULKCOLLECT].Caption := 'Задачи по участкам';
  WorkItem.Commands[COMMAND_PRINT_BULKCOLLECT].SetHandler(CmdPrintBulkCollect);
  View.CommandBar.AddCommand(COMMAND_PRINT_BULKCOLLECT, 'Печать', true);

  WorkItem.Commands[COMMAND_PRINT_COLLECTTASK].Caption := 'Комплектовочные листы';
  WorkItem.Commands[COMMAND_PRINT_COLLECTTASK].SetHandler(CmdPrintCollectTask);
  View.CommandBar.AddCommand(COMMAND_PRINT_COLLECTTASK, 'Печать');
end;

procedure TTaskBulkJournalExtension.CommandUpdate;
begin
  WorkItem.Commands[COMMAND_DELETE].Status := csDisabled;
  WorkItem.Commands[COMMAND_OPEN].Status := csDisabled;
  WorkItem.Commands[COMMAND_NEW].Status := csDisabled;
  WorkItem.Commands[COMMAND_STATE_CHANGE_NEXT].Status := csDisabled;
  WorkItem.Commands[COMMAND_STATE_CHANGE_PREV].Status := csDisabled;

  if View.Tabs.Active = 0 then
    WorkItem.Commands[COMMAND_NEW].Status := csEnabled;

  if (View.Tabs.Active = 0) and (View.Selection.Count > 0) then
    WorkItem.Commands[COMMAND_DELETE].Status := csEnabled;

  if View.Selection.Count > 0 then
    WorkItem.Commands[COMMAND_OPEN].Status := csEnabled;

  if (View.Tabs.Active < (View.Tabs.Count - 1)) and (View.Selection.Count > 0) then
    WorkItem.Commands[COMMAND_STATE_CHANGE_NEXT].Status := csEnabled;

end;

function TTaskBulkJournalExtension.View: IEntityJournalView;
begin
  Result := GetView as IEntityJournalView;
end;

end.
