unit SalTaskBulkItemPresenter;

interface
uses CoreClasses, CustomContentPresenter, ShellIntf, EntityServiceIntf, SysUtils,
  variants, UIClasses, db, BPMConst, BPMConstExt;

const
  ENT = 'BPM_TASKBULK';
  ENT_HEAD = 'Head';
  ENT_DETAILS = 'Details';

  COMMAND_HEAD_OPEN = '{785FB60E-33B4-40B4-9E60-40F3FBA9DF87}';

  COMMAND_DETAIL_NEW = '{79804F16-7BD9-4714-9142-F70FFE6E1E8A}';
  COMMAND_DETAIL_OPEN = '{6BD45055-0D96-4010-8800-2629EAB5952B}';
  COMMAND_DETAIL_DEL = '{006DF812-1147-40EC-8480-18517F4F2457}';

  COMMAND_CHANGE_DETAIL_SELECT = '{72FCC4AD-E2F6-4039-8730-BAA0D7C1DB38}';

  COMMAND_PRINT_BULKCOLLECT = 'reports.bpm.wh.bulkcollect';
  COMMAND_PRINT_COLLECTTASK = '{8FE7BC89-C0E0-419A-B204-BFC1CCD7AD61}';

type
  ITaskBulkItemView = interface(IContentView)
  ['{A16E7E6C-3BAD-478C-BA94-429B20FF7F3A}']
    function DetailSelection: ISelection;
    function DetailTabs: ITabs;
    procedure SetData(Header, Details: TDataSet);
  end;

  TTaskBulkItemPresenter = class(TCustomContentPresenter)
  private
    procedure SetCommandsStatus;
    procedure OnDetailTabChanged;
    procedure OnDetailSelectionChanged;
    procedure CmdPrintBulkCollect(Sender: TObject);
    procedure CmdPrintCollectTask(Sender: TObject);
    //procedure CmdRecNew(Sender: TObject);
    //procedure CmdRecOpen(Sender: TObject);
    //procedure CmdRecDel(Sender: TObject);
   // procedure CmdChangeRecSelect(Sender: TObject);
    function View: ITaskBulkItemView;
  protected
    function OnGetWorkItemState(const AName: string): Variant; override;
    procedure OnInit(Sender: IActivity); override;
    procedure OnViewReady; override;
    function GetEVHeader: IEntityView;
    function GetEVDetails: IEntityView;
  end;

implementation

{ TTaskBulkItemPresenter }


function TTaskBulkItemPresenter.GetEVHeader: IEntityView;
begin
  Result := GetEView(ENT, ENT_HEAD);
end;

function TTaskBulkItemPresenter.GetEVDetails: IEntityView;
begin
  Result := GetEView(ENT, ENT_DETAILS);
end;

function TTaskBulkItemPresenter.OnGetWorkItemState(
  const AName: string): Variant;
begin
  if SameText(AName, 'PRINTED_STATUS') then
    Result := View.DetailTabs.Active
  else
    Result := inherited OnGetWorkItemState(AName);
end;

procedure TTaskBulkItemPresenter.OnInit(Sender: IActivity);
begin
  ViewTitle := GetEVHeader.Values['VIEW_TITLE'];
  WorkItem.State['HID'] := WorkItem.State['ID'];
end;

procedure TTaskBulkItemPresenter.OnViewReady;
begin
  WorkItem.Commands[COMMAND_CLOSE].Caption := COMMAND_CLOSE_CAPTION;
  WorkItem.Commands[COMMAND_CLOSE].ShortCut := COMMAND_CLOSE_SHORTCUT;
  WorkItem.Commands[COMMAND_CLOSE].SetHandler(CmdClose);
  (GetView as IContentView).CommandBar.AddCommand(COMMAND_CLOSE);

  WorkItem.Commands[COMMAND_PRINT_BULKCOLLECT].Caption := 'Заборный лист';
  WorkItem.Commands[COMMAND_PRINT_BULKCOLLECT].SetHandler(CmdPrintBulkCollect);
  (GetView as IContentView).CommandBar.AddCommand(COMMAND_PRINT_BULKCOLLECT, 'Печать', true);

  WorkItem.Commands[COMMAND_PRINT_COLLECTTASK].Caption := 'Комплектовочный лист';
  WorkItem.Commands[COMMAND_PRINT_COLLECTTASK].SetHandler(CmdPrintCollectTask);
  (GetView as IContentView).CommandBar.AddCommand(COMMAND_PRINT_COLLECTTASK, 'Печать');

  //GetView.LinkDataSet('Header', GetEVHeader.DataSet);
  //GetView.LinkDataSet('Details', GetEVDetails.DataSet);
  View.SetData(GetEVHeader.DataSet, GetEVDetails.DataSet);

  View.DetailTabs.Active := 0;
  View.DetailTabs.SetTabChangedHandler(OnDetailTabChanged);

  View.DetailSelection.SetSelectionChangedHandler(OnDetailSelectionChanged);

  SetCommandsStatus;
end;

procedure TTaskBulkItemPresenter.SetCommandsStatus;
begin
  WorkItem.Commands[COMMAND_DETAIL_OPEN].Status := csDisabled;
  WorkItem.Commands[COMMAND_DETAIL_DEL].Status := csDisabled;
  WorkItem.Commands[COMMAND_PRINT_COLLECTTASK].Status := csDisabled;

  if View.DetailSelection.Count > 0 then
  begin
    WorkItem.Commands[COMMAND_DETAIL_OPEN].Status := csEnabled;
    WorkItem.Commands[COMMAND_DETAIL_DEL].Status := csEnabled;
    WorkItem.Commands[COMMAND_PRINT_COLLECTTASK].Status := csEnabled;
  end;

end;

procedure TTaskBulkItemPresenter.CmdPrintBulkCollect(Sender: TObject);
begin

//  App.Reports[COMMAND_PRINT_BULKCOLLECT].Params['ID'] := WorkItem.State['ID'];
//  App.Reports[COMMAND_PRINT_BULKCOLLECT].Execute(WorkItem);
end;

procedure TTaskBulkItemPresenter.CmdPrintCollectTask(Sender: TObject);
  procedure PrintTask;
  var
    TaskList: Variant;
    I: integer;
    _count: integer;
    _rptData: TDataSet;
    _rptID: string;
  begin
    TaskList := View.DetailSelection.AsArray;
    _count := VarArrayHighBound(TaskList, 1);

    for I := 0 to _count do
    begin
      _rptData := App.Entities.Entity[ENT_BPM_TASK].
        GetOper(ENT_BPM_TASK_OPER_REPORTS_GET, WorkItem).Execute([TaskList[I]]);

   {   while not _rptData.Eof do
      begin
        _rptID := _rptData['Report_ID'];
        App.Reports.Report[_rptID].Params['ID'] := VarToStr(TaskList[I]);
        App.Reports.Report[_rptID].Params['OutCode'] := _rptData['Out_Code'];

        if _count = 0 then
          App.Reports.Report[_rptID].Execute(WorkItem, reaExecute)
        else if I = 0 then
          App.Reports.Report[_rptID].Execute(WorkItem, reaPrepareFirst)
        else if I = _count then
          App.Reports.Report[_rptID].Execute(WorkItem, reaExecutePrepared)
        else
          App.Reports.Report[_rptID].Execute(WorkItem, reaPrepareNext);

        _rptData.Next;
      end;}
    end;
  end;
begin
  try
    PrintTask;
  finally
    GetEVDetails.Reload;  
  end;
end;

procedure TTaskBulkItemPresenter.OnDetailTabChanged;
begin
  GetEVDetails.Reload;
  SetCommandsStatus;
end;

function TTaskBulkItemPresenter.View: ITaskBulkItemView;
begin
  Result := GetView as ITaskBulkItemView;
end;

procedure TTaskBulkItemPresenter.OnDetailSelectionChanged;
begin
  SetCommandsStatus;
end;


end.
