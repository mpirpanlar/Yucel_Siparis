unit CrmRotaU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  System.Contnrs,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniMemo, uniButton, uniComboBox, uniDateTimePicker,
  uniBasicGrid, uniDBGrid, Data.DB, MemDS, DBAccess, Uni, uniMultiItem;

type
  TfrmCrmRotaPlan = class(TUniForm)
    rootPanel: TUniPanel;
    panFooter: TUniPanel;
    btnKaydet: TUniButton;
    btnRotaHarita: TUniButton;
    btnKapat: TUniButton;
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
    btnDurakSil: TUniButton;
    btnUyariYenile: TUniButton;
    grdDurak: TUniDBGrid;
    qGrid: TUniQuery;
    dsGrid: TUniDataSource;
    qExec: TUniQuery;
    qLoad: TUniQuery;
    qNetsis: TUniQuery;
    qTmp: TUniQuery;
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormDestroy(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure btnHarBasClick(Sender: TObject);
    procedure btnHarBitClick(Sender: TObject);
    procedure btnEkleCariClick(Sender: TObject);
    procedure btnEklePotClick(Sender: TObject);
    procedure btnDurakSilClick(Sender: TObject);
    procedure btnUyariYenileClick(Sender: TObject);
    procedure btnRotaHaritaClick(Sender: TObject);
  private
    FDuraklar: TObjectList;
    FRotaId: Int64;
    function ParseDec(const S: string): Double;
    function SqlNv(const S: string): string;
    function EsikKm: Integer;
    function BasLat: Double;
    function BasLng: Double;
    function BitLat: Double;
    function BitLng: Double;
    procedure YeniKayit;
    procedure YukleKayit;
    procedure GridYenile;
    procedure HesaplaTumUyari;
    function SonSira: Integer;
    procedure CariSecildi(Sender: TObject; const ACariKod: string);
    procedure PotSecildi(Sender: TObject; APotId: Int64);
    procedure AddDurakCari(const ACariKod: string);
    procedure AddDurakPot(APotId: Int64);
    procedure PersistDuraklar;
    function HaritaNoktaListesiJson: string;
    procedure RotayiHaritaGoster;
  public
  end;

function frmCrmRotaPlan: TfrmCrmRotaPlan;

implementation

{$R *.dfm}

uses
  System.Math, System.IOUtils, System.DateUtils, StrUtils,
  ServerModule,
  uniGUIApplication, MainModule, DMU, TmpU, Main, Genel,
  CrmCariSecU, CrmPotansiyelListeU, CrmHaritaSecU, CrmRotaHaritaU, CrmRotaGeoU, CrmMapsConfigU;

type
  TRotaDurakItem = class
  public
    Sira: Integer;
    DurakTip: Char;
    CariKod: string;
    PotId: Int64;
    Unvan: string;
    Il, Ilce, Adres: string;
    GpsE, GpsB: Double;
    Uyari: string;
    constructor Create;
  end;

constructor TRotaDurakItem.Create;
begin
  inherited Create;
  DurakTip := 'C';
  PotId := 0;
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
  Result := StringReplace(Trim(S), '''', '''''', [rfReplaceAll]);
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
  FDuraklar := TObjectList.Create(True);
end;

procedure TfrmCrmRotaPlan.UniFormDestroy(Sender: TObject);
begin
  FreeAndNil(FDuraklar);
end;

procedure TfrmCrmRotaPlan.YeniKayit;
begin
  FRotaId := 0;
  Caption := 'Yeni rota plani';
  edBaslik.Text := '';
  mmDetay.Clear;
  dtPlan.DateTime := Date;
  cbDurum.ItemIndex := 0;
  edBasEnlem.Text := '';
  edBasBoylam.Text := '';
  edBitEnlem.Text := '';
  edBitBoylam.Text := '';
  edEsikKm.Text := '80';
  FDuraklar.Clear;
  GridYenile;
end;

procedure TfrmCrmRotaPlan.YukleKayit;
begin
  qLoad.Close;
  qLoad.SQL.Text := 'SELECT * FROM dbo.CRM_ROTA_PLAN WHERE ROTA_ID = :ID';
  qLoad.ParamByName('ID').AsLargeInt := FRotaId;
  qLoad.Open;
  if qLoad.IsEmpty then
  begin
    qLoad.Close;
    UniMainModule.saHata.Show('Kayit yok.');
    YeniKayit;
    Exit;
  end;
  edBaslik.Text := qLoad.FieldByName('BASLIK').AsString;
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
  if qLoad.FieldByName('BASLANGIC_ENLEM').IsNull then
    edBasEnlem.Text := ''
  else
    edBasEnlem.Text := FormatFloat('0.######', qLoad.FieldByName('BASLANGIC_ENLEM').AsFloat, TFormatSettings.Invariant);
  if qLoad.FieldByName('BASLANGIC_BOYLAM').IsNull then
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
  qLoad.Close;

  FDuraklar.Clear;
  qTmp.Close;
  qTmp.SQL.Text :=
    'SELECT DURAK_ID, SIRA, DURAK_TIP, NETSIS_CARI_KOD, POTANSIYEL_ID, UNVAN_SNAPSHOT, ' +
    'IL_SNAPSHOT, ILCE_SNAPSHOT, ADRES_SNAPSHOT, GPS_ENLEM, GPS_BOYLAM, UYARI_METNI ' +
    'FROM dbo.CRM_ROTA_PLAN_DURAK WHERE ROTA_ID = :R ORDER BY SIRA, DURAK_ID';
  qTmp.ParamByName('R').AsLargeInt := FRotaId;
  qTmp.Open;
  while not qTmp.Eof do
  begin
    with TRotaDurakItem(FDuraklar.Add(TRotaDurakItem.Create)) do
    begin
      Sira := qTmp.FieldByName('SIRA').AsInteger;
      DurakTip := qTmp.FieldByName('DURAK_TIP').AsString[1];
      CariKod := '';
      if not qTmp.FieldByName('NETSIS_CARI_KOD').IsNull then
        CariKod := Trim(qTmp.FieldByName('NETSIS_CARI_KOD').AsString);
      PotId := 0;
      if not qTmp.FieldByName('POTANSIYEL_ID').IsNull then
        PotId := qTmp.FieldByName('POTANSIYEL_ID').AsLargeInt;
      Unvan := qTmp.FieldByName('UNVAN_SNAPSHOT').AsString;
      Il := qTmp.FieldByName('IL_SNAPSHOT').AsString;
      Ilce := qTmp.FieldByName('ILCE_SNAPSHOT').AsString;
      Adres := qTmp.FieldByName('ADRES_SNAPSHOT').AsString;
      if qTmp.FieldByName('GPS_ENLEM').IsNull then
        GpsE := 0
      else
        GpsE := qTmp.FieldByName('GPS_ENLEM').AsFloat;
      if qTmp.FieldByName('GPS_BOYLAM').IsNull then
        GpsB := 0
      else
        GpsB := qTmp.FieldByName('GPS_BOYLAM').AsFloat;
      Uyari := qTmp.FieldByName('UYARI_METNI').AsString;
    end;
    qTmp.Next;
  end;
  qTmp.Close;
  Caption := 'Rota plani';
  GridYenile;
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
    Sql := Sql + '(' + IntToStr(It.Sira) + ', N''' + It.DurakTip + ''', ';
    if It.DurakTip = 'C' then
      Sql := Sql + 'N''' + SqlNv(It.CariKod) + ''', CAST(NULL AS BIGINT), '
    else
      Sql := Sql + 'CAST(NULL AS NVARCHAR(50)), ' + IntToStr(It.PotId) + ', ';
    Sql := Sql + 'N''' + SqlNv(It.Unvan) + ''', N''' + SqlNv(It.Il) + ''', N''' + SqlNv(It.Ilce) +
      ''', N''' + SqlNv(It.Adres) + ''', CAST(' + Fnv(It.GpsE) + ' AS DECIMAL(18,6)), CAST(' +
      Fnv(It.GpsB) + ' AS DECIMAL(18,6)), N''' + SqlNv(It.Uyari) + ''')';
  end;
  Sql := Sql + ') AS T(SIRA, TIP, CARI_KOD, POTID, UNVAN, IL, ILCE, ADRES, ENLEM, BOYLAM, UYARI) ORDER BY SIRA';
  qGrid.SQL.Text := Sql;
  qGrid.Open;
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
  It: TRotaDurakItem;
  Ge, Gb: Double;
  CIsim, CI, CC, CAD: string;
begin
  Ck := Trim(ACariKod);
  if Ck = '' then
    Exit;
  qNetsis.Close;
  qNetsis.SQL.Text :=
    'SELECT TOP 1 CARI_KOD, CARI_ISIM, ISNULL(CARI_IL, N'''') AS CI, ISNULL(CARI_ILCE, N'''') AS CC, ' +
    'ISNULL(CARI_ADRES, N'''') AS CAD FROM HV_CARI_LISTESI WHERE CARI_KOD = :K';
  qNetsis.ParamByName('K').AsString := Ck;
  qNetsis.Open;
  if qNetsis.IsEmpty then
  begin
    qNetsis.Close;
    UniMainModule.saHata.Show('Cari HV listesinde bulunamadi: ' + Ck);
    Exit;
  end;
  CIsim := qNetsis.FieldByName('CARI_ISIM').AsString;
  CI := qNetsis.FieldByName('CI').AsString;
  CC := qNetsis.FieldByName('CC').AsString;
  CAD := qNetsis.FieldByName('CAD').AsString;
  qNetsis.Close;

  Ge := 0;
  Gb := 0;
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
    UniMainModule.saHata.Show('Potansiyel bulunamadi.');
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

procedure TfrmCrmRotaPlan.PersistDuraklar;
var
  I: Integer;
  It: TRotaDurakItem;
begin
  qExec.Close;
  qExec.SQL.Text := 'DELETE FROM dbo.CRM_ROTA_PLAN_DURAK WHERE ROTA_ID = :R';
  qExec.ParamByName('R').AsLargeInt := FRotaId;
  qExec.Execute;
  for I := 0 to FDuraklar.Count - 1 do
  begin
    It := TRotaDurakItem(FDuraklar[I]);
    qExec.Close;
    qExec.SQL.Text :=
      'INSERT INTO dbo.CRM_ROTA_PLAN_DURAK (ROTA_ID, SIRA, DURAK_TIP, NETSIS_CARI_KOD, POTANSIYEL_ID, ' +
      'UNVAN_SNAPSHOT, IL_SNAPSHOT, ILCE_SNAPSHOT, ADRES_SNAPSHOT, GPS_ENLEM, GPS_BOYLAM, UYARI_METNI) ' +
      'VALUES (:R, :S, :T, :CK, :PID, :U, :IL, :ILC, :AD, :GE, :GB, :UY)';
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
      qExec.ParamByName('GE').Clear
    else
      qExec.ParamByName('GE').AsFloat := It.GpsE;
    if Abs(It.GpsB) < 1E-9 then
      qExec.ParamByName('GB').Clear
    else
      qExec.ParamByName('GB').AsFloat := It.GpsB;
    qExec.ParamByName('UY').AsString := It.Uyari;
    qExec.Execute;
  end;
end;

procedure TfrmCrmRotaPlan.UniFormShow(Sender: TObject);
begin
  if cbDurum.Items.Count = 0 then
  begin
    cbDurum.Items.Add('TASLAK');
    cbDurum.Items.Add('ONAYLI');
    cbDurum.Items.Add('IPTAL');
  end;
  FRotaId := StrToInt64Def(Trim(Hint), 0);
  if FRotaId > 0 then
    YukleKayit
  else
    YeniKayit;
end;

procedure TfrmCrmRotaPlan.btnKaydetClick(Sender: TObject);
var
  Durum: string;
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
    UniMainModule.saHata.Show('Baslik zorunlu.');
    Exit;
  end;
  if (cbDurum.ItemIndex < 0) or (cbDurum.ItemIndex > 2) then
    Durum := 'TASLAK'
  else
    Durum := cbDurum.Items[cbDurum.ItemIndex];
  HesaplaTumUyari;

  if FRotaId > 0 then
  begin
    qExec.Close;
    qExec.SQL.Text :=
      'UPDATE dbo.CRM_ROTA_PLAN SET BASLIK = :BAS, DETAY = :DET, PLANLAMA_TARIHI = :PT, DURUM = :DUR, ' +
      'BASLANGIC_ENLEM = :LA1, BASLANGIC_BOYLAM = :LN1, BITIS_ENLEM = :LA2, BITIS_BOYLAM = :LN2, ' +
      'ESIK_KM = :ESK, GUNCELLEME_UTC = SYSUTCDATETIME() WHERE ROTA_ID = :ID';
    qExec.ParamByName('ID').AsLargeInt := FRotaId;
    qExec.ParamByName('BAS').AsString := Trim(edBaslik.Text);
    qExec.ParamByName('DET').AsString := mmDetay.Text;
    qExec.ParamByName('PT').AsDate := DateOf(dtPlan.DateTime);
    qExec.ParamByName('DUR').AsString := Durum;
    qExec.ParamByName('ESK').AsInteger := EsikKm;
    BindGeo;
    qExec.Execute;
    PersistDuraklar;
    GridYenile;
  end
  else
  begin
    qExec.Close;
    qExec.SQL.Text :=
      'INSERT INTO dbo.CRM_ROTA_PLAN (BASLIK, DETAY, PLANLAMA_TARIHI, DURUM, BASLANGIC_ENLEM, BASLANGIC_BOYLAM, ' +
      'BITIS_ENLEM, BITIS_BOYLAM, ESIK_KM, OLUSTURAN_KULLANICI_ID) OUTPUT INSERTED.ROTA_ID AS RID VALUES (' +
      ':BAS, :DET, :PT, :DUR, :LA1, :LN1, :LA2, :LN2, :ESK, :KUL)';
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
      Hint := IntToStr(FRotaId);
      YukleKayit;
    end;
  end;
  UniMainModule.saKaydet.Show('Kaydedildi.');
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
var
  PotForm: TfrmCrmPotansiyelListe;
begin
  { frmCrmHaritaSec / frmCrmCariSec ile ayni: UniMainModule GetFormInstance + ShowModal.
    Create(UniApplication) bu projede modalin acilmamasina yol acabiliyor. }
  PotForm := frmCrmPotansiyelListe;
  { Menuden acilan liste Create ile baska instance; callback + kaynak yalnizca bu modal liste. }
  UniMainModule.CrmPotListeSecimKaynakListe := PotForm;
  UniMainModule.CrmPotListeSecimCallback := PotSecildi;
  PotForm.SecimToolbarYenile;
  PotForm.BorderStyle := bsDialog;
  PotForm.BorderIcons := [biSystemMenu];
  try
    PotForm.btnListeleClick(nil);
    PotForm.ShowModal;
  finally
    UniMainModule.CrmPotListeSecimCallback := nil;
    UniMainModule.CrmPotListeSecimKaynakListe := nil;
    PotForm.OnPotansiyelSecildi := nil;
    PotForm.BorderStyle := bsNone;
    PotForm.BorderIcons := [];
    PotForm.SecimToolbarYenile;
  end;
end;

procedure TfrmCrmRotaPlan.btnDurakSilClick(Sender: TObject);
var
  Sr: Integer;
  I, J: Integer;
begin
  if not qGrid.Active or qGrid.IsEmpty then
  begin
    UniMainModule.saHata.Show('Once durak secin.');
    Exit;
  end;
  Sr := qGrid.FieldByName('SIRA').AsInteger;
  for I := FDuraklar.Count - 1 downto 0 do
    if TRotaDurakItem(FDuraklar[I]).Sira = Sr then
    begin
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

function TfrmCrmRotaPlan.HaritaNoktaListesiJson: string;
var
  SL: TStringList;
  La, Ln: Double;
  I, J: Integer;
  It: TRotaDurakItem;
  FS: TFormatSettings;

  procedure Ekle(const ALa, ALn: Double);
  begin
    if (Abs(ALa) < 1E-7) or (Abs(ALn) < 1E-7) then
      Exit;
    SL.Add('{lat:' + FormatFloat('0.######', ALa, FS) + ',lng:' + FormatFloat('0.######', ALn, FS) + '}');
  end;

begin
  FS := TFormatSettings.Invariant;
  SL := TStringList.Create;
  try
    Ekle(BasLat, BasLng);
    for I := 0 to FDuraklar.Count - 1 do
    begin
      It := TRotaDurakItem(FDuraklar[I]);
      Ekle(It.GpsE, It.GpsB);
    end;
    Ekle(BitLat, BitLng);
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
    UniMainModule.saHata.Show('Harita icin en az iki gecerli koordinat gerekir (baslangic, durak veya bitis).');
    Exit;
  end;
  Key := Trim(CrmGoogleMapsBrowserApiKey);
  if (Key = '') or SameText(Key, 'YOUR_BROWSER_KEY_HERE') then
  begin
    UniMainModule.saHata.Show('Google Maps anahtari CrmMapsConfigU icinde tanimlanmali.');
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
    'function initMap(){'#10 +
    'var map = new google.maps.Map(document.getElementById("map"), { zoom: 6, center: routePts[0] });'#10 +
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
