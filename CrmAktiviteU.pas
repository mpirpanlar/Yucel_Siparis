unit CrmAktiviteU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniMemo, uniDateTimePicker, uniButton, uniDBLookupComboBox,
  Data.DB, MemDS, DBAccess, Uni, uniMultiItem, uniComboBox, uniDBComboBox;

type
  TfrmCrmAktivite = class(TUniForm)
    rootPanel: TUniPanel;
    panMain: TUniPanel;
    lblTip: TUniLabel;
    lkTip: TUniDBLookupComboBox;
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
    lblTarih: TUniLabel;
    dtAktivite: TUniDateTimePicker;
    lblDurum: TUniLabel;
    lkDurum: TUniDBLookupComboBox;
    panFooter: TUniPanel;
    btnKaydet: TUniButton;
    qExec: TUniQuery;
    qLoad: TUniQuery;
    qTipLkp: TUniQuery;
    dsTipLkp: TUniDataSource;
    qDurLkp: TUniQuery;
    dsDurLkp: TUniDataSource;
    qTekLkp: TUniQuery;
    dsTekLkp: TUniDataSource;
    procedure UniFormShow(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnCariBulClick(Sender: TObject);
    procedure btnTeklifYenileClick(Sender: TObject);
  private
    FAktiviteId: Int64;
    procedure AcLookupSorgulari;
    procedure VarsayilanSecimler;
    procedure TeklifLookupYenile(AForceTid: Int64);
    procedure UygulaBaslangicTeklif(ATeklifId: Int64);
    procedure YeniKayit;
    procedure YukleKayit;
    function TipKodFromLookup: string;
    function DurumKodFromLookup: string;
  public
  end;

function frmCrmAktivite: TfrmCrmAktivite;

implementation

{$R *.dfm}

uses
  uniGUIApplication, MainModule, DMU, TmpU, CrmCariSecU;

procedure TfrmCrmAktivite.btnCariBulClick(Sender: TObject);
var
  PrevTkl: Int64;
begin
  PrevTkl := 0;
  if not VarIsNull(lkTeklif.KeyValue) and not VarIsEmpty(lkTeklif.KeyValue) then
    PrevTkl := lkTeklif.KeyValue;
  frmCrmCariSec.HedefCariEdit := edCariKod;
  frmCrmCariSec.edArama.Text := Trim(edCariKod.Text);
  frmCrmCariSec.ShowModal;
  TeklifLookupYenile(0);
  if PrevTkl > 0 then
  begin
    if qTekLkp.Active and qTekLkp.Locate('TEKLIF_ID', PrevTkl, []) then
      lkTeklif.KeyValue := PrevTkl
    else
      lkTeklif.KeyValue := Null;
  end;
end;

procedure TfrmCrmAktivite.btnTeklifYenileClick(Sender: TObject);
var
  PrevTkl: Int64;
begin
  PrevTkl := 0;
  if not VarIsNull(lkTeklif.KeyValue) and not VarIsEmpty(lkTeklif.KeyValue) then
    PrevTkl := lkTeklif.KeyValue;
  TeklifLookupYenile(PrevTkl);
  if PrevTkl > 0 then
  begin
    if qTekLkp.Active and qTekLkp.Locate('TEKLIF_ID', PrevTkl, []) then
      lkTeklif.KeyValue := PrevTkl
    else
      lkTeklif.KeyValue := Null;
  end;
end;

function frmCrmAktivite: TfrmCrmAktivite;
begin
  Result := TfrmCrmAktivite(UniMainModule.GetFormInstance(TfrmCrmAktivite));
end;

procedure TfrmCrmAktivite.AcLookupSorgulari;
begin
  qTipLkp.Close;
  qTipLkp.SQL.Text :=
    'SELECT TIP_ID, KOD, (KOD + N'' - '' + ISNULL(ACIKLAMA, N'''')) AS AD ' +
    'FROM dbo.CRM_AKTIVITE_TIP WHERE AKTIF = 1 AND KOD <> ''TASK'' ORDER BY SIRA, TIP_ID';
  qTipLkp.Open;

  qDurLkp.Close;
  qDurLkp.SQL.Text :=
    'SELECT DURUM_ID, KOD, (KOD + N'' - '' + ISNULL(ACIKLAMA, N'''')) AS AD ' +
    'FROM dbo.CRM_AKTIVITE_DURUM WHERE AKTIF = 1 ORDER BY SIRA, DURUM_ID';
  qDurLkp.Open;
end;

procedure TfrmCrmAktivite.UygulaBaslangicTeklif(ATeklifId: Int64);
begin
  if ATeklifId <= 0 then
    Exit;
  qLoad.Close;
  qLoad.SQL.Text := 'SELECT CARI_KOD FROM dbo.CRM_TEKLIF WHERE TEKLIF_ID = :T';
  qLoad.ParamByName('T').AsLargeInt := ATeklifId;
  qLoad.Open;
  if not qLoad.IsEmpty and not qLoad.FieldByName('CARI_KOD').IsNull then
    edCariKod.Text := Trim(qLoad.FieldByName('CARI_KOD').AsString);
  qLoad.Close;
  TeklifLookupYenile(ATeklifId);
  if qTekLkp.Active and qTekLkp.Locate('TEKLIF_ID', ATeklifId, []) then
    lkTeklif.KeyValue := ATeklifId
  else
    lkTeklif.KeyValue := Null;
end;

procedure TfrmCrmAktivite.TeklifLookupYenile(AForceTid: Int64);
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

procedure TfrmCrmAktivite.VarsayilanSecimler;
begin
  lkTip.KeyValue := Null;
  if qTipLkp.Active and not qTipLkp.IsEmpty then
    lkTip.KeyValue := qTipLkp.FieldByName('TIP_ID').AsLargeInt;

  lkDurum.KeyValue := Null;
  if qDurLkp.Active and qDurLkp.Locate('KOD', 'ACIK', [loCaseInsensitive]) then
    lkDurum.KeyValue := qDurLkp.FieldByName('DURUM_ID').AsLargeInt
  else if qDurLkp.Active and not qDurLkp.IsEmpty then
    lkDurum.KeyValue := qDurLkp.FieldByName('DURUM_ID').AsLargeInt;
end;

function TfrmCrmAktivite.TipKodFromLookup: string;
begin
  Result := '';
  if VarIsNull(lkTip.KeyValue) or VarIsEmpty(lkTip.KeyValue) then
    Exit;
  if qTipLkp.Active and qTipLkp.Locate('TIP_ID', lkTip.KeyValue, []) then
    Result := qTipLkp.FieldByName('KOD').AsString;
end;

function TfrmCrmAktivite.DurumKodFromLookup: string;
begin
  Result := '';
  if VarIsNull(lkDurum.KeyValue) or VarIsEmpty(lkDurum.KeyValue) then
    Exit;
  if qDurLkp.Active and qDurLkp.Locate('DURUM_ID', lkDurum.KeyValue, []) then
    Result := qDurLkp.FieldByName('KOD').AsString;
end;

procedure TfrmCrmAktivite.YeniKayit;
begin
  FAktiviteId := 0;
  Caption := 'Yeni Aktivite';
  edKonu.Text := '';
  mmAciklama.Text := '';
  edCariKod.Text := '';
  dtAktivite.DateTime := Now;
  AcLookupSorgulari;
  VarsayilanSecimler;
  TeklifLookupYenile(0);
  lkTeklif.KeyValue := Null;
  edSiparis.Text := '';
end;

procedure TfrmCrmAktivite.YukleKayit;
var
  TipKod: string;
  Tid: Int64;
begin
  qLoad.Close;
  qLoad.SQL.Text :=
    'SELECT A.AKTIVITE_TIP_ID, A.AKTIVITE_DURUM_ID, A.KONU, A.ACIKLAMA, A.CARI_KOD, A.AKTIVITE_TARIHI, A.DURUM, A.TEKLIF_ID, A.SIPARIS_NO, TK.KOD AS TIP_KOD ' +
    'FROM dbo.CRM_AKTIVITE A ' +
    'LEFT JOIN dbo.CRM_AKTIVITE_TIP TK ON TK.TIP_ID = A.AKTIVITE_TIP_ID ' +
    'WHERE A.AKTIVITE_ID = :ID';
  qLoad.ParamByName('ID').AsLargeInt := FAktiviteId;
  qLoad.Open;
  if qLoad.IsEmpty then
  begin
    qLoad.Close;
    UniMainModule.saHata.Show('Aktivite bulunamadi.');
    YeniKayit;
    Exit;
  end;
  TipKod := qLoad.FieldByName('TIP_KOD').AsString;
  if SameText(TipKod, 'TASK') then
  begin
    qLoad.Close;
    UniMainModule.saHata.Show('Bu kayit gorev tipindedir; Gorev listesinden aciniz.');
    YeniKayit;
    Exit;
  end;

  Tid := 0;
  if not qLoad.FieldByName('TEKLIF_ID').IsNull then
    Tid := qLoad.FieldByName('TEKLIF_ID').AsLargeInt;

  AcLookupSorgulari;
  TeklifLookupYenile(Tid);
  lkTip.KeyValue := qLoad.FieldByName('AKTIVITE_TIP_ID').AsLargeInt;
  lkDurum.KeyValue := qLoad.FieldByName('AKTIVITE_DURUM_ID').AsLargeInt;
  if Tid > 0 then
    lkTeklif.KeyValue := Tid
  else
    lkTeklif.KeyValue := Null;

  edKonu.Text := qLoad.FieldByName('KONU').AsString;
  mmAciklama.Text := qLoad.FieldByName('ACIKLAMA').AsString;
  if qLoad.FieldByName('CARI_KOD').IsNull then
    edCariKod.Text := ''
  else
    edCariKod.Text := qLoad.FieldByName('CARI_KOD').AsString;
  if qLoad.FieldByName('AKTIVITE_TARIHI').IsNull then
    dtAktivite.DateTime := Now
  else
    dtAktivite.DateTime := qLoad.FieldByName('AKTIVITE_TARIHI').AsDateTime;
  if (qLoad.FindField('SIPARIS_NO') <> nil) and not qLoad.FieldByName('SIPARIS_NO').IsNull then
    edSiparis.Text := Trim(qLoad.FieldByName('SIPARIS_NO').AsString)
  else
    edSiparis.Text := '';
  qLoad.Close;
  Caption := 'Aktivite';
end;

procedure TfrmCrmAktivite.UniFormShow(Sender: TObject);
var
  PrefTeklif: Int64;
begin
  FAktiviteId := StrToInt64Def(Trim(Hint), 0);
  PrefTeklif := Tmp.xCrmYeniAktiviteTeklifId;
  Tmp.xCrmYeniAktiviteTeklifId := 0;
  if FAktiviteId > 0 then
    YukleKayit
  else
  begin
    YeniKayit;
    if PrefTeklif > 0 then
      UygulaBaslangicTeklif(PrefTeklif);
  end;
end;

procedure TfrmCrmAktivite.btnKaydetClick(Sender: TObject);
var
  NewId: Int64;
  Tkod, Dkod: string;
begin
  if Trim(edKonu.Text) = '' then
  begin
    UniMainModule.saHata.Show('Konu zorunludur.');
    Exit;
  end;
  if VarIsNull(lkTip.KeyValue) or VarIsEmpty(lkTip.KeyValue) then
  begin
    UniMainModule.saHata.Show('Aktivite tipi seciniz.');
    Exit;
  end;
  if VarIsNull(lkDurum.KeyValue) or VarIsEmpty(lkDurum.KeyValue) then
  begin
    UniMainModule.saHata.Show('Durum seciniz.');
    Exit;
  end;

  Tkod := TipKodFromLookup;
  Dkod := DurumKodFromLookup;
  if SameText(Tkod, 'TASK') then
  begin
    UniMainModule.saHata.Show('TASK tipi yalnizca gorev formundan kullanilir.');
    Exit;
  end;

  if not VarIsNull(lkTeklif.KeyValue) and not VarIsEmpty(lkTeklif.KeyValue) then
  begin
    qLoad.Close;
    qLoad.SQL.Text := 'SELECT CARI_KOD FROM dbo.CRM_TEKLIF WHERE TEKLIF_ID = :T';
    qLoad.ParamByName('T').AsLargeInt := lkTeklif.KeyValue;
    qLoad.Open;
    if not qLoad.IsEmpty and not qLoad.FieldByName('CARI_KOD').IsNull then
    begin
      if (Trim(edCariKod.Text) <> '') and
        not SameText(Trim(edCariKod.Text), Trim(qLoad.FieldByName('CARI_KOD').AsString)) then
      begin
        qLoad.Close;
        UniMainModule.saHata.Show('Secilen teklifin cari kodu ile aktivite carisi uyusmuyor.');
        Exit;
      end;
    end;
    qLoad.Close;
  end;

  qExec.Close;
  qExec.SQL.Clear;
  if FAktiviteId > 0 then
  begin
    qExec.SQL.Add('UPDATE dbo.CRM_AKTIVITE SET TIP = :TIP, KONU = :KONU, ACIKLAMA = :ACIKLAMA, CARI_KOD = :CARI_KOD,');
    qExec.SQL.Add('AKTIVITE_TARIHI = :AKTIVITE_TARIHI, DURUM = :DURUM,');
    qExec.SQL.Add('AKTIVITE_TIP_ID = :TID_REF, AKTIVITE_DURUM_ID = :DID_REF, TEKLIF_ID = :TID_TEK, SIPARIS_NO = :SIPNO, GUNCELLEME_UTC = SYSUTCDATETIME()');
    qExec.SQL.Add('WHERE AKTIVITE_ID = :ID');
    qExec.ParamByName('ID').AsLargeInt := FAktiviteId;
  end
  else
  begin
    qExec.SQL.Add('INSERT INTO dbo.CRM_AKTIVITE (TIP, KONU, ACIKLAMA, CARI_KOD, AKTIVITE_TARIHI, DURUM, OLUSTURAN_KULLANICI_ID, AKTIVITE_TIP_ID, AKTIVITE_DURUM_ID, TEKLIF_ID, SIPARIS_NO)');
    qExec.SQL.Add('OUTPUT INSERTED.AKTIVITE_ID');
    qExec.SQL.Add('VALUES (:TIP, :KONU, :ACIKLAMA, :CARI_KOD, :AKTIVITE_TARIHI, :DURUM, :KUL, :TID_REF, :DID_REF, :TID_TEK, :SIPNO)');
  end;

  qExec.ParamByName('TIP').AsString := Tkod;
  qExec.ParamByName('KONU').AsString := edKonu.Text;
  qExec.ParamByName('ACIKLAMA').AsString := mmAciklama.Text;
  if Trim(edCariKod.Text) <> '' then
    qExec.ParamByName('CARI_KOD').AsString := Trim(edCariKod.Text)
  else
    qExec.ParamByName('CARI_KOD').Clear;
  qExec.ParamByName('AKTIVITE_TARIHI').AsDateTime := dtAktivite.DateTime;
  qExec.ParamByName('DURUM').AsString := Dkod;
  qExec.ParamByName('TID_REF').AsLargeInt := lkTip.KeyValue;
  qExec.ParamByName('DID_REF').AsLargeInt := lkDurum.KeyValue;
  if VarIsNull(lkTeklif.KeyValue) or VarIsEmpty(lkTeklif.KeyValue) then
    qExec.ParamByName('TID_TEK').Clear
  else
    qExec.ParamByName('TID_TEK').AsLargeInt := lkTeklif.KeyValue;
  if Trim(edSiparis.Text) <> '' then
    qExec.ParamByName('SIPNO').AsString := Trim(edSiparis.Text)
  else
    qExec.ParamByName('SIPNO').Clear;
  if FAktiviteId <= 0 then
    qExec.ParamByName('KUL').AsInteger := Tmp.xKullaniciID;

  if FAktiviteId > 0 then
    qExec.Execute
  else
  begin
    qExec.Open;
    if qExec.Fields[0].IsNull then
      NewId := 0
    else
      NewId := qExec.Fields[0].AsLargeInt;
    qExec.Close;
    FAktiviteId := NewId;
  end;

  UniMainModule.saKaydet.Show('Aktivite kaydedildi.');
  if FAktiviteId > 0 then
    Caption := 'Aktivite';
end;

end.
