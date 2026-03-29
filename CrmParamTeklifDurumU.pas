unit CrmParamTeklifDurumU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniButton, uniBasicGrid, uniDBGrid, uniCheckBox, Data.DB,
  MemDS, DBAccess, Uni;

type
  TfrmCrmParamTeklifDurum = class(TUniForm)
    rootPanel: TUniPanel;
    pnlToolbar: TUniPanel;
    btnListele: TUniButton;
    btnYeni: TUniButton;
    btnKaydet: TUniButton;
    btnKapat: TUniButton;
    grd: TUniDBGrid;
    qDur: TUniQuery;
    dsDur: TUniDataSource;
    panDetay: TUniPanel;
    lblKod: TUniLabel;
    edKod: TUniEdit;
    lblAciklama: TUniLabel;
    edAciklama: TUniEdit;
    chkAktif: TUniCheckBox;
    lblSira: TUniLabel;
    edSira: TUniEdit;
    qExec: TUniQuery;
    procedure UniFormShow(Sender: TObject);
    procedure btnListeleClick(Sender: TObject);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure dsDurDataChange(Sender: TObject; Field: TField);
  private
    FYeni: Boolean;
    procedure DetayYukle;
  public
  end;

function frmCrmParamTeklifDurum: TfrmCrmParamTeklifDurum;

implementation

{$R *.dfm}

uses
  uniGUIApplication, MainModule, DMU, Main;

function frmCrmParamTeklifDurum: TfrmCrmParamTeklifDurum;
begin
  Result := TfrmCrmParamTeklifDurum(UniMainModule.GetFormInstance(TfrmCrmParamTeklifDurum));
end;

procedure TfrmCrmParamTeklifDurum.DetayYukle;
begin
  FYeni := False;
  if not qDur.Active or qDur.IsEmpty then
  begin
    edKod.Text := '';
    edAciklama.Text := '';
    chkAktif.Checked := True;
    edSira.Text := '0';
    edKod.ReadOnly := False;
    Exit;
  end;
  edKod.Text := qDur.FieldByName('KOD').AsString;
  edAciklama.Text := qDur.FieldByName('ACIKLAMA').AsString;
  chkAktif.Checked := qDur.FieldByName('AKTIF').AsBoolean;
  edSira.Text := IntToStr(qDur.FieldByName('SIRA').AsInteger);
  edKod.ReadOnly := False;
end;

procedure TfrmCrmParamTeklifDurum.dsDurDataChange(Sender: TObject; Field: TField);
begin
  if not (csLoading in ComponentState) then
    DetayYukle;
end;

procedure TfrmCrmParamTeklifDurum.UniFormShow(Sender: TObject);
begin
  FYeni := False;
  btnListeleClick(Sender);
end;

procedure TfrmCrmParamTeklifDurum.btnListeleClick(Sender: TObject);
begin
  qDur.Close;
  qDur.SQL.Text :=
    'SELECT TEKLIF_DURUM_ID, KOD, ACIKLAMA, AKTIF, SIRA FROM dbo.CRM_TEKLIF_DURUM ORDER BY SIRA, TEKLIF_DURUM_ID';
  qDur.Open;
  DetayYukle;
end;

procedure TfrmCrmParamTeklifDurum.btnYeniClick(Sender: TObject);
begin
  FYeni := True;
  edKod.Text := '';
  edAciklama.Text := '';
  chkAktif.Checked := True;
  edSira.Text := '0';
  edKod.ReadOnly := False;
end;

procedure TfrmCrmParamTeklifDurum.btnKaydetClick(Sender: TObject);
var
  Sira: Integer;
  Did: Int64;
  YeniKod: string;
begin
  if Trim(edKod.Text) = '' then
  begin
    UniMainModule.saHata.Show('Kod zorunludur.');
    Exit;
  end;
  Sira := StrToIntDef(Trim(edSira.Text), 0);
  YeniKod := UpperCase(Trim(edKod.Text));

  qExec.Close;
  if FYeni then
  begin
    qExec.SQL.Text :=
      'INSERT INTO dbo.CRM_TEKLIF_DURUM (KOD, ACIKLAMA, AKTIF, SIRA) ' +
      'VALUES (:KOD, :ACIK, :AKT, :SIRA)';
  end
  else
  begin
    if not qDur.Active or qDur.IsEmpty then
    begin
      UniMainModule.saHata.Show('Once bir satir secin veya Yeni ile ekleyin.');
      Exit;
    end;
    Did := qDur.FieldByName('TEKLIF_DURUM_ID').AsLargeInt;
    qExec.SQL.Text :=
      'UPDATE dbo.CRM_TEKLIF_DURUM SET KOD = :KOD, ACIKLAMA = :ACIK, AKTIF = :AKT, SIRA = :SIRA ' +
      'WHERE TEKLIF_DURUM_ID = :DID';
    qExec.ParamByName('DID').AsLargeInt := Did;
  end;
  qExec.ParamByName('KOD').AsString := YeniKod;
  qExec.ParamByName('ACIK').AsString := edAciklama.Text;
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
    Did := qDur.FieldByName('TEKLIF_DURUM_ID').AsLargeInt;
    qExec.SQL.Text :=
      'UPDATE dbo.CRM_TEKLIF SET DURUM = :KOD WHERE TEKLIF_DURUM_ID = :DID';
    qExec.ParamByName('KOD').AsString := YeniKod;
    qExec.ParamByName('DID').AsLargeInt := Did;
    qExec.Execute;
  end;

  UniMainModule.saKaydet.Show('Kaydedildi.');
  FYeni := False;
  btnListeleClick(Sender);
end;

procedure TfrmCrmParamTeklifDurum.btnKapatClick(Sender: TObject);
begin
  MainForm.NavPage.ActivePage.Close;
end;

end.
