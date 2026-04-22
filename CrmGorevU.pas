unit CrmGorevU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniMemo, uniComboBox, uniDateTimePicker, uniButton,
  uniDBLookupComboBox, Data.DB, MemDS, DBAccess, Uni, uniDBComboBox,
  uniMultiItem;

type
  TfrmCrmGorev = class(TUniForm)
    rootPanel: TUniPanel;
    panMain: TUniPanel;
    lblKonu: TUniLabel;
    edKonu: TUniEdit;
    lblAciklama: TUniLabel;
    mmAciklama: TUniMemo;
    lblCari: TUniLabel;
    edCariKod: TUniEdit;
    btnCariBul: TUniButton;
    lblBagliTeklif: TUniLabel;
    edBagliTeklifNo: TUniEdit;
    lblBitis: TUniLabel;
    dtBitis: TUniDateTimePicker;
    lblOncelik: TUniLabel;
    cbOncelik: TUniComboBox;
    lblAtanan: TUniLabel;
    lkAtanan: TUniDBLookupComboBox;
    lblDurum: TUniLabel;
    lkDurum: TUniDBLookupComboBox;
    panFooter: TUniPanel;
    btnKaydet: TUniButton;
    qKullanici: TUniQuery;
    dsKullanici: TUniDataSource;
    qInsAkt: TUniQuery;
    qLoad: TUniQuery;
    qInsGor: TUniQuery;
    qDurLkp: TUniQuery;
    dsDurLkp: TUniDataSource;
    procedure UniFormShow(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnCariBulClick(Sender: TObject);
  private
    FAktiviteId: Int64;
    FBaslangicTeklifId: Int64;
    procedure YukleOncelik;
    procedure SetComboByText(ACombo: TUniComboBox; const AText: string);
    procedure KullanicilariAc;
    procedure AcDurumLookup;
    procedure VarsayilanDurum;
    procedure YeniGorevState;
    procedure UygulaBaslangicTeklifGorev(ATeklifId: Int64);
    procedure YukleGorev;
    function DurumKodFromLookup: string;
    function GorevTipId: Int64;
  public
  end;

function frmCrmGorev: TfrmCrmGorev;

implementation

{$R *.dfm}

uses
  uniGUIApplication, MainModule, DMU, TmpU, CrmCariSecU;

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
var
  Tno: string;
begin
  if ATeklifId <= 0 then
    Exit;
  FBaslangicTeklifId := ATeklifId;
  qLoad.Close;
  qLoad.SQL.Text :=
    'SELECT CARI_KOD, TEKLIF_NO FROM dbo.CRM_TEKLIF WHERE TEKLIF_ID = :T';
  qLoad.ParamByName('T').AsLargeInt := ATeklifId;
  qLoad.Open;
  if not qLoad.IsEmpty then
  begin
    if not qLoad.FieldByName('CARI_KOD').IsNull then
      edCariKod.Text := Trim(qLoad.FieldByName('CARI_KOD').AsString);
    if qLoad.FieldByName('TEKLIF_NO').IsNull then
      Tno := ''
    else
      Tno := Trim(qLoad.FieldByName('TEKLIF_NO').AsString);
    if Tno = '' then
      edBagliTeklifNo.Text := 'ID ' + IntToStr(ATeklifId)
    else
      edBagliTeklifNo.Text := Tno;
  end;
  qLoad.Close;
end;

procedure TfrmCrmGorev.YeniGorevState;
begin
  FAktiviteId := 0;
  FBaslangicTeklifId := 0;
  Caption := 'Yeni Gorev';
  edKonu.Text := '';
  mmAciklama.Text := '';
  edCariKod.Text := '';
  edBagliTeklifNo.Text := '';
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
    'SELECT A.KONU, A.ACIKLAMA, A.CARI_KOD, A.AKTIVITE_DURUM_ID, A.TEKLIF_ID, T.TEKLIF_NO AS TEKLIF_NO_REF, ' +
    'G.BITIS_TARIHI, G.ONCELIK, G.TAMAMLANDI, G.ATANAN_KULLANICI_ID ' +
    'FROM dbo.CRM_AKTIVITE A ' +
    'INNER JOIN dbo.CRM_GOREV G ON G.AKTIVITE_ID = A.AKTIVITE_ID ' +
    'LEFT JOIN dbo.CRM_TEKLIF T ON T.TEKLIF_ID = A.TEKLIF_ID ' +
    'WHERE A.AKTIVITE_ID = :AID AND A.TIP = ''TASK''';
  qLoad.ParamByName('AID').AsLargeInt := FAktiviteId;
  qLoad.Open;
  if qLoad.IsEmpty then
  begin
    qLoad.Close;
    UniMainModule.saHata.Show('Gorev bulunamadi.');
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
    edBagliTeklifNo.Text := '';
    FBaslangicTeklifId := 0;
  end
  else
  begin
    FBaslangicTeklifId := qLoad.FieldByName('TEKLIF_ID').AsLargeInt;
    if qLoad.FieldByName('TEKLIF_NO_REF').IsNull then
      edBagliTeklifNo.Text := 'ID ' + IntToStr(FBaslangicTeklifId)
    else
      edBagliTeklifNo.Text := Trim(qLoad.FieldByName('TEKLIF_NO_REF').AsString);
  end;
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

  Caption := 'Gorev';
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
begin
  if Trim(edKonu.Text) = '' then
  begin
    UniMainModule.saHata.Show('Konu zorunludur.');
    Exit;
  end;
  if VarIsNull(lkDurum.KeyValue) or VarIsEmpty(lkDurum.KeyValue) then
  begin
    UniMainModule.saHata.Show('Durum seciniz.');
    Exit;
  end;

  Dkod := DurumKodFromLookup;
  Tamam := 0;
  if SameText(Dkod, 'TAMAMLANDI') then
    Tamam := 1;

  if FAktiviteId > 0 then
  begin
    Aid := FAktiviteId;
    qInsAkt.Close;
    qInsAkt.SQL.Clear;
    qInsAkt.SQL.Add('UPDATE dbo.CRM_AKTIVITE SET KONU = :KONU, ACIKLAMA = :ACIKLAMA, CARI_KOD = :CARI_KOD,');
    qInsAkt.SQL.Add('DURUM = :DURUM, AKTIVITE_DURUM_ID = :DID, GUNCELLEME_UTC = SYSUTCDATETIME() WHERE AKTIVITE_ID = :AID AND TIP = ''TASK''');
    qInsAkt.ParamByName('AID').AsLargeInt := Aid;
    qInsAkt.ParamByName('KONU').AsString := edKonu.Text;
    qInsAkt.ParamByName('ACIKLAMA').AsString := mmAciklama.Text;
    if Trim(edCariKod.Text) <> '' then
      qInsAkt.ParamByName('CARI_KOD').AsString := Trim(edCariKod.Text)
    else
      qInsAkt.ParamByName('CARI_KOD').Clear;
    qInsAkt.ParamByName('DURUM').AsString := Dkod;
    qInsAkt.ParamByName('DID').AsLargeInt := lkDurum.KeyValue;
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
      UniMainModule.saHata.Show('CRM: TASK aktivite tipi bulunamadi. Veritabani migrasyonunu calistirin.');
      Exit;
    end;

    if FBaslangicTeklifId > 0 then
    begin
      qLoad.Close;
      qLoad.SQL.Text := 'SELECT CARI_KOD FROM dbo.CRM_TEKLIF WHERE TEKLIF_ID = :T';
      qLoad.ParamByName('T').AsLargeInt := FBaslangicTeklifId;
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
    qInsAkt.SQL.Add('INSERT INTO dbo.CRM_AKTIVITE (TIP, KONU, ACIKLAMA, CARI_KOD, AKTIVITE_TARIHI, DURUM, OLUSTURAN_KULLANICI_ID, AKTIVITE_TIP_ID, AKTIVITE_DURUM_ID, TEKLIF_ID)');
    qInsAkt.SQL.Add('OUTPUT INSERTED.AKTIVITE_ID');
    qInsAkt.SQL.Add('VALUES (''TASK'', :KONU, :ACIKLAMA, :CARI_KOD, :AKTAR, :DURUM, :KUL, :TID_REF, :DID_REF, :TID_TEK)');
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
    if FBaslangicTeklifId > 0 then
      qInsAkt.ParamByName('TID_TEK').AsLargeInt := FBaslangicTeklifId
    else
      qInsAkt.ParamByName('TID_TEK').Clear;
    qInsAkt.Open;
    if qInsAkt.Fields[0].IsNull then
      Aid := 0
    else
      Aid := qInsAkt.Fields[0].AsLargeInt;
    qInsAkt.Close;

    if Aid <= 0 then
    begin
      UniMainModule.saHata.Show('CRM aktivite kaydi olusmadi (AktiviteID alinamadi).');
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
    Caption := 'Gorev';
  end;

  UniMainModule.saKaydet.Show('Gorev kaydedildi.');
end;

end.
