unit BPMModuleInit;

interface
uses classes, CoreClasses, BPMConst, BPMController, ShellIntf,
  Graphics, NavBarServiceIntf, ViewServiceIntf;

const
  NAVBAR_IMAGE_RES_NAME = 'BPM_NAVBAR_IMAGE';

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
