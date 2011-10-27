unit BPMConstExt;

interface
uses
  CommonViewIntf, ViewServiceIntf;

const

// Sal
  ENT_BPM_TASK_VIEW_LIST_SAL = 'SalList';
  ENT_BPM_TASK_VIEW_DATA_SAL = 'SalData';
  ENT_BPM_TASK_VIEW_DATA_REC_SAL = 'SalDataRec';
  ENT_BPM_TASK_VIEW_LINKS_SAL = 'SalLinks';


// SalCert
  BPM_ACTIVITY_CODE_SAL_CERT = 'Sal.Cert';

  ACT_BPM_TASK_LIST_SAL_CERT = 'activities.bpm.task.list.sal.cert';
  ACT_BPM_TASK_LIST_SAL_CERT_CAPTION = 'Задачи [сертификаты]';
  ACT_BPM_TASK_OPEN_SAL_CERT = 'activities.bpm.task.item.sal.cert';
  VIEW_BPM_TASK_LIST_SAL_CERT = 'views.bpm.task.list.sal.cert';
  VIEW_BPM_TASK_ITEM_SAL_CERT = 'views.bpm.task.item.sal.cert';


// SalDLV
  BPM_ACTIVITY_CODE_SAL_DLV = 'Sal.DLV';

  ACT_BPM_TASK_LIST_SAL_DLV = 'activities.bpm.task.list.sal.dlv';
  ACT_BPM_TASK_LIST_SAL_DLV_CAPTION = 'Задачи [доставка]';
  ACT_BPM_TASK_OPEN_SAL_DLV = 'activities.bpm.task.item.sal.dlv';
  VIEW_BPM_TASK_LIST_SAL_DLV = 'views.bpm.task.list.sal.dlv';
  VIEW_BPM_TASK_ITEM_SAL_DLV = 'views.bpm.task.item.sal.dlv';


// SalWh
  BPM_ACTIVITY_CODE_SAL_WH2 = 'Sal.Wh2';
  BPM_ACTIVITY_CODE_SAL_WH3 = 'Sal.Wh3';
  BPM_ACTIVITY_CODE_SAL_WH7 = 'Sal.Wh7';
  BPM_ACTIVITY_CODE_SAL_COLLECT_BULK = 'SALE.COLLECT.BULK';

  ACT_BPM_TASK_DESK_SAL_WH = 'activities.bpm.task.desk.sal.wh';
  ACT_BPM_TASK_DESK_SAL_WH_CAPTION = 'Диспетчер задач [комплектация]';
  VIEW_BPM_TASK_DESK_SAL_WH = 'views.bpm.task.desk.sal.wh';

  VIEW_BPM_TASK_BULK_SALE_COLLECT_JRN_CAPTION = 'Консолидация задач [комплектация]';
  VIEW_BPM_TASK_BULK_SALE_COLLECT_JRN = 'views.BPM_TASKBULK.Journal';

  VIEW_BPM_TASK_BULK_SALE_COLLECT_ITEM_CAPTION = 'Консолидация задач [комплектация]';
  VIEW_BPM_TASK_BULK_SALE_COLLECT_ITEM = 'views.BPM_TASKBULK.sale.collect.item';

  ACT_BPM_TASK_LIST_SAL_WH = 'activities.bpm.task.list.sal.wh';
  ACT_BPM_TASK_LIST_SAL_WH_CAPTION = 'Задачи [комплектация]';
  ACT_BPM_TASK_OPEN_SAL_WH = 'activities.bpm.task.item.sal.wh';
  VIEW_BPM_TASK_LIST_SAL_WH = 'views.bpm.task.list.sal.wh';
  VIEW_BPM_TASK_ITEM_SAL_WH = 'views.bpm.task.item.sal.wh';

type
  TTaskBulkItemData = class(TPresenterData)
  private
    FID: Variant;
    procedure SetID(const Value: Variant);
  published
    property ID: Variant read FID write SetID;
  end;


implementation

{ TTaskBulkItemData }

procedure TTaskBulkItemData.SetID(const Value: Variant);
begin
  FID := Value;
  PresenterID := Value;
end;

end.
