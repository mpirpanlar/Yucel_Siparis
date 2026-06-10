unit CrmGorevU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniMemo, uniComboBox, uniDateTimePicker, uniButton,
  uniDBLookupComboBox, Data.DB, MemDS, DBAccess, Uni, uniDBComboBox,
  uniMultiItem, uniPageControl, uniBasicGrid, uniDBGrid, uniSweetAlert;

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
    lblTeklif: TUniLabel;
    lkTeklif: TUniDBLookupComboBox;
    btnTeklifYenile: TUniButton;
    lblSiparis: TUniLabel;
    edSiparis: TUniEdit;
    btnSiparisBul: TUniButton;
    lblSiparisTar: TUniLabel;
    lblSiparisAcik: TUniLabel;
    saBaglantiDurum: TUniSweetAlert;
    lblBitis: TUniLabel;
    dtBitis: TUniDateTimePicker;
    lblOncelik: TUniLabel;
    cbOncelik: TUniComboBox;
    lblAtanan: TUniLabel;
    lkAtanan: TUniDBLookupComboBox;
    lblDurum: TUniLabel;
    lkDurum: TUniDBLookupComboBox;
    tsTarihce: TUniTabSheet;
    grdTarihce: TUniDBGrid;
    panFooter: TUniPanel;
    btnKaydet: TUniButton;
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
    procedure UniFormShow(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnCariBulClick(Sender: TObject);
    procedure btnTeklifYenileClick(Sender: TObject);
    procedure btnSiparisBulClick(Sender: TObject);
    procedure lkTeklifCloseUp(Sender: TObject);
    procedure lkDurumCloseUp(Sender: TObject);
    procedure saBaglantiDurumConfirm(Sender: TObject);
  private
    FAktiviteId: Int64;
    FBaslangicTeklifId: Int64;
    FPendingDurumId: Int64;
    procedure YukleOncelik;
    procedure SetComboByText(ACombo: TUniComboBox; const AText: string);
    procedure KullanicilariAc;
    procedure AcDurumLookup;
    procedure VarsayilanDurum;
    procedure YeniGorevState;
    procedure UygulaBaslangicTeklifGorev(ATeklifId: Int64);
    procedure TeklifLookupYenile(AForceTid: Int64);
    function TeklifIdFromLookup: Int64;
    function MevcutDurumId: Int64;
    procedure BaglantiDurumDegerlendir(const AKaynakTip: string);
    procedure SiparisSecildi(Sender: TObject; const ASiparisKod: string);
    procedure YukleGorev;
    function DurumKodFromLookup: string;
    function GorevTipId: Int64;
    procedure TarihceYukle;
    procedure GorevLogKaydet(const IsNew: Boolean; const OldKonu, OldAcik, OldDurAd, OldBitisStr, OldAtananAd: string;
      OldTamam: Boolean);
  public
  end;

function frmCrmGorev: TfrmCrmGorev;

implementation

{$R *.dfm}

uses
  uniGUIApplication, MainModule, DMU, TmpU, CrmCariSecU, CrmSiparisSecU, CrmBaglantiDurumU, CrmAktiviteLogU;

procedure TfrmCrmGorev.btnCariBulClick(Sender: TObject);
begin
  frmCrmCariSec.HedefCariEdit := edCariKod;
  frmCrmCariSec.edArama.Text := Trim(edCariKod.Text);
  frmCrmCariSec.ShowModal;
end;

function frmCrmGorev: TfrmCrmGorev;
begin
  Result := TfrmCrmGorev(UniMainModule.GetFormInstance(TfrmCrmGorev));
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
  FBaslangicTeklifId := 0;
  Caption := 'Yeni G'#246'rev';
  edKonu.Text := '';
  mmAciklama.Text := '';
  edCariKod.Text := '';
  TeklifLookupYenile(0);
  lkTeklif.KeyValue := Null;
  edSiparis.Text := '';
  lblSiparisTar.Caption := '';
  lblSiparisAcik.Caption := '';
  dtBitis.DateTime := Now;
  YukleOncelik;
  AcDurumLookup;
  VarsayilanDurum;
  lkAtanan.KeyValue := Tmp.xKullaniciID;
end;

procedure TfrmCrmGorev.YukleGorev;
var
  DurId: Int64;
  TamB: Boolean;
begin
  qLoad.Close;
  qLoad.SQL.Text :=
    'SELECT A.KONU, A.ACIKLAMA, A.CARI_KOD, A.AKTIVITE_DURUM_ID, A.TEKLIF_ID, A.SIPARIS_NO, ' +
    'G.BITIS_TARIHI, G.ONCELIK, G.TAMAMLANDI, G.ATANAN_KULLANICI_ID ' +
    'FROM dbo.CRM_AKTIVITE A ' +
    'INNER JOIN dbo.CRM_GOREV G ON G.AKTIVITE_ID = A.AKTIVITE_ID ' +
    'WHERE A.AKTIVITE_ID = :AID AND A.TIP = ''TASK''';
  qLoad.ParamByName('AID').AsLargeInt := FAktiviteId;
  qLoad.Open;
  if qLoad.IsEmpty then
  begin
    qLoad.Close;
    UniMainModule.saHata.Show('Gùrev bulunamadù.');
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
    edCariKod.Text := ''
  else
    edCariKod.Text := qLoad.FieldByName('CARI_KOD').AsString;
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
  qLoad.Close;

  if TamB and qDurLkp.Locate('KOD', 'TAMAMLANDI', [loCaseInsensitive]) then
    lkDurum.KeyValue := qDurLkp.FieldByName('DURUM_ID').AsLargeInt
  else if (DurId > 0) and qDurLkp.Locate('DURUM_ID', DurId, []) then
    lkDurum.KeyValue := DurId
  else
    VarsayilanDurum;

  Caption := 'G' + #$00F6 + 'rev';
  TarihceYukle;
end;

procedure TfrmCrmGorev.TarihceYukle;
begin
  CrmTarihceYukle(qLog, FAktiviteId);
end;

procedure TfrmCrmGorev.GorevLogKaydet(const IsNew: Boolean; const OldKonu, OldAcik, OldDurAd, OldBitisStr,
  OldAtananAd: string; OldTamam: Boolean);
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

procedure TfrmCrmGorev.UniFormShow(Sender: TObject);
var
  PrefTeklif: Int64;
begin
  KullanicilariAc;
  FAktiviteId := StrToInt64Def(Trim(Hint), 0);
  PrefTeklif := Tmp.xCrmYeniGorevTeklifId;
  Tmp.xCrmYeniGorevTeklifId := 0;
  if FAktiviteId > 0 then
    YukleGorev
  else
  begin
    YeniGorevState;
    if PrefTeklif > 0 then
      UygulaBaslangicTeklifGorev(PrefTeklif);
  end;
end;

procedure TfrmCrmGorev.btnKaydetClick(Sender: TObject);
var
  Aid: Int64;
  Tamam: Integer;
  TaskTid: Int64;
  Dkod: string;
  IsNew: Boolean;
  OldKonu, OldAcik, OldDurAd, OldBitisStr, OldAtananAd: string;
  OldDurId, OldAtananId: Int64;
  OldTamam: Boolean;
begin
  IsNew := FAktiviteId <= 0;
  OldKonu := '';
  OldAcik := '';
  OldDurAd := '';
  OldBitisStr := '';
  OldAtananAd := '';
  OldTamam := False;
  OldDurId := 0;
  OldAtananId := 0;
  if FAktiviteId > 0 then
  begin
    qLoad.Close;
    qLoad.SQL.Text :=
      'SELECT A.KONU, A.ACIKLAMA, A.AKTIVITE_DURUM_ID, G.BITIS_TARIHI, G.ATANAN_KULLANICI_ID, G.TAMAMLANDI ' +
      'FROM dbo.CRM_AKTIVITE A INNER JOIN dbo.CRM_GOREV G ON G.AKTIVITE_ID = A.AKTIVITE_ID WHERE A.AKTIVITE_ID = :ID';
    qLoad.ParamByName('ID').AsLargeInt := FAktiviteId;
    qLoad.Open;
    if not qLoad.IsEmpty then
    begin
      OldKonu := qLoad.FieldByName('KONU').AsString;
      OldAcik := qLoad.FieldByName('ACIKLAMA').AsString;
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
    UniMainModule.saHata.Show('Durum seùiniz.');
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
        UniMainModule.saHata.Show('Secilen teklifin cari kodu ile gorev carisi uyusmuyor.');
        Exit;
      end;
    end;
    qLoad.Close;
  end;

  if FAktiviteId > 0 then
  begin
    Aid := FAktiviteId;
    qInsAkt.Close;
    qInsAkt.SQL.Clear;
    qInsAkt.SQL.Add('UPDATE dbo.CRM_AKTIVITE SET KONU = :KONU, ACIKLAMA = :ACIKLAMA, CARI_KOD = :CARI_KOD,');
    qInsAkt.SQL.Add('DURUM = :DURUM, AKTIVITE_DURUM_ID = :DID, TEKLIF_ID = :TID_TEK, SIPARIS_NO = :SIPNO,');
    qInsAkt.SQL.Add('GUNCELLEME_UTC = SYSUTCDATETIME() WHERE AKTIVITE_ID = :AID AND TIP = ''TASK''');
    qInsAkt.ParamByName('AID').AsLargeInt := Aid;
    qInsAkt.ParamByName('KONU').AsString := edKonu.Text;
    qInsAkt.ParamByName('ACIKLAMA').AsString := mmAciklama.Text;
    if Trim(edCariKod.Text) <> '' then
      qInsAkt.ParamByName('CARI_KOD').AsString := Trim(edCariKod.Text)
    else
      qInsAkt.ParamByName('CARI_KOD').Clear;
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
      UniMainModule.saHata.Show('CRM: TASK aktivite tipi bulunamadù. Veritabanù migrasyonunu ùalùùtùrùn.');
      Exit;
    end;

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
          UniMainModule.saHata.Show('Secilen teklifin cari kodu ile gorev carisi uyusmuyor.');
          Exit;
        end;
      end;
      qLoad.Close;
    end;

    qInsAkt.Close;
    qInsAkt.SQL.Clear;
    qInsAkt.SQL.Add('INSERT INTO dbo.CRM_AKTIVITE (TIP, KONU, ACIKLAMA, CARI_KOD, AKTIVITE_TARIHI, DURUM, OLUSTURAN_KULLANICI_ID, AKTIVITE_TIP_ID, AKTIVITE_DURUM_ID, TEKLIF_ID, SIPARIS_NO)');
    qInsAkt.SQL.Add('OUTPUT INSERTED.AKTIVITE_ID');
    qInsAkt.SQL.Add('VALUES (''TASK'', :KONU, :ACIKLAMA, :CARI_KOD, :AKTAR, :DURUM, :KUL, :TID_REF, :DID_REF, :TID_TEK, :SIPNO)');
    qInsAkt.ParamByName('KONU').AsString := edKonu.Text;
    qInsAkt.ParamByName('ACIKLAMA').AsString := mmAciklama.Text;
    if Trim(edCariKod.Text) <> '' then
      qInsAkt.ParamByName('CARI_KOD').AsString := Trim(edCariKod.Text)
    else
      qInsAkt.ParamByName('CARI_KOD').Clear;
    qInsAkt.ParamByName('AKTAR').AsDateTime := Now;
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
      UniMainModule.saHata.Show('CRM aktivite kaydù oluùmadù (AktiviteID alùnamadù).');
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
    GorevLogKaydet(IsNew, OldKonu, OldAcik, OldDurAd, OldBitisStr, OldAtananAd, OldTamam);
    TarihceYukle;
  end;

  UniMainModule.saKaydet.Show('G' + #$00F6 + 'rev kaydedildi.');
end;

end.
