unit CrmAktiviteRaporU;

{ CRM aktivite / gorev durum raporu: plan vs tamamlanma, geciken, yapilmayanlar. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniButton, uniDateTimePicker, uniDBLookupComboBox, uniBasicGrid,
  uniDBGrid, uniComboBox, uniEdit, Data.DB, MemDS, DBAccess, Uni,
  uniPageControl, uniMultiItem;

type
  TfrmCrmAktiviteRapor = class(TUniForm)
    rootPanel: TUniPanel;
    panTop: TUniPanel;
    lblTarihTur: TUniLabel;
    cbTarihTur: TUniComboBox;
    lblBas: TUniLabel;
    dtBas: TUniDateTimePicker;
    lblBit: TUniLabel;
    dtBit: TUniDateTimePicker;
    lblKaynak: TUniLabel;
    cbKaynak: TUniComboBox;
    lblTip: TUniLabel;
    lkTip: TUniDBLookupComboBox;
    lblDurum: TUniLabel;
    lkDurum: TUniDBLookupComboBox;
    lblPersonel: TUniLabel;
    cbPersonel: TUniComboBox;
    lblDurumGrup: TUniLabel;
    cbDurumGrup: TUniComboBox;
    lblCari: TUniLabel;
    edCari: TUniEdit;
    btnGetir: TUniButton;
    btnAc: TUniButton;
    btnKapat: TUniButton;
    pgc: TUniPageControl;
    tsDetay: TUniTabSheet;
    tsOzetDurum: TUniTabSheet;
    tsOzetPersonel: TUniTabSheet;
    tsYapilmayan: TUniTabSheet;
    grdDetay: TUniDBGrid;
    grdOzetDurum: TUniDBGrid;
    grdOzetPersonel: TUniDBGrid;
    grdYapilmayan: TUniDBGrid;
    qTipLkp: TUniQuery;
    dsTipLkp: TUniDataSource;
    qDurLkp: TUniQuery;
    dsDurLkp: TUniDataSource;
    qDetay: TUniQuery;
    dsDetay: TUniDataSource;
    qOzetDurum: TUniQuery;
    dsOzetDurum: TUniDataSource;
    qOzetPersonel: TUniQuery;
    dsOzetPersonel: TUniDataSource;
    qYapilmayan: TUniQuery;
    dsYapilmayan: TUniDataSource;
    procedure UniFormShow(Sender: TObject);
    procedure btnGetirClick(Sender: TObject);
    procedure btnAcClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
  private
    function FiltreTipId: Int64;
    function FiltreDurumId: Int64;
    function DetaySql: string;
    procedure AcKayit;
    procedure RaporuYukle;
  public
  end;

function frmCrmAktiviteRapor: TfrmCrmAktiviteRapor;

implementation

{$R *.dfm}

uses
  System.DateUtils,
  uniGUIApplication, MainModule, DMU, Main, Genel, TmpU, CrmAktiviteU, CrmGorevU;

function frmCrmAktiviteRapor: TfrmCrmAktiviteRapor;
begin
  Result := TfrmCrmAktiviteRapor(UniMainModule.GetFormInstance(TfrmCrmAktiviteRapor));
end;

function TfrmCrmAktiviteRapor.FiltreTipId: Int64;
begin
  if VarIsNull(lkTip.KeyValue) or VarIsEmpty(lkTip.KeyValue) then
    Result := 0
  else
    Result := lkTip.KeyValue;
end;

function TfrmCrmAktiviteRapor.FiltreDurumId: Int64;
begin
  if VarIsNull(lkDurum.KeyValue) or VarIsEmpty(lkDurum.KeyValue) then
    Result := 0
  else
    Result := lkDurum.KeyValue;
end;

function TfrmCrmAktiviteRapor.DetaySql: string;
begin
  Result :=
    'SELECT X.AKTIVITE_ID, X.KAYNAK, X.TIP, X.KONU, X.CARI_KOD, X.OLUSTURAN, X.ATANAN, ' +
    'CONVERT(varchar(16), X.PLAN_TARIHI, 120) AS PLAN_TARIHI, X.DURUM, ' +
    'CONVERT(varchar(16), X.TAMAMLANMA_TARIHI, 120) AS TAMAMLANMA_TARIHI, X.GECIKME_GUN, X.TAMAMLANDI_MI ' +
    'FROM (' +
    'SELECT A.AKTIVITE_ID, N''AKTIVITE'' AS KAYNAK, A.TIP, A.KONU, A.CARI_KOD, ' +
    'ISNULL(KO.KullaniciAd, '''') AS OLUSTURAN, N'''' AS ATANAN, A.AKTIVITE_TARIHI AS PLAN_TARIHI, ' +
    'ISNULL(D.KOD, A.DURUM) AS DURUM, ' +
    'CASE WHEN ISNULL(D.KAPANIS_MI, 0) = 1 THEN ISNULL(A.GUNCELLEME_UTC, A.OLUSTURMA_UTC) END AS TAMAMLANMA_TARIHI, ' +
    'CASE WHEN ISNULL(D.KAPANIS_MI, 0) = 0 AND A.AKTIVITE_TARIHI < CAST(GETDATE() AS date) ' +
    'THEN DATEDIFF(day, CAST(A.AKTIVITE_TARIHI AS date), CAST(GETDATE() AS date)) ELSE 0 END AS GECIKME_GUN, ' +
    'CAST(ISNULL(D.KAPANIS_MI, 0) AS bit) AS TAMAMLANDI_MI, A.OLUSTURAN_KULLANICI_ID, CAST(NULL AS int) AS ATANAN_ID ' +
    'FROM dbo.CRM_AKTIVITE A ' +
    'LEFT JOIN dbo.CRM_AKTIVITE_DURUM D ON D.DURUM_ID = A.AKTIVITE_DURUM_ID ' +
    'LEFT JOIN dbo.Kullanici KO ON KO.KullaniciID = A.OLUSTURAN_KULLANICI_ID ' +
    'WHERE A.TIP <> ''TASK'' ' +
    'UNION ALL ' +
    'SELECT A.AKTIVITE_ID, N''GOREV'', N''TASK'', A.KONU, A.CARI_KOD, ' +
    'ISNULL(KO.KullaniciAd, ''''), ISNULL(KA.KullaniciAd, ''''), G.BITIS_TARIHI, ISNULL(D.KOD, A.DURUM), ' +
    'CASE WHEN (G.TAMAMLANDI = 1 OR ISNULL(D.KAPANIS_MI, 0) = 1) THEN ISNULL(G.TAMAMLANMA_UTC, A.GUNCELLEME_UTC) END, ' +
    'CASE WHEN (G.TAMAMLANDI = 0 AND ISNULL(D.KAPANIS_MI, 0) = 0) AND G.BITIS_TARIHI < CAST(GETDATE() AS date) ' +
    'THEN DATEDIFF(day, CAST(G.BITIS_TARIHI AS date), CAST(GETDATE() AS date)) ELSE 0 END, ' +
    'CAST(CASE WHEN (G.TAMAMLANDI = 1 OR ISNULL(D.KAPANIS_MI, 0) = 1) THEN 1 ELSE 0 END AS bit), ' +
    'A.OLUSTURAN_KULLANICI_ID, G.ATANAN_KULLANICI_ID ' +
    'FROM dbo.CRM_GOREV G ' +
    'INNER JOIN dbo.CRM_AKTIVITE A ON A.AKTIVITE_ID = G.AKTIVITE_ID ' +
    'LEFT JOIN dbo.CRM_AKTIVITE_DURUM D ON D.DURUM_ID = A.AKTIVITE_DURUM_ID ' +
    'LEFT JOIN dbo.Kullanici KO ON KO.KullaniciID = A.OLUSTURAN_KULLANICI_ID ' +
    'LEFT JOIN dbo.Kullanici KA ON KA.KullaniciID = G.ATANAN_KULLANICI_ID ' +
    ') X WHERE 1=1 ';
end;

procedure TfrmCrmAktiviteRapor.UniFormShow(Sender: TObject);
begin
  Caption := 'CRM - Aktivite Durum Raporu';
  cbTarihTur.Items.Clear;
  cbTarihTur.Items.Add('Plan Tarihi');
  cbTarihTur.Items.Add('Tamamlanma Tarihi');
  cbTarihTur.ItemIndex := 0;

  cbKaynak.Items.Clear;
  cbKaynak.Items.Add('T' + #$00FC + 'm' + #$00FC);
  cbKaynak.Items.Add('Aktivite');
  cbKaynak.Items.Add('G' + #$00F6 + 'rev');
  cbKaynak.ItemIndex := 0;

  cbPersonel.Items.Clear;
  cbPersonel.Items.Add('T' + #$00FC + 'm' + #$00FC);
  cbPersonel.Items.Add('Olu' + #$015F + 'turan');
  cbPersonel.Items.Add('Atanan');
  cbPersonel.ItemIndex := 0;

  cbDurumGrup.Items.Clear;
  cbDurumGrup.Items.Add('T' + #$00FC + 'm' + #$00FC);
  cbDurumGrup.Items.Add('A' + #$00E7 + #$0131 + 'k');
  cbDurumGrup.Items.Add('Tamamlanan');
  cbDurumGrup.Items.Add('Geciken');
  cbDurumGrup.ItemIndex := 0;

  qTipLkp.Close;
  qTipLkp.SQL.Text :=
    'SELECT TIP_ID, (KOD + N'' - '' + ISNULL(ACIKLAMA, N'''')) AS AD ' +
    'FROM dbo.CRM_AKTIVITE_TIP WHERE AKTIF = 1 ORDER BY SIRA, TIP_ID';
  qTipLkp.Open;

  qDurLkp.Close;
  qDurLkp.SQL.Text :=
    'SELECT DURUM_ID, (KOD + N'' - '' + ISNULL(ACIKLAMA, N'''')) AS AD ' +
    'FROM dbo.CRM_AKTIVITE_DURUM WHERE AKTIF = 1 ORDER BY SIRA, DURUM_ID';
  qDurLkp.Open;

  dtBas.DateTime := Trunc(StartOfTheMonth(Now));
  dtBit.DateTime := Trunc(EndOfTheMonth(Now));
  lkTip.KeyValue := Null;
  lkDurum.KeyValue := Null;
  edCari.Text := '';
  btnGetirClick(Sender);
end;

procedure TfrmCrmAktiviteRapor.RaporuYukle;
var
  Bas, Bit: TDateTime;
  SqlCore, SqlDetay, Wh, Kaynak, Ck: string;
  Tt, Pm, Dg, KulId: Integer;
begin
  Bas := Trunc(dtBas.DateTime);
  Bit := Trunc(dtBit.DateTime) + 1;
  Tt := cbTarihTur.ItemIndex;
  if Tt < 0 then Tt := 0;
  Pm := cbPersonel.ItemIndex;
  if Pm < 0 then Pm := 0;
  Dg := cbDurumGrup.ItemIndex;
  if Dg < 0 then Dg := 0;
  KulId := Tmp.xKullaniciID;
  Kaynak := '';
  if cbKaynak.ItemIndex = 1 then Kaynak := 'AKTIVITE'
  else if cbKaynak.ItemIndex = 2 then Kaynak := 'GOREV';
  Ck := Trim(edCari.Text);

  Wh := '';
  if Tt = 0 then
    Wh := Wh + ' AND X.PLAN_TARIHI >= :BAS AND X.PLAN_TARIHI < :BIT '
  else
    Wh := Wh + ' AND X.TAMAMLANMA_TARIHI IS NOT NULL AND X.TAMAMLANMA_TARIHI >= :BAS AND X.TAMAMLANMA_TARIHI < :BIT ';

  if Kaynak <> '' then
    Wh := Wh + ' AND X.KAYNAK = :KAY ';
  if FiltreTipId > 0 then
    Wh := Wh + ' AND EXISTS (SELECT 1 FROM dbo.CRM_AKTIVITE AA WHERE AA.AKTIVITE_ID = X.AKTIVITE_ID AND AA.AKTIVITE_TIP_ID = :TID) ';
  if FiltreDurumId > 0 then
    Wh := Wh + ' AND EXISTS (SELECT 1 FROM dbo.CRM_AKTIVITE AA WHERE AA.AKTIVITE_ID = X.AKTIVITE_ID AND AA.AKTIVITE_DURUM_ID = :DID) ';
  if Ck <> '' then
    Wh := Wh + ' AND X.CARI_KOD = :CK ';
  if Pm = 1 then
    Wh := Wh + ' AND X.OLUSTURAN_KULLANICI_ID = :KUL ';
  if Pm = 2 then
    Wh := Wh + ' AND X.ATANAN_ID = :KUL ';
  if Dg = 1 then
    Wh := Wh + ' AND X.TAMAMLANDI_MI = 0 ';
  if Dg = 2 then
    Wh := Wh + ' AND X.TAMAMLANDI_MI = 1 ';
  if Dg = 3 then
    Wh := Wh + ' AND X.TAMAMLANDI_MI = 0 AND X.GECIKME_GUN > 0 ';

  SqlCore := DetaySql + Wh;
  SqlDetay := SqlCore + ' ORDER BY X.PLAN_TARIHI DESC, X.AKTIVITE_ID DESC';

  qDetay.Close;
  qDetay.SQL.Text := SqlDetay;
  qDetay.ParamByName('BAS').AsDateTime := Bas;
  qDetay.ParamByName('BIT').AsDateTime := Bit;
  if Kaynak <> '' then
    qDetay.ParamByName('KAY').AsString := Kaynak;
  if FiltreTipId > 0 then
    qDetay.ParamByName('TID').AsLargeInt := FiltreTipId;
  if FiltreDurumId > 0 then
    qDetay.ParamByName('DID').AsLargeInt := FiltreDurumId;
  if Ck <> '' then
    qDetay.ParamByName('CK').AsString := Ck;
  if (Pm = 1) or (Pm = 2) then
    qDetay.ParamByName('KUL').AsInteger := KulId;
  qDetay.Open;

  qOzetDurum.Close;
  qOzetDurum.SQL.Text :=
    'SELECT DURUM, COUNT(*) AS ADET FROM (' + SqlCore + ') Z GROUP BY DURUM ORDER BY ADET DESC';
  qOzetDurum.ParamByName('BAS').AsDateTime := Bas;
  qOzetDurum.ParamByName('BIT').AsDateTime := Bit;
  if Kaynak <> '' then qOzetDurum.ParamByName('KAY').AsString := Kaynak;
  if FiltreTipId > 0 then qOzetDurum.ParamByName('TID').AsLargeInt := FiltreTipId;
  if FiltreDurumId > 0 then qOzetDurum.ParamByName('DID').AsLargeInt := FiltreDurumId;
  if Ck <> '' then qOzetDurum.ParamByName('CK').AsString := Ck;
  if (Pm = 1) or (Pm = 2) then qOzetDurum.ParamByName('KUL').AsInteger := KulId;
  qOzetDurum.Open;

  qOzetPersonel.Close;
  qOzetPersonel.SQL.Text :=
    'SELECT PERSONEL, SUM(ACIK_SAY) AS ACIK, SUM(TAMAM_SAY) AS TAMAMLANAN, SUM(GECIKEN_SAY) AS GECIKEN FROM (' +
    'SELECT CASE WHEN X.KAYNAK = ''GOREV'' AND ISNULL(X.ATANAN, '''') <> '''' THEN X.ATANAN ELSE X.OLUSTURAN END AS PERSONEL, ' +
    'CASE WHEN X.TAMAMLANDI_MI = 0 THEN 1 ELSE 0 END AS ACIK_SAY, ' +
    'CASE WHEN X.TAMAMLANDI_MI = 1 THEN 1 ELSE 0 END AS TAMAM_SAY, ' +
    'CASE WHEN X.TAMAMLANDI_MI = 0 AND X.GECIKME_GUN > 0 THEN 1 ELSE 0 END AS GECIKEN_SAY ' +
    'FROM (' + SqlCore + ') X) Y GROUP BY PERSONEL ORDER BY PERSONEL';
  qOzetPersonel.ParamByName('BAS').AsDateTime := Bas;
  qOzetPersonel.ParamByName('BIT').AsDateTime := Bit;
  if Kaynak <> '' then qOzetPersonel.ParamByName('KAY').AsString := Kaynak;
  if FiltreTipId > 0 then qOzetPersonel.ParamByName('TID').AsLargeInt := FiltreTipId;
  if FiltreDurumId > 0 then qOzetPersonel.ParamByName('DID').AsLargeInt := FiltreDurumId;
  if Ck <> '' then qOzetPersonel.ParamByName('CK').AsString := Ck;
  if (Pm = 1) or (Pm = 2) then qOzetPersonel.ParamByName('KUL').AsInteger := KulId;
  qOzetPersonel.Open;

  qYapilmayan.Close;
  qYapilmayan.SQL.Text := SqlCore + ' AND X.TAMAMLANDI_MI = 0 AND X.GECIKME_GUN > 0 ORDER BY X.GECIKME_GUN DESC, X.PLAN_TARIHI';
  qYapilmayan.ParamByName('BAS').AsDateTime := Bas;
  qYapilmayan.ParamByName('BIT').AsDateTime := Bit;
  if Kaynak <> '' then qYapilmayan.ParamByName('KAY').AsString := Kaynak;
  if FiltreTipId > 0 then qYapilmayan.ParamByName('TID').AsLargeInt := FiltreTipId;
  if FiltreDurumId > 0 then qYapilmayan.ParamByName('DID').AsLargeInt := FiltreDurumId;
  if Ck <> '' then qYapilmayan.ParamByName('CK').AsString := Ck;
  if (Pm = 1) or (Pm = 2) then qYapilmayan.ParamByName('KUL').AsInteger := KulId;
  qYapilmayan.Open;
end;

procedure TfrmCrmAktiviteRapor.btnGetirClick(Sender: TObject);
begin
  RaporuYukle;
end;

procedure TfrmCrmAktiviteRapor.AcKayit;
var
  Aid: Int64;
  Kaynak: string;
begin
  if not qDetay.Active or qDetay.IsEmpty then
  begin
    UniMainModule.saHata.Show(#$00D6 + 'nce raporu getirin ve bir sat' + #$0131 + 'r se' + #$00E7 + 'in.');
    Exit;
  end;
  Aid := qDetay.FieldByName('AKTIVITE_ID').AsLargeInt;
  if Aid <= 0 then Exit;
  Kaynak := qDetay.FieldByName('KAYNAK').AsString;
  if SameText(Kaynak, 'GOREV') then
    xFormShow(TfrmCrmGorev, 'CrmYeniGorev', 1, IntToStr(Aid))
  else
    xFormShow(TfrmCrmAktivite, 'CrmYeniAktivite', 1, IntToStr(Aid));
end;

procedure TfrmCrmAktiviteRapor.btnAcClick(Sender: TObject);
begin
  AcKayit;
end;

procedure TfrmCrmAktiviteRapor.btnKapatClick(Sender: TObject);
begin
  MainForm.NavPage.ActivePage.Close;
end;

end.
