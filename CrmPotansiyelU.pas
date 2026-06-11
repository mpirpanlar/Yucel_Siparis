unit CrmPotansiyelU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniMemo, uniButton, uniCheckBox, uniComboBox, uniDateTimePicker,
  uniDBLookupComboBox, uniPageControl, Data.DB, MemDS, DBAccess, Uni,
  uniDBComboBox, uniMultiItem;

type
  TfrmCrmPotansiyel = class(TUniForm)
    rootPanel: TUniPanel;
    panFooter: TUniPanel;
    btnKaydet: TUniButton;
    btnYeniAktivite: TUniButton;
    btnYeniGorev: TUniButton;
    btnKapat: TUniButton;
    pc: TUniPageControl;
    tabFirma: TUniTabSheet;
    panFirma: TUniPanel;
    lblUnvan: TUniLabel;
    edUnvan: TUniEdit;
    lblKisa: TUniLabel;
    edKisa: TUniEdit;
    lblMustTip: TUniLabel;
    cbMustTip: TUniComboBox;
    lblVdaire: TUniLabel;
    edVdaire: TUniEdit;
    lblVno: TUniLabel;
    edVno: TUniEdit;
    lblTc: TUniLabel;
    edTc: TUniEdit;
    lblMersis: TUniLabel;
    edMersis: TUniEdit;
    lblSektor: TUniLabel;
    edSektor: TUniEdit;
    lblFaal: TUniLabel;
    edFaal: TUniEdit;
    lblCalisan: TUniLabel;
    edCalisan: TUniEdit;
    lblCiro: TUniLabel;
    edCiro: TUniEdit;
    lblPara: TUniLabel;
    cbPara: TUniComboBox;
    lblKaynak: TUniLabel;
    edKaynak: TUniEdit;
    tabAdres: TUniTabSheet;
    panAdres: TUniPanel;
    lblUlke: TUniLabel;
    edUlke: TUniEdit;
    lblIl: TUniLabel;
    edIl: TUniEdit;
    lblIlce: TUniLabel;
    edIlce: TUniEdit;
    lblPk: TUniLabel;
    edPk: TUniEdit;
    lblAdres: TUniLabel;
    mmAdres: TUniMemo;
    tabKonum: TUniTabSheet;
    panKonum: TUniPanel;
    lblGpsE: TUniLabel;
    edGpsEnlem: TUniEdit;
    lblGpsB: TUniLabel;
    edGpsBoylam: TUniEdit;
    btnHaritaKonum: TUniButton;
    lblHarFmt: TUniLabel;
    mmHaritaAdres: TUniMemo;
    lblKonumBilgi: TUniLabel;
    tabIletisim: TUniTabSheet;
    panIletisim: TUniPanel;
    lblTel: TUniLabel;
    edTel: TUniEdit;
    lblTel2: TUniLabel;
    edTel2: TUniEdit;
    lblCep: TUniLabel;
    edCep: TUniEdit;
    lblFaks: TUniLabel;
    edFaks: TUniEdit;
    lblEposta: TUniLabel;
    edEposta: TUniEdit;
    lblWeb: TUniLabel;
    edWeb: TUniEdit;
    lblYetAd: TUniLabel;
    edYetAd: TUniEdit;
    lblYetUnv: TUniLabel;
    edYetUnv: TUniEdit;
    lblYetEposta: TUniLabel;
    edYetEposta: TUniEdit;
    lblYetTel: TUniLabel;
    edYetTel: TUniEdit;
    lblMuhAd: TUniLabel;
    edMuhAd: TUniEdit;
    lblMuhTel: TUniLabel;
    edMuhTel: TUniEdit;
    lblMuhEposta: TUniLabel;
    edMuhEposta: TUniEdit;
    tabTakip: TUniTabSheet;
    panTakip: TUniPanel;
    lblDurum: TUniLabel;
    lkDurum: TUniDBLookupComboBox;
    chkIlkTar: TUniCheckBox;
    dtIlk: TUniDateTimePicker;
    chkSonTakip: TUniCheckBox;
    dtSonTakip: TUniDateTimePicker;
    chkSonraki: TUniCheckBox;
    dtSonraki: TUniDateTimePicker;
    lblNot: TUniLabel;
    mmNot: TUniMemo;
    lblNetsis: TUniLabel;
    edNetsis: TUniEdit;
    btnCariBul: TUniButton;
    btnNetsisTemizle: TUniButton;
    btnNetsisCariOlustur: TUniButton;
    qLoad: TUniQuery;
    qExec: TUniQuery;
    qDurLkp: TUniQuery;
    dsDurLkp: TUniDataSource;
    procedure UniFormShow(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnYeniAktiviteClick(Sender: TObject);
    procedure btnYeniGorevClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure btnCariBulClick(Sender: TObject);
    procedure btnNetsisTemizleClick(Sender: TObject);
    procedure btnNetsisCariOlusturClick(Sender: TObject);
    procedure btnHaritaKonumClick(Sender: TObject);
  private
    FPotansiyelId: Int64;
    FYuklenenNetsis: string;
    FHasLoadedBagUtc: Boolean;
    FLoadedBaglantiUtc: TDateTime;
    function ParseDecimal(const S: string): Double;
    procedure AcDurumLookup;
    procedure VarsayilanDurum;
    procedure YeniKayit;
    procedure YukleKayit;
    procedure StrToParam(Q: TUniQuery; const N, V: string);
    procedure DateToParam(Q: TUniQuery; const N: string; UseIt: Boolean; D: TDateTime);
    function NetsisBaglantiUtcParam: Variant;
    procedure InitCombos;
    function NetsisCariSablonOku: string;
    function NetsisCariKodUret(const ASablon: string): string;
    function SonrakiCariSiraNoFromSablon(const APrefix: string; ADigitLen: Integer): Int64;
    function NetsisCariNetOpenXOlustur(const ACariKod: string): Boolean;
    procedure PotansiyelNetsisKodBagla(const ACariKod: string);
    procedure HaritaAdresiniAyikla(const AAddr: string);
  public
  end;

function frmCrmPotansiyel: TfrmCrmPotansiyel;

implementation

{$R *.dfm}

uses
  System.DateUtils,
  uniGUIApplication, MainModule, DMU, TmpU, CrmCariSecU, CrmHaritaSecU, Main, Genel,
  CrmAktiviteU, CrmGorevU, NetOpenX50_TLB;

function frmCrmPotansiyel: TfrmCrmPotansiyel;
begin
  Result := TfrmCrmPotansiyel(UniMainModule.GetFormInstance(TfrmCrmPotansiyel));
end;

function TfrmCrmPotansiyel.ParseDecimal(const S: string): Double;
var
  T: string;
  FS: TFormatSettings;
begin
  T := Trim(StringReplace(S, ',', '.', [rfReplaceAll]));
  FS := FormatSettings;
  FS.DecimalSeparator := '.';
  Result := StrToFloatDef(T, 0, FS);
end;

procedure TfrmCrmPotansiyel.StrToParam(Q: TUniQuery; const N, V: string);
begin
  if Trim(V) <> '' then
    Q.ParamByName(N).AsString := Trim(V)
  else
    Q.ParamByName(N).Clear;
end;

procedure TfrmCrmPotansiyel.DateToParam(Q: TUniQuery; const N: string; UseIt: Boolean; D: TDateTime);
begin
  if not UseIt then
    Q.ParamByName(N).Clear
  else
    Q.ParamByName(N).AsDateTime := DateOf(D);
end;

function TfrmCrmPotansiyel.NetsisBaglantiUtcParam: Variant;
var
  Nk: string;
begin
  Nk := Trim(edNetsis.Text);
  if Nk = '' then
  begin
    Result := Null;
    Exit;
  end;
  if (FPotansiyelId <= 0) or (Nk <> FYuklenenNetsis) then
    Result := Now
  else if FHasLoadedBagUtc then
    Result := FLoadedBaglantiUtc
  else
    Result := Now;
end;

procedure TfrmCrmPotansiyel.AcDurumLookup;
begin
  qDurLkp.Close;
  qDurLkp.SQL.Text :=
    'SELECT POTANSIYEL_DURUM_ID, KOD, (KOD + N'' - '' + ISNULL(ACIKLAMA, N'''')) AS AD ' +
    'FROM dbo.CRM_POTANSIYEL_DURUM WHERE AKTIF = 1 ORDER BY SIRA, POTANSIYEL_DURUM_ID';
  qDurLkp.Open;
end;

procedure TfrmCrmPotansiyel.VarsayilanDurum;
begin
  lkDurum.KeyValue := Null;
  if qDurLkp.Active and qDurLkp.Locate('KOD', 'YENI', [loCaseInsensitive]) then
    lkDurum.KeyValue := qDurLkp.FieldByName('POTANSIYEL_DURUM_ID').AsLargeInt
  else if qDurLkp.Active and not qDurLkp.IsEmpty then
    lkDurum.KeyValue := qDurLkp.FieldByName('POTANSIYEL_DURUM_ID').AsLargeInt;
end;

procedure TfrmCrmPotansiyel.YeniKayit;
begin
  FPotansiyelId := 0;
  FYuklenenNetsis := '';
  FHasLoadedBagUtc := False;
  Caption := 'Yeni Potansiyel M��teri';
  edUnvan.Text := '';
  edKisa.Text := '';
  cbMustTip.ItemIndex := 0;
  edVdaire.Text := '';
  edVno.Text := '';
  edTc.Text := '';
  edMersis.Text := '';
  edSektor.Text := '';
  edFaal.Text := '';
  edCalisan.Text := '';
  edCiro.Text := '';
  cbPara.ItemIndex := 0;
  edKaynak.Text := '';
  edUlke.Text := 'Turkiye';
  edIl.Text := '';
  edIlce.Text := '';
  edPk.Text := '';
  mmAdres.Clear;
  edGpsEnlem.Text := '';
  edGpsBoylam.Text := '';
  mmHaritaAdres.Clear;
  edTel.Text := '';
  edTel2.Text := '';
  edCep.Text := '';
  edFaks.Text := '';
  edEposta.Text := '';
  edWeb.Text := '';
  edYetAd.Text := '';
  edYetUnv.Text := '';
  edYetEposta.Text := '';
  edYetTel.Text := '';
  edMuhAd.Text := '';
  edMuhTel.Text := '';
  edMuhEposta.Text := '';
  AcDurumLookup;
  VarsayilanDurum;
  chkIlkTar.Checked := True;
  dtIlk.DateTime := Now;
  chkSonTakip.Checked := False;
  dtSonTakip.DateTime := Now;
  chkSonraki.Checked := False;
  dtSonraki.DateTime := Now + 7;
  mmNot.Clear;
  edNetsis.Text := '';
end;

procedure TfrmCrmPotansiyel.YukleKayit;
begin
  qLoad.Close;
  qLoad.SQL.Text :=
    'SELECT * FROM dbo.CRM_POTANSIYEL_MUSTERI WHERE POTANSIYEL_ID = :ID';
  qLoad.ParamByName('ID').AsLargeInt := FPotansiyelId;
  qLoad.Open;
  if qLoad.IsEmpty then
  begin
    qLoad.Close;
    UniMainModule.saHata.Show('Kay�t bulunamad�.');
    YeniKayit;
    Exit;
  end;
  edUnvan.Text := qLoad.FieldByName('FIRMA_UNVAN').AsString;
  edKisa.Text := qLoad.FieldByName('KISA_AD').AsString;
  if SameText(qLoad.FieldByName('MUSTERI_TIPI').AsString, 'BIREYSEL') then
    cbMustTip.ItemIndex := 1
  else
    cbMustTip.ItemIndex := 0;
  edVdaire.Text := qLoad.FieldByName('VERGI_DAIRESI').AsString;
  edVno.Text := qLoad.FieldByName('VERGI_NO').AsString;
  edTc.Text := qLoad.FieldByName('TC_KIMLIK_NO').AsString;
  edMersis.Text := qLoad.FieldByName('MERSIS_NO').AsString;
  edSektor.Text := qLoad.FieldByName('SEKTOR').AsString;
  edFaal.Text := qLoad.FieldByName('FAALIYET_KONUSU').AsString;
  if qLoad.FieldByName('CALISAN_SAYISI').IsNull then
    edCalisan.Text := ''
  else
    edCalisan.Text := IntToStr(qLoad.FieldByName('CALISAN_SAYISI').AsInteger);
  if qLoad.FieldByName('TAHMINI_YILLIK_CIRO').IsNull then
    edCiro.Text := ''
  else
    edCiro.Text := FloatToStr(qLoad.FieldByName('TAHMINI_YILLIK_CIRO').AsFloat);
  cbPara.ItemIndex := cbPara.Items.IndexOf(qLoad.FieldByName('PARA_BIRIMI').AsString);
  if cbPara.ItemIndex < 0 then
    cbPara.ItemIndex := 0;
  edKaynak.Text := qLoad.FieldByName('KAYNAK').AsString;
  edUlke.Text := qLoad.FieldByName('ULKE').AsString;
  edIl.Text := qLoad.FieldByName('IL').AsString;
  edIlce.Text := qLoad.FieldByName('ILCE').AsString;
  edPk.Text := qLoad.FieldByName('POSTA_KODU').AsString;
  mmAdres.Text := qLoad.FieldByName('ADRES').AsString;
  if qLoad.FindField('GPS_ENLEM') <> nil then
  begin
    if qLoad.FieldByName('GPS_ENLEM').IsNull then
      edGpsEnlem.Text := ''
    else
      edGpsEnlem.Text := FormatFloat('0.######', qLoad.FieldByName('GPS_ENLEM').AsFloat, TFormatSettings.Invariant);
    if qLoad.FieldByName('GPS_BOYLAM').IsNull then
      edGpsBoylam.Text := ''
    else
      edGpsBoylam.Text := FormatFloat('0.######', qLoad.FieldByName('GPS_BOYLAM').AsFloat, TFormatSettings.Invariant);
    mmHaritaAdres.Text := qLoad.FieldByName('HARITA_FORMATLI_ADRES').AsString;
  end
  else
  begin
    edGpsEnlem.Text := '';
    edGpsBoylam.Text := '';
    mmHaritaAdres.Clear;
  end;
  edTel.Text := qLoad.FieldByName('TELEFON_SABIT').AsString;
  edTel2.Text := qLoad.FieldByName('TELEFON2').AsString;
  edCep.Text := qLoad.FieldByName('TELEFON_CEPTEL').AsString;
  edFaks.Text := qLoad.FieldByName('FAKS').AsString;
  edEposta.Text := qLoad.FieldByName('EPOSTA').AsString;
  edWeb.Text := qLoad.FieldByName('WEB').AsString;
  edYetAd.Text := qLoad.FieldByName('YETKILI_AD_SOYAD').AsString;
  edYetUnv.Text := qLoad.FieldByName('YETKILI_UNVAN').AsString;
  edYetEposta.Text := qLoad.FieldByName('YETKILI_EPOSTA').AsString;
  edYetTel.Text := qLoad.FieldByName('YETKILI_TEL').AsString;
  edMuhAd.Text := qLoad.FieldByName('MUHASEBE_YETKILI_AD').AsString;
  edMuhTel.Text := qLoad.FieldByName('MUHASEBE_TEL').AsString;
  edMuhEposta.Text := qLoad.FieldByName('MUHASEBE_EPOSTA').AsString;
  AcDurumLookup;
  lkDurum.KeyValue := qLoad.FieldByName('POTANSIYEL_DURUM_ID').AsLargeInt;
  chkIlkTar.Checked := not qLoad.FieldByName('ILK_ILETISIM_TARIHI').IsNull;
  if chkIlkTar.Checked then
    dtIlk.DateTime := qLoad.FieldByName('ILK_ILETISIM_TARIHI').AsDateTime;
  chkSonTakip.Checked := not qLoad.FieldByName('SON_TAKIP_TARIHI').IsNull;
  if chkSonTakip.Checked then
    dtSonTakip.DateTime := qLoad.FieldByName('SON_TAKIP_TARIHI').AsDateTime;
  chkSonraki.Checked := not qLoad.FieldByName('SONRAKI_AKSYON_TARIHI').IsNull;
  if chkSonraki.Checked then
    dtSonraki.DateTime := qLoad.FieldByName('SONRAKI_AKSYON_TARIHI').AsDateTime;
  mmNot.Text := qLoad.FieldByName('NOTLAR').AsString;
  if qLoad.FieldByName('NETSIS_CARI_KOD').IsNull then
  begin
    edNetsis.Text := '';
    FYuklenenNetsis := '';
  end
  else
  begin
    edNetsis.Text := Trim(qLoad.FieldByName('NETSIS_CARI_KOD').AsString);
    FYuklenenNetsis := edNetsis.Text;
  end;
  FHasLoadedBagUtc := not qLoad.FieldByName('NETSIS_BAGLANTI_UTC').IsNull;
  if FHasLoadedBagUtc then
    FLoadedBaglantiUtc := qLoad.FieldByName('NETSIS_BAGLANTI_UTC').AsDateTime;
  qLoad.Close;
  Caption := 'Potansiyel M��teri';
end;

procedure TfrmCrmPotansiyel.InitCombos;
begin
  if cbMustTip.Items.Count = 0 then
  begin
    cbMustTip.Items.Add('KURUMSAL');
    cbMustTip.Items.Add('BIREYSEL');
  end;
  if cbPara.Items.Count = 0 then
  begin
    cbPara.Items.Add('TRY');
    cbPara.Items.Add('USD');
    cbPara.Items.Add('EUR');
    cbPara.Items.Add('GBP');
  end;
end;

procedure TfrmCrmPotansiyel.UniFormShow(Sender: TObject);
begin
  InitCombos;
  FPotansiyelId := StrToInt64Def(Trim(Hint), 0);
  if FPotansiyelId > 0 then
    YukleKayit
  else
    YeniKayit;
end;

procedure TfrmCrmPotansiyel.btnCariBulClick(Sender: TObject);
begin
  frmCrmCariSec.HedefCariEdit := edNetsis;
  frmCrmCariSec.edArama.Text := Trim(edNetsis.Text);
  frmCrmCariSec.ShowModal;
end;

procedure TfrmCrmPotansiyel.btnNetsisTemizleClick(Sender: TObject);
begin
  edNetsis.Text := '';
end;

function TfrmCrmPotansiyel.NetsisCariSablonOku: string;
begin
  Result := '120#####';
  qLoad.Close;
  qLoad.SQL.Text :=
    'SELECT NETSIS_CARI_SABLON FROM dbo.PARAMETRE WITH(NOLOCK) WHERE SUBE_KODU = :SUBE';
  qLoad.ParamByName('SUBE').AsInteger := Tmp.xSubeKodu;
  qLoad.Open;
  if not qLoad.IsEmpty then
  begin
    if (qLoad.FindField('NETSIS_CARI_SABLON') <> nil) and
      not qLoad.FieldByName('NETSIS_CARI_SABLON').IsNull then
    begin
      Result := Trim(qLoad.FieldByName('NETSIS_CARI_SABLON').AsString);
      if Result = '' then
        Result := '120#####';
    end;
  end;
  qLoad.Close;
end;

function TfrmCrmPotansiyel.SonrakiCariSiraNoFromSablon(const APrefix: string; ADigitLen: Integer): Int64;
var
  ToplamUz: Integer;
begin
  Result := 1;
  if (APrefix = '') or (ADigitLen <= 0) then
    Exit;
  ToplamUz := Length(APrefix) + ADigitLen;
  qLoad.Close;
  qLoad.SQL.Text :=
    'SELECT ISNULL(MAX(TRY_CAST(RIGHT(CARI_KOD, :DIG) AS BIGINT)), 0) AS MX ' +
    'FROM YUCEL..HV_CARI_LISTESI WITH(NOLOCK) ' +
    'WHERE CARI_KOD LIKE :PFX AND LEN(CARI_KOD) = :UZ';
  qLoad.ParamByName('PFX').AsString := APrefix + '%';
  qLoad.ParamByName('UZ').AsInteger := ToplamUz;
  qLoad.ParamByName('DIG').AsInteger := ADigitLen;
  qLoad.Open;
  if not qLoad.IsEmpty and not qLoad.FieldByName('MX').IsNull then
    Result := qLoad.FieldByName('MX').AsLargeInt + 1;
  qLoad.Close;
end;

function TfrmCrmPotansiyel.NetsisCariKodUret(const ASablon: string): string;
var
  Sablon, Prefix: string;
  i, HashCnt: Integer;
  NextNo: Int64;
  Fmt: string;
begin
  Sablon := Trim(ASablon);
  if Sablon = '' then
    Sablon := '120#####';
  HashCnt := 0;
  for i := 1 to Length(Sablon) do
    if Sablon[i] = '#' then
      Inc(HashCnt);
  if HashCnt <= 0 then
    Exit(Sablon);
  Prefix := Copy(Sablon, 1, Length(Sablon) - HashCnt);
  NextNo := SonrakiCariSiraNoFromSablon(Prefix, HashCnt);
  Fmt := '%.' + IntToStr(HashCnt) + 'd';
  Result := Prefix + Format(Fmt, [NextNo]);
end;

function TfrmCrmPotansiyel.NetsisCariNetOpenXOlustur(const ACariKod: string): Boolean;
var
  Kernel: IKernel;
  Sirket: ISirket;
  Cari: ICari;
  CariTemel: ICariTemelBilgi;
  CariEk: ICariEkBilgi;
  Kullanici, Sifre, Firma, Telefon: string;
  Sube: Integer;
begin
  Result := False;
  if Trim(ACariKod) = '' then
    Exit;

  Kullanici := Tmp.xNetsisKullanici;
  Sifre := Tmp.xNetsisSifre;
  Firma := Tmp.xNetsisSirketKodu;
  Sube := Tmp.xSubeKodu;

  Kernel := CoKernel.Create;
  Sirket := Kernel.yeniSirket(vtMSSQL, Firma, 'TemelSet', '', Kullanici, Sifre, Sube);

  Cari := Kernel.yeniCari(Sirket);
  CariTemel := Cari.TemelBilgi;
  CariEk := Cari.EkBilgi;

  Telefon := Trim(edTel.Text);
  if Telefon = '' then
    Telefon := Trim(edCep.Text);

  Cari.NetsisTransaction(ttBaslat);
  try
    CariTemel.CARI_KOD := Trim(ACariKod);
    CariTemel.CARI_ISIM := Trim(edUnvan.Text);
    CariTemel.CARI_TIP := 'A';
    CariTemel.CARI_ADRES := Trim(mmAdres.Text);
    CariTemel.CARI_IL := Trim(edIl.Text);
    CariTemel.CARI_ILCE := Trim(edIlce.Text);
    CariTemel.CARI_TEL := Telefon;
    CariTemel.VERGI_DAIRESI := Trim(edVdaire.Text);
    CariTemel.VERGI_NUMARASI := Trim(edVno.Text);
    CariTemel.ULKE_KODU := 'TR';
    CariTemel.EMAIL := Trim(edEposta.Text);

    CariEk.CARI_KOD := Trim(ACariKod);
    CariEk.TcKimlikNo := Trim(edTc.Text);

    Cari.kayitYeni;
    Cari.NetsisTransaction(ttBitir);
    Result := True;
  except
    Cari.NetsisTransaction(ttGeriAl);
    raise;
  end;
end;

procedure TfrmCrmPotansiyel.PotansiyelNetsisKodBagla(const ACariKod: string);
begin
  qExec.Close;
  qExec.SQL.Text :=
    'UPDATE dbo.CRM_POTANSIYEL_MUSTERI SET NETSIS_CARI_KOD = :NKOD, ' +
    'NETSIS_BAGLANTI_UTC = SYSUTCDATETIME(), GUNCELLEME_UTC = SYSUTCDATETIME() ' +
    'WHERE POTANSIYEL_ID = :PID';
  qExec.ParamByName('NKOD').AsString := Trim(ACariKod);
  qExec.ParamByName('PID').AsLargeInt := FPotansiyelId;
  qExec.Execute;
end;

procedure TfrmCrmPotansiyel.btnNetsisCariOlusturClick(Sender: TObject);
var
  Sablon, YeniKod: string;
begin
  if Trim(edNetsis.Text) <> '' then
  begin
    UniMainModule.saHata.Show(
      'Bu potansiyel m��teri i�in zaten Netsis cari ba�lant�s� var.' + sLineBreak +
      'Mevcut kod: ' + Trim(edNetsis.Text));
    Exit;
  end;
  if FPotansiyelId <= 0 then
  begin
    UniMainModule.saHata.Show('�nce potansiyel m��teriyi kaydedin, sonra Netsis cari olu�turabilirsiniz.');
    Exit;
  end;

  try
    Sablon := NetsisCariSablonOku;
    YeniKod := NetsisCariKodUret(Sablon);
    if Trim(YeniKod) = '' then
    begin
      UniMainModule.saHata.Show('Netsis cari kodu �retilemedi. PARAMETRE.NETSIS_CARI_SABLON de�erini kontrol edin.');
      Exit;
    end;

    if not NetsisCariNetOpenXOlustur(YeniKod) then
    begin
      UniMainModule.saHata.Show('Netsis cari olu�turma i�lemi tamamlanamad�.');
      Exit;
    end;

    PotansiyelNetsisKodBagla(YeniKod);
    edNetsis.Text := YeniKod;
    FYuklenenNetsis := YeniKod;
    FHasLoadedBagUtc := True;
    FLoadedBaglantiUtc := Now;
    UniMainModule.saKaydet.Show('Netsis cari kodu olu�turuldu ve potansiyel kayda ba�land�: ' + YeniKod);
  except
    on E: Exception do
      UniMainModule.saHata.Show('Netsis cari olu�turma hatas�: ' + E.Message);
  end;
end;

procedure TfrmCrmPotansiyel.HaritaAdresiniAyikla(const AAddr: string);

  function TumuRakam(const S: string): Boolean;
  var
    I: Integer;
  begin
    Result := S <> '';
    for I := 1 to Length(S) do
      if not CharInSet(S[I], ['0'..'9']) then
      begin
        Result := False;
        Break;
      end;
  end;

var
  Adr, SehirBolum, IlceIl, Pk, Il, Ilce, Ulke, Detay, Token: string;
  Parts: TArray<string>;
  N, I, SpacePos, SlashPos: Integer;
begin
  // Google formatted_address (ornek: 'Sokak/Cadde, 35220 Konak/Izmir, Turkiye')
  // virgulle ayrilan parcalardan ulke / il / ilce / posta kodu / adres detayi cikarilir.
  Adr := Trim(AAddr);
  if Adr = '' then
    Exit;

  Parts := Adr.Split([',']);
  N := Length(Parts);
  for I := 0 to N - 1 do
    Parts[I] := Trim(Parts[I]);

  Ulke := '';
  Pk := '';
  Il := '';
  Ilce := '';
  Detay := '';

  if N >= 1 then
    Ulke := Parts[N - 1];

  if N >= 2 then
  begin
    SehirBolum := Parts[N - 2];
    SpacePos := Pos(' ', SehirBolum);
    if SpacePos > 0 then
    begin
      Token := Copy(SehirBolum, 1, SpacePos - 1);
      if (Length(Token) >= 4) and (Length(Token) <= 6) and TumuRakam(Token) then
      begin
        Pk := Token;
        IlceIl := Trim(Copy(SehirBolum, SpacePos + 1, MaxInt));
      end
      else
        IlceIl := SehirBolum;
    end
    else
      IlceIl := SehirBolum;

    SlashPos := Pos('/', IlceIl);
    if SlashPos > 0 then
    begin
      Ilce := Trim(Copy(IlceIl, 1, SlashPos - 1));
      Il := Trim(Copy(IlceIl, SlashPos + 1, MaxInt));
    end
    else
      Il := Trim(IlceIl);
  end;

  if N >= 3 then
    for I := 0 to N - 3 do
    begin
      if Detay <> '' then
        Detay := Detay + ', ';
      Detay := Detay + Parts[I];
    end;

  if Ulke <> '' then edUlke.Text := Ulke;
  if Il <> '' then edIl.Text := Il;
  if Ilce <> '' then edIlce.Text := Ilce;
  if Pk <> '' then edPk.Text := Pk;
  if Detay <> '' then mmAdres.Text := Detay;
end;

procedure TfrmCrmPotansiyel.btnHaritaKonumClick(Sender: TObject);
begin
  frmCrmHaritaSec.MerkezAyarla(ParseDecimal(edGpsEnlem.Text), ParseDecimal(edGpsBoylam.Text));
  frmCrmHaritaSec.HedefEnlemEdit := edGpsEnlem;
  frmCrmHaritaSec.HedefBoylamEdit := edGpsBoylam;
  frmCrmHaritaSec.HedefHaritaAdresMemo := mmHaritaAdres;
  frmCrmHaritaSec.ShowModal(
    procedure(ASender: TComponent; AResult: Integer)
    begin
      if AResult = mrOK then
        HaritaAdresiniAyikla(mmHaritaAdres.Text);
    end);
end;

procedure TfrmCrmPotansiyel.btnKaydetClick(Sender: TObject);
var
  NewId: Int64;
  Ci: Integer;
  Ciro: Double;
  BagUtc: Variant;
begin
  if Trim(edUnvan.Text) = '' then
  begin
    UniMainModule.saHata.Show('Firma / unvan zorunludur.');
    Exit;
  end;
  if VarIsNull(lkDurum.KeyValue) or VarIsEmpty(lkDurum.KeyValue) then
  begin
    UniMainModule.saHata.Show('Durum se�iniz.');
    Exit;
  end;

  Ci := StrToIntDef(Trim(edCalisan.Text), -1);
  if Trim(edCalisan.Text) = '' then
    Ci := -1;
  if Trim(edCiro.Text) = '' then
    Ciro := -1
  else
    Ciro := ParseDecimal(edCiro.Text);

  BagUtc := NetsisBaglantiUtcParam;

  qExec.Close;
  if FPotansiyelId > 0 then
  begin
    qExec.SQL.Text :=
      'UPDATE dbo.CRM_POTANSIYEL_MUSTERI SET ' +
      'FIRMA_UNVAN = :FIRMA, KISA_AD = :KISA, MUSTERI_TIPI = :MTIP, VERGI_DAIRESI = :VDA, VERGI_NO = :VNO, ' +
      'TC_KIMLIK_NO = :TC, MERSIS_NO = :MER, NETSIS_CARI_KOD = :NKOD, NETSIS_BAGLANTI_UTC = :NBAG, ' +
      'ULKE = :ULKE, IL = :IL, ILCE = :ILCE, POSTA_KODU = :PK, ADRES = :ADR, ' +
      'GPS_ENLEM = :GPE, GPS_BOYLAM = :GPB, HARITA_FORMATLI_ADRES = :HADR, ' +
      'TELEFON_SABIT = :TEL, TELEFON_CEPTEL = :CEP, TELEFON2 = :TEL2, FAKS = :FAK, EPOSTA = :EP, WEB = :WEB, ' +
      'YETKILI_AD_SOYAD = :YAD, YETKILI_UNVAN = :YUNV, YETKILI_EPOSTA = :YEP, YETKILI_TEL = :YTEL, ' +
      'MUHASEBE_YETKILI_AD = :MAD, MUHASEBE_TEL = :MTEL, MUHASEBE_EPOSTA = :MEP, ' +
      'SEKTOR = :SEK, FAALIYET_KONUSU = :FAAL, CALISAN_SAYISI = :CALS, TAHMINI_YILLIK_CIRO = :CIRO, ' +
      'PARA_BIRIMI = :PB, KAYNAK = :KAY, POTANSIYEL_DURUM_ID = :DID, ' +
      'ILK_ILETISIM_TARIHI = :DT1, SON_TAKIP_TARIHI = :DT2, SONRAKI_AKSYON_TARIHI = :DT3, ' +
      'NOTLAR = :NOTL, GUNCELLEME_UTC = SYSUTCDATETIME() WHERE POTANSIYEL_ID = :PID';
    qExec.ParamByName('PID').AsLargeInt := FPotansiyelId;
  end
  else
  begin
    qExec.SQL.Text :=
      'INSERT INTO dbo.CRM_POTANSIYEL_MUSTERI (' +
      'FIRMA_UNVAN, KISA_AD, MUSTERI_TIPI, VERGI_DAIRESI, VERGI_NO, TC_KIMLIK_NO, MERSIS_NO, NETSIS_CARI_KOD, NETSIS_BAGLANTI_UTC, ' +
      'ULKE, IL, ILCE, POSTA_KODU, ADRES, GPS_ENLEM, GPS_BOYLAM, HARITA_FORMATLI_ADRES, ' +
      'TELEFON_SABIT, TELEFON_CEPTEL, TELEFON2, FAKS, EPOSTA, WEB, ' +
      'YETKILI_AD_SOYAD, YETKILI_UNVAN, YETKILI_EPOSTA, YETKILI_TEL, MUHASEBE_YETKILI_AD, MUHASEBE_TEL, MUHASEBE_EPOSTA, ' +
      'SEKTOR, FAALIYET_KONUSU, CALISAN_SAYISI, TAHMINI_YILLIK_CIRO, PARA_BIRIMI, KAYNAK, POTANSIYEL_DURUM_ID, ' +
      'ILK_ILETISIM_TARIHI, SON_TAKIP_TARIHI, SONRAKI_AKSYON_TARIHI, NOTLAR, OLUSTURAN_KULLANICI_ID) ' +
      'OUTPUT INSERTED.POTANSIYEL_ID VALUES (' +
      ':FIRMA, :KISA, :MTIP, :VDA, :VNO, :TC, :MER, :NKOD, :NBAG, ' +
      ':ULKE, :IL, :ILCE, :PK, :ADR, :GPE, :GPB, :HADR, ' +
      ':TEL, :CEP, :TEL2, :FAK, :EP, :WEB, ' +
      ':YAD, :YUNV, :YEP, :YTEL, :MAD, :MTEL, :MEP, ' +
      ':SEK, :FAAL, :CALS, :CIRO, :PB, :KAY, :DID, ' +
      ':DT1, :DT2, :DT3, :NOTL, :KUL)';
    qExec.ParamByName('KUL').AsInteger := Tmp.xKullaniciID;
  end;

  qExec.ParamByName('FIRMA').AsString := Trim(edUnvan.Text);
  StrToParam(qExec, 'KISA', edKisa.Text);
  if cbMustTip.ItemIndex = 1 then
    qExec.ParamByName('MTIP').AsString := 'BIREYSEL'
  else
    qExec.ParamByName('MTIP').AsString := 'KURUMSAL';
  StrToParam(qExec, 'VDA', edVdaire.Text);
  StrToParam(qExec, 'VNO', edVno.Text);
  StrToParam(qExec, 'TC', edTc.Text);
  StrToParam(qExec, 'MER', edMersis.Text);
  if Trim(edNetsis.Text) = '' then
  begin
    qExec.ParamByName('NKOD').Clear;
    qExec.ParamByName('NBAG').Clear;
  end
  else
  begin
    qExec.ParamByName('NKOD').AsString := Trim(edNetsis.Text);
    if VarIsNull(BagUtc) then
      qExec.ParamByName('NBAG').Clear
    else
      qExec.ParamByName('NBAG').AsDateTime := BagUtc;
  end;
  StrToParam(qExec, 'ULKE', edUlke.Text);
  StrToParam(qExec, 'IL', edIl.Text);
  StrToParam(qExec, 'ILCE', edIlce.Text);
  StrToParam(qExec, 'PK', edPk.Text);
  StrToParam(qExec, 'ADR', mmAdres.Text);
  if (Trim(edGpsEnlem.Text) = '') or (Trim(edGpsBoylam.Text) = '') then
  begin
    qExec.ParamByName('GPE').Clear;
    qExec.ParamByName('GPB').Clear;
  end
  else
  begin
    qExec.ParamByName('GPE').AsFloat := ParseDecimal(edGpsEnlem.Text);
    qExec.ParamByName('GPB').AsFloat := ParseDecimal(edGpsBoylam.Text);
  end;
  StrToParam(qExec, 'HADR', mmHaritaAdres.Text);
  StrToParam(qExec, 'TEL', edTel.Text);
  StrToParam(qExec, 'CEP', edCep.Text);
  StrToParam(qExec, 'TEL2', edTel2.Text);
  StrToParam(qExec, 'FAK', edFaks.Text);
  StrToParam(qExec, 'EP', edEposta.Text);
  StrToParam(qExec, 'WEB', edWeb.Text);
  StrToParam(qExec, 'YAD', edYetAd.Text);
  StrToParam(qExec, 'YUNV', edYetUnv.Text);
  StrToParam(qExec, 'YEP', edYetEposta.Text);
  StrToParam(qExec, 'YTEL', edYetTel.Text);
  StrToParam(qExec, 'MAD', edMuhAd.Text);
  StrToParam(qExec, 'MTEL', edMuhTel.Text);
  StrToParam(qExec, 'MEP', edMuhEposta.Text);
  StrToParam(qExec, 'SEK', edSektor.Text);
  StrToParam(qExec, 'FAAL', edFaal.Text);
  if Ci < 0 then
    qExec.ParamByName('CALS').Clear
  else
    qExec.ParamByName('CALS').AsInteger := Ci;
  if Ciro < 0 then
    qExec.ParamByName('CIRO').Clear
  else
    qExec.ParamByName('CIRO').AsFloat := Ciro;
  qExec.ParamByName('PB').AsString := cbPara.Text;
  StrToParam(qExec, 'KAY', edKaynak.Text);
  qExec.ParamByName('DID').AsLargeInt := lkDurum.KeyValue;
  DateToParam(qExec, 'DT1', chkIlkTar.Checked, dtIlk.DateTime);
  DateToParam(qExec, 'DT2', chkSonTakip.Checked, dtSonTakip.DateTime);
  DateToParam(qExec, 'DT3', chkSonraki.Checked, dtSonraki.DateTime);
  StrToParam(qExec, 'NOTL', mmNot.Text);

  if FPotansiyelId > 0 then
  begin
    qExec.Execute;
    NewId := FPotansiyelId;
  end
  else
  begin
    qExec.Open;
    if qExec.Fields[0].IsNull then
      NewId := 0
    else
      NewId := qExec.Fields[0].AsLargeInt;
    qExec.Close;
    FPotansiyelId := NewId;
  end;

  UniMainModule.saKaydet.Show('Kaydedildi.');
  if NewId > 0 then
  begin
    Hint := IntToStr(NewId);
    YukleKayit;
  end;
end;

procedure TfrmCrmPotansiyel.btnYeniAktiviteClick(Sender: TObject);
begin
  if FPotansiyelId <= 0 then
  begin
    UniMainModule.saHata.Show(#214'nce potansiyel m'#252#351'teriyi kaydedin.');
    Exit;
  end;
  Tmp.xCrmYeniAktivitePotId := FPotansiyelId;
  Tmp.xCrmYeniAktiviteTeklifId := 0;
  xFormShow(TfrmCrmAktivite, 'CrmYeniAktivite', 0, '0');
end;

procedure TfrmCrmPotansiyel.btnYeniGorevClick(Sender: TObject);
begin
  if FPotansiyelId <= 0 then
  begin
    UniMainModule.saHata.Show(#214'nce potansiyel m'#252#351'teriyi kaydedin.');
    Exit;
  end;
  Tmp.xCrmYeniGorevPotId := FPotansiyelId;
  Tmp.xCrmYeniGorevTeklifId := 0;
  xFormShow(TfrmCrmGorev, 'CrmYeniGorev', 0, '0');
end;

procedure TfrmCrmPotansiyel.btnKapatClick(Sender: TObject);
begin
  MainForm.NavPage.ActivePage.Close;
end;

end.
