unit CustomTaskListView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxLookAndFeelPainters, Menus, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, ActnList, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxGrid, cxPC, StdCtrls, cxButtons, cxContainer,
  cxGroupBox, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxLabel,
  cxVGrid, cxInplaceContainer, cxCheckBox, cxLookAndFeels,
  CustomTaskListPresenter, CustomContentView, UIClasses, cxPCdxBarPopupMenu;

type
  TfrCustomTaskListView = class(TfrCustomContentView, ICustomTaskListView)
    cxGroupBox1: TcxGroupBox;
    cxLabel1: TcxLabel;
    DBeg: TcxDateEdit;
    DEnd: TcxDateEdit;
    MainDataSource: TDataSource;
    grMainViewDef: TcxGridDBBandedTableView;
    tcStates: TcxTabControl;
    grMain: TcxGrid;
    grMainLevel1: TcxGridLevel;
    ppmCreate: TPopupMenu;
    procedure grMainViewDefCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure DBegPropertiesEditValueChanged(Sender: TObject);
  protected
    procedure LinkData(AData: TDataSet);
    function Tabs: ITabs;
    function Selection: ISelection;
    function GetDBEG: variant;
    procedure SetDBEG(AValue: variant);
    function GetDEND: variant;
    procedure SetDEND(AValue: variant);
    procedure SetDateStatus(AStatus: TValueStatus);
  end;



implementation

{$R *.dfm}

{ TfrCustomTaskListView }

procedure TfrCustomTaskListView.LinkData(AData: TDataSet);
begin
  LinkDataSet(MainDataSource, AData);
end;

function TfrCustomTaskListView.Selection: ISelection;
begin
  Result := GetChildInterface(grMainViewDef.Name) as ISelection;
end;

procedure TfrCustomTaskListView.SetDateStatus(AStatus: TValueStatus);
begin
  DBEG.Enabled := AStatus <> vsDisabled;
  DEND.Enabled := AStatus <> vsDisabled;
end;

procedure TfrCustomTaskListView.SetDBEG(AValue: variant);
begin
  DBeg.Date := AValue;
end;

procedure TfrCustomTaskListView.SetDEND(AValue: variant);
begin
  DEnd.Date := AValue;
end;

function TfrCustomTaskListView.Tabs: ITabs;
begin
  Result := GetChildInterface(tcStates.Name) as ITabs;
end;

procedure TfrCustomTaskListView.DBegPropertiesEditValueChanged(Sender: TObject);
begin
  WorkItem.Commands[COMMAND_DATERANGE_CHANGED].Execute;
end;

function TfrCustomTaskListView.GetDBEG: variant;
begin
  Result := DBEG.Date;
end;

function TfrCustomTaskListView.GetDEND: variant;
begin
  Result := DEND.Date;
end;

procedure TfrCustomTaskListView.grMainViewDefCellDblClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  WorkItem.Commands[COMMAND_OPEN].Execute;
end;

end.
