unit BPMModuleExtInit;

interface
uses classes, CoreClasses, CustomModule, BPMConst, BPMConstExt, ShellIntf,
  ViewServiceIntf, BPMControllerExt;

type
  TBPMModuleExt = class(TCustomModule)
  protected
    procedure OnLoading; override;
    procedure OnLoaded; override;
  end;

implementation

function GetModuleActivatorClass: TClass;
begin
  Result := TBPMModuleExt;
end;

function GetModuleKind: TModuleKind;
begin
  Result := mkExtension;
end;

{ TBPMModuleExt }

procedure TBPMModuleExt.OnLoaded;
begin
  InstantiateController(TBPMControllerExt);

end;

procedure TBPMModuleExt.OnLoading;
begin

end;

initialization
  RegisterEmbededModule(GetModuleActivatorClass, GetModuleKind);

end.
