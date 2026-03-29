unit CrmAktiviteListeU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniButton,
  uniBasicGrid, uniDBGrid, Data.DB, MemDS, DBAccess, Uni;

type
  TfrmCrmAktiviteListe = class(TUniForm)
    rootPanel: TUniPanel;
    pnlToolbar: TUniPanel;
    btnListele: TUniButton;
    btnAc: TUniButton;
    btnKapat: TUniButton;
    grd: TUniDBGrid;
    qList: TUniQuery;
    dsList: TUniDataSource;
    procedure UniFormShow(Sender: TObject);
    procedure btnListeleClick(Sender: TObject);
    procedure btnAcClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure grdAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
  private
    procedure AcKayit;
  public
  end;

function frmCrmAktiviteListe: TfrmCrmAktiviteListe;

implementation

{$R *.dfm}

uses
  uniGUIApplication, MainModule, DMU, Main, Genel, CrmAktiviteU;

function frmCrmAktiviteListe: TfrmCrmAktiviteListe;
begin
  Result := TfrmCrmAktiviteListe(UniMainModule.GetFormInstance(TfrmCrmAktiviteListe));
end;

procedure TfrmCrmAktiviteListe.AcKayit;
begin
  if not qList.Active or qList.IsEmpty then
  begin
    UniMainModule.saHata.Show('Once listele yapin ve bir satir secin.');
    Exit;
  end;
  if qList.FieldByName('AKTIVITE_ID').IsNull then
    Exit;
  xFormShow(TfrmCrmAktivite, 'CrmYeniAktivite', 1, qList.FieldByName('AKTIVITE_ID').AsString);
end;

procedure TfrmCrmAktiviteListe.btnAcClick(Sender: TObject);
begin
  AcKayit;
end;

procedure TfrmCrmAktiviteListe.btnKapatClick(Sender: TObject);
begin
  MainForm.NavPage.ActivePage.Close;
end;

procedure TfrmCrmAktiviteListe.btnListeleClick(Sender: TObject);
begin
  qList.Close;
  qList.SQL.Text :=
    'SELECT A.AKTIVITE_ID, A.TIP, A.KONU, A.CARI_KOD, A.AKTIVITE_TARIHI, A.DURUM, T.TEKLIF_NO, A.SIPARIS_NO ' +
    'FROM dbo.CRM_AKTIVITE A ' +
    'LEFT JOIN dbo.CRM_TEKLIF T ON T.TEKLIF_ID = A.TEKLIF_ID ' +
    'WHERE A.TIP <> ''TASK'' ORDER BY A.AKTIVITE_ID DESC';
  qList.Open;
end;

procedure TfrmCrmAktiviteListe.grdAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if SameText(EventName, 'celldblclick') then
    AcKayit;
end;

procedure TfrmCrmAktiviteListe.UniFormShow(Sender: TObject);
begin
  btnListeleClick(Self);
end;

end.
