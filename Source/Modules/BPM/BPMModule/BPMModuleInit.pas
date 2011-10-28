unit BPMModuleInit;

interface
uses classes, CoreClasses, BPMConst, BPMController, ShellIntf;

type
  TBPMModule = class(TModule)
  public
    procedure Load; override;
  end;

implementation
{$R BPM.res}

{ TBPMModule }

procedure TBPMModule.Load;
begin
  WorkItem.WorkItems.Add(TBPMController);
end;

initialization
  RegisterModule(TBPMModule);

end.
