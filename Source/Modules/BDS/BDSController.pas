unit BDSController;

interface
uses classes, CoreClasses, CustomUIController, ShellIntf,
  ActivityServiceIntf, Variants, CommonViewIntf,
  db, CommonUtils, sysutils, controls, EntityCatalogIntf,
  AcntJournalPresenter, AcntJournalView,
  SalRetDeskPresenter, SalRetDeskView;


type

  TBDSController = class(TCustomUIController)
  private
    procedure ActionAcntJrn(Sender: IAction);
  protected
    procedure OnInitialize; override;
  end;

implementation



{ TBDSController }

procedure TBDSController.OnInitialize;
var
  svc: IActivityService;
begin
  svc := WorkItem.Services[IActivityService] as IActivityService;

  WorkItem.Root.Actions[VIEW_ACNT_JRN + '.NavBar'].SetHandler(ActionAcntJrn);

  svc.RegisterActivityInfo(VIEW_ACNT_JRN);
  svc.RegisterActivityClass(TViewActivityBuilder.Create(WorkItem,
    VIEW_ACNT_JRN, TAcntJournalPresenter, TfrAcntJournalView));

  svc.RegisterActivityClass(TViewActivityBuilder.Create(WorkItem,
     'views.BDS_SALRET.Desk', TSalRetDeskPresenter, TfrSalRetDeskView));
end;


procedure TBDSController.ActionAcntJrn(Sender: IAction);
const
  ACTION_ACNT_PICKLIST = 'views.BDS_ACNT.PickList';
var
  actionGetAcnt: IAction;
  action: IAction;
  actionData: TTransAcntJrnData;
begin
  actionGetAcnt := WorkItem.Actions[ACTION_ACNT_PICKLIST];
  actionGetAcnt.Execute(WorkItem);
  if (actionGetAcnt.Data as TPresenterData).ModalResult <> mrOk then Exit;
  action := WorkItem.Actions[VIEW_ACNT_JRN];
  actionData := action.Data as TTransAcntJrnData;
  actionData.ACNT_ID := actionGetAcnt.Data['ID'];
  action.Execute(Sender.Caller);
end;


end.
