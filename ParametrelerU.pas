unit ParametrelerU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniBasicGrid, uniDBGrid, uniDBEdit, uniMultiItem,
  uniComboBox, uniDBComboBox, uniDBLookupComboBox, uniPageControl, uniPanel,
  uniCheckBox, uniDBCheckBox, uniBitBtn, uniSpeedButton, uniEdit, uniButton, uniLabel,
  uniGUIBaseClasses, Data.DB, MemDS, DBAccess, Uni, uniSweetAlert;

type
  TfrmParametreler = class(TUniForm)
    UniContainerPanel1: TUniContainerPanel;
    UniPanel2: TUniPanel;
    bntKaydet: TUniButton;
    btnDuzenle: TUniButton;
    btnKapat: TUniButton;
    UniPanel1: TUniPanel;
    btnGenel: TUniSpeedButton;
    btnYetkili: TUniSpeedButton;
    btnBanka: TUniSpeedButton;
    UniSimplePanel4: TUniSimplePanel;
    UniPageControl1: TUniPageControl;
    tabGenel: TUniTabSheet;
    TabFatura: TUniTabSheet;
    tabBanka: TUniTabSheet;
    UniPanel5: TUniPanel;
    UniButton1: TUniButton;
    UniButton2: TUniButton;
    UniButton3: TUniButton;
    UniDBGrid2: TUniDBGrid;
    UniSimplePanel2: TUniSimplePanel;
    UniDBCheckBox2: TUniDBCheckBox;
    UniDBCheckBox3: TUniDBCheckBox;
    UniSimplePanel1: TUniSimplePanel;
    edCariKod: TUniDBEdit;
    UniDBEdit1: TUniDBEdit;
    edCariNo: TUniEdit;
    edStokNo: TUniEdit;
    lcParaBirimi: TUniDBLookupComboBox;
    UniSimplePanel3: TUniSimplePanel;
    UniDBCheckBox4: TUniDBCheckBox;
    UniDBCheckBox5: TUniDBCheckBox;
    UniSimplePanel5: TUniSimplePanel;
    UniDBCheckBox6: TUniDBCheckBox;
    UniDBEdit3: TUniDBEdit;
    UniDBEdit4: TUniDBEdit;
    edFaturaSeriNo: TUniEdit;
    UniDBEdit5: TUniDBEdit;
    UniDBEdit6: TUniDBEdit;
    edEFaturaSeriNo: TUniEdit;
    UniDBEdit7: TUniDBEdit;
    UniDBEdit8: TUniDBEdit;
    edEArsivSeriNo: TUniEdit;
    saSor: TUniSweetAlert;
    UniDBComboBox1: TUniDBComboBox;
    UniDBComboBox2: TUniDBComboBox;
    edParamGpsX: TUniEdit;
    edParamGpsY: TUniEdit;
    btnParamHaritaGps: TUniButton;
    lblRotaGpsBaslik: TUniLabel;
    lblRotaGorevBaslik: TUniLabel;
    cbParamOnayGorev: TUniComboBox;
    cbParamGorevZaman: TUniComboBox;
    edParamGorevBasSaat: TUniEdit;
    edParamGorevDurakDk: TUniEdit;
    edParamGorevMesaiBitSaat: TUniEdit;
    edParamGorevHizKmh: TUniEdit;
    qExec: TUniQuery;
    procedure UniFormShow(Sender: TObject);
    procedure btnGenelClick(Sender: TObject);
    procedure btnYetkiliClick(Sender: TObject);
    procedure edEArsivSeriNoTriggerEvent(Sender: TUniFormControl;
      AButtonId: Integer);
    procedure edCariNoTriggerEvent(Sender: TUniFormControl; AButtonId: Integer);
    procedure saSorConfirm(Sender: TObject);
    procedure edStokNoTriggerEvent(Sender: TUniFormControl; AButtonId: Integer);
    procedure edFaturaSeriNoTriggerEvent(Sender: TUniFormControl;
      AButtonId: Integer);
    procedure edEFaturaSeriNoTriggerEvent(Sender: TUniFormControl;
      AButtonId: Integer);
    procedure bntKaydetClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure btnDuzenleClick(Sender: TObject);
    procedure btnParamHaritaGpsClick(Sender: TObject);
  private
    function ParseGpsDec(const S: string): Double;
    function GpsDecToText(const V: Double): string;
    procedure RotaGpsYukle;
    procedure RotaGpsKaydet;
    procedure RotaGorevParamDoldur;
    procedure RotaGorevYukle;
    procedure RotaGorevKaydet;
  public
  end;

function frmParametreler: TfrmParametreler;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, DMU, Genel, Main, TmpU, CrmHaritaSecU, CrmRotaGorevU;

function frmParametreler: TfrmParametreler;
begin
  Result := TfrmParametreler(UniMainModule.GetFormInstance(TfrmParametreler));
end;

procedure TfrmParametreler.bntKaydetClick(Sender: TObject);
begin
  RotaGpsKaydet;
  RotaGorevKaydet;
  UniMainModule.saKaydet.Show('Parametreler kaydedildi.');
end;

procedure TfrmParametreler.RotaGorevParamDoldur;
begin
  if cbParamOnayGorev.Items.Count = 0 then
  begin
    cbParamOnayGorev.Items.Add('Kapal'#305' (manuel)');
    cbParamOnayGorev.Items.Add('Onayda sor');
    cbParamOnayGorev.Items.Add('Her zaman otomatik');
  end;
  if cbParamGorevZaman.Items.Count = 0 then
  begin
    cbParamGorevZaman.Items.Add('Ayn'#305' g'#252'n');
    cbParamGorevZaman.Items.Add('Ayn'#305' g'#252'n + saat slotu');
  end;
end;

function TfrmParametreler.ParseGpsDec(const S: string): Double;
var
  T: string;
  FS: TFormatSettings;
begin
  T := Trim(StringReplace(S, ',', '.', [rfReplaceAll]));
  FS := TFormatSettings.Invariant;
  Result := StrToFloatDef(T, 0, FS);
end;

function TfrmParametreler.GpsDecToText(const V: Double): string;
begin
  if Abs(V) < 1E-12 then
    Result := ''
  else
    Result := FormatFloat('0.########', V, TFormatSettings.Invariant);
end;

procedure TfrmParametreler.RotaGpsYukle;
var
  Gx, Gy: Double;
begin
  edParamGpsX.Text := '';
  edParamGpsY.Text := '';
  qExec.Close;
  qExec.SQL.Text := 'SELECT GPSX, GPSY FROM dbo.PARAMETRE WITH(NOLOCK) WHERE SUBE_KODU = :SUBE';
  qExec.ParamByName('SUBE').AsInteger := Tmp.xSubeKodu;
  qExec.Open;
  if qExec.IsEmpty then
  begin
    qExec.Close;
    Exit;
  end;
  Gx := 0;
  Gy := 0;
  if (qExec.FindField('GPSX') <> nil) and not qExec.FieldByName('GPSX').IsNull then
    Gx := qExec.FieldByName('GPSX').AsFloat;
  if (qExec.FindField('GPSY') <> nil) and not qExec.FieldByName('GPSY').IsNull then
    Gy := qExec.FieldByName('GPSY').AsFloat;
  qExec.Close;
  edParamGpsX.Text := GpsDecToText(Gx);
  edParamGpsY.Text := GpsDecToText(Gy);
end;

procedure TfrmParametreler.RotaGpsKaydet;
var
  Gx, Gy: Double;
begin
  Gx := ParseGpsDec(edParamGpsX.Text);
  Gy := ParseGpsDec(edParamGpsY.Text);
  qExec.Close;
  qExec.SQL.Text :=
    'UPDATE dbo.PARAMETRE SET GPSX = :GX, GPSY = :GY WHERE SUBE_KODU = :SUBE';
  qExec.ParamByName('SUBE').AsInteger := Tmp.xSubeKodu;
  if Abs(Gx) < 1E-12 then
    qExec.ParamByName('GX').Clear
  else
    qExec.ParamByName('GX').AsFloat := Gx;
  if Abs(Gy) < 1E-12 then
    qExec.ParamByName('GY').Clear
  else
    qExec.ParamByName('GY').AsFloat := Gy;
  qExec.Execute;
end;

procedure TfrmParametreler.RotaGorevYukle;
var
  Ayar: TRotaGorevAyar;
begin
  RotaGorevParamDoldur;
  Ayar := CrmRotaGorevAyarOku(frmDM.conAsya, Tmp.xSubeKodu);
  if (Ayar.OnayGorevOto >= 0) and (Ayar.OnayGorevOto <= 2) then
    cbParamOnayGorev.ItemIndex := Ayar.OnayGorevOto
  else
    cbParamOnayGorev.ItemIndex := ROTA_GOREV_OTO_SOR;
  if Ayar.ZamanMod = ROTA_GOREV_ZAMAN_GUN_SAAT then
    cbParamGorevZaman.ItemIndex := 1
  else
    cbParamGorevZaman.ItemIndex := 0;
  edParamGorevBasSaat.Text := Ayar.BasSaat;
  edParamGorevMesaiBitSaat.Text := Ayar.BitSaat;
  edParamGorevDurakDk.Text := IntToStr(Ayar.DurakDakika);
  edParamGorevHizKmh.Text := IntToStr(Ayar.HizKmh);
end;

procedure TfrmParametreler.RotaGorevKaydet;
var
  Oto, Zaman, Dk, Hiz, MesaiDk: Integer;
  BasSaat, BitSaat: string;
begin
  Oto := cbParamOnayGorev.ItemIndex;
  if (Oto < 0) or (Oto > 2) then
    Oto := ROTA_GOREV_OTO_SOR;
  Zaman := cbParamGorevZaman.ItemIndex;
  if Zaman < 0 then
    Zaman := 0;
  if Zaman > 1 then
    Zaman := 1;
  Dk := StrToIntDef(Trim(edParamGorevDurakDk.Text), 45);
  if Dk <= 0 then
    Dk := 45;
  Hiz := StrToIntDef(Trim(edParamGorevHizKmh.Text), 50);
  if Hiz <= 0 then
    Hiz := 50;
  BasSaat := Trim(edParamGorevBasSaat.Text);
  if BasSaat = '' then
    BasSaat := '09:00';
  BitSaat := Trim(edParamGorevMesaiBitSaat.Text);
  if BitSaat = '' then
    BitSaat := '18:00';
  MesaiDk := CrmMesaiDakikaHesapla(BasSaat, BitSaat, 480);
  qExec.Close;
  qExec.SQL.Text :=
    'UPDATE dbo.PARAMETRE SET ROTA_ONAYDA_GOREV_OTO = :OTO, ROTA_GOREV_ZAMAN_MOD = :ZM, ' +
    'ROTA_GOREV_BAS_SAAT = :BS, ROTA_GOREV_BIT_SAAT = :BIT, ROTA_GOREV_DURAK_DK = :DK, ' +
    'ROTA_GOREV_MESAI_DK = :MDK, ROTA_GOREV_HIZ_KMH = :HZ WHERE SUBE_KODU = :SUBE';
  qExec.ParamByName('SUBE').AsInteger := Tmp.xSubeKodu;
  qExec.ParamByName('OTO').AsInteger := Oto;
  qExec.ParamByName('ZM').AsInteger := Zaman;
  qExec.ParamByName('BS').AsString := BasSaat;
  qExec.ParamByName('BIT').AsString := BitSaat;
  qExec.ParamByName('DK').AsInteger := Dk;
  qExec.ParamByName('MDK').AsInteger := MesaiDk;
  qExec.ParamByName('HZ').AsInteger := Hiz;
  qExec.Execute;
end;

procedure TfrmParametreler.btnParamHaritaGpsClick(Sender: TObject);
begin
  frmCrmHaritaSec.MerkezAyarla(ParseGpsDec(edParamGpsX.Text), ParseGpsDec(edParamGpsY.Text));
  frmCrmHaritaSec.HedefEnlemEdit := edParamGpsX;
  frmCrmHaritaSec.HedefBoylamEdit := edParamGpsY;
  frmCrmHaritaSec.ShowModal;
end;

procedure TfrmParametreler.btnDuzenleClick(Sender: TObject);
begin
    tabGenel.Enabled:=True;
    TabFatura.Enabled:=True;
end;

procedure TfrmParametreler.btnGenelClick(Sender: TObject);
begin
  UniPageControl1.ActivePage:=tabGenel;
end;

procedure TfrmParametreler.btnKapatClick(Sender: TObject);
begin
    MainForm.NavPage.ActivePage.Close;
end;

procedure TfrmParametreler.btnYetkiliClick(Sender: TObject);
begin
  UniPageControl1.ActivePage:=TabFatura;
end;

procedure TfrmParametreler.edCariNoTriggerEvent(Sender: TUniFormControl;
  AButtonId: Integer);
begin
  if AButtonId=0 then begin
    saSor.Tag:=1;
    saSor.Show();
  end;
end;

procedure TfrmParametreler.edEArsivSeriNoTriggerEvent(Sender: TUniFormControl;
  AButtonId: Integer);
begin
  if AButtonId=0 then begin
    saSor.Tag:=5;
    saSor.Show();
  end;
end;

procedure TfrmParametreler.edEFaturaSeriNoTriggerEvent(Sender: TUniFormControl;
  AButtonId: Integer);
begin
  if AButtonId=0 then begin
    saSor.Tag:=4;
    saSor.Show();
  end;
end;

procedure TfrmParametreler.edFaturaSeriNoTriggerEvent(Sender: TUniFormControl;
  AButtonId: Integer);
begin
  if AButtonId=0 then begin
    saSor.Tag:=3;
    saSor.Show();
  end;
end;

procedure TfrmParametreler.edStokNoTriggerEvent(Sender: TUniFormControl;
  AButtonId: Integer);
begin
  if AButtonId=0 then begin
    saSor.Tag:=2;
    saSor.Show();
  end;
end;

procedure TfrmParametreler.saSorConfirm(Sender: TObject);
begin
if saSor.Tag=1 then xUpdateTablo('Update FisNo set FisNo='''+edCariNo.Text+''' where TabloAdi=''CariKart'' ');
if saSor.Tag=2 then xUpdateTablo('Update FisNo set FisNo='''+edStokNo.Text+''' where TabloAdi=''StokKart'' ');
if saSor.Tag=3 then xUpdateTablo('Update FisNo set FisNo='''+edFaturaSeriNo.Text+''' where TabloAdi=''KFatura'' ');
if saSor.Tag=4 then xUpdateTablo('Update FisNo set FisNo='''+edEFaturaSeriNo.Text+''' where TabloAdi=''EFatura'' ');
if saSor.Tag=5 then xUpdateTablo('Update FisNo set FisNo='''+edEArsivSeriNo.Text+''' where TabloAdi=''EArsiv'' ');
end;

procedure TfrmParametreler.UniFormShow(Sender: TObject);
begin
  RotaGpsYukle;
  RotaGorevYukle;
end;

end.
