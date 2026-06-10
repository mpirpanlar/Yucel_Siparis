unit CrmRotaU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  System.Contnrs,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniMemo, uniButton, uniComboBox, uniDateTimePicker,
  uniBasicGrid, uniDBGrid, Data.DB, MemDS, DBAccess, Uni, uniMultiItem,
  uniDBLookupComboBox, uniListBox, CrmRotaMesafeU, uniSweetAlert, CrmRotaDurakSecU, CrmRotaGorevU;

type
  TRotaDurakItem = class
  public
    DurakId: Int64;
    GorevId: Int64;
    Sira: Integer;
    DurakTip: Char;
    CariKod: string;
    PotId: Int64;
    Unvan: string;
    Il, Ilce, Adres: string;
    GpsE, GpsB: Double;
    Uyari: string;
    BacakKm: Double;
    BacakGpsEksik: Boolean;
    constructor Create;
  end;

  TfrmCrmRotaPlan = class(TUniForm)
    rootPanel: TUniPanel;
    panFooter: TUniPanel;
    btnKaydet: TUniButton;
    btnRotaHarita: TUniButton;
    btnKapat: TUniButton;
    panPersonel: TUniPanel;
    lblAtanan: TUniLabel;
    lkPersonel: TUniDBLookupComboBox;
    btnPersEkle: TUniButton;
    btnPersSil: TUniButton;
    lbPersonel: TUniListBox;
    lblToplamKm: TUniLabel;
    btnMesafeHesapla: TUniButton;
    cbGpsMod: TUniComboBox;
    qKullanici: TUniQuery;
    dsKullanici: TUniDataSource;
    panUst: TUniPanel;
    lblBaslik: TUniLabel;
    edBaslik: TUniEdit;
    lblDetay: TUniLabel;
    mmDetay: TUniMemo;
    lblPlanTar: TUniLabel;
    dtPlan: TUniDateTimePicker;
    lblDurum: TUniLabel;
    cbDurum: TUniComboBox;
    lblBasE: TUniLabel;
    edBasEnlem: TUniEdit;
    lblBasB: TUniLabel;
    edBasBoylam: TUniEdit;
    btnHarBas: TUniButton;
    lblBitE: TUniLabel;
    edBitEnlem: TUniEdit;
    lblBitB: TUniLabel;
    edBitBoylam: TUniEdit;
    btnHarBit: TUniButton;
    lblEsik: TUniLabel;
    edEsikKm: TUniEdit;
    lblEsikAcik: TUniLabel;
    panDurakBar: TUniPanel;
    btnEkleCari: TUniButton;
    btnEklePot: TUniButton;
    btnEkleBolge: TUniButton;
    btnDurakSil: TUniButton;
    btnDurakYukari: TUniButton;
    btnDurakAsagi: TUniButton;
    btnOtomatikSirala: TUniButton;
    btnGorevOlustur: TUniButton;
    btnUyariYenile: TUniButton;
    grdDurak: TUniDBGrid;
    qGrid: TUniQuery;
    dsGrid: TUniDataSource;
    qExec: TUniQuery;
    qLoad: TUniQuery;
    qNetsis: TUniQuery;
    qTmp: TUniQuery;
    saMukerrer: TUniSweetAlert;
    saOnayGorev: TUniSweetAlert;
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormDestroy(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure btnHarBasClick(Sender: TObject);
    procedure btnHarBitClick(Sender: TObject);
    procedure btnEkleCariClick(Sender: TObject);
    procedure btnEklePotClick(Sender: TObject);
    procedure btnEkleBolgeClick(Sender: TObject);
    procedure btnDurakSilClick(Sender: TObject);
    procedure btnDurakYukariClick(Sender: TObject);
    procedure btnDurakAsagiClick(Sender: TObject);
    procedure btnOtomatikSiralaClick(Sender: TObject);
    procedure btnGorevOlusturClick(Sender: TObject);
    procedure btnUyariYenileClick(Sender: TObject);
    procedure btnRotaHaritaClick(Sender: TObject);
    procedure btnMesafeHesaplaClick(Sender: TObject);
    procedure btnPersEkleClick(Sender: TObject);
    procedure btnPersSilClick(Sender: TObject);
    procedure saMukerrerConfirm(Sender: TObject);
    procedure saMukerrerDismiss(Sender: TObject; const Reason: TDismissType);
    procedure saOnayGorevConfirm(Sender: TObject);
  private
    FPersonelIds: TStringList;
    FDuraklar: TObjectList;
    FRotaId: Int64;
    FKayitDurum: string;
    FGorevAyar: TRotaGorevAyar;
    FPendSecim: TObjectList;
    FMukerrerMod: Integer;
    FPendCariKod: string;
    FPendPotId: Int64;
    function ParseDec(const S: string): Double;
    function SqlNv(const S: string): string;
    function EsikKm: Integer;
    function BasLat: Double;
    function BasLng: Double;
    function BitLat: Double;
    function BitLng: Double;
    procedure YeniKayit;
    procedure YukleKayit;
    procedure DuraklariVeritabanindanYukle;
    procedure DurakSatiriniListeyeEkle;
    function DurakTipSql(const AIt: TRotaDurakItem): string;
    procedure GridYenile;
    procedure HesaplaTumUyari;
    function SonSira: Integer;
    procedure CariSecildi(Sender: TObject; const ACariKod: string);
    procedure PotSecildi(Sender: TObject; APotId: Int64);
    procedure AddDurakCari(const ACariKod: string);
    procedure AddDurakPot(APotId: Int64);
    function DurakMukerrerCari(const ACariKod: string): Boolean;
    function DurakMukerrerPot(APotId: Int64): Boolean;
    procedure InternalAddDurakCari(const ACariKod: string);
    procedure InternalAddDurakPot(APotId: Int64);
    procedure AddDurakFromKayit(AKayit: TRotaSecimKayit);
    procedure EkleSecimListesi(AListe: TObjectList; AMukerrerleriDahilEt: Boolean);
    procedure RotaDurakSecildi(Sender: TObject; AListe: TObjectList);
    procedure PersistDuraklar;
    procedure SyncGorevDurakRefs;
    procedure ReloadDurakIdsFromDb;
    procedure EnsureDuraklarList;
    procedure ParametreBaslangicGpsOku(out ALa, ALn: Double);
    procedure SiralariYenidenNumarala;
    function SeciliDurakIndeks: Integer;
    procedure DurakYukari;
    procedure DurakAsagi;
    procedure OtomatikSiralaMesafe;
    function GorevTipId: Int64;
    function GorevDurumIdAcik: Int64;
    procedure GorevSilById(AGorevId: Int64);
    procedure RotaGorevleriniIptal;
    function GorevOlusturVeyaGuncelle(AIt: TRotaDurakItem): Int64;
    function PersonelIdDizisi: TArray<Integer>;
    function TumDuraklarIcinGorevOlustur(AShowMesaj: Boolean): Integer;
    procedure OnaySonrasiGorevKontrol(const YeniDurum, OncekiDurum: string);
    function HaritaNoktaListesiJson: string;
    procedure RotayiHaritaGoster;
    procedure KullanicilariAc;
    procedure PersonelListYukle;
    procedure PersonelKaydet;
    procedure MesafeHesaplaGoster;
    function GpsEksikModSecim: TCrmGpsEksikMod;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

function frmCrmRotaPlan: TfrmCrmRotaPlan;

implementation

{$R *.dfm}

uses
  System.Math, System.IOUtils, System.DateUtils, StrUtils,
  ServerModule,
  uniGUIApplication, MainModule, DMU, TmpU, Main, Genel,
  CrmCariSecU, CrmPotansiyelListeU, CrmHaritaSecU, CrmRotaHaritaU, CrmRotaGeoU, CrmMapsConfigU;

constructor TRotaDurakItem.Create;
begin
  inherited Create;
  DurakId := 0;
  GorevId := 0;
  DurakTip := 'C';
  PotId := 0;
  BacakKm := 0;
  BacakGpsEksik := False;
end;

constructor TfrmCrmRotaPlan.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDuraklar := TObjectList.Create(True);
  FPersonelIds := TStringList.Create;
  FPersonelIds.Sorted := True;
  FPersonelIds.Duplicates := dupIgnore;
  FMukerrerMod := -1;
end;

destructor TfrmCrmRotaPlan.Destroy;
begin
  FreeAndNil(FPersonelIds);
  FreeAndNil(FDuraklar);
  inherited Destroy;
end;

procedure TfrmCrmRotaPlan.EnsureDuraklarList;
begin
  if FDuraklar = nil then
    FDuraklar := TObjectList.Create(True);
end;

function frmCrmRotaPlan: TfrmCrmRotaPlan;
begin
  Result := TfrmCrmRotaPlan(UniMainModule.GetFormInstance(TfrmCrmRotaPlan));
end;

function TfrmCrmRotaPlan.ParseDec(const S: string): Double;
var
  T: string;
  FS: TFormatSettings;
begin
  T := Trim(StringReplace(S, ',', '.', [rfReplaceAll]));
  FS := TFormatSettings.Invariant;
  FS.DecimalSeparator := '.';
  Result := StrToFloatDef(T, 0, FS);
end;

function TfrmCrmRotaPlan.SqlNv(const S: string): string;
begin
  Result := Trim(S);
  Result := StringReplace(Result, '''', '''''', [rfReplaceAll]);
  Result := StringReplace(Result, #13#10, ' ', [rfReplaceAll]);
  Result := StringReplace(Result, #10, ' ', [rfReplaceAll]);
  Result := StringReplace(Result, #13, ' ', [rfReplaceAll]);
end;

function TfrmCrmRotaPlan.DurakTipSql(const AIt: TRotaDurakItem): string;
var
  C: Char;
begin
  C := AIt.DurakTip;
  if not CharInSet(C, ['C', 'P']) then
    C := 'C';
  Result := C;
end;

procedure TfrmCrmRotaPlan.DurakSatiriniListeyeEkle;

  function QF(const AName: string): TField;
  begin
    Result := nil;
    if (qTmp <> nil) and qTmp.Active then
      Result := qTmp.FindField(AName);
  end;

  function QLargeInt(const AName: string; const ADefault: Int64 = 0): Int64;
  var
    F: TField;
  begin
    Result := ADefault;
    F := QF(AName);
    if (F = nil) or F.IsNull then
      Exit;
    try
      Result := F.AsLargeInt;
    except
      Result := F.AsInteger;
    end;
  end;

  function QInt(const AName: string; const ADefault: Integer = 0): Integer;
  var
    F: TField;
  begin
    Result := ADefault;
    F := QF(AName);
    if (F = nil) or F.IsNull then
      Exit;
    Result := F.AsInteger;
  end;

  function QBool(const AName: string; const ADefault: Boolean = False): Boolean;
  var
    F: TField;
  begin
    Result := ADefault;
    F := QF(AName);
    if (F = nil) or F.IsNull then
      Exit;
    try
      Result := F.AsBoolean;
    except
      Result := F.AsInteger <> 0;
    end;
  end;

  function QStr(const AName: string): string;
  var
    F: TField;
  begin
    Result := '';
    F := QF(AName);
    if (F = nil) or F.IsNull then
      Exit;
    Result := F.AsString;
  end;

  function QFloat(const AName: string; const ADefault: Double = 0): Double;
  var
    F: TField;
  begin
    Result := ADefault;
    F := QF(AName);
    if (F = nil) or F.IsNull then
      Exit;
    Result := F.AsFloat;
  end;

var
  It: TRotaDurakItem;
  TipStr: string;
  FDurak: TField;
begin
  if (qTmp = nil) or (not qTmp.Active) then
    raise Exception.Create('Durak sorgusu a'#231#305'k de'#287'il; sat'#305'r okunamad'#305'.');

  FDurak := QF('DURAK_ID');
  if FDurak = nil then
    raise Exception.Create('DURAK_ID alan'#305' bulunamad'#305' (durak sorgu kolonlar'#305' kontrol edin).');

  It := TRotaDurakItem.Create;
  try
    try
      It.DurakId := QLargeInt('DURAK_ID', 0);
      It.GorevId := QLargeInt('GOREV_ID', 0);
      It.Sira := QInt('SIRA', FDuraklar.Count + 1);
      TipStr := Trim(QStr('DURAK_TIP'));
      if TipStr <> '' then
        It.DurakTip := TipStr[1]
      else
        It.DurakTip := 'C';
      if not CharInSet(It.DurakTip, ['C', 'P']) then
        It.DurakTip := 'C';
      It.CariKod := Trim(QStr('NETSIS_CARI_KOD'));
      It.PotId := QLargeInt('POTANSIYEL_ID', 0);
      It.Unvan := QStr('UNVAN_SNAPSHOT');
      It.Il := QStr('IL_SNAPSHOT');
      It.Ilce := QStr('ILCE_SNAPSHOT');
      It.Adres := QStr('ADRES_SNAPSHOT');
      if QF('GPSX') <> nil then
        It.GpsE := QFloat('GPSX', 0)
      else
        It.GpsE := QFloat('GPS_ENLEM', 0);
      if QF('GPSY') <> nil then
        It.GpsB := QFloat('GPSY', 0)
      else
        It.GpsB := QFloat('GPS_BOYLAM', 0);
      It.Uyari := QStr('UYARI_METNI');
      if QF('BACAK_KM') <> nil then
        It.BacakKm := QFloat('BACAK_KM', 0);
      if QF('GPS_EKSIK') <> nil then
        It.BacakGpsEksik := QBool('GPS_EKSIK', False);
      FDuraklar.Add(It);
    except
      on E: Exception do
        raise Exception.CreateFmt('Durak sat'#305'r'#305' okunamad'#305' (s'#305'ra=%d): %s',
          [It.Sira, E.Message]);
    end;
  except
    It.Free;
    raise;
  end;
end;

procedure TfrmCrmRotaPlan.DuraklariVeritabanindanYukle;
const
  SQL_DURAK_BASE =
    'SELECT DURAK_ID, SIRA, DURAK_TIP, NETSIS_CARI_KOD, POTANSIYEL_ID, UNVAN_SNAPSHOT, ' +
    'IL_SNAPSHOT, ILCE_SNAPSHOT, ADRES_SNAPSHOT, GPS_ENLEM, GPS_BOYLAM, UYARI_METNI ' +
    'FROM dbo.CRM_ROTA_PLAN_DURAK WHERE ROTA_ID = :R ORDER BY SIRA, DURAK_ID';
  SQL_DURAK_FULL =
    'SELECT DURAK_ID, SIRA, DURAK_TIP, NETSIS_CARI_KOD, POTANSIYEL_ID, UNVAN_SNAPSHOT, ' +
    'IL_SNAPSHOT, ILCE_SNAPSHOT, ADRES_SNAPSHOT, GPS_ENLEM, GPS_BOYLAM, GPSX, GPSY, UYARI_METNI, GOREV_ID, ' +
    'BACAK_KM, GPS_EKSIK FROM dbo.CRM_ROTA_PLAN_DURAK WHERE ROTA_ID = :R ORDER BY SIRA, DURAK_ID';
begin
  EnsureDuraklarList;
  FDuraklar.Clear;
  qTmp.Close;
  try
    try
      qTmp.SQL.Text := SQL_DURAK_FULL;
      qTmp.ParamByName('R').AsLargeInt := FRotaId;
      qTmp.Open;
    except
      qTmp.Close;
      qTmp.SQL.Text := SQL_DURAK_BASE;
      qTmp.ParamByName('R').AsLargeInt := FRotaId;
      qTmp.Open;
    end;
    while not qTmp.Eof do
    begin
      DurakSatiriniListeyeEkle;
      qTmp.Next;
    end;
  finally
    qTmp.Close;
  end;
end;

function TfrmCrmRotaPlan.EsikKm: Integer;
begin
  Result := StrToIntDef(Trim(edEsikKm.Text), 80);
  if Result < 1 then
    Result := 80;
end;

function TfrmCrmRotaPlan.BasLat: Double;
begin
  Result := ParseDec(edBasEnlem.Text);
end;

function TfrmCrmRotaPlan.BasLng: Double;
begin
  Result := ParseDec(edBasBoylam.Text);
end;

function TfrmCrmRotaPlan.BitLat: Double;
begin
  Result := ParseDec(edBitEnlem.Text);
end;

function TfrmCrmRotaPlan.BitLng: Double;
begin
  Result := ParseDec(edBitBoylam.Text);
end;

procedure TfrmCrmRotaPlan.UniFormCreate(Sender: TObject);
begin
  EnsureDuraklarList;
end;

procedure TfrmCrmRotaPlan.UniFormDestroy(Sender: TObject);
begin
  { FDuraklar destructor'da serbest birakilir. }
end;

procedure TfrmCrmRotaPlan.ParametreBaslangicGpsOku(out ALa, ALn: Double);
begin
  ALa := 0;
  ALn := 0;
  qTmp.Close;
  qTmp.SQL.Text :=
    'SELECT GPSX, GPSY FROM dbo.PARAMETRE WITH(NOLOCK) WHERE SUBE_KODU = :SUBE';
  qTmp.ParamByName('SUBE').AsInteger := Tmp.xSubeKodu;
  qTmp.Open;
  if not qTmp.IsEmpty then
  begin
    if (qTmp.FindField('GPSX') <> nil) and not qTmp.FieldByName('GPSX').IsNull then
      ALa := qTmp.FieldByName('GPSX').AsFloat;
    if (qTmp.FindField('GPSY') <> nil) and not qTmp.FieldByName('GPSY').IsNull then
      ALn := qTmp.FieldByName('GPSY').AsFloat;
  end;
  qTmp.Close;
end;

procedure TfrmCrmRotaPlan.YeniKayit;
var
  La, Ln: Double;
begin
  EnsureDuraklarList;
  FRotaId := 0;
  Caption := 'Yeni rota plan'#305;
  edBaslik.Text := '';
  mmDetay.Clear;
  dtPlan.DateTime := Date;
  cbDurum.ItemIndex := 0;
  ParametreBaslangicGpsOku(La, Ln);
  if Abs(La) > 1E-9 then
    edBasEnlem.Text := FormatFloat('0.######', La, TFormatSettings.Invariant)
  else
    edBasEnlem.Text := '';
  if Abs(Ln) > 1E-9 then
    edBasBoylam.Text := FormatFloat('0.######', Ln, TFormatSettings.Invariant)
  else
    edBasBoylam.Text := '';
  edBitEnlem.Text := '';
  edBitBoylam.Text := '';
  edEsikKm.Text := '80';
  FPersonelIds.Clear;
  lbPersonel.Items.Clear;
  lblToplamKm.Caption := 'Toplam yol: - km';
  FDuraklar.Clear;
  FKayitDurum := '';
  GridYenile;
end;

procedure TfrmCrmRotaPlan.YukleKayit;
begin
  EnsureDuraklarList;
  try
  qLoad.Close;
  qLoad.SQL.Text := 'SELECT * FROM dbo.CRM_ROTA_PLAN WHERE ROTA_ID = :ID';
  qLoad.ParamByName('ID').AsLargeInt := FRotaId;
  qLoad.Open;
  if qLoad.IsEmpty then
  begin
    qLoad.Close;
    UniMainModule.saHata.Show('Kay'#305't yok.');
    YeniKayit;
    Exit;
  end;
  edBaslik.Text := qLoad.FieldByName('BASLIK').AsString;
  if qLoad.FieldByName('DETAY').IsNull then
    mmDetay.Clear
  else
    mmDetay.Text := qLoad.FieldByName('DETAY').AsString;
  if qLoad.FieldByName('PLANLAMA_TARIHI').IsNull then
    dtPlan.DateTime := Date
  else
    dtPlan.DateTime := qLoad.FieldByName('PLANLAMA_TARIHI').AsDateTime;
  case IndexStr(UpperCase(Trim(qLoad.FieldByName('DURUM').AsString)), ['TASLAK', 'ONAYLI', 'IPTAL']) of
    0: cbDurum.ItemIndex := 0;
    1: cbDurum.ItemIndex := 1;
    2: cbDurum.ItemIndex := 2;
  else
    cbDurum.ItemIndex := 0;
  end;
  FKayitDurum := cbDurum.Items[cbDurum.ItemIndex];
  if (qLoad.FindField('GPSX') <> nil) and not qLoad.FieldByName('GPSX').IsNull then
    edBasEnlem.Text := FormatFloat('0.######', qLoad.FieldByName('GPSX').AsFloat, TFormatSettings.Invariant)
  else if qLoad.FieldByName('BASLANGIC_ENLEM').IsNull then
    edBasEnlem.Text := ''
  else
    edBasEnlem.Text := FormatFloat('0.######', qLoad.FieldByName('BASLANGIC_ENLEM').AsFloat, TFormatSettings.Invariant);
  if (qLoad.FindField('GPSY') <> nil) and not qLoad.FieldByName('GPSY').IsNull then
    edBasBoylam.Text := FormatFloat('0.######', qLoad.FieldByName('GPSY').AsFloat, TFormatSettings.Invariant)
  else if qLoad.FieldByName('BASLANGIC_BOYLAM').IsNull then
    edBasBoylam.Text := ''
  else
    edBasBoylam.Text := FormatFloat('0.######', qLoad.FieldByName('BASLANGIC_BOYLAM').AsFloat, TFormatSettings.Invariant);
  if qLoad.FieldByName('BITIS_ENLEM').IsNull then
    edBitEnlem.Text := ''
  else
    edBitEnlem.Text := FormatFloat('0.######', qLoad.FieldByName('BITIS_ENLEM').AsFloat, TFormatSettings.Invariant);
  if qLoad.FieldByName('BITIS_BOYLAM').IsNull then
    edBitBoylam.Text := ''
  else
    edBitBoylam.Text := FormatFloat('0.######', qLoad.FieldByName('BITIS_BOYLAM').AsFloat, TFormatSettings.Invariant);
  edEsikKm.Text := IntToStr(qLoad.FieldByName('ESIK_KM').AsInteger);
  if (qLoad.FindField('GPS_EKSIK_MOD') <> nil) and not qLoad.FieldByName('GPS_EKSIK_MOD').IsNull then
    cbGpsMod.ItemIndex := qLoad.FieldByName('GPS_EKSIK_MOD').AsInteger
  else
    cbGpsMod.ItemIndex := 0;
  if (qLoad.FindField('TOPLAM_YOL_KM') <> nil) and not qLoad.FieldByName('TOPLAM_YOL_KM').IsNull then
    lblToplamKm.Caption := Format('Toplam yol: %.1f km', [qLoad.FieldByName('TOPLAM_YOL_KM').AsFloat])
  else
    lblToplamKm.Caption := 'Toplam yol: - km';
  qLoad.Close;
  PersonelListYukle;

  DuraklariVeritabanindanYukle;
  Caption := 'Rota plan'#305;
  GridYenile;
  except
    on E: Exception do
    begin
      qLoad.Close;
      qTmp.Close;
      qGrid.Close;
      UniMainModule.saHata.Show('Rota y'#252'klenemedi.'#13#10 + E.Message);
      YeniKayit;
    end;
  end;
end;

function TfrmCrmRotaPlan.SonSira: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to FDuraklar.Count - 1 do
    if TRotaDurakItem(FDuraklar[I]).Sira > Result then
      Result := TRotaDurakItem(FDuraklar[I]).Sira;
end;

procedure TfrmCrmRotaPlan.GridYenile;
var
  Sql: string;
  I: Integer;
  It: TRotaDurakItem;
  FS: TFormatSettings;

  function Fnv(const D: Double): string;
  begin
    if Abs(D) < 1E-9 then
      Result := '0'
    else
      Result := FormatFloat('0.######', D, FS);
  end;

begin
  FS := TFormatSettings.Invariant;
  qGrid.Close;
  if FDuraklar.Count = 0 then
  begin
    qGrid.SQL.Text := 'SELECT CAST(NULL AS INT) AS SIRA WHERE 0 = 1';
    qGrid.Open;
    Exit;
  end;
  Sql := 'SELECT * FROM (VALUES ';
  for I := 0 to FDuraklar.Count - 1 do
  begin
    It := TRotaDurakItem(FDuraklar[I]);
    if I > 0 then
      Sql := Sql + ',';
    Sql := Sql + '(' + IntToStr(It.Sira) + ', N''' + DurakTipSql(It) + ''', ';
    if It.DurakTip = 'C' then
      Sql := Sql + 'N''' + SqlNv(It.CariKod) + ''', CAST(NULL AS BIGINT), '
    else
      Sql := Sql + 'CAST(NULL AS NVARCHAR(50)), ' + IntToStr(It.PotId) + ', ';
    Sql := Sql + 'N''' + SqlNv(It.Unvan) + ''', N''' + SqlNv(It.Il) + ''', N''' + SqlNv(It.Ilce) +
      ''', N''' + SqlNv(It.Adres) + ''', CAST(' + Fnv(It.GpsE) + ' AS DECIMAL(18,6)), CAST(' +
      Fnv(It.GpsB) + ' AS DECIMAL(18,6)), N''' + SqlNv(It.Uyari) + ''', ' +
      IntToStr(It.GorevId) + ', CAST(' + Fnv(It.BacakKm) + ' AS DECIMAL(10,2)), ' +
      IntToStr(Ord(It.BacakGpsEksik)) + ')';
  end;
  Sql := Sql + ') AS T(SIRA, TIP, CARI_KOD, POTID, UNVAN, IL, ILCE, ADRES, ENLEM, BOYLAM, UYARI, GOREV_ID, BACAK_KM, GPS_EKSIK) ORDER BY SIRA';
  qGrid.SQL.Text := Sql;
  try
    qGrid.Open;
  except
    on E: Exception do
    begin
      qGrid.Close;
      qGrid.SQL.Text := 'SELECT CAST(NULL AS INT) AS SIRA WHERE 0 = 1';
      qGrid.Open;
      UniMainModule.saHata.Show('Durak listesi g'#246'sterilemedi.'#13#10 + E.Message);
    end;
  end;
end;

procedure TfrmCrmRotaPlan.HesaplaTumUyari;
var
  I: Integer;
  It: TRotaDurakItem;
  ALa, ALn, BLa, BLn: Double;
begin
  ALa := BasLat;
  ALn := BasLng;
  BLa := BitLat;
  BLn := BitLng;
  for I := 0 to FDuraklar.Count - 1 do
  begin
    It := TRotaDurakItem(FDuraklar[I]);
    It.Uyari := CrmRotaKoridorUyari(EsikKm, It.GpsE, It.GpsB, ALa, ALn, BLa, BLn);
  end;
end;

procedure TfrmCrmRotaPlan.CariSecildi(Sender: TObject; const ACariKod: string);
begin
  frmCrmCariSec.OnCariSecildi := nil;
  AddDurakCari(ACariKod);
end;

procedure TfrmCrmRotaPlan.PotSecildi(Sender: TObject; APotId: Int64);
var
  Ck: string;
begin
  if APotId <= 0 then
    Exit;
  qTmp.Close;
  qTmp.SQL.Text :=
    'SELECT LTRIM(RTRIM(ISNULL(NETSIS_CARI_KOD, N''''))) AS K FROM dbo.CRM_POTANSIYEL_MUSTERI WHERE POTANSIYEL_ID = :ID';
  qTmp.ParamByName('ID').AsLargeInt := APotId;
  qTmp.Open;
  Ck := '';
  if not qTmp.IsEmpty then
    Ck := Trim(qTmp.FieldByName('K').AsString);
  qTmp.Close;
  if Ck <> '' then
    AddDurakCari(Ck)
  else
    AddDurakPot(APotId);
end;

procedure TfrmCrmRotaPlan.AddDurakCari(const ACariKod: string);
var
  Ck: string;
begin
  Ck := Trim(ACariKod);
  if Ck = '' then
    Exit;
  if DurakMukerrerCari(Ck) then
  begin
    FMukerrerMod := 1;
    FPendCariKod := Ck;
    saMukerrer.Title := 'M'#252'kerrer durak';
    saMukerrer.Text := 'Bu cari zaten rotada: ' + Ck + #13#10 +
      'Yine de eklemek ister misiniz? (Hay'#305'r = atla)';
    saMukerrer.Show;
    Exit;
  end;
  InternalAddDurakCari(Ck);
end;

procedure TfrmCrmRotaPlan.InternalAddDurakCari(const ACariKod: string);
var
  Ck: string;
  It: TRotaDurakItem;
  Ge, Gb: Double;
  CIsim, CI, CC, CAD: string;

  procedure NetsisGpsOku(out AEnlem, ABoylam: Double);
  begin
    AEnlem := 0;
    ABoylam := 0;
    if (qNetsis.FindField('KULL1N') <> nil) and not qNetsis.FieldByName('KULL1N').IsNull then
      AEnlem := qNetsis.FieldByName('KULL1N').AsFloat;
    if (qNetsis.FindField('KULL2N') <> nil) and not qNetsis.FieldByName('KULL2N').IsNull then
      ABoylam := qNetsis.FieldByName('KULL2N').AsFloat;
  end;

begin
  Ck := Trim(ACariKod);
  if Ck = '' then
    Exit;
  qNetsis.Close;
  qNetsis.SQL.Text :=
    'SELECT TOP 1 C.CARI_KOD, C.CARI_ISIM, ISNULL(C.CARI_IL, N'''') AS CI, ISNULL(C.CARI_ILCE, N'''') AS CC, ' +
    'ISNULL(C.CARI_ADRES, N'''') AS CAD, T.KULL1N, T.KULL2N ' +
    'FROM YUCEL..HV_CARI_LISTESI C WITH(NOLOCK) ' +
    'LEFT JOIN TBLCASABITEK T WITH(NOLOCK) ON T.CARI_KOD = C.CARI_KOD ' +
    'WHERE C.CARI_KOD = :K';
  qNetsis.ParamByName('K').AsString := Ck;
  qNetsis.Open;
  if qNetsis.IsEmpty then
  begin
    qNetsis.Close;
    UniMainModule.saHata.Show('Cari HV listesinde bulunamad'#305': ' + Ck);
    Exit;
  end;
  CIsim := qNetsis.FieldByName('CARI_ISIM').AsString;
  CI := qNetsis.FieldByName('CI').AsString;
  CC := qNetsis.FieldByName('CC').AsString;
  CAD := qNetsis.FieldByName('CAD').AsString;
  NetsisGpsOku(Ge, Gb);
  qNetsis.Close;

  { Netsis TBLCASABITEK bos ise eski CRM_CARI_LOKASYON kaydina dus. }
  if (Abs(Ge) < 1E-9) and (Abs(Gb) < 1E-9) then
  begin
    qTmp.Close;
    qTmp.SQL.Text :=
      'SELECT GPS_ENLEM, GPS_BOYLAM FROM dbo.CRM_CARI_LOKASYON WHERE CARI_KOD = :K';
    qTmp.ParamByName('K').AsString := Ck;
    qTmp.Open;
    if not qTmp.IsEmpty then
    begin
      if not qTmp.FieldByName('GPS_ENLEM').IsNull then
        Ge := qTmp.FieldByName('GPS_ENLEM').AsFloat;
      if not qTmp.FieldByName('GPS_BOYLAM').IsNull then
        Gb := qTmp.FieldByName('GPS_BOYLAM').AsFloat;
    end;
    qTmp.Close;
  end;

  It := TRotaDurakItem.Create;
  It.Sira := SonSira + 1;
  It.DurakTip := 'C';
  It.CariKod := Ck;
  It.Unvan := CIsim;
  It.Il := CI;
  It.Ilce := CC;
  It.Adres := CAD;
  It.GpsE := Ge;
  It.GpsB := Gb;
  FDuraklar.Add(It);
  HesaplaTumUyari;
  GridYenile;
end;

procedure TfrmCrmRotaPlan.AddDurakPot(APotId: Int64);
begin
  if APotId <= 0 then
    Exit;
  if DurakMukerrerPot(APotId) then
  begin
    FMukerrerMod := 2;
    FPendPotId := APotId;
    saMukerrer.Title := 'M'#252'kerrer durak';
    saMukerrer.Text := 'Bu potansiyel zaten rotada (ID: ' + IntToStr(APotId) + ').'#13#10 +
      'Yine de eklemek ister misiniz? (Hay'#305'r = atla)';
    saMukerrer.Show;
    Exit;
  end;
  InternalAddDurakPot(APotId);
end;

procedure TfrmCrmRotaPlan.InternalAddDurakPot(APotId: Int64);
var
  It: TRotaDurakItem;
begin
  if APotId <= 0 then
    Exit;
  qTmp.Close;
  qTmp.SQL.Text :=
    'SELECT FIRMA_UNVAN, IL, ILCE, ADRES, GPS_ENLEM, GPS_BOYLAM FROM dbo.CRM_POTANSIYEL_MUSTERI ' +
    'WHERE POTANSIYEL_ID = :ID';
  qTmp.ParamByName('ID').AsLargeInt := APotId;
  qTmp.Open;
  if qTmp.IsEmpty then
  begin
    qTmp.Close;
    UniMainModule.saHata.Show('Potansiyel bulunamad'#305'.');
    Exit;
  end;
  It := TRotaDurakItem.Create;
  It.Sira := SonSira + 1;
  It.DurakTip := 'P';
  It.PotId := APotId;
  It.Unvan := qTmp.FieldByName('FIRMA_UNVAN').AsString;
  It.Il := qTmp.FieldByName('IL').AsString;
  It.Ilce := qTmp.FieldByName('ILCE').AsString;
  It.Adres := qTmp.FieldByName('ADRES').AsString;
  if qTmp.FieldByName('GPS_ENLEM').IsNull then
    It.GpsE := 0
  else
    It.GpsE := qTmp.FieldByName('GPS_ENLEM').AsFloat;
  if qTmp.FieldByName('GPS_BOYLAM').IsNull then
    It.GpsB := 0
  else
    It.GpsB := qTmp.FieldByName('GPS_BOYLAM').AsFloat;
  qTmp.Close;
  FDuraklar.Add(It);
  HesaplaTumUyari;
  GridYenile;
end;

function TfrmCrmRotaPlan.DurakMukerrerCari(const ACariKod: string): Boolean;
var
  I: Integer;
  Ck: string;
begin
  Ck := Trim(ACariKod);
  Result := False;
  if Ck = '' then
    Exit;
  for I := 0 to FDuraklar.Count - 1 do
    if (TRotaDurakItem(FDuraklar[I]).DurakTip = 'C') and
      SameText(TRotaDurakItem(FDuraklar[I]).CariKod, Ck) then
      Exit(True);
end;

function TfrmCrmRotaPlan.DurakMukerrerPot(APotId: Int64): Boolean;
var
  I: Integer;
begin
  Result := False;
  if APotId <= 0 then
    Exit;
  for I := 0 to FDuraklar.Count - 1 do
    if (TRotaDurakItem(FDuraklar[I]).DurakTip = 'P') and
      (TRotaDurakItem(FDuraklar[I]).PotId = APotId) then
      Exit(True);
end;

procedure TfrmCrmRotaPlan.AddDurakFromKayit(AKayit: TRotaSecimKayit);
var
  It: TRotaDurakItem;
begin
  if AKayit = nil then
    Exit;
  It := TRotaDurakItem.Create;
  It.Sira := SonSira + 1;
  It.DurakTip := AKayit.Tip;
  It.CariKod := AKayit.CariKod;
  It.PotId := AKayit.PotId;
  It.Unvan := AKayit.Unvan;
  It.Il := AKayit.Il;
  It.Ilce := AKayit.Ilce;
  It.Adres := AKayit.Adres;
  It.GpsE := AKayit.GpsE;
  It.GpsB := AKayit.GpsB;
  FDuraklar.Add(It);
end;

procedure TfrmCrmRotaPlan.EkleSecimListesi(AListe: TObjectList; AMukerrerleriDahilEt: Boolean);
var
  I, N: Integer;
  Kay: TRotaSecimKayit;
begin
  if AListe = nil then
    Exit;
  N := 0;
  for I := 0 to AListe.Count - 1 do
  begin
    Kay := TRotaSecimKayit(AListe[I]);
    if Kay.Tip = 'C' then
    begin
      if (not AMukerrerleriDahilEt) and DurakMukerrerCari(Kay.CariKod) then
        Continue;
      AddDurakFromKayit(Kay);
      Inc(N);
    end
    else if Kay.Tip = 'P' then
    begin
      if (not AMukerrerleriDahilEt) and DurakMukerrerPot(Kay.PotId) then
        Continue;
      AddDurakFromKayit(Kay);
      Inc(N);
    end;
  end;
  if N > 0 then
  begin
    HesaplaTumUyari;
    GridYenile;
    UniMainModule.saKaydet.Show(Format('%d durak eklendi.', [N]));
  end
  else
    UniMainModule.saHata.Show('Eklenecek yeni durak kalmad'#305'.');
end;

procedure TfrmCrmRotaPlan.RotaDurakSecildi(Sender: TObject; AListe: TObjectList);
var
  I, Muk: Integer;
  Kay: TRotaSecimKayit;
begin
  if (AListe = nil) or (AListe.Count = 0) then
    Exit;
  Muk := 0;
  for I := 0 to AListe.Count - 1 do
  begin
    Kay := TRotaSecimKayit(AListe[I]);
    if (Kay.Tip = 'C') and DurakMukerrerCari(Kay.CariKod) then
      Inc(Muk)
    else if (Kay.Tip = 'P') and DurakMukerrerPot(Kay.PotId) then
      Inc(Muk);
  end;
  if Muk > 0 then
  begin
    FMukerrerMod := 0;
    FPendSecim := AListe;
    saMukerrer.Title := 'M'#252'kerrer duraklar';
    saMukerrer.Text := Format('%d se'#231'im zaten rotada.'#13#10 +
      'Evet = yine de ekle, Hay'#305'r = yaln'#305'z yeni olanlar', [Muk]);
    saMukerrer.Show;
    Exit;
  end;
  EkleSecimListesi(AListe, True);
end;

procedure TfrmCrmRotaPlan.saMukerrerConfirm(Sender: TObject);
begin
  case FMukerrerMod of
    1: InternalAddDurakCari(FPendCariKod);
    2: InternalAddDurakPot(FPendPotId);
    0: EkleSecimListesi(FPendSecim, True);
  end;
  FMukerrerMod := -1;
  FPendSecim := nil;
end;

procedure TfrmCrmRotaPlan.saMukerrerDismiss(Sender: TObject; const Reason: TDismissType);
begin
  if FMukerrerMod = 0 then
    EkleSecimListesi(FPendSecim, False);
  FMukerrerMod := -1;
  FPendSecim := nil;
end;

procedure TfrmCrmRotaPlan.btnEkleBolgeClick(Sender: TObject);
begin
  frmCrmRotaDurakSec.BaslangicLat := BasLat;
  frmCrmRotaDurakSec.BaslangicLng := BasLng;
  frmCrmRotaDurakSec.OnSecimTamam := RotaDurakSecildi;
  frmCrmRotaDurakSec.ShowModal;
  frmCrmRotaDurakSec.OnSecimTamam := nil;
end;

procedure TfrmCrmRotaPlan.PersistDuraklar;
var
  I: Integer;
  It: TRotaDurakItem;
  IdList: string;
  NewId: Int64;

  procedure BindDurakParams;
  begin
    It := TRotaDurakItem(FDuraklar[I]);
    qExec.ParamByName('R').AsLargeInt := FRotaId;
    qExec.ParamByName('S').AsInteger := It.Sira;
    qExec.ParamByName('T').AsString := It.DurakTip;
    if It.DurakTip = 'C' then
    begin
      qExec.ParamByName('CK').AsString := It.CariKod;
      qExec.ParamByName('PID').Clear;
    end
    else
    begin
      qExec.ParamByName('CK').Clear;
      qExec.ParamByName('PID').AsLargeInt := It.PotId;
    end;
    qExec.ParamByName('U').AsString := It.Unvan;
    qExec.ParamByName('IL').AsString := It.Il;
    qExec.ParamByName('ILC').AsString := It.Ilce;
    qExec.ParamByName('AD').AsString := It.Adres;
    if Abs(It.GpsE) < 1E-9 then
    begin
      qExec.ParamByName('GE').Clear;
      qExec.ParamByName('GX').Clear;
    end
    else
    begin
      qExec.ParamByName('GE').AsFloat := It.GpsE;
      qExec.ParamByName('GX').AsFloat := It.GpsE;
    end;
    if Abs(It.GpsB) < 1E-9 then
    begin
      qExec.ParamByName('GB').Clear;
      qExec.ParamByName('GY').Clear;
    end
    else
    begin
      qExec.ParamByName('GB').AsFloat := It.GpsB;
      qExec.ParamByName('GY').AsFloat := It.GpsB;
    end;
    qExec.ParamByName('UY').AsString := It.Uyari;
    if It.GorevId > 0 then
      qExec.ParamByName('GID').AsLargeInt := It.GorevId
    else
      qExec.ParamByName('GID').Clear;
    if It.BacakKm > 0 then
      qExec.ParamByName('BK').AsFloat := It.BacakKm
    else
      qExec.ParamByName('BK').Clear;
    if It.BacakGpsEksik then
      qExec.ParamByName('GEK').AsInteger := 1
    else
      qExec.ParamByName('GEK').AsInteger := 0;
  end;

begin
  IdList := '';
  for I := 0 to FDuraklar.Count - 1 do
    if TRotaDurakItem(FDuraklar[I]).DurakId > 0 then
      IdList := IdList + IntToStr(TRotaDurakItem(FDuraklar[I]).DurakId) + ',';

  qExec.Close;
  if IdList <> '' then
  begin
    IdList := Copy(IdList, 1, Length(IdList) - 1);
    qExec.SQL.Text :=
      'DELETE FROM dbo.CRM_ROTA_PLAN_DURAK WHERE ROTA_ID = :R AND DURAK_ID NOT IN (' + IdList + ')';
  end
  else
    qExec.SQL.Text := 'DELETE FROM dbo.CRM_ROTA_PLAN_DURAK WHERE ROTA_ID = :R';
  qExec.ParamByName('R').AsLargeInt := FRotaId;
  qExec.Execute;

  for I := 0 to FDuraklar.Count - 1 do
  begin
    It := TRotaDurakItem(FDuraklar[I]);
    if It.DurakId > 0 then
    begin
      qExec.Close;
      qExec.SQL.Text :=
        'UPDATE dbo.CRM_ROTA_PLAN_DURAK SET SIRA = :S, DURAK_TIP = :T, NETSIS_CARI_KOD = :CK, POTANSIYEL_ID = :PID, ' +
        'UNVAN_SNAPSHOT = :U, IL_SNAPSHOT = :IL, ILCE_SNAPSHOT = :ILC, ADRES_SNAPSHOT = :AD, ' +
        'GPS_ENLEM = :GE, GPS_BOYLAM = :GB, GPSX = :GX, GPSY = :GY, UYARI_METNI = :UY, GOREV_ID = :GID, ' +
        'BACAK_KM = :BK, GPS_EKSIK = :GEK WHERE DURAK_ID = :DID AND ROTA_ID = :R';
      qExec.ParamByName('DID').AsLargeInt := It.DurakId;
      BindDurakParams;
      qExec.Execute;
    end
    else
    begin
      qExec.Close;
      qExec.SQL.Text :=
        'INSERT INTO dbo.CRM_ROTA_PLAN_DURAK (ROTA_ID, SIRA, DURAK_TIP, NETSIS_CARI_KOD, POTANSIYEL_ID, ' +
        'UNVAN_SNAPSHOT, IL_SNAPSHOT, ILCE_SNAPSHOT, ADRES_SNAPSHOT, GPS_ENLEM, GPS_BOYLAM, GPSX, GPSY, UYARI_METNI, GOREV_ID, BACAK_KM, GPS_EKSIK) ' +
        'OUTPUT INSERTED.DURAK_ID VALUES (:R, :S, :T, :CK, :PID, :U, :IL, :ILC, :AD, :GE, :GB, :GX, :GY, :UY, :GID, :BK, :GEK)';
      BindDurakParams;
      qExec.Open;
      if qExec.Fields[0].IsNull then
        NewId := 0
      else
        NewId := qExec.Fields[0].AsLargeInt;
      qExec.Close;
      It.DurakId := NewId;
    end;
  end;
  SyncGorevDurakRefs;
end;

procedure TfrmCrmRotaPlan.SyncGorevDurakRefs;
var
  I: Integer;
  It: TRotaDurakItem;
begin
  for I := 0 to FDuraklar.Count - 1 do
  begin
    It := TRotaDurakItem(FDuraklar[I]);
    if (It.GorevId > 0) and (It.DurakId > 0) then
    begin
      qExec.Close;
      qExec.SQL.Text :=
        'UPDATE A SET A.ROTA_DURAK_ID = :D, A.ROTA_ID = :R FROM dbo.CRM_AKTIVITE A ' +
        'INNER JOIN dbo.CRM_GOREV G ON G.AKTIVITE_ID = A.AKTIVITE_ID WHERE G.GOREV_ID = :G';
      qExec.ParamByName('D').AsLargeInt := It.DurakId;
      qExec.ParamByName('R').AsLargeInt := FRotaId;
      qExec.ParamByName('G').AsLargeInt := It.GorevId;
      qExec.Execute;
    end;
  end;
end;

procedure TfrmCrmRotaPlan.ReloadDurakIdsFromDb;
var
  I: Integer;
  Sr: Integer;
begin
  if FRotaId <= 0 then
    Exit;
  qTmp.Close;
  try
    qTmp.SQL.Text :=
      'SELECT DURAK_ID, SIRA, GOREV_ID FROM dbo.CRM_ROTA_PLAN_DURAK WHERE ROTA_ID = :R';
    qTmp.ParamByName('R').AsLargeInt := FRotaId;
    qTmp.Open;
  except
    qTmp.Close;
    qTmp.SQL.Text :=
      'SELECT DURAK_ID, SIRA FROM dbo.CRM_ROTA_PLAN_DURAK WHERE ROTA_ID = :R';
    qTmp.ParamByName('R').AsLargeInt := FRotaId;
    qTmp.Open;
  end;
  while not qTmp.Eof do
  begin
    Sr := qTmp.FieldByName('SIRA').AsInteger;
    for I := 0 to FDuraklar.Count - 1 do
      if TRotaDurakItem(FDuraklar[I]).Sira = Sr then
      begin
        TRotaDurakItem(FDuraklar[I]).DurakId := qTmp.FieldByName('DURAK_ID').AsLargeInt;
        if (qTmp.FindField('GOREV_ID') <> nil) and not qTmp.FieldByName('GOREV_ID').IsNull then
          if TRotaDurakItem(FDuraklar[I]).GorevId <= 0 then
            TRotaDurakItem(FDuraklar[I]).GorevId := qTmp.FieldByName('GOREV_ID').AsLargeInt;
        Break;
      end;
    qTmp.Next;
  end;
  qTmp.Close;
end;

procedure TfrmCrmRotaPlan.UniFormShow(Sender: TObject);
begin
  EnsureDuraklarList;
  if cbDurum.Items.Count = 0 then
  begin
    cbDurum.Items.Add('TASLAK');
    cbDurum.Items.Add('ONAYLI');
    cbDurum.Items.Add('IPTAL');
  end;
  if cbGpsMod.Items.Count = 0 then
  begin
    cbGpsMod.Items.Add('0 km + uyar'#305' (eksik bacak)');
    cbGpsMod.Items.Add('Toplamdan hari'#231' tut');
    cbGpsMod.ItemIndex := 0;
  end;
  KullanicilariAc;
  FRotaId := StrToInt64Def(Trim(Hint), 0);
  if FRotaId > 0 then
    YukleKayit
  else
    YeniKayit;
end;

procedure TfrmCrmRotaPlan.btnKaydetClick(Sender: TObject);
var
  Durum, OncekiDurum: string;
  NewId: Int64;

  procedure BindGeo;
  var
    La1, Ln1, La2, Ln2: Double;
  begin
    La1 := ParseDec(edBasEnlem.Text);
    Ln1 := ParseDec(edBasBoylam.Text);
    La2 := ParseDec(edBitEnlem.Text);
    Ln2 := ParseDec(edBitBoylam.Text);
    if (Abs(La1) < 1E-9) or (Abs(Ln1) < 1E-9) then
    begin
      qExec.ParamByName('LA1').Clear;
      qExec.ParamByName('LN1').Clear;
    end
    else
    begin
      qExec.ParamByName('LA1').AsFloat := La1;
      qExec.ParamByName('LN1').AsFloat := Ln1;
    end;
    if (Abs(La2) < 1E-9) or (Abs(Ln2) < 1E-9) then
    begin
      qExec.ParamByName('LA2').Clear;
      qExec.ParamByName('LN2').Clear;
    end
    else
    begin
      qExec.ParamByName('LA2').AsFloat := La2;
      qExec.ParamByName('LN2').AsFloat := Ln2;
    end;
  end;

begin
  if Trim(edBaslik.Text) = '' then
  begin
    UniMainModule.saHata.Show('Ba'#351'l'#305'k zorunlu.');
    Exit;
  end;
  if (cbDurum.ItemIndex < 0) or (cbDurum.ItemIndex > 2) then
    Durum := 'TASLAK'
  else
    Durum := cbDurum.Items[cbDurum.ItemIndex];
  OncekiDurum := FKayitDurum;
  HesaplaTumUyari;

  if FRotaId > 0 then
  begin
    qExec.Close;
    if SameText(Durum, 'IPTAL') then
      RotaGorevleriniIptal;
    qExec.Close;
    qExec.SQL.Text :=
      'UPDATE dbo.CRM_ROTA_PLAN SET BASLIK = :BAS, DETAY = :DET, PLANLAMA_TARIHI = :PT, DURUM = :DUR, ' +
      'BASLANGIC_ENLEM = :LA1, BASLANGIC_BOYLAM = :LN1, GPSX = :LA1, GPSY = :LN1, ' +
      'BITIS_ENLEM = :LA2, BITIS_BOYLAM = :LN2, ESIK_KM = :ESK, GUNCELLEME_UTC = SYSUTCDATETIME() WHERE ROTA_ID = :ID';
    qExec.ParamByName('ID').AsLargeInt := FRotaId;
    qExec.ParamByName('BAS').AsString := Trim(edBaslik.Text);
    qExec.ParamByName('DET').AsString := mmDetay.Text;
    qExec.ParamByName('PT').AsDate := DateOf(dtPlan.DateTime);
    qExec.ParamByName('DUR').AsString := Durum;
    qExec.ParamByName('ESK').AsInteger := EsikKm;
    BindGeo;
    qExec.Execute;
    PersistDuraklar;
    PersonelKaydet;
    GridYenile;
  end
  else
  begin
    qExec.Close;
    qExec.SQL.Text :=
      'INSERT INTO dbo.CRM_ROTA_PLAN (BASLIK, DETAY, PLANLAMA_TARIHI, DURUM, BASLANGIC_ENLEM, BASLANGIC_BOYLAM, GPSX, GPSY, ' +
      'BITIS_ENLEM, BITIS_BOYLAM, ESIK_KM, OLUSTURAN_KULLANICI_ID) OUTPUT INSERTED.ROTA_ID AS RID VALUES (' +
      ':BAS, :DET, :PT, :DUR, :LA1, :LN1, :LA1, :LN1, :LA2, :LN2, :ESK, :KUL)';
    qExec.ParamByName('BAS').AsString := Trim(edBaslik.Text);
    qExec.ParamByName('DET').AsString := mmDetay.Text;
    qExec.ParamByName('PT').AsDate := DateOf(dtPlan.DateTime);
    qExec.ParamByName('DUR').AsString := Durum;
    qExec.ParamByName('ESK').AsInteger := EsikKm;
    qExec.ParamByName('KUL').AsInteger := Tmp.xKullaniciID;
    BindGeo;
    qExec.Open;
    if qExec.Fields[0].IsNull then
      NewId := 0
    else
      NewId := qExec.Fields[0].AsLargeInt;
    qExec.Close;
    FRotaId := NewId;
    if FRotaId > 0 then
    begin
      PersistDuraklar;
      PersonelKaydet;
      Hint := IntToStr(FRotaId);
      YukleKayit;
    end;
  end;
  OnaySonrasiGorevKontrol(Durum, OncekiDurum);
  FKayitDurum := Durum;
  UniMainModule.saKaydet.Show('Kaydedildi.');
end;

procedure TfrmCrmRotaPlan.KullanicilariAc;
begin
  qKullanici.Close;
  qKullanici.SQL.Text := 'SELECT KullaniciID, KullaniciAd FROM dbo.Kullanici ORDER BY KullaniciAd';
  qKullanici.Open;
end;

procedure TfrmCrmRotaPlan.PersonelListYukle;
var
  I, Kid: Integer;
  Ad: string;
begin
  FPersonelIds.Clear;
  lbPersonel.Items.Clear;
  if FRotaId <= 0 then
    Exit;
  qTmp.Close;
  qTmp.SQL.Text :=
    'SELECT RP.KULLANICI_ID, K.KullaniciAd FROM dbo.CRM_ROTA_PLAN_PERSONEL RP ' +
    'INNER JOIN dbo.Kullanici K ON K.KullaniciID = RP.KULLANICI_ID WHERE RP.ROTA_ID = :R ORDER BY K.KullaniciAd';
  qTmp.ParamByName('R').AsLargeInt := FRotaId;
  qTmp.Open;
  while not qTmp.Eof do
  begin
    Kid := qTmp.FieldByName('KULLANICI_ID').AsInteger;
    Ad := qTmp.FieldByName('KullaniciAd').AsString;
    FPersonelIds.Add(IntToStr(Kid));
    lbPersonel.Items.AddObject(Ad, TObject(Kid));
    qTmp.Next;
  end;
  qTmp.Close;
end;

procedure TfrmCrmRotaPlan.PersonelKaydet;
var
  I, Kid: Integer;
begin
  if FRotaId <= 0 then
    Exit;
  qExec.Close;
  qExec.SQL.Text := 'DELETE FROM dbo.CRM_ROTA_PLAN_PERSONEL WHERE ROTA_ID = :R';
  qExec.ParamByName('R').AsLargeInt := FRotaId;
  qExec.Execute;
  for I := 0 to lbPersonel.Items.Count - 1 do
  begin
    Kid := Integer(lbPersonel.Items.Objects[I]);
    if Kid <= 0 then
      Continue;
    qExec.Close;
    qExec.SQL.Text :=
      'INSERT INTO dbo.CRM_ROTA_PLAN_PERSONEL (ROTA_ID, KULLANICI_ID) VALUES (:R, :K)';
    qExec.ParamByName('R').AsLargeInt := FRotaId;
    qExec.ParamByName('K').AsInteger := Kid;
    qExec.Execute;
  end;
end;

function TfrmCrmRotaPlan.GpsEksikModSecim: TCrmGpsEksikMod;
begin
  if cbGpsMod.ItemIndex = 1 then
    Result := geToplamHaric
  else
    Result := geSifirVeUyari;
end;

procedure TfrmCrmRotaPlan.MesafeHesaplaGoster;
var
  Noktalar: TArray<TCrmRotaNokta>;
  Sonuc, Kayit: TCrmRotaMesafeSonuc;
  I, Idx, N: Integer;
  HasBit: Boolean;
begin
  N := FDuraklar.Count;
  HasBit := CrmRotaNoktaGecerli(BitLat, BitLng);
  SetLength(Noktalar, 1 + N + Ord(HasBit));
  Idx := 0;
  Noktalar[Idx].Lat := BasLat;
  Noktalar[Idx].Lng := BasLng;
  Noktalar[Idx].Ad := 'Baslangic';
  Inc(Idx);
  for I := 0 to N - 1 do
  begin
    Noktalar[Idx].Lat := TRotaDurakItem(FDuraklar[I]).GpsE;
    Noktalar[Idx].Lng := TRotaDurakItem(FDuraklar[I]).GpsB;
    Noktalar[Idx].Ad := TRotaDurakItem(FDuraklar[I]).Unvan;
    Inc(Idx);
  end;
  if HasBit then
  begin
    Noktalar[Idx].Lat := BitLat;
    Noktalar[Idx].Lng := BitLng;
    Noktalar[Idx].Ad := 'Bitis';
  end;
  Sonuc := CrmRotaYolMesafeHesapla(Noktalar, GpsEksikModSecim);
  for I := 0 to N - 1 do
  begin
    if I < Length(Sonuc.BacakKm) then
    begin
      TRotaDurakItem(FDuraklar[I]).BacakKm := Sonuc.BacakKm[I];
      TRotaDurakItem(FDuraklar[I]).BacakGpsEksik :=
        (I < Length(Sonuc.BacakGpsEksik)) and Sonuc.BacakGpsEksik[I];
    end;
  end;
  lblToplamKm.Caption := Format('Toplam yol: %.1f km', [Sonuc.ToplamKm]);
  GridYenile;
  if FRotaId > 0 then
  begin
    Kayit := Sonuc;
    SetLength(Kayit.BacakKm, N);
    SetLength(Kayit.BacakGpsEksik, N);
    for I := 0 to N - 1 do
    begin
      Kayit.BacakKm[I] := TRotaDurakItem(FDuraklar[I]).BacakKm;
      Kayit.BacakGpsEksik[I] := TRotaDurakItem(FDuraklar[I]).BacakGpsEksik;
    end;
    CrmRotaMesafeDbKaydet(frmDM.conAsya, FRotaId, Kayit, GpsEksikModSecim);
  end;
  if Trim(Sonuc.Hata) <> '' then
    UniMainModule.saHata.Show(Sonuc.Hata);
end;

procedure TfrmCrmRotaPlan.btnMesafeHesaplaClick(Sender: TObject);
begin
  MesafeHesaplaGoster;
end;

procedure TfrmCrmRotaPlan.btnPersEkleClick(Sender: TObject);
var
  Kid: Integer;
  Ad: string;
begin
  if VarIsNull(lkPersonel.KeyValue) or VarIsEmpty(lkPersonel.KeyValue) then
  begin
    UniMainModule.saHata.Show('Personel se'#231'iniz.');
    Exit;
  end;
  Kid := lkPersonel.KeyValue;
  if Kid <= 0 then
    Exit;
  Ad := lkPersonel.Text;
  if lbPersonel.Items.IndexOfObject(TObject(Kid)) >= 0 then
    Exit;
  lbPersonel.Items.AddObject(Ad, TObject(Kid));
end;

procedure TfrmCrmRotaPlan.btnPersSilClick(Sender: TObject);
begin
  if lbPersonel.ItemIndex < 0 then
    Exit;
  lbPersonel.Items.Delete(lbPersonel.ItemIndex);
end;

procedure TfrmCrmRotaPlan.btnKapatClick(Sender: TObject);
begin
  MainForm.NavPage.ActivePage.Close;
end;

procedure TfrmCrmRotaPlan.btnHarBasClick(Sender: TObject);
begin
  with frmCrmHaritaSec do
  begin
    MerkezAyarla(ParseDec(edBasEnlem.Text), ParseDec(edBasBoylam.Text));
    HedefEnlemEdit := edBasEnlem;
    HedefBoylamEdit := edBasBoylam;
    HedefHaritaAdresMemo := nil;
    ShowModal;
  end;
end;

procedure TfrmCrmRotaPlan.btnHarBitClick(Sender: TObject);
begin
  with frmCrmHaritaSec do
  begin
    MerkezAyarla(ParseDec(edBitEnlem.Text), ParseDec(edBitBoylam.Text));
    HedefEnlemEdit := edBitEnlem;
    HedefBoylamEdit := edBitBoylam;
    HedefHaritaAdresMemo := nil;
    ShowModal;
  end;
end;

procedure TfrmCrmRotaPlan.btnEkleCariClick(Sender: TObject);
begin
  frmCrmCariSec.HedefCariEdit := nil;
  frmCrmCariSec.OnCariSecildi := CariSecildi;
  frmCrmCariSec.edArama.Text := '';
  frmCrmCariSec.ShowModal;
end;

procedure TfrmCrmRotaPlan.btnEklePotClick(Sender: TObject);
//var
//  PotForm: TfrmCrmPotansiyelListe;
begin
  { frmCrmCariSec.OnCariSecildi ile ayni: olay bu modal liste orneginde; UniMainModule + Self
    eslesmesi menudeki xFormShow(Create) ile GetFormInstance farki yuzunden kiriliyordu. }
//  PotForm := frmCrmPotansiyelListe;
//  PotForm.HedefPotansiyelIdEdit := nil;
//  PotForm.OnPotansiyelSecildi := PotSecildi;
//  PotForm.SecimToolbarYenile;
//  PotForm.BorderStyle := bsDialog;
//  PotForm.BorderIcons := [biSystemMenu];
//  try
//    PotForm.btnListeleClick(nil);
//    PotForm.ShowModal;
//  finally
//    PotForm.OnPotansiyelSecildi := nil;
//    PotForm.BorderStyle := bsNone;
//    PotForm.BorderIcons := [];
//    PotForm.SecimToolbarYenile;
//  end;

  frmCrmPotansiyelListe.HedefPotansiyelIdEdit := nil;
  frmCrmPotansiyelListe.OnPotansiyelSecildi := PotSecildi;
  frmCrmPotansiyelListe.edFiltUnvan.Text;
  frmCrmPotansiyelListe.ShowModal;


end;

procedure TfrmCrmRotaPlan.btnDurakSilClick(Sender: TObject);
var
  Sr: Integer;
  I, J: Integer;
  It: TRotaDurakItem;
begin
  if not qGrid.Active or qGrid.IsEmpty then
  begin
    UniMainModule.saHata.Show(#214'nce durak se'#231'in.');
    Exit;
  end;
  Sr := qGrid.FieldByName('SIRA').AsInteger;
  for I := FDuraklar.Count - 1 downto 0 do
    if TRotaDurakItem(FDuraklar[I]).Sira = Sr then
    begin
      It := TRotaDurakItem(FDuraklar[I]);
      if It.GorevId > 0 then
        GorevSilById(It.GorevId);
      FDuraklar.Delete(I);
      Break;
    end;
  J := 1;
  for I := 0 to FDuraklar.Count - 1 do
  begin
    TRotaDurakItem(FDuraklar[I]).Sira := J;
    Inc(J);
  end;
  HesaplaTumUyari;
  GridYenile;
end;

procedure TfrmCrmRotaPlan.btnUyariYenileClick(Sender: TObject);
begin
  HesaplaTumUyari;
  GridYenile;
end;

procedure TfrmCrmRotaPlan.SiralariYenidenNumarala;
var
  I: Integer;
begin
  for I := 0 to FDuraklar.Count - 1 do
    TRotaDurakItem(FDuraklar[I]).Sira := I + 1;
end;

function TfrmCrmRotaPlan.SeciliDurakIndeks: Integer;
var
  Sr, I: Integer;
begin
  Result := -1;
  if not qGrid.Active or qGrid.IsEmpty then
    Exit;
  Sr := qGrid.FieldByName('SIRA').AsInteger;
  for I := 0 to FDuraklar.Count - 1 do
    if TRotaDurakItem(FDuraklar[I]).Sira = Sr then
      Exit(I);
end;

procedure TfrmCrmRotaPlan.DurakYukari;
var
  Idx: Integer;
  It: TRotaDurakItem;
begin
  Idx := SeciliDurakIndeks;
  if Idx <= 0 then
    Exit;
  It := TRotaDurakItem(FDuraklar[Idx]);
  FDuraklar.Delete(Idx);
  FDuraklar.Insert(Idx - 1, It);
  SiralariYenidenNumarala;
  HesaplaTumUyari;
  GridYenile;
end;

procedure TfrmCrmRotaPlan.DurakAsagi;
var
  Idx: Integer;
  It: TRotaDurakItem;
begin
  Idx := SeciliDurakIndeks;
  if (Idx < 0) or (Idx >= FDuraklar.Count - 1) then
    Exit;
  It := TRotaDurakItem(FDuraklar[Idx]);
  FDuraklar.Delete(Idx);
  FDuraklar.Insert(Idx + 1, It);
  SiralariYenidenNumarala;
  HesaplaTumUyari;
  GridYenile;
end;

procedure TfrmCrmRotaPlan.OtomatikSiralaMesafe;
var
  Lats, Lngs: TArray<Double>;
  Order: TArray<Integer>;
  Sirali: TArray<TRotaDurakItem>;
  I, N: Integer;
begin
  EnsureDuraklarList;
  N := FDuraklar.Count;
  if N = 0 then
    Exit;
  if (Abs(BasLat) < 1E-9) and (Abs(BasLng) < 1E-9) then
  begin
    UniMainModule.saHata.Show('Otomatik s'#305'ralama i'#231'in rota ba'#351'lang'#305#231' GPS (X/Y) giriniz.');
    Exit;
  end;
  SetLength(Lats, N);
  SetLength(Lngs, N);
  SetLength(Order, N);
  SetLength(Sirali, N);
  for I := 0 to N - 1 do
  begin
    Lats[I] := TRotaDurakItem(FDuraklar[I]).GpsE;
    Lngs[I] := TRotaDurakItem(FDuraklar[I]).GpsB;
  end;
  CrmRotaSiralaEnYakinKomsu(BasLat, BasLng, Lats, Lngs, Order);
  for I := 0 to N - 1 do
    Sirali[I] := TRotaDurakItem(FDuraklar[Order[I]]);
  FDuraklar.OwnsObjects := False;
  FDuraklar.Clear;
  FDuraklar.OwnsObjects := True;
  for I := 0 to N - 1 do
    FDuraklar.Add(Sirali[I]);
  SiralariYenidenNumarala;
  HesaplaTumUyari;
  GridYenile;
  // TODO : Gelismis rota optimizasyon algoritmasi burada uygulanacak
end;

function TfrmCrmRotaPlan.GorevTipId: Int64;
begin
  Result := 0;
  qTmp.Close;
  qTmp.SQL.Text :=
    'SELECT TOP 1 TIP_ID FROM dbo.CRM_AKTIVITE_TIP WHERE KOD = ''TASK'' AND AKTIF = 1 ORDER BY TIP_ID';
  qTmp.Open;
  if not qTmp.IsEmpty then
    Result := qTmp.Fields[0].AsLargeInt;
  qTmp.Close;
end;

function TfrmCrmRotaPlan.GorevDurumIdAcik: Int64;
begin
  Result := 0;
  qTmp.Close;
  qTmp.SQL.Text :=
    'SELECT TOP 1 DURUM_ID FROM dbo.CRM_AKTIVITE_DURUM WHERE KOD = ''ACIK'' AND AKTIF = 1 ORDER BY DURUM_ID';
  qTmp.Open;
  if not qTmp.IsEmpty then
    Result := qTmp.Fields[0].AsLargeInt;
  qTmp.Close;
end;

procedure TfrmCrmRotaPlan.GorevSilById(AGorevId: Int64);
var
  Aid: Int64;
begin
  if AGorevId <= 0 then
    Exit;
  Aid := 0;
  qTmp.Close;
  qTmp.SQL.Text := 'SELECT AKTIVITE_ID FROM dbo.CRM_GOREV WHERE GOREV_ID = :G';
  qTmp.ParamByName('G').AsLargeInt := AGorevId;
  qTmp.Open;
  if not qTmp.IsEmpty then
    Aid := qTmp.Fields[0].AsLargeInt;
  qTmp.Close;
  if Aid > 0 then
  begin
    qExec.Close;
    qExec.SQL.Text := 'DELETE FROM dbo.CRM_AKTIVITE WHERE AKTIVITE_ID = :A';
    qExec.ParamByName('A').AsLargeInt := Aid;
    qExec.Execute;
  end;
end;

procedure TfrmCrmRotaPlan.RotaGorevleriniIptal;
var
  I: Integer;
begin
  if FRotaId <= 0 then
    Exit;
  CrmRotaGorevleriniIptal(qExec, FRotaId, True);
  for I := 0 to FDuraklar.Count - 1 do
    TRotaDurakItem(FDuraklar[I]).GorevId := 0;
end;

function TfrmCrmRotaPlan.GorevOlusturVeyaGuncelle(AIt: TRotaDurakItem): Int64;
var
  TaskTid, DurId, Aid, Gid: Int64;
  Konu, Acik: string;
  AktTar, Bitis: TDateTime;
  AtananId: Integer;
  PersonelIds: TArray<Integer>;

  procedure BindCariPot;
  begin
    if AIt.DurakTip = 'C' then
    begin
      qExec.ParamByName('CK').AsString := Trim(AIt.CariKod);
      qExec.ParamByName('PID').Clear;
    end
    else if AIt.DurakTip = 'P' then
    begin
      qExec.ParamByName('CK').Clear;
      qExec.ParamByName('PID').AsLargeInt := AIt.PotId;
    end
    else
    begin
      qExec.ParamByName('CK').Clear;
      qExec.ParamByName('PID').Clear;
    end;
  end;

  procedure BindAtanan;
  begin
    if AtananId <= 0 then
      qExec.ParamByName('ATAN').Clear
    else
      qExec.ParamByName('ATAN').AsInteger := AtananId;
  end;

begin
  Result := 0;
  if AIt = nil then
    Exit;
  if FRotaId <= 0 then
    raise Exception.Create(#214'nce rotay'#305' kaydedin.');
  TaskTid := GorevTipId;
  DurId := GorevDurumIdAcik;
  if TaskTid <= 0 then
    raise Exception.Create('CRM TASK aktivite tipi bulunamad'#305'.');
  if DurId <= 0 then
    raise Exception.Create('CRM ACIK durum kayd'#305' bulunamad'#305'.');

  PersonelIds := PersonelIdDizisi;
  AktTar := CrmRotaGorevZamanHesapla(FGorevAyar, dtPlan.DateTime, AIt.Sira);
  Bitis := CrmRotaGorevBitisTarihi(AktTar);
  AtananId := CrmRotaPersonelAtananId(PersonelIds, AIt.Sira);

  Konu := Format('Rota: %s - Durak %d: %s', [Trim(edBaslik.Text), AIt.Sira, Trim(AIt.Unvan)]);
  Acik := Format('Rota plani #%d durak ziyareti. %s', [FRotaId, Trim(AIt.Adres)]);

  if AIt.GorevId > 0 then
  begin
    Aid := 0;
    qTmp.Close;
    qTmp.SQL.Text := 'SELECT AKTIVITE_ID FROM dbo.CRM_GOREV WHERE GOREV_ID = :G';
    qTmp.ParamByName('G').AsLargeInt := AIt.GorevId;
    qTmp.Open;
    if qTmp.IsEmpty then
    begin
      qTmp.Close;
      AIt.GorevId := 0;
    end
    else
      Aid := qTmp.Fields[0].AsLargeInt;
    qTmp.Close;
    if Aid > 0 then
    begin
      qExec.Close;
      qExec.SQL.Text :=
        'UPDATE dbo.CRM_AKTIVITE SET KONU = :KONU, ACIKLAMA = :ACIK, CARI_KOD = :CK, POTANSIYEL_ID = :PID, ' +
        'AKTIVITE_TARIHI = :TAR, DURUM = ''ACIK'', AKTIVITE_DURUM_ID = :DID, ' +
        'ROTA_ID = :RID, ROTA_DURAK_ID = :DID2, GUNCELLEME_UTC = SYSUTCDATETIME() ' +
        'WHERE AKTIVITE_ID = :AID AND TIP = ''TASK''';
      qExec.ParamByName('KONU').AsString := Konu;
      qExec.ParamByName('ACIK').AsString := Acik;
      BindCariPot;
      qExec.ParamByName('TAR').AsDateTime := AktTar;
      qExec.ParamByName('DID').AsLargeInt := DurId;
      qExec.ParamByName('RID').AsLargeInt := FRotaId;
      if AIt.DurakId > 0 then
        qExec.ParamByName('DID2').AsLargeInt := AIt.DurakId
      else
        qExec.ParamByName('DID2').Clear;
      qExec.ParamByName('AID').AsLargeInt := Aid;
      qExec.Execute;
      qExec.Close;
      qExec.SQL.Text :=
        'UPDATE dbo.CRM_GOREV SET ATANAN_KULLANICI_ID = :ATAN, BITIS_TARIHI = :BITIS, ONCELIK = ''NORMAL'', ' +
        'TAMAMLANDI = 0, TAMAMLANMA_UTC = NULL WHERE GOREV_ID = :G';
      BindAtanan;
      qExec.ParamByName('BITIS').AsDateTime := Bitis;
      qExec.ParamByName('G').AsLargeInt := AIt.GorevId;
      qExec.Execute;
      Result := AIt.GorevId;
      Exit;
    end;
  end;

  qExec.Close;
  qExec.SQL.Text :=
    'INSERT INTO dbo.CRM_AKTIVITE (TIP, KONU, ACIKLAMA, CARI_KOD, POTANSIYEL_ID, AKTIVITE_TARIHI, DURUM, OLUSTURAN_KULLANICI_ID, ' +
    'AKTIVITE_TIP_ID, AKTIVITE_DURUM_ID, ROTA_ID, ROTA_DURAK_ID) OUTPUT INSERTED.AKTIVITE_ID ' +
    'VALUES (''TASK'', :KONU, :ACIK, :CK, :PID, :TAR, ''ACIK'', :KUL, :TID, :DID, :RID, :DID2)';
  qExec.ParamByName('KONU').AsString := Konu;
  qExec.ParamByName('ACIK').AsString := Acik;
  BindCariPot;
  qExec.ParamByName('TAR').AsDateTime := AktTar;
  qExec.ParamByName('KUL').AsInteger := Tmp.xKullaniciID;
  qExec.ParamByName('TID').AsLargeInt := TaskTid;
  qExec.ParamByName('DID').AsLargeInt := DurId;
  qExec.ParamByName('RID').AsLargeInt := FRotaId;
  if AIt.DurakId > 0 then
    qExec.ParamByName('DID2').AsLargeInt := AIt.DurakId
  else
    qExec.ParamByName('DID2').Clear;
  qExec.Open;
  if qExec.Fields[0].IsNull then
    Aid := 0
  else
    Aid := qExec.Fields[0].AsLargeInt;
  qExec.Close;
  if Aid <= 0 then
    raise Exception.Create('G'#246'rev aktivitesi olu'#351'turulamad'#305'.');

  qExec.Close;
  qExec.SQL.Text :=
    'INSERT INTO dbo.CRM_GOREV (AKTIVITE_ID, ATANAN_KULLANICI_ID, BITIS_TARIHI, ONCELIK, TAMAMLANDI) OUTPUT INSERTED.GOREV_ID ' +
    'VALUES (:AID, :ATAN, :BITIS, ''NORMAL'', 0)';
  qExec.ParamByName('AID').AsLargeInt := Aid;
  BindAtanan;
  qExec.ParamByName('BITIS').AsDateTime := Bitis;
  qExec.Open;
  if qExec.Fields[0].IsNull then
    Gid := 0
  else
    Gid := qExec.Fields[0].AsLargeInt;
  qExec.Close;
  AIt.GorevId := Gid;
  Result := Gid;
end;

function TfrmCrmRotaPlan.PersonelIdDizisi: TArray<Integer>;
var
  I: Integer;
begin
  SetLength(Result, lbPersonel.Items.Count);
  for I := 0 to lbPersonel.Items.Count - 1 do
    Result[I] := Integer(lbPersonel.Items.Objects[I]);
end;

function TfrmCrmRotaPlan.TumDuraklarIcinGorevOlustur(AShowMesaj: Boolean): Integer;
var
  I, N: Integer;
  It: TRotaDurakItem;
begin
  Result := 0;
  if FRotaId <= 0 then
    Exit;
  if FDuraklar.Count = 0 then
    Exit;
  FGorevAyar := CrmRotaGorevAyarOku(frmDM.conAsya, Tmp.xSubeKodu);
  PersistDuraklar;
  ReloadDurakIdsFromDb;
  N := 0;
  for I := 0 to FDuraklar.Count - 1 do
  begin
    It := TRotaDurakItem(FDuraklar[I]);
    if GorevOlusturVeyaGuncelle(It) > 0 then
      Inc(N);
  end;
  PersistDuraklar;
  GridYenile;
  Result := N;
  if AShowMesaj then
    UniMainModule.saKaydet.Show(Format('%d durak i'#231'in g'#246'rev olu'#351'turuldu veya g'#252'ncellendi.', [N]));
end;

procedure TfrmCrmRotaPlan.OnaySonrasiGorevKontrol(const YeniDurum, OncekiDurum: string);
begin
  if not SameText(YeniDurum, 'ONAYLI') then
    Exit;
  if FRotaId <= 0 then
    Exit;
  if FDuraklar.Count = 0 then
    Exit;
  FGorevAyar := CrmRotaGorevAyarOku(frmDM.conAsya, Tmp.xSubeKodu);
  if FGorevAyar.OnayGorevOto = ROTA_GOREV_OTO_KAPALI then
    Exit;
  if FGorevAyar.OnayGorevOto = ROTA_GOREV_OTO_HER then
  begin
    try
      TumDuraklarIcinGorevOlustur(False);
    except
      on E: Exception do
        UniMainModule.saHata.Show('G'#246'rev olu'#351'turma hatas'#305': ' + E.Message);
    end;
    Exit;
  end;
  if FGorevAyar.OnayGorevOto = ROTA_GOREV_OTO_SOR then
  begin
    if SameText(OncekiDurum, 'ONAYLI') then
      Exit;
    saOnayGorev.Title := 'G'#246'rev olu'#351'tur';
    saOnayGorev.Text := Format(
      'Rota onayland'#305'. %d durak i'#231'in g'#246'rev/aktivite olu'#351'turulsun mu?'#13#10 +
      'Personel atamas'#305' ve zaman plan'#305' parametrelerden uygulan'#305'r.',
      [FDuraklar.Count]);
    saOnayGorev.Show;
  end;
end;

procedure TfrmCrmRotaPlan.saOnayGorevConfirm(Sender: TObject);
begin
  try
    TumDuraklarIcinGorevOlustur(True);
  except
    on E: Exception do
      UniMainModule.saHata.Show('G'#246'rev olu'#351'turma hatas'#305': ' + E.Message);
  end;
end;

procedure TfrmCrmRotaPlan.btnDurakYukariClick(Sender: TObject);
begin
  DurakYukari;
end;

procedure TfrmCrmRotaPlan.btnDurakAsagiClick(Sender: TObject);
begin
  DurakAsagi;
end;

procedure TfrmCrmRotaPlan.btnOtomatikSiralaClick(Sender: TObject);
begin
  try
    OtomatikSiralaMesafe;
    UniMainModule.saKaydet.Show('Duraklar ba'#351'lang'#305#231' noktas'#305'na g'#246're mesafe s'#305'ras'#305'na g'#246're d'#252'zenlendi.');
  except
    on E: Exception do
      UniMainModule.saHata.Show(E.Message);
  end;
end;

procedure TfrmCrmRotaPlan.btnGorevOlusturClick(Sender: TObject);
begin
  if FRotaId <= 0 then
  begin
    UniMainModule.saHata.Show(#214'nce rotay'#305' kaydedin, sonra g'#246'rev olu'#351'turun.');
    Exit;
  end;
  if FDuraklar.Count = 0 then
  begin
    UniMainModule.saHata.Show('G'#246'rev olu'#351'turmak i'#231'in en az bir durak ekleyin.');
    Exit;
  end;
  try
    TumDuraklarIcinGorevOlustur(True);
  except
    on E: Exception do
      UniMainModule.saHata.Show('G'#246'rev olu'#351'turma hatas'#305': ' + E.Message);
  end;
end;

function TfrmCrmRotaPlan.HaritaNoktaListesiJson: string;
var
  SL: TStringList;
  La, Ln: Double;
  I, J: Integer;
  It: TRotaDurakItem;
  FS: TFormatSettings;

  procedure Ekle(const ALa, ALn: Double; const ALabel: string);
  begin
    if (Abs(ALa) < 1E-7) or (Abs(ALn) < 1E-7) then
      Exit;
    SL.Add('{lat:' + FormatFloat('0.######', ALa, FS) + ',lng:' + FormatFloat('0.######', ALn, FS) +
      ',label:"' + ALabel + '"}');
  end;

begin
  FS := TFormatSettings.Invariant;
  SL := TStringList.Create;
  try
    Ekle(BasLat, BasLng, 'B');
    for I := 0 to FDuraklar.Count - 1 do
    begin
      It := TRotaDurakItem(FDuraklar[I]);
      Ekle(It.GpsE, It.GpsB, IntToStr(It.Sira));
    end;
    Ekle(BitLat, BitLng, 'S');
    if SL.Count < 2 then
    begin
      Result := '';
      Exit;
    end;
    Result := SL[0];
    for J := 1 to SL.Count - 1 do
      Result := Result + ',' + SL[J];
    Result := '[' + Result + ']';
  finally
    SL.Free;
  end;
end;

procedure TfrmCrmRotaPlan.RotayiHaritaGoster;
var
  Pts: string;
  Key: string;
  Html: string;
  Fn: string;
  Sl: TStringList;
begin
  Pts := HaritaNoktaListesiJson;
  if Pts = '' then
  begin
    UniMainModule.saHata.Show('Harita i'#231'in en az iki ge'#231'erli koordinat gerekir (ba'#351'lang'#305#231', durak veya biti'#351').');
    Exit;
  end;
  Key := Trim(CrmGoogleMapsBrowserApiKey);
  if (Key = '') or SameText(Key, 'YOUR_BROWSER_KEY_HERE') then
  begin
    UniMainModule.saHata.Show('Google Maps anahtar'#305' CrmMapsConfigU i'#231'inde tan'#305'mlanmal'#305'.');
    Exit;
  end;
  Fn := 'crm_rota_' + IntToStr(GetTickCount) + '.html';
  { DirectionsService -> Google Cloud'ta "Directions API" acik olmali + faturalama.
    REQUEST_DENIED genelde API kapali veya anahtar kisitlamasi. Basarisizda dogrudan cizgi yedegi. }
  Html :=
    '<!DOCTYPE html><html><head><meta charset="utf-8"/><style>html,body,' + '#map' + '{height:100%;margin:0;position:relative}</style>'#10 +
    '<script>'#10 +
    'var routePts = ' + Pts + ';'#10 +
    'function rotaBasitCizgi(map){'#10 +
    'var path=[];for(var i=0;i<routePts.length;i++)path.push(routePts[i]);'#10 +
    'new google.maps.Polyline({path:path,geodesic:true,strokeColor:"#996633",strokeOpacity:0.9,strokeWeight:3,map:map});'#10 +
    'var b=new google.maps.LatLngBounds();routePts.forEach(function(p){b.extend(p);});map.fitBounds(b);'#10 +
    '}'#10 +
    'function uyariBandi(map,status){'#10 +
    'var d=document.createElement("div");d.style.cssText="position:absolute;top:0;left:0;right:0;background:#fff3cd;color:#856404;padding:10px 12px;font:12px/1.4 sans-serif;z-index:5;border-bottom:1px solid #856404";'#10 +
    'd.innerHTML="<b>Rota cizilemedi ("+status+").</b> Google Cloud Console: <b>Directions API</b> etkin olsun, faturalama acik olsun, API anahtari HTTP referrer ile uygulama adresinize izin versin. Asagida noktalar arasi dogru cizgi gosteriliyor.";'#10 +
    'map.getDiv().appendChild(d);'#10 +
    '}'#10 +
    '// TODO : Google Maps rota gorsellestirme - durak etiketleri (label) marker ile belirginlestirilecek'#10 +
    'function initMap(){'#10 +
    'var map = new google.maps.Map(document.getElementById("map"), { zoom: 6, center: routePts[0] });'#10 +
    'for(var i=0;i<routePts.length;i++){if(routePts[i].label)new google.maps.Marker({position:routePts[i],map:map,label:String(routePts[i].label)});}'#10 +
    'var ds = new google.maps.DirectionsService();'#10 +
    'var o = routePts[0], d = routePts[routePts.length-1];'#10 +
    'var req = { origin: o, destination: d, travelMode: google.maps.TravelMode.DRIVING, provideRouteAlternatives: true };'#10 +
    'if (routePts.length > 2) {'#10 +
    '  req.waypoints = [];'#10 +
    '  for (var i=1;i<routePts.length-1;i++) req.waypoints.push({location: routePts[i], stopover: true});'#10 +
    '}'#10 +
    'ds.route(req, function(res, status) {'#10 +
    'if (status !== google.maps.DirectionsStatus.OK) { uyariBandi(map,status); rotaBasitCizgi(map); return; }'#10 +
    'var cols = ["' + '#cc3366' + '","' + '#339933' + '","' + '#333399' + '"];'#10 +
    'for (var r=0;r<res.routes.length;r++) {'#10 +
    'new google.maps.Polyline({ path: res.routes[r].overview_path, strokeColor: cols[r % cols.length], strokeOpacity: 0.85, strokeWeight: 5, map: map });'#10 +
    '}'#10 +
    'var b = new google.maps.LatLngBounds();'#10 +
    'routePts.forEach(function(p){ b.extend(p); });'#10 +
    'map.fitBounds(b);'#10 +
    '});}'#10 +
    '</script>'#10 +
    '<script async defer src="https://maps.googleapis.com/maps/api/js?key=' + Key + '&callback=initMap"></script>'#10 +
    '</head><body><div id="map"></div></body></html>';
  Sl := TStringList.Create;
  try
    Sl.Text := Html;
    Sl.SaveToFile(TPath.Combine(UniServerModule.LocalCachePath, Fn), TEncoding.UTF8);
  finally
    Sl.Free;
  end;
  frmCrmRotaHarita.HaritaUrl := UniServerModule.LocalCacheURL + Fn;
  frmCrmRotaHarita.ShowModal;
end;

procedure TfrmCrmRotaPlan.btnRotaHaritaClick(Sender: TObject);
begin
  RotayiHaritaGoster;
end;

end.
