unit SalTaskBulkItemView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomContentView, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Menus, ActnList, StdCtrls,
  cxButtons, cxGroupBox, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxSplitter, cxInplaceContainer, cxVGrid, cxDBVGrid, SalTaskBulkItemPresenter,
  ISelectionGridImpl, UIClasses, CoreClasses, cxPC, ITabsImpl;

type
  TfrTaskBulkItemView = class(TfrCustomContentView, ITaskBulkItemView)
    grHeader: TcxDBVerticalGrid;
    cxSplitter1: TcxSplitter;
    HeaderDataSource: TDataSource;
    DetailsDataSource: TDataSource;
    acPrintDef: TAction;
    acPrintBulkCollect: TAction;
    acPrintCollectTask: TAction;
    tcDetails: TcxTabControl;
    grList: TcxGrid;
    grDetails: TcxGridDBTableView;
    grListLevel1: TcxGridLevel;
    procedure acPrintDefExecute(Sender: TObject);
  private
  protected
    procedure OnInitialize; override;
    //
    function DetailSelection: ISelection;
    function DetailTabs: ITabs;
    procedure SetData(Header, Details: TDataSet);
  public
    constructor Create(APresenterWI: TWorkItem; const AViewURI: string); override;
  end;

var
  frTaskBulkItemView: TfrTaskBulkItemView;

implementation

{$R *.dfm}

{ TfrTaskBulkItemView }

constructor TfrTaskBulkItemView.Create(APresenterWI: TWorkItem;
  const AViewURI: string);
begin
  inherited;
end;

function TfrTaskBulkItemView.DetailSelection: ISelection;
begin
  Result := GetChildInterface(grDetails.Name) as ISelection;
end;

procedure TfrTaskBulkItemView.OnInitialize;
begin
  WorkItem.Commands[COMMAND_PRINT_BULKCOLLECT].AddInvoker(acPrintBulkCollect);
  WorkItem.Commands[COMMAND_PRINT_COLLECTTASK].AddInvoker(acPrintCollectTask);
end;

procedure TfrTaskBulkItemView.acPrintDefExecute(Sender: TObject);
begin
 // ExecuteButtonDefAction(btPrint);
end;

function TfrTaskBulkItemView.DetailTabs: ITabs;
begin
  Result := GetChildInterface(tcDetails.Name) as ITabs;
end;

procedure TfrTaskBulkItemView.SetData(Header, Details: TDataSet);
begin
  LinkDataSet(HeaderDataSource, Header);
  LinkDataSet(DetailsDataSource, Details);
end;

end.
