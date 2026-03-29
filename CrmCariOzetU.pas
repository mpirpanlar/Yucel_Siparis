unit CrmCariOzetU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniButton, uniPageControl, uniBasicGrid, uniDBGrid, Data.DB,
  MemDS, DBAccess, Uni;

type
  TfrmCrmCariOzet = class(TUniForm)
    rootPanel: TUniPanel;
    pnlToolbar: TUniPanel;
    lblCari: TUniLabel;
    edCariKod: TUniEdit;
    btnCariBul: TUniButton;
    btnListele: TUniButton;
    btnAc: TUniButton;
    btnKapat: TUniButton;
    pcMain: TUniPageControl;
    tabAktivite: TUniTabSheet;
    panAkt: TUniPanel;
    grdAkt: TUniDBGrid;
    tabGorev: TUniTabSheet;
    panGrv: TUniPanel;
    grdGrv: TUniDBGrid;
    tabTeklif: TUniTabSheet;
    panTek: TUniPanel;
    grdTek: TUniDBGrid;
    qAkt: TUniQuery;
    dsAkt: TUniDataSource;
    qGrv: TUniQuery;
    dsGrv: TUniDataSource;
    qTek: TUniQuery;
    dsTek: TUniDataSource;
    procedure UniFormShow(Sender: TObject);
    procedure btnCariBulClick(Sender: TObject);
    procedure btnListeleClick(Sender: TObject);
    procedure btnAcClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure grdAktAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure grdGrvAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure grdTekAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
  private
    procedure ListeleriYukle;
    procedure AcAktivite;
    procedure AcGorev;
    procedure AcTeklif;
  public
  end;

function frmCrmCariOzet: TfrmCrmCariOzet;

implementation

{$R *.dfm}

uses
  uniGUIApplication, MainModule, DMU, Main, Genel, CrmCariSecU, CrmAktiviteU, CrmGorevU, CrmTeklifU;

function frmCrmCariOzet: TfrmCrmCariOzet;
begin
  Result := TfrmCrmCariOzet(UniMainModule.GetFormInstance(TfrmCrmCariOzet));
end;

procedure TfrmCrmCariOzet.ListeleriYukle;
var
  Ck: string;
begin
  Ck := Trim(edCariKod.Text);
  qAkt.Close;
  qAkt.SQL.Text :=
    'SELECT TOP 100 A.AKTIVITE_ID, ISNULL(TK.KOD, A.TIP) AS TIP_GORUNEN, A.KONU, T.TEKLIF_NO, A.SIPARIS_NO, A.AKTIVITE_TARIHI, A.DURUM ' +
    'FROM dbo.CRM_AKTIVITE A ' +
    'LEFT JOIN dbo.CRM_AKTIVITE_TIP TK ON TK.TIP_ID = A.AKTIVITE_TIP_ID ' +
    'LEFT JOIN dbo.CRM_TEKLIF T ON T.TEKLIF_ID = A.TEKLIF_ID ' +
    'WHERE A.CARI_KOD = :CK AND A.TIP <> ''TASK'' ' +
    'ORDER BY A.AKTIVITE_TARIHI DESC, A.AKTIVITE_ID DESC';
  qAkt.ParamByName('CK').AsString := Ck;
  qAkt.Open;

  qGrv.Close;
  qGrv.SQL.Text :=
    'SELECT TOP 100 G.GOREV_ID, A.AKTIVITE_ID, A.KONU, A.AKTIVITE_TARIHI, A.DURUM, G.BITIS_TARIHI, G.ONCELIK, G.TAMAMLANDI ' +
    'FROM dbo.CRM_GOREV G ' +
    'INNER JOIN dbo.CRM_AKTIVITE A ON A.AKTIVITE_ID = G.AKTIVITE_ID ' +
    'WHERE A.CARI_KOD = :CK AND A.TIP = ''TASK'' ' +
    'ORDER BY A.AKTIVITE_TARIHI DESC, G.GOREV_ID DESC';
  qGrv.ParamByName('CK').AsString := Ck;
  qGrv.Open;

  qTek.Close;
  qTek.SQL.Text :=
    'SELECT TOP 100 TEKLIF_ID, TEKLIF_NO, SIPARIS_NO, BASLIK, TEKLIF_TARIHI, DURUM, TOPLAM_NET ' +
    'FROM dbo.CRM_TEKLIF WHERE CARI_KOD = :CK ORDER BY TEKLIF_TARIHI DESC, TEKLIF_ID DESC';
  qTek.ParamByName('CK').AsString := Ck;
  qTek.Open;
end;

procedure TfrmCrmCariOzet.AcAktivite;
begin
  if not qAkt.Active or qAkt.IsEmpty then
  begin
    UniMainModule.saHata.Show('Once listele yapin ve aktivite satiri secin.');
    Exit;
  end;
  if qAkt.FieldByName('AKTIVITE_ID').IsNull then
    Exit;
  xFormShow(TfrmCrmAktivite, 'CrmYeniAktivite', 1, qAkt.FieldByName('AKTIVITE_ID').AsString);
end;

procedure TfrmCrmCariOzet.AcGorev;
begin
  if not qGrv.Active or qGrv.IsEmpty then
  begin
    UniMainModule.saHata.Show('Once listele yapin ve gorev satiri secin.');
    Exit;
  end;
  if qGrv.FieldByName('AKTIVITE_ID').IsNull then
    Exit;
  xFormShow(TfrmCrmGorev, 'CrmYeniGorev', 1, qGrv.FieldByName('AKTIVITE_ID').AsString);
end;

procedure TfrmCrmCariOzet.AcTeklif;
begin
  if not qTek.Active or qTek.IsEmpty then
  begin
    UniMainModule.saHata.Show('Once listele yapin ve teklif satiri secin.');
    Exit;
  end;
  if qTek.FieldByName('TEKLIF_ID').IsNull then
    Exit;
  xFormShow(TfrmCrmTeklif, 'CrmYeniTeklif', 1, qTek.FieldByName('TEKLIF_ID').AsString);
end;

procedure TfrmCrmCariOzet.UniFormShow(Sender: TObject);
begin
  pcMain.ActivePage := tabAktivite;
end;

procedure TfrmCrmCariOzet.btnCariBulClick(Sender: TObject);
begin
  frmCrmCariSec.HedefCariEdit := edCariKod;
  frmCrmCariSec.edArama.Text := Trim(edCariKod.Text);
  frmCrmCariSec.ShowModal;
  if Trim(edCariKod.Text) <> '' then
    btnListeleClick(Sender);
end;

procedure TfrmCrmCariOzet.btnListeleClick(Sender: TObject);
begin
  if Trim(edCariKod.Text) = '' then
  begin
    UniMainModule.saHata.Show('Cari kod girin veya Bul ile secin.');
    Exit;
  end;
  ListeleriYukle;
end;

procedure TfrmCrmCariOzet.btnAcClick(Sender: TObject);
begin
  if pcMain.ActivePage = tabAktivite then
    AcAktivite
  else if pcMain.ActivePage = tabGorev then
    AcGorev
  else
    AcTeklif;
end;

procedure TfrmCrmCariOzet.btnKapatClick(Sender: TObject);
begin
  MainForm.NavPage.ActivePage.Close;
end;

procedure TfrmCrmCariOzet.grdAktAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if SameText(EventName, 'celldblclick') then
    AcAktivite;
end;

procedure TfrmCrmCariOzet.grdGrvAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if SameText(EventName, 'celldblclick') then
    AcGorev;
end;

procedure TfrmCrmCariOzet.grdTekAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if SameText(EventName, 'celldblclick') then
    AcTeklif;
end;

end.
