unit CrmKontrolRaporU;

{ CRM Aktivite Kontrol Listesi raporu:
  - Detay: aktivite/personel/set/soru/cevap
  - Özet: soru bazinda cevap dagilimi (Evet/Hayir, ortalama puan) }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniButton, uniDateTimePicker, uniDBLookupComboBox, uniBasicGrid, uniDBGrid,
  Data.DB, MemDS, DBAccess, Uni, uniPageControl;

type
  TfrmCrmKontrolRapor = class(TUniForm)
    rootPanel: TUniPanel;
    panTop: TUniPanel;
    lblTip: TUniLabel;
    lkTip: TUniDBLookupComboBox;
    lblSet: TUniLabel;
    lkSet: TUniDBLookupComboBox;
    lblBas: TUniLabel;
    dtBas: TUniDateTimePicker;
    lblBit: TUniLabel;
    dtBit: TUniDateTimePicker;
    btnGetir: TUniButton;
    btnKapat: TUniButton;
    pgc: TUniPageControl;
    tsDetay: TUniTabSheet;
    tsOzet: TUniTabSheet;
    grdDetay: TUniDBGrid;
    grdOzet: TUniDBGrid;
    qTipLkp: TUniQuery;
    dsTipLkp: TUniDataSource;
    qSetLkp: TUniQuery;
    dsSetLkp: TUniDataSource;
    qDetay: TUniQuery;
    dsDetay: TUniDataSource;
    qOzet: TUniQuery;
    dsOzet: TUniDataSource;
    procedure UniFormShow(Sender: TObject);
    procedure btnGetirClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
  private
    function FiltreTipId: Int64;
    function FiltreSetId: Int64;
  public
  end;

function frmCrmKontrolRapor: TfrmCrmKontrolRapor;

implementation

{$R *.dfm}

uses
  uniGUIApplication, MainModule, DMU, Main, TmpU, Genel;

function frmCrmKontrolRapor: TfrmCrmKontrolRapor;
begin
  Result := TfrmCrmKontrolRapor(UniMainModule.GetFormInstance(TfrmCrmKontrolRapor));
end;

function TfrmCrmKontrolRapor.FiltreTipId: Int64;
begin
  if VarIsNull(lkTip.KeyValue) or VarIsEmpty(lkTip.KeyValue) then
    Result := 0
  else
    Result := lkTip.KeyValue;
end;

function TfrmCrmKontrolRapor.FiltreSetId: Int64;
begin
  if VarIsNull(lkSet.KeyValue) or VarIsEmpty(lkSet.KeyValue) then
    Result := 0
  else
    Result := lkSet.KeyValue;
end;

procedure TfrmCrmKontrolRapor.UniFormShow(Sender: TObject);
begin
  Caption := 'CRM - Kontrol Listesi Raporu';
  qTipLkp.Close;
  qTipLkp.SQL.Text :=
    'SELECT TIP_ID, (KOD + N'' - '' + ISNULL(ACIKLAMA, N'''')) AS AD ' +
    'FROM dbo.CRM_AKTIVITE_TIP WHERE AKTIF = 1 ORDER BY SIRA, TIP_ID';
  qTipLkp.Open;

  qSetLkp.Close;
  qSetLkp.SQL.Text :=
    'SELECT SET_ID, BASLIK AS AD FROM dbo.CRM_SORU_SETI ORDER BY SIRA, SET_ID';
  qSetLkp.Open;

  dtBas.DateTime := Trunc(Now) - 30;
  dtBit.DateTime := Trunc(Now);
  lkTip.KeyValue := Null;
  lkSet.KeyValue := Null;
  btnGetirClick(Sender);
end;

procedure TfrmCrmKontrolRapor.btnGetirClick(Sender: TObject);
var
  Bas, Bit: TDateTime;
begin
  Bas := Trunc(dtBas.DateTime);
  Bit := Trunc(dtBit.DateTime) + 1;

  qDetay.Close;
  qDetay.SQL.Text :=
    'SELECT A.AKTIVITE_ID, CASE WHEN A.TIP = ''TASK'' THEN N''G' + #$00F6 + 'rev'' ELSE N''Aktivite'' END AS KAYNAK, ' +
    'CONVERT(varchar(16), A.AKTIVITE_TARIHI, 120) AS TARIH, A.KONU, ' +
    'ISNULL(KU.KullaniciAd, CONVERT(varchar(20), CV.CEVAPLAYAN_KULLANICI_ID)) AS PERSONEL, ' +
    'S.BASLIK AS SET_BASLIK, CV.SORU_METNI_KOPYA AS SORU, ' +
    'CASE CV.CEVAP_TIPI ' +
    'WHEN ''EVET_HAYIR'' THEN CASE WHEN CV.CEVAP_BIT = 1 THEN N''Evet'' WHEN CV.CEVAP_BIT = 0 THEN N''Hay'' + NCHAR(305) + N''r'' ELSE N'''' END ' +
    'WHEN ''SAYI'' THEN CONVERT(varchar(40), CV.CEVAP_SAYI) ' +
    'WHEN ''PUAN'' THEN CONVERT(varchar(40), CONVERT(int, CV.CEVAP_SAYI)) ' +
    'WHEN ''TARIH'' THEN CONVERT(varchar(10), CV.CEVAP_TARIH, 104) ' +
    'WHEN ''METIN'' THEN CV.CEVAP_METIN ' +
    'ELSE STUFF((SELECT N'', '' + X.SECENEK_METNI_KOPYA FROM dbo.CRM_AKTIVITE_CEVAP_SECENEK X ' +
    'WHERE X.CEVAP_ID = CV.CEVAP_ID FOR XML PATH(''''), TYPE).value(''.'', ''nvarchar(max)''), 1, 2, N'''') ' +
    'END AS CEVAP ' +
    'FROM dbo.CRM_AKTIVITE_CEVAP CV ' +
    'INNER JOIN dbo.CRM_AKTIVITE A ON A.AKTIVITE_ID = CV.AKTIVITE_ID ' +
    'LEFT JOIN dbo.CRM_SORU_SETI S ON S.SET_ID = CV.SET_ID ' +
    'LEFT JOIN dbo.Kullanici KU ON KU.KullaniciID = CV.CEVAPLAYAN_KULLANICI_ID ' +
    'WHERE A.AKTIVITE_TARIHI >= :BAS AND A.AKTIVITE_TARIHI < :BIT ' +
    'AND ((:TID = 0) OR (A.AKTIVITE_TIP_ID = :TID)) ' +
    'AND ((:SID = 0) OR (CV.SET_ID = :SID)) ' +
    'AND ((:ADM = 1) OR (A.TIP <> ''TASK'' AND A.OLUSTURAN_KULLANICI_ID = :KUL) ' +
    'OR (A.TIP = ''TASK'' AND EXISTS (SELECT 1 FROM dbo.CRM_GOREV GX WHERE GX.AKTIVITE_ID = A.AKTIVITE_ID AND GX.ATANAN_KULLANICI_ID = :KUL)) ' +
    'OR (CV.CEVAPLAYAN_KULLANICI_ID = :KUL)) ' +
    'ORDER BY A.AKTIVITE_TARIHI DESC, A.AKTIVITE_ID, CV.CEVAP_ID';
  qDetay.ParamByName('BAS').AsDateTime := Bas;
  qDetay.ParamByName('BIT').AsDateTime := Bit;
  qDetay.ParamByName('TID').AsLargeInt := FiltreTipId;
  qDetay.ParamByName('SID').AsLargeInt := FiltreSetId;
  qDetay.ParamByName('ADM').AsInteger := Tmp.xKullaniciAdmin;
  qDetay.ParamByName('KUL').AsInteger := Tmp.xKullaniciID;
  qDetay.Open;

  qOzet.Close;
  qOzet.SQL.Text :=
    'SELECT S.BASLIK AS SET_BASLIK, CV.SORU_METNI_KOPYA AS SORU, CV.CEVAP_TIPI, ' +
    'COUNT(*) AS CEVAP_SAYISI, ' +
    'SUM(CASE WHEN CV.CEVAP_BIT = 1 THEN 1 ELSE 0 END) AS EVET, ' +
    'SUM(CASE WHEN CV.CEVAP_BIT = 0 THEN 1 ELSE 0 END) AS HAYIR, ' +
    'AVG(CASE WHEN CV.CEVAP_TIPI = ''PUAN'' THEN CV.CEVAP_SAYI END) AS PUAN_ORT ' +
    'FROM dbo.CRM_AKTIVITE_CEVAP CV ' +
    'INNER JOIN dbo.CRM_AKTIVITE A ON A.AKTIVITE_ID = CV.AKTIVITE_ID ' +
    'LEFT JOIN dbo.CRM_SORU_SETI S ON S.SET_ID = CV.SET_ID ' +
    'WHERE A.AKTIVITE_TARIHI >= :BAS AND A.AKTIVITE_TARIHI < :BIT ' +
    'AND ((:TID = 0) OR (A.AKTIVITE_TIP_ID = :TID)) ' +
    'AND ((:SID = 0) OR (CV.SET_ID = :SID)) ' +
    'AND ((:ADM = 1) OR (A.TIP <> ''TASK'' AND A.OLUSTURAN_KULLANICI_ID = :KUL) ' +
    'OR (A.TIP = ''TASK'' AND EXISTS (SELECT 1 FROM dbo.CRM_GOREV GX WHERE GX.AKTIVITE_ID = A.AKTIVITE_ID AND GX.ATANAN_KULLANICI_ID = :KUL)) ' +
    'OR (CV.CEVAPLAYAN_KULLANICI_ID = :KUL)) ' +
    'GROUP BY S.BASLIK, CV.SORU_METNI_KOPYA, CV.CEVAP_TIPI ' +
    'ORDER BY S.BASLIK, CV.SORU_METNI_KOPYA';
  qOzet.ParamByName('BAS').AsDateTime := Bas;
  qOzet.ParamByName('BIT').AsDateTime := Bit;
  qOzet.ParamByName('TID').AsLargeInt := FiltreTipId;
  qOzet.ParamByName('SID').AsLargeInt := FiltreSetId;
  qOzet.ParamByName('ADM').AsInteger := Tmp.xKullaniciAdmin;
  qOzet.ParamByName('KUL').AsInteger := Tmp.xKullaniciID;
  qOzet.Open;
end;

procedure TfrmCrmKontrolRapor.btnKapatClick(Sender: TObject);
begin
  xNavListeKapat(Self);
end;

end.
