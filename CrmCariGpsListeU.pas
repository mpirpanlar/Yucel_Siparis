unit CrmCariGpsListeU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniButton,
  uniBasicGrid, uniDBGrid, uniEdit, uniLabel, Data.DB, MemDS, DBAccess, Uni;

type
  TfrmCrmCariGpsListe = class(TUniForm)
    rootPanel: TUniPanel;
    pnlToolbar: TUniPanel;
    lblArama: TUniLabel;
    edArama: TUniEdit;
    btnListele: TUniButton;
    btnAc: TUniButton;
    btnKapat: TUniButton;
    grd: TUniDBGrid;
    qList: TUniQuery;
    dsList: TUniDataSource;
    procedure UniFormShow(Sender: TObject);
    procedure btnListeleClick(Sender: TObject);
    procedure btnAcClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure edAramaKeyPress(Sender: TObject; var Key: Char);
    procedure grdAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
  private
    function SqlQuote(const S: string): string;
    procedure AcKayit;
  public
  end;

function frmCrmCariGpsListe: TfrmCrmCariGpsListe;

implementation

{$R *.dfm}

uses
  uniGUIApplication, MainModule, DMU, Main, Genel, CrmCariGpsU;

function frmCrmCariGpsListe: TfrmCrmCariGpsListe;
begin
  Result := TfrmCrmCariGpsListe(UniMainModule.GetFormInstance(TfrmCrmCariGpsListe));
end;

function TfrmCrmCariGpsListe.SqlQuote(const S: string): string;
begin
  Result := StringReplace(Trim(S), '''', '''''', [rfReplaceAll]);
end;

procedure TfrmCrmCariGpsListe.AcKayit;
var
  Ck: string;
begin
  if not qList.Active or qList.IsEmpty then
  begin
    UniMainModule.saHata.Show(#214'nce listele yap'#305'n ve bir sat'#305'r se'#231'in.');
    Exit;
  end;
  Ck := Trim(qList.FieldByName('CARI_KOD').AsString);
  if Ck = '' then
    Exit;
  xFormShow(TfrmCrmCariGps, 'CrmCariGps', 1, Ck);
end;

procedure TfrmCrmCariGpsListe.btnAcClick(Sender: TObject);
begin
  AcKayit;
end;

procedure TfrmCrmCariGpsListe.btnKapatClick(Sender: TObject);
begin
  MainForm.NavPage.ActivePage.Close;
end;

procedure TfrmCrmCariGpsListe.btnListeleClick(Sender: TObject);
var
  SQL, F: string;
begin
  F := SqlQuote(edArama.Text);
  SQL :=
    'SELECT C.CARI_KOD, C.CARI_ISIM, C.CARI_IL, C.CARI_ILCE, T.KULL1N, T.KULL2N ' +
    'FROM TBLCASABIT C WITH(NOLOCK) ' +
    'LEFT JOIN TBLCASABITEK T WITH(NOLOCK) ON T.CARI_KOD = C.CARI_KOD ' +
    'WHERE 1=1 ';
  if F <> '' then
    SQL := SQL +
      'AND (DBO.TRK(C.CARI_ISIM) LIKE ''%' + F + '%'' OR C.CARI_KOD LIKE ''%' + F + '%'') ';
  SQL := SQL + 'ORDER BY C.CARI_KOD';
  Genel.xTabloAc(qList, SQL);
end;

procedure TfrmCrmCariGpsListe.edAramaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnListeleClick(Sender);
  end;
end;

procedure TfrmCrmCariGpsListe.grdAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if SameText(EventName, 'celldblclick') then
    AcKayit;
end;

procedure TfrmCrmCariGpsListe.UniFormShow(Sender: TObject);
begin
  qList.Close;
end;

end.
