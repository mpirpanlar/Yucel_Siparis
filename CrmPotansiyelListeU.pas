unit CrmPotansiyelListeU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniButton, uniCheckBox, uniComboBox,
  uniBasicGrid, uniDBGrid, uniPageControl, Data.DB, MemDS, DBAccess, Uni,
  MainModule, uniMultiItem;

type
  TfrmCrmPotansiyelListe = class(TUniForm)
    rootPanel: TUniPanel;
    pnlToolbar: TUniPanel;
    lblSecimBilgi: TUniLabel;
    btnListele: TUniButton;
    btnSatirSec: TUniButton;
    btnYeni: TUniButton;
    btnAc: TUniButton;
    btnKapat: TUniButton;
    panFilt: TUniPanel;
    lblFiltUnvan: TUniLabel;
    edFiltUnvan: TUniEdit;
    lblFiltNetsis: TUniLabel;
    edFiltNetsis: TUniEdit;
    lblFiltDur: TUniLabel;
    cbFiltDurum: TUniComboBox;
    chkSadeceNetsis: TUniCheckBox;
    grd: TUniDBGrid;
    qList: TUniQuery;
    dsList: TUniDataSource;
    qFilt: TUniQuery;
    procedure UniFormShow(Sender: TObject);
    procedure btnListeleClick(Sender: TObject);
    procedure btnSatirSecClick(Sender: TObject);
    procedure btnYeniClick(Sender: TObject);
    procedure btnAcClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure grdAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure grdCellClick(Column: TUniDBGridColumn);
    procedure UniFormDestroy(Sender: TObject);
  private
    function SecimModuAktif: Boolean;
    procedure SecimModuToolbarGuncelle;
    procedure FiltreDurumlariDoldur;
    procedure PotansiyelSecVeKapat;
    function PotSeciliPotansiyelId(out APotId: Int64): Boolean;
    procedure AcKayit;
    function GomuluNavSekmesiMi: Boolean;
    { NavPage sekmesindeki liste (bsNone); rota modalinda bsDialog -> sekme kapatilmaz, yalnizca form Close. }
    function KapatirkenSekmeKaldir: Boolean;
  public
    { CrmCariSecU.HedefCariEdit benzeri: ShowModal oncesi atanir, Satir sec ile POTANSIYEL_ID yazilir. }
    HedefPotansiyelIdEdit: TUniEdit;
    { CrmCariSecU.OnCariSecildi ile ayni: method pointer dogrudan atanir. }
    OnPotansiyelSecildi: TCrmPotListeSecildiEvent;
    procedure SecimToolbarYenile;
  end;

function frmCrmPotansiyelListe: TfrmCrmPotansiyelListe;

implementation

{$R *.dfm}

uses
  System.Math,
  uniGUIApplication, DMU, Main, Genel, CrmPotansiyelU;

function frmCrmPotansiyelListe: TfrmCrmPotansiyelListe;
begin
  Result := TfrmCrmPotansiyelListe(UniMainModule.GetFormInstance(TfrmCrmPotansiyelListe));
end;

function TfrmCrmPotansiyelListe.KapatirkenSekmeKaldir: Boolean;
begin
  Result := GomuluNavSekmesiMi and (BorderStyle <> bsDialog);
end;

procedure TfrmCrmPotansiyelListe.SecimToolbarYenile;
begin
  SecimModuToolbarGuncelle;
end;

function TfrmCrmPotansiyelListe.SecimModuAktif: Boolean;
begin
  Result :=
    Assigned(HedefPotansiyelIdEdit) or Assigned(OnPotansiyelSecildi) or
    (Assigned(UniMainModule.CrmPotListeSecimCallback) and (UniMainModule.CrmPotListeSecimKaynakListe = Self));
end;

procedure TfrmCrmPotansiyelListe.SecimModuToolbarGuncelle;
const
  BtnRowNormal = 8;
  RowBtnSecim = 36;
  lblTop = 4;
begin
  if SecimModuAktif then
  begin
    pnlToolbar.Height := 76;
    lblSecimBilgi.Visible := True;
    lblSecimBilgi.Top := lblTop;
    lblSecimBilgi.Left := 12;
    lblSecimBilgi.Width := Max(400, pnlToolbar.ClientWidth - 140);
    lblSecimBilgi.Height := 26;
    lblSecimBilgi.SendToBack;
    btnYeni.Visible := False;
    btnAc.Visible := False;
    btnListele.Top := RowBtnSecim;
    btnListele.Left := 12;
    btnSatirSec.Visible := True;
    btnSatirSec.Enabled := True;
    btnSatirSec.Hint :=
      'Secili satirin POTANSIYEL_ID degerini cagiran forma aktarir ve listeyi kapatir';
    btnSatirSec.Top := RowBtnSecim;
    btnSatirSec.Left := 120;
    btnSatirSec.Width := 150;
    btnSatirSec.Height := 32;
    btnKapat.Align := alNone;
    btnKapat.Width := 100;
    btnKapat.Height := 32;
    btnKapat.Top := RowBtnSecim;
    btnKapat.Left := Max(260, pnlToolbar.ClientWidth - btnKapat.Width - 12);
    btnKapat.BringToFront;
    btnSatirSec.BringToFront;
    btnListele.BringToFront;
    Caption := 'CRM - Potansiyel secimi (rota)';
  end
  else
  begin
    pnlToolbar.Height := 48;
    lblSecimBilgi.Visible := False;
    btnSatirSec.Visible := True;
    btnSatirSec.Enabled := True;
    btnSatirSec.Hint :=
      'Secim modunda: POTANSIYEL_ID yi cagiran forma aktarip listeyi kapatir. Kayit detayi icin Kaydi ac veya cift tik.';
    btnSatirSec.Left := 246;
    btnSatirSec.Width := 140;
    btnSatirSec.Height := 32;
    btnYeni.Visible := True;
    btnAc.Visible := True;
    btnListele.Top := BtnRowNormal;
    btnYeni.Top := BtnRowNormal;
    btnSatirSec.Top := BtnRowNormal;
    btnAc.Top := BtnRowNormal;
    btnListele.Left := 12;
    btnYeni.Left := 120;
    btnAc.Left := 392;
    btnSatirSec.BringToFront;
    btnKapat.Align := alNone;
    btnKapat.Top := BtnRowNormal;
    btnKapat.Height := 32;
    btnKapat.Width := 100;
    btnKapat.Left := Max(380, pnlToolbar.ClientWidth - btnKapat.Width - 12);
    Caption := 'CRM - Potansiyel musteri listesi';
  end;
end;

procedure TfrmCrmPotansiyelListe.FiltreDurumlariDoldur;
begin
  cbFiltDurum.Items.Clear;
  cbFiltDurum.Items.Add('(Tumu)');
  try
    qFilt.Close;
    qFilt.SQL.Text :=
      'SELECT KOD FROM dbo.CRM_POTANSIYEL_DURUM WHERE AKTIF = 1 ORDER BY SIRA, POTANSIYEL_DURUM_ID';
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

function TfrmCrmPotansiyelListe.PotSeciliPotansiyelId(out APotId: Int64): Boolean;
var
  F: TField;
begin
  Result := False;
  APotId := 0;
  if qList.Active then
    qList.CheckBrowseMode;
  if not qList.Active or qList.IsEmpty then
    Exit;
  F := qList.FindField('POTANSIYEL_ID');
  if (F = nil) or F.IsNull then
    Exit;
  APotId := F.AsLargeInt;
  if APotId <= 0 then
    APotId := F.AsInteger;
  Result := APotId > 0;
end;

procedure TfrmCrmPotansiyelListe.PotansiyelSecVeKapat;
var
  PotId: Int64;
begin
  if not PotSeciliPotansiyelId(PotId) then
  begin
    UniMainModule.saHata.Show('Once listele yapin ve bir satir secin.');
    Exit;
  end;
//  if not SecimModuAktif then
//  begin
//    UniMainModule.saHata.Show(
//      'Satir sec yalnizca potansiyel kimligini baska forma aktarmak icin kullanilir (cagiran tarafta hedef veya secim olayi). ' +
//      'Kaydi acmak icin Kaydi ac veya satira cift tiklayin.');
//    Exit;
//  end;

  if Assigned(HedefPotansiyelIdEdit) then
    HedefPotansiyelIdEdit.Text := IntToStr(PotId);

  if Assigned(OnPotansiyelSecildi) then
    OnPotansiyelSecildi(Self, PotId);

  if Assigned(UniMainModule.CrmPotListeSecimCallback) and (UniMainModule.CrmPotListeSecimKaynakListe = Self) then
  begin
    UniMainModule.CrmPotListeSecimCallback(Self, PotId);
    UniMainModule.CrmPotListeSecimCallback := nil;
    UniMainModule.CrmPotListeSecimKaynakListe := nil;
  end;

  OnPotansiyelSecildi := nil;
  HedefPotansiyelIdEdit := nil;

  if KapatirkenSekmeKaldir then
  begin
    if (MainForm <> nil) and (MainForm.NavPage <> nil) and (MainForm.NavPage.ActivePage <> nil) then
      MainForm.NavPage.ActivePage.Close;
  end
  else
    Close;
end;

procedure TfrmCrmPotansiyelListe.AcKayit;
var
  PotId: Int64;
begin
  if not PotSeciliPotansiyelId(PotId) then
  begin
    UniMainModule.saHata.Show('Once listele yapin ve bir satir secin.');
    Exit;
  end;
  xFormShow(TfrmCrmPotansiyel, 'CrmYeniPotansiyel', 1, IntToStr(PotId));
end;

procedure TfrmCrmPotansiyelListe.UniFormDestroy(Sender: TObject);
begin
  OnPotansiyelSecildi := nil;
  HedefPotansiyelIdEdit := nil;
  if UniMainModule.CrmPotListeSecimKaynakListe = Self then
  begin
    UniMainModule.CrmPotListeSecimCallback := nil;
    UniMainModule.CrmPotListeSecimKaynakListe := nil;
  end;
end;

procedure TfrmCrmPotansiyelListe.btnAcClick(Sender: TObject);
begin
  AcKayit;
end;

procedure TfrmCrmPotansiyelListe.btnSatirSecClick(Sender: TObject);
begin
  PotansiyelSecVeKapat;
end;

procedure TfrmCrmPotansiyelListe.btnYeniClick(Sender: TObject);
begin
  xFormShow(TfrmCrmPotansiyel, 'CrmYeniPotansiyel', 1, '0');
end;

function TfrmCrmPotansiyelListe.GomuluNavSekmesiMi: Boolean;
var
  C: TWinControl;
  MF: TMainForm;
begin
  Result := False;
  MF := MainForm;
  if (MF = nil) or (MF.NavPage = nil) then
    Exit;
  C := Parent;
  while C <> nil do
  begin
    if C is TUniTabSheet then
      Exit(TUniTabSheet(C).PageControl = MF.NavPage);
    C := C.Parent;
  end;
end;

procedure TfrmCrmPotansiyelListe.btnKapatClick(Sender: TObject);
var
  MF: TMainForm;
begin
  HedefPotansiyelIdEdit := nil;
  OnPotansiyelSecildi := nil;
  SecimModuToolbarGuncelle;
  if UniMainModule.CrmPotListeSecimKaynakListe = Self then
  begin
    UniMainModule.CrmPotListeSecimCallback := nil;
    UniMainModule.CrmPotListeSecimKaynakListe := nil;
  end;
  { Sadece CRM NavPage sekmesine gomulu liste (modal degil): sekmeyi kaldir. }
  if KapatirkenSekmeKaldir then
  begin
    MF := MainForm;
    if (MF <> nil) and (MF.NavPage <> nil) and (MF.NavPage.ActivePage <> nil) then
      MF.NavPage.ActivePage.Close;
  end
  else
    Close;
end;

procedure TfrmCrmPotansiyelListe.btnListeleClick(Sender: TObject);
var
  Sql: string;
begin
  qList.Close;
  Sql :=
    'SELECT P.POTANSIYEL_ID, P.FIRMA_UNVAN, P.KISA_AD, P.NETSIS_CARI_KOD, D.KOD AS DURUM_KOD, ' +
    'P.IL, P.ILCE, P.EPOSTA, P.TELEFON_SABIT, P.OLUSTURMA_UTC ' +
    'FROM dbo.CRM_POTANSIYEL_MUSTERI P ' +
    'INNER JOIN dbo.CRM_POTANSIYEL_DURUM D ON D.POTANSIYEL_DURUM_ID = P.POTANSIYEL_DURUM_ID ' +
    'WHERE 1 = 1';
  if Trim(edFiltUnvan.Text) <> '' then
    Sql := Sql + ' AND P.FIRMA_UNVAN LIKE :FU';
  if Trim(edFiltNetsis.Text) <> '' then
    Sql := Sql + ' AND P.NETSIS_CARI_KOD LIKE :NK';
  if cbFiltDurum.ItemIndex > 0 then
    Sql := Sql + ' AND D.KOD = :DK';
  if chkSadeceNetsis.Checked then
    Sql := Sql + ' AND P.NETSIS_CARI_KOD IS NOT NULL AND LTRIM(RTRIM(P.NETSIS_CARI_KOD)) <> ''''';
  Sql := Sql + ' ORDER BY P.POTANSIYEL_ID DESC';
  qList.SQL.Text := Sql;
  if Trim(edFiltUnvan.Text) <> '' then
    qList.ParamByName('FU').AsString := '%' + Trim(edFiltUnvan.Text) + '%';
  if Trim(edFiltNetsis.Text) <> '' then
    qList.ParamByName('NK').AsString := '%' + Trim(edFiltNetsis.Text) + '%';
  if cbFiltDurum.ItemIndex > 0 then
    qList.ParamByName('DK').AsString := cbFiltDurum.Items[cbFiltDurum.ItemIndex];
  qList.Open;
end;

procedure TfrmCrmPotansiyelListe.grdCellClick(Column: TUniDBGridColumn);
begin
  if qList.Active then
    qList.CheckBrowseMode;
end;

procedure TfrmCrmPotansiyelListe.grdAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if SameText(EventName, 'cellclick') then
  begin
    if qList.Active then
      qList.CheckBrowseMode;
  end
  else if SameText(EventName, 'celldblclick') then
  begin
    if SecimModuAktif then
      PotansiyelSecVeKapat
    else
      AcKayit;
  end;
end;

procedure TfrmCrmPotansiyelListe.UniFormShow(Sender: TObject);
begin
  FiltreDurumlariDoldur;
  btnListeleClick(Sender);
  SecimModuToolbarGuncelle;
end;

end.
