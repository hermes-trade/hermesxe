unit BPMModuleInit;

interface
uses classes, CoreClasses, CustomModule, BPMConst, BPMController, ShellIntf,
  Graphics, NavBarServiceIntf, ViewServiceIntf;

const
  NAVBAR_IMAGE_RES_NAME = 'BPM_NAVBAR_IMAGE';

type
  TBPMModule = class(TCustomModule)
  protected
    procedure OnLoading; override;
    procedure OnLoaded; override;
  end;

implementation
{$R BPM.res}

function GetModuleActivatorClass: TClass;
begin
  Result := TBPMModule;
end;

function GetModuleKind: TModuleKind;
begin
  Result := mkExtension;
end;


{ TBPMModule }

procedure TBPMModule.OnLoaded;
begin

  InstantiateController(TBPMController);
end;

procedure TBPMModule.OnLoading;
{var
  Image: TBitMap;
  ImgRes: TResourceStream;
  ViewSvc: IViewManagerService;}
begin
{

  Image := TBitMap.Create;
  try
    ImgRes := TResourceStream.Create(HInstance, NAVBAR_IMAGE_RES_NAME, 'file');
    try
      Image.LoadFromStream(ImgRes);
    finally
      ImgRes.Free;
    end;

    App.NavBar.DefaultLayout.
      Categories[ACT_CTG_BPM_Caption].SetImage(Image);
  finally
    Image.Free;
  end;
 }


end;

initialization
  RegisterEmbededModule(GetModuleActivatorClass, GetModuleKind);

end.
