unit SalTaskItemPresenterCert;

interface
uses classes, CoreClasses, CustomTaskItemPresenter, ShellIntf, UIClasses,
  Variants, BPMConst, BPMConstExt, EntityServiceIntf;

type
  TSalTaskItemPresenterCert = class(TCustomTaskItemPresenter)
  private
  protected
   // procedure OnViewInitialize; override;
    procedure OnViewReady; override;
    function GetEntityDataViewName: string; override;
    function GetEntityDataRecViewName: string; override;
    function GetEntityLinksViewName: string; override;
  end;

implementation

{ TSalTaskItemPresenterCert }

function TSalTaskItemPresenterCert.GetEntityDataRecViewName: string;
begin
  Result := ENT_BPM_TASK_VIEW_DATA_REC_SAL;
end;

function TSalTaskItemPresenterCert.GetEntityDataViewName: string;
begin
  Result := ENT_BPM_TASK_VIEW_DATA_SAL;
end;

function TSalTaskItemPresenterCert.GetEntityLinksViewName: string;
begin
  Result := ENT_BPM_TASK_VIEW_LINKS_SAL;
end;

procedure TSalTaskItemPresenterCert.OnViewReady;
begin
  inherited;
end;

end.
