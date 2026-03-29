unit CrmGorevU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniMemo, uniComboBox, uniDateTimePicker, uniButton,
  uniDBLookupComboBox, Data.DB, MemDS, DBAccess, Uni;

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
    lblBitis: TUniLabel;
    dtBitis: TUniDateTimePicker;
    lblOncelik: TUniLabel;
    cbOncelik: TUniComboBox;
    lblAtanan: TUniLabel;
    lkAtanan: TUniDBLookupComboBox;
    lblDurum: TUniLabel;
    cbDurum: TUniComboBox;
    panFooter: TUniPanel;
    btnKaydet: TUniButton;
    qKullanici: TUniQuery;
    dsKullanici: TUniDataSource;
    qInsAkt: TUniQuery;
    qLoad: TUniQuery;
    qInsGor: TUniQuery;
    procedure UniFormShow(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnCariBulClick(Sender: TObject);
  private
    FAktiviteId: Int64;
    procedure YukleCombos;
    procedure SetComboByText(ACombo: TUniComboBox; const AText: string);
    procedure KullanicilariAc;
    procedure YeniGorevState;
    procedure YukleGorev;
  public
    { Public declarations }
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

procedure TfrmCrmGorev.YukleCombos;
begin
  cbOncelik.Items.Clear;
  cbOncelik.Items.Add('DUSUK');
  cbOncelik.Items.Add('NORMAL');
  cbOncelik.Items.Add('YUKSEK');
  cbOncelik.Items.Add('ACIL');
  cbOncelik.ItemIndex := 1;

  cbDurum.Items.Clear;
  cbDurum.Items.Add('ACIK');
  cbDurum.Items.Add('TAMAMLANDI');
  cbDurum.Items.Add('IPTAL');
  cbDurum.ItemIndex := 0;
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

procedure TfrmCrmGorev.YeniGorevState;
begin
  FAktiviteId := 0;
  Caption := 'Yeni Gorev';
  edKonu.Text := '';
  mmAciklama.Text := '';
  edCariKod.Text := '';
  dtBitis.DateTime := Now;
  YukleCombos;
  lkAtanan.KeyValue := Tmp.xKullaniciID;
end;

procedure TfrmCrmGorev.YukleGorev;
begin
  qLoad.Close;
  qLoad.SQL.Text :=
    'SELECT A.KONU, A.ACIKLAMA, A.CARI_KOD, A.DURUM, G.BITIS_TARIHI, G.ONCELIK, G.TAMAMLANDI, G.ATANAN_KULLANICI_ID ' +
    'FROM dbo.CRM_AKTIVITE A INNER JOIN dbo.CRM_GOREV G ON G.AKTIVITE_ID = A.AKTIVITE_ID ' +
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
  YukleCombos;
  edKonu.Text := qLoad.FieldByName('KONU').AsString;
  mmAciklama.Text := qLoad.FieldByName('ACIKLAMA').AsString;
  if qLoad.FieldByName('CARI_KOD').IsNull then
    edCariKod.Text := ''
  else
    edCariKod.Text := qLoad.FieldByName('CARI_KOD').AsString;
  if qLoad.FieldByName('BITIS_TARIHI').IsNull then
    dtBitis.DateTime := Now
  else
    dtBitis.DateTime := qLoad.FieldByName('BITIS_TARIHI').AsDateTime;
  SetComboByText(cbOncelik, qLoad.FieldByName('ONCELIK').AsString);
  if qLoad.FieldByName('TAMAMLANDI').AsBoolean then
    SetComboByText(cbDurum, 'TAMAMLANDI')
  else
    SetComboByText(cbDurum, qLoad.FieldByName('DURUM').AsString);
  if qLoad.FieldByName('ATANAN_KULLANICI_ID').IsNull then
    lkAtanan.KeyValue := Null
  else
    lkAtanan.KeyValue := qLoad.FieldByName('ATANAN_KULLANICI_ID').AsInteger;
  qLoad.Close;
  Caption := 'Gorev';
end;

procedure TfrmCrmGorev.UniFormShow(Sender: TObject);
begin
  KullanicilariAc;
  FAktiviteId := StrToInt64Def(Trim(Hint), 0);
  if FAktiviteId > 0 then
    YukleGorev
  else
    YeniGorevState;
end;

procedure TfrmCrmGorev.btnKaydetClick(Sender: TObject);
var
  Aid: Int64;
  Tamam: Integer;
begin
  if Trim(edKonu.Text) = '' then
  begin
    UniMainModule.saHata.Show('Konu zorunludur.');
    Exit;
  end;

  Tamam := 0;
  if cbDurum.Text = 'TAMAMLANDI' then
    Tamam := 1;

  if FAktiviteId > 0 then
  begin
    Aid := FAktiviteId;
    qInsAkt.Close;
    qInsAkt.SQL.Clear;
    qInsAkt.SQL.Add('UPDATE dbo.CRM_AKTIVITE SET KONU = :KONU, ACIKLAMA = :ACIKLAMA, CARI_KOD = :CARI_KOD,');
    qInsAkt.SQL.Add('DURUM = :DURUM, GUNCELLEME_UTC = SYSUTCDATETIME() WHERE AKTIVITE_ID = :AID AND TIP = ''TASK''');
    qInsAkt.ParamByName('AID').AsLargeInt := Aid;
    qInsAkt.ParamByName('KONU').AsString := edKonu.Text;
    qInsAkt.ParamByName('ACIKLAMA').AsString := mmAciklama.Text;
    if Trim(edCariKod.Text) <> '' then
      qInsAkt.ParamByName('CARI_KOD').AsString := Trim(edCariKod.Text)
    else
      qInsAkt.ParamByName('CARI_KOD').Clear;
    qInsAkt.ParamByName('DURUM').AsString := cbDurum.Text;
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
    qInsAkt.Close;
    qInsAkt.SQL.Clear;
    qInsAkt.SQL.Add('INSERT INTO dbo.CRM_AKTIVITE (TIP, KONU, ACIKLAMA, CARI_KOD, AKTIVITE_TARIHI, DURUM, OLUSTURAN_KULLANICI_ID)');
    qInsAkt.SQL.Add('OUTPUT INSERTED.AKTIVITE_ID');
    qInsAkt.SQL.Add('VALUES (''TASK'', :KONU, :ACIKLAMA, :CARI_KOD, :AKTAR, :DURUM, :KUL)');
    qInsAkt.ParamByName('KONU').AsString := edKonu.Text;
    qInsAkt.ParamByName('ACIKLAMA').AsString := mmAciklama.Text;
    if Trim(edCariKod.Text) <> '' then
      qInsAkt.ParamByName('CARI_KOD').AsString := Trim(edCariKod.Text)
    else
      qInsAkt.ParamByName('CARI_KOD').Clear;
    qInsAkt.ParamByName('AKTAR').AsDateTime := Now;
    qInsAkt.ParamByName('DURUM').AsString := cbDurum.Text;
    qInsAkt.ParamByName('KUL').AsInteger := Tmp.xKullaniciID;
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
