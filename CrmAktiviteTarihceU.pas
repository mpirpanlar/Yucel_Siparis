unit CrmAktiviteTarihceU;

{ CRM aktivite / gorev degisiklik tarihcesi (CRM_AKTIVITE_LOG). }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniButton, uniDateTimePicker, uniEdit, uniComboBox, uniBasicGrid,
  uniDBGrid, Data.DB, MemDS, DBAccess, Uni, uniMultiItem;

type
  TfrmCrmAktiviteTarihce = class(TUniForm)
    rootPanel: TUniPanel;
    panTop: TUniPanel;
    lblBas: TUniLabel;
    dtBas: TUniDateTimePicker;
    lblBit: TUniLabel;
    dtBit: TUniDateTimePicker;
    lblKaynak: TUniLabel;
    cbKaynak: TUniComboBox;
    lblAktId: TUniLabel;
    edAktiviteId: TUniEdit;
    lblCari: TUniLabel;
    edCari: TUniEdit;
    btnGetir: TUniButton;
    btnAc: TUniButton;
    btnKapat: TUniButton;
    grd: TUniDBGrid;
    qList: TUniQuery;
    dsList: TUniDataSource;
    procedure UniFormShow(Sender: TObject);
    procedure btnGetirClick(Sender: TObject);
    procedure btnAcClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
  private
    procedure AcKayit;
  public
  end;

function frmCrmAktiviteTarihce: TfrmCrmAktiviteTarihce;

implementation

{$R *.dfm}

uses
  uniGUIApplication, MainModule, DMU, Main, Genel, CrmAktiviteU, CrmGorevU;

function frmCrmAktiviteTarihce: TfrmCrmAktiviteTarihce;
begin
  Result := TfrmCrmAktiviteTarihce(UniMainModule.GetFormInstance(TfrmCrmAktiviteTarihce));
end;

procedure TfrmCrmAktiviteTarihce.UniFormShow(Sender: TObject);
begin
  Caption := 'CRM - Aktivite / G' + #$00F6 + 'rev Tarih' + #$00E7 + 'esi';
  cbKaynak.Items.Clear;
  cbKaynak.Items.Add('T' + #$00FC + 'm' + #$00FC);
  cbKaynak.Items.Add('Aktivite');
  cbKaynak.Items.Add('G' + #$00F6 + 'rev');
  cbKaynak.ItemIndex := 0;
  dtBas.DateTime := Trunc(Now) - 30;
  dtBit.DateTime := Trunc(Now);
  btnGetirClick(Sender);
end;

procedure TfrmCrmAktiviteTarihce.btnGetirClick(Sender: TObject);
var
  BasT, BitT: TDateTime;
  Kaynak, Ck: string;
  Aid: Int64;
begin
  BasT := Trunc(dtBas.DateTime);
  BitT := Trunc(dtBit.DateTime);
  if BitT < BasT then
  begin
    UniMainModule.saHata.Show('Biti' + #$015F + ' tarihi ba' + #$015F + 'lang' + #$0131 + 'tan k' + #$00FC + #$00E7 + #$00FC + 'k olamaz.');
    Exit;
  end;
  Kaynak := '';
  if cbKaynak.ItemIndex = 1 then
    Kaynak := 'AKTIVITE'
  else if cbKaynak.ItemIndex = 2 then
    Kaynak := 'GOREV';
  Aid := StrToInt64Def(Trim(edAktiviteId.Text), 0);
  Ck := Trim(edCari.Text);

  qList.Close;
  qList.SQL.Text :=
    'SELECT L.LOG_ID, L.AKTIVITE_ID, A.KONU, A.TIP, ' +
    'CONVERT(varchar(19), L.ISLEM_UTC, 120) AS ISLEM_ZAMANI, ' +
    'ISNULL(K.KullaniciAd, '''') AS KULLANICI, L.KAYNAK, L.ISLEM, L.ALAN_ADI, ' +
    'L.ESKI_DEGER, L.YENI_DEGER, L.ACIKLAMA ' +
    'FROM dbo.CRM_AKTIVITE_LOG L ' +
    'INNER JOIN dbo.CRM_AKTIVITE A ON A.AKTIVITE_ID = L.AKTIVITE_ID ' +
    'LEFT JOIN dbo.Kullanici K ON K.KullaniciID = L.KULLANICI_ID ' +
    'WHERE CAST(L.ISLEM_UTC AS date) >= CAST(:BAS AS date) AND CAST(L.ISLEM_UTC AS date) <= CAST(:BIT AS date) ' +
    'AND ((:KAY = '''') OR (L.KAYNAK = :KAY)) ' +
    'AND ((:AID = 0) OR (L.AKTIVITE_ID = :AID)) ' +
    'AND ((:CK = '''') OR (A.CARI_KOD = :CK)) ' +
    'ORDER BY L.ISLEM_UTC DESC, L.LOG_ID DESC';
  qList.ParamByName('BAS').AsDateTime := BasT;
  qList.ParamByName('BIT').AsDateTime := BitT;
  qList.ParamByName('KAY').AsString := Kaynak;
  qList.ParamByName('AID').AsLargeInt := Aid;
  qList.ParamByName('CK').AsString := Ck;
  qList.Open;
end;

procedure TfrmCrmAktiviteTarihce.AcKayit;
var
  Aid: Int64;
  Tip: string;
begin
  if not qList.Active or qList.IsEmpty then
  begin
    UniMainModule.saHata.Show(#$00D6 + 'nce listele yap' + #$0131 + 'n ve bir sat' + #$0131 + 'r se' + #$00E7 + 'in.');
    Exit;
  end;
  Aid := qList.FieldByName('AKTIVITE_ID').AsLargeInt;
  if Aid <= 0 then
    Exit;
  Tip := qList.FieldByName('TIP').AsString;
  if SameText(Tip, 'TASK') then
    xFormShow(TfrmCrmGorev, 'CrmYeniGorev', 1, IntToStr(Aid))
  else
    xFormShow(TfrmCrmAktivite, 'CrmYeniAktivite', 1, IntToStr(Aid));
end;

procedure TfrmCrmAktiviteTarihce.btnAcClick(Sender: TObject);
begin
  AcKayit;
end;

procedure TfrmCrmAktiviteTarihce.btnKapatClick(Sender: TObject);
begin
  MainForm.NavPage.ActivePage.Close;
end;

end.
