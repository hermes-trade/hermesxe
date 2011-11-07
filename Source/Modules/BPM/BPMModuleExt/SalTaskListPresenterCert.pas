unit SalTaskListPresenterCert;

interface
uses CustomTaskListPresenter, classes, CoreClasses, ShellIntf, SysUtils, db,
  UIClasses, Variants, EntityServiceIntf, BPMConst, BPMConstExt;

const
  const_LaneID = 104;

type
  TSalTaskListPresenterCert = class(TCustomTaskListPresenter)
  private
  protected
    procedure OnInit(Sender: IActivity); override;
    function GetLaneID: Variant; override;
    function GetEVListName: string; override;
  end;

implementation


{ TSalTaskListPresenterCert }

function TSalTaskListPresenterCert.GetEVListName: string;
begin
  Result := ENT_BPM_TASK_VIEW_LIST_SAL;
end;

function TSalTaskListPresenterCert.GetLaneID: Variant;
begin
  Result := const_LaneID;
end;

procedure TSalTaskListPresenterCert.OnInit(Sender: IActivity);
begin
  ViewTitle := ACT_BPM_TASK_LIST_SAL_CERT_CAPTION;
end;




end.
