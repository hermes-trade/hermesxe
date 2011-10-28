unit BDSModuleInit;

interface
uses classes, CoreClasses, ShellIntf,
  BDSController, Graphics;


type
  TBDSModule = class(TModule)
  public
    procedure Load; override;
  end;

implementation

{ TBDSModule }

procedure TBDSModule.Load;
begin
  WorkItem.WorkItems.Add(TBDSController);
end;

initialization
  RegisterModule(TBDSModule);
  
end.
