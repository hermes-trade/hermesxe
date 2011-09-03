unit SalTaskItemPresenterDlv;

interface
uses classes, CoreClasses, CustomTaskItemPresenter, ShellIntf, CommonViewIntf,
  Variants, BPMConst, BPMConstExt, EntityServiceIntf;

type
  TSalTaskItemPresenterDlv = class(TCustomTaskItemPresenter)
  private

  protected

    procedure OnViewReady; override;
    function GetEntityDataViewName: string; override;
    function GetEntityDataRecViewName: string; override;
    function GetEntityLinksViewName: string; override;
  end;

implementation

{ TSalTaskItemPresenterDlv }

function TSalTaskItemPresenterDlv.GetEntityDataRecViewName: string;
begin
  Result := ENT_BPM_TASK_VIEW_DATA_REC_SAL;
end;

function TSalTaskItemPresenterDlv.GetEntityDataViewName: string;
begin
  Result := ENT_BPM_TASK_VIEW_DATA_SAL;
end;

function TSalTaskItemPresenterDlv.GetEntityLinksViewName: string;
begin
  Result := ENT_BPM_TASK_VIEW_LINKS_SAL;
end;


procedure TSalTaskItemPresenterDlv.OnViewReady;
begin
  inherited;
end;
end.
