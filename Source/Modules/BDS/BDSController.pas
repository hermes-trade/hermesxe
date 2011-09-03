unit BDSController;

interface
uses classes, CoreClasses, CustomUIController, ShellIntf,
  ActivityServiceIntf, Variants, ViewServiceIntf, CommonViewIntf,
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
begin
  //TopView
  WorkItem.Root.Actions[VIEW_ACNT_JRN + '.NavBar'].SetHandler(ActionAcntJrn);
  RegisterView(VIEW_ACNT_JRN, TAcntJournalPresenter, TfrAcntJournalView);

  RegisterView(VIEW_SALRET_DESK, TSalRetDeskPresenter, TfrSalRetDeskView);
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
