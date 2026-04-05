unit CrmCariSecU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniEdit, uniButton,
  uniBasicGrid, uniDBGrid, Data.DB, MemDS, DBAccess, Uni, uniLabel;

type
  TCrmCariSecildiEvent = procedure(Sender: TObject; const ACariKod: string) of object;

  TfrmCrmCariSec = class(TUniForm)
    pnlToolbar: TUniPanel;
    lblBilgi: TUniLabel;
    edArama: TUniEdit;
    btnListele: TUniButton;
    btnSec: TUniButton;
    btnKapat: TUniButton;
    grdCari: TUniDBGrid;
    qCari: TUniQuery;
    dsCari: TUniDataSource;
    procedure UniFormShow(Sender: TObject);
    procedure btnListeleClick(Sender: TObject);
    procedure btnSecClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure edAramaKeyPress(Sender: TObject; var Key: Char);
    procedure grdCariAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
  private
    procedure CariSecVeKapat;
    function SqlQuote(const S: string): string;
  public
    { Siparis / StokBul benzeri: ShowModal oncesi atanir, Sec ile doldurulur. }
    HedefCariEdit: TUniEdit;
    { Atanirsa cari seciminde kod ile birlikte cagrilir (rota plan vb.). }
    OnCariSecildi: TCrmCariSecildiEvent;
  end;

function frmCrmCariSec: TfrmCrmCariSec;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, DMU, Genel;

function frmCrmCariSec: TfrmCrmCariSec;
begin
  Result := TfrmCrmCariSec(UniMainModule.GetFormInstance(TfrmCrmCariSec));
end;

function TfrmCrmCariSec.SqlQuote(const S: string): string;
begin
  Result := StringReplace(Trim(S), '''', '''''', [rfReplaceAll]);
end;

procedure TfrmCrmCariSec.UniFormShow(Sender: TObject);
begin
  qCari.Close;
end;

procedure TfrmCrmCariSec.btnListeleClick(Sender: TObject);
var
  SQL: string;
  F: string;
begin
  F := SqlQuote(edArama.Text);
  if F = '' then
    SQL := 'SELECT TOP 400 * FROM HV_CARI_LISTESI ORDER BY CARI_KOD'
  else
    SQL :=
      'SELECT * FROM HV_CARI_LISTESI WHERE ' +
      '(DBO.TRK(CARI_ISIM) LIKE ''%' + F + '%'' OR CARI_KOD LIKE ''%' + F + '%'') ' +
      'ORDER BY CARI_KOD';
  Genel.xTabloAc(qCari, SQL);
end;

procedure TfrmCrmCariSec.CariSecVeKapat;
var
  Ck: string;
begin
  if not qCari.Active or qCari.IsEmpty then
  begin
    UniMainModule.saHata.Show('Once listele yapin ve bir satir secin.');
    Exit;
  end;
  Ck := Trim(qCari.FieldByName('CARI_KOD').AsString);
  if Assigned(HedefCariEdit) then
    HedefCariEdit.Text := Ck;
  if Assigned(OnCariSecildi) then
    OnCariSecildi(Self, Ck);
  OnCariSecildi := nil;
  HedefCariEdit := nil;
  Close;
end;

procedure TfrmCrmCariSec.btnSecClick(Sender: TObject);
begin
  CariSecVeKapat;
end;

procedure TfrmCrmCariSec.btnKapatClick(Sender: TObject);
begin
  OnCariSecildi := nil;
  HedefCariEdit := nil;
  Close;
end;

procedure TfrmCrmCariSec.edAramaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnListeleClick(Sender);
  end;
end;

procedure TfrmCrmCariSec.grdCariAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if SameText(EventName, 'celldblclick') then
    CariSecVeKapat;
end;

end.
