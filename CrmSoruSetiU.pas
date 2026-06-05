unit CrmSoruSetiU;

{ CRM Aktivite Kontrol Listesi yonetimi:
  - Soru setleri (CRM_SORU_SETI)
  - Sorular (CRM_SORU) ve secenekleri (CRM_SORU_SECENEK)
  - Aktivite tipi - soru seti atamalari (CRM_TIP_SORU_SETI) }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniMemo, uniButton, uniBasicGrid, uniDBGrid, uniDBLookupComboBox,
  uniCheckBox, Data.DB, MemDS, DBAccess, Uni, uniMultiItem, uniComboBox,
  uniDBComboBox, uniPageControl;

type
  TfrmCrmSoruSeti = class(TUniForm)
    rootPanel: TUniPanel;
    pgc: TUniPageControl;
    tsSet: TUniTabSheet;
    tsAtama: TUniTabSheet;
    panSetTb: TUniPanel;
    btnListele: TUniButton;
    btnYeniSet: TUniButton;
    btnSetKaydet: TUniButton;
    btnSetSil: TUniButton;
    btnKapat: TUniButton;
    grdSet: TUniDBGrid;
    panSetDetay: TUniPanel;
    lblKod: TUniLabel;
    edKod: TUniEdit;
    lblBaslik: TUniLabel;
    edBaslik: TUniEdit;
    lblSetAciklama: TUniLabel;
    edSetAciklama: TUniEdit;
    chkSetAktif: TUniCheckBox;
    lblSetSira: TUniLabel;
    edSetSira: TUniEdit;
    panSoruTb: TUniPanel;
    lblSorular: TUniLabel;
    btnSoruYeni: TUniButton;
    btnSoruKaydet: TUniButton;
    btnSoruSil: TUniButton;
    grdSoru: TUniDBGrid;
    panSoruDetay: TUniPanel;
    lblSoruMetni: TUniLabel;
    edSoruMetni: TUniMemo;
    lblCevapTipi: TUniLabel;
    cbCevapTipi: TUniComboBox;
    chkZorunlu: TUniCheckBox;
    chkSoruAktif: TUniCheckBox;
    lblSoruSira: TUniLabel;
    edSoruSira: TUniEdit;
    lblSecenekler: TUniLabel;
    grdSec: TUniDBGrid;
    edSecMetin: TUniEdit;
    edSecSira: TUniEdit;
    btnSecEkle: TUniButton;
    btnSecSil: TUniButton;
    panAtamaTb: TUniPanel;
    lblAtamaTip: TUniLabel;
    lkTip: TUniDBLookupComboBox;
    grdAtama: TUniDBGrid;
    lblSetEkle: TUniLabel;
    lkSetEkle: TUniDBLookupComboBox;
    chkAtaZorunlu: TUniCheckBox;
    btnAta: TUniButton;
    btnAtaKaldir: TUniButton;
    qSet: TUniQuery;
    dsSet: TUniDataSource;
    qSoru: TUniQuery;
    dsSoru: TUniDataSource;
    qSec: TUniQuery;
    dsSec: TUniDataSource;
    qTipLkp: TUniQuery;
    dsTipLkp: TUniDataSource;
    qSetLkp: TUniQuery;
    dsSetLkp: TUniDataSource;
    qAtama: TUniQuery;
    dsAtama: TUniDataSource;
    qExec: TUniQuery;
    procedure UniFormShow(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure btnListeleClick(Sender: TObject);
    procedure btnYeniSetClick(Sender: TObject);
    procedure btnSetKaydetClick(Sender: TObject);
    procedure btnSetSilClick(Sender: TObject);
    procedure dsSetDataChange(Sender: TObject; Field: TField);
    procedure btnSoruYeniClick(Sender: TObject);
    procedure btnSoruKaydetClick(Sender: TObject);
    procedure btnSoruSilClick(Sender: TObject);
    procedure dsSoruDataChange(Sender: TObject; Field: TField);
    procedure btnSecEkleClick(Sender: TObject);
    procedure btnSecSilClick(Sender: TObject);
    procedure lkTipCloseUp(Sender: TObject);
    procedure btnAtaClick(Sender: TObject);
    procedure btnAtaKaldirClick(Sender: TObject);
  private
    FYeniSet: Boolean;
    FYeniSoru: Boolean;
    function CurrentSetId: Int64;
    function CurrentSoruId: Int64;
    function CevapTipiKod: string;
    procedure CevapTipiYukle;
    procedure CevapTipiSec(const AKod: string);
    procedure SetleriListele;
    procedure SetDetayTemizle;
    procedure SetDetayYukle;
    procedure SorulariListele;
    procedure SoruDetayTemizle;
    procedure SoruDetayYukle;
    procedure SecenekleriListele;
    procedure TipLookupAc;
    procedure SetLookupAc;
    procedure AtamalariListele;
  public
  end;

function frmCrmSoruSeti: TfrmCrmSoruSeti;

implementation

{$R *.dfm}

uses
  uniGUIApplication, MainModule, DMU, Main;

const
  CT_KODLAR: array[0..6] of string =
    ('EVET_HAYIR', 'TEK_SECIM', 'COK_SECIM', 'METIN', 'SAYI', 'TARIH', 'PUAN');

function frmCrmSoruSeti: TfrmCrmSoruSeti;
begin
  Result := TfrmCrmSoruSeti(UniMainModule.GetFormInstance(TfrmCrmSoruSeti));
end;

function TfrmCrmSoruSeti.CurrentSetId: Int64;
begin
  Result := 0;
  if qSet.Active and not qSet.IsEmpty and not qSet.FieldByName('SET_ID').IsNull then
    Result := qSet.FieldByName('SET_ID').AsLargeInt;
end;

function TfrmCrmSoruSeti.CurrentSoruId: Int64;
begin
  Result := 0;
  if qSoru.Active and not qSoru.IsEmpty and not qSoru.FieldByName('SORU_ID').IsNull then
    Result := qSoru.FieldByName('SORU_ID').AsLargeInt;
end;

procedure TfrmCrmSoruSeti.CevapTipiYukle;
begin
  cbCevapTipi.Items.Clear;
  cbCevapTipi.Items.Add('Evet/Hay' + #$0131 + 'r');
  cbCevapTipi.Items.Add('Tek Se' + #$00E7 + 'im');
  cbCevapTipi.Items.Add(#$00C7 + 'ok Se' + #$00E7 + 'im');
  cbCevapTipi.Items.Add('Metin');
  cbCevapTipi.Items.Add('Say' + #$0131);
  cbCevapTipi.Items.Add('Tarih');
  cbCevapTipi.Items.Add('Puan (1-5)');
  cbCevapTipi.ItemIndex := 3;
end;

function TfrmCrmSoruSeti.CevapTipiKod: string;
begin
  if (cbCevapTipi.ItemIndex >= 0) and (cbCevapTipi.ItemIndex <= High(CT_KODLAR)) then
    Result := CT_KODLAR[cbCevapTipi.ItemIndex]
  else
    Result := 'METIN';
end;

procedure TfrmCrmSoruSeti.CevapTipiSec(const AKod: string);
var
  I: Integer;
begin
  for I := 0 to High(CT_KODLAR) do
    if SameText(CT_KODLAR[I], AKod) then
    begin
      cbCevapTipi.ItemIndex := I;
      Exit;
    end;
  cbCevapTipi.ItemIndex := 3;
end;

procedure TfrmCrmSoruSeti.UniFormShow(Sender: TObject);
begin
  Caption := 'CRM - Kontrol Listesi (Soru Setleri)';
  CevapTipiYukle;
  TipLookupAc;
  SetLookupAc;
  SetleriListele;
end;

procedure TfrmCrmSoruSeti.btnKapatClick(Sender: TObject);
begin
  MainForm.NavPage.ActivePage.Close;
end;

procedure TfrmCrmSoruSeti.btnListeleClick(Sender: TObject);
begin
  SetleriListele;
end;

{ ----- Soru setleri ----- }

procedure TfrmCrmSoruSeti.SetleriListele;
begin
  qSet.Close;
  qSet.SQL.Text :=
    'SELECT SET_ID, KOD, BASLIK, ACIKLAMA, AKTIF, SIRA FROM dbo.CRM_SORU_SETI ' +
    'ORDER BY SIRA, SET_ID';
  qSet.Open;
  SetDetayYukle;
  SorulariListele;
  SetLookupAc;
end;

procedure TfrmCrmSoruSeti.SetDetayTemizle;
begin
  edKod.Text := '';
  edBaslik.Text := '';
  edSetAciklama.Text := '';
  chkSetAktif.Checked := True;
  edSetSira.Text := '0';
end;

procedure TfrmCrmSoruSeti.SetDetayYukle;
begin
  FYeniSet := False;
  if not qSet.Active or qSet.IsEmpty then
  begin
    SetDetayTemizle;
    Exit;
  end;
  edKod.Text := qSet.FieldByName('KOD').AsString;
  edBaslik.Text := qSet.FieldByName('BASLIK').AsString;
  edSetAciklama.Text := qSet.FieldByName('ACIKLAMA').AsString;
  chkSetAktif.Checked := qSet.FieldByName('AKTIF').AsBoolean;
  edSetSira.Text := IntToStr(qSet.FieldByName('SIRA').AsInteger);
end;

procedure TfrmCrmSoruSeti.dsSetDataChange(Sender: TObject; Field: TField);
begin
  if csLoading in ComponentState then
    Exit;
  if FYeniSet then
    Exit;
  SetDetayYukle;
  SorulariListele;
end;

procedure TfrmCrmSoruSeti.btnYeniSetClick(Sender: TObject);
begin
  FYeniSet := True;
  SetDetayTemizle;
  edKod.SetFocus;
end;

procedure TfrmCrmSoruSeti.btnSetKaydetClick(Sender: TObject);
var
  Sid: Int64;
begin
  if Trim(edBaslik.Text) = '' then
  begin
    UniMainModule.saHata.Show('Set ba' + #$015F + 'l' + #$0131 + #$011F + #$0131 + ' zorunludur.');
    Exit;
  end;
  qExec.Close;
  if FYeniSet then
  begin
    qExec.SQL.Text :=
      'INSERT INTO dbo.CRM_SORU_SETI (KOD, BASLIK, ACIKLAMA, AKTIF, SIRA) ' +
      'OUTPUT INSERTED.SET_ID VALUES (:KOD, :BASLIK, :ACIK, :AKT, :SIRA)';
  end
  else
  begin
    Sid := CurrentSetId;
    if Sid <= 0 then
    begin
      UniMainModule.saHata.Show('Önce bir set se' + #$00E7 + 'in veya Yeni ile ekleyin.');
      Exit;
    end;
    qExec.SQL.Text :=
      'UPDATE dbo.CRM_SORU_SETI SET KOD = :KOD, BASLIK = :BASLIK, ACIKLAMA = :ACIK, ' +
      'AKTIF = :AKT, SIRA = :SIRA, GUNCELLEME_UTC = SYSUTCDATETIME() WHERE SET_ID = :SID';
    qExec.ParamByName('SID').AsLargeInt := Sid;
  end;
  if Trim(edKod.Text) <> '' then
    qExec.ParamByName('KOD').AsString := UpperCase(Trim(edKod.Text))
  else
    qExec.ParamByName('KOD').Clear;
  qExec.ParamByName('BASLIK').AsString := Trim(edBaslik.Text);
  qExec.ParamByName('ACIK').AsString := edSetAciklama.Text;
  qExec.ParamByName('AKT').AsBoolean := chkSetAktif.Checked;
  qExec.ParamByName('SIRA').AsInteger := StrToIntDef(Trim(edSetSira.Text), 0);

  Sid := 0;
  try
    if FYeniSet then
    begin
      qExec.Open;
      if not qExec.Fields[0].IsNull then
        Sid := qExec.Fields[0].AsLargeInt;
      qExec.Close;
    end
    else
    begin
      Sid := CurrentSetId;
      qExec.Execute;
    end;
  except
    on E: Exception do
    begin
      UniMainModule.saHata.Show('Kay' + #$0131 + 't hatas' + #$0131 + ': ' + E.Message);
      Exit;
    end;
  end;

  FYeniSet := False;
  UniMainModule.saKaydet.Show('Set kaydedildi.');
  SetleriListele;
  if (Sid > 0) and qSet.Active and qSet.Locate('SET_ID', Sid, []) then
  begin
    SetDetayYukle;
    SorulariListele;
  end;
end;

procedure TfrmCrmSoruSeti.btnSetSilClick(Sender: TObject);
var
  Sid: Int64;
begin
  Sid := CurrentSetId;
  if Sid <= 0 then
  begin
    UniMainModule.saHata.Show('Silinecek seti se' + #$00E7 + 'in.');
    Exit;
  end;
  qExec.Close;
  qExec.SQL.Text := 'DELETE FROM dbo.CRM_SORU_SETI WHERE SET_ID = :SID';
  qExec.ParamByName('SID').AsLargeInt := Sid;
  try
    qExec.Execute;
  except
    on E: Exception do
    begin
      UniMainModule.saHata.Show('Set silinemedi (ba' + #$011F + 'l' + #$0131 + ' kay' + #$0131 + 'tlar olabilir): ' + E.Message);
      Exit;
    end;
  end;
  UniMainModule.saKaydet.Show('Set silindi.');
  SetleriListele;
end;

{ ----- Sorular ----- }

procedure TfrmCrmSoruSeti.SorulariListele;
var
  Sid: Int64;
begin
  qSoru.Close;
  Sid := CurrentSetId;
  if Sid <= 0 then
  begin
    SoruDetayTemizle;
    qSec.Close;
    Exit;
  end;
  qSoru.SQL.Text :=
    'SELECT SORU_ID, SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ' +
    'CASE CEVAP_TIPI ' +
    'WHEN ''EVET_HAYIR'' THEN N''Evet/Hay'' + NCHAR(305) + N''r'' ' +
    'WHEN ''TEK_SECIM'' THEN N''Tek Se'' + NCHAR(231) + N''im'' ' +
    'WHEN ''COK_SECIM'' THEN NCHAR(199) + N''ok Se'' + NCHAR(231) + N''im'' ' +
    'WHEN ''METIN'' THEN N''Metin'' ' +
    'WHEN ''SAYI'' THEN N''Say'' + NCHAR(305) ' +
    'WHEN ''TARIH'' THEN N''Tarih'' ' +
    'WHEN ''PUAN'' THEN N''Puan (1-5)'' ELSE CEVAP_TIPI END AS CEVAP_TIPI_AD, ' +
    'ZORUNLU, AKTIF FROM dbo.CRM_SORU WHERE SET_ID = :SID ORDER BY SIRA, SORU_ID';
  qSoru.ParamByName('SID').AsLargeInt := Sid;
  qSoru.Open;
  SoruDetayYukle;
  SecenekleriListele;
end;

procedure TfrmCrmSoruSeti.SoruDetayTemizle;
begin
  edSoruMetni.Text := '';
  CevapTipiSec('METIN');
  chkZorunlu.Checked := False;
  chkSoruAktif.Checked := True;
  edSoruSira.Text := '0';
end;

procedure TfrmCrmSoruSeti.SoruDetayYukle;
begin
  FYeniSoru := False;
  if not qSoru.Active or qSoru.IsEmpty then
  begin
    SoruDetayTemizle;
    Exit;
  end;
  edSoruMetni.Text := qSoru.FieldByName('SORU_METNI').AsString;
  CevapTipiSec(qSoru.FieldByName('CEVAP_TIPI').AsString);
  chkZorunlu.Checked := qSoru.FieldByName('ZORUNLU').AsBoolean;
  chkSoruAktif.Checked := qSoru.FieldByName('AKTIF').AsBoolean;
  edSoruSira.Text := IntToStr(qSoru.FieldByName('SIRA').AsInteger);
end;

procedure TfrmCrmSoruSeti.dsSoruDataChange(Sender: TObject; Field: TField);
begin
  if csLoading in ComponentState then
    Exit;
  if FYeniSoru then
    Exit;
  SoruDetayYukle;
  SecenekleriListele;
end;

procedure TfrmCrmSoruSeti.btnSoruYeniClick(Sender: TObject);
begin
  if CurrentSetId <= 0 then
  begin
    UniMainModule.saHata.Show('Önce bir soru seti se' + #$00E7 + 'in.');
    Exit;
  end;
  FYeniSoru := True;
  SoruDetayTemizle;
  edSoruMetni.SetFocus;
end;

procedure TfrmCrmSoruSeti.btnSoruKaydetClick(Sender: TObject);
var
  Sid, SoruId: Int64;
begin
  Sid := CurrentSetId;
  if Sid <= 0 then
  begin
    UniMainModule.saHata.Show('Önce bir soru seti se' + #$00E7 + 'in.');
    Exit;
  end;
  if Trim(edSoruMetni.Text) = '' then
  begin
    UniMainModule.saHata.Show('Soru metni zorunludur.');
    Exit;
  end;
  qExec.Close;
  if FYeniSoru then
  begin
    qExec.SQL.Text :=
      'INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF) ' +
      'OUTPUT INSERTED.SORU_ID VALUES (:SID, :SIRA, :METIN, :CT, :ZOR, :AKT)';
    qExec.ParamByName('SID').AsLargeInt := Sid;
  end
  else
  begin
    SoruId := CurrentSoruId;
    if SoruId <= 0 then
    begin
      UniMainModule.saHata.Show('Önce bir soru se' + #$00E7 + 'in veya Yeni ile ekleyin.');
      Exit;
    end;
    qExec.SQL.Text :=
      'UPDATE dbo.CRM_SORU SET SIRA = :SIRA, SORU_METNI = :METIN, CEVAP_TIPI = :CT, ' +
      'ZORUNLU = :ZOR, AKTIF = :AKT WHERE SORU_ID = :SORUID';
    qExec.ParamByName('SORUID').AsLargeInt := SoruId;
  end;
  qExec.ParamByName('SIRA').AsInteger := StrToIntDef(Trim(edSoruSira.Text), 0);
  qExec.ParamByName('METIN').AsString := Trim(edSoruMetni.Text);
  qExec.ParamByName('CT').AsString := CevapTipiKod;
  qExec.ParamByName('ZOR').AsBoolean := chkZorunlu.Checked;
  qExec.ParamByName('AKT').AsBoolean := chkSoruAktif.Checked;

  SoruId := 0;
  try
    if FYeniSoru then
    begin
      qExec.Open;
      if not qExec.Fields[0].IsNull then
        SoruId := qExec.Fields[0].AsLargeInt;
      qExec.Close;
    end
    else
    begin
      SoruId := CurrentSoruId;
      qExec.Execute;
    end;
  except
    on E: Exception do
    begin
      UniMainModule.saHata.Show('Soru kay' + #$0131 + 't hatas' + #$0131 + ': ' + E.Message);
      Exit;
    end;
  end;

  FYeniSoru := False;
  UniMainModule.saKaydet.Show('Soru kaydedildi.');
  SorulariListele;
  if (SoruId > 0) and qSoru.Active and qSoru.Locate('SORU_ID', SoruId, []) then
  begin
    SoruDetayYukle;
    SecenekleriListele;
  end;
end;

procedure TfrmCrmSoruSeti.btnSoruSilClick(Sender: TObject);
var
  SoruId: Int64;
begin
  SoruId := CurrentSoruId;
  if SoruId <= 0 then
  begin
    UniMainModule.saHata.Show('Silinecek soruyu se' + #$00E7 + 'in.');
    Exit;
  end;
  qExec.Close;
  qExec.SQL.Text := 'DELETE FROM dbo.CRM_SORU WHERE SORU_ID = :SORUID';
  qExec.ParamByName('SORUID').AsLargeInt := SoruId;
  try
    qExec.Execute;
  except
    on E: Exception do
    begin
      UniMainModule.saHata.Show('Soru silinemedi (cevap kay' + #$0131 + 'tlar' + #$0131 + ' olabilir): ' + E.Message);
      Exit;
    end;
  end;
  UniMainModule.saKaydet.Show('Soru silindi.');
  SorulariListele;
end;

{ ----- Secenekler ----- }

procedure TfrmCrmSoruSeti.SecenekleriListele;
var
  SoruId: Int64;
begin
  qSec.Close;
  SoruId := CurrentSoruId;
  if SoruId <= 0 then
    Exit;
  qSec.SQL.Text :=
    'SELECT SECENEK_ID, SORU_ID, SIRA, METIN, AKTIF FROM dbo.CRM_SORU_SECENEK ' +
    'WHERE SORU_ID = :SORUID ORDER BY SIRA, SECENEK_ID';
  qSec.ParamByName('SORUID').AsLargeInt := SoruId;
  qSec.Open;
end;

procedure TfrmCrmSoruSeti.btnSecEkleClick(Sender: TObject);
var
  SoruId: Int64;
  Kod: string;
begin
  SoruId := CurrentSoruId;
  if SoruId <= 0 then
  begin
    UniMainModule.saHata.Show('Önce bir soru se' + #$00E7 + 'in.');
    Exit;
  end;
  Kod := qSoru.FieldByName('CEVAP_TIPI').AsString;
  if not (SameText(Kod, 'TEK_SECIM') or SameText(Kod, 'COK_SECIM')) then
  begin
    UniMainModule.saHata.Show('Se' + #$00E7 + 'enek yaln' + #$0131 + 'zca Tek/' + #$00C7 + 'ok se' + #$00E7 + 'im sorular' + #$0131 + 'na eklenir.');
    Exit;
  end;
  if Trim(edSecMetin.Text) = '' then
  begin
    UniMainModule.saHata.Show('Se' + #$00E7 + 'enek metni zorunludur.');
    Exit;
  end;
  qExec.Close;
  qExec.SQL.Text :=
    'INSERT INTO dbo.CRM_SORU_SECENEK (SORU_ID, SIRA, METIN, AKTIF) ' +
    'VALUES (:SORUID, :SIRA, :METIN, 1)';
  qExec.ParamByName('SORUID').AsLargeInt := SoruId;
  qExec.ParamByName('SIRA').AsInteger := StrToIntDef(Trim(edSecSira.Text), 0);
  qExec.ParamByName('METIN').AsString := Trim(edSecMetin.Text);
  qExec.Execute;
  edSecMetin.Text := '';
  SecenekleriListele;
end;

procedure TfrmCrmSoruSeti.btnSecSilClick(Sender: TObject);
begin
  if not qSec.Active or qSec.IsEmpty or qSec.FieldByName('SECENEK_ID').IsNull then
  begin
    UniMainModule.saHata.Show('Silinecek se' + #$00E7 + 'ene' + #$011F + 'i se' + #$00E7 + 'in.');
    Exit;
  end;
  qExec.Close;
  qExec.SQL.Text := 'DELETE FROM dbo.CRM_SORU_SECENEK WHERE SECENEK_ID = :ID';
  qExec.ParamByName('ID').AsLargeInt := qSec.FieldByName('SECENEK_ID').AsLargeInt;
  qExec.Execute;
  SecenekleriListele;
end;

{ ----- Tip - Set atama ----- }

procedure TfrmCrmSoruSeti.TipLookupAc;
begin
  qTipLkp.Close;
  qTipLkp.SQL.Text :=
    'SELECT TIP_ID, KOD, (KOD + N'' - '' + ISNULL(ACIKLAMA, N'''')) AS AD ' +
    'FROM dbo.CRM_AKTIVITE_TIP WHERE AKTIF = 1 AND KOD <> ''TASK'' ORDER BY SIRA, TIP_ID';
  qTipLkp.Open;
end;

procedure TfrmCrmSoruSeti.SetLookupAc;
begin
  qSetLkp.Close;
  qSetLkp.SQL.Text :=
    'SELECT SET_ID, BASLIK AS AD FROM dbo.CRM_SORU_SETI WHERE AKTIF = 1 ORDER BY SIRA, SET_ID';
  qSetLkp.Open;
end;

procedure TfrmCrmSoruSeti.AtamalariListele;
begin
  qAtama.Close;
  if VarIsNull(lkTip.KeyValue) or VarIsEmpty(lkTip.KeyValue) then
    Exit;
  qAtama.SQL.Text :=
    'SELECT A.ATAMA_ID, A.SET_ID, S.BASLIK, A.ZORUNLU_MU, A.AKTIF ' +
    'FROM dbo.CRM_TIP_SORU_SETI A ' +
    'INNER JOIN dbo.CRM_SORU_SETI S ON S.SET_ID = A.SET_ID ' +
    'WHERE A.AKTIVITE_TIP_ID = :TID ORDER BY S.SIRA, S.SET_ID';
  qAtama.ParamByName('TID').AsLargeInt := lkTip.KeyValue;
  qAtama.Open;
end;

procedure TfrmCrmSoruSeti.lkTipCloseUp(Sender: TObject);
begin
  AtamalariListele;
end;

procedure TfrmCrmSoruSeti.btnAtaClick(Sender: TObject);
begin
  if VarIsNull(lkTip.KeyValue) or VarIsEmpty(lkTip.KeyValue) then
  begin
    UniMainModule.saHata.Show('Önce aktivite tipi se' + #$00E7 + 'in.');
    Exit;
  end;
  if VarIsNull(lkSetEkle.KeyValue) or VarIsEmpty(lkSetEkle.KeyValue) then
  begin
    UniMainModule.saHata.Show('Eklenecek soru setini se' + #$00E7 + 'in.');
    Exit;
  end;
  qExec.Close;
  qExec.SQL.Text :=
    'IF EXISTS (SELECT 1 FROM dbo.CRM_TIP_SORU_SETI WHERE AKTIVITE_TIP_ID = :TID AND SET_ID = :SID) ' +
    'UPDATE dbo.CRM_TIP_SORU_SETI SET ZORUNLU_MU = :ZOR, AKTIF = 1 WHERE AKTIVITE_TIP_ID = :TID AND SET_ID = :SID ' +
    'ELSE INSERT INTO dbo.CRM_TIP_SORU_SETI (AKTIVITE_TIP_ID, SET_ID, ZORUNLU_MU, AKTIF) VALUES (:TID, :SID, :ZOR, 1)';
  qExec.ParamByName('TID').AsLargeInt := lkTip.KeyValue;
  qExec.ParamByName('SID').AsLargeInt := lkSetEkle.KeyValue;
  qExec.ParamByName('ZOR').AsBoolean := chkAtaZorunlu.Checked;
  qExec.Execute;
  UniMainModule.saKaydet.Show('Atama kaydedildi.');
  AtamalariListele;
end;

procedure TfrmCrmSoruSeti.btnAtaKaldirClick(Sender: TObject);
begin
  if not qAtama.Active or qAtama.IsEmpty or qAtama.FieldByName('ATAMA_ID').IsNull then
  begin
    UniMainModule.saHata.Show('Kald' + #$0131 + 'r' + #$0131 + 'lacak atamay' + #$0131 + ' se' + #$00E7 + 'in.');
    Exit;
  end;
  qExec.Close;
  qExec.SQL.Text := 'DELETE FROM dbo.CRM_TIP_SORU_SETI WHERE ATAMA_ID = :ID';
  qExec.ParamByName('ID').AsLargeInt := qAtama.FieldByName('ATAMA_ID').AsLargeInt;
  qExec.Execute;
  UniMainModule.saKaydet.Show('Atama kald' + #$0131 + 'r' + #$0131 + 'ld' + #$0131 + '.');
  AtamalariListele;
end;

end.
