unit CrmSiparisSecU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniEdit, uniButton,
  uniBasicGrid, uniDBGrid, Data.DB, MemDS, DBAccess, Uni, uniLabel;

type
  TCrmSiparisSecildiEvent = procedure(Sender: TObject; const ASiparisKod: string) of object;

  TfrmCrmSiparisSec = class(TUniForm)
    pnlToolbar: TUniPanel;
    lblBilgi: TUniLabel;
    edArama: TUniEdit;
    btnListele: TUniButton;
    btnSec: TUniButton;
    btnKapat: TUniButton;
    grdSiparis: TUniDBGrid;
    qSiparis: TUniQuery;
    dsSiparis: TUniDataSource;
    procedure UniFormShow(Sender: TObject);
    procedure btnListeleClick(Sender: TObject);
    procedure btnSecClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure edAramaKeyPress(Sender: TObject; var Key: Char);
    procedure grdSiparisAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
  private
    procedure SiparisSecVeKapat;
    function SqlQuote(const S: string): string;
  public
    FiltreCariKod: string;
    HedefSiparisEdit: TUniEdit;
    HedefSiparisTarLabel: TUniLabel;
    HedefSiparisAcikLabel: TUniLabel;
    OnSiparisSecildi: TCrmSiparisSecildiEvent;
  end;

function frmCrmSiparisSec: TfrmCrmSiparisSec;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, DMU, Genel, TmpU;

function frmCrmSiparisSec: TfrmCrmSiparisSec;
begin
  Result := TfrmCrmSiparisSec(UniMainModule.GetFormInstance(TfrmCrmSiparisSec));
end;

function TfrmCrmSiparisSec.SqlQuote(const S: string): string;
begin
  Result := StringReplace(Trim(S), '''', '''''', [rfReplaceAll]);
end;

procedure TfrmCrmSiparisSec.UniFormShow(Sender: TObject);
begin
  qSiparis.Close;
  if Trim(FiltreCariKod) <> '' then
    edArama.Text := Trim(FiltreCariKod);
end;

procedure TfrmCrmSiparisSec.btnListeleClick(Sender: TObject);
var
  SQL, F, Ck, NetsisDb: string;
begin
  try
    Genel.xUnidacBaglanNetsis;
  except
  end;
  NetsisDb := Trim(Tmp.xNetsisSirketKodu);
  if NetsisDb = '' then
    NetsisDb := 'YUCEL';
  F := SqlQuote(edArama.Text);
  Ck := SqlQuote(FiltreCariKod);
  SQL :=
    'SELECT TOP 400 M.FATIRS_NO AS SIPARIS_KOD, M.TARIH AS SIPARIS_TARIHI, ' +
    'ISNULL(NULLIF(RTRIM(M.ACIK1), ''''), ISNULL(RTRIM(M.ACIK2), '''')) AS SIPARIS_ACIKLAMA, ' +
    'M.CARI_KODU AS CARI_KOD, C.CARI_ISIM ' +
    'FROM ' + NetsisDb + '.DBO.TBLSIPAMAS M WITH(NOLOCK) ' +
    'LEFT JOIN ' + NetsisDb + '.DBO.TBLCASABIT C WITH(NOLOCK) ON C.CARI_KOD = M.CARI_KODU ' +
    'WHERE M.FTIRSIP = ''6'' ';
  if Ck <> '' then
    SQL := SQL + 'AND M.CARI_KODU = ''' + Ck + ''' ';
  if F <> '' then
    SQL := SQL +
      'AND (M.FATIRS_NO LIKE ''%' + F + '%'' OR ISNULL(M.ACIK1, '''') LIKE ''%' + F + '%'' ' +
      'OR ISNULL(M.ACIK2, '''') LIKE ''%' + F + '%'' OR DBO.TRK(C.CARI_ISIM) LIKE ''%' + F + '%'') ';
  SQL := SQL + 'ORDER BY M.TARIH DESC, M.FATIRS_NO DESC';
  qSiparis.Connection := frmDM.conNetsis;
  Genel.xTabloAc(qSiparis, SQL);
end;

procedure TfrmCrmSiparisSec.SiparisSecVeKapat;
var
  Skod, Sacik: string;
  Star: TDateTime;
begin
  if not qSiparis.Active or qSiparis.IsEmpty then
  begin
    UniMainModule.saHata.Show(#214'nce listele yap'#305'n ve bir sat'#305'r se'#231'in.');
    Exit;
  end;
  Skod := Trim(qSiparis.FieldByName('SIPARIS_KOD').AsString);
  Sacik := '';
  if (qSiparis.FindField('SIPARIS_ACIKLAMA') <> nil) and not qSiparis.FieldByName('SIPARIS_ACIKLAMA').IsNull then
    Sacik := Trim(qSiparis.FieldByName('SIPARIS_ACIKLAMA').AsString);
  Star := 0;
  if (qSiparis.FindField('SIPARIS_TARIHI') <> nil) and not qSiparis.FieldByName('SIPARIS_TARIHI').IsNull then
    Star := qSiparis.FieldByName('SIPARIS_TARIHI').AsDateTime;
  if Assigned(HedefSiparisEdit) then
    HedefSiparisEdit.Text := Skod;
  if Assigned(HedefSiparisTarLabel) then
  begin
    if Star > 0 then
      HedefSiparisTarLabel.Caption := FormatDateTime('dd.mm.yyyy', Star)
    else
      HedefSiparisTarLabel.Caption := '';
  end;
  if Assigned(HedefSiparisAcikLabel) then
    HedefSiparisAcikLabel.Caption := Sacik;
  if Assigned(OnSiparisSecildi) then
    OnSiparisSecildi(Self, Skod);
  OnSiparisSecildi := nil;
  HedefSiparisEdit := nil;
  HedefSiparisTarLabel := nil;
  HedefSiparisAcikLabel := nil;
  FiltreCariKod := '';
  Close;
end;

procedure TfrmCrmSiparisSec.btnSecClick(Sender: TObject);
begin
  SiparisSecVeKapat;
end;

procedure TfrmCrmSiparisSec.btnKapatClick(Sender: TObject);
begin
  OnSiparisSecildi := nil;
  HedefSiparisEdit := nil;
  HedefSiparisTarLabel := nil;
  HedefSiparisAcikLabel := nil;
  FiltreCariKod := '';
  Close;
end;

procedure TfrmCrmSiparisSec.edAramaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnListeleClick(Sender);
  end;
end;

procedure TfrmCrmSiparisSec.grdSiparisAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if SameText(EventName, 'celldblclick') then
    SiparisSecVeKapat;
end;

end.
