unit SalTaskItemPresenterWh;

interface
uses classes, CoreClasses, CustomTaskItemPresenter, ShellIntf, CommonViewIntf,
  Variants, BPMConst, BPMConstExt, EntityServiceIntf;

type
  TSalTaskItemPresenterWh = class(TCustomTaskItemPresenter)
  private

  protected

    procedure OnViewReady; override;
    function GetEntityDataViewName: string; override;
    function GetEntityDataRecViewName: string; override;
    function GetEntityLinksViewName: string; override;
  end;

implementation

{ TSalTaskItemPresenterWh }

function TSalTaskItemPresenterWh.GetEntityDataRecViewName: string;
begin
  Result := ENT_BPM_TASK_VIEW_DATA_REC_SAL;
end;

function TSalTaskItemPresenterWh.GetEntityDataViewName: string;
begin
  Result := ENT_BPM_TASK_VIEW_DATA_SAL;
end;

function TSalTaskItemPresenterWh.GetEntityLinksViewName: string;
begin
  Result := ENT_BPM_TASK_VIEW_LINKS_SAL;
end;


procedure TSalTaskItemPresenterWh.OnViewReady;
begin
  inherited;
end;

end.
