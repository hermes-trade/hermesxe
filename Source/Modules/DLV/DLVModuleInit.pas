unit DLVModuleInit;

interface
uses classes, CoreClasses, ShellIntf, UIClasses, DLVDeskpPresenter, DLVDeskpView;


type
  TDLVModule = class(TModule)
  const
    VIEW_DESKP = 'views.DLV_DESKP.';
  public
    procedure Load; override;
  end;

implementation

{ TDLVModule }

procedure TDLVModule.Load;
begin
  WorkItem.Activities[VIEW_DESKP].
    RegisterHandler(TViewActivityHandler.Create(TDLVDeskpPresenter, TfrDLVDeskpView));

end;

initialization
  RegisterModule(TDLVModule);

end.
