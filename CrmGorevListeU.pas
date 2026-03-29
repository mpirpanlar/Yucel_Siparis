unit CrmGorevListeU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniButton,
  uniBasicGrid, uniDBGrid, Data.DB, MemDS, DBAccess, Uni;

type
  TfrmCrmGorevListe = class(TUniForm)
    rootPanel: TUniPanel;
    pnlToolbar: TUniPanel;
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
    procedure grdAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
  private
    procedure AcKayit;
  public
  end;

function frmCrmGorevListe: TfrmCrmGorevListe;

implementation

{$R *.dfm}

uses
  uniGUIApplication, MainModule, DMU, Main, Genel, CrmGorevU;

function frmCrmGorevListe: TfrmCrmGorevListe;
begin
  Result := TfrmCrmGorevListe(UniMainModule.GetFormInstance(TfrmCrmGorevListe));
end;

procedure TfrmCrmGorevListe.AcKayit;
begin
  if not qList.Active or qList.IsEmpty then
  begin
    UniMainModule.saHata.Show('Once listele yapin ve bir satir secin.');
    Exit;
  end;
  if qList.FieldByName('AKTIVITE_ID').IsNull then
    Exit;
  xFormShow(TfrmCrmGorev, 'CrmYeniGorev', 1, qList.FieldByName('AKTIVITE_ID').AsString);
end;

procedure TfrmCrmGorevListe.btnAcClick(Sender: TObject);
begin
  AcKayit;
end;

procedure TfrmCrmGorevListe.btnKapatClick(Sender: TObject);
begin
  MainForm.NavPage.ActivePage.Close;
end;

procedure TfrmCrmGorevListe.btnListeleClick(Sender: TObject);
begin
  qList.Close;
  qList.SQL.Text :=
    'SELECT G.GOREV_ID, G.AKTIVITE_ID, A.KONU, A.CARI_KOD, T.TEKLIF_NO, A.DURUM, G.BITIS_TARIHI, G.ONCELIK, G.TAMAMLANDI ' +
    'FROM dbo.CRM_GOREV G ' +
    'INNER JOIN dbo.CRM_AKTIVITE A ON A.AKTIVITE_ID = G.AKTIVITE_ID ' +
    'LEFT JOIN dbo.CRM_TEKLIF T ON T.TEKLIF_ID = A.TEKLIF_ID ' +
    'WHERE A.TIP = ''TASK'' ' +
    'ORDER BY G.GOREV_ID DESC';
  qList.Open;
end;

procedure TfrmCrmGorevListe.grdAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if SameText(EventName, 'celldblclick') then
    AcKayit;
end;

procedure TfrmCrmGorevListe.UniFormShow(Sender: TObject);
begin
  btnListeleClick(Self);
end;

end.
