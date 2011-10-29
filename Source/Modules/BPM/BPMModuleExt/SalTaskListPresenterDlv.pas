unit SalTaskListPresenterDlv;

interface
uses CustomTaskListPresenter, classes, CoreClasses, ShellIntf, SysUtils, db,
  UIClasses, Variants, EntityServiceIntf, BPMConst, BPMConstExt;

const
  const_LaneID = 4;

type
  TSalTaskListPresenterDlv = class(TCustomTaskListPresenter)
  private
  protected
    procedure OnInit(Sender: IAction); override;
    function GetLaneID: Variant; override;
    function GetEVListName: string; override;
  end;

implementation


{ TSalTaskListPresenterDlv }

function TSalTaskListPresenterDlv.GetEVListName: string;
begin
  Result := ENT_BPM_TASK_VIEW_LIST_SAL;
end;

function TSalTaskListPresenterDlv.GetLaneID: Variant;
begin
  Result := const_LaneID;
end;

procedure TSalTaskListPresenterDlv.OnInit(Sender: IAction);
begin
  ViewTitle := ACT_BPM_TASK_LIST_SAL_DLV_CAPTION;
end;



end.
