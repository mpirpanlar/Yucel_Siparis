unit CrmAktiviteU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniMemo, uniComboBox, uniDateTimePicker, uniButton, Data.DB,
  MemDS, DBAccess, Uni;

type
  TfrmCrmAktivite = class(TUniForm)
    rootPanel: TUniPanel;
    panMain: TUniPanel;
    lblTip: TUniLabel;
    cbTip: TUniComboBox;
    lblKonu: TUniLabel;
    edKonu: TUniEdit;
    lblAciklama: TUniLabel;
    mmAciklama: TUniMemo;
    lblCari: TUniLabel;
    edCariKod: TUniEdit;
    btnCariBul: TUniButton;
    lblTarih: TUniLabel;
    dtAktivite: TUniDateTimePicker;
    lblDurum: TUniLabel;
    cbDurum: TUniComboBox;
    panFooter: TUniPanel;
    btnKaydet: TUniButton;
    qExec: TUniQuery;
    qLoad: TUniQuery;
    procedure UniFormShow(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnCariBulClick(Sender: TObject);
  private
    FAktiviteId: Int64;
    procedure YukleCombos;
    procedure SetComboByText(ACombo: TUniComboBox; const AText: string);
    procedure YeniKayit;
    procedure YukleKayit;
  public
    { Public declarations }
  end;

function frmCrmAktivite: TfrmCrmAktivite;

implementation

{$R *.dfm}

uses
  uniGUIApplication, MainModule, DMU, TmpU, CrmCariSecU;

procedure TfrmCrmAktivite.btnCariBulClick(Sender: TObject);
begin
  frmCrmCariSec.HedefCariEdit := edCariKod;
  frmCrmCariSec.edArama.Text := Trim(edCariKod.Text);
  frmCrmCariSec.ShowModal;
end;

function frmCrmAktivite: TfrmCrmAktivite;
begin
  Result := TfrmCrmAktivite(UniMainModule.GetFormInstance(TfrmCrmAktivite));
end;

procedure TfrmCrmAktivite.YukleCombos;
begin
  cbTip.Items.Clear;
  cbTip.Items.Add('CALL');
  cbTip.Items.Add('MEETING');
  cbTip.Items.Add('EMAIL');
  cbTip.Items.Add('NOTE');
  cbTip.Items.Add('OTHER');
  cbTip.ItemIndex := 0;

  cbDurum.Items.Clear;
  cbDurum.Items.Add('ACIK');
  cbDurum.Items.Add('TAMAMLANDI');
  cbDurum.Items.Add('IPTAL');
  cbDurum.ItemIndex := 0;
end;

procedure TfrmCrmAktivite.SetComboByText(ACombo: TUniComboBox; const AText: string);
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

procedure TfrmCrmAktivite.YeniKayit;
begin
  FAktiviteId := 0;
  Caption := 'Yeni Aktivite';
  edKonu.Text := '';
  mmAciklama.Text := '';
  edCariKod.Text := '';
  dtAktivite.DateTime := Now;
  YukleCombos;
end;

procedure TfrmCrmAktivite.YukleKayit;
begin
  qLoad.Close;
  qLoad.SQL.Text :=
    'SELECT TIP, KONU, ACIKLAMA, CARI_KOD, AKTIVITE_TARIHI, DURUM FROM dbo.CRM_AKTIVITE WHERE AKTIVITE_ID = :ID';
  qLoad.ParamByName('ID').AsLargeInt := FAktiviteId;
  qLoad.Open;
  if qLoad.IsEmpty then
  begin
    qLoad.Close;
    UniMainModule.saHata.Show('Aktivite bulunamadi.');
    YeniKayit;
    Exit;
  end;
  if SameText(qLoad.FieldByName('TIP').AsString, 'TASK') then
  begin
    qLoad.Close;
    UniMainModule.saHata.Show('Bu kayit gorev tipindedir; Gorev listesinden aciniz.');
    YeniKayit;
    Exit;
  end;
  YukleCombos;
  SetComboByText(cbTip, qLoad.FieldByName('TIP').AsString);
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
  SetComboByText(cbDurum, qLoad.FieldByName('DURUM').AsString);
  qLoad.Close;
  Caption := 'Aktivite';
end;

procedure TfrmCrmAktivite.UniFormShow(Sender: TObject);
begin
  FAktiviteId := StrToInt64Def(Trim(Hint), 0);
  if FAktiviteId > 0 then
    YukleKayit
  else
    YeniKayit;
end;

procedure TfrmCrmAktivite.btnKaydetClick(Sender: TObject);
var
  NewId: Int64;
begin
  if Trim(edKonu.Text) = '' then
  begin
    UniMainModule.saHata.Show('Konu zorunludur.');
    Exit;
  end;
  qExec.Close;
  qExec.SQL.Clear;
  if FAktiviteId > 0 then
  begin
    qExec.SQL.Add('UPDATE dbo.CRM_AKTIVITE SET TIP = :TIP, KONU = :KONU, ACIKLAMA = :ACIKLAMA, CARI_KOD = :CARI_KOD,');
    qExec.SQL.Add('AKTIVITE_TARIHI = :AKTIVITE_TARIHI, DURUM = :DURUM, GUNCELLEME_UTC = SYSUTCDATETIME()');
    qExec.SQL.Add('WHERE AKTIVITE_ID = :ID');
    qExec.ParamByName('ID').AsLargeInt := FAktiviteId;
  end
  else
  begin
    qExec.SQL.Add('INSERT INTO dbo.CRM_AKTIVITE (TIP, KONU, ACIKLAMA, CARI_KOD, AKTIVITE_TARIHI, DURUM, OLUSTURAN_KULLANICI_ID)');
    qExec.SQL.Add('OUTPUT INSERTED.AKTIVITE_ID');
    qExec.SQL.Add('VALUES (:TIP, :KONU, :ACIKLAMA, :CARI_KOD, :AKTIVITE_TARIHI, :DURUM, :KUL)');
  end;
  qExec.ParamByName('TIP').AsString := cbTip.Text;
  qExec.ParamByName('KONU').AsString := edKonu.Text;
  qExec.ParamByName('ACIKLAMA').AsString := mmAciklama.Text;
  if Trim(edCariKod.Text) <> '' then
    qExec.ParamByName('CARI_KOD').AsString := Trim(edCariKod.Text)
  else
    qExec.ParamByName('CARI_KOD').Clear;
  qExec.ParamByName('AKTIVITE_TARIHI').AsDateTime := dtAktivite.DateTime;
  qExec.ParamByName('DURUM').AsString := cbDurum.Text;
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
