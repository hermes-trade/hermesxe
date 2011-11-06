program Hermes;

{$R *.dres}

uses
  Forms,
  midaslib,
  bfwApp,
  bfwModules,
  ConfigServiceIntf;
{  BarCodeScanerModuleInit,
  BDSModuleInit,
  BPMModuleInit,
  BPMModuleExtInit;
 }
{$R *.res}

type
  THermesApp = class(TApp)
  end;

begin
//  Application.Initialize;   for enabled applicaion options editor

//  Application.MainFormOnTaskbar := True;
  ConfigServiceIntf.LOCAL_APP_DATA_KEY := 'Hermes\HermesTrade';
  THermesApp.ShellInstantiate;
end.
