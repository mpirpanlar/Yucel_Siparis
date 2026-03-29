unit CrmTeklifU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniMemo, uniDateTimePicker, uniButton, uniDBLookupComboBox,
  uniBasicGrid, uniDBGrid, Data.DB, MemDS, DBAccess, Uni;

type
  TfrmCrmTeklif = class(TUniForm)
    rootPanel: TUniContainerPanel;
    panToolbar: TUniPanel;
    btnKaydet: TUniButton;
    lblTeklifNo: TUniLabel;
    edTeklifNo: TUniEdit;
    btnOnizle: TUniButton;
    btnYeniAktivite: TUniButton;
    btnYeniGorev: TUniButton;
    btnKapat: TUniButton;
    panUst: TUniPanel;
    lblBaslik: TUniLabel;
    edBaslik: TUniEdit;
    lblCari: TUniLabel;
    edCariKod: TUniEdit;
    btnCariBul: TUniButton;
    lblTeklifTar: TUniLabel;
    dtTeklif: TUniDateTimePicker;
    lblGecer: TUniLabel;
    dtGecer: TUniDateTimePicker;
    lblDurum: TUniLabel;
    lkDurum: TUniDBLookupComboBox;
    lblSiparis: TUniLabel;
    edSiparis: TUniEdit;
    lblNot: TUniLabel;
    mmNot: TUniMemo;
    panAktBagli: TUniPanel;
    lblBagliAkt: TUniLabel;
    grdAktBagli: TUniDBGrid;
    panGorBagli: TUniPanel;
    lblBagliGor: TUniLabel;
    grdGorBagli: TUniDBGrid;
    panSatirOrta: TUniSimplePanel;
    lblTeklifSatirlari: TUniLabel;
    panSatir: TUniPanel;
    lblStokKod: TUniLabel;
    edStokKod: TUniEdit;
    btnStokBul: TUniButton;
    lblStokAd: TUniLabel;
    edStokAd: TUniEdit;
    lblMiktar: TUniLabel;
    edMiktar: TUniEdit;
    lblFiyat: TUniLabel;
    edBirimFiyat: TUniEdit;
    btnSatirEkle: TUniButton;
    btnSatirSil: TUniButton;
    lblToplamCap: TUniLabel;
    lblToplam: TUniLabel;
    grd: TUniDBGrid;
    qExec: TUniQuery;
    qLoad: TUniQuery;
    qSatir: TUniQuery;
    dsSatir: TUniDataSource;
    qDurLkp: TUniQuery;
    dsDurLkp: TUniDataSource;
    qAktBagli: TUniQuery;
    dsAktBagli: TUniDataSource;
    qGorBagli: TUniQuery;
    dsGorBagli: TUniDataSource;
    procedure UniFormShow(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure btnCariBulClick(Sender: TObject);
    procedure btnStokBulClick(Sender: TObject);
    procedure btnOnizleClick(Sender: TObject);
    procedure btnYeniAktiviteClick(Sender: TObject);
    procedure btnYeniGorevClick(Sender: TObject);
    procedure btnSatirEkleClick(Sender: TObject);
    procedure btnSatirSilClick(Sender: TObject);
    procedure grdAktBagliAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure grdGorBagliAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
  private
    FTeklifId: Int64;
    function ParseDecimal(const S: string): Double;
    procedure YeniKayit;
    procedure YukleKayit;
    procedure AcSatirlar;
    procedure GuncelleToplamEtiket;
    procedure RecalcToplamDb;
    procedure AcLookupSorgulari;
    procedure VarsayilanDurum;
    function DurumKodFromLookup: string;
    procedure TeklifNoGuncelleIfNeeded;
    procedure TeklifNoEkrandaGoster;
    function HtmlEsc(const S: string): string;
    function AciklamayiHtml(const S: string): string;
    procedure TeklifHtmlOnizle;
    procedure BagliAktiviteleriYenile;
    procedure BagliGorevleriYenile;
  public
  end;

function frmCrmTeklif: TfrmCrmTeklif;

implementation

{$R *.dfm}

uses
  System.DateUtils, System.IOUtils,
  uniGUIApplication, MainModule, DMU, TmpU, Main, Genel, CrmCariSecU, CrmStokSecU,
  CrmAktiviteU, CrmGorevU, ServerModule, PDFGosterU;

function frmCrmTeklif: TfrmCrmTeklif;
begin
  Result := TfrmCrmTeklif(UniMainModule.GetFormInstance(TfrmCrmTeklif));
end;

procedure TfrmCrmTeklif.BagliAktiviteleriYenile;
begin
  qAktBagli.Close;
  if FTeklifId <= 0 then
    Exit;
  qAktBagli.SQL.Text :=
    'SELECT A.AKTIVITE_ID, ISNULL(TK.KOD, A.TIP) AS TIP_GORUNEN, A.KONU, A.AKTIVITE_TARIHI, A.DURUM, A.SIPARIS_NO ' +
    'FROM dbo.CRM_AKTIVITE A ' +
    'LEFT JOIN dbo.CRM_AKTIVITE_TIP TK ON TK.TIP_ID = A.AKTIVITE_TIP_ID ' +
    'WHERE A.TEKLIF_ID = :TID AND A.TIP <> ''TASK'' ' +
    'ORDER BY A.AKTIVITE_TARIHI DESC, A.AKTIVITE_ID DESC';
  qAktBagli.ParamByName('TID').AsLargeInt := FTeklifId;
  qAktBagli.Open;
end;

procedure TfrmCrmTeklif.BagliGorevleriYenile;
begin
  qGorBagli.Close;
  if FTeklifId <= 0 then
    Exit;
  qGorBagli.SQL.Text :=
    'SELECT G.GOREV_ID, A.AKTIVITE_ID, A.KONU, A.AKTIVITE_TARIHI, A.DURUM, G.BITIS_TARIHI, G.ONCELIK, G.TAMAMLANDI ' +
    'FROM dbo.CRM_GOREV G ' +
    'INNER JOIN dbo.CRM_AKTIVITE A ON A.AKTIVITE_ID = G.AKTIVITE_ID ' +
    'WHERE A.TEKLIF_ID = :TID AND A.TIP = ''TASK'' ' +
    'ORDER BY A.AKTIVITE_TARIHI DESC, G.GOREV_ID DESC';
  qGorBagli.ParamByName('TID').AsLargeInt := FTeklifId;
  qGorBagli.Open;
end;

procedure TfrmCrmTeklif.btnYeniAktiviteClick(Sender: TObject);
begin
  if FTeklifId <= 0 then
  begin
    UniMainModule.saHata.Show('Once teklifi kaydedin.');
    Exit;
  end;
  Tmp.xCrmYeniAktiviteTeklifId := FTeklifId;
  xFormShow(TfrmCrmAktivite, 'CrmYeniAktivite', 0, '0');
end;

procedure TfrmCrmTeklif.btnYeniGorevClick(Sender: TObject);
begin
  if FTeklifId <= 0 then
  begin
    UniMainModule.saHata.Show('Once teklifi kaydedin.');
    Exit;
  end;
  Tmp.xCrmYeniGorevTeklifId := FTeklifId;
  xFormShow(TfrmCrmGorev, 'CrmYeniGorev', 0, '0');
end;

procedure TfrmCrmTeklif.grdAktBagliAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if not SameText(EventName, 'celldblclick') then
    Exit;
  if not qAktBagli.Active or qAktBagli.IsEmpty then
    Exit;
  if qAktBagli.FieldByName('AKTIVITE_ID').IsNull then
    Exit;
  xFormShow(TfrmCrmAktivite, 'CrmYeniAktivite', 1, qAktBagli.FieldByName('AKTIVITE_ID').AsString);
end;

procedure TfrmCrmTeklif.grdGorBagliAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if not SameText(EventName, 'celldblclick') then
    Exit;
  if not qGorBagli.Active or qGorBagli.IsEmpty then
    Exit;
  if qGorBagli.FieldByName('AKTIVITE_ID').IsNull then
    Exit;
  xFormShow(TfrmCrmGorev, 'CrmYeniGorev', 1, qGorBagli.FieldByName('AKTIVITE_ID').AsString);
end;

function TfrmCrmTeklif.HtmlEsc(const S: string): string;
begin
  Result := S;
  Result := StringReplace(Result, '&', '&amp;', [rfReplaceAll]);
  Result := StringReplace(Result, '<', '&lt;', [rfReplaceAll]);
  Result := StringReplace(Result, '>', '&gt;', [rfReplaceAll]);
  Result := StringReplace(Result, '"', '&quot;', [rfReplaceAll]);
end;

function TfrmCrmTeklif.AciklamayiHtml(const S: string): string;
begin
  Result := HtmlEsc(S);
  Result := StringReplace(Result, #13#10, '<br/>', [rfReplaceAll]);
  Result := StringReplace(Result, #10, '<br/>', [rfReplaceAll]);
end;

procedure TfrmCrmTeklif.TeklifHtmlOnizle;
var
  Sl: TStringList;
  fn, FullPath: string;
  TopNet: Double;
  Cari, Bas, Tno, Dur, Notlar, SipNo: string;
  TTar, GTar: TDateTime;
  HasG: Boolean;
begin
  if FTeklifId <= 0 then
  begin
    UniMainModule.saHata.Show('Once teklifi kaydedin.');
    Exit;
  end;
  RecalcToplamDb;

  qLoad.Close;
  qLoad.SQL.Text :=
    'SELECT TEKLIF_NO, CARI_KOD, BASLIK, TEKLIF_TARIHI, GECERLILIK_TARIHI, DURUM, ACIKLAMA, TOPLAM_NET, SIPARIS_NO ' +
    'FROM dbo.CRM_TEKLIF WHERE TEKLIF_ID = :ID';
  qLoad.ParamByName('ID').AsLargeInt := FTeklifId;
  qLoad.Open;
  if qLoad.IsEmpty then
  begin
    qLoad.Close;
    UniMainModule.saHata.Show('Teklif veritabaninda bulunamadi.');
    Exit;
  end;

  if qLoad.FieldByName('TEKLIF_NO').IsNull then
    Tno := ''
  else
    Tno := Trim(qLoad.FieldByName('TEKLIF_NO').AsString);
  if qLoad.FieldByName('CARI_KOD').IsNull then
    Cari := ''
  else
    Cari := Trim(qLoad.FieldByName('CARI_KOD').AsString);
  Bas := qLoad.FieldByName('BASLIK').AsString;
  TTar := qLoad.FieldByName('TEKLIF_TARIHI').AsDateTime;
  HasG := not qLoad.FieldByName('GECERLILIK_TARIHI').IsNull;
  if HasG then
    GTar := qLoad.FieldByName('GECERLILIK_TARIHI').AsDateTime;
  Dur := qLoad.FieldByName('DURUM').AsString;
  if (qLoad.FindField('SIPARIS_NO') <> nil) and not qLoad.FieldByName('SIPARIS_NO').IsNull then
    SipNo := Trim(qLoad.FieldByName('SIPARIS_NO').AsString)
  else
    SipNo := '';
  if qLoad.FieldByName('ACIKLAMA').IsNull then
    Notlar := ''
  else
    Notlar := qLoad.FieldByName('ACIKLAMA').AsString;
  TopNet := qLoad.FieldByName('TOPLAM_NET').AsFloat;
  qLoad.Close;

  fn := Format('crm_teklif_%d.html', [FTeklifId]);
  Sl := TStringList.Create;
  try
    Sl.Add('<!DOCTYPE html>');
    Sl.Add('<html><head><meta charset="utf-8"/><title>' + HtmlEsc(Tno) + '</title>');
    Sl.Add('<style type="text/css">body{font-family:Segoe UI,Arial,sans-serif;margin:24px;}');
    Sl.Add('table{border-collapse:collapse;width:100%;margin-top:12px;}');
    Sl.Add('th,td{border:1px solid #ccc;padding:6px 8px;font-size:13px;}');
    Sl.Add('th{background:#f0f0f0;text-align:left;} .sayi{text-align:right;} .toplam{font-weight:bold;}</style></head><body>');
    Sl.Add('<h2>' + HtmlEsc(Bas) + '</h2>');
    Sl.Add('<p><b>Teklif no:</b> ' + HtmlEsc(Tno) + ' &nbsp; <b>Durum:</b> ' + HtmlEsc(Dur) + '</p>');
    Sl.Add('<p><b>Cari kod:</b> ' + HtmlEsc(Cari) + '</p>');
    Sl.Add('<p><b>Teklif tarihi:</b> ' + HtmlEsc(FormatDateTime('dd/MM/yyyy HH:nn', TTar)) + '</p>');
    if HasG then
      Sl.Add('<p><b>Gecerlilik:</b> ' + HtmlEsc(FormatDateTime('dd/MM/yyyy HH:nn', GTar)) + '</p>');
    if SipNo <> '' then
      Sl.Add('<p><b>Siparis no:</b> ' + HtmlEsc(SipNo) + '</p>');
    if Trim(Notlar) <> '' then
    begin
      Sl.Add('<p><b>Aciklama</b></p><p>' + AciklamayiHtml(Notlar) + '</p>');
    end;
    Sl.Add('<table><thead><tr>');
    Sl.Add('<th>Sira</th><th>Stok kod</th><th>Stok ad</th><th class="sayi">Miktar</th><th>Birim</th>');
    Sl.Add('<th class="sayi">Birim fiyat</th><th class="sayi">Tutar</th></tr></thead><tbody>');

    qExec.Close;
    qExec.SQL.Text :=
      'SELECT SIRA, STOK_KOD, STOK_ADI, MIKTAR, BIRIM, BIRIM_FIYAT, TUTAR ' +
      'FROM dbo.CRM_TEKLIF_SATIR WHERE TEKLIF_ID = :TID ORDER BY SIRA, SATIR_ID';
    qExec.ParamByName('TID').AsLargeInt := FTeklifId;
    qExec.Open;
    try
      while not qExec.Eof do
      begin
        Sl.Add('<tr>');
        Sl.Add('<td>' + IntToStr(qExec.FieldByName('SIRA').AsInteger) + '</td>');
        Sl.Add('<td>' + HtmlEsc(qExec.FieldByName('STOK_KOD').AsString) + '</td>');
        if qExec.FieldByName('STOK_ADI').IsNull then
          Sl.Add('<td></td>')
        else
          Sl.Add('<td>' + HtmlEsc(qExec.FieldByName('STOK_ADI').AsString) + '</td>');
        Sl.Add('<td class="sayi">' + FormatFloat('#,##0.####', qExec.FieldByName('MIKTAR').AsFloat) + '</td>');
        if qExec.FieldByName('BIRIM').IsNull then
          Sl.Add('<td></td>')
        else
          Sl.Add('<td>' + HtmlEsc(qExec.FieldByName('BIRIM').AsString) + '</td>');
        Sl.Add('<td class="sayi">' + FormatFloat('#,##0.00', qExec.FieldByName('BIRIM_FIYAT').AsFloat) + '</td>');
        Sl.Add('<td class="sayi">' + FormatFloat('#,##0.00', qExec.FieldByName('TUTAR').AsFloat) + '</td>');
        Sl.Add('</tr>');
        qExec.Next;
      end;
    finally
      qExec.Close;
    end;

    Sl.Add('</tbody></table>');
    Sl.Add('<p class="toplam">Satir toplami (net): ' + FormatFloat('#,##0.00', TopNet) + '</p>');
    Sl.Add('</body></html>');

    FullPath := TPath.Combine(UniServerModule.LocalCachePath, fn);
    Sl.SaveToFile(FullPath, TEncoding.UTF8);
  finally
    Sl.Free;
  end;

  frmPDFGoster.UniURLFrame1.URL := UniServerModule.LocalCacheURL + fn;
  frmPDFGoster.ShowModal;
end;

procedure TfrmCrmTeklif.btnOnizleClick(Sender: TObject);
begin
  TeklifHtmlOnizle;
end;

function TfrmCrmTeklif.ParseDecimal(const S: string): Double;
var
  T: string;
  FS: TFormatSettings;
begin
  T := Trim(StringReplace(S, ',', '.', [rfReplaceAll]));
  FS := FormatSettings;
  FS.DecimalSeparator := '.';
  Result := StrToFloatDef(T, 0, FS);
end;

procedure TfrmCrmTeklif.AcLookupSorgulari;
begin
  qDurLkp.Close;
  qDurLkp.SQL.Text :=
    'SELECT TEKLIF_DURUM_ID, KOD, (KOD + N'' - '' + ISNULL(ACIKLAMA, N'''')) AS AD ' +
    'FROM dbo.CRM_TEKLIF_DURUM WHERE AKTIF = 1 ORDER BY SIRA, TEKLIF_DURUM_ID';
  qDurLkp.Open;
end;

procedure TfrmCrmTeklif.VarsayilanDurum;
begin
  lkDurum.KeyValue := Null;
  if qDurLkp.Active and qDurLkp.Locate('KOD', 'TASLAK', [loCaseInsensitive]) then
    lkDurum.KeyValue := qDurLkp.FieldByName('TEKLIF_DURUM_ID').AsLargeInt
  else if qDurLkp.Active and not qDurLkp.IsEmpty then
    lkDurum.KeyValue := qDurLkp.FieldByName('TEKLIF_DURUM_ID').AsLargeInt;
end;

function TfrmCrmTeklif.DurumKodFromLookup: string;
begin
  Result := '';
  if VarIsNull(lkDurum.KeyValue) or VarIsEmpty(lkDurum.KeyValue) then
    Exit;
  if qDurLkp.Active and qDurLkp.Locate('TEKLIF_DURUM_ID', lkDurum.KeyValue, []) then
    Result := qDurLkp.FieldByName('KOD').AsString;
end;

procedure TfrmCrmTeklif.TeklifNoGuncelleIfNeeded;
var
  Y: Integer;
  Mevcut, NewNo: string;
  Tar: TDateTime;
begin
  if FTeklifId <= 0 then
    Exit;
  qLoad.Close;
  qLoad.SQL.Text :=
    'SELECT TEKLIF_NO, TEKLIF_TARIHI FROM dbo.CRM_TEKLIF WHERE TEKLIF_ID = :ID';
  qLoad.ParamByName('ID').AsLargeInt := FTeklifId;
  qLoad.Open;
  if qLoad.IsEmpty then
  begin
    qLoad.Close;
    Exit;
  end;
  if qLoad.FieldByName('TEKLIF_NO').IsNull then
    Mevcut := ''
  else
    Mevcut := Trim(qLoad.FieldByName('TEKLIF_NO').AsString);
  if qLoad.FieldByName('TEKLIF_TARIHI').IsNull then
    Tar := Now
  else
    Tar := qLoad.FieldByName('TEKLIF_TARIHI').AsDateTime;
  qLoad.Close;
  if Mevcut <> '' then
    Exit;
  Y := YearOf(Tar);
  NewNo := Format('TKL-%d-%d', [Y, FTeklifId]);
  qExec.Close;
  qExec.SQL.Text :=
    'UPDATE dbo.CRM_TEKLIF SET TEKLIF_NO = :NO, GUNCELLEME_UTC = SYSUTCDATETIME() WHERE TEKLIF_ID = :ID ' +
    'AND (TEKLIF_NO IS NULL OR LTRIM(RTRIM(TEKLIF_NO)) = '''')';
  qExec.ParamByName('NO').AsString := NewNo;
  qExec.ParamByName('ID').AsLargeInt := FTeklifId;
  qExec.Execute;
end;

procedure TfrmCrmTeklif.TeklifNoEkrandaGoster;
begin
  if FTeklifId <= 0 then
  begin
    edTeklifNo.Text := '';
    Exit;
  end;
  qLoad.Close;
  qLoad.SQL.Text := 'SELECT TEKLIF_NO FROM dbo.CRM_TEKLIF WHERE TEKLIF_ID = :ID';
  qLoad.ParamByName('ID').AsLargeInt := FTeklifId;
  qLoad.Open;
  if qLoad.IsEmpty or qLoad.FieldByName('TEKLIF_NO').IsNull then
    edTeklifNo.Text := ''
  else
    edTeklifNo.Text := Trim(qLoad.FieldByName('TEKLIF_NO').AsString);
  qLoad.Close;
end;

procedure TfrmCrmTeklif.GuncelleToplamEtiket;
begin
  if FTeklifId <= 0 then
  begin
    lblToplam.Caption := '0,00';
    Exit;
  end;
  qLoad.Close;
  qLoad.SQL.Text := 'SELECT TOPLAM_NET FROM dbo.CRM_TEKLIF WHERE TEKLIF_ID = :ID';
  qLoad.ParamByName('ID').AsLargeInt := FTeklifId;
  qLoad.Open;
  if qLoad.IsEmpty then
    lblToplam.Caption := '0,00'
  else
    lblToplam.Caption := FormatFloat('#,##0.00', qLoad.Fields[0].AsFloat);
  qLoad.Close;
end;

procedure TfrmCrmTeklif.RecalcToplamDb;
begin
  if FTeklifId <= 0 then
    Exit;
  qExec.Close;
  qExec.SQL.Text :=
    'UPDATE T SET T.TOPLAM_NET = ISNULL(S.TT, 0), T.GUNCELLEME_UTC = SYSUTCDATETIME() ' +
    'FROM dbo.CRM_TEKLIF T ' +
    'LEFT JOIN (SELECT TEKLIF_ID, SUM(TUTAR) AS TT FROM dbo.CRM_TEKLIF_SATIR GROUP BY TEKLIF_ID) S ' +
    '  ON S.TEKLIF_ID = T.TEKLIF_ID WHERE T.TEKLIF_ID = :ID';
  qExec.ParamByName('ID').AsLargeInt := FTeklifId;
  qExec.Execute;
end;

procedure TfrmCrmTeklif.AcSatirlar;
begin
  qSatir.Close;
  if FTeklifId <= 0 then
  begin
    GuncelleToplamEtiket;
    Exit;
  end;
  qSatir.SQL.Text :=
    'SELECT SATIR_ID, TEKLIF_ID, SIRA, STOK_KOD, STOK_ADI, MIKTAR, BIRIM, BIRIM_FIYAT, TUTAR ' +
    'FROM dbo.CRM_TEKLIF_SATIR WHERE TEKLIF_ID = :TID ORDER BY SIRA, SATIR_ID';
  qSatir.ParamByName('TID').AsLargeInt := FTeklifId;
  qSatir.Open;
  GuncelleToplamEtiket;
end;

procedure TfrmCrmTeklif.YeniKayit;
begin
  FTeklifId := 0;
  Caption := 'Yeni Teklif';
  edBaslik.Text := '';
  edCariKod.Text := '';
  dtTeklif.DateTime := Now;
  dtGecer.DateTime := Now + 30;
  AcLookupSorgulari;
  VarsayilanDurum;
  mmNot.Text := '';
  edSiparis.Text := '';
  edStokKod.Text := '';
  edStokAd.Text := '';
  edMiktar.Text := '1';
  edBirimFiyat.Text := '0';
  qSatir.Close;
  lblToplam.Caption := '0,00';
  edTeklifNo.Text := '';
  qAktBagli.Close;
  qGorBagli.Close;
end;

procedure TfrmCrmTeklif.YukleKayit;
begin
  qLoad.Close;
  qLoad.SQL.Text :=
    'SELECT CARI_KOD, BASLIK, TEKLIF_TARIHI, GECERLILIK_TARIHI, DURUM, TEKLIF_DURUM_ID, TEKLIF_NO, ACIKLAMA, SIPARIS_NO ' +
    'FROM dbo.CRM_TEKLIF WHERE TEKLIF_ID = :ID';
  qLoad.ParamByName('ID').AsLargeInt := FTeklifId;
  qLoad.Open;
  if qLoad.IsEmpty then
  begin
    qLoad.Close;
    UniMainModule.saHata.Show('Teklif bulunamadi.');
    YeniKayit;
    Exit;
  end;
  edBaslik.Text := qLoad.FieldByName('BASLIK').AsString;
  if qLoad.FieldByName('CARI_KOD').IsNull then
    edCariKod.Text := ''
  else
    edCariKod.Text := qLoad.FieldByName('CARI_KOD').AsString;
  if qLoad.FieldByName('TEKLIF_TARIHI').IsNull then
    dtTeklif.DateTime := Now
  else
    dtTeklif.DateTime := qLoad.FieldByName('TEKLIF_TARIHI').AsDateTime;
  if qLoad.FieldByName('GECERLILIK_TARIHI').IsNull then
    dtGecer.DateTime := Now + 30
  else
    dtGecer.DateTime := qLoad.FieldByName('GECERLILIK_TARIHI').AsDateTime;
  AcLookupSorgulari;
  if qLoad.FieldByName('TEKLIF_DURUM_ID').IsNull then
    VarsayilanDurum
  else
    lkDurum.KeyValue := qLoad.FieldByName('TEKLIF_DURUM_ID').AsLargeInt;
  if qLoad.FieldByName('TEKLIF_NO').IsNull then
    edTeklifNo.Text := ''
  else
    edTeklifNo.Text := Trim(qLoad.FieldByName('TEKLIF_NO').AsString);
  mmNot.Text := qLoad.FieldByName('ACIKLAMA').AsString;
  if (qLoad.FindField('SIPARIS_NO') <> nil) and not qLoad.FieldByName('SIPARIS_NO').IsNull then
    edSiparis.Text := Trim(qLoad.FieldByName('SIPARIS_NO').AsString)
  else
    edSiparis.Text := '';
  qLoad.Close;
  if Trim(edTeklifNo.Text) = '' then
  begin
    TeklifNoGuncelleIfNeeded;
    TeklifNoEkrandaGoster;
  end;
  Caption := 'Teklif';
  AcSatirlar;
  BagliAktiviteleriYenile;
  BagliGorevleriYenile;
end;

procedure TfrmCrmTeklif.UniFormShow(Sender: TObject);
begin
  FTeklifId := StrToInt64Def(Trim(Hint), 0);
  if FTeklifId > 0 then
    YukleKayit
  else
    YeniKayit;
end;

procedure TfrmCrmTeklif.btnCariBulClick(Sender: TObject);
begin
  frmCrmCariSec.HedefCariEdit := edCariKod;
  frmCrmCariSec.edArama.Text := Trim(edCariKod.Text);
  frmCrmCariSec.ShowModal;
end;

procedure TfrmCrmTeklif.btnStokBulClick(Sender: TObject);
begin
  frmCrmStokSec.HedefStokKod := edStokKod;
  frmCrmStokSec.HedefStokAd := edStokAd;
  frmCrmStokSec.HedefBirimFiyat := edBirimFiyat;
  frmCrmStokSec.edArama.Text := Trim(edStokKod.Text);
  frmCrmStokSec.ShowModal;
end;

procedure TfrmCrmTeklif.btnKaydetClick(Sender: TObject);
var
  NewId: Int64;
  DKod: string;
begin
  if Trim(edBaslik.Text) = '' then
  begin
    UniMainModule.saHata.Show('Baslik zorunludur.');
    Exit;
  end;
  if VarIsNull(lkDurum.KeyValue) or VarIsEmpty(lkDurum.KeyValue) then
  begin
    UniMainModule.saHata.Show('Durum seciniz.');
    Exit;
  end;
  DKod := DurumKodFromLookup;
  if DKod = '' then
  begin
    UniMainModule.saHata.Show('Durum seciniz.');
    Exit;
  end;

  qExec.Close;
  if FTeklifId > 0 then
  begin
    qExec.SQL.Text :=
      'UPDATE dbo.CRM_TEKLIF SET CARI_KOD = :CARI, BASLIK = :BAS, TEKLIF_TARIHI = :TTAR, ' +
      'GECERLILIK_TARIHI = :GTAR, DURUM = :DUR, TEKLIF_DURUM_ID = :DID_REF, ACIKLAMA = :NOTLAR, ' +
      'SIPARIS_NO = :SIPNO, GUNCELLEME_UTC = SYSUTCDATETIME() ' +
      'WHERE TEKLIF_ID = :ID';
    qExec.ParamByName('ID').AsLargeInt := FTeklifId;
  end
  else
  begin
    qExec.SQL.Text :=
      'INSERT INTO dbo.CRM_TEKLIF (CARI_KOD, BASLIK, TEKLIF_TARIHI, GECERLILIK_TARIHI, DURUM, TEKLIF_DURUM_ID, ACIKLAMA, SIPARIS_NO, TOPLAM_NET, OLUSTURAN_KULLANICI_ID) ' +
      'OUTPUT INSERTED.TEKLIF_ID VALUES (:CARI, :BAS, :TTAR, :GTAR, :DUR, :DID_REF, :NOTLAR, :SIPNO, 0, :KUL)';
    qExec.ParamByName('KUL').AsInteger := Tmp.xKullaniciID;
  end;

  if Trim(edCariKod.Text) <> '' then
    qExec.ParamByName('CARI').AsString := Trim(edCariKod.Text)
  else
    qExec.ParamByName('CARI').Clear;
  qExec.ParamByName('BAS').AsString := edBaslik.Text;
  qExec.ParamByName('TTAR').AsDateTime := dtTeklif.DateTime;
  qExec.ParamByName('GTAR').AsDateTime := dtGecer.DateTime;
  qExec.ParamByName('DUR').AsString := DKod;
  qExec.ParamByName('DID_REF').AsLargeInt := lkDurum.KeyValue;
  qExec.ParamByName('NOTLAR').AsString := mmNot.Text;
  if Trim(edSiparis.Text) <> '' then
    qExec.ParamByName('SIPNO').AsString := Trim(edSiparis.Text)
  else
    qExec.ParamByName('SIPNO').Clear;

  if FTeklifId > 0 then
  begin
    qExec.Execute;
    RecalcToplamDb;
  end
  else
  begin
    qExec.Open;
    if qExec.Fields[0].IsNull then
      NewId := 0
    else
      NewId := qExec.Fields[0].AsLargeInt;
    qExec.Close;
    FTeklifId := NewId;
  end;

  if FTeklifId > 0 then
    TeklifNoGuncelleIfNeeded;

  UniMainModule.saKaydet.Show('Teklif kaydedildi.');
  if FTeklifId > 0 then
  begin
    Caption := 'Teklif';
    TeklifNoEkrandaGoster;
    AcSatirlar;
    BagliAktiviteleriYenile;
    BagliGorevleriYenile;
  end;
end;

procedure TfrmCrmTeklif.btnKapatClick(Sender: TObject);
begin
  MainForm.NavPage.ActivePage.Close;
end;

procedure TfrmCrmTeklif.btnSatirEkleClick(Sender: TObject);
var
  M, Bf, Tut: Double;
  Sk, Sa: string;
begin
  if FTeklifId <= 0 then
  begin
    UniMainModule.saHata.Show('Once teklif basligini kaydedin.');
    Exit;
  end;
  Sk := Trim(edStokKod.Text);
  if Sk = '' then
  begin
    UniMainModule.saHata.Show('Stok kodu zorunludur.');
    Exit;
  end;
  M := ParseDecimal(edMiktar.Text);
  Bf := ParseDecimal(edBirimFiyat.Text);
  if M <= 0 then
  begin
    UniMainModule.saHata.Show('Miktar sifirdan buyuk olmalidir.');
    Exit;
  end;
  Tut := M * Bf;
  Sa := Trim(edStokAd.Text);

  qExec.Close;
  qExec.SQL.Text :=
    'INSERT INTO dbo.CRM_TEKLIF_SATIR (TEKLIF_ID, SIRA, STOK_KOD, STOK_ADI, MIKTAR, BIRIM, BIRIM_FIYAT, TUTAR) ' +
    'SELECT :TID, ISNULL((SELECT MAX(SIRA) FROM dbo.CRM_TEKLIF_SATIR WHERE TEKLIF_ID = :TID2), 0) + 1, ' +
    ':SK, :SA, :M, N''ADET'', :BF, :TT';
  qExec.ParamByName('TID').AsLargeInt := FTeklifId;
  qExec.ParamByName('TID2').AsLargeInt := FTeklifId;
  qExec.ParamByName('SK').AsString := Sk;
  if Sa <> '' then
    qExec.ParamByName('SA').AsString := Sa
  else
    qExec.ParamByName('SA').Clear;
  qExec.ParamByName('M').AsFloat := M;
  qExec.ParamByName('BF').AsFloat := Bf;
  qExec.ParamByName('TT').AsFloat := Tut;
  qExec.Execute;

  RecalcToplamDb;
  AcSatirlar;
  edStokKod.Text := '';
  edStokAd.Text := '';
  edMiktar.Text := '1';
  edBirimFiyat.Text := '0';
end;

procedure TfrmCrmTeklif.btnSatirSilClick(Sender: TObject);
var
  Sid: Int64;
begin
  if not qSatir.Active or qSatir.IsEmpty then
    Exit;
  Sid := qSatir.FieldByName('SATIR_ID').AsLargeInt;
  qExec.Close;
  qExec.SQL.Text := 'DELETE FROM dbo.CRM_TEKLIF_SATIR WHERE SATIR_ID = :SID';
  qExec.ParamByName('SID').AsLargeInt := Sid;
  qExec.Execute;
  RecalcToplamDb;
  AcSatirlar;
end;

end.
