unit CrmTeklifListeU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniButton, uniCheckBox, uniComboBox, uniDateTimePicker,
  uniBasicGrid, uniDBGrid, Data.DB, MemDS, DBAccess, Uni;

type
  TfrmCrmTeklifListe = class(TUniForm)
    rootPanel: TUniPanel;
    pnlToolbar: TUniPanel;
    btnListele: TUniButton;
    btnAc: TUniButton;
    btnKapat: TUniButton;
    panFilt: TUniPanel;
    lblFiltCari: TUniLabel;
    edFiltCari: TUniEdit;
    lblFiltNo: TUniLabel;
    edFiltNo: TUniEdit;
    chkTarih: TUniCheckBox;
    lblFiltTarBas: TUniLabel;
    dtFiltBas: TUniDateTimePicker;
    lblFiltTarBit: TUniLabel;
    dtFiltBit: TUniDateTimePicker;
    lblFiltDur: TUniLabel;
    cbFiltDurum: TUniComboBox;
    lblFiltSip: TUniLabel;
    edFiltSip: TUniEdit;
    grd: TUniDBGrid;
    qList: TUniQuery;
    dsList: TUniDataSource;
    qFilt: TUniQuery;
    procedure UniFormShow(Sender: TObject);
    procedure btnListeleClick(Sender: TObject);
    procedure btnAcClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure grdAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
  private
    procedure FiltreDurumlariDoldur;
    procedure AcKayit;
  public
  end;

function frmCrmTeklifListe: TfrmCrmTeklifListe;

implementation

{$R *.dfm}

uses
  System.DateUtils,
  uniGUIApplication, MainModule, DMU, Main, Genel, CrmTeklifU;

function frmCrmTeklifListe: TfrmCrmTeklifListe;
begin
  Result := TfrmCrmTeklifListe(UniMainModule.GetFormInstance(TfrmCrmTeklifListe));
end;

procedure TfrmCrmTeklifListe.FiltreDurumlariDoldur;
begin
  cbFiltDurum.Items.Clear;
  cbFiltDurum.Items.Add('(Tumu)');
  try
    qFilt.Close;
    qFilt.SQL.Text :=
      'SELECT KOD FROM dbo.CRM_TEKLIF_DURUM WHERE AKTIF = 1 ORDER BY SIRA, TEKLIF_DURUM_ID';
    qFilt.Open;
    while not qFilt.Eof do
    begin
      cbFiltDurum.Items.Add(qFilt.Fields[0].AsString);
      qFilt.Next;
    end;
  except
  end;
  qFilt.Close;
  cbFiltDurum.ItemIndex := 0;
end;

procedure TfrmCrmTeklifListe.AcKayit;
begin
  if not qList.Active or qList.IsEmpty then
  begin
    UniMainModule.saHata.Show('Once listele yapin ve bir satir secin.');
    Exit;
  end;
  if qList.FieldByName('TEKLIF_ID').IsNull then
    Exit;
  xFormShow(TfrmCrmTeklif, 'CrmYeniTeklif', 1, qList.FieldByName('TEKLIF_ID').AsString);
end;

procedure TfrmCrmTeklifListe.btnAcClick(Sender: TObject);
begin
  AcKayit;
end;

procedure TfrmCrmTeklifListe.btnKapatClick(Sender: TObject);
begin
  MainForm.NavPage.ActivePage.Close;
end;

procedure TfrmCrmTeklifListe.btnListeleClick(Sender: TObject);
var
  Sql: string;
begin
  if chkTarih.Checked then
  begin
    if DateOf(dtFiltBas.DateTime) > DateOf(dtFiltBit.DateTime) then
    begin
      UniMainModule.saHata.Show('Tarih baslangic bitisten buyuk olamaz.');
      Exit;
    end;
  end;

  qList.Close;
  Sql :=
    'SELECT T.TEKLIF_ID, T.TEKLIF_NO, T.CARI_KOD, T.BASLIK, T.TEKLIF_TARIHI, T.DURUM, T.TOPLAM_NET, T.SIPARIS_NO ' +
    'FROM dbo.CRM_TEKLIF T WHERE 1 = 1';
  if Trim(edFiltCari.Text) <> '' then
    Sql := Sql + ' AND T.CARI_KOD LIKE :FC';
  if Trim(edFiltNo.Text) <> '' then
    Sql := Sql + ' AND T.TEKLIF_NO LIKE :FN';
  if Trim(edFiltSip.Text) <> '' then
    Sql := Sql + ' AND T.SIPARIS_NO LIKE :FS';
  if chkTarih.Checked then
    Sql := Sql + ' AND CAST(T.TEKLIF_TARIHI AS DATE) BETWEEN CAST(:DB AS DATE) AND CAST(:DE AS DATE)';
  if cbFiltDurum.ItemIndex > 0 then
    Sql := Sql + ' AND T.DURUM = :DUR';
  Sql := Sql + ' ORDER BY T.TEKLIF_ID DESC';
  qList.SQL.Text := Sql;
  if Trim(edFiltCari.Text) <> '' then
    qList.ParamByName('FC').AsString := '%' + Trim(edFiltCari.Text) + '%';
  if Trim(edFiltNo.Text) <> '' then
    qList.ParamByName('FN').AsString := '%' + Trim(edFiltNo.Text) + '%';
  if Trim(edFiltSip.Text) <> '' then
    qList.ParamByName('FS').AsString := '%' + Trim(edFiltSip.Text) + '%';
  if chkTarih.Checked then
  begin
    qList.ParamByName('DB').AsDateTime := DateOf(dtFiltBas.DateTime);
    qList.ParamByName('DE').AsDateTime := DateOf(dtFiltBit.DateTime);
  end;
  if cbFiltDurum.ItemIndex > 0 then
    qList.ParamByName('DUR').AsString := cbFiltDurum.Items[cbFiltDurum.ItemIndex];
  qList.Open;
end;

procedure TfrmCrmTeklifListe.grdAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if SameText(EventName, 'celldblclick') then
    AcKayit;
end;

procedure TfrmCrmTeklifListe.UniFormShow(Sender: TObject);
begin
  FiltreDurumlariDoldur;
  dtFiltBas.DateTime := StartOfTheMonth(Now);
  dtFiltBit.DateTime := EndOfTheMonth(Now);
  chkTarih.Checked := False;
  btnListeleClick(Self);
end;

end.
