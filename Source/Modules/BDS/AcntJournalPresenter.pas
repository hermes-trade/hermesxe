unit AcntJournalPresenter;

interface
uses  ShellIntf, EntityServiceIntf, 
  EntityCatalogIntf, CustomContentPresenter, ViewServiceIntf,
  sysutils, CustomPresenter, db, variants, CommonViewIntf, CoreClasses,
  CommonUtils, Controls;

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
  TTransAcntJrnData = class(TPresenterData)
  private
    FACNT_ID: Variant;
    procedure SetACNT_ID(const Value: Variant);
  published
    property ACNT_ID: Variant read FACNT_ID write SetACNT_ID;
  end;


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
    function OnGetWorkItemState(const AName: string): Variant; override;
    procedure OnViewReady; override;
    function GetEVJrn: IEntityView;
    function GetEVBS: IEntityView;
    procedure CmdOpen(Sender: TObject);
    procedure CmdReload(Sender: TObject);
  public
    class function ExecuteDataClass: TActionDataClass; override;
  end;

implementation

{ TAcntJournalPresenter }


procedure TAcntJournalPresenter.CmdOpen(Sender: TObject);
var
  action: IAction;
begin
  if VarIsEmpty(WorkItem.State['ITEM_ID']) then Exit;

  action := WorkItem.Actions[ACTION_ENTITY_ITEM];
  action.Data.Value['ID'] := WorkItem.State['ITEM_ID'];
  action.Data.Value['ENTITYNAME'] := 'BDS_TRANS';//UIInfo.EntityName;
  action.Execute(WorkItem);
end;

procedure TAcntJournalPresenter.CmdOpenCAcntJrn(Sender: TObject);
var
  action: IAction;
begin
  action := WorkItem.Actions[VIEW_ACNT_JRN];
  action.Data.Value['ACNT_ID'] := GetCorrAcnt;
  action.Execute(WorkItem);

end;

procedure TAcntJournalPresenter.CmdReload(Sender: TObject);
begin
  GetEVJrn.Reload;
  GetEVBS.Reload;
  View.SetBSDateRangeInfo(WorkItem.State['DATE1'], WorkItem.State['DATE2']);
end;

procedure TAcntJournalPresenter.CmdSelector(Sender: TObject);
const
  FMT_VIEW_SELECTOR = 'Views.%s.Selector';
var
  action: IAction;
  actionName: string;
begin
  actionName := format(FMT_VIEW_SELECTOR, [ENT_SELECTOR]);

  action := WorkItem.Actions[actionName];
  action.Data.Assign(WorkItem);
  action.Execute(WorkItem);
  if (action.Data as TEntitySelectorPresenterData).ModalResult = mrOk then
  begin
    action.Data.AssignTo(WorkItem);
    UpdateInfoText;
    WorkItem.Commands[COMMAND_RELOAD].Execute;
  end;

end;




class function TAcntJournalPresenter.ExecuteDataClass: TActionDataClass;
begin
  Result := TTransAcntJrnData;
end;

function TAcntJournalPresenter.GetCorrAcnt: Variant;
begin
  Result := GetEVJrn.Values['CORR_ID'];
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
  eView.ParamsBind;
  Result := eView.Load['Title'];
end;

procedure TAcntJournalPresenter.InitializeSelector;
var
  ds: TDataSet;
  I: integer;
begin
  ds := App.Entities[ENT_SELECTOR].GetView('Selector', WorkItem).Load(WorkItem);
  for I := 0 to ds.FieldCount - 1 do
    WorkItem.State[ds.Fields[I].FieldName] := ds.Fields[I].Value;
  UpdateInfoText;

end;

function TAcntJournalPresenter.OnGetWorkItemState(
  const AName: string): Variant;
begin
  if SameText(AName, 'ITEM_ID') then
    Result := (GetView as IAcntJournalView).Selection.First
  else if SameText('STATE_ID', AName) then
  begin
    {if GetView <> nil then
    begin
      GetEVStates.DataSet.Locate('NAME', View.Tabs.TabCaption[View.Tabs.Active], []);
      result := GetEVStates.DataSet['ID'];
    end;}
  end
  else if SameText('USE_DRANGE', AName) then
  begin
    Result := 1;
  end
  else
    Result := inherited OnGetWorkItemState(AName);
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
    AddCommand(COMMAND_CLOSE, COMMAND_CLOSE_CAPTION, COMMAND_CLOSE_SHORTCUT, CmdClose);

  View.CommandBar.
    AddCommand(COMMAND_RELOAD, COMMAND_RELOAD_CAPTION, COMMAND_RELOAD_SHORTCUT, CmdReload);

  View.CommandBar.AddCommand(COMMAND_SELECTOR, 'Отбор', '', CmdSelector);

  View.CommandBar.AddCommand(COMMAND_OPEN, COMMAND_OPEN_CAPTION, COMMAND_OPEN_SHORTCUT,
    CmdOpen, 'Открыть', true);

  View.CommandBar.AddCommand(COMMAND_CACNT_JRN, 'Журнал контрагента', 'Ctrl+K',
    CmdOpenCAcntJrn, 'Открыть');

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
     GetView('SelectorInfo', WorkItem).Load(WorkItem)['Info']);

  if GetView <> nil then
      View.SetInfoText(txt);

end;

function TAcntJournalPresenter.View: IAcntJournalView;
begin
  Result := GetView as IAcntJournalView;
end;

{ TTransAcntJrnData }

procedure TTransAcntJrnData.SetACNT_ID(const Value: Variant);
begin
  FACNT_ID := Value;
  PresenterID := Value;
end;

end.
