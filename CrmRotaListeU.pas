unit CrmRotaListeU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniButton, uniSweetAlert,
  uniBasicGrid, uniDBGrid, Data.DB, MemDS, DBAccess, Uni;

type
  TfrmCrmRotaListe = class(TUniForm)
    rootPanel: TUniPanel;
    pnlToolbar: TUniPanel;
    btnListele: TUniButton;
    btnYeni: TUniButton;
    btnAc: TUniButton;
    btnSil: TUniButton;
    btnKapat: TUniButton;
    panFilt: TUniPanel;
    lblFiltBaslik: TUniLabel;
    edFiltBaslik: TUniEdit;
    grd: TUniDBGrid;
    qList: TUniQuery;
    dsList: TUniDataSource;
    qExec: TUniQuery;
    saSil: TUniSweetAlert;
    saSilOk: TUniSweetAlert;
    procedure UniFormShow(Sender: TObject);
    procedure btnListeleClick(Sender: TObject);
    procedure btnYeniClick(Sender: TObject);
    procedure btnAcClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure grdAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure saSilConfirm(Sender: TObject);
  private
    procedure AcKayit;
    procedure SilSeciliKayit;
  public
  end;

function frmCrmRotaListe: TfrmCrmRotaListe;

implementation

{$R *.dfm}

uses
  uniGUIApplication, MainModule, DMU, Main, Genel, CrmRotaU, CrmRotaGorevU;

function frmCrmRotaListe: TfrmCrmRotaListe;
begin
  Result := TfrmCrmRotaListe(UniMainModule.GetFormInstance(TfrmCrmRotaListe));
end;

procedure TfrmCrmRotaListe.AcKayit;
begin
  if not qList.Active or qList.IsEmpty then
  begin
    UniMainModule.saHata.Show(#214'nce listele yap'#305'n ve bir sat'#305'r se'#231'in.');
    Exit;
  end;
  if qList.FieldByName('ROTA_ID').IsNull then
    Exit;
  xFormShow(TfrmCrmRotaPlan, 'CrmRotaPlan', 1, qList.FieldByName('ROTA_ID').AsString);
end;

procedure TfrmCrmRotaListe.SilSeciliKayit;
var
  RotaId: Int64;
  Baslik: string;
begin
  if not qList.Active or qList.IsEmpty then
  begin
    UniMainModule.saHata.Show(#214'nce listele yap'#305'n ve bir sat'#305'r se'#231'in.');
    Exit;
  end;
  if qList.FieldByName('ROTA_ID').IsNull then
    Exit;

  RotaId := qList.FieldByName('ROTA_ID').AsLargeInt;
  Baslik := Trim(qList.FieldByName('BASLIK').AsString);

  try
    CrmRotaGorevleriniIptal(qExec, RotaId, True);

    qExec.Close;
    qExec.SQL.Text :=
      'UPDATE dbo.CRM_AKTIVITE SET ROTA_ID = NULL, ROTA_DURAK_ID = NULL WHERE ROTA_ID = :R';
    qExec.ParamByName('R').AsLargeInt := RotaId;
    qExec.Execute;

    qExec.Close;
    qExec.SQL.Text := 'DELETE FROM dbo.CRM_ROTA_PLAN WHERE ROTA_ID = :R';
    qExec.ParamByName('R').AsLargeInt := RotaId;
    qExec.Execute;

    if Baslik <> '' then
      saSilOk.Show('Rota silindi: ' + Baslik + '. Ba'#287'l'#305' g'#246'revler iptal edildi.')
    else
      saSilOk.Show('Rota silindi. Ba'#287'l'#305' g'#246'revler iptal edildi.');
    btnListeleClick(nil);
  except
    on E: Exception do
    begin
      if Trim(E.Message) <> '' then
        UniMainModule.saHata.Show('Silme islemi basarisiz.'#13#10 + E.Message)
      else
        UniMainModule.saHata.Show('Silme islemi basarisiz.');
    end;
  end;
end;

procedure TfrmCrmRotaListe.btnAcClick(Sender: TObject);
begin
  AcKayit;
end;

procedure TfrmCrmRotaListe.btnSilClick(Sender: TObject);
begin
  if not qList.Active or qList.IsEmpty then
  begin
    UniMainModule.saHata.Show(#214'nce listele yap'#305'n ve bir sat'#305'r se'#231'in.');
    Exit;
  end;
  saSil.Show;
end;

procedure TfrmCrmRotaListe.saSilConfirm(Sender: TObject);
begin
  SilSeciliKayit;
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
    'ISNULL(KO.KullaniciAd, '''') AS OLUSTURAN, ' +
    'ISNULL((SELECT STUFF((SELECT N'', '' + K.KullaniciAd FROM dbo.CRM_ROTA_PLAN_PERSONEL RP ' +
    'INNER JOIN dbo.Kullanici K ON K.KullaniciID = RP.KULLANICI_ID WHERE RP.ROTA_ID = R.ROTA_ID ' +
    'ORDER BY K.KullaniciAd FOR XML PATH(''''), TYPE).value(''.'',''nvarchar(max)''), 1, 2, N'''')), '''') AS ATANAN, ' +
    '(SELECT COUNT(*) FROM dbo.CRM_ROTA_PLAN_DURAK D WHERE D.ROTA_ID = R.ROTA_ID) AS DURAK_SAY, ' +
    'ISNULL(R.TOPLAM_YOL_KM, 0) AS TOPLAM_KM, ' +
    'R.BASLANGIC_ENLEM, R.BASLANGIC_BOYLAM, R.BITIS_ENLEM, R.BITIS_BOYLAM ' +
    'FROM dbo.CRM_ROTA_PLAN R LEFT JOIN dbo.Kullanici KO ON KO.KullaniciID = R.OLUSTURAN_KULLANICI_ID WHERE 1 = 1';
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
