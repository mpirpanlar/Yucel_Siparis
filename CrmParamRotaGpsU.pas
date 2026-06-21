unit CrmParamRotaGpsU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniButton, uniBasicGrid, uniDBGrid, Data.DB,
  MemDS, DBAccess, Uni;

type
  TfrmCrmParamRotaGps = class(TUniForm)
    rootPanel: TUniPanel;
    pnlToolbar: TUniPanel;
    btnListele: TUniButton;
    btnKaydet: TUniButton;
    btnKapat: TUniButton;
    panDetay: TUniPanel;
    lblSube: TUniLabel;
    edSubeKodu: TUniEdit;
    lblBasBaslik: TUniLabel;
    edBasEnlem: TUniEdit;
    edBasBoylam: TUniEdit;
    btnHarBas: TUniButton;
    lblBitBaslik: TUniLabel;
    edBitEnlem: TUniEdit;
    edBitBoylam: TUniEdit;
    btnHarBit: TUniButton;
    grd: TUniDBGrid;
    qParam: TUniQuery;
    dsParam: TUniDataSource;
    qExec: TUniQuery;
    procedure UniFormShow(Sender: TObject);
    procedure btnListeleClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure dsParamDataChange(Sender: TObject; Field: TField);
    procedure btnHarBasClick(Sender: TObject);
    procedure btnHarBitClick(Sender: TObject);
  private
    procedure DetayYukle;
    function ParseGpsDec(const S: string): Double;
    function GpsDecToText(const V: Double): string;
    function SeciliSubeKodu: Integer;
  public
  end;

function frmCrmParamRotaGps: TfrmCrmParamRotaGps;

implementation

{$R *.dfm}

uses
  uniGUIApplication, MainModule, DMU, Main, CrmHaritaSecU;

function frmCrmParamRotaGps: TfrmCrmParamRotaGps;
begin
  Result := TfrmCrmParamRotaGps(UniMainModule.GetFormInstance(TfrmCrmParamRotaGps));
end;

function TfrmCrmParamRotaGps.ParseGpsDec(const S: string): Double;
var
  T: string;
  FS: TFormatSettings;
begin
  T := Trim(StringReplace(S, ',', '.', [rfReplaceAll]));
  FS := TFormatSettings.Invariant;
  Result := StrToFloatDef(T, 0, FS);
end;

function TfrmCrmParamRotaGps.GpsDecToText(const V: Double): string;
begin
  if Abs(V) < 1E-12 then
    Result := ''
  else
    Result := FormatFloat('0.########', V, TFormatSettings.Invariant);
end;

function TfrmCrmParamRotaGps.SeciliSubeKodu: Integer;
begin
  Result := StrToIntDef(Trim(edSubeKodu.Text), -1);
end;

procedure TfrmCrmParamRotaGps.DetayYukle;
begin
  if not qParam.Active or qParam.IsEmpty then
  begin
    edSubeKodu.Text := '';
    edBasEnlem.Text := '';
    edBasBoylam.Text := '';
    edBitEnlem.Text := '';
    edBitBoylam.Text := '';
    Exit;
  end;
  edSubeKodu.Text := IntToStr(qParam.FieldByName('SUBE_KODU').AsInteger);
  if qParam.FieldByName('GPSX').IsNull then
    edBasEnlem.Text := ''
  else
    edBasEnlem.Text := GpsDecToText(qParam.FieldByName('GPSX').AsFloat);
  if qParam.FieldByName('GPSY').IsNull then
    edBasBoylam.Text := ''
  else
    edBasBoylam.Text := GpsDecToText(qParam.FieldByName('GPSY').AsFloat);
  if qParam.FieldByName('ROTA_BITIS_ENLEM').IsNull then
    edBitEnlem.Text := ''
  else
    edBitEnlem.Text := GpsDecToText(qParam.FieldByName('ROTA_BITIS_ENLEM').AsFloat);
  if qParam.FieldByName('ROTA_BITIS_BOYLAM').IsNull then
    edBitBoylam.Text := ''
  else
    edBitBoylam.Text := GpsDecToText(qParam.FieldByName('ROTA_BITIS_BOYLAM').AsFloat);
end;

procedure TfrmCrmParamRotaGps.dsParamDataChange(Sender: TObject; Field: TField);
begin
  if not (csLoading in ComponentState) then
    DetayYukle;
end;

procedure TfrmCrmParamRotaGps.UniFormShow(Sender: TObject);
begin
  btnListeleClick(Sender);
end;

procedure TfrmCrmParamRotaGps.btnListeleClick(Sender: TObject);
begin
  qParam.Close;
  qParam.SQL.Text :=
    'SELECT ID, SUBE_KODU, GPSX, GPSY, ROTA_BITIS_ENLEM, ROTA_BITIS_BOYLAM ' +
    'FROM dbo.PARAMETRE WITH (NOLOCK) ORDER BY SUBE_KODU';
  qParam.Open;
  DetayYukle;
end;

procedure TfrmCrmParamRotaGps.btnKaydetClick(Sender: TObject);
var
  Gx, Gy, Be, Bb: Double;
  SubeKod: Integer;
begin
  SubeKod := SeciliSubeKodu;
  if SubeKod < 0 then
  begin
    UniMainModule.saHata.Show(#214'nce listeden bir '#351'ube se'#231'iniz.');
    Exit;
  end;
  Gx := ParseGpsDec(edBasEnlem.Text);
  Gy := ParseGpsDec(edBasBoylam.Text);
  Be := ParseGpsDec(edBitEnlem.Text);
  Bb := ParseGpsDec(edBitBoylam.Text);
  qExec.Close;
  qExec.SQL.Text :=
    'UPDATE dbo.PARAMETRE SET GPSX = :GX, GPSY = :GY, ' +
    'ROTA_BITIS_ENLEM = :BE, ROTA_BITIS_BOYLAM = :BB WHERE SUBE_KODU = :SUBE';
  qExec.ParamByName('SUBE').AsInteger := SubeKod;
  if Abs(Gx) < 1E-12 then
    qExec.ParamByName('GX').Clear
  else
    qExec.ParamByName('GX').AsFloat := Gx;
  if Abs(Gy) < 1E-12 then
    qExec.ParamByName('GY').Clear
  else
    qExec.ParamByName('GY').AsFloat := Gy;
  if Abs(Be) < 1E-12 then
    qExec.ParamByName('BE').Clear
  else
    qExec.ParamByName('BE').AsFloat := Be;
  if Abs(Bb) < 1E-12 then
    qExec.ParamByName('BB').Clear
  else
    qExec.ParamByName('BB').AsFloat := Bb;
  qExec.Execute;
  btnListeleClick(Sender);
  UniMainModule.saKaydet.Show('Rota GPS tan'#305'm'#305' kaydedildi.');
end;

procedure TfrmCrmParamRotaGps.btnKapatClick(Sender: TObject);
begin
  MainForm.NavPage.ActivePage.Close;
end;

procedure TfrmCrmParamRotaGps.btnHarBasClick(Sender: TObject);
begin
  frmCrmHaritaSec.MerkezAyarla(ParseGpsDec(edBasEnlem.Text), ParseGpsDec(edBasBoylam.Text));
  frmCrmHaritaSec.HedefEnlemEdit := edBasEnlem;
  frmCrmHaritaSec.HedefBoylamEdit := edBasBoylam;
  frmCrmHaritaSec.HedefHaritaAdresMemo := nil;
  frmCrmHaritaSec.ShowModal;
end;

procedure TfrmCrmParamRotaGps.btnHarBitClick(Sender: TObject);
begin
  frmCrmHaritaSec.MerkezAyarla(ParseGpsDec(edBitEnlem.Text), ParseGpsDec(edBitBoylam.Text));
  frmCrmHaritaSec.HedefEnlemEdit := edBitEnlem;
  frmCrmHaritaSec.HedefBoylamEdit := edBitBoylam;
  frmCrmHaritaSec.HedefHaritaAdresMemo := nil;
  frmCrmHaritaSec.ShowModal;
end;

end.
