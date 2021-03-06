unit DLVDeskpPresenter;

interface
uses CustomPresenter, UIClasses, coreClasses, UIStr, EntityServiceIntf,
  db, sysutils, ShellIntf, variants, strutils;

const
  COMMAND_TRIP_NEW = '{BAADFA0E-AA30-499D-B939-817F73A906BF}';
  COMMAND_TRIP_ADD_BULK = '{D3B3A254-DBD2-4D94-86F1-66F6666DD5FC}';
  COMMAND_TRIP_EDIT = '{0664E4CA-F174-4660-A854-5111D9687088}';
  COMMAND_TRIP_DEL = '{C379D5DB-FADF-433A-87A0-A1AA42016FB4}';

  COMMAND_TASK_ADD = '{CE8844BF-C00E-4D5B-AD40-30AECE1E38DA}';
  COMMAND_TASK_REMOVE = '{CCE86082-B214-4F19-A383-6404AD29A944}';

  COMMAND_DATE_INC = '{66ACD6C1-8C88-44EE-A4FA-AB0326811870}';
  COMMAND_DATE_DEC = '{1A61D1EB-63A5-46DC-A168-1753000B014E}';
  COMMAND_DATE_SET = '{077053BE-D86A-4F2D-8F61-3EE03A5659FF}';

  COMMAND_CHANGE_TASKS_KIND = '{CE590136-D650-4A81-A47A-C3644B582C43}';
  COMMAND_TRIP_SELECTED = '{1CBDE422-4D0A-4C83-893E-BF2DD8662A3D}';
  COMMAND_TASK_SELECTED = '{273E10C3-F218-4566-90E0-B529BB8DBAE2}';
  COMMAND_TRIP_TASK_SELECTED = '{33AE05A6-B377-4BF5-8595-EE6CD8436260}';
  COMMAND_TASK_OPEN = '{C9AF572E-1EF5-4707-B03C-373D989C64DC}';
  COMMAND_TRIP_TASK_OPEN = '{A0D70EE0-C261-4401-9FAA-657A0E1C08A7}';

  ENT = 'DLV_DESKP';
type
  IDLVTripDeskView = interface(ICustomView)
  ['{4BB31718-0C03-4E54-B1AF-E4A53AE9E62A}']
    procedure SetDate(AValue: TDateTime);
    function GetTasksKind: integer;
    function SelectedTrips: ISelection;
    function SelectedTasks: ISelection;
    function SelectedTripTasks: ISelection;
    procedure LinkData(Trips, Tasks, TripTasks: TDataSet);
  end;

  TDLVDeskpPresenter = class(TCustomPresenter)
  private
    function GetEVTrips: IEntityView;
    function GetEVTasks: IEntityView;
    function GetEVTripTasks: IEntityView;

    procedure CmdEVReload(Sender: TObject);
    procedure CmdTripNew(Sender: TObject);
    procedure CmdTripAddBulk(Sender: TObject);
    procedure CmdTripEdit(Sender: TObject);
    procedure CmdTripDel(Sender: TObject);
    procedure CmdDateInc(Sender: TObject);
    procedure CmdDateDec(Sender: TObject);
    procedure CmdDateSet(Sender: TObject);
    procedure CmdChangeTasksKind(Sender: TObject);
    procedure CmdTripSelected(Sender: TObject);
    procedure CmdTaskSelected(Sender: TObject);
    procedure CmdTripTaskSelected(Sender: TObject);
    procedure CmdTaskAdd(Sender: TObject);
    procedure CmdTaskRemove(Sender: TObject);
    procedure CmdTaskOpen(Sender: TObject);
    procedure CmdTripTaskOpen(Sender: TObject);
    procedure CmdReload(Sender: TObject);
    function View: IDLVTripDeskView;
  protected
    procedure OnUpdateCommandStatus; override;
    function OnGetWorkItemState(const AName: string; var Done: boolean): Variant; override;
    procedure OnViewReady; override;
  end;

implementation

{ TDLVTripDeskPresenter }

procedure TDLVDeskpPresenter.CmdChangeTasksKind(Sender: TObject);
begin
  GetEVTasks.Load(true);
end;

procedure TDLVDeskpPresenter.CmdDateDec(Sender: TObject);
begin
  WorkItem.State['DAT'] :=  WorkItem.State['DAT'] - 1;
  View.SetDate(WorkItem.State['DAT']);
  WorkItem.Commands[COMMAND_RELOAD].Execute;
end;

procedure TDLVDeskpPresenter.CmdDateInc(Sender: TObject);
begin
  WorkItem.State['DAT'] :=  WorkItem.State['DAT'] + 1;
  View.SetDate(WorkItem.State['DAT']);
  WorkItem.Commands[COMMAND_RELOAD].Execute;
end;

procedure TDLVDeskpPresenter.CmdDateSet(Sender: TObject);
var
  cmd: ICommand;
begin
  Sender.GetInterface(ICommand, cmd);
  WorkItem.State['DAT'] :=   cmd.Data['Date'];
//  View.SetDate(WorkItem.State['DAT']);
  WorkItem.Commands[COMMAND_RELOAD].Execute;
end;

procedure TDLVDeskpPresenter.CmdEVReload(Sender: TObject);
var
  cmd: ICommand;
  evName: string;
begin
  Sender.GetInterface(ICommand, cmd);
  evName := cmd.Data['EntityView'];
  App.Entities[ENT].GetView(evName, WorkItem).Load;
end;

procedure TDLVDeskpPresenter.CmdReload(Sender: TObject);
begin
  try
    GetEVTrips.Load;
    GetEVTasks.Load;
    GetEVTripTasks.Load;
  finally
    UpdateCommandStatus;
  end;
end;

procedure TDLVDeskpPresenter.CmdTaskAdd(Sender: TObject);
var
  I: integer;
  oper: IEntityOper;
begin
  try
    oper := App.Entities[ENT].GetOper('TaskAdd', WorkItem);
    for I := 0 to View.SelectedTasks.Count - 1 do
    begin
      oper.Params.ParamByName('TRIP_ID').Value := WorkItem.State['TRIP_ID'];
      oper.Params.ParamByName('TASK_ID').Value :=View.SelectedTasks[I];
      oper.Execute;
    end;
  finally
    WorkItem.Commands['OnTaskAdd'].Execute;
    GetEVTasks.Load;
    GetEVTripTasks.Load;
    GetEVTrips.ReloadRecord(WorkItem.State['TRIP_ID']);
    UpdateCommandStatus;
  end;

end;

procedure TDLVDeskpPresenter.CmdTaskOpen(Sender: TObject);
var
  activity: IActivity;
begin
  if View.SelectedTasks.Count = 0 then Exit;

  activity := WorkItem.Activities['views.DLV_TASK.Item'];
  activity.Params['ID'] := View.SelectedTasks.First;
  activity.Execute(WorkItem);
end;

procedure TDLVDeskpPresenter.CmdTaskRemove(Sender: TObject);
var
  I: integer;
  oper: IEntityOper;
begin
  try
    oper := App.Entities[ENT].GetOper('TaskRemove', WorkItem);
    for I := 0 to View.SelectedTripTasks.Count - 1 do
    begin
      oper.Params.ParamByName('ID').Value :=View.SelectedTripTasks[I];
      oper.Execute;
    end;
  finally
    GetEVTasks.Load;
    GetEVTripTasks.Load;
    GetEVTrips.ReloadRecord(WorkItem.State['TRIP_ID']);
    UpdateCommandStatus;
  end;

end;

procedure TDLVDeskpPresenter.CmdTaskSelected(Sender: TObject);
begin
  UpdateCommandStatus;
end;

procedure TDLVDeskpPresenter.CmdTripAddBulk(Sender: TObject);
const
  ENT_OPER_TRIP_ADD_BULK = 'TripAddBulk';
begin
  try
    App.Entities[ENT].
      GetOper(ENT_OPER_TRIP_ADD_BULK, WorkItem).
        Execute([WorkItem.State['DAT']]);
  finally
    WorkItem.Commands[COMMAND_RELOAD].Execute;
  end;
end;

procedure TDLVDeskpPresenter.CmdTripDel(Sender: TObject);
var
  cResult: boolean;
begin
  cResult := App.UI.MessageBox.ConfirmYesNo('������� ����?');
  if cResult then
  begin
    try
      GetEVTrips.DataSet.Delete;
      GetEVTrips.Save;
     // GetEVTasks.Load;
      WorkItem.Commands[COMMAND_RELOAD].Execute;
    except
      GetEVTrips.CancelUpdates;
      raise;
    end;
  end;
end;

procedure TDLVDeskpPresenter.CmdTripEdit(Sender: TObject);
var
  activity: IActivity;
begin
  if GetEVTrips.DataSet['STATUS'] = 0 then
    activity := WorkItem.Activities['views.DLV_TRIP.Head']
  else
    activity := WorkItem.Activities['views.DLV_TRIP.Item'];
  activity.Params['ID'] := WorkItem.State['TRIP_ID'];
  activity.Execute(WorkItem);
end;

procedure TDLVDeskpPresenter.CmdTripNew(Sender: TObject);
var
  activity: IActivity;
begin
  activity := WorkItem.Activities['views.DLV_TRIP.New'];
  activity.Params['DAT'] := WorkItem.State['DAT'];
  activity.Params['TRIP_TMPL'] := WorkItem.State['TRIP_ID'];
  activity.Execute(WorkItem);
end;

procedure TDLVDeskpPresenter.CmdTripSelected(Sender: TObject);
begin
  GetEVTripTasks.Load;
  UpdateCommandStatus;
end;

procedure TDLVDeskpPresenter.CmdTripTaskOpen(Sender: TObject);
var
  activity: IActivity;
begin
  if View.SelectedTripTasks.Count = 0 then Exit;

  activity := WorkItem.Activities['views.DLV_TASK.Item'];
  activity.Params['ID'] :=  GetEVTripTasks.DataSet['TASK_ID']; //View.SelectedTripTasks.First;
  activity.Execute(WorkItem);

end;

procedure TDLVDeskpPresenter.CmdTripTaskSelected(Sender: TObject);
begin
  UpdateCommandStatus;
end;

function TDLVDeskpPresenter.GetEVTasks: IEntityView;
begin
  Result := (WorkItem.Services[IEntityService] as IEntityService).
    Entity[ENT].GetView('Tasks', WorkItem);
  Result.Load(false);
end;

function TDLVDeskpPresenter.GetEVTrips: IEntityView;
begin
  Result := (WorkItem.Services[IEntityService] as IEntityService).
    Entity[ENT].GetView('Trips', WorkItem);
  Result.Load(false);
end;

function TDLVDeskpPresenter.GetEVTripTasks: IEntityView;
begin
  Result := (WorkItem.Services[IEntityService] as IEntityService).
    Entity[ENT].GetView('TripTasks', WorkItem);
  Result.Load(false);
end;

function TDLVDeskpPresenter.OnGetWorkItemState(const AName: string;
  var Done: boolean): Variant;

  function TripTaskNotPrinted: Variant;
  var
    ds: TDataSet;
    I: integer;
  begin
    Result := Unassigned;

    ds := App.Entities[ENT].
      GetOper('TripTasksNotPrinted', WorkItem).Execute([WorkItem.State['TRIP_ID']]);

    if ds.IsEmpty then Exit;

    Result := VarArrayCreate([0, ds.RecordCount - 1], varVariant);
    I := 0;
    while not ds.Eof do
    begin
      Result[I] := ds.Fields[0].Value;
      Inc(I);
      ds.Next;
    end;
  end;

begin
  Done := true;

  if SameText(AName, 'TRIP_ID') then
    Result := View.SelectedTrips.First
  else if SameText(AName, 'TASKS_KIND') then
    Result := View.GetTasksKind
  else if SameText(AName, 'TASK_ID') then
    Result := View.SelectedTasks.First
  else if SameText(AName, 'TRIP_TASKS') then
    Result := View.SelectedTripTasks.AsArray
  else if SameText(AName, 'TRIP_TASKS_NOT_PRINTED') then
    Result := TripTaskNotPrinted
  else
    Done := false;

end;

procedure TDLVDeskpPresenter.OnUpdateCommandStatus;
begin
  WorkItem.Commands[COMMAND_TRIP_EDIT].Status := csDisabled;
  WorkItem.Commands[COMMAND_TRIP_DEL].Status := csDisabled;

  WorkItem.Commands[COMMAND_TASK_ADD].Status := csDisabled;
  WorkItem.Commands[COMMAND_TASK_REMOVE].Status := csDisabled;

  if not VarIsEmpty(View.SelectedTrips.First) then
  begin
    WorkItem.Commands[COMMAND_TRIP_EDIT].Status := csEnabled;
    WorkItem.Commands[COMMAND_TRIP_DEL].Status := csEnabled;
  end;

  if (not VarIsEmpty(View.SelectedTrips.First)) and (View.SelectedTasks.Count <> 0) then
    WorkItem.Commands[COMMAND_TASK_ADD].Status := csEnabled;

  if View.SelectedTripTasks.Count <> 0 then
    WorkItem.Commands[COMMAND_TASK_REMOVE].Status := csEnabled;

end;

procedure TDLVDeskpPresenter.OnViewReady;
begin
  ViewTitle := ViewInfo.Title;

  View.CommandBar.
    AddCommand(COMMAND_CLOSE,
      GetLocaleString(@COMMAND_CLOSE_CAPTION), COMMAND_CLOSE_SHORTCUT);
  WorkItem.Commands[COMMAND_CLOSE].SetHandler(CmdClose);

  View.CommandBar.
    AddCommand(COMMAND_RELOAD, GetLocaleString(@COMMAND_RELOAD_CAPTION), COMMAND_RELOAD_SHORTCUT);
  WorkItem.Commands[COMMAND_RELOAD].SetHandler(CmdReload);

  View.CommandBar.AddCommand(COMMAND_TRIP_NEW, '�������� ����', '', '�������� ����', true);
  WorkItem.Commands[COMMAND_TRIP_NEW].SetHandler(CmdTripNew);
  View.CommandBar.AddCommand(COMMAND_TRIP_ADD_BULK, '�������� ���� ����', '', '�������� ����');
  WorkItem.Commands[COMMAND_TRIP_ADD_BULK].SetHandler(CmdTripAddBulk);

  View.CommandBar.AddCommand(COMMAND_TRIP_EDIT, '�������� ����', '', '�������� ����');
  WorkItem.Commands[COMMAND_TRIP_EDIT].SetHandler(CmdTripEdit);

  View.CommandBar.AddCommand(COMMAND_TRIP_DEL, '������� ����', '', '�������� ����');
  WorkItem.Commands[COMMAND_TRIP_DEL].SetHandler(CmdTripDel);

  View.CommandBar.AddCommand(COMMAND_TASK_ADD, '�������� ������', '', '�������� ������', true);
  WorkItem.Commands[COMMAND_TASK_ADD].SetHandler(CmdTaskAdd);
  View.CommandBar.AddCommand(COMMAND_TASK_REMOVE, '��������� ������', '', '�������� ������');
  WorkItem.Commands[COMMAND_TASK_REMOVE].SetHandler(CmdTaskRemove);

  WorkItem.Commands[COMMAND_DATE_INC].SetHandler(CmdDateInc);
  WorkItem.Commands[COMMAND_DATE_DEC].SetHandler(CmdDateDec);
  WorkItem.Commands[COMMAND_DATE_SET].SetHandler(CmdDateSet);

  WorkItem.Commands[COMMAND_CHANGE_TASKS_KIND].SetHandler(CmdChangeTasksKind);

  View.SelectedTrips.SetChangedCommand(COMMAND_TRIP_SELECTED);
  WorkItem.Commands[COMMAND_TRIP_SELECTED].SetHandler(CmdTripSelected);

  View.SelectedTasks.SetChangedCommand(COMMAND_TASK_SELECTED);
  WorkItem.Commands[COMMAND_TASK_SELECTED].SetHandler(CmdTaskSelected);

  View.SelectedTripTasks.SetChangedCommand(COMMAND_TRIP_TASK_SELECTED);
  WorkItem.Commands[COMMAND_TRIP_TASK_SELECTED].SetHandler(CmdTripTaskSelected);

  WorkItem.Commands[COMMAND_TASK_OPEN].SetHandler(CmdTaskOpen);
  WorkItem.Commands[COMMAND_TRIP_TASK_OPEN].SetHandler(CmdTripTaskOpen);

  with WorkItem.Commands['Commands.EV.TripTasks.Reload'] do
  begin
    Data['EntityView'] := 'TripTasks';
    SetHandler(CmdEVReload);
  end;

  WorkItem.State['DAT'] := Date;
  View.SetDate(Date);

  GetEVTrips.ImmediateSave := true;

  View.LinkData(GetEVTrips.DataSet, GetEVTasks.DataSet, GetEVTripTasks.DataSet);
end;

function TDLVDeskpPresenter.View: IDLVTripDeskView;
begin
  Result := GetView as IDLVTripDeskView;
end;

end.
