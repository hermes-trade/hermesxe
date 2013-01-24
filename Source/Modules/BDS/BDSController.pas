unit BDSController;

interface
uses classes, CoreClasses, ShellIntf, Variants, UIClasses,
  db, sysutils, controls,
  AcntJournalPresenter, AcntJournalView,
  SalRetDeskPresenter, SalRetDeskView;


type

  TBDSController = class(TWorkItemController)
  protected
    procedure Initialize; override;
  type
    TAcntJrnNavBarActivityHandler = class(TActivityHandler)
    public
      procedure Execute(Sender: TWorkItem; Activity: IActivity); override;
    end;
  end;

implementation



{ TBDSController }

procedure TBDSController.Initialize;
begin

  WorkItem.Activities[VIEW_ACNT_JRN + '.NavBar'].
    RegisterHandler(TAcntJrnNavBarActivityHandler.Create);

  WorkItem.Activities[VIEW_ACNT_JRN].
    RegisterHandler(TViewActivityHandler.Create(TAcntJournalPresenter, TfrAcntJournalView));

  WorkItem.Activities['views.BDS_SALRET.Desk'].
    RegisterHandler(TViewActivityHandler.Create(TSalRetDeskPresenter, TfrSalRetDeskView));
end;



{ TBDSController.TAcntJrnNavBarActivityHandler }

procedure TBDSController.TAcntJrnNavBarActivityHandler.Execute(
  Sender: TWorkItem; Activity: IActivity);
const
  ACTION_ACNT_PICKLIST = 'views.BDS_ACNT.PickList';
begin
  with Sender.Activities[ACTION_ACNT_PICKLIST] do
  begin
    Execute(Sender);
    if  Outs[TViewActivityOuts.ModalResult] <> mrOk then Exit;

    with Sender.Activities[VIEW_ACNT_JRN] do
    begin
      Params[TAcntJournalPresenter.TAcntJrnActivityParams.ACNT_ID] :=
        Sender.Activities[ACTION_ACNT_PICKLIST].Outs['ID'];
      Execute(Sender);
    end;
  end;
end;

end.
