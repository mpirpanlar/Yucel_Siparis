unit CrmAktiviteListeU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniButton,
  uniLabel, uniEdit, uniCheckBox, uniComboBox, uniDateTimePicker,
  uniBasicGrid, uniDBGrid, Data.DB, MemDS, DBAccess, Uni, MainModule;

type
  TfrmCrmAktiviteListe = class(TUniForm)
    rootPanel: TUniPanel;
    pnlToolbar: TUniPanel;
    btnListele: TUniButton;
    btnAc: TUniButton;
    btnKapat: TUniButton;
    panFilt: TUniPanel;
    lblFiltTip: TUniLabel;
    ccTip: TUniComboBox;
    lblFiltDurum: TUniLabel;
    ccDurum: TUniComboBox;
    lblFiltOnc: TUniLabel;
    ccOncelik: TUniComboBox;
    chkTarih: TUniCheckBox;
    lblFiltTarBas: TUniLabel;
    dtFiltBas: TUniDateTimePicker;
    lblFiltTarBit: TUniLabel;
    dtFiltBit: TUniDateTimePicker;
    lblFiltCari: TUniLabel;
    edFiltCari: TUniEdit;
    lblFiltCariUnvan: TUniLabel;
    btnCariBul: TUniButton;
    lblFiltPot: TUniLabel;
    edFiltPotId: TUniEdit;
    lblFiltPotUnvan: TUniLabel;
    btnPotBul: TUniButton;
    grd: TUniDBGrid;
    qList: TUniQuery;
    dsList: TUniDataSource;
    qFilt: TUniQuery;
    procedure UniFormShow(Sender: TObject);
    procedure btnListeleClick(Sender: TObject);
    procedure btnAcClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure btnCariBulClick(Sender: TObject);
    procedure btnPotBulClick(Sender: TObject);
    procedure grdAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure UniFormDestroy(Sender: TObject);
  private
    procedure AcKayit;
    procedure FiltreCombolariDoldur;
    procedure CariSecildi(Sender: TObject; const ACariKod: string);
    procedure PotSecildi(Sender: TObject; APotansiyelId: Int64);
    function ComboSeciliIdInClause(ACombo: TUniComboBox): string;
    function ComboSeciliOncelikInClause: string;
    function SqlQuoteLike(const S: string): string;
  public
  end;

function frmCrmAktiviteListe: TfrmCrmAktiviteListe;

implementation

{$R *.dfm}

uses
  System.DateUtils,
  uniGUIApplication, DMU, Main, Genel, CrmAktiviteU, CrmCariSecU, CrmPotansiyelListeU;

function frmCrmAktiviteListe: TfrmCrmAktiviteListe;
begin
  Result := TfrmCrmAktiviteListe(UniMainModule.GetFormInstance(TfrmCrmAktiviteListe));
end;

function TfrmCrmAktiviteListe.SqlQuoteLike(const S: string): string;
begin
  Result := StringReplace(Trim(S), '''', '''''', [rfReplaceAll]);
end;

function TfrmCrmAktiviteListe.ComboSeciliIdInClause(ACombo: TUniComboBox): string;
var
  Parts: TStringList;
  I, J, Id: Integer;
  SL: TStringList;
  Lbl: string;
begin
  SL := TStringList.Create;
  Parts := TStringList.Create;
  try
    Parts.StrictDelimiter := True;
    Parts.Delimiter := ',';
    Parts.DelimitedText := Trim(ACombo.Text);
    for I := 0 to ACombo.Items.Count - 1 do
    begin
      Lbl := Trim(ACombo.Items[I]);
      for J := 0 to Parts.Count - 1 do
        if SameText(Trim(Parts[J]), Lbl) then
        begin
          if ACombo.Items.Objects[I] <> nil then
          begin
            Id := NativeInt(ACombo.Items.Objects[I]);
            if Id > 0 then
              SL.Add(IntToStr(Id));
          end;
          Break;
        end;
    end;
    Result := SL.CommaText;
  finally
    Parts.Free;
    SL.Free;
  end;
end;

function TfrmCrmAktiviteListe.ComboSeciliOncelikInClause: string;
const
  OncKodlar: array[1..3] of string = ('DUSUK', 'ORTA', 'YUKSEK');
var
  Parts: TStringList;
  I, J, Tag: Integer;
  SL: TStringList;
  Lbl: string;
begin
  SL := TStringList.Create;
  Parts := TStringList.Create;
  try
    Parts.StrictDelimiter := True;
    Parts.Delimiter := ',';
    Parts.DelimitedText := Trim(ccOncelik.Text);
    for I := 0 to ccOncelik.Items.Count - 1 do
    begin
      Lbl := Trim(ccOncelik.Items[I]);
      for J := 0 to Parts.Count - 1 do
        if SameText(Trim(Parts[J]), Lbl) then
        begin
          if ccOncelik.Items.Objects[I] <> nil then
          begin
            Tag := NativeInt(ccOncelik.Items.Objects[I]);
            if (Tag >= 1) and (Tag <= 3) then
              SL.Add('''' + OncKodlar[Tag] + '''');
          end;
          Break;
        end;
    end;
    Result := SL.CommaText;
  finally
    Parts.Free;
    SL.Free;
  end;
end;

procedure TfrmCrmAktiviteListe.FiltreCombolariDoldur;
begin
  ccTip.Items.Clear;
  ccDurum.Items.Clear;
  try
    qFilt.Close;
    qFilt.SQL.Text :=
      'SELECT TIP_ID, ACIKLAMA FROM dbo.CRM_AKTIVITE_TIP ' +
      'WHERE AKTIF = 1 AND KOD <> ''TASK'' ORDER BY SIRA, TIP_ID';
    qFilt.Open;
    while not qFilt.Eof do
    begin
      ccTip.Items.AddObject(
        Trim(qFilt.FieldByName('ACIKLAMA').AsString),
        TObject(NativeInt(qFilt.FieldByName('TIP_ID').AsLargeInt)));
      qFilt.Next;
    end;
    qFilt.Close;

    qFilt.SQL.Text :=
      'SELECT DURUM_ID, ACIKLAMA FROM dbo.CRM_AKTIVITE_DURUM ' +
      'WHERE AKTIF = 1 ORDER BY SIRA, DURUM_ID';
    qFilt.Open;
    while not qFilt.Eof do
    begin
      ccDurum.Items.AddObject(
        Trim(qFilt.FieldByName('ACIKLAMA').AsString),
        TObject(NativeInt(qFilt.FieldByName('DURUM_ID').AsLargeInt)));
      qFilt.Next;
    end;
  except
  end;
  qFilt.Close;

  ccOncelik.Items.Clear;
  ccOncelik.Items.AddObject('D' + #$00FC + #$015F + #$00FC + 'k', TObject(NativeInt(1)));
  ccOncelik.Items.AddObject('Orta', TObject(NativeInt(2)));
  ccOncelik.Items.AddObject('Y' + #$00FC + 'ksek', TObject(NativeInt(3)));
end;

procedure TfrmCrmAktiviteListe.CariSecildi(Sender: TObject; const ACariKod: string);
begin
  edFiltCari.Text := ACariKod;
end;

procedure TfrmCrmAktiviteListe.PotSecildi(Sender: TObject; APotansiyelId: Int64);
begin
  edFiltPotId.Text := IntToStr(APotansiyelId);
  lblFiltPotUnvan.Caption := '';
  if APotansiyelId <= 0 then
    Exit;
  try
    qFilt.Close;
    qFilt.SQL.Text :=
      'SELECT FIRMA_UNVAN FROM dbo.CRM_POTANSIYEL_MUSTERI WHERE POTANSIYEL_ID = :ID';
    qFilt.ParamByName('ID').AsLargeInt := APotansiyelId;
    qFilt.Open;
    if not qFilt.IsEmpty then
      lblFiltPotUnvan.Caption := Trim(qFilt.FieldByName('FIRMA_UNVAN').AsString);
  except
  end;
  qFilt.Close;
end;

procedure TfrmCrmAktiviteListe.AcKayit;
begin
  if not qList.Active or qList.IsEmpty then
  begin
    UniMainModule.saHata.Show(#214'nce listele yap'#305'n ve bir sat'#305'r se'#231'in.');
    Exit;
  end;
  if qList.FieldByName('AKTIVITE_ID').IsNull then
    Exit;
  xFormShow(TfrmCrmAktivite, 'CrmYeniAktivite', 1, qList.FieldByName('AKTIVITE_ID').AsString);
end;

procedure TfrmCrmAktiviteListe.btnAcClick(Sender: TObject);
begin
  AcKayit;
end;

procedure TfrmCrmAktiviteListe.btnCariBulClick(Sender: TObject);
begin
  frmCrmCariSec.HedefCariEdit := edFiltCari;
  frmCrmCariSec.HedefCariAdLabel := lblFiltCariUnvan;
  frmCrmCariSec.OnCariSecildi := CariSecildi;
  frmCrmCariSec.edArama.Text := Trim(edFiltCari.Text);
  frmCrmCariSec.ShowModal;
  frmCrmCariSec.OnCariSecildi := nil;
  frmCrmCariSec.HedefCariAdLabel := nil;
end;

procedure TfrmCrmAktiviteListe.btnPotBulClick(Sender: TObject);
begin
  frmCrmPotansiyelListe.HedefPotansiyelIdEdit := edFiltPotId;
  frmCrmPotansiyelListe.OnPotansiyelSecildi := PotSecildi;
  frmCrmPotansiyelListe.SecimToolbarYenile;
  frmCrmPotansiyelListe.BorderStyle := bsDialog;
  frmCrmPotansiyelListe.BorderIcons := [biSystemMenu];
  try
    frmCrmPotansiyelListe.btnListeleClick(nil);
    frmCrmPotansiyelListe.ShowModal;
  finally
    frmCrmPotansiyelListe.OnPotansiyelSecildi := nil;
    frmCrmPotansiyelListe.HedefPotansiyelIdEdit := nil;
    frmCrmPotansiyelListe.BorderStyle := bsNone;
    frmCrmPotansiyelListe.BorderIcons := [];
    frmCrmPotansiyelListe.SecimToolbarYenile;
  end;
end;

procedure TfrmCrmAktiviteListe.btnKapatClick(Sender: TObject);
begin
  MainForm.NavPage.ActivePage.Close;
end;

procedure TfrmCrmAktiviteListe.btnListeleClick(Sender: TObject);
var
  Sql, TipIn, DurIn, OncIn, CariF: string;
  PotId: Int64;
begin
  if chkTarih.Checked then
  begin
    if DateOf(dtFiltBas.DateTime) > DateOf(dtFiltBit.DateTime) then
    begin
      UniMainModule.saHata.Show('Tarih ba'#351'lang'#305#231' biti'#351'ten b'#252'y'#252'k olamaz.');
      Exit;
    end;
  end;

  TipIn := ComboSeciliIdInClause(ccTip);
  DurIn := ComboSeciliIdInClause(ccDurum);
  OncIn := ComboSeciliOncelikInClause;
  CariF := Trim(edFiltCari.Text);
  PotId := 0;
  if Trim(edFiltPotId.Text) <> '' then
    if not TryStrToInt64(Trim(edFiltPotId.Text), PotId) then
      PotId := 0;

  qList.Close;
  Sql :=
    'SELECT A.AKTIVITE_ID, ISNULL(TK.ACIKLAMA, A.TIP) AS TIP_AD, A.KONU, A.CARI_KOD, ' +
    'C.CARI_ISIM, P.FIRMA_UNVAN AS POT_UNVAN, A.AKTIVITE_TARIHI, ' +
    'ISNULL(D.ACIKLAMA, A.DURUM) AS DURUM_AD, ' +
    'CASE A.ONCELIK ' +
    'WHEN ''DUSUK'' THEN N''D' + #$00FC + #$015F + #$00FC + 'k'' ' +
    'WHEN ''YUKSEK'' THEN N''Y' + #$00FC + 'ksek'' ' +
    'ELSE N''Orta'' END AS ONCELIK, ' +
    'T.TEKLIF_NO, A.SIPARIS_NO ' +
    'FROM dbo.CRM_AKTIVITE A ' +
    'LEFT JOIN dbo.CRM_AKTIVITE_TIP TK ON TK.TIP_ID = A.AKTIVITE_TIP_ID ' +
    'LEFT JOIN dbo.CRM_AKTIVITE_DURUM D ON D.DURUM_ID = A.AKTIVITE_DURUM_ID ' +
    'LEFT JOIN YUCEL..HV_CARI_LISTESI C WITH(NOLOCK) ON C.CARI_KOD = A.CARI_KOD ' +
    'LEFT JOIN dbo.CRM_POTANSIYEL_MUSTERI P ON P.POTANSIYEL_ID = A.POTANSIYEL_ID ' +
    'LEFT JOIN dbo.CRM_TEKLIF T ON T.TEKLIF_ID = A.TEKLIF_ID ' +
    'WHERE ISNULL(TK.KOD, A.TIP) <> ''TASK''';

  if TipIn <> '' then
    Sql := Sql + ' AND A.AKTIVITE_TIP_ID IN (' + TipIn + ')';
  if DurIn <> '' then
    Sql := Sql + ' AND A.AKTIVITE_DURUM_ID IN (' + DurIn + ')';
  if OncIn <> '' then
    Sql := Sql + ' AND A.ONCELIK IN (' + OncIn + ')';
  if chkTarih.Checked then
    Sql := Sql + ' AND CAST(A.AKTIVITE_TARIHI AS DATE) BETWEEN CAST(:DB AS DATE) AND CAST(:DE AS DATE)';
  if CariF <> '' then
    Sql := Sql +
      ' AND (A.CARI_KOD LIKE :FC OR EXISTS (SELECT 1 FROM YUCEL..HV_CARI_LISTESI C2 WITH(NOLOCK) ' +
      'WHERE C2.CARI_KOD = A.CARI_KOD AND DBO.TRK(C2.CARI_ISIM) LIKE :FCU))';
  if PotId > 0 then
    Sql := Sql +
      ' AND (A.POTANSIYEL_ID = :POT_ID OR EXISTS (SELECT 1 FROM dbo.CRM_POTANSIYEL_MUSTERI PM ' +
      'WHERE PM.POTANSIYEL_ID = :POT_ID AND PM.NETSIS_CARI_KOD IS NOT NULL AND PM.NETSIS_CARI_KOD = A.CARI_KOD))';

  Sql := Sql + ' ORDER BY A.AKTIVITE_ID DESC';
  qList.SQL.Text := Sql;

  if chkTarih.Checked then
  begin
    qList.ParamByName('DB').AsDateTime := DateOf(dtFiltBas.DateTime);
    qList.ParamByName('DE').AsDateTime := DateOf(dtFiltBit.DateTime);
  end;
  if CariF <> '' then
  begin
    qList.ParamByName('FC').AsString := '%' + CariF + '%';
    qList.ParamByName('FCU').AsString := '%' + SqlQuoteLike(CariF) + '%';
  end;
  if PotId > 0 then
    qList.ParamByName('POT_ID').AsLargeInt := PotId;

  qList.Open;
end;

procedure TfrmCrmAktiviteListe.grdAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if SameText(EventName, 'celldblclick') then
    AcKayit;
end;

procedure TfrmCrmAktiviteListe.UniFormDestroy(Sender: TObject);
begin
  frmCrmPotansiyelListe.OnPotansiyelSecildi := nil;
  frmCrmPotansiyelListe.HedefPotansiyelIdEdit := nil;
end;

procedure TfrmCrmAktiviteListe.UniFormShow(Sender: TObject);
begin
  edFiltPotId.Visible := False;
  FiltreCombolariDoldur;
  chkTarih.Checked := True;
  dtFiltBas.DateTime := IncDay(DateOf(Now), -30);
  dtFiltBit.DateTime := DateOf(Now);
  edFiltCari.Text := '';
  lblFiltCariUnvan.Caption := '';
  edFiltPotId.Text := '';
  lblFiltPotUnvan.Caption := '';
  btnListeleClick(Self);
end;

end.
