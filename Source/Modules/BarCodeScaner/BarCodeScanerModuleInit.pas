unit BarCodeScanerModuleInit;

interface

uses classes, CoreClasses, BarCodeScanerController;


type
  TBarCodeScanerModuleInit = class(TModule)
  public
    procedure Load; override;
  end;

implementation



{ TBarCodeScanerModuleInit }

procedure TBarCodeScanerModuleInit.Load;
begin
  WorkItem.WorkItems.Add(TBarCodeScanerController)
end;

initialization
  RegisterModule(TBarCodeScanerModuleInit);
end.
