program Hermes;

{$R *.dres}

uses
  Forms,
  midaslib,
  bfwApp,

{$DEFINE BFW_SERVEMODULE}
  bfwModules,


  ConfigServiceIntf,
  BDSModuleInit,
  BPMModuleInit,
  BPMModuleExtInit,
  BarCodeScanerModuleInit;

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
