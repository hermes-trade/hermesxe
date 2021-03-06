unit SalRetDeskView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxLookAndFeelPainters, ActnList, cxPC,
  cxControls, cxContainer, cxEdit, cxGroupBox, CustomView, Menus, cxStyles,
  cxGraphics, cxCustomData, cxFilter, cxData, cxDataStorage, DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxSplitter,
  cxInplaceContainer, cxVGrid, cxDBVGrid, StdCtrls, cxButtons, cxLabel,
  cxTextEdit, cxMaskEdit, cxButtonEdit, cxDropDownEdit, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter,
  cxGridBandedTableView, cxGridDBBandedTableView, cxDBLookupComboBox,
  SalRetDeskPresenter, UIClasses;



type
  TfrSalRetDeskView = class(TfrCustomView, ISalRetDeskView)
    HeadDataSource: TDataSource;
    RecDataSource: TDataSource;
    cxGroupBox1: TcxGroupBox;
    DOC_NUM: TcxButtonEdit;
    cxLabel1: TcxLabel;
    DOC_KIND: TcxComboBox;
    cxLabel2: TcxLabel;
    FORWARDER_NAME: TcxButtonEdit;
    grData: TcxDBVerticalGrid;
    cxSplitter1: TcxSplitter;
    grDataRec: TcxGrid;
    grDataRecLevel1: TcxGridLevel;
    grDataRecView: TcxGridDBBandedTableView;
    grDataRecViewGDS_ID: TcxGridDBBandedColumn;
    grDataRecViewGDS_NAME: TcxGridDBBandedColumn;
    grDataRecViewSAL_QTY: TcxGridDBBandedColumn;
    grDataRecViewPRICE: TcxGridDBBandedColumn;
    grDataRecViewSUMM: TcxGridDBBandedColumn;
    grDataRecViewQTY2: TcxGridDBBandedColumn;
    grDataRecViewQTY3: TcxGridDBBandedColumn;
    grDataRecViewQTY4: TcxGridDBBandedColumn;
    grDataRecViewQTY5: TcxGridDBBandedColumn;
    grDataRecViewQTY: TcxGridDBBandedColumn;
    grDataRecViewQTY1: TcxGridDBBandedColumn;
    grDataRecViewGDS2_NAME: TcxGridDBBandedColumn;
    grDataRecViewGDS2_QTY: TcxGridDBBandedColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyleInfoBk: TcxStyle;
    Gds2DataSource: TDataSource;
    procedure DOC_NUMPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure FORWARDER_NAMEPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure grDataRecViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  protected
    procedure SetViewMode(AValue: TViewMode);
    procedure SetDataSets(AHead, ARec, AGds2: TDataSet);
    procedure SetFrwd(const AName: string);
    function GetDOCNUM: string;
    procedure SetDOCNUM(const AValue: string);
    function GetDOCKIND: integer;
    procedure SetDOCKIND(AValue: integer);
  end;


implementation

{$R *.dfm}


{ TfrSalRetDeskView }

procedure TfrSalRetDeskView.DOC_NUMPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  doc_num.PostEditValue;
  WorkItem.Commands[Command_LoadDoc].Execute;
end;


procedure TfrSalRetDeskView.FORWARDER_NAMEPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  case AButtonIndex of
    0: WorkItem.Commands[Command_SelectForwarder].Execute;
    1: WorkItem.Commands[Command_ClearForwarder].Execute;
  end;
end;


function TfrSalRetDeskView.GetDOCKIND: integer;
begin
  Result := DOC_KIND.ItemIndex;
end;

function TfrSalRetDeskView.GetDOCNUM: string;
begin
  Result := DOC_NUM.Text;
end;

procedure TfrSalRetDeskView.SetViewMode(AValue: TViewMode);
var
  I: integer;
begin


  for I := 0 to grDataRecView.ColumnCount - 1 do
    grDataRecView.Columns[I].Options.Editing := false;

  if AValue = vmCreate then
  begin
    grDataRecViewQTY.Options.Editing := true;
    grDataRecViewQTY1.Options.Editing := true;
    grDataRecViewQTY2.Options.Editing := true;
    grDataRecViewQTY3.Options.Editing := true;
    grDataRecViewQTY4.Options.Editing := true;
    grDataRecViewQTY5.Options.Editing := true;
    grDataRecViewGDS2_QTY.Options.Editing := true;
    grDataRecViewGDS2_NAME.Options.Editing := true;
    FORWARDER_NAME.Properties.Buttons[0].Enabled := true;
    //btProcess.Action := acPostDoc;
  end
  else
  begin
    //btProcess.Action := acRollbackDoc;
    FORWARDER_NAME.Properties.Buttons[0].Enabled := false;
  end
end;

procedure TfrSalRetDeskView.grDataRecViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  exit;
  if not AViewInfo.Selected then
  if SameText(TcxGridDBBandedColumn(AViewInfo.Item).DataBinding.FieldName, 'QTY') then
  begin
    ACanvas.Brush.Color := clInfoBk;
    ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];
  end;

end;

procedure TfrSalRetDeskView.SetDataSets(AHead, ARec, AGds2: TDataSet);
begin
  LinkDataSet(HeadDataSource, AHead);
  LinkDataSet(RecDataSource, ARec);
  LinkDataSet(Gds2DataSource, AGds2);
end;

procedure TfrSalRetDeskView.SetDOCKIND(AValue: integer);
begin
  DOC_KIND.ItemIndex := AValue;
end;

procedure TfrSalRetDeskView.SetDOCNUM(const AValue: string);
begin
  DOC_NUM.Text := AValue;
end;

procedure TfrSalRetDeskView.SetFrwd(const AName: string);
begin
  FORWARDER_NAME.Text := AName;
end;

end.
