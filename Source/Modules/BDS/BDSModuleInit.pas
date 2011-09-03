unit BDSModuleInit;

interface
uses classes, CoreClasses, CustomModule,ShellIntf,
  ViewServiceIntf, BDSController, Graphics;


type
  TBDSModule = class(TCustomModule)
  protected
    procedure OnLoaded; override;
  end;

implementation


function GetModuleActivatorClass: TClass;
begin
  Result := TBDSModule;
end;

function GetModuleKind: TModuleKind;
begin
  Result := mkExtension;
end;


{ TBDSModule }

procedure TBDSModule.OnLoaded;
begin
  InstantiateController(TBDSController);
end;

initialization
  RegisterEmbededModule(GetModuleActivatorClass, GetModuleKind);
  
end.
