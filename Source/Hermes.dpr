program Hermes;

{$R *.dres}

uses
  Forms,
  midaslib,
  Addons in 'Shell\Addons.pas',
  ShellApp in 'Shell\ShellApp.pas';

{$R *.res}

begin
//  Application.Initialize;   for enabled applicaion options editor

//  Application.MainFormOnTaskbar := True;
  ShellApp.TShellApp.ShellInstantiate;
end.
