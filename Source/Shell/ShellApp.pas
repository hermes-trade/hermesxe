unit ShellApp;

interface
uses CoreClasses, bfwShellApp, ConfigServiceIntf, classes;

type
  TShellApp = class(TApp)
  protected
    procedure AddServices; override;
  end;

implementation

{ TShellApp }

procedure TShellApp.AddServices;
begin
  ConfigServiceIntf.LOCAL_APP_DATA_KEY := 'Hermes\HermesTrade';
  inherited;
end;

end.
