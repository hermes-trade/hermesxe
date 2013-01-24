unit AcntJournalPresenter;

interface
uses  ShellIntf, EntityServiceIntf, CustomContentPresenter,
  sysutils, CustomPresenter, db, variants, UIClasses, CoreClasses,
  Controls, UIStr;

const
  VIEW_ACNT_JRN = 'views.BDS_TRANS.JournalAcnt';
  VIEW_ACNT_JRN_CAPTION = 'Операции по счету';

  COMMAND_CACNT_JRN = '{223D6443-B5A0-41D4-B5E6-834A414E57DE}';

  COMMAND_SELECTOR = 'commands.selector';
  COMMAND_SELECTOR_DATERANGE = 'commands.journal.selector.daterange';
  COMMAND_SELECTOR_DATERANGE_CAPTION = 'Интервал дат';

  ENT_BDS_TRANS = 'BDS_TRANS';
    
  ENT = 'BDS_ACNT_JRN';
  ENT_VIEW_JRN = 'Jrn';
  ENT_VIEW_BS = 'BS';

  ENT_SELECTOR = 'UTL_JRN';

  ACTION_TRANS_ACNT_JRN = 'views.BDS_TRANS.JournalAcnt';


type


  IAcntJournalView = interface(IContentView)
  ['{1054F83F-3189-4CA3-B9CE-EDDBBACED665}']
    function GetCorrAcnt: Variant;
    procedure SetBSDateRangeInfo(Date1, Date2: TDateTime);
    procedure SetBSData(ADataSet: TDataSet);
    function Selection: ISelection;
    procedure SetInfoText(const AText: string);
    procedure SetJournalDataSet(ADataSet: TDataSet);
  end;

  TAcntJournalPresenter = class(TCustomContentPresenter)
  type
    TAcntJrnActivityParams = record
    const
      ACNT_ID = 'ACNT_ID';
    end;

  private
    FSelectorInitialized: boolean;
    procedure InitializeSelector;
    procedure UpdateInfoText;
    procedure OnSelectionChanged;
    procedure SetCommandsStatus;
    procedure CmdOpenCAcntJrn(Sender: TObject);
    function GetViewTitle: string;
    function GetCorrAcnt: Variant;
    function View: IAcntJournalView;
    procedure CmdSelector(Sender: TObject);
  protected
    function OnGetWorkItemState(const AName: string; var Done: boolean): Variant; override;
    procedure OnViewReady; override;
    function GetEVJrn: IEntityView;
    function GetEVBS: IEntityView;
    procedure CmdReload(Sender: TObject);
  end;

implementation

function FirstDayOfMonth(ADate: TDateTime): TDateTime;
var
  Year, Month, Day: Word;
begin
  DecodeDate(ADate, Year, Month, Day);
  Result := EncodeDate(Year, Month, 1);
end;

function LastDayOfMonth(ADate: TDateTime): TDateTime;
var
  Year, Month, Day: Word;
begin
  DecodeDate(ADate, Year, Month, Day);
  if Month < 12 then inc(Month)
  else begin Month := 1; inc(Year) end;
  Result := EncodeDate(Year, Month, 1) - 1;
end;

{ TAcntJournalPresenter }



procedure TAcntJournalPresenter.CmdOpenCAcntJrn(Sender: TObject);
begin
  with WorkItem.Activities[VIEW_ACNT_JRN] do
  begin
    Params['ACNT_ID'] := GetCorrAcnt;
    Params[TViewActivityParams.InstanceID] := Params['ACNT_ID'];
    Execute(WorkItem);
  end;
end;

procedure TAcntJournalPresenter.CmdReload(Sender: TObject);
begin
  GetEVJrn.Load;
  GetEVBS.Load;
  View.SetBSDateRangeInfo(WorkItem.State['DATE1'], WorkItem.State['DATE2']);
end;

procedure TAcntJournalPresenter.CmdSelector(Sender: TObject);
const
  FMT_VIEW_SELECTOR = 'Views.%s.Selector';
var
  actionName: string;
begin
  actionName := format(FMT_VIEW_SELECTOR, [ENT_SELECTOR]);

  with WorkItem.Activities[actionName] do
  begin
    Params.Assign(WorkItem);
    Execute(WorkItem);
    if Outs[TViewActivityOuts.ModalResult] = mrOk then
    begin
      Outs.AssignTo(WorkItem);
      UpdateInfoText;
      WorkItem.Commands[COMMAND_RELOAD].Execute;
    end;
  end;
end;

function TAcntJournalPresenter.GetCorrAcnt: Variant;
begin
  Result := GetEVJrn.DataSet['CORR_ID'];
end;

function TAcntJournalPresenter.GetEVBS: IEntityView;
begin
  Result := GetEView(ENT, ENT_VIEW_BS)
end;

function TAcntJournalPresenter.GetEVJrn: IEntityView;
begin
  if not FSelectorInitialized then
  begin
    InitializeSelector;
    FSelectorInitialized := true;
  end;

  Result := GetEView(ENT, ENT_VIEW_JRN);
end;

function TAcntJournalPresenter.GetViewTitle: string;
const
  ENT_VIEW_TITLE = 'Title';

var
  eView: IEntityView;

begin
  Result := '';
  eView := App.Entities[ENT].GetView(ENT_VIEW_TITLE, WorkItem);
  Result := eView.Load['Title'];
end;

procedure TAcntJournalPresenter.InitializeSelector;
var
  ds: TDataSet;
  I: integer;
begin
  ds := App.Entities[ENT_SELECTOR].GetView('Selector', WorkItem).Load;
  for I := 0 to ds.FieldCount - 1 do
    WorkItem.State[ds.Fields[I].FieldName] := ds.Fields[I].Value;
  UpdateInfoText;

end;

function TAcntJournalPresenter.OnGetWorkItemState(
  const AName: string; var Done: boolean): Variant;
begin
  Done := true;
  if SameText(AName, 'ITEM_ID') then
    Result := (GetView as IAcntJournalView).Selection.First
  else if SameText('USE_DRANGE', AName) then
  begin
    Result := 1;
  end
  else
  begin
    Done := false;
    Result := inherited OnGetWorkItemState(AName, Done);
  end;
end;


procedure TAcntJournalPresenter.OnSelectionChanged;
begin
  SetCommandsStatus;
end;

procedure TAcntJournalPresenter.OnViewReady;
begin
  ViewTitle := GetViewTitle;

  WorkItem.State['Date1'] := FirstDayOfMonth(Date);
  WorkItem.State['Date2'] := LastDayOfMonth(Date);

  WorkItem.Commands[COMMAND_CACNT_JRN].SetHandler(CmdOpenCAcntJrn);

  View.CommandBar.
    AddCommand(COMMAND_CLOSE, COMMAND_CLOSE_CAPTION, COMMAND_CLOSE_SHORTCUT);
  WorkItem.Commands[COMMAND_CLOSE].SetHandler(CmdClose);

  View.CommandBar.
    AddCommand(COMMAND_RELOAD, COMMAND_RELOAD_CAPTION, COMMAND_RELOAD_SHORTCUT);
  WorkItem.Commands[COMMAND_RELOAD].SetHandler(CmdReload);

  View.CommandBar.AddCommand(COMMAND_SELECTOR, 'Отбор');
  WorkItem.Commands[COMMAND_SELECTOR].SetHandler(CmdSelector);

  View.CommandBar.AddCommand(COMMAND_OPEN, COMMAND_OPEN_CAPTION, COMMAND_OPEN_SHORTCUT,
    'Открыть', true);

  View.CommandBar.AddCommand(COMMAND_CACNT_JRN, 'Журнал контрагента', 'Ctrl+K',
    'Открыть');
  WorkItem.Commands[COMMAND_CACNT_JRN].SetHandler(CmdOpenCAcntJrn);

  (GetView as IAcntJournalView).SetJournalDataSet(GetEVJrn.DataSet);

  View.SetBSData(GetEVBS.DataSet);
  SetCommandsStatus;
  View.Selection.SetSelectionChangedHandler(OnSelectionChanged);
end;

procedure TAcntJournalPresenter.SetCommandsStatus;
begin
  WorkItem.Commands[COMMAND_DELETE].Status := csDisabled;
  WorkItem.Commands[COMMAND_OPEN].Status := csDisabled;
  WorkItem.Commands[COMMAND_NEW].Status := csDisabled;
  WorkItem.Commands[COMMAND_STATE_CHANGE_NEXT].Status := csDisabled;
  WorkItem.Commands[COMMAND_STATE_CHANGE_PREV].Status := csDisabled;
  WorkItem.Commands[COMMAND_CACNT_JRN].Status := csDisabled;

  if View.Selection.Count > 0 then
    WorkItem.Commands[COMMAND_OPEN].Status := csEnabled;

  if View.Selection.Count > 0 then
    WorkItem.Commands[COMMAND_CACNT_JRN].Status := csEnabled;

{  if View.Tabs.Active = 0 then
    WorkItem.Commands[COMMAND_NEW].Status := csEnabled;

  if (View.Tabs.Active = 0) and (View.Selection.Count > 0) then
    WorkItem.Commands[COMMAND_DELETE].Status := csEnabled;

  if View.Selection.Count > 0 then
    WorkItem.Commands[COMMAND_OPEN].Status := csEnabled;

  if (View.Tabs.Active > 0) and (View.Selection.Count > 0) then
    WorkItem.Commands[COMMAND_STATE_CHANGE_PREV].Status := csEnabled;

  if (View.Tabs.Active < (View.Tabs.Count - 1)) and (View.Selection.Count > 0) then
    WorkItem.Commands[COMMAND_STATE_CHANGE_NEXT].Status := csEnabled;

  if View.Selection.Count > 0 then
    WorkItem.Commands[COMMAND_CACNT_JRN].Status := csEnabled;}
end;


procedure TAcntJournalPresenter.UpdateInfoText;
var
  txt: string;
begin
  txt := VarToStr(App.Entities[ENT_SELECTOR].
     GetView('SelectorInfo', WorkItem).Load['Info']);

  if GetView <> nil then
      View.SetInfoText(txt);

end;

function TAcntJournalPresenter.View: IAcntJournalView;
begin
  Result := GetView as IAcntJournalView;
end;


end.
