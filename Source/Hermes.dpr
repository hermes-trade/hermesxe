program Hermes;



{$R *.dres}

uses
  Forms,
  midaslib,
  bfwApp,
  bfwModules,
  BDSModuleInit,
  DLVModuleInit,
  BPMModuleInit,
  BPMModuleExtInit;

{$R *.res}

type
  THermesApp = class(TApp)
  end;

begin
 // Application.Initialize;  // for enabled applicaion options editor

//  Application.MainFormOnTaskbar := True;

  THermesApp.AppInstance.Run;

end.
