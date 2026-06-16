unit CrmGorevU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniMemo, uniComboBox, uniDateTimePicker, uniButton,
  uniDBLookupComboBox, Data.DB, MemDS, DBAccess, Uni, uniDBComboBox,
  uniMultiItem, uniPageControl, uniBasicGrid, uniDBGrid, uniSweetAlert,
  uniFileUpload,
  CrmAktiviteKontrolU;

type
  TfrmCrmGorev = class(TUniForm)
    rootPanel: TUniPanel;
    pgc: TUniPageControl;
    tsGenel: TUniTabSheet;
    panMain: TUniPanel;
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
    lblGorevTar: TUniLabel;
    dtAktivite: TUniDateTimePicker;
    lblBitis: TUniLabel;
    dtBitis: TUniDateTimePicker;
    lblOncelik: TUniLabel;
    cbOncelik: TUniComboBox;
    lblAtanan: TUniLabel;
    lkAtanan: TUniDBLookupComboBox;
    lblDurum: TUniLabel;
    lkDurum: TUniDBLookupComboBox;
    tsEkler: TUniTabSheet;
    panEkBar: TUniPanel;
    btnEkEkle: TUniButton;
    btnEkIndir: TUniButton;
    btnEkSil: TUniButton;
    grdEk: TUniDBGrid;
    tsKontrol: TUniTabSheet;
    panKontrolTb: TUniPanel;
    lblKontrolBilgi: TUniLabel;
    btnKontrolKaydet: TUniButton;
    panKontrol: TUniPanel;
    tsTarihce: TUniTabSheet;
    grdTarihce: TUniDBGrid;
    panFooter: TUniPanel;
    btnKaydet: TUniButton;
    btnKapat: TUniButton;
    qKullanici: TUniQuery;
    dsKullanici: TUniDataSource;
    qInsAkt: TUniQuery;
    qLoad: TUniQuery;
    qInsGor: TUniQuery;
    qDurLkp: TUniQuery;
    dsDurLkp: TUniDataSource;
    qTekLkp: TUniQuery;
    dsTekLkp: TUniDataSource;
    qLog: TUniQuery;
    dsLog: TUniDataSource;
    qLogExec: TUniQuery;
    qEk: TUniQuery;
    dsEk: TUniDataSource;
    qEkExec: TUniQuery;
    qKontrol: TUniQuery;
    qSecenek: TUniQuery;
    qCevap: TUniQuery;
    qKontrolExec: TUniQuery;
    saBaglantiDurum: TUniSweetAlert;
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure btnCariBulClick(Sender: TObject);
    procedure btnPotBulClick(Sender: TObject);
    procedure btnTeklifYenileClick(Sender: TObject);
    procedure btnSiparisBulClick(Sender: TObject);
    procedure btnEkEkleClick(Sender: TObject);
    procedure btnEkIndirClick(Sender: TObject);
    procedure btnEkSilClick(Sender: TObject);
    procedure lkTeklifCloseUp(Sender: TObject);
    procedure lkDurumCloseUp(Sender: TObject);
    procedure saBaglantiDurumConfirm(Sender: TObject);
    procedure grdEkAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure btnKontrolKaydetClick(Sender: TObject);
  private
    FAktiviteId: Int64;
    FRotaId: Int64;
    FSoruSetId: Int64;
    FBaslangicTeklifId: Int64;
    FPendingDurumId: Int64;
    FCrmKontrol: TCrmAktiviteKontrolYonetici;
    fuEk: TUniFileUpload;
    procedure KontrolSekmesiGoster(Sender: TObject);
    procedure KontrolListesiYukle;
    procedure EnsureCrmKontrol;
    procedure YukleOncelik;
    procedure SetComboByText(ACombo: TUniComboBox; const AText: string);
    procedure KullanicilariAc;
    procedure AcDurumLookup;
    procedure VarsayilanDurum;
    procedure YeniGorevState;
    procedure UygulaBaslangicTeklifGorev(ATeklifId: Int64);
    procedure UygulaBaslangicPotansiyel(APotId: Int64);
    procedure TeklifLookupYenile(AForceTid: Int64);
    function TeklifIdFromLookup: Int64;
    function MevcutDurumId: Int64;
    function PotansiyelIdOku: Int64;
    procedure PotansiyelUnvanYukle(APotId: Int64);
    procedure PotSecildi(Sender: TObject; APotId: Int64);
    procedure BaglantiDurumDegerlendir(const AKaynakTip: string);
    procedure SiparisSecildi(Sender: TObject; const ASiparisKod: string);
    procedure YukleGorev;
    procedure UygulaRotaKilit;
    function DurumKodFromLookup: string;
    function GorevTipId: Int64;
    procedure TarihceYukle;
    procedure GorevLogKaydet(const IsNew: Boolean; const OldKonu, OldAcik, OldDurAd, OldAktTarStr, OldBitisStr,
      OldAtananAd: string; OldTamam: Boolean);
    function GorevKaydet: Boolean;
    procedure EnsureEkUpload;
    procedure EkListele;
    procedure EkIndir;
    procedure EkSil;
    procedure fuEkCompleted(Sender: TObject; AStream: TFileStream);
    destructor Destroy; override;
  public
  end;

function frmCrmGorev: TfrmCrmGorev;

implementation

{$R *.dfm}

uses
  uniGUIApplication, MainModule, DMU, TmpU, CrmCariSecU, CrmSiparisSecU, CrmBaglantiDurumU,
  CrmAktiviteLogU, CrmPotSecU, CrmRotaGorevU, ServerModule, Main;

procedure TfrmCrmGorev.btnCariBulClick(Sender: TObject);
var
  PrevTkl: Int64;
begin
  if FRotaId > 0 then
    Exit;
  PrevTkl := TeklifIdFromLookup;
  frmCrmCariSec.HedefCariEdit := edCariKod;
  frmCrmCariSec.HedefCariAdLabel := lblCariAd;
  frmCrmCariSec.edArama.Text := Trim(edCariKod.Text);
  frmCrmCariSec.ShowModal;
  TeklifLookupYenile(PrevTkl);
  if PrevTkl > 0 then
  begin
    if qTekLkp.Active and qTekLkp.Locate('TEKLIF_ID', PrevTkl, []) then
      lkTeklif.KeyValue := PrevTkl
    else
      lkTeklif.KeyValue := Null;
  end;
end;

function frmCrmGorev: TfrmCrmGorev;
begin
  Result := TfrmCrmGorev(UniMainModule.GetFormInstance(TfrmCrmGorev));
end;

function TfrmCrmGorev.PotansiyelIdOku: Int64;
begin
  Result := StrToInt64Def(Trim(edPotId.Text), 0);
end;

procedure TfrmCrmGorev.PotansiyelUnvanYukle(APotId: Int64);
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

procedure TfrmCrmGorev.PotSecildi(Sender: TObject; APotId: Int64);
var
  Ck, CariAd: string;
begin
  edPotId.Text := IntToStr(APotId);
  PotansiyelUnvanYukle(APotId);
  if (APotId <= 0) or (Trim(edCariKod.Text) <> '') then
    Exit;
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
end;

procedure TfrmCrmGorev.btnPotBulClick(Sender: TObject);
begin
  if FRotaId > 0 then
    Exit;
  frmCrmPotSec.HedefPotansiyelIdEdit := edPotId;
  frmCrmPotSec.HedefPotansiyelUnvanLabel := lblPotUnvan;
  frmCrmPotSec.OnPotansiyelSecildi := PotSecildi;
  frmCrmPotSec.SecimModuHazirla(False);
  frmCrmPotSec.edArama.Text := Trim(lblPotUnvan.Caption);
  frmCrmPotSec.ShowModal;
end;

procedure TfrmCrmGorev.UygulaBaslangicPotansiyel(APotId: Int64);
begin
  if APotId <= 0 then
    Exit;
  PotSecildi(Self, APotId);
end;

procedure TfrmCrmGorev.KullanicilariAc;
begin
  qKullanici.Close;
  qKullanici.SQL.Text :=
    'SELECT KullaniciID, KullaniciAd FROM dbo.Kullanici ORDER BY KullaniciAd';
  qKullanici.Open;
end;

procedure TfrmCrmGorev.YukleOncelik;
begin
  cbOncelik.Items.Clear;
  cbOncelik.Items.Add('DUSUK');
  cbOncelik.Items.Add('NORMAL');
  cbOncelik.Items.Add('YUKSEK');
  cbOncelik.Items.Add('ACIL');
  cbOncelik.ItemIndex := 1;
end;

procedure TfrmCrmGorev.AcDurumLookup;
begin
  qDurLkp.Close;
  qDurLkp.SQL.Text :=
    'SELECT DURUM_ID, KOD, (KOD + N'' - '' + ISNULL(ACIKLAMA, N'''')) AS AD ' +
    'FROM dbo.CRM_AKTIVITE_DURUM WHERE AKTIF = 1 ORDER BY SIRA, DURUM_ID';
  qDurLkp.Open;
end;

procedure TfrmCrmGorev.VarsayilanDurum;
begin
  lkDurum.KeyValue := Null;
  if qDurLkp.Active and qDurLkp.Locate('KOD', 'ACIK', [loCaseInsensitive]) then
    lkDurum.KeyValue := qDurLkp.FieldByName('DURUM_ID').AsLargeInt
  else if qDurLkp.Active and not qDurLkp.IsEmpty then
    lkDurum.KeyValue := qDurLkp.FieldByName('DURUM_ID').AsLargeInt;
end;

procedure TfrmCrmGorev.SetComboByText(ACombo: TUniComboBox; const AText: string);
var
  I: Integer;
begin
  I := ACombo.Items.IndexOf(AText);
  if I >= 0 then
    ACombo.ItemIndex := I
  else if AText <> '' then
  begin
    ACombo.Items.Add(AText);
    ACombo.ItemIndex := ACombo.Items.Count - 1;
  end;
end;

function TfrmCrmGorev.DurumKodFromLookup: string;
begin
  Result := '';
  if VarIsNull(lkDurum.KeyValue) or VarIsEmpty(lkDurum.KeyValue) then
    Exit;
  if qDurLkp.Active and qDurLkp.Locate('DURUM_ID', lkDurum.KeyValue, []) then
    Result := qDurLkp.FieldByName('KOD').AsString;
end;

function TfrmCrmGorev.GorevTipId: Int64;
begin
  Result := 0;
  qInsAkt.Close;
  qInsAkt.SQL.Text := 'SELECT TIP_ID FROM dbo.CRM_AKTIVITE_TIP WHERE KOD = ''TASK''';
  qInsAkt.Open;
  if not qInsAkt.IsEmpty then
    Result := qInsAkt.Fields[0].AsLargeInt;
  qInsAkt.Close;
end;

procedure TfrmCrmGorev.UygulaBaslangicTeklifGorev(ATeklifId: Int64);
begin
  if ATeklifId <= 0 then
    Exit;
  FBaslangicTeklifId := ATeklifId;
  qLoad.Close;
  qLoad.SQL.Text :=
    'SELECT CARI_KOD FROM dbo.CRM_TEKLIF WHERE TEKLIF_ID = :T';
  qLoad.ParamByName('T').AsLargeInt := ATeklifId;
  qLoad.Open;
  if not qLoad.IsEmpty then
  begin
    if not qLoad.FieldByName('CARI_KOD').IsNull then
      edCariKod.Text := Trim(qLoad.FieldByName('CARI_KOD').AsString);
  end;
  qLoad.Close;
  TeklifLookupYenile(ATeklifId);
  if qTekLkp.Active and qTekLkp.Locate('TEKLIF_ID', ATeklifId, []) then
    lkTeklif.KeyValue := ATeklifId
  else
    lkTeklif.KeyValue := Null;
  BaglantiDurumDegerlendir(CRM_KAYNAK_TEKLIF);
end;

procedure TfrmCrmGorev.TeklifLookupYenile(AForceTid: Int64);
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

function TfrmCrmGorev.TeklifIdFromLookup: Int64;
begin
  Result := 0;
  if VarIsNull(lkTeklif.KeyValue) or VarIsEmpty(lkTeklif.KeyValue) then
    Exit;
  Result := lkTeklif.KeyValue;
end;

function TfrmCrmGorev.MevcutDurumId: Int64;
begin
  Result := 0;
  if VarIsNull(lkDurum.KeyValue) or VarIsEmpty(lkDurum.KeyValue) then
    Exit;
  Result := lkDurum.KeyValue;
end;

procedure TfrmCrmGorev.BaglantiDurumDegerlendir(const AKaynakTip: string);
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

procedure TfrmCrmGorev.saBaglantiDurumConfirm(Sender: TObject);
begin
  if FPendingDurumId > 0 then
    lkDurum.KeyValue := FPendingDurumId;
  FPendingDurumId := 0;
end;

procedure TfrmCrmGorev.SiparisSecildi(Sender: TObject; const ASiparisKod: string);
begin
  BaglantiDurumDegerlendir(CRM_KAYNAK_SIPARIS);
end;

procedure TfrmCrmGorev.btnTeklifYenileClick(Sender: TObject);
var
  PrevTkl: Int64;
begin
  PrevTkl := TeklifIdFromLookup;
  TeklifLookupYenile(PrevTkl);
  if PrevTkl > 0 then
  begin
    if qTekLkp.Active and qTekLkp.Locate('TEKLIF_ID', PrevTkl, []) then
      lkTeklif.KeyValue := PrevTkl
    else
      lkTeklif.KeyValue := Null;
  end;
end;

procedure TfrmCrmGorev.btnSiparisBulClick(Sender: TObject);
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

procedure TfrmCrmGorev.lkTeklifCloseUp(Sender: TObject);
begin
  BaglantiDurumDegerlendir(CRM_KAYNAK_TEKLIF);
end;

procedure TfrmCrmGorev.lkDurumCloseUp(Sender: TObject);
var
  Did: Int64;
begin
  Did := MevcutDurumId;
  if CrmDurumKapanisMi(qLoad, Did) then
    BaglantiDurumDegerlendir(CRM_KAYNAK_KAPANIS);
end;

procedure TfrmCrmGorev.YeniGorevState;
begin
  FAktiviteId := 0;
  FRotaId := 0;
  FSoruSetId := 0;
  FBaslangicTeklifId := 0;
  Caption := 'Yeni G' + #$00F6 + 'rev';
  edKonu.Text := '';
  mmAciklama.Text := '';
  edCariKod.Text := '';
  lblCariAd.Caption := '';
  edPotId.Text := '';
  lblPotUnvan.Caption := '';
  TeklifLookupYenile(0);
  lkTeklif.KeyValue := Null;
  edSiparis.Text := '';
  lblSiparisTar.Caption := '';
  lblSiparisAcik.Caption := '';
  dtAktivite.DateTime := Now;
  dtBitis.DateTime := Now;
  YukleOncelik;
  AcDurumLookup;
  VarsayilanDurum;
  lkAtanan.KeyValue := Tmp.xKullaniciID;
  EkListele;
  UygulaRotaKilit;
  KontrolListesiYukle;
end;

procedure TfrmCrmGorev.UygulaRotaKilit;
var
  Bagli: Boolean;
begin
  Bagli := FRotaId > 0;
  btnCariBul.Enabled := not Bagli;
  btnPotBul.Enabled := not Bagli;
  edCariKod.ReadOnly := Bagli;
  edPotId.ReadOnly := Bagli;
end;

procedure TfrmCrmGorev.YukleGorev;
var
  DurId: Int64;
  TamB: Boolean;
begin
  qLoad.Close;
  qLoad.SQL.Text :=
    'SELECT A.KONU, A.ACIKLAMA, A.CARI_KOD, A.POTANSIYEL_ID, A.AKTIVITE_TARIHI, A.AKTIVITE_DURUM_ID, ' +
    'A.TEKLIF_ID, A.SIPARIS_NO, A.ROTA_ID, C.CARI_ISIM, P.FIRMA_UNVAN AS POT_UNVAN, ' +
    'G.BITIS_TARIHI, G.ONCELIK, G.TAMAMLANDI, G.ATANAN_KULLANICI_ID ' +
    'FROM dbo.CRM_AKTIVITE A ' +
    'INNER JOIN dbo.CRM_GOREV G ON G.AKTIVITE_ID = A.AKTIVITE_ID ' +
    'LEFT JOIN YUCEL..HV_CARI_LISTESI C WITH(NOLOCK) ON C.CARI_KOD = A.CARI_KOD ' +
    'LEFT JOIN dbo.CRM_POTANSIYEL_MUSTERI P ON P.POTANSIYEL_ID = A.POTANSIYEL_ID ' +
    'WHERE A.AKTIVITE_ID = :AID AND A.TIP = ''TASK''';
  qLoad.ParamByName('AID').AsLargeInt := FAktiviteId;
  qLoad.Open;
  if qLoad.IsEmpty then
  begin
    qLoad.Close;
    UniMainModule.saHata.Show('G' + #$00F6 + 'rev bulunamad' + #$0131 + '.');
    FAktiviteId := 0;
    KullanicilariAc;
    YeniGorevState;
    Exit;
  end;
  YukleOncelik;
  AcDurumLookup;
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
  if qLoad.FieldByName('TEKLIF_ID').IsNull then
  begin
    FBaslangicTeklifId := 0;
    TeklifLookupYenile(0);
    lkTeklif.KeyValue := Null;
  end
  else
  begin
    FBaslangicTeklifId := qLoad.FieldByName('TEKLIF_ID').AsLargeInt;
    TeklifLookupYenile(FBaslangicTeklifId);
    lkTeklif.KeyValue := FBaslangicTeklifId;
  end;
  if (qLoad.FindField('SIPARIS_NO') <> nil) and not qLoad.FieldByName('SIPARIS_NO').IsNull then
    edSiparis.Text := Trim(qLoad.FieldByName('SIPARIS_NO').AsString)
  else
    edSiparis.Text := '';
  lblSiparisTar.Caption := '';
  lblSiparisAcik.Caption := '';
  if qLoad.FieldByName('AKTIVITE_TARIHI').IsNull then
    dtAktivite.DateTime := Now
  else
    dtAktivite.DateTime := qLoad.FieldByName('AKTIVITE_TARIHI').AsDateTime;
  if qLoad.FieldByName('BITIS_TARIHI').IsNull then
    dtBitis.DateTime := Now
  else
    dtBitis.DateTime := qLoad.FieldByName('BITIS_TARIHI').AsDateTime;
  SetComboByText(cbOncelik, qLoad.FieldByName('ONCELIK').AsString);
  TamB := qLoad.FieldByName('TAMAMLANDI').AsBoolean;
  if qLoad.FieldByName('AKTIVITE_DURUM_ID').IsNull then
    DurId := 0
  else
    DurId := qLoad.FieldByName('AKTIVITE_DURUM_ID').AsLargeInt;
  if qLoad.FieldByName('ATANAN_KULLANICI_ID').IsNull then
    lkAtanan.KeyValue := Null
  else
    lkAtanan.KeyValue := qLoad.FieldByName('ATANAN_KULLANICI_ID').AsInteger;
  if (qLoad.FindField('ROTA_ID') <> nil) and not qLoad.FieldByName('ROTA_ID').IsNull then
    FRotaId := qLoad.FieldByName('ROTA_ID').AsLargeInt
  else
    FRotaId := 0;
  if FRotaId > 0 then
    FSoruSetId := CrmRotaGorevSoruSetIdOku(frmDM.conAsya, FRotaId, Tmp.xSubeKodu)
  else
    FSoruSetId := 0;
  qLoad.Close;

  if TamB and qDurLkp.Locate('KOD', 'TAMAMLANDI', [loCaseInsensitive]) then
    lkDurum.KeyValue := qDurLkp.FieldByName('DURUM_ID').AsLargeInt
  else if (DurId > 0) and qDurLkp.Locate('DURUM_ID', DurId, []) then
    lkDurum.KeyValue := DurId
  else
    VarsayilanDurum;

  Caption := 'G' + #$00F6 + 'rev';
  EkListele;
  TarihceYukle;
  UygulaRotaKilit;
  KontrolListesiYukle;
end;

procedure TfrmCrmGorev.TarihceYukle;
begin
  CrmTarihceYukle(qLog, FAktiviteId);
end;

procedure TfrmCrmGorev.GorevLogKaydet(const IsNew: Boolean; const OldKonu, OldAcik, OldDurAd, OldAktTarStr,
  OldBitisStr, OldAtananAd: string; OldTamam: Boolean);
var
  KulId: Integer;
  YeniAtanan, YeniTamStr, EskiTamStr: string;
begin
  if FAktiviteId <= 0 then
    Exit;
  KulId := Tmp.xKullaniciID;
  if IsNew then
  begin
    CrmLogEkle(qLogExec, FAktiviteId, 'GOREV', 'OLUSTUR', '', '', edKonu.Text, 'Yeni gorev', KulId);
    Exit;
  end;
  CrmLogAlanDegisti(qLogExec, FAktiviteId, 'GOREV', 'KONU_DEGIS', 'Konu', OldKonu, edKonu.Text, KulId);
  CrmLogAlanDegisti(qLogExec, FAktiviteId, 'GOREV', 'ACIKLAMA_DEGIS', 'Aciklama', OldAcik, mmAciklama.Text, KulId);
  CrmLogAlanDegisti(qLogExec, FAktiviteId, 'GOREV', 'DURUM_DEGIS', 'Durum', OldDurAd, Trim(lkDurum.Text), KulId);
  CrmLogAlanDegisti(qLogExec, FAktiviteId, 'GOREV', 'TARIH_DEGIS', 'Gorev Tarihi', OldAktTarStr,
    CrmTarihMetin(dtAktivite.DateTime), KulId);
  CrmLogAlanDegisti(qLogExec, FAktiviteId, 'GOREV', 'TARIH_DEGIS', 'Termin Tarihi', OldBitisStr,
    CrmTarihMetin(dtBitis.DateTime), KulId);
  if VarIsEmpty(lkAtanan.KeyValue) or VarIsNull(lkAtanan.KeyValue) then
    YeniAtanan := ''
  else
    YeniAtanan := Trim(lkAtanan.Text);
  CrmLogAlanDegisti(qLogExec, FAktiviteId, 'GOREV', 'ATAMA_DEGIS', 'Atanan', OldAtananAd, YeniAtanan, KulId);
  if SameText(DurumKodFromLookup, 'TAMAMLANDI') then
    YeniTamStr := 'Evet'
  else
    YeniTamStr := 'Hayir';
  if OldTamam then
    EskiTamStr := 'Evet'
  else
    EskiTamStr := 'Hayir';
  CrmLogAlanDegisti(qLogExec, FAktiviteId, 'GOREV', 'TAMAMLANDI', 'Tamamlandi', EskiTamStr, YeniTamStr, KulId);
end;

procedure TfrmCrmGorev.EnsureEkUpload;
begin
  if Assigned(fuEk) then
    Exit;
  fuEk := TUniFileUpload.Create(Self);
  fuEk.Name := 'fuEk';
  fuEk.Title := 'Dosya Ekle';
  fuEk.MaxAllowedSize := 52428800;
  fuEk.OnCompleted := fuEkCompleted;
end;

procedure TfrmCrmGorev.btnEkEkleClick(Sender: TObject);
begin
  EnsureEkUpload;
  fuEk.ExecuteN;
end;

procedure TfrmCrmGorev.EkListele;
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

procedure TfrmCrmGorev.fuEkCompleted(Sender: TObject; AStream: TFileStream);
var
  Dosya, Uzanti: string;
begin
  if not GorevKaydet then
  begin
    UniMainModule.saHata.Show('Ek eklemek i' + #$00E7 + 'in g' + #$00F6 + 'rev kaydedilemedi. Zorunlu alanlar' +
      #$0131 + ' kontrol edin.');
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

procedure TfrmCrmGorev.EkIndir;
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

procedure TfrmCrmGorev.EkSil;
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

procedure TfrmCrmGorev.btnEkIndirClick(Sender: TObject);
begin
  EkIndir;
end;

procedure TfrmCrmGorev.btnEkSilClick(Sender: TObject);
begin
  EkSil;
end;

procedure TfrmCrmGorev.grdEkAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
begin
  if SameText(EventName, 'celldblclick') then
    EkIndir;
end;

procedure TfrmCrmGorev.UniFormCreate(Sender: TObject);
begin
  Align := alClient;
end;

procedure TfrmCrmGorev.UniFormShow(Sender: TObject);
var
  PrefTeklif, PrefPot: Int64;
begin
  EnsureEkUpload;
  KullanicilariAc;
  FAktiviteId := StrToInt64Def(Trim(Hint), 0);
  PrefTeklif := Tmp.xCrmYeniGorevTeklifId;
  PrefPot := Tmp.xCrmYeniGorevPotId;
  Tmp.xCrmYeniGorevTeklifId := 0;
  Tmp.xCrmYeniGorevPotId := 0;
  if FAktiviteId > 0 then
    YukleGorev
  else
  begin
    YeniGorevState;
    if PrefPot > 0 then
      UygulaBaslangicPotansiyel(PrefPot)
    else if PrefTeklif > 0 then
      UygulaBaslangicTeklifGorev(PrefTeklif);
  end;
end;

function TfrmCrmGorev.GorevKaydet: Boolean;
var
  Aid: Int64;
  Tamam: Integer;
  TaskTid: Int64;
  Dkod: string;
  IsNew: Boolean;
  OldKonu, OldAcik, OldDurAd, OldAktTarStr, OldBitisStr, OldAtananAd: string;
  OldDurId, OldAtananId: Int64;
  OldTamam: Boolean;
begin
  Result := False;
  IsNew := FAktiviteId <= 0;
  OldKonu := '';
  OldAcik := '';
  OldDurAd := '';
  OldAktTarStr := '';
  OldBitisStr := '';
  OldAtananAd := '';
  OldTamam := False;
  OldDurId := 0;
  OldAtananId := 0;
  if FAktiviteId > 0 then
  begin
    qLoad.Close;
    qLoad.SQL.Text :=
      'SELECT A.KONU, A.ACIKLAMA, A.AKTIVITE_TARIHI, A.AKTIVITE_DURUM_ID, G.BITIS_TARIHI, ' +
      'G.ATANAN_KULLANICI_ID, G.TAMAMLANDI ' +
      'FROM dbo.CRM_AKTIVITE A INNER JOIN dbo.CRM_GOREV G ON G.AKTIVITE_ID = A.AKTIVITE_ID WHERE A.AKTIVITE_ID = :ID';
    qLoad.ParamByName('ID').AsLargeInt := FAktiviteId;
    qLoad.Open;
    if not qLoad.IsEmpty then
    begin
      OldKonu := qLoad.FieldByName('KONU').AsString;
      OldAcik := qLoad.FieldByName('ACIKLAMA').AsString;
      OldAktTarStr := CrmTarihMetin(qLoad.FieldByName('AKTIVITE_TARIHI').AsDateTime);
      OldBitisStr := CrmTarihMetin(qLoad.FieldByName('BITIS_TARIHI').AsDateTime);
      OldTamam := qLoad.FieldByName('TAMAMLANDI').AsBoolean;
      if not qLoad.FieldByName('AKTIVITE_DURUM_ID').IsNull then
        OldDurId := qLoad.FieldByName('AKTIVITE_DURUM_ID').AsLargeInt;
      if not qLoad.FieldByName('ATANAN_KULLANICI_ID').IsNull then
        OldAtananId := qLoad.FieldByName('ATANAN_KULLANICI_ID').AsInteger;
    end;
    qLoad.Close;
    OldDurAd := CrmDurumMetni(qLogExec, OldDurId);
    OldAtananAd := CrmKullaniciMetni(qLogExec, OldAtananId);
  end;
  if Trim(edKonu.Text) = '' then
  begin
    UniMainModule.saHata.Show('Konu zorunludur.');
    Exit;
  end;
  if VarIsNull(lkDurum.KeyValue) or VarIsEmpty(lkDurum.KeyValue) then
  begin
    UniMainModule.saHata.Show('Durum se' + #$00E7 + 'iniz.');
    Exit;
  end;

  Dkod := DurumKodFromLookup;
  Tamam := 0;
  if SameText(Dkod, 'TAMAMLANDI') then
    Tamam := 1;

  if (Tamam = 1) and not OldTamam then
    BaglantiDurumDegerlendir(CRM_KAYNAK_GOREV_TAM);

  Dkod := DurumKodFromLookup;
  Tamam := 0;
  if SameText(Dkod, 'TAMAMLANDI') then
    Tamam := 1;

  if TeklifIdFromLookup > 0 then
  begin
    qLoad.Close;
    qLoad.SQL.Text := 'SELECT CARI_KOD FROM dbo.CRM_TEKLIF WHERE TEKLIF_ID = :T';
    qLoad.ParamByName('T').AsLargeInt := TeklifIdFromLookup;
    qLoad.Open;
    if not qLoad.IsEmpty and not qLoad.FieldByName('CARI_KOD').IsNull then
    begin
      if (Trim(edCariKod.Text) <> '') and
        not SameText(Trim(edCariKod.Text), Trim(qLoad.FieldByName('CARI_KOD').AsString)) then
      begin
        qLoad.Close;
        UniMainModule.saHata.Show('Se' + #$00E7 + 'ilen teklifin cari kodu ile g' + #$00F6 + 'rev carisi uyu' +
          #$015F + 'muyor.');
        Exit;
      end;
    end;
    qLoad.Close;
  end;

  if CrmKontrolTamamlamaGerekli(qLoad, lkDurum.KeyValue, Dkod, True) then
  begin
    EnsureCrmKontrol;
    if not FCrmKontrol.Dogrula then
      Exit;
  end;

  if FAktiviteId > 0 then
  begin
    Aid := FAktiviteId;
    qInsAkt.Close;
    qInsAkt.SQL.Clear;
    qInsAkt.SQL.Add('UPDATE dbo.CRM_AKTIVITE SET KONU = :KONU, ACIKLAMA = :ACIKLAMA, CARI_KOD = :CARI_KOD,');
    qInsAkt.SQL.Add('POTANSIYEL_ID = :PID, AKTIVITE_TARIHI = :AKTAR, DURUM = :DURUM, AKTIVITE_DURUM_ID = :DID,');
    qInsAkt.SQL.Add('TEKLIF_ID = :TID_TEK, SIPARIS_NO = :SIPNO, GUNCELLEME_UTC = SYSUTCDATETIME()');
    qInsAkt.SQL.Add('WHERE AKTIVITE_ID = :AID AND TIP = ''TASK''');
    qInsAkt.ParamByName('AID').AsLargeInt := Aid;
    qInsAkt.ParamByName('KONU').AsString := edKonu.Text;
    qInsAkt.ParamByName('ACIKLAMA').AsString := mmAciklama.Text;
    if Trim(edCariKod.Text) <> '' then
      qInsAkt.ParamByName('CARI_KOD').AsString := Trim(edCariKod.Text)
    else
      qInsAkt.ParamByName('CARI_KOD').Clear;
    if PotansiyelIdOku > 0 then
      qInsAkt.ParamByName('PID').AsLargeInt := PotansiyelIdOku
    else
      qInsAkt.ParamByName('PID').Clear;
    qInsAkt.ParamByName('AKTAR').AsDateTime := dtAktivite.DateTime;
    qInsAkt.ParamByName('DURUM').AsString := Dkod;
    qInsAkt.ParamByName('DID').AsLargeInt := lkDurum.KeyValue;
    if TeklifIdFromLookup > 0 then
      qInsAkt.ParamByName('TID_TEK').AsLargeInt := TeklifIdFromLookup
    else
      qInsAkt.ParamByName('TID_TEK').Clear;
    if Trim(edSiparis.Text) <> '' then
      qInsAkt.ParamByName('SIPNO').AsString := Trim(edSiparis.Text)
    else
      qInsAkt.ParamByName('SIPNO').Clear;
    qInsAkt.Execute;

    qInsGor.Close;
    qInsGor.SQL.Clear;
    qInsGor.SQL.Add('UPDATE dbo.CRM_GOREV SET ATANAN_KULLANICI_ID = :ATAN, BITIS_TARIHI = :BITIS, ONCELIK = :ONC,');
    qInsGor.SQL.Add('TAMAMLANDI = :TAM, TAMAMLANMA_UTC = :TAMUTC WHERE AKTIVITE_ID = :AID');
    qInsGor.ParamByName('AID').AsLargeInt := Aid;
    if VarIsEmpty(lkAtanan.KeyValue) or VarIsNull(lkAtanan.KeyValue) or (Trim(lkAtanan.Text) = '') then
      qInsGor.ParamByName('ATAN').Clear
    else
      qInsGor.ParamByName('ATAN').AsInteger := lkAtanan.KeyValue;
    qInsGor.ParamByName('BITIS').AsDateTime := dtBitis.DateTime;
    qInsGor.ParamByName('ONC').AsString := cbOncelik.Text;
    qInsGor.ParamByName('TAM').AsBoolean := Tamam = 1;
    if Tamam = 1 then
      qInsGor.ParamByName('TAMUTC').AsDateTime := Now
    else
      qInsGor.ParamByName('TAMUTC').Clear;
    qInsGor.Execute;
  end
  else
  begin
    TaskTid := GorevTipId;
    if TaskTid <= 0 then
    begin
      UniMainModule.saHata.Show('CRM: TASK aktivite tipi bulunamad' + #$0131 + '. Veritaban' + #$0131 +
        ' migrasyonunu ' + #$00E7 + 'al' + #$0131 + #351 + 't' + #$0131 + 'r' + #$0131 + 'n.');
      Exit;
    end;

    qInsAkt.Close;
    qInsAkt.SQL.Clear;
    qInsAkt.SQL.Add('INSERT INTO dbo.CRM_AKTIVITE (TIP, KONU, ACIKLAMA, CARI_KOD, POTANSIYEL_ID, AKTIVITE_TARIHI,');
    qInsAkt.SQL.Add('DURUM, OLUSTURAN_KULLANICI_ID, AKTIVITE_TIP_ID, AKTIVITE_DURUM_ID, TEKLIF_ID, SIPARIS_NO)');
    qInsAkt.SQL.Add('OUTPUT INSERTED.AKTIVITE_ID');
    qInsAkt.SQL.Add('VALUES (''TASK'', :KONU, :ACIKLAMA, :CARI_KOD, :PID, :AKTAR, :DURUM, :KUL, :TID_REF, :DID_REF, :TID_TEK, :SIPNO)');
    qInsAkt.ParamByName('KONU').AsString := edKonu.Text;
    qInsAkt.ParamByName('ACIKLAMA').AsString := mmAciklama.Text;
    if Trim(edCariKod.Text) <> '' then
      qInsAkt.ParamByName('CARI_KOD').AsString := Trim(edCariKod.Text)
    else
      qInsAkt.ParamByName('CARI_KOD').Clear;
    if PotansiyelIdOku > 0 then
      qInsAkt.ParamByName('PID').AsLargeInt := PotansiyelIdOku
    else
      qInsAkt.ParamByName('PID').Clear;
    qInsAkt.ParamByName('AKTAR').AsDateTime := dtAktivite.DateTime;
    qInsAkt.ParamByName('DURUM').AsString := Dkod;
    qInsAkt.ParamByName('KUL').AsInteger := Tmp.xKullaniciID;
    qInsAkt.ParamByName('TID_REF').AsLargeInt := TaskTid;
    qInsAkt.ParamByName('DID_REF').AsLargeInt := lkDurum.KeyValue;
    if TeklifIdFromLookup > 0 then
      qInsAkt.ParamByName('TID_TEK').AsLargeInt := TeklifIdFromLookup
    else
      qInsAkt.ParamByName('TID_TEK').Clear;
    if Trim(edSiparis.Text) <> '' then
      qInsAkt.ParamByName('SIPNO').AsString := Trim(edSiparis.Text)
    else
      qInsAkt.ParamByName('SIPNO').Clear;
    qInsAkt.Open;
    if qInsAkt.Fields[0].IsNull then
      Aid := 0
    else
      Aid := qInsAkt.Fields[0].AsLargeInt;
    qInsAkt.Close;

    if Aid <= 0 then
    begin
      UniMainModule.saHata.Show('CRM aktivite kayd' + #$0131 + ' olu' + #$015F + 'mad' + #$0131 + ' (AktiviteID al' +
        #$0131 + 'namad' + #$0131 + ').');
      Exit;
    end;

    FAktiviteId := Aid;

    qInsGor.Close;
    qInsGor.SQL.Clear;
    qInsGor.SQL.Add('INSERT INTO dbo.CRM_GOREV (AKTIVITE_ID, ATANAN_KULLANICI_ID, BITIS_TARIHI, ONCELIK, TAMAMLANDI, TAMAMLANMA_UTC)');
    qInsGor.SQL.Add('VALUES (:AID, :ATAN, :BITIS, :ONC, :TAM, :TAMUTC)');
    qInsGor.ParamByName('AID').AsLargeInt := Aid;
    if VarIsEmpty(lkAtanan.KeyValue) or VarIsNull(lkAtanan.KeyValue) or (Trim(lkAtanan.Text) = '') then
      qInsGor.ParamByName('ATAN').Clear
    else
      qInsGor.ParamByName('ATAN').AsInteger := lkAtanan.KeyValue;
    qInsGor.ParamByName('BITIS').AsDateTime := dtBitis.DateTime;
    qInsGor.ParamByName('ONC').AsString := cbOncelik.Text;
    qInsGor.ParamByName('TAM').AsBoolean := Tamam = 1;
    if Tamam = 1 then
      qInsGor.ParamByName('TAMUTC').AsDateTime := Now
    else
      qInsGor.ParamByName('TAMUTC').Clear;
    qInsGor.Execute;
    Caption := 'G' + #$00F6 + 'rev';
  end;

  if FAktiviteId > 0 then
  begin
    EnsureCrmKontrol;
    FCrmKontrol.CevaplariKaydet(FAktiviteId);
  end;

  if FAktiviteId > 0 then
  begin
    GorevLogKaydet(IsNew, OldKonu, OldAcik, OldDurAd, OldAktTarStr, OldBitisStr, OldAtananAd, OldTamam);
    TarihceYukle;
  end;

  UniMainModule.saKaydet.Show('G' + #$00F6 + 'rev kaydedildi.');
  EkListele;
  Result := True;
end;

procedure TfrmCrmGorev.btnKaydetClick(Sender: TObject);
begin
  GorevKaydet;
end;

procedure TfrmCrmGorev.btnKapatClick(Sender: TObject);
begin
  MainForm.NavPage.ActivePage.Close;
end;

procedure TfrmCrmGorev.EnsureCrmKontrol;
begin
  if FCrmKontrol <> nil then
    Exit;
  FCrmKontrol := TCrmAktiviteKontrolYonetici.Create(Self, panKontrol, qKontrol, qSecenek, qCevap,
    qKontrolExec);
  FCrmKontrol.OnSekmeGoster := KontrolSekmesiGoster;
end;

procedure TfrmCrmGorev.KontrolSekmesiGoster(Sender: TObject);
begin
  pgc.ActivePage := tsKontrol;
end;

procedure TfrmCrmGorev.KontrolListesiYukle;
var
  Tid: Int64;
begin
  EnsureCrmKontrol;
  if FSoruSetId > 0 then
  begin
    FCrmKontrol.YukleSet(FSoruSetId, FAktiviteId,
      'Bu rotaya bagli g' + #$00F6 + 'rev i' + #$00E7 + 'in tan' + #$0131 + 'ml' + #$0131 + ' soru seti yok.');
    Exit;
  end;
  Tid := GorevTipId;
  if Tid <= 0 then
    FCrmKontrol.Yukle(0, FAktiviteId,
      'G' + #$00F6 + 'rev tipi i' + #$00E7 + 'in tan' + #$0131 + 'ml' + #$0131 + ' soru seti yok.')
  else
    FCrmKontrol.Yukle(Tid, FAktiviteId,
      'Bu g' + #$00F6 + 'rev tipi i' + #$00E7 + 'in tan' + #$0131 + 'ml' + #$0131 + ' soru seti yok.');
end;

procedure TfrmCrmGorev.btnKontrolKaydetClick(Sender: TObject);
begin
  GorevKaydet;
end;

destructor TfrmCrmGorev.Destroy;
begin
  FCrmKontrol.Free;
  inherited;
end;

end.
