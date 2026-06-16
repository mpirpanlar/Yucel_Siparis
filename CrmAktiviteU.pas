unit CrmAktiviteU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniMemo, uniDateTimePicker, uniButton, uniDBLookupComboBox,
  Data.DB, MemDS, DBAccess, Uni, uniMultiItem, uniComboBox, uniDBComboBox,
  uniBasicGrid, uniDBGrid, uniFileUpload, uniCheckBox, uniPageControl,
  uniSweetAlert,
  CrmAktiviteKontrolU;

type
  TfrmCrmAktivite = class(TUniForm)
    rootPanel: TUniPanel;
    panMain: TUniPanel;
    lblTip: TUniLabel;
    lkTip: TUniDBLookupComboBox;
    lblKonu: TUniLabel;
    edKonu: TUniEdit;
    lblAciklama: TUniLabel;
    mmAciklama: TUniMemo;
    lblCari: TUniLabel;
    edCariKod: TUniEdit;
    btnCariBul: TUniButton;
    lblCariAd: TUniLabel;
    lblPot: TUniLabel;
    edPotId: TUniEdit;
    btnPotBul: TUniButton;
    lblPotUnvan: TUniLabel;
    lblTeklif: TUniLabel;
    lkTeklif: TUniDBLookupComboBox;
    btnTeklifYenile: TUniButton;
    lblSiparis: TUniLabel;
    edSiparis: TUniEdit;
    btnSiparisBul: TUniButton;
    lblSiparisTar: TUniLabel;
    lblSiparisAcik: TUniLabel;
    saBaglantiDurum: TUniSweetAlert;
    lblTarih: TUniLabel;
    dtAktivite: TUniDateTimePicker;
    lblDurum: TUniLabel;
    lkDurum: TUniDBLookupComboBox;
    lblOncelik: TUniLabel;
    cbOncelik: TUniComboBox;
    lblEkler: TUniLabel;
    fuEk: TUniFileUpload;
    btnEkEkle: TUniButton;
    btnEkIndir: TUniButton;
    btnEkSil: TUniButton;
    grdEk: TUniDBGrid;
    panFooter: TUniPanel;
    btnKaydet: TUniButton;
    qExec: TUniQuery;
    qLoad: TUniQuery;
    qTipLkp: TUniQuery;
    dsTipLkp: TUniDataSource;
    qDurLkp: TUniQuery;
    dsDurLkp: TUniDataSource;
    qTekLkp: TUniQuery;
    dsTekLkp: TUniDataSource;
    qEk: TUniQuery;
    dsEk: TUniDataSource;
    qEkExec: TUniQuery;
    pgc: TUniPageControl;
    tsGenel: TUniTabSheet;
    tsKontrol: TUniTabSheet;
    tsTarihce: TUniTabSheet;
    grdTarihce: TUniDBGrid;
    panKontrolTb: TUniPanel;
    lblKontrolBilgi: TUniLabel;
    btnKontrolKaydet: TUniButton;
    panKontrol: TUniPanel;
    qKontrol: TUniQuery;
    qSecenek: TUniQuery;
    qCevap: TUniQuery;
    qKontrolExec: TUniQuery;
    qLog: TUniQuery;
    dsLog: TUniDataSource;
    qLogExec: TUniQuery;
    procedure UniFormShow(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnCariBulClick(Sender: TObject);
    procedure btnPotBulClick(Sender: TObject);
    procedure btnSiparisBulClick(Sender: TObject);
    procedure btnTeklifYenileClick(Sender: TObject);
    procedure lkTeklifCloseUp(Sender: TObject);
    procedure lkDurumCloseUp(Sender: TObject);
    procedure saBaglantiDurumConfirm(Sender: TObject);
    procedure fuEkCompleted(Sender: TObject; AStream: TFileStream);
    procedure btnEkEkleClick(Sender: TObject);
    procedure btnEkIndirClick(Sender: TObject);
    procedure btnEkSilClick(Sender: TObject);
    procedure grdEkAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure lkTipCloseUp(Sender: TObject);
    procedure btnKontrolKaydetClick(Sender: TObject);
  private
    FAktiviteId: Int64;
    FPendingDurumId: Int64;
    FCrmKontrol: TCrmAktiviteKontrolYonetici;
    procedure KontrolSekmesiGoster(Sender: TObject);
    procedure KontrolListesiYukle;
    procedure EnsureCrmKontrol;
    procedure EnsureEkUpload;
    function AktiviteKaydet: Boolean;
    procedure EkListele;
    procedure TarihceYukle;
    procedure AktiviteLogKaydet(const IsNew: Boolean; const OldKonu, OldAcik, OldTarStr, OldDurAd: string);
    procedure EkIndir;
    procedure EkSil;
    procedure AcLookupSorgulari;
    procedure VarsayilanSecimler;
    procedure TeklifLookupYenile(AForceTid: Int64);
    procedure UygulaBaslangicTeklif(ATeklifId: Int64);
    procedure UygulaBaslangicPotansiyel(APotId: Int64);
    procedure PotSecildi(Sender: TObject; APotId: Int64);
    procedure PotansiyelUnvanYukle(APotId: Int64);
    function PotansiyelIdOku: Int64;
    procedure YeniKayit;
    procedure YukleKayit;
    function TipKodFromLookup: string;
    function DurumKodFromLookup: string;
    procedure YukleOncelik;
    function OncelikKodFromCombo: string;
    procedure ComboSetOncelik(const AKod: string);
    procedure BaglantiDurumDegerlendir(const AKaynakTip: string);
    procedure SiparisSecildi(Sender: TObject; const ASiparisKod: string);
    function MevcutDurumId: Int64;
  public
    destructor Destroy; override;
  end;

function frmCrmAktivite: TfrmCrmAktivite;

implementation

{$R *.dfm}

uses
  uniGUIApplication, MainModule, DMU, TmpU, CrmCariSecU, CrmSiparisSecU, CrmBaglantiDurumU,
  CrmPotSecU, ServerModule, CrmAktiviteLogU;

procedure TfrmCrmAktivite.btnCariBulClick(Sender: TObject);
var
  PrevTkl: Int64;
begin
  PrevTkl := 0;
  if not VarIsNull(lkTeklif.KeyValue) and not VarIsEmpty(lkTeklif.KeyValue) then
    PrevTkl := lkTeklif.KeyValue;
  frmCrmCariSec.HedefCariEdit := edCariKod;
  frmCrmCariSec.HedefCariAdLabel := lblCariAd;
  frmCrmCariSec.edArama.Text := Trim(edCariKod.Text);
  frmCrmCariSec.ShowModal;
  //frmCrmCariSec.HedefCariAdLabel := nil;
  TeklifLookupYenile(0);
  if PrevTkl > 0 then
  begin
    if qTekLkp.Active and qTekLkp.Locate('TEKLIF_ID', PrevTkl, []) then
      lkTeklif.KeyValue := PrevTkl
    else
      lkTeklif.KeyValue := Null;
  end;
end;

function TfrmCrmAktivite.PotansiyelIdOku: Int64;
begin
  Result := StrToInt64Def(Trim(edPotId.Text), 0);
end;

procedure TfrmCrmAktivite.PotansiyelUnvanYukle(APotId: Int64);
begin
  lblPotUnvan.Caption := '';
  if APotId <= 0 then
    Exit;
  qLoad.Close;
  qLoad.SQL.Text :=
    'SELECT FIRMA_UNVAN FROM dbo.CRM_POTANSIYEL_MUSTERI WHERE POTANSIYEL_ID = :ID';
  qLoad.ParamByName('ID').AsLargeInt := APotId;
  qLoad.Open;
  if not qLoad.IsEmpty then
    lblPotUnvan.Caption := Trim(qLoad.FieldByName('FIRMA_UNVAN').AsString);
  qLoad.Close;
end;

procedure TfrmCrmAktivite.PotSecildi(Sender: TObject; APotId: Int64);
var
  Ck, CariAd: string;
begin
  if APotId <= 0 then
    Exit;
  edPotId.Text := IntToStr(APotId);
  PotansiyelUnvanYukle(APotId);
  if Trim(edCariKod.Text) <> '' then
  begin
    if UniSession <> nil then
      UniSession.Synchronize;
    Exit;
  end;
  qLoad.Close;
  qLoad.SQL.Text :=
    'SELECT P.NETSIS_CARI_KOD, C.CARI_ISIM FROM dbo.CRM_POTANSIYEL_MUSTERI P ' +
    'LEFT JOIN YUCEL..HV_CARI_LISTESI C WITH(NOLOCK) ON C.CARI_KOD = P.NETSIS_CARI_KOD ' +
    'WHERE P.POTANSIYEL_ID = :ID';
  qLoad.ParamByName('ID').AsLargeInt := APotId;
  qLoad.Open;
  if not qLoad.IsEmpty then
  begin
    if not qLoad.FieldByName('NETSIS_CARI_KOD').IsNull then
      Ck := Trim(qLoad.FieldByName('NETSIS_CARI_KOD').AsString)
    else
      Ck := '';
    if Ck <> '' then
    begin
      edCariKod.Text := Ck;
      if (qLoad.FindField('CARI_ISIM') <> nil) and not qLoad.FieldByName('CARI_ISIM').IsNull then
        CariAd := Trim(qLoad.FieldByName('CARI_ISIM').AsString)
      else
        CariAd := '';
      lblCariAd.Caption := CariAd;
      TeklifLookupYenile(0);
    end;
  end;
  qLoad.Close;
  if UniSession <> nil then
    UniSession.Synchronize;
end;

procedure TfrmCrmAktivite.btnPotBulClick(Sender: TObject);
begin
  frmCrmPotSec.HedefPotansiyelIdEdit := edPotId;
  frmCrmPotSec.HedefPotansiyelUnvanLabel := lblPotUnvan;
  frmCrmPotSec.OnPotansiyelSecildi := PotSecildi;
  frmCrmPotSec.SecimModuHazirla(False);
  frmCrmPotSec.edArama.Text := Trim(lblPotUnvan.Caption);
  frmCrmPotSec.ShowModal;
end;

procedure TfrmCrmAktivite.UygulaBaslangicPotansiyel(APotId: Int64);
begin
  if APotId <= 0 then
    Exit;
  PotSecildi(Self, APotId);
end;

procedure TfrmCrmAktivite.btnTeklifYenileClick(Sender: TObject);
var
  PrevTkl: Int64;
begin
  PrevTkl := 0;
  if not VarIsNull(lkTeklif.KeyValue) and not VarIsEmpty(lkTeklif.KeyValue) then
    PrevTkl := lkTeklif.KeyValue;
  TeklifLookupYenile(PrevTkl);
  if PrevTkl > 0 then
  begin
    if qTekLkp.Active and qTekLkp.Locate('TEKLIF_ID', PrevTkl, []) then
      lkTeklif.KeyValue := PrevTkl
    else
      lkTeklif.KeyValue := Null;
  end;
end;

function TfrmCrmAktivite.MevcutDurumId: Int64;
begin
  Result := 0;
  if VarIsNull(lkDurum.KeyValue) or VarIsEmpty(lkDurum.KeyValue) then
    Exit;
  Result := lkDurum.KeyValue;
end;

procedure TfrmCrmAktivite.BaglantiDurumDegerlendir(const AKaynakTip: string);
var
  K: TCrmBaglantiKuralSonuc;
begin
  K := CrmBaglantiKuralGet(qLoad, AKaynakTip);
  if not K.Bulundu then
    Exit;
  if MevcutDurumId = K.HedefDurumId then
    Exit;
  if K.PromptKullanici then
  begin
    FPendingDurumId := K.HedefDurumId;
    saBaglantiDurum.Text :=
      CrmKaynakTipAciklama(AKaynakTip) + ': durumu "' + K.HedefDurumAd + '" yapilsin mi?';
    saBaglantiDurum.Show;
  end
  else if K.SessizUygula then
    lkDurum.KeyValue := K.HedefDurumId;
end;

procedure TfrmCrmAktivite.saBaglantiDurumConfirm(Sender: TObject);
begin
  if FPendingDurumId > 0 then
    lkDurum.KeyValue := FPendingDurumId;
  FPendingDurumId := 0;
end;

procedure TfrmCrmAktivite.SiparisSecildi(Sender: TObject; const ASiparisKod: string);
begin
  BaglantiDurumDegerlendir(CRM_KAYNAK_SIPARIS);
end;

procedure TfrmCrmAktivite.btnSiparisBulClick(Sender: TObject);
begin
  frmCrmSiparisSec.HedefSiparisEdit := edSiparis;
  frmCrmSiparisSec.HedefSiparisTarLabel := lblSiparisTar;
  frmCrmSiparisSec.HedefSiparisAcikLabel := lblSiparisAcik;
  frmCrmSiparisSec.FiltreCariKod := Trim(edCariKod.Text);
  frmCrmSiparisSec.OnSiparisSecildi := SiparisSecildi;
  frmCrmSiparisSec.edArama.Text := Trim(edSiparis.Text);
  frmCrmSiparisSec.ShowModal;
  frmCrmSiparisSec.OnSiparisSecildi := nil;
end;

procedure TfrmCrmAktivite.lkTeklifCloseUp(Sender: TObject);
begin
  BaglantiDurumDegerlendir(CRM_KAYNAK_TEKLIF);
end;

procedure TfrmCrmAktivite.lkDurumCloseUp(Sender: TObject);
var
  Did: Int64;
begin
  Did := MevcutDurumId;
  if CrmDurumKapanisMi(qLoad, Did) then
    BaglantiDurumDegerlendir(CRM_KAYNAK_KAPANIS);
end;

function frmCrmAktivite: TfrmCrmAktivite;
begin
  Result := TfrmCrmAktivite(UniMainModule.GetFormInstance(TfrmCrmAktivite));
end;

procedure TfrmCrmAktivite.AcLookupSorgulari;
begin
  qTipLkp.Close;
  qTipLkp.SQL.Text :=
    'SELECT TIP_ID, KOD, (KOD + N'' - '' + ISNULL(ACIKLAMA, N'''')) AS AD ' +
    'FROM dbo.CRM_AKTIVITE_TIP WHERE AKTIF = 1 AND KOD <> ''TASK'' ORDER BY SIRA, TIP_ID';
  qTipLkp.Open;

  qDurLkp.Close;
  qDurLkp.SQL.Text :=
    'SELECT DURUM_ID, KOD, (KOD + N'' - '' + ISNULL(ACIKLAMA, N'''')) AS AD ' +
    'FROM dbo.CRM_AKTIVITE_DURUM WHERE AKTIF = 1 ORDER BY SIRA, DURUM_ID';
  qDurLkp.Open;
end;

procedure TfrmCrmAktivite.UygulaBaslangicTeklif(ATeklifId: Int64);
begin
  if ATeklifId <= 0 then
    Exit;
  qLoad.Close;
  qLoad.SQL.Text :=
    'SELECT T.CARI_KOD, C.CARI_ISIM FROM dbo.CRM_TEKLIF T ' +
    'LEFT JOIN YUCEL..HV_CARI_LISTESI C WITH(NOLOCK) ON C.CARI_KOD = T.CARI_KOD ' +
    'WHERE T.TEKLIF_ID = :T';
  qLoad.ParamByName('T').AsLargeInt := ATeklifId;
  qLoad.Open;
  if not qLoad.IsEmpty then
  begin
    if not qLoad.FieldByName('CARI_KOD').IsNull then
      edCariKod.Text := Trim(qLoad.FieldByName('CARI_KOD').AsString);
    if (qLoad.FindField('CARI_ISIM') <> nil) and not qLoad.FieldByName('CARI_ISIM').IsNull then
      lblCariAd.Caption := Trim(qLoad.FieldByName('CARI_ISIM').AsString)
    else
      lblCariAd.Caption := '';
  end;
  qLoad.Close;
  TeklifLookupYenile(ATeklifId);
  if qTekLkp.Active and qTekLkp.Locate('TEKLIF_ID', ATeklifId, []) then
    lkTeklif.KeyValue := ATeklifId
  else
    lkTeklif.KeyValue := Null;
  BaglantiDurumDegerlendir(CRM_KAYNAK_TEKLIF);
end;

procedure TfrmCrmAktivite.TeklifLookupYenile(AForceTid: Int64);
var
  Ck: string;
begin
  Ck := Trim(edCariKod.Text);
  qTekLkp.Close;
  qTekLkp.SQL.Text :=
    'SELECT TOP 200 T.TEKLIF_ID, (ISNULL(T.TEKLIF_NO, N'''') + N'' - '' + T.BASLIK) AS AD ' +
    'FROM dbo.CRM_TEKLIF T WHERE ((:CK = '''') OR (T.CARI_KOD = :CK)) ' +
    'OR ((:FID > 0) AND (T.TEKLIF_ID = :FID)) ORDER BY T.TEKLIF_ID DESC';
  qTekLkp.ParamByName('CK').AsString := Ck;
  qTekLkp.ParamByName('FID').AsLargeInt := AForceTid;
  qTekLkp.Open;
end;

procedure TfrmCrmAktivite.VarsayilanSecimler;
begin
  lkTip.KeyValue := Null;
  if qTipLkp.Active and not qTipLkp.IsEmpty then
    lkTip.KeyValue := qTipLkp.FieldByName('TIP_ID').AsLargeInt;

  lkDurum.KeyValue := Null;
  if qDurLkp.Active and qDurLkp.Locate('KOD', 'ACIK', [loCaseInsensitive]) then
    lkDurum.KeyValue := qDurLkp.FieldByName('DURUM_ID').AsLargeInt
  else if qDurLkp.Active and not qDurLkp.IsEmpty then
    lkDurum.KeyValue := qDurLkp.FieldByName('DURUM_ID').AsLargeInt;
end;

function TfrmCrmAktivite.TipKodFromLookup: string;
begin
  Result := '';
  if VarIsNull(lkTip.KeyValue) or VarIsEmpty(lkTip.KeyValue) then
    Exit;
  if qTipLkp.Active and qTipLkp.Locate('TIP_ID', lkTip.KeyValue, []) then
    Result := qTipLkp.FieldByName('KOD').AsString;
end;

function TfrmCrmAktivite.DurumKodFromLookup: string;
begin
  Result := '';
  if VarIsNull(lkDurum.KeyValue) or VarIsEmpty(lkDurum.KeyValue) then
    Exit;
  if qDurLkp.Active and qDurLkp.Locate('DURUM_ID', lkDurum.KeyValue, []) then
    Result := qDurLkp.FieldByName('KOD').AsString;
end;

procedure TfrmCrmAktivite.YukleOncelik;
begin
  cbOncelik.Items.Clear;
  cbOncelik.Items.Add('D' + #$00FC + #$015F + #$00FC + 'k');
  cbOncelik.Items.Add('Orta');
  cbOncelik.Items.Add('Y' + #$00FC + 'ksek');
  cbOncelik.ItemIndex := 1;
end;

function TfrmCrmAktivite.OncelikKodFromCombo: string;
begin
  case cbOncelik.ItemIndex of
    0: Result := 'DUSUK';
    2: Result := 'YUKSEK';
  else
    Result := 'ORTA';
  end;
end;

procedure TfrmCrmAktivite.ComboSetOncelik(const AKod: string);
begin
  if SameText(AKod, 'DUSUK') then
    cbOncelik.ItemIndex := 0
  else if SameText(AKod, 'YUKSEK') then
    cbOncelik.ItemIndex := 2
  else
    cbOncelik.ItemIndex := 1;
end;

procedure TfrmCrmAktivite.YeniKayit;
begin
  FAktiviteId := 0;
  Caption := 'Yeni Aktivite';
  edKonu.Text := '';
  mmAciklama.Text := '';
  edCariKod.Text := '';
  lblCariAd.Caption := '';
  edPotId.Text := '';
  lblPotUnvan.Caption := '';
  dtAktivite.DateTime := Now;
  AcLookupSorgulari;
  VarsayilanSecimler;
  TeklifLookupYenile(0);
  lkTeklif.KeyValue := Null;
  edSiparis.Text := '';
  lblSiparisTar.Caption := '';
  lblSiparisAcik.Caption := '';
  YukleOncelik;
  EkListele;
  KontrolListesiYukle;
end;

procedure TfrmCrmAktivite.YukleKayit;
var
  TipKod: string;
  Tid: Int64;
begin
  qLoad.Close;
  qLoad.SQL.Text :=
    'SELECT A.AKTIVITE_TIP_ID, A.AKTIVITE_DURUM_ID, A.KONU, A.ACIKLAMA, A.CARI_KOD, A.POTANSIYEL_ID, ' +
    'A.AKTIVITE_TARIHI, A.DURUM, A.ONCELIK, A.TEKLIF_ID, A.SIPARIS_NO, TK.KOD AS TIP_KOD, C.CARI_ISIM, P.FIRMA_UNVAN AS POT_UNVAN ' +
    'FROM dbo.CRM_AKTIVITE A ' +
    'LEFT JOIN dbo.CRM_AKTIVITE_TIP TK ON TK.TIP_ID = A.AKTIVITE_TIP_ID ' +
    'LEFT JOIN YUCEL..HV_CARI_LISTESI C WITH(NOLOCK) ON C.CARI_KOD = A.CARI_KOD ' +
    'LEFT JOIN dbo.CRM_POTANSIYEL_MUSTERI P ON P.POTANSIYEL_ID = A.POTANSIYEL_ID ' +
    'WHERE A.AKTIVITE_ID = :ID';
  qLoad.ParamByName('ID').AsLargeInt := FAktiviteId;
  qLoad.Open;
  if qLoad.IsEmpty then
  begin
    qLoad.Close;
    UniMainModule.saHata.Show('Aktivite bulunamad�.');
    YeniKayit;
    Exit;
  end;
  TipKod := qLoad.FieldByName('TIP_KOD').AsString;
  if SameText(TipKod, 'TASK') then
  begin
    qLoad.Close;
    UniMainModule.saHata.Show('Bu kay�t g�rev tipindedir; G�rev listesinden a��n�z.');
    YeniKayit;
    Exit;
  end;

  Tid := 0;
  if not qLoad.FieldByName('TEKLIF_ID').IsNull then
    Tid := qLoad.FieldByName('TEKLIF_ID').AsLargeInt;

  AcLookupSorgulari;
  TeklifLookupYenile(Tid);
  lkTip.KeyValue := qLoad.FieldByName('AKTIVITE_TIP_ID').AsLargeInt;
  lkDurum.KeyValue := qLoad.FieldByName('AKTIVITE_DURUM_ID').AsLargeInt;
  if Tid > 0 then
    lkTeklif.KeyValue := Tid
  else
    lkTeklif.KeyValue := Null;

  edKonu.Text := qLoad.FieldByName('KONU').AsString;
  mmAciklama.Text := qLoad.FieldByName('ACIKLAMA').AsString;
  if qLoad.FieldByName('CARI_KOD').IsNull then
  begin
    edCariKod.Text := '';
    lblCariAd.Caption := '';
  end
  else
  begin
    edCariKod.Text := qLoad.FieldByName('CARI_KOD').AsString;
    if (qLoad.FindField('CARI_ISIM') <> nil) and not qLoad.FieldByName('CARI_ISIM').IsNull then
      lblCariAd.Caption := Trim(qLoad.FieldByName('CARI_ISIM').AsString)
    else
      lblCariAd.Caption := '';
  end;
  if (qLoad.FindField('POTANSIYEL_ID') <> nil) and not qLoad.FieldByName('POTANSIYEL_ID').IsNull then
  begin
    edPotId.Text := qLoad.FieldByName('POTANSIYEL_ID').AsString;
    if (qLoad.FindField('POT_UNVAN') <> nil) and not qLoad.FieldByName('POT_UNVAN').IsNull then
      lblPotUnvan.Caption := Trim(qLoad.FieldByName('POT_UNVAN').AsString)
    else
      PotansiyelUnvanYukle(qLoad.FieldByName('POTANSIYEL_ID').AsLargeInt);
  end
  else
  begin
    edPotId.Text := '';
    lblPotUnvan.Caption := '';
  end;
  if qLoad.FieldByName('AKTIVITE_TARIHI').IsNull then
    dtAktivite.DateTime := Now
  else
    dtAktivite.DateTime := qLoad.FieldByName('AKTIVITE_TARIHI').AsDateTime;
  if (qLoad.FindField('SIPARIS_NO') <> nil) and not qLoad.FieldByName('SIPARIS_NO').IsNull then
    edSiparis.Text := Trim(qLoad.FieldByName('SIPARIS_NO').AsString)
  else
    edSiparis.Text := '';
  lblSiparisTar.Caption := '';
  lblSiparisAcik.Caption := '';
  YukleOncelik;
  if (qLoad.FindField('ONCELIK') <> nil) and not qLoad.FieldByName('ONCELIK').IsNull then
    ComboSetOncelik(qLoad.FieldByName('ONCELIK').AsString)
  else
    ComboSetOncelik('ORTA');
  qLoad.Close;
  EkListele;
  KontrolListesiYukle;
  TarihceYukle;
  Caption := 'Aktivite';
end;

procedure TfrmCrmAktivite.TarihceYukle;
begin
  CrmTarihceYukle(qLog, FAktiviteId);
end;

procedure TfrmCrmAktivite.AktiviteLogKaydet(const IsNew: Boolean; const OldKonu, OldAcik, OldTarStr, OldDurAd: string);
var
  KulId: Integer;
begin
  if FAktiviteId <= 0 then
    Exit;
  KulId := Tmp.xKullaniciID;
  if IsNew then
  begin
    CrmLogEkle(qLogExec, FAktiviteId, 'AKTIVITE', 'OLUSTUR', '', '', edKonu.Text, 'Yeni aktivite', KulId);
    Exit;
  end;
  CrmLogAlanDegisti(qLogExec, FAktiviteId, 'AKTIVITE', 'KONU_DEGIS', 'Konu', OldKonu, edKonu.Text, KulId);
  CrmLogAlanDegisti(qLogExec, FAktiviteId, 'AKTIVITE', 'ACIKLAMA_DEGIS', 'Aciklama', OldAcik, mmAciklama.Text, KulId);
  CrmLogAlanDegisti(qLogExec, FAktiviteId, 'AKTIVITE', 'TARIH_DEGIS', 'Aktivite Tarihi', OldTarStr,
    CrmTarihMetin(dtAktivite.DateTime), KulId);
  CrmLogAlanDegisti(qLogExec, FAktiviteId, 'AKTIVITE', 'DURUM_DEGIS', 'Durum', OldDurAd, Trim(lkDurum.Text), KulId);
end;

procedure TfrmCrmAktivite.EnsureEkUpload;
begin
  if Assigned(fuEk) then
    Exit;
  { TUniFileUpload gorsel olmayan bir bilesendir; tetikleyici buton btnEkEkle'dir. }
  fuEk := TUniFileUpload.Create(Self);
  fuEk.Name := 'fuEk';
  fuEk.Title := 'Dosya Ekle';
  fuEk.MaxAllowedSize := 52428800;
  fuEk.OnCompleted := fuEkCompleted;
end;

procedure TfrmCrmAktivite.btnEkEkleClick(Sender: TObject);
begin
  EnsureEkUpload;
  fuEk.ExecuteN;
end;

procedure TfrmCrmAktivite.UniFormShow(Sender: TObject);
var
  PrefTeklif, PrefPot: Int64;
begin
  EnsureEkUpload;
  FAktiviteId := StrToInt64Def(Trim(Hint), 0);
  PrefTeklif := Tmp.xCrmYeniAktiviteTeklifId;
  PrefPot := Tmp.xCrmYeniAktivitePotId;
  Tmp.xCrmYeniAktiviteTeklifId := 0;
  Tmp.xCrmYeniAktivitePotId := 0;
  if FAktiviteId > 0 then
    YukleKayit
  else
  begin
    YeniKayit;
    if PrefPot > 0 then
      UygulaBaslangicPotansiyel(PrefPot)
    else if PrefTeklif > 0 then
      UygulaBaslangicTeklif(PrefTeklif);
  end;
end;

function TfrmCrmAktivite.AktiviteKaydet: Boolean;
var
  NewId: Int64;
  Tkod, Dkod: string;
  IsNew: Boolean;
  OldKonu, OldAcik, OldDurAd, OldTarStr: string;
  OldDurId: Int64;
begin
  Result := False;
  IsNew := FAktiviteId <= 0;
  OldKonu := '';
  OldAcik := '';
  OldDurAd := '';
  OldTarStr := '';
  OldDurId := 0;
  if FAktiviteId > 0 then
  begin
    qLoad.Close;
    qLoad.SQL.Text :=
      'SELECT KONU, ACIKLAMA, AKTIVITE_TARIHI, AKTIVITE_DURUM_ID FROM dbo.CRM_AKTIVITE WHERE AKTIVITE_ID = :ID';
    qLoad.ParamByName('ID').AsLargeInt := FAktiviteId;
    qLoad.Open;
    if not qLoad.IsEmpty then
    begin
      OldKonu := qLoad.FieldByName('KONU').AsString;
      OldAcik := qLoad.FieldByName('ACIKLAMA').AsString;
      OldTarStr := CrmTarihMetin(qLoad.FieldByName('AKTIVITE_TARIHI').AsDateTime);
      if not qLoad.FieldByName('AKTIVITE_DURUM_ID').IsNull then
        OldDurId := qLoad.FieldByName('AKTIVITE_DURUM_ID').AsLargeInt;
    end;
    qLoad.Close;
    OldDurAd := CrmDurumMetni(qLogExec, OldDurId);
  end;
  if Trim(edKonu.Text) = '' then
  begin
    UniMainModule.saHata.Show('Konu zorunludur.');
    Exit;
  end;
  if (Trim(edCariKod.Text) = '') and (PotansiyelIdOku <= 0) then
  begin
    UniMainModule.saHata.Show('Cari veya potansiyel se'#231'imi zorunludur.');
    Exit;
  end;
  if VarIsNull(lkTip.KeyValue) or VarIsEmpty(lkTip.KeyValue) then
  begin
    UniMainModule.saHata.Show('Aktivite tipi se�iniz.');
    Exit;
  end;
  if VarIsNull(lkDurum.KeyValue) or VarIsEmpty(lkDurum.KeyValue) then
  begin
    UniMainModule.saHata.Show('Durum se�iniz.');
    Exit;
  end;

  Tkod := TipKodFromLookup;
  Dkod := DurumKodFromLookup;
  if SameText(Tkod, 'TASK') then
  begin
    UniMainModule.saHata.Show('TASK tipi yaln�zca g�rev formundan kullan�l�r.');
    Exit;
  end;

  if not VarIsNull(lkTeklif.KeyValue) and not VarIsEmpty(lkTeklif.KeyValue) then
  begin
    qLoad.Close;
    qLoad.SQL.Text := 'SELECT CARI_KOD FROM dbo.CRM_TEKLIF WHERE TEKLIF_ID = :T';
    qLoad.ParamByName('T').AsLargeInt := lkTeklif.KeyValue;
    qLoad.Open;
    if not qLoad.IsEmpty and not qLoad.FieldByName('CARI_KOD').IsNull then
    begin
      if (Trim(edCariKod.Text) <> '') and
        not SameText(Trim(edCariKod.Text), Trim(qLoad.FieldByName('CARI_KOD').AsString)) then
      begin
        qLoad.Close;
        UniMainModule.saHata.Show('Se�ilen teklifin cari kodu ile aktivite carisi uyu�muyor.');
        Exit;
      end;
    end;
    qLoad.Close;
  end;

  if CrmKontrolTamamlamaGerekli(qLoad, lkDurum.KeyValue, Dkod, False) then
  begin
    EnsureCrmKontrol;
    if not FCrmKontrol.Dogrula then
      Exit;
  end;

  qExec.Close;
  qExec.SQL.Clear;
  if FAktiviteId > 0 then
  begin
    qExec.SQL.Add('UPDATE dbo.CRM_AKTIVITE SET TIP = :TIP, KONU = :KONU, ACIKLAMA = :ACIKLAMA, CARI_KOD = :CARI_KOD,');
    qExec.SQL.Add('POTANSIYEL_ID = :PID, AKTIVITE_TARIHI = :AKTIVITE_TARIHI, DURUM = :DURUM, ONCELIK = :ONCELIK,');
    qExec.SQL.Add('AKTIVITE_TIP_ID = :TID_REF, AKTIVITE_DURUM_ID = :DID_REF, TEKLIF_ID = :TID_TEK, SIPARIS_NO = :SIPNO, GUNCELLEME_UTC = SYSUTCDATETIME()');
    qExec.SQL.Add('WHERE AKTIVITE_ID = :ID');
    qExec.ParamByName('ID').AsLargeInt := FAktiviteId;
  end
  else
  begin
    qExec.SQL.Add('INSERT INTO dbo.CRM_AKTIVITE (TIP, KONU, ACIKLAMA, CARI_KOD, POTANSIYEL_ID, AKTIVITE_TARIHI, DURUM, ONCELIK, OLUSTURAN_KULLANICI_ID, AKTIVITE_TIP_ID, AKTIVITE_DURUM_ID, TEKLIF_ID, SIPARIS_NO)');
    qExec.SQL.Add('OUTPUT INSERTED.AKTIVITE_ID');
    qExec.SQL.Add('VALUES (:TIP, :KONU, :ACIKLAMA, :CARI_KOD, :PID, :AKTIVITE_TARIHI, :DURUM, :ONCELIK, :KUL, :TID_REF, :DID_REF, :TID_TEK, :SIPNO)');
  end;

  qExec.ParamByName('TIP').AsString := Tkod;
  qExec.ParamByName('ONCELIK').AsString := OncelikKodFromCombo;
  qExec.ParamByName('KONU').AsString := edKonu.Text;
  qExec.ParamByName('ACIKLAMA').AsString := mmAciklama.Text;
  if Trim(edCariKod.Text) <> '' then
    qExec.ParamByName('CARI_KOD').AsString := Trim(edCariKod.Text)
  else
    qExec.ParamByName('CARI_KOD').Clear;
  if PotansiyelIdOku > 0 then
    qExec.ParamByName('PID').AsLargeInt := PotansiyelIdOku
  else
    qExec.ParamByName('PID').Clear;
  qExec.ParamByName('AKTIVITE_TARIHI').AsDateTime := dtAktivite.DateTime;
  qExec.ParamByName('DURUM').AsString := Dkod;
  qExec.ParamByName('TID_REF').AsLargeInt := lkTip.KeyValue;
  qExec.ParamByName('DID_REF').AsLargeInt := lkDurum.KeyValue;
  if VarIsNull(lkTeklif.KeyValue) or VarIsEmpty(lkTeklif.KeyValue) then
    qExec.ParamByName('TID_TEK').Clear
  else
    qExec.ParamByName('TID_TEK').AsLargeInt := lkTeklif.KeyValue;
  if Trim(edSiparis.Text) <> '' then
    qExec.ParamByName('SIPNO').AsString := Trim(edSiparis.Text)
  else
    qExec.ParamByName('SIPNO').Clear;
  if FAktiviteId <= 0 then
    qExec.ParamByName('KUL').AsInteger := Tmp.xKullaniciID;

  if FAktiviteId > 0 then
    qExec.Execute
  else
  begin
    qExec.Open;
    if qExec.Fields[0].IsNull then
      NewId := 0
    else
      NewId := qExec.Fields[0].AsLargeInt;
    qExec.Close;
    FAktiviteId := NewId;
  end;

  if FAktiviteId > 0 then
  begin
    EnsureCrmKontrol;
    FCrmKontrol.CevaplariKaydet(FAktiviteId);
  end;

  if FAktiviteId > 0 then
    AktiviteLogKaydet(IsNew, OldKonu, OldAcik, OldTarStr, OldDurAd);

  UniMainModule.saKaydet.Show('Aktivite kaydedildi.');
  if FAktiviteId > 0 then
    Caption := 'Aktivite';
  EkListele;
  TarihceYukle;
  Result := True;
end;

procedure TfrmCrmAktivite.btnKaydetClick(Sender: TObject);
begin
  AktiviteKaydet;
end;

procedure TfrmCrmAktivite.EkListele;
begin
  qEk.Close;
  if FAktiviteId <= 0 then
    Exit;
  qEk.SQL.Text :=
    'SELECT EK_ID, DOSYA_ADI, UZANTI, BOYUT, YUKLEME_UTC ' +
    'FROM dbo.CRM_AKTIVITE_EK WHERE AKTIVITE_ID = :AID ORDER BY EK_ID DESC';
  qEk.ParamByName('AID').AsLargeInt := FAktiviteId;
  qEk.Open;
end;

procedure TfrmCrmAktivite.fuEkCompleted(Sender: TObject; AStream: TFileStream);
var
  Dosya, Uzanti: string;
begin
  if not AktiviteKaydet then
  begin
    UniMainModule.saHata.Show('Ek eklemek i' + #$00E7 + 'in aktivite kaydedilemedi. Zorunlu alanlar' + #$0131 + ' kontrol edin.');
    Exit;
  end;

  Dosya := ExtractFileName(fuEk.FileName);
  if Trim(Dosya) = '' then
    Dosya := 'dosya';
  Uzanti := LowerCase(ExtractFileExt(Dosya));
  AStream.Position := 0;

  qEkExec.Close;
  qEkExec.SQL.Text :=
    'INSERT INTO dbo.CRM_AKTIVITE_EK (AKTIVITE_ID, DOSYA_ADI, UZANTI, BOYUT, ICERIK, YUKLEYEN_KULLANICI_ID) ' +
    'VALUES (:AID, :ADI, :UZ, :BOYUT, :ICERIK, :KUL)';
  qEkExec.ParamByName('AID').AsLargeInt := FAktiviteId;
  qEkExec.ParamByName('ADI').AsString := Dosya;
  if Uzanti <> '' then
    qEkExec.ParamByName('UZ').AsString := Uzanti
  else
    qEkExec.ParamByName('UZ').Clear;
  qEkExec.ParamByName('BOYUT').AsLargeInt := AStream.Size;
  qEkExec.ParamByName('ICERIK').LoadFromStream(AStream, ftBlob);
  qEkExec.ParamByName('KUL').AsInteger := Tmp.xKullaniciID;
  qEkExec.Execute;

  EkListele;
  UniMainModule.saKaydet.Show('Ek eklendi: ' + Dosya);
end;

procedure TfrmCrmAktivite.EkIndir;
var
  Ms: TMemoryStream;
  Adi, TamYol: string;
begin
  if not qEk.Active or qEk.IsEmpty then
  begin
    UniMainModule.saHata.Show(#$00D6 + 'nce bir ek se' + #$00E7 + 'iniz.');
    Exit;
  end;
  if qEk.FieldByName('EK_ID').IsNull then
    Exit;

  qEkExec.Close;
  qEkExec.SQL.Text := 'SELECT DOSYA_ADI, ICERIK FROM dbo.CRM_AKTIVITE_EK WHERE EK_ID = :ID';
  qEkExec.ParamByName('ID').AsLargeInt := qEk.FieldByName('EK_ID').AsLargeInt;
  qEkExec.Open;
  if qEkExec.IsEmpty then
  begin
    qEkExec.Close;
    Exit;
  end;

  Adi := qEkExec.FieldByName('DOSYA_ADI').AsString;
  Ms := TMemoryStream.Create;
  try
    TBlobField(qEkExec.FieldByName('ICERIK')).SaveToStream(Ms);
    TamYol := UniServerModule.LocalCachePath +
      IntToStr(qEk.FieldByName('EK_ID').AsLargeInt) + '_' + Adi;
    Ms.SaveToFile(TamYol);
  finally
    Ms.Free;
  end;
  qEkExec.Close;

  UniSession.SendFile(TamYol, Adi);
end;

procedure TfrmCrmAktivite.EkSil;
begin
  if not qEk.Active or qEk.IsEmpty then
  begin
    UniMainModule.saHata.Show(#$00D6 + 'nce bir ek se' + #$00E7 + 'iniz.');
    Exit;
  end;
  if qEk.FieldByName('EK_ID').IsNull then
    Exit;

  qEkExec.Close;
  qEkExec.SQL.Text := 'DELETE FROM dbo.CRM_AKTIVITE_EK WHERE EK_ID = :ID';
  qEkExec.ParamByName('ID').AsLargeInt := qEk.FieldByName('EK_ID').AsLargeInt;
  qEkExec.Execute;

  EkListele;
  UniMainModule.saKaydet.Show('Ek silindi.');
end;

procedure TfrmCrmAktivite.btnEkIndirClick(Sender: TObject);
begin
  EkIndir;
end;

procedure TfrmCrmAktivite.btnEkSilClick(Sender: TObject);
begin
  EkSil;
end;

procedure TfrmCrmAktivite.grdEkAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if SameText(EventName, 'celldblclick') then
    EkIndir;
end;

procedure TfrmCrmAktivite.EnsureCrmKontrol;
begin
  if FCrmKontrol <> nil then
    Exit;
  FCrmKontrol := TCrmAktiviteKontrolYonetici.Create(Self, panKontrol, qKontrol, qSecenek, qCevap,
    qKontrolExec);
  FCrmKontrol.OnSekmeGoster := KontrolSekmesiGoster;
end;

procedure TfrmCrmAktivite.KontrolSekmesiGoster(Sender: TObject);
begin
  pgc.ActivePage := tsKontrol;
end;

procedure TfrmCrmAktivite.KontrolListesiYukle;
begin
  EnsureCrmKontrol;
  if VarIsNull(lkTip.KeyValue) or VarIsEmpty(lkTip.KeyValue) then
    FCrmKontrol.Yukle(0, FAktiviteId,
      'Bu aktivite tipi i' + #$00E7 + 'in tan' + #$0131 + 'ml' + #$0131 + ' soru seti yok.')
  else
    FCrmKontrol.Yukle(lkTip.KeyValue, FAktiviteId,
      'Bu aktivite tipi i' + #$00E7 + 'in tan' + #$0131 + 'ml' + #$0131 + ' soru seti yok.');
end;

destructor TfrmCrmAktivite.Destroy;
begin
  FCrmKontrol.Free;
  inherited;
end;

procedure TfrmCrmAktivite.lkTipCloseUp(Sender: TObject);
begin
  KontrolListesiYukle;
end;

procedure TfrmCrmAktivite.btnKontrolKaydetClick(Sender: TObject);
begin
  AktiviteKaydet;
end;

end.
