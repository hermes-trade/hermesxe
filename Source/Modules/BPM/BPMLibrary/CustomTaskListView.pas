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
  CustomTaskListPresenter, CustomContentView, UIClasses;

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
  protected
    procedure LinkData(AData: TDataSet);
    function Tabs: ITabs;
    function Selection: ISelection;
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

function TfrCustomTaskListView.Tabs: ITabs;
begin
  Result := GetChildInterface(tcStates.Name) as ITabs;
end;

procedure TfrCustomTaskListView.grMainViewDefCellDblClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  WorkItem.Commands[COMMAND_OPEN].Execute;
end;

end.
