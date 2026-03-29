unit CrmParamAktiviteTipU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniButton, uniBasicGrid, uniDBGrid, uniDBLookupComboBox,
  uniCheckBox, Data.DB, MemDS, DBAccess, Uni;

type
  TfrmCrmParamAktiviteTip = class(TUniForm)
    rootPanel: TUniPanel;
    pnlToolbar: TUniPanel;
    btnListele: TUniButton;
    btnYeni: TUniButton;
    btnKaydet: TUniButton;
    btnKapat: TUniButton;
    grd: TUniDBGrid;
    qTip: TUniQuery;
    dsTip: TUniDataSource;
    panDetay: TUniPanel;
    lblKod: TUniLabel;
    edKod: TUniEdit;
    lblAciklama: TUniLabel;
    edAciklama: TUniEdit;
    lblUst: TUniLabel;
    lkUst: TUniDBLookupComboBox;
    qUst: TUniQuery;
    dsUst: TUniDataSource;
    chkAktif: TUniCheckBox;
    lblSira: TUniLabel;
    edSira: TUniEdit;
    qExec: TUniQuery;
    procedure UniFormShow(Sender: TObject);
    procedure btnListeleClick(Sender: TObject);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure dsTipDataChange(Sender: TObject; Field: TField);
  private
    FYeni: Boolean;
    procedure UstListeyiAc;
    procedure DetayYukle;
  public
  end;

function frmCrmParamAktiviteTip: TfrmCrmParamAktiviteTip;

implementation

{$R *.dfm}

uses
  uniGUIApplication, MainModule, DMU, Main;

function frmCrmParamAktiviteTip: TfrmCrmParamAktiviteTip;
begin
  Result := TfrmCrmParamAktiviteTip(UniMainModule.GetFormInstance(TfrmCrmParamAktiviteTip));
end;

procedure TfrmCrmParamAktiviteTip.UstListeyiAc;
begin
  qUst.Close;
  qUst.SQL.Text :=
    'SELECT TIP_ID, KOD, (KOD + N'' - '' + ISNULL(ACIKLAMA, N'''')) AS AD ' +
    'FROM dbo.CRM_AKTIVITE_TIP WHERE AKTIF = 1 ORDER BY SIRA, TIP_ID';
  qUst.Open;
end;

procedure TfrmCrmParamAktiviteTip.DetayYukle;
var
  Tid: Int64;
begin
  FYeni := False;
  if not qTip.Active or qTip.IsEmpty then
  begin
    edKod.Text := '';
    edAciklama.Text := '';
    lkUst.KeyValue := Null;
    chkAktif.Checked := True;
    edSira.Text := '0';
    edKod.ReadOnly := False;
    Exit;
  end;
  Tid := qTip.FieldByName('TIP_ID').AsLargeInt;
  edKod.Text := qTip.FieldByName('KOD').AsString;
  edAciklama.Text := qTip.FieldByName('ACIKLAMA').AsString;
  if qTip.FieldByName('UST_TIP_ID').IsNull then
    lkUst.KeyValue := Null
  else
    lkUst.KeyValue := qTip.FieldByName('UST_TIP_ID').AsLargeInt;
  chkAktif.Checked := qTip.FieldByName('AKTIF').AsBoolean;
  edSira.Text := IntToStr(qTip.FieldByName('SIRA').AsInteger);
  edKod.ReadOnly := SameText(Trim(edKod.Text), 'TASK');
  UstListeyiAc;
  if not qTip.FieldByName('UST_TIP_ID').IsNull then
    lkUst.KeyValue := qTip.FieldByName('UST_TIP_ID').AsLargeInt;
end;

procedure TfrmCrmParamAktiviteTip.dsTipDataChange(Sender: TObject; Field: TField);
begin
  if not (csLoading in ComponentState) then
    DetayYukle;
end;

procedure TfrmCrmParamAktiviteTip.UniFormShow(Sender: TObject);
begin
  FYeni := False;
  btnListeleClick(Sender);
end;

procedure TfrmCrmParamAktiviteTip.btnListeleClick(Sender: TObject);
begin
  qTip.Close;
  qTip.SQL.Text :=
    'SELECT TIP_ID, KOD, ACIKLAMA, UST_TIP_ID, AKTIF, SIRA FROM dbo.CRM_AKTIVITE_TIP ORDER BY SIRA, TIP_ID';
  qTip.Open;
  UstListeyiAc;
  DetayYukle;
end;

procedure TfrmCrmParamAktiviteTip.btnYeniClick(Sender: TObject);
begin
  FYeni := True;
  edKod.Text := '';
  edAciklama.Text := '';
  lkUst.KeyValue := Null;
  chkAktif.Checked := True;
  edSira.Text := '0';
  edKod.ReadOnly := False;
end;

procedure TfrmCrmParamAktiviteTip.btnKaydetClick(Sender: TObject);
var
  UstId: Variant;
  Sira: Integer;
  Tid: Int64;
begin
  if Trim(edKod.Text) = '' then
  begin
    UniMainModule.saHata.Show('Kod zorunludur.');
    Exit;
  end;
  Sira := StrToIntDef(Trim(edSira.Text), 0);
  if VarIsNull(lkUst.KeyValue) or VarIsEmpty(lkUst.KeyValue) or (Trim(lkUst.Text) = '') then
    UstId := Null
  else
    UstId := lkUst.KeyValue;

  qExec.Close;
  if FYeni then
  begin
    qExec.SQL.Text :=
      'INSERT INTO dbo.CRM_AKTIVITE_TIP (KOD, ACIKLAMA, UST_TIP_ID, AKTIF, SIRA) ' +
      'VALUES (:KOD, :ACIK, :UST, :AKT, :SIRA)';
  end
  else
  begin
    if not qTip.Active or qTip.IsEmpty then
    begin
      UniMainModule.saHata.Show('Once bir satir secin veya Yeni ile ekleyin.');
      Exit;
    end;
    Tid := qTip.FieldByName('TIP_ID').AsLargeInt;
    if not (VarIsNull(UstId) or VarIsEmpty(UstId)) and (UstId = Tid) then
    begin
      UniMainModule.saHata.Show('Ust tip kendi kaydina isaret edemez.');
      Exit;
    end;
    qExec.SQL.Text :=
      'UPDATE dbo.CRM_AKTIVITE_TIP SET KOD = :KOD, ACIKLAMA = :ACIK, UST_TIP_ID = :UST, AKTIF = :AKT, SIRA = :SIRA ' +
      'WHERE TIP_ID = :TID';
    qExec.ParamByName('TID').AsLargeInt := Tid;
  end;
  qExec.ParamByName('KOD').AsString := UpperCase(Trim(edKod.Text));
  qExec.ParamByName('ACIK').AsString := edAciklama.Text;
  if VarIsNull(UstId) or VarIsEmpty(UstId) then
    qExec.ParamByName('UST').Clear
  else
    qExec.ParamByName('UST').AsLargeInt := UstId;
  qExec.ParamByName('AKT').AsBoolean := chkAktif.Checked;
  qExec.ParamByName('SIRA').AsInteger := Sira;
  try
    qExec.Execute;
  except
    on E: Exception do
    begin
      UniMainModule.saHata.Show('Kayit hatasi: ' + E.Message);
      Exit;
    end;
  end;

  if not FYeni then
  begin
    Tid := qTip.FieldByName('TIP_ID').AsLargeInt;
    qExec.SQL.Text :=
      'UPDATE dbo.CRM_AKTIVITE SET TIP = :KOD WHERE AKTIVITE_TIP_ID = :TID';
    qExec.ParamByName('KOD').AsString := UpperCase(Trim(edKod.Text));
    qExec.ParamByName('TID').AsLargeInt := Tid;
    qExec.Execute;
  end;

  UniMainModule.saKaydet.Show('Kaydedildi.');
  FYeni := False;
  btnListeleClick(Sender);
end;

procedure TfrmCrmParamAktiviteTip.btnKapatClick(Sender: TObject);
begin
  MainForm.NavPage.ActivePage.Close;
end;

end.
