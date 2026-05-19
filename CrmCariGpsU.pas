unit CrmCariGpsU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniMemo, uniButton, MemDS, DBAccess, Uni;

type
  TfrmCrmCariGps = class(TUniForm)
    rootPanel: TUniPanel;
    panMain: TUniPanel;
    lblCariKod: TUniLabel;
    edCariKod: TUniEdit;
    lblCariIsim: TUniLabel;
    edCariIsim: TUniEdit;
    lblGpsE: TUniLabel;
    edGpsEnlem: TUniEdit;
    lblGpsB: TUniLabel;
    edGpsBoylam: TUniEdit;
    btnHaritaKonum: TUniButton;
    lblHarFmt: TUniLabel;
    mmHaritaAdres: TUniMemo;
    panFooter: TUniPanel;
    btnKaydet: TUniButton;
    btnKapat: TUniButton;
    qLoad: TUniQuery;
    qExec: TUniQuery;
    procedure UniFormShow(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure btnHaritaKonumClick(Sender: TObject);
  private
    FCariKod: string;
    function ParseDecimal(const S: string): Double;
    function DecimalToText(const V: Double): string;
    procedure DecimalToParam(Q: TUniQuery; const N: string; const V: Double);
    procedure YukleKayit;
  public
  end;

function frmCrmCariGps: TfrmCrmCariGps;

implementation

{$R *.dfm}

uses
  uniGUIApplication, MainModule, DMU, CrmHaritaSecU, Main;

function frmCrmCariGps: TfrmCrmCariGps;
begin
  Result := TfrmCrmCariGps(UniMainModule.GetFormInstance(TfrmCrmCariGps));
end;

function TfrmCrmCariGps.ParseDecimal(const S: string): Double;
var
  T: string;
  FS: TFormatSettings;
begin
  T := Trim(StringReplace(S, ',', '.', [rfReplaceAll]));
  FS := TFormatSettings.Invariant;
  FS.DecimalSeparator := '.';
  Result := StrToFloatDef(T, 0, FS);
end;

function TfrmCrmCariGps.DecimalToText(const V: Double): string;
begin
  if Abs(V) < 1E-12 then
    Result := ''
  else
    Result := FormatFloat('0.########', V, TFormatSettings.Invariant);
end;

procedure TfrmCrmCariGps.DecimalToParam(Q: TUniQuery; const N: string; const V: Double);
begin
  if Abs(V) < 1E-12 then
    Q.ParamByName(N).Clear
  else
    Q.ParamByName(N).AsFloat := V;
end;

procedure TfrmCrmCariGps.YukleKayit;
var
  Ge, Gb: Double;
begin
  qLoad.Close;
  qLoad.SQL.Text :=
    'SELECT C.CARI_KOD, C.CARI_ISIM, T.KULL1N, T.KULL2N ' +
    'FROM TBLCASABIT C WITH(NOLOCK) ' +
    'LEFT JOIN TBLCASABITEK T WITH(NOLOCK) ON T.CARI_KOD = C.CARI_KOD ' +
    'WHERE C.CARI_KOD = :K';
  qLoad.ParamByName('K').AsString := FCariKod;
  qLoad.Open;
  if qLoad.IsEmpty then
  begin
    UniMainModule.saHata.Show('Cari bulunamadi: ' + FCariKod);
    Exit;
  end;

  edCariKod.Text := Trim(qLoad.FieldByName('CARI_KOD').AsString);
  edCariIsim.Text := Trim(qLoad.FieldByName('CARI_ISIM').AsString);

  Ge := 0;
  Gb := 0;
  if (qLoad.FindField('KULL1N') <> nil) and not qLoad.FieldByName('KULL1N').IsNull then
    Ge := qLoad.FieldByName('KULL1N').AsFloat;
  if (qLoad.FindField('KULL2N') <> nil) and not qLoad.FieldByName('KULL2N').IsNull then
    Gb := qLoad.FieldByName('KULL2N').AsFloat;

  edGpsEnlem.Text := DecimalToText(Ge);
  edGpsBoylam.Text := DecimalToText(Gb);
  mmHaritaAdres.Clear;

  Caption := 'Netsis Cari GPS - ' + edCariKod.Text;
  qLoad.Close;
end;

procedure TfrmCrmCariGps.UniFormShow(Sender: TObject);
begin
  FCariKod := Trim(Hint);
  if FCariKod = '' then
  begin
    UniMainModule.saHata.Show('Cari kodu belirtilmedi.');
    Exit;
  end;
  edCariKod.ReadOnly := True;
  edCariIsim.ReadOnly := True;
  YukleKayit;
end;

procedure TfrmCrmCariGps.btnHaritaKonumClick(Sender: TObject);
begin
  with frmCrmHaritaSec do
  begin
    MerkezAyarla(ParseDecimal(edGpsEnlem.Text), ParseDecimal(edGpsBoylam.Text));
    HedefEnlemEdit := edGpsEnlem;
    HedefBoylamEdit := edGpsBoylam;
    HedefHaritaAdresMemo := mmHaritaAdres;
    ShowModal;
  end;
end;

procedure TfrmCrmCariGps.btnKaydetClick(Sender: TObject);
var
  Ge, Gb: Double;
  N: Integer;
begin
  if Trim(FCariKod) = '' then
    Exit;

  Ge := ParseDecimal(edGpsEnlem.Text);
  Gb := ParseDecimal(edGpsBoylam.Text);

  qExec.Close;
  qExec.SQL.Text :=
    'UPDATE TBLCASABITEK SET KULL1N = :K1, KULL2N = :K2 WHERE CARI_KOD = :K';
  qExec.ParamByName('K').AsString := FCariKod;
  DecimalToParam(qExec, 'K1', Ge);
  DecimalToParam(qExec, 'K2', Gb);
  qExec.Execute;
  N := qExec.RowsAffected;

  if N = 0 then
  begin
    qExec.Close;
    qExec.SQL.Text :=
      'INSERT INTO TBLCASABITEK (CARI_KOD, KULL1N, KULL2N) VALUES (:K, :K1, :K2)';
    qExec.ParamByName('K').AsString := FCariKod;
    DecimalToParam(qExec, 'K1', Ge);
    DecimalToParam(qExec, 'K2', Gb);
    try
      qExec.Execute;
    except
      on E: Exception do
      begin
        UniMainModule.saHata.Show(
          'TBLCASABITEK guncellenemedi. Cari icin Netsis ek kart kaydi olmayabilir.'#13#10 + E.Message);
        Exit;
      end;
    end;
  end;

  UniMainModule.saKaydet.Show('GPS koordinatlari kaydedildi.');
end;

procedure TfrmCrmCariGps.btnKapatClick(Sender: TObject);
begin
  MainForm.NavPage.ActivePage.Close;
end;

end.
