unit CrmRotaListeU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniButton,
  uniBasicGrid, uniDBGrid, Data.DB, MemDS, DBAccess, Uni;

type
  TfrmCrmRotaListe = class(TUniForm)
    rootPanel: TUniPanel;
    pnlToolbar: TUniPanel;
    btnListele: TUniButton;
    btnYeni: TUniButton;
    btnAc: TUniButton;
    btnKapat: TUniButton;
    panFilt: TUniPanel;
    lblFiltBaslik: TUniLabel;
    edFiltBaslik: TUniEdit;
    grd: TUniDBGrid;
    qList: TUniQuery;
    dsList: TUniDataSource;
    procedure UniFormShow(Sender: TObject);
    procedure btnListeleClick(Sender: TObject);
    procedure btnYeniClick(Sender: TObject);
    procedure btnAcClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure grdAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
  private
    procedure AcKayit;
  public
  end;

function frmCrmRotaListe: TfrmCrmRotaListe;

implementation

{$R *.dfm}

uses
  uniGUIApplication, MainModule, DMU, Main, Genel, CrmRotaU;

function frmCrmRotaListe: TfrmCrmRotaListe;
begin
  Result := TfrmCrmRotaListe(UniMainModule.GetFormInstance(TfrmCrmRotaListe));
end;

procedure TfrmCrmRotaListe.AcKayit;
begin
  if not qList.Active or qList.IsEmpty then
  begin
    UniMainModule.saHata.Show('Once listele yapin ve bir satir secin.');
    Exit;
  end;
  if qList.FieldByName('ROTA_ID').IsNull then
    Exit;
  xFormShow(TfrmCrmRotaPlan, 'CrmRotaPlan', 1, qList.FieldByName('ROTA_ID').AsString);
end;

procedure TfrmCrmRotaListe.btnAcClick(Sender: TObject);
begin
  AcKayit;
end;

procedure TfrmCrmRotaListe.btnYeniClick(Sender: TObject);
begin
  xFormShow(TfrmCrmRotaPlan, 'CrmRotaPlan', 1, '0');
end;

procedure TfrmCrmRotaListe.btnKapatClick(Sender: TObject);
begin
  MainForm.NavPage.ActivePage.Close;
end;

procedure TfrmCrmRotaListe.btnListeleClick(Sender: TObject);
begin
  qList.Close;
  qList.SQL.Text :=
    'SELECT R.ROTA_ID, R.BASLIK, R.DURUM, R.PLANLAMA_TARIHI, R.OLUSTURMA_UTC, ' +
    'R.BASLANGIC_ENLEM, R.BASLANGIC_BOYLAM, R.BITIS_ENLEM, R.BITIS_BOYLAM ' +
    'FROM dbo.CRM_ROTA_PLAN R WHERE 1 = 1';
  if Trim(edFiltBaslik.Text) <> '' then
    qList.SQL.Text := qList.SQL.Text + ' AND R.BASLIK LIKE :BAS';
  qList.SQL.Text := qList.SQL.Text + ' ORDER BY R.ROTA_ID DESC';
  if Trim(edFiltBaslik.Text) <> '' then
    qList.ParamByName('BAS').AsString := '%' + Trim(edFiltBaslik.Text) + '%';
  qList.Open;
end;

procedure TfrmCrmRotaListe.grdAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if SameText(EventName, 'celldblclick') then
    AcKayit;
end;

procedure TfrmCrmRotaListe.UniFormShow(Sender: TObject);
begin
  btnListeleClick(Sender);
end;

end.
