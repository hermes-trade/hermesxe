unit AcntJournalView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Menus, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, DB, cxDBData, ActnList,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxGrid,
  cxPC, StdCtrls, cxButtons, cxGroupBox, AcntJournalPresenter, cxVGrid,
  cxDBVGrid, cxInplaceContainer, cxSplitter, CustomContentView, UIClasses,
  cxGridDBTableView;

type
  TfrAcntJournalView = class(TfrCustomContentView, IAcntJournalView)
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    BSDataSource: TDataSource;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    pcTotal: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    grBS: TcxDBVerticalGrid;
    grBSDBEditorRow2: TcxDBEditorRow;
    grBSDBEditorRow3: TcxDBEditorRow;
    grBSDBEditorRow4: TcxDBEditorRow;
    grBSDBEditorRow5: TcxDBEditorRow;
    grBSDBEditorRow1: TcxDBEditorRow;
    cxSplitter1: TcxSplitter;
    grBSTopCategory: TcxCategoryRow;
    JrnDataSource: TDataSource;
    pnInfo: TcxGroupBox;
    grList: TcxGrid;
    grJrnView: TcxGridDBTableView;
    grListLevel1: TcxGridLevel;
    procedure grJrnViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
  protected
    function GetCorrAcnt: variant;
    procedure SetBSDateRangeInfo(Date1, Date2: TDateTime);
    procedure SetBSData(ADataSet: TDataSet);
    function Selection: ISelection;
    procedure SetInfoText(const AText: string);
    procedure SetJournalDataSet(ADataSet: TDataSet);
  end;



implementation

{$R *.dfm}

{ TfrAcntJournalView }

function TfrAcntJournalView.GetCorrAcnt: variant;
begin
 { Result := Unassigned;
  if grJrnView.Controller.SelectedRowCount > 0 then
  begin
    KeyFieldIndex := grJrnView.GetColumnByFieldName(grJrnView.DataController.KeyFieldNames).Index;
    Result := grAcntListView.Controller.SelectedRecords[0].Values[KeyFieldIndex];
  end
  }
end;

function TfrAcntJournalView.Selection: ISelection;
begin
  Result := GetChildInterface(grJrnView.Name) as ISelection;
end;

procedure TfrAcntJournalView.SetBSData(ADataSet: TDataSet);
begin
  LinkDataSet(BSDataSource, ADataSet);
end;

procedure TfrAcntJournalView.SetBSDateRangeInfo(Date1, Date2: TDateTime);
var
  bsRangeInfo: string;
begin
  bsRangeInfo := 'с ' + DateToStr(Date1) + ' по ' + DateToStr(Date2);
  grBSTopCategory.Properties.Caption := bsRangeInfo;
end;

procedure TfrAcntJournalView.SetInfoText(const AText: string);
begin
  pnInfo.Caption := AText;
  pnInfo.Visible := AText <> '';
end;

procedure TfrAcntJournalView.SetJournalDataSet(ADataSet: TDataSet);
begin
  LinkDataSet(JrnDataSource, ADataSet);
end;

procedure TfrAcntJournalView.grJrnViewCellDblClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  WorkItem.Commands[COMMAND_OPEN].Execute;
end;

end.
