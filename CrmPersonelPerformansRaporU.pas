unit CrmPersonelPerformansRaporU;

{ CRM personel performans: gorev tamamlanma + SIPARIS_BASLIK teklif durumu. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniButton, uniDateTimePicker, uniBasicGrid, uniDBGrid, uniComboBox,
  Data.DB, MemDS, DBAccess, Uni, uniPageControl, uniMultiItem;

type
  TfrmCrmPersonelPerformansRapor = class(TUniForm)
    rootPanel: TUniPanel;
    panTop: TUniPanel;
    lblBas: TUniLabel;
    dtBas: TUniDateTimePicker;
    lblBit: TUniLabel;
    dtBit: TUniDateTimePicker;
    lblPersonel: TUniLabel;
    cbPersonel: TUniComboBox;
    btnGetir: TUniButton;
    btnKapat: TUniButton;
    pgc: TUniPageControl;
    tsGorevOzet: TUniTabSheet;
    tsGorevDetay: TUniTabSheet;
    tsTeklifOzet: TUniTabSheet;
    tsTeklifDetay: TUniTabSheet;
    grdGorevOzet: TUniDBGrid;
    grdGorevDetay: TUniDBGrid;
    grdTeklifOzet: TUniDBGrid;
    grdTeklifDetay: TUniDBGrid;
    qGorevOzet: TUniQuery;
    dsGorevOzet: TUniDataSource;
    qGorevDetay: TUniQuery;
    dsGorevDetay: TUniDataSource;
    qTeklifOzet: TUniQuery;
    dsTeklifOzet: TUniDataSource;
    qTeklifDetay: TUniQuery;
    dsTeklifDetay: TUniDataSource;
    qExec: TUniQuery;
    procedure UniFormShow(Sender: TObject);
    procedure btnGetirClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
  private
    function FiltreKulId: Integer;
    function GorevYetkiSql: string;
    function TeklifYetkiSql: string;
    procedure PersonelComboDoldur;
    procedure RaporuYukle;
  public
  end;

function frmCrmPersonelPerformansRapor: TfrmCrmPersonelPerformansRapor;

implementation

{$R *.dfm}

uses
  System.DateUtils,
  uniGUIApplication, MainModule, DMU, Main, Genel, TmpU;

function frmCrmPersonelPerformansRapor: TfrmCrmPersonelPerformansRapor;
begin
  Result := TfrmCrmPersonelPerformansRapor(UniMainModule.GetFormInstance(TfrmCrmPersonelPerformansRapor));
end;

function TfrmCrmPersonelPerformansRapor.FiltreKulId: Integer;
begin
  if Tmp.xKullaniciAdmin <> 1 then
    Result := Tmp.xKullaniciID
  else if cbPersonel.ItemIndex <= 0 then
    Result := 0
  else
    Result := Integer(cbPersonel.Items.Objects[cbPersonel.ItemIndex]);
end;

function TfrmCrmPersonelPerformansRapor.GorevYetkiSql: string;
begin
  Result := '';
  if Tmp.xKullaniciAdmin <> 1 then
    Result := Result + ' AND G.ATANAN_KULLANICI_ID = :KUL ';
  if FiltreKulId > 0 then
    Result := Result + ' AND G.ATANAN_KULLANICI_ID = :PKUL ';
end;

function TfrmCrmPersonelPerformansRapor.TeklifYetkiSql: string;
begin
  Result := '';
  if Tmp.xKullaniciAdmin <> 1 then
    Result := Result +
      ' AND ((A.TIP = ''TASK'' AND EXISTS (SELECT 1 FROM dbo.CRM_GOREV GX WHERE GX.AKTIVITE_ID = A.AKTIVITE_ID AND GX.ATANAN_KULLANICI_ID = :KUL)) ' +
      'OR (A.TIP <> ''TASK'' AND A.OLUSTURAN_KULLANICI_ID = :KUL)) ';
  if FiltreKulId > 0 then
    Result := Result +
      ' AND ((A.TIP = ''TASK'' AND EXISTS (SELECT 1 FROM dbo.CRM_GOREV GX WHERE GX.AKTIVITE_ID = A.AKTIVITE_ID AND GX.ATANAN_KULLANICI_ID = :PKUL)) ' +
      'OR (A.TIP <> ''TASK'' AND A.OLUSTURAN_KULLANICI_ID = :PKUL)) ';
end;

procedure TfrmCrmPersonelPerformansRapor.PersonelComboDoldur;
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

procedure TfrmCrmPersonelPerformansRapor.RaporuYukle;
var
  Bas, Bit: TDateTime;
  SqlCore, SqlOzet: string;
  Pkul: Integer;
  NeedKul, NeedPkul: Boolean;
begin
  Bas := Trunc(dtBas.DateTime);
  Bit := Trunc(dtBit.DateTime) + 1;
  Pkul := FiltreKulId;
  NeedKul := Tmp.xKullaniciAdmin <> 1;
  NeedPkul := Pkul > 0;

  SqlCore :=
    'SELECT ISNULL(K.KullaniciAd, CONVERT(varchar(20), G.ATANAN_KULLANICI_ID)) AS PERSONEL, ' +
    'COUNT(*) AS TOPLAM, ' +
    'SUM(CASE WHEN (G.TAMAMLANDI = 1 OR ISNULL(D.KAPANIS_MI, 0) = 1) THEN 1 ELSE 0 END) AS TAMAMLANAN, ' +
    'SUM(CASE WHEN (G.TAMAMLANDI = 0 AND ISNULL(D.KAPANIS_MI, 0) = 0) THEN 1 ELSE 0 END) AS ACIK, ' +
    'SUM(CASE WHEN (G.TAMAMLANDI = 0 AND ISNULL(D.KAPANIS_MI, 0) = 0) AND G.BITIS_TARIHI < CAST(GETDATE() AS date) THEN 1 ELSE 0 END) AS GECIKEN ' +
    'FROM dbo.CRM_GOREV G ' +
    'INNER JOIN dbo.CRM_AKTIVITE A ON A.AKTIVITE_ID = G.AKTIVITE_ID ' +
    'LEFT JOIN dbo.CRM_AKTIVITE_DURUM D ON D.DURUM_ID = A.AKTIVITE_DURUM_ID ' +
    'LEFT JOIN dbo.Kullanici K ON K.KullaniciID = G.ATANAN_KULLANICI_ID ' +
    'WHERE G.BITIS_TARIHI >= :BAS AND G.BITIS_TARIHI < :BIT ' + GorevYetkiSql +
    'GROUP BY ISNULL(K.KullaniciAd, CONVERT(varchar(20), G.ATANAN_KULLANICI_ID)) ' +
    'ORDER BY PERSONEL';

  qGorevOzet.Close;
  qGorevOzet.SQL.Text := SqlCore;
  qGorevOzet.ParamByName('BAS').AsDateTime := Bas;
  qGorevOzet.ParamByName('BIT').AsDateTime := Bit;
  if NeedKul then
    qGorevOzet.ParamByName('KUL').AsInteger := Tmp.xKullaniciID;
  if NeedPkul then
    qGorevOzet.ParamByName('PKUL').AsInteger := Pkul;
  qGorevOzet.Open;

  qGorevDetay.Close;
  qGorevDetay.SQL.Text :=
    'SELECT G.GOREV_ID, A.AKTIVITE_ID, A.KONU, ISNULL(K.KullaniciAd, '''') AS ATANAN, ' +
    'CONVERT(varchar(16), G.BITIS_TARIHI, 120) AS PLAN_TARIHI, ' +
    'CASE WHEN (G.TAMAMLANDI = 1 OR ISNULL(D.KAPANIS_MI, 0) = 1) THEN N''Tamamland' + #$0131 + ''' ELSE N''A' + #$00E7 + #$0131 + 'k'' END AS DURUM, ' +
    'CASE WHEN (G.TAMAMLANDI = 0 AND ISNULL(D.KAPANIS_MI, 0) = 0) AND G.BITIS_TARIHI < CAST(GETDATE() AS date) ' +
    'THEN DATEDIFF(day, CAST(G.BITIS_TARIHI AS date), CAST(GETDATE() AS date)) ELSE 0 END AS GECIKME_GUN ' +
    'FROM dbo.CRM_GOREV G ' +
    'INNER JOIN dbo.CRM_AKTIVITE A ON A.AKTIVITE_ID = G.AKTIVITE_ID ' +
    'LEFT JOIN dbo.CRM_AKTIVITE_DURUM D ON D.DURUM_ID = A.AKTIVITE_DURUM_ID ' +
    'LEFT JOIN dbo.Kullanici K ON K.KullaniciID = G.ATANAN_KULLANICI_ID ' +
    'WHERE G.BITIS_TARIHI >= :BAS AND G.BITIS_TARIHI < :BIT ' + GorevYetkiSql +
    'ORDER BY G.BITIS_TARIHI DESC, G.GOREV_ID DESC';
  qGorevDetay.ParamByName('BAS').AsDateTime := Bas;
  qGorevDetay.ParamByName('BIT').AsDateTime := Bit;
  if NeedKul then
    qGorevDetay.ParamByName('KUL').AsInteger := Tmp.xKullaniciID;
  if NeedPkul then
    qGorevDetay.ParamByName('PKUL').AsInteger := Pkul;
  qGorevDetay.Open;

  SqlCore :=
    'SELECT A.AKTIVITE_ID, A.TIP, A.KONU, A.CARI_KOD, A.TEKLIF_FISNO, ' +
    'CASE WHEN A.TIP = ''TASK'' THEN ISNULL(KG.KullaniciAd, '''') ELSE ISNULL(KO.KullaniciAd, '''') END AS PERSONEL, ' +
    'CASE ' +
    'WHEN A.TEKLIF_FISNO IS NULL OR LTRIM(RTRIM(A.TEKLIF_FISNO)) = '''' THEN N''Ba' + #$011F + 'l' + #$0131 + ' de' + #$011F + 'il'' ' +
    'WHEN SB.FisNo IS NULL THEN N''Fis bulunamad' + #$0131 + ''' ' +
    'WHEN ISNULL(SB.AcikKapali, 0) = 1 THEN N''Kapal' + #$0131 + ''' ' +
    'WHEN ISNULL(SB.NetsisSiparisNo, '''') <> '''' THEN N''Sipari' + #$015F + 'e d' + #$00F6 + 'n' + #$00FC + #351 + 'm' + #$00FC + #351 + ''' ' +
    'ELSE N''A' + #$00E7 + #$0131 + 'k teklif'' END AS TEKLIF_DURUM, ' +
    'CONVERT(varchar(10), SB.Tarih, 104) AS TEKLIF_TARIH ' +
    'FROM dbo.CRM_AKTIVITE A ' +
    'LEFT JOIN dbo.SIPARIS_BASLIK SB WITH(NOLOCK) ON SB.FisNo = A.TEKLIF_FISNO ' +
    'LEFT JOIN dbo.CRM_GOREV G ON G.AKTIVITE_ID = A.AKTIVITE_ID ' +
    'LEFT JOIN dbo.Kullanici KG ON KG.KullaniciID = G.ATANAN_KULLANICI_ID ' +
    'LEFT JOIN dbo.Kullanici KO ON KO.KullaniciID = A.OLUSTURAN_KULLANICI_ID ' +
    'WHERE A.TEKLIF_FISNO IS NOT NULL AND LTRIM(RTRIM(A.TEKLIF_FISNO)) <> '''' ' +
    'AND A.AKTIVITE_TARIHI >= :BAS AND A.AKTIVITE_TARIHI < :BIT ' + TeklifYetkiSql;

  qTeklifDetay.Close;
  qTeklifDetay.SQL.Text := SqlCore + ' ORDER BY A.AKTIVITE_TARIHI DESC, A.AKTIVITE_ID DESC';
  qTeklifDetay.ParamByName('BAS').AsDateTime := Bas;
  qTeklifDetay.ParamByName('BIT').AsDateTime := Bit;
  if NeedKul then
    qTeklifDetay.ParamByName('KUL').AsInteger := Tmp.xKullaniciID;
  if NeedPkul then
    qTeklifDetay.ParamByName('PKUL').AsInteger := Pkul;
  qTeklifDetay.Open;

  SqlOzet :=
    'SELECT TEKLIF_DURUM, COUNT(*) AS ADET FROM (' + SqlCore + ') Z GROUP BY TEKLIF_DURUM ORDER BY ADET DESC';
  qTeklifOzet.Close;
  qTeklifOzet.SQL.Text := SqlOzet;
  qTeklifOzet.ParamByName('BAS').AsDateTime := Bas;
  qTeklifOzet.ParamByName('BIT').AsDateTime := Bit;
  if NeedKul then
    qTeklifOzet.ParamByName('KUL').AsInteger := Tmp.xKullaniciID;
  if NeedPkul then
    qTeklifOzet.ParamByName('PKUL').AsInteger := Pkul;
  qTeklifOzet.Open;
end;

procedure TfrmCrmPersonelPerformansRapor.UniFormShow(Sender: TObject);
begin
  Caption := 'CRM - Personel Performans Raporu';
  dtBas.DateTime := Trunc(StartOfTheMonth(Now));
  dtBit.DateTime := Trunc(EndOfTheMonth(Now));
  PersonelComboDoldur;
  lblPersonel.Visible := Tmp.xKullaniciAdmin = 1;
  cbPersonel.Visible := Tmp.xKullaniciAdmin = 1;
  btnGetirClick(Sender);
end;

procedure TfrmCrmPersonelPerformansRapor.btnGetirClick(Sender: TObject);
begin
  RaporuYukle;
end;

procedure TfrmCrmPersonelPerformansRapor.btnKapatClick(Sender: TObject);
begin
  MainForm.NavPage.ActivePage.Close;
end;

end.
