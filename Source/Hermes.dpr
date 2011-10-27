program Hermes;

{$R *.dres}

uses
  Forms,
  midaslib,
  bfwApp,
  bfwModules,
  ConfigServiceIntf,
  BDSModuleInit,
  BPMModuleInit,
  BPMModuleExtInit;

{$R *.res}

type
  THermesApp = class(TApp)
  protected
    procedure AddServices; override;
  end;

{ THermesApp }

procedure THermesApp.AddServices;
begin
  ConfigServiceIntf.LOCAL_APP_DATA_KEY := 'Hermes\HermesTrade';
  inherited;
end;

begin
//  Application.Initialize;   for enabled applicaion options editor

//  Application.MainFormOnTaskbar := True;
  THermesApp.ShellInstantiate;
end.
