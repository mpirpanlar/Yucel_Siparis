unit CrmRotaKmRaporU;

{ CRM rota yol km raporu: rota/bacak detay, personel/donem ozeti, GPS eksik cari. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniButton, uniDateTimePicker, uniBasicGrid, uniDBGrid, uniComboBox,
  uniEdit, Data.DB, MemDS, DBAccess, Uni, uniPageControl, uniMultiItem;

type
  TfrmCrmRotaKmRapor = class(TUniForm)
    rootPanel: TUniPanel;
    panTop: TUniPanel;
    lblBas: TUniLabel;
    dtBas: TUniDateTimePicker;
    lblBit: TUniLabel;
    dtBit: TUniDateTimePicker;
    lblDurum: TUniLabel;
    cbDurum: TUniComboBox;
    lblPersonel: TUniLabel;
    cbPersonel: TUniComboBox;
    lblGpsMod: TUniLabel;
    cbGpsMod: TUniComboBox;
    lblBaslik: TUniLabel;
    edBaslik: TUniEdit;
    btnGetir: TUniButton;
    btnMesafeGuncelle: TUniButton;
    btnAc: TUniButton;
    btnKapat: TUniButton;
    pgc: TUniPageControl;
    tsRota: TUniTabSheet;
    tsBacak: TUniTabSheet;
    tsOzetPersonel: TUniTabSheet;
    tsOzetDonem: TUniTabSheet;
    tsGpsEksik: TUniTabSheet;
    grdRota: TUniDBGrid;
    grdBacak: TUniDBGrid;
    grdOzetPersonel: TUniDBGrid;
    grdOzetDonem: TUniDBGrid;
    grdGpsEksik: TUniDBGrid;
    qRota: TUniQuery;
    dsRota: TUniDataSource;
    qBacak: TUniQuery;
    dsBacak: TUniDataSource;
    qOzetPersonel: TUniQuery;
    dsOzetPersonel: TUniDataSource;
    qOzetDonem: TUniQuery;
    dsOzetDonem: TUniDataSource;
    qGpsEksik: TUniQuery;
    dsGpsEksik: TUniDataSource;
    qExec: TUniQuery;
    procedure UniFormShow(Sender: TObject);
    procedure btnGetirClick(Sender: TObject);
    procedure btnMesafeGuncelleClick(Sender: TObject);
    procedure btnAcClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
  private
    function FiltreKulId: Integer;
    function FiltreDurum: string;
    function GpsEksikMod: Integer;
    function RotaFiltreSql: string;
    procedure PersonelComboDoldur;
    procedure RaporuYukle;
    procedure GpsEksikCariYukle;
  public
  end;

function frmCrmRotaKmRapor: TfrmCrmRotaKmRapor;

implementation

{$R *.dfm}

uses
  uniGUIApplication, MainModule, DMU, Main, Genel, CrmRotaU, CrmRotaMesafeU;

function frmCrmRotaKmRapor: TfrmCrmRotaKmRapor;
begin
  Result := TfrmCrmRotaKmRapor(UniMainModule.GetFormInstance(TfrmCrmRotaKmRapor));
end;

function TfrmCrmRotaKmRapor.FiltreKulId: Integer;
begin
  if cbPersonel.ItemIndex <= 0 then
    Result := 0
  else
    Result := Integer(cbPersonel.Items.Objects[cbPersonel.ItemIndex]);
end;

function TfrmCrmRotaKmRapor.FiltreDurum: string;
begin
  if cbDurum.ItemIndex <= 0 then
    Result := ''
  else
    Result := cbDurum.Items[cbDurum.ItemIndex];
end;

function TfrmCrmRotaKmRapor.GpsEksikMod: Integer;
begin
  Result := cbGpsMod.ItemIndex;
  if Result < 0 then
    Result := 0;
end;

function TfrmCrmRotaKmRapor.RotaFiltreSql: string;
var
  Bas, Bit: TDateTime;
  KulId: Integer;
  Dur, Baslik: string;
begin
  Bas := Trunc(dtBas.DateTime);
  Bit := Trunc(dtBit.DateTime);
  KulId := FiltreKulId;
  Dur := FiltreDurum;
  Baslik := Trim(edBaslik.Text);
  Result :=
    ' FROM dbo.CRM_ROTA_PLAN R ' +
    'LEFT JOIN dbo.Kullanici KO ON KO.KullaniciID = R.OLUSTURAN_KULLANICI_ID ' +
    'WHERE R.PLANLAMA_TARIHI >= :TAR_BAS AND R.PLANLAMA_TARIHI <= :TAR_BIT ';
  if Dur <> '' then
    Result := Result + ' AND R.DURUM = :DUR ';
  if KulId > 0 then
    Result := Result +
      ' AND (R.OLUSTURAN_KULLANICI_ID = :KUL OR EXISTS (SELECT 1 FROM dbo.CRM_ROTA_PLAN_PERSONEL RP ' +
      'WHERE RP.ROTA_ID = R.ROTA_ID AND RP.KULLANICI_ID = :KUL)) ';
  if Baslik <> '' then
    Result := Result + ' AND R.BASLIK LIKE :BASLIK ';
end;

procedure TfrmCrmRotaKmRapor.PersonelComboDoldur;
begin
  cbPersonel.Items.Clear;
  cbPersonel.Items.AddObject('(T'#252'm'#252')', TObject(0));
  qExec.Close;
  qExec.SQL.Text := 'SELECT KullaniciID, KullaniciAd FROM dbo.Kullanici ORDER BY KullaniciAd';
  qExec.Open;
  while not qExec.Eof do
  begin
    cbPersonel.Items.AddObject(qExec.FieldByName('KullaniciAd').AsString,
      TObject(qExec.FieldByName('KullaniciID').AsInteger));
    qExec.Next;
  end;
  cbPersonel.ItemIndex := 0;
end;

procedure TfrmCrmRotaKmRapor.UniFormShow(Sender: TObject);
begin
  Caption := 'CRM - Rota Km Raporu';
  if cbDurum.Items.Count = 0 then
  begin
    cbDurum.Items.Add('(T'#252'm'#252')');
    cbDurum.Items.Add('TASLAK');
    cbDurum.Items.Add('ONAYLI');
    cbDurum.Items.Add('IPTAL');
    cbDurum.ItemIndex := 0;
  end;
  if cbGpsMod.Items.Count = 0 then
  begin
    cbGpsMod.Items.Add('0 km + uyar'#305' (eksik bacak)');
    cbGpsMod.Items.Add('Toplamdan hari'#231' tut');
    cbGpsMod.ItemIndex := 0;
  end;
  dtBas.DateTime := Trunc(Now) - 30;
  dtBit.DateTime := Trunc(Now);
  PersonelComboDoldur;
  btnGetirClick(Sender);
end;

procedure TfrmCrmRotaKmRapor.RaporuYukle;
var
  Bas, Bit: TDateTime;
  KulId: Integer;
  Dur, Baslik, SqlCore: string;
begin
  Bas := Trunc(dtBas.DateTime);
  Bit := Trunc(dtBit.DateTime);
  KulId := FiltreKulId;
  Dur := FiltreDurum;
  Baslik := Trim(edBaslik.Text);
  SqlCore := RotaFiltreSql;

  qRota.Close;
  qRota.SQL.Text :=
    'SELECT R.ROTA_ID, R.BASLIK, R.DURUM, R.PLANLAMA_TARIHI, ' +
    'ISNULL(KO.KullaniciAd, '''') AS OLUSTURAN, ' +
    'CAST(ISNULL((SELECT STUFF((SELECT '', '' + RTRIM(K.KullaniciAd) FROM dbo.CRM_ROTA_PLAN_PERSONEL RP ' +
    'INNER JOIN dbo.Kullanici K ON K.KullaniciID = RP.KULLANICI_ID WHERE RP.ROTA_ID = R.ROTA_ID ' +
    'ORDER BY K.KullaniciAd FOR XML PATH('''')), 1, 2, '''')), '''') AS NVARCHAR(500)) AS ATANAN_PERSONEL, ' +
    '(SELECT COUNT(*) FROM dbo.CRM_ROTA_PLAN_DURAK D WHERE D.ROTA_ID = R.ROTA_ID) AS DURAK_SAY, ' +
    'ISNULL(R.TOPLAM_YOL_KM, 0) AS TOPLAM_KM, ' +
    'CONVERT(varchar(16), R.MESAFE_HESAP_UTC, 120) AS MESAFE_HESAP ' + SqlCore +
    ' ORDER BY R.PLANLAMA_TARIHI DESC, R.ROTA_ID DESC';
  qRota.ParamByName('TAR_BAS').AsDate := Bas;
  qRota.ParamByName('TAR_BIT').AsDate := Bit;
  if Dur <> '' then
    qRota.ParamByName('DUR').AsString := Dur;
  if KulId > 0 then
    qRota.ParamByName('KUL').AsInteger := KulId;
  if Baslik <> '' then
    qRota.ParamByName('BASLIK').AsString := '%' + Baslik + '%';
  qRota.Open;

  qBacak.Close;
  qBacak.SQL.Text :=
    'SELECT R.ROTA_ID, R.BASLIK, D.SIRA, D.UNVAN_SNAPSHOT AS DURAK, D.IL_SNAPSHOT AS IL, ' +
    'ISNULL(D.BACAK_KM, 0) AS BACAK_KM, CASE WHEN D.GPS_EKSIK = 1 THEN N''Evet'' ELSE N'''' END AS GPS_EKSIK ' +
    'FROM dbo.CRM_ROTA_PLAN R INNER JOIN dbo.CRM_ROTA_PLAN_DURAK D ON D.ROTA_ID = R.ROTA_ID ' +
    'WHERE R.PLANLAMA_TARIHI >= :TAR_BAS AND R.PLANLAMA_TARIHI <= :TAR_BIT ';
  if Dur <> '' then
    qBacak.SQL.Text := qBacak.SQL.Text + ' AND R.DURUM = :DUR ';
  if KulId > 0 then
    qBacak.SQL.Text := qBacak.SQL.Text +
      ' AND (R.OLUSTURAN_KULLANICI_ID = :KUL OR EXISTS (SELECT 1 FROM dbo.CRM_ROTA_PLAN_PERSONEL RP ' +
      'WHERE RP.ROTA_ID = R.ROTA_ID AND RP.KULLANICI_ID = :KUL)) ';
  if Baslik <> '' then
    qBacak.SQL.Text := qBacak.SQL.Text + ' AND R.BASLIK LIKE :BASLIK ';
  qBacak.SQL.Text := qBacak.SQL.Text + ' ORDER BY R.ROTA_ID DESC, D.SIRA';
  qBacak.ParamByName('TAR_BAS').AsDate := Bas;
  qBacak.ParamByName('TAR_BIT').AsDate := Bit;
  if Dur <> '' then
    qBacak.ParamByName('DUR').AsString := Dur;
  if KulId > 0 then
    qBacak.ParamByName('KUL').AsInteger := KulId;
  if Baslik <> '' then
    qBacak.ParamByName('BASLIK').AsString := '%' + Baslik + '%';
  qBacak.Open;

  qOzetPersonel.Close;
  qOzetPersonel.SQL.Text :=
    'SELECT PERSONEL, COUNT(DISTINCT ROTA_ID) AS ROTA_SAY, SUM(TOPLAM_KM) AS TOPLAM_KM, ' +
    'CASE WHEN COUNT(DISTINCT ROTA_ID) > 0 THEN SUM(TOPLAM_KM) / COUNT(DISTINCT ROTA_ID) ELSE 0 END AS ORT_KM ' +
    'FROM (' +
    'SELECT R.ROTA_ID, ISNULL(KO.KullaniciAd, N''(Bilinmiyor)'') AS PERSONEL, ISNULL(R.TOPLAM_YOL_KM, 0) AS TOPLAM_KM ' +
    'FROM dbo.CRM_ROTA_PLAN R LEFT JOIN dbo.Kullanici KO ON KO.KullaniciID = R.OLUSTURAN_KULLANICI_ID ' +
    'WHERE R.PLANLAMA_TARIHI >= :TAR_BAS AND R.PLANLAMA_TARIHI <= :TAR_BIT ';
  if Dur <> '' then
    qOzetPersonel.SQL.Text := qOzetPersonel.SQL.Text + ' AND R.DURUM = :DUR ';
  if KulId > 0 then
    qOzetPersonel.SQL.Text := qOzetPersonel.SQL.Text +
      ' AND (R.OLUSTURAN_KULLANICI_ID = :KUL OR EXISTS (SELECT 1 FROM dbo.CRM_ROTA_PLAN_PERSONEL RP ' +
      'WHERE RP.ROTA_ID = R.ROTA_ID AND RP.KULLANICI_ID = :KUL)) ';
  if Baslik <> '' then
    qOzetPersonel.SQL.Text := qOzetPersonel.SQL.Text + ' AND R.BASLIK LIKE :BASLIK ';
  qOzetPersonel.SQL.Text := qOzetPersonel.SQL.Text +
    'UNION ALL ' +
    'SELECT R.ROTA_ID, K.KullaniciAd AS PERSONEL, ISNULL(R.TOPLAM_YOL_KM, 0) AS TOPLAM_KM ' +
    'FROM dbo.CRM_ROTA_PLAN R ' +
    'INNER JOIN dbo.CRM_ROTA_PLAN_PERSONEL RP ON RP.ROTA_ID = R.ROTA_ID ' +
    'INNER JOIN dbo.Kullanici K ON K.KullaniciID = RP.KULLANICI_ID ' +
    'WHERE R.PLANLAMA_TARIHI >= :TAR_BAS AND R.PLANLAMA_TARIHI <= :TAR_BIT ';
  if Dur <> '' then
    qOzetPersonel.SQL.Text := qOzetPersonel.SQL.Text + ' AND R.DURUM = :DUR ';
  if KulId > 0 then
    qOzetPersonel.SQL.Text := qOzetPersonel.SQL.Text +
      ' AND (R.OLUSTURAN_KULLANICI_ID = :KUL OR RP.KULLANICI_ID = :KUL) ';
  if Baslik <> '' then
    qOzetPersonel.SQL.Text := qOzetPersonel.SQL.Text + ' AND R.BASLIK LIKE :BASLIK ';
  qOzetPersonel.SQL.Text := qOzetPersonel.SQL.Text +
    ') X GROUP BY PERSONEL ORDER BY PERSONEL';
  qOzetPersonel.ParamByName('TAR_BAS').AsDate := Bas;
  qOzetPersonel.ParamByName('TAR_BIT').AsDate := Bit;
  if Dur <> '' then
    qOzetPersonel.ParamByName('DUR').AsString := Dur;
  if KulId > 0 then
    qOzetPersonel.ParamByName('KUL').AsInteger := KulId;
  if Baslik <> '' then
    qOzetPersonel.ParamByName('BASLIK').AsString := '%' + Baslik + '%';
  qOzetPersonel.Open;

  qOzetDonem.Close;
  qOzetDonem.SQL.Text :=
    'SELECT CONVERT(varchar(7), R.PLANLAMA_TARIHI, 120) AS DONEM, COUNT(*) AS ROTA_SAY, ' +
    'SUM(ISNULL(R.TOPLAM_YOL_KM, 0)) AS TOPLAM_KM ' + SqlCore +
    ' GROUP BY CONVERT(varchar(7), R.PLANLAMA_TARIHI, 120) ORDER BY DONEM';
  qOzetDonem.ParamByName('TAR_BAS').AsDate := Bas;
  qOzetDonem.ParamByName('TAR_BIT').AsDate := Bit;
  if Dur <> '' then
    qOzetDonem.ParamByName('DUR').AsString := Dur;
  if KulId > 0 then
    qOzetDonem.ParamByName('KUL').AsInteger := KulId;
  if Baslik <> '' then
    qOzetDonem.ParamByName('BASLIK').AsString := '%' + Baslik + '%';
  qOzetDonem.Open;

  GpsEksikCariYukle;
end;

procedure TfrmCrmRotaKmRapor.GpsEksikCariYukle;
begin
  qGpsEksik.Close;
  qGpsEksik.Connection := frmDM.conNetsis;
  qGpsEksik.SQL.Text :=
    'SELECT C.CARI_KOD, C.CARI_ISIM, C.CARI_IL, C.CARI_ILCE, ' +
    'T.KULL1N AS GPS_X, T.KULL2N AS GPS_Y ' +
    'FROM TBLCASABIT C WITH(NOLOCK) ' +
    'LEFT JOIN TBLCASABITEK T WITH(NOLOCK) ON T.CARI_KOD = C.CARI_KOD ' +
    'WHERE T.KULL1N IS NULL OR T.KULL1N = 0 OR T.KULL2N IS NULL OR T.KULL2N = 0 ' +
    'ORDER BY C.CARI_KOD';
  try
    if not frmDM.conNetsis.Connected then
      Genel.xUnidacBaglanNetsis;
    qGpsEksik.Open;
  except
    on E: Exception do
    begin
      qGpsEksik.Close;
      qGpsEksik.SQL.Text := 'SELECT CAST(NULL AS VARCHAR(50)) AS CARI_KOD WHERE 0 = 1';
      qGpsEksik.Open;
      UniMainModule.saHata.Show('GPS eksik cari listesi yuklenemedi (Netsis): '#13#10 + E.Message);
    end;
  end;
end;

procedure TfrmCrmRotaKmRapor.btnGetirClick(Sender: TObject);
begin
  if Trunc(dtBas.DateTime) > Trunc(dtBit.DateTime) then
  begin
    UniMainModule.saHata.Show('Tarih ba'#351'lang'#305#231' biti'#351'ten b'#252'y'#252'k olamaz.');
    Exit;
  end;
  RaporuYukle;
end;

procedure TfrmCrmRotaKmRapor.btnMesafeGuncelleClick(Sender: TObject);
var
  ModIdx: TCrmGpsEksikMod;
  Sonuc: TCrmRotaMesafeSonuc;
  RotaId: Int64;
  N: Integer;
begin
  if not qRota.Active or qRota.IsEmpty then
  begin
    UniMainModule.saHata.Show('#214nce raporu getirin.');
    Exit;
  end;
  if GpsEksikMod = 0 then
    ModIdx := geSifirVeUyari
  else
    ModIdx := geToplamHaric;
  N := 0;
  qRota.First;
  while not qRota.Eof do
  begin
    RotaId := qRota.FieldByName('ROTA_ID').AsLargeInt;
    Sonuc := CrmRotaMesafeDbHesaplaKaydet(frmDM.conAsya, RotaId, ModIdx);
    Inc(N);
    qRota.Next;
  end;
  RaporuYukle;
  if Trim(Sonuc.Hata) <> '' then
    UniMainModule.saKaydet.Show(Format('%d rota g'#252'ncellendi.'#13#10'Not: %s', [N, Sonuc.Hata]))
  else
    UniMainModule.saKaydet.Show(Format('%d rota i'#231'in yol mesafesi g'#252'ncellendi.', [N]));
end;

procedure TfrmCrmRotaKmRapor.btnAcClick(Sender: TObject);
var
  Rid: Int64;
begin
  if not qRota.Active or qRota.IsEmpty then
  begin
    UniMainModule.saHata.Show('#214nce bir rota se'#231'in.');
    Exit;
  end;
  Rid := qRota.FieldByName('ROTA_ID').AsLargeInt;
  if Rid <= 0 then
    Exit;
  xFormShow(TfrmCrmRotaPlan, 'CrmRotaPlan', 1, IntToStr(Rid));
end;

procedure TfrmCrmRotaKmRapor.btnKapatClick(Sender: TObject);
begin
  xNavListeKapat(Self);
end;

end.
