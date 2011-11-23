unit BPMControllerExt;

interface
uses classes, CoreClasses, BPMConst, BPMConstExt, ShellIntf, sysutils,
   UIClasses,  Variants,
  GenericTaskListView, GenericTaskItemView,
  SalTaskListPresenterWh, SalTaskItemPresenterWh,
  SalTaskListPresenterCert, SalTaskItemPresenterCert,
  SalTaskListPresenterDlv, SalTaskItemPresenterDlv,
  SalTaskDeskPresenterWh, SalTaskDeskViewWh,
  SalTaskBulkItemPresenter, SalTaskBulkItemView;

type
  TTaskBulkJournalExtension = class(TViewExtension, IExtensionCommand)
  private
    procedure CmdPrintBulkCollect(Sender: TObject);
    procedure CmdPrintCollectTask(Sender: TObject);
    procedure CmdNew(Sender: TObject);
    procedure CmdOpen(Sender: TObject);
  protected
    procedure CommandExtend;
    procedure CommandUpdate;
  public
    class function CheckView(AView: IView): boolean; override;
  end;

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

  WorkItem.Activities[VIEW_BPM_TASK_BULK_SALE_COLLECT_ITEM].
    RegisterHandler(TViewActivityHandler.Create(TTaskBulkItemPresenter, TfrTaskBulkItemView));

  //(WorkItem.Services[IViewManagerService] as IViewManagerService).
    RegisterViewExtension({VIEW_BPM_TASK_BULK_SALE_COLLECT_JRN,} TTaskBulkJournalExtension);

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

{ TTaskBulkJournalExtension }

class function TTaskBulkJournalExtension.CheckView(AView: IView): boolean;
begin
  Result := SameText(VIEW_BPM_TASK_BULK_SALE_COLLECT_JRN, AView.ViewURI);

end;

procedure TTaskBulkJournalExtension.CmdNew(Sender: TObject);
begin
  try
    App.Entities['BPM_TASKBULK'].GetOper('Create', WorkItem).Execute([]);
  finally
    WorkItem.Commands[COMMAND_RELOAD].Execute;
  end;
end;

procedure TTaskBulkJournalExtension.CmdOpen(Sender: TObject);
begin
  if VarIsEmpty(WorkItem.State['ITEM_ID']) then Exit;
  with WorkItem.Activities[VIEW_BPM_TASK_BULK_SALE_COLLECT_ITEM] do
  begin
    Params['ID'] := WorkItem.State['ITEM_ID'];
    Execute(WorkItem);
  end;
end;

procedure TTaskBulkJournalExtension.CmdPrintBulkCollect(Sender: TObject);
begin
//  App.Reports[COMMAND_PRINT_BULKCOLLECT].Params['ID'] := WorkItem.State['ITEM_ID'];
//  App.Reports[COMMAND_PRINT_BULKCOLLECT].Execute(WorkItem);
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
 // View.CommandBar.AddCommand(COMMAND_PRINT_BULKCOLLECT, 'Печать', true);

  WorkItem.Commands[COMMAND_PRINT_COLLECTTASK].Caption := 'Комплектовочные листы';
  WorkItem.Commands[COMMAND_PRINT_COLLECTTASK].SetHandler(CmdPrintCollectTask);
 // View.CommandBar.AddCommand(COMMAND_PRINT_COLLECTTASK, 'Печать');
end;

procedure TTaskBulkJournalExtension.CommandUpdate;
begin
  WorkItem.Commands[COMMAND_DELETE].Status := csDisabled;
  WorkItem.Commands[COMMAND_OPEN].Status := csDisabled;
  WorkItem.Commands[COMMAND_NEW].Status := csDisabled;
  WorkItem.Commands[COMMAND_STATE_CHANGE_NEXT].Status := csDisabled;
  WorkItem.Commands[COMMAND_STATE_CHANGE_PREV].Status := csDisabled;
{
  if View.Tabs.Active = 0 then
    WorkItem.Commands[COMMAND_NEW].Status := csEnabled;

  if (View.Tabs.Active = 0) and (View.Selection.Count > 0) then
    WorkItem.Commands[COMMAND_DELETE].Status := csEnabled;

  if View.Selection.Count > 0 then
    WorkItem.Commands[COMMAND_OPEN].Status := csEnabled;

  if (View.Tabs.Active < (View.Tabs.Count - 1)) and (View.Selection.Count > 0) then
    WorkItem.Commands[COMMAND_STATE_CHANGE_NEXT].Status := csEnabled;
 }
end;


end.
