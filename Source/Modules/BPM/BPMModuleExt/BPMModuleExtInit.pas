unit BPMModuleExtInit;

interface
uses classes, CoreClasses, BPMConst, BPMConstExt, ShellIntf,
  ViewServiceIntf, BPMControllerExt;

type
  TBPMModuleExt = class(TModule)
  public
    procedure Load; override;
  end;

implementation


{ TBPMModuleExt }

procedure TBPMModuleExt.Load;
begin
  WorkItem.WorkItems.Add(TBPMControllerExt);
end;

initialization
  RegisterModule(TBPMModuleExt);

end.
