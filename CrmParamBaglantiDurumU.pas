unit CrmParamBaglantiDurumU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniButton, uniBasicGrid, uniDBGrid, uniCheckBox, uniComboBox,
  uniDBLookupComboBox, Data.DB, MemDS, DBAccess, Uni;

type
  TfrmCrmParamBaglantiDurum = class(TUniForm)
    rootPanel: TUniPanel;
    pnlToolbar: TUniPanel;
    btnListele: TUniButton;
    btnYeni: TUniButton;
    btnKaydet: TUniButton;
    btnKapat: TUniButton;
    grd: TUniDBGrid;
    panDetay: TUniPanel;
    lblKaynak: TUniLabel;
    cbKaynak: TUniComboBox;
    lblHedefDurum: TUniLabel;
    lkHedefDurum: TUniDBLookupComboBox;
    chkPrompt: TUniCheckBox;
    chkSessiz: TUniCheckBox;
    chkAktif: TUniCheckBox;
    lblSira: TUniLabel;
    edSira: TUniEdit;
    qKural: TUniQuery;
    dsKural: TUniDataSource;
    qExec: TUniQuery;
    qDurLkp: TUniQuery;
    dsDurLkp: TUniDataSource;
    procedure UniFormShow(Sender: TObject);
    procedure btnListeleClick(Sender: TObject);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure dsKuralDataChange(Sender: TObject; Field: TField);
  private
    FYeni: Boolean;
    procedure KaynakCombosuDoldur;
    procedure DurumLookupAc;
    procedure DetayYukle;
    function KaynakKodFromCombo: string;
    procedure KaynakComboSet(const AKod: string);
  public
  end;

function frmCrmParamBaglantiDurum: TfrmCrmParamBaglantiDurum;

implementation

{$R *.dfm}

uses
  uniGUIApplication, MainModule, DMU, Main, CrmBaglantiDurumU;

function frmCrmParamBaglantiDurum: TfrmCrmParamBaglantiDurum;
begin
  Result := TfrmCrmParamBaglantiDurum(UniMainModule.GetFormInstance(TfrmCrmParamBaglantiDurum));
end;

procedure TfrmCrmParamBaglantiDurum.KaynakCombosuDoldur;
begin
  cbKaynak.Items.Clear;
  cbKaynak.Items.Add(CrmKaynakTipAciklama(CRM_KAYNAK_TEKLIF));
  cbKaynak.Items.Add(CrmKaynakTipAciklama(CRM_KAYNAK_SIPARIS));
  cbKaynak.Items.Add(CrmKaynakTipAciklama(CRM_KAYNAK_GOREV_TAM));
  cbKaynak.Items.Add(CrmKaynakTipAciklama(CRM_KAYNAK_KAPANIS));
end;

function TfrmCrmParamBaglantiDurum.KaynakKodFromCombo: string;
begin
  case cbKaynak.ItemIndex of
    0: Result := CRM_KAYNAK_TEKLIF;
    1: Result := CRM_KAYNAK_SIPARIS;
    2: Result := CRM_KAYNAK_GOREV_TAM;
    3: Result := CRM_KAYNAK_KAPANIS;
  else
    Result := '';
  end;
end;

procedure TfrmCrmParamBaglantiDurum.KaynakComboSet(const AKod: string);
begin
  if SameText(AKod, CRM_KAYNAK_TEKLIF) then
    cbKaynak.ItemIndex := 0
  else if SameText(AKod, CRM_KAYNAK_SIPARIS) then
    cbKaynak.ItemIndex := 1
  else if SameText(AKod, CRM_KAYNAK_GOREV_TAM) then
    cbKaynak.ItemIndex := 2
  else if SameText(AKod, CRM_KAYNAK_KAPANIS) then
    cbKaynak.ItemIndex := 3
  else
    cbKaynak.ItemIndex := -1;
end;

procedure TfrmCrmParamBaglantiDurum.DurumLookupAc;
begin
  qDurLkp.Close;
  qDurLkp.SQL.Text :=
    'SELECT DURUM_ID, (KOD + N'' - '' + ISNULL(ACIKLAMA, N'''')) AS AD ' +
    'FROM dbo.CRM_AKTIVITE_DURUM WHERE AKTIF = 1 ORDER BY SIRA, DURUM_ID';
  qDurLkp.Open;
end;

procedure TfrmCrmParamBaglantiDurum.DetayYukle;
begin
  FYeni := False;
  if not qKural.Active or qKural.IsEmpty then
  begin
    cbKaynak.ItemIndex := -1;
    lkHedefDurum.KeyValue := Null;
    chkPrompt.Checked := True;
    chkSessiz.Checked := False;
    chkAktif.Checked := True;
    edSira.Text := '0';
    Exit;
  end;
  KaynakComboSet(qKural.FieldByName('KAYNAK_TIP').AsString);
  lkHedefDurum.KeyValue := qKural.FieldByName('HEDEF_DURUM_ID').AsLargeInt;
  chkPrompt.Checked := qKural.FieldByName('PROMPT_KULLANICI').AsBoolean;
  chkSessiz.Checked := qKural.FieldByName('SESSIZ_UYGULA').AsBoolean;
  chkAktif.Checked := qKural.FieldByName('AKTIF').AsBoolean;
  edSira.Text := IntToStr(qKural.FieldByName('SIRA').AsInteger);
end;

procedure TfrmCrmParamBaglantiDurum.dsKuralDataChange(Sender: TObject; Field: TField);
begin
  if not (csLoading in ComponentState) then
    DetayYukle;
end;

procedure TfrmCrmParamBaglantiDurum.UniFormShow(Sender: TObject);
begin
  KaynakCombosuDoldur;
  DurumLookupAc;
  FYeni := False;
  btnListeleClick(Sender);
end;

procedure TfrmCrmParamBaglantiDurum.btnListeleClick(Sender: TObject);
begin
  qKural.Close;
  qKural.SQL.Text :=
    'SELECT K.KURAL_ID, K.KAYNAK_TIP, K.HEDEF_DURUM_ID, K.PROMPT_KULLANICI, K.SESSIZ_UYGULA, K.AKTIF, K.SIRA, ' +
    'D.KOD + N'' - '' + ISNULL(D.ACIKLAMA, N'''') AS HEDEF_DURUM_AD ' +
    'FROM dbo.CRM_BAGLANTI_DURUM_KURAL K ' +
    'INNER JOIN dbo.CRM_AKTIVITE_DURUM D ON D.DURUM_ID = K.HEDEF_DURUM_ID ' +
    'ORDER BY K.SIRA, K.KURAL_ID';
  qKural.Open;
  DetayYukle;
end;

procedure TfrmCrmParamBaglantiDurum.btnYeniClick(Sender: TObject);
begin
  FYeni := True;
  cbKaynak.ItemIndex := 0;
  lkHedefDurum.KeyValue := Null;
  if qDurLkp.Active and not qDurLkp.IsEmpty then
    lkHedefDurum.KeyValue := qDurLkp.FieldByName('DURUM_ID').AsLargeInt;
  chkPrompt.Checked := True;
  chkSessiz.Checked := False;
  chkAktif.Checked := True;
  edSira.Text := '0';
end;

procedure TfrmCrmParamBaglantiDurum.btnKaydetClick(Sender: TObject);
var
  Kid: Int64;
  Sira: Integer;
  Kkod: string;
begin
  Kkod := KaynakKodFromCombo;
  if Kkod = '' then
  begin
    UniMainModule.saHata.Show('Kaynak tipi se'#231'iniz.');
    Exit;
  end;
  if VarIsNull(lkHedefDurum.KeyValue) or VarIsEmpty(lkHedefDurum.KeyValue) then
  begin
    UniMainModule.saHata.Show('Hedef durum se'#231'iniz.');
    Exit;
  end;
  Sira := StrToIntDef(Trim(edSira.Text), 0);
  qExec.Close;
  if FYeni then
  begin
    qExec.SQL.Text :=
      'INSERT INTO dbo.CRM_BAGLANTI_DURUM_KURAL (KAYNAK_TIP, HEDEF_DURUM_ID, PROMPT_KULLANICI, SESSIZ_UYGULA, AKTIF, SIRA) ' +
      'VALUES (:KT, :HD, :PR, :SE, :AK, :SR)';
  end
  else
  begin
    if not qKural.Active or qKural.IsEmpty then
    begin
      UniMainModule.saHata.Show(#214'nce bir sat'#305'r se'#231'in veya Yeni ile ekleyin.');
      Exit;
    end;
    Kid := qKural.FieldByName('KURAL_ID').AsLargeInt;
    qExec.SQL.Text :=
      'UPDATE dbo.CRM_BAGLANTI_DURUM_KURAL SET KAYNAK_TIP = :KT, HEDEF_DURUM_ID = :HD, ' +
      'PROMPT_KULLANICI = :PR, SESSIZ_UYGULA = :SE, AKTIF = :AK, SIRA = :SR WHERE KURAL_ID = :ID';
    qExec.ParamByName('ID').AsLargeInt := Kid;
  end;
  qExec.ParamByName('KT').AsString := Kkod;
  qExec.ParamByName('HD').AsLargeInt := lkHedefDurum.KeyValue;
  qExec.ParamByName('PR').AsBoolean := chkPrompt.Checked;
  qExec.ParamByName('SE').AsBoolean := chkSessiz.Checked;
  qExec.ParamByName('AK').AsBoolean := chkAktif.Checked;
  qExec.ParamByName('SR').AsInteger := Sira;
  try
    qExec.Execute;
  except
    on E: Exception do
    begin
      UniMainModule.saHata.Show('Kay'#305't hatas'#305': ' + E.Message);
      Exit;
    end;
  end;
  UniMainModule.saKaydet.Show('Kaydedildi.');
  FYeni := False;
  btnListeleClick(Sender);
end;

procedure TfrmCrmParamBaglantiDurum.btnKapatClick(Sender: TObject);
begin
  MainForm.NavPage.ActivePage.Close;
end;

end.
