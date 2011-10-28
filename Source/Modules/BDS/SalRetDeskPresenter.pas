unit SalRetDeskPresenter;

interface
uses classes, sysutils, CoreClasses, ShellIntf, CommonViewIntf,
  Variants, EntityServiceIntf, CustomContentPresenter,
   db, Controls;

const
  VIEW_SALRET_DESK = 'views.bds.salret.desk';
  VIEW_SALRET_DESK_CAPTION = 'Учет возврата товара';

  ENT_BDS_STAFF = 'BDS_Staff';
  ENT_BDS_STAFF_VIEW_SELECT = 'Select';
  STAFF_POSITION_FORWARDER = 3;
  VIEW_B52_SOTR_PICKLIST = 'views.B52_SOTR.PickList';

  strDocNotFound = 'Документ не найден!';

  ENT_SALRET_DESK = 'BDS_SalRet_Desk';
  ENT_VIEW_HEAD = 'Head';
  ENT_VIEW_REC = 'Rec';
  ENT_VIEW_GDS2 = 'Gds2';

  ENT_OPER_POST = 'Post';
  ENT_OPER_ROLLBACK = 'RollBack';
  ENT_OPER_CREATEMOVE = 'CreateMove';


  SALRET_STATE_POSTED = 2;

  DOC_KIND_RN = 1;
  DOC_KIND_REQ = 2;

  Command_LoadDoc = '{5E481D5C-92E8-4F53-A18D-390AA9BDA99D}';
  Command_PostDoc =  '{B6C81DA1-050F-485F-B74A-A55E09A7B3D6}';
  Command_RollbackDoc = '{1C2CBDBD-DABB-4363-9A6A-38936B3FC3A8}';
  Command_SelectForwarder = '{70EF62B3-E440-43C1-B1C0-99C6EC6C02CF}';
  Command_ClearForwarder = '{A41547D9-03B0-4D01-A457-91C4BA199634}';  
  Command_CreateMove = '{FEFE5AAE-60B3-4B2D-9E0D-9CCA684EB22F}';  
  Command_PrintOrder = 'reports.bds.wh.cardin.salret';


  VIEW_VALUE_DOC_KIND = 'DOC_KIND';
  VIEW_VALUE_DOC_NUM = 'DOC_NUM';

type
  TViewMode = (vmCreate, vmReview);

  ISalRetDeskView = interface
  ['{13F8E6AF-CB7E-463D-A266-FD6670F826B6}']
    procedure SetViewMode(AValue: TViewMode);
    procedure SetDataSets(AHead, ARec, AGds2: TDataSet);
  end;

  TSalRetDeskPresenter = class(TCustomContentPresenter)
  private
    FDocLoaded: boolean;
    function GetEVHead: IEntityView;
    function GetEVRec: IEntityView;
    function GetEVGds2: IEntityView;
    procedure CmdLoadDoc(Sender: TObject);
    procedure CmdPostDoc(Sender: TObject);
    procedure CmdRollbackDoc(Sender: TObject);
    procedure CmdSelectForwarder(Sender: TObject);
    procedure CmdClearForwarder(Sender: TObject);
    procedure CmdCreateMove(Sender: TObject);
    procedure CmdPrintOrder(Sender: TObject);
    function GetDocKind: integer;
    procedure LoadEmptyDoc;
    procedure EVRecChangedHandler(ADataSet: TDataSet);
  protected
    function OnGetWorkItemState(const AName: string): Variant; override;
    //
    procedure OnViewReady; override;
  end;

implementation


{ TSalRetDeskPresenter }


procedure TSalRetDeskPresenter.CmdLoadDoc(Sender: TObject);
var
  docNum: Variant;
begin
  {if FDocLoaded and (GetView.Value['ViewMode'] = VIEW_MODE_CREATE) then
    case App.MessageBox.ConfirmYesNoCancel('Предыдущий документ не проведен! Провести ?') of
      mrYes: WorkItem.Commands[Command_PostDoc].Execute;
      mrCancel: Exit;
    end;}


  LoadEmptyDoc;
  (GetView as ISalRetDeskView).SetViewMode(vmCreate);


  SetCommandStatus(Command_PostDoc, false);
  SetCommandStatus(Command_RollbackDoc, false);
  FDocLoaded := false;

  docNum := WorkItem.State[VIEW_VALUE_DOC_NUM];
  if not (Trim(VarToStr(docNum)) = '') then
  begin
    GetEVHead.Load([docNum, GetDocKind]);
    if not GetEVHead.DataSet.IsEmpty then
    begin

      GetEVHead.Values['DUMMY'] := '_'; //need for modified
      GetEVRec.Load([GetEVHead.Values['ID'], GetEVHead.Values['KIND_ID'], GetEVHead.Values['SAL_ID']]);

      GetView.Value['FORWARDER_NAME'] := GetEVHead.Values['FORWARDER_NAME'];
      if GetEVHead.Values['STATE_ID'] = SALRET_STATE_POSTED then
      begin
        (GetView as ISalRetDeskView).SetViewMode(vmReview);
        //GetView.Value['ViewMode'] := VIEW_MODE_REVIEW;
        SetCommandStatus(Command_PostDoc, false);
        SetCommandStatus(Command_RollbackDoc, true);
      end
      else
      begin
        (GetView as ISalRetDeskView).SetViewMode(vmCreate);
        //GetView.Value['ViewMode'] := VIEW_MODE_CREATE;
        SetCommandStatus(Command_PostDoc, true);
        SetCommandStatus(Command_RollbackDoc, false);
      end;
      FDocLoaded := true;
    end
    else
      App.UI.MessageBox.ErrorMessage(strDocNotFound);
  end;


end;


procedure TSalRetDeskPresenter.CmdPostDoc(Sender: TObject);
begin
  if not App.UI.MessageBox.ConfirmYesNo('Провести документ ?') then exit;

  GetEVHead.Save;
  App.Entities[ENT_SALRET_DESK].GetOper(ENT_OPER_POST, WorkItem).
      Execute([GetEVHead.Values['ID']]);

  SetCommandStatus(Command_PostDoc, false);
  SetCommandStatus(Command_RollbackDoc, false);
  LoadEmptyDoc;
  WorkItem.State[VIEW_VALUE_DOC_NUM] := '';
  FDocLoaded := false;

end;

procedure TSalRetDeskPresenter.EVRecChangedHandler(ADataSet: TDataSet);
begin
  try
    GetEVHead.Save;
    GetEVRec.Save;
  except
    GetEVRec.UndoLastChange;
    raise;
  end;

end;

function TSalRetDeskPresenter.GetEVHead: IEntityView;
begin
  Result := App.Entities[ENT_SALRET_DESK].
    GetView(ENT_VIEW_HEAD, WorkItem);
end;

function TSalRetDeskPresenter.GetEVRec: IEntityView;
begin
  Result := App.Entities[ENT_SALRET_DESK].
    GetView(ENT_VIEW_REC, WorkItem);
end;

procedure TSalRetDeskPresenter.LoadEmptyDoc;
begin
  GetEVHead.Load([null, null]);
  GetEVRec.Load([null, null]);
  GetView.Value['FORWARDER_NAME'] := '';
end;

procedure TSalRetDeskPresenter.OnViewReady;
begin
  ViewTitle := VIEW_SALRET_DESK_CAPTION;
  FDocLoaded := false;
  WorkItem.State[VIEW_VALUE_DOC_KIND] := 0;

  LoadEmptyDoc;

  (GetView as ISalRetDeskView).SetDataSets(GetEVHead.DataSet, GetEVRec.DataSet, GetEVGds2.DataSet);
  GetEVRec.DataSet.AfterPost := EVRecChangedHandler;

  //-------------------- CommandBar begin
  WorkItem.Commands[COMMAND_CLOSE].Caption := COMMAND_CLOSE_CAPTION;
  WorkItem.Commands[COMMAND_CLOSE].ShortCut := COMMAND_CLOSE_SHORTCUT;
  WorkItem.Commands[COMMAND_CLOSE].SetHandler(CmdClose);
  (GetView as IContentView).CommandBar.AddCommand(COMMAND_CLOSE);

  WorkItem.Commands[Command_PostDoc].Caption := 'Провести';
  WorkItem.Commands[Command_PostDoc].SetHandler(CmdPostDoc);
  (GetView as IContentView).CommandBar.AddCommand(Command_PostDoc);
  SetCommandStatus(Command_PostDoc, false);

  //WorkItem.Commands[Command_RollbackDoc].SetHandler(CmdRollbackDoc);
  //SetCommandStatus(Command_RollbackDoc, false);
  WorkItem.Commands[Command_RollbackDoc].Caption := 'Отменить проведение';
  WorkItem.Commands[Command_RollbackDoc].SetHandler(CmdRollbackDoc);
  (GetView as IContentView).CommandBar.AddCommand(Command_RollbackDoc);
  SetCommandStatus(Command_RollbackDoc, false);

  WorkItem.Commands[Command_CreateMove].Caption := 'Переместить';
  WorkItem.Commands[Command_CreateMove].SetHandler(CmdCreateMove);
  (GetView as IContentView).CommandBar.AddCommand(Command_CreateMove);

  WorkItem.Commands[Command_PrintOrder].Caption := 'Приходный ордер';
  WorkItem.Commands[Command_PrintOrder].SetHandler(CmdPrintOrder);
  (GetView as IContentView).CommandBar.AddCommand(Command_PrintOrder, 'Печать', true);

  WorkItem.Commands[Command_LoadDoc].SetHandler(CmdLoadDoc);
  WorkItem.Commands[Command_SelectForwarder].SetHandler(CmdSelectForwarder);
  WorkItem.Commands[Command_ClearForwarder].SetHandler(CmdClearForwarder);

end;

procedure TSalRetDeskPresenter.CmdSelectForwarder(Sender: TObject);
var
  forwarderID: Variant;
  _action: IAction;
  _actionData: TPresenterData;
begin
  if not FDocLoaded then exit;

  _action := WorkItem.Actions[VIEW_B52_SOTR_PICKLIST];
  _actionData := _action.Data as TPresenterData;
  _actionData.SetValue('POSITION', STAFF_POSITION_FORWARDER);
  _action.Execute(WorkItem);

  if _actionData.ModalResult = mrOk then
  begin
    forwarderID := _actionData['ID'];
    GetEVHead.Values['FORWARDER_ID'] := forwarderID;
    GetView.Value['FORWARDER_NAME'] :=
      App.Entities[ENT_BDS_STAFF].GetView('Item', WorkItem).Load([forwarderID])['NAME'];
  end;

  GetEVHead.Save;
end;

function TSalRetDeskPresenter.GetDocKind: integer;
begin
  case WorkItem.State[VIEW_VALUE_DOC_KIND] of
    0: Result := DOC_KIND_RN;
    1: Result := DOC_KIND_REQ;
    else
      Result := 0;
  end;
end;

procedure TSalRetDeskPresenter.CmdRollbackDoc(Sender: TObject);
begin
  if not App.UI.MessageBox.ConfirmYesNo('Отменить проведение документа ?') then exit;

  if GetEVHead.IsModified then GetEVHead.Save;
  App.Entities[ENT_SALRET_DESK].GetOper(ENT_OPER_ROLLBACK, WorkItem).
      Execute([GetEVHead.Values['ID']]);

  SetCommandStatus(Command_PostDoc, false);
  SetCommandStatus(Command_RollbackDoc, false);
  LoadEmptyDoc;
  WorkItem.State[VIEW_VALUE_DOC_NUM] := '';
  FDocLoaded := false;

end;

function TSalRetDeskPresenter.GetEVGds2: IEntityView;
begin
  Result := Self.GetEView(ENT_SALRET_DESK, ENT_VIEW_GDS2, []);
end;

procedure TSalRetDeskPresenter.CmdCreateMove(Sender: TObject);
begin
  if not App.UI.MessageBox.ConfirmYesNo('Сформировать перемещения по складу возвратов ?') then exit;

  App.Entities[ENT_SALRET_DESK].GetOper(ENT_OPER_CREATEMOVE, WorkItem).
      Execute([GetEVHead.Values['ID']]);

end;

function TSalRetDeskPresenter.OnGetWorkItemState(const AName: string): Variant;
begin
  if (AName = 'ID') and FDocLoaded then
    Result := GetEVHead.Values['ID']
  else
    Result := inherited OnGetWorkItemState(AName);

end;

procedure TSalRetDeskPresenter.CmdPrintOrder(Sender: TObject);
begin
  App.Reports[Command_PrintOrder].Execute(WorkItem);
end;

procedure TSalRetDeskPresenter.CmdClearForwarder(Sender: TObject);
begin
  if not FDocLoaded then exit;

  GetEVHead.Values['FORWARDER_ID'] := null;
  GetView.Value['FORWARDER_NAME'] := '';
  GetEVHead.Save;
end;


end.
