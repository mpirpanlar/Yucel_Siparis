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
    lblSecili: TUniLabel;
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
    procedure grdSelectionChange(Sender: TObject);
    procedure UniFormDestroy(Sender: TObject);
  private
    FCokluSecimModu: Boolean;
    function SecimModuAktif: Boolean;
    function CokluSecimYolu: Boolean;
    procedure SecimModuToolbarGuncelle;
    procedure GridCheckSecimAyar(ACoklu: Boolean);
    procedure GuncelleSeciliSayisi;
    function SeciliPotIdListesi: TStringList;
    procedure FiltreDurumlariDoldur;
    procedure PotansiyelSecVeKapat;
    procedure PotansiyelCokluSecVeKapat;
    function PotSeciliPotansiyelId(out APotId: Int64): Boolean;
    procedure AcKayit;
    function GomuluNavSekmesiMi: Boolean;
    { NavPage sekmesindeki liste (bsNone); rota modal�nda bsDialog -> sekme kapat�lmaz, yaln�zca form Close. }
    function KapatirkenSekmeKaldir: Boolean;
    procedure GomuluDurumaGetir;
  public
    { CrmCariSecU.HedefCariEdit benzeri: ShowModal �ncesi atan�r, Sat�r se� ile POTANSIYEL_ID yaz�l�r. }
    HedefPotansiyelIdEdit: TUniEdit;
    { CrmCariSecU.OnCariSecildi ile ayn�: method pointer do�rudan atan�r. }
    OnPotansiyelSecildi: TCrmPotListeSecildiEvent;
    OnPotansiyelSecildiCoklu: TCrmPotListeSecildiCokluEvent;
    property CokluSecimModu: Boolean read FCokluSecimModu write FCokluSecimModu;
    procedure SecimToolbarYenile;
    procedure ListeSekmesineGeriAl(const AGizle: Boolean = True);
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
    Assigned(OnPotansiyelSecildiCoklu) or FCokluSecimModu or
    UniMainModule.CrmRotaDurakSecimAktif or
    (Assigned(UniMainModule.CrmPotListeSecimCallback) and (UniMainModule.CrmPotListeSecimKaynakListe = Self));
end;

function TfrmCrmPotansiyelListe.CokluSecimYolu: Boolean;
begin
  Result := FCokluSecimModu or Assigned(OnPotansiyelSecildiCoklu);
end;

procedure TfrmCrmPotansiyelListe.GridCheckSecimAyar(ACoklu: Boolean);
begin
  grd.Options := grd.Options + [dgAlwaysShowSelection, dgRowSelect];
  grd.Options := grd.Options - [dgMultiSelect];
  if ACoklu then
    grd.Options := grd.Options + [dgCheckSelect, dgCheckSelectCheckOnly, dgMultiSelect]
  else
    grd.Options := grd.Options - [dgCheckSelect, dgCheckSelectCheckOnly];
end;

procedure TfrmCrmPotansiyelListe.GuncelleSeciliSayisi;
begin
  if not lblSecili.Visible then
    Exit;
  if grd.SelectedRows.Count > 0 then
    lblSecili.Caption := Format('Se'#231'ili: %d', [grd.SelectedRows.Count])
  else
    lblSecili.Caption := 'Se'#231'ili: 0';
end;

procedure TfrmCrmPotansiyelListe.grdSelectionChange(Sender: TObject);
begin
  GuncelleSeciliSayisi;
end;

function TfrmCrmPotansiyelListe.SeciliPotIdListesi: TStringList;
var
  I: Integer;
  Bm: TBookmark;
  F: TField;
  PotId: Int64;
  IdStr: string;
begin
  Result := TStringList.Create;
  Result.Sorted := True;
  Result.Duplicates := dupIgnore;
  if not qList.Active or qList.IsEmpty then
    Exit;
  qList.CheckBrowseMode;
  if grd.SelectedRows.Count > 0 then
  begin
    for I := 0 to grd.SelectedRows.Count - 1 do
    begin
      Bm := grd.SelectedRows[I];
      qList.Bookmark := Bm;
      F := qList.FindField('POTANSIYEL_ID');
      if (F = nil) or F.IsNull then
        Continue;
      PotId := F.AsLargeInt;
      if PotId <= 0 then
        PotId := F.AsInteger;
      if PotId > 0 then
      begin
        IdStr := IntToStr(PotId);
        if Result.IndexOf(IdStr) < 0 then
          Result.Add(IdStr);
      end;
    end;
  end
  else if PotSeciliPotansiyelId(PotId) then
    Result.Add(IntToStr(PotId));
end;

procedure TfrmCrmPotansiyelListe.SecimModuToolbarGuncelle;
const
  BtnRowNormal = 8;
  RowBtnSecim = 36;
  lblTop = 4;
begin
  if SecimModuAktif then
  begin
    if FCokluSecimModu or Assigned(OnPotansiyelSecildiCoklu) then
    begin
      FCokluSecimModu := True;
      GridCheckSecimAyar(True);
      pnlToolbar.Height := 88;
      lblSecili.Visible := True;
      lblSecili.Top := 28;
      lblSecili.Left := 12;
      lblSecimBilgi.Caption :=
        'Filtre + Listele; satir basindaki kutulari isaretleyin, ardindan Secilenleri ekle.';
      btnSatirSec.Caption := 'Se'#231'ilenleri ekle';
      btnSatirSec.Hint := 'Isaretli potansiyelleri rotaya eklemek uzere dondurur';
    end
    else
    begin
      GridCheckSecimAyar(False);
      pnlToolbar.Height := 76;
      lblSecili.Visible := False;
      lblSecimBilgi.Caption :=
        'Filtre + Listele; satir basindaki kutuyu isaretleyin ve Satir sec ile onaylayin. Cift tik da secer.';
      btnSatirSec.Caption := 'Sat'#305'r Se'#231;
      btnSatirSec.Hint :=
        'Se'#231'ili sat'#305'r'#305'n POTANSIYEL_ID de'#287'erini '#231'a'#287#305'ran forma aktar'#305'r ve listeyi kapat'#305'r';
    end;
    lblSecimBilgi.Visible := True;
    lblSecimBilgi.Top := lblTop;
    lblSecimBilgi.Left := 12;
    lblSecimBilgi.Width := Max(400, pnlToolbar.ClientWidth - 140);
    lblSecimBilgi.Height := 22;
    lblSecimBilgi.SendToBack;
    GuncelleSeciliSayisi;
    btnYeni.Visible := False;
    btnAc.Visible := False;
    btnListele.Top := 56;
    btnListele.Left := 12;
    btnSatirSec.Visible := True;
    btnSatirSec.Enabled := True;
    btnSatirSec.Top := 56;
    btnSatirSec.Left := 120;
    btnSatirSec.Width := 150;
    btnSatirSec.Height := 32;
    btnKapat.Align := alNone;
    btnKapat.Width := 100;
    btnKapat.Height := 32;
    btnKapat.Top := 56;
    btnKapat.Left := Max(260, pnlToolbar.ClientWidth - btnKapat.Width - 12);
    btnKapat.BringToFront;
    btnSatirSec.BringToFront;
    btnListele.BringToFront;
    Caption := 'CRM - Potansiyel Se�imi (Rota)';
  end
  else
  begin
    FCokluSecimModu := False;
    GridCheckSecimAyar(False);
    lblSecili.Visible := False;
    pnlToolbar.Height := 48;
    lblSecimBilgi.Visible := False;
    btnSatirSec.Visible := True;
    btnSatirSec.Enabled := True;
    btnSatirSec.Hint :=
      'Se�im modunda: POTANSIYEL_ID yi �a��ran forma aktar�p listeyi kapat�r. Kay�t detay� i�in Kayd� a� veya �ift t�k.';
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
    Caption := 'CRM - Potansiyel M��teri Listesi';
  end;
end;

procedure TfrmCrmPotansiyelListe.FiltreDurumlariDoldur;
begin
  cbFiltDurum.Items.Clear;
  cbFiltDurum.Items.Add('(T�m�)');
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
  if CokluSecimYolu and (grd.SelectedRows.Count > 0) then
    qList.Bookmark := grd.SelectedRows[0];
  F := qList.FindField('POTANSIYEL_ID');
  if (F = nil) or F.IsNull then
    Exit;
  APotId := F.AsLargeInt;
  if APotId <= 0 then
    APotId := F.AsInteger;
  Result := APotId > 0;
end;

procedure TfrmCrmPotansiyelListe.PotansiyelCokluSecVeKapat;
var
  Liste: TStringList;
begin
  Liste := SeciliPotIdListesi;
  if Liste.Count = 0 then
  begin
    Liste.Free;
    UniMainModule.saHata.Show('�nce listele yap?n ve en az bir sat?r se�in.');
    Exit;
  end;
  if Assigned(OnPotansiyelSecildiCoklu) then
    OnPotansiyelSecildiCoklu(Self, Liste)
  else
    Liste.Free;
  OnPotansiyelSecildi := nil;
  OnPotansiyelSecildiCoklu := nil;
  HedefPotansiyelIdEdit := nil;
  FCokluSecimModu := False;
  if KapatirkenSekmeKaldir then
  begin
    if (MainForm <> nil) and (MainForm.NavPage <> nil) and (MainForm.NavPage.ActivePage <> nil) then
      MainForm.NavPage.ActivePage.Close;
  end
  else
    Close;
end;

procedure TfrmCrmPotansiyelListe.PotansiyelSecVeKapat;
var
  PotId: Int64;
begin
  if not PotSeciliPotansiyelId(PotId) then
  begin
    UniMainModule.saHata.Show('�nce listele yap�n ve bir sat�r se�in.');
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
    UniMainModule.saHata.Show('�nce listele yap�n ve bir sat�r se�in.');
    Exit;
  end;
  xFormShow(TfrmCrmPotansiyel, 'CrmYeniPotansiyel', 1, IntToStr(PotId));
end;

procedure TfrmCrmPotansiyelListe.UniFormDestroy(Sender: TObject);
begin
  OnPotansiyelSecildi := nil;
  OnPotansiyelSecildiCoklu := nil;
  FCokluSecimModu := False;
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
  if CokluSecimYolu and (grd.SelectedRows.Count > 1) then
    PotansiyelCokluSecVeKapat
  else if Assigned(OnPotansiyelSecildi) then
    PotansiyelSecVeKapat
  else if CokluSecimYolu then
    PotansiyelCokluSecVeKapat
  else
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
  OnPotansiyelSecildiCoklu := nil;
  FCokluSecimModu := False;
  SecimModuToolbarGuncelle;
  if UniMainModule.CrmRotaDurakSecimAktif then
    UniMainModule.CrmRotaDurakSecimBitir;
  if UniMainModule.CrmPotListeSecimKaynakListe = Self then
  begin
    UniMainModule.CrmPotListeSecimCallback := nil;
    UniMainModule.CrmPotListeSecimKaynakListe := nil;
  end;
  { Sadece CRM NavPage sekmesine g�m�l� liste (modal de�il): sekmeyi kald�r. }
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
    if CokluSecimYolu and (grd.SelectedRows.Count > 1) then
      PotansiyelCokluSecVeKapat
    else if Assigned(OnPotansiyelSecildi) then
      PotansiyelSecVeKapat
    else if CokluSecimYolu then
      PotansiyelCokluSecVeKapat
    else if SecimModuAktif then
      PotansiyelSecVeKapat
    else
      AcKayit;
  end;
end;

procedure TfrmCrmPotansiyelListe.ListeSekmesineGeriAl(const AGizle: Boolean);
var
  I, J: Integer;
  Tab: TUniTabSheet;
  Pnl: TUniPanel;
  MF: TMainForm;
begin
  MF := MainForm;
  if (MF = nil) or (MF.NavPage = nil) then
    Exit;
  for I := 0 to MF.NavPage.PageCount - 1 do
    if SameText(MF.NavPage.Pages[I].Name, 'CrmPotansiyelListesi') then
    begin
      Tab := TUniTabSheet(MF.NavPage.Pages[I]);
      Pnl := nil;
      for J := 0 to Tab.ControlCount - 1 do
        if Tab.Controls[J] is TUniPanel then
        begin
          Pnl := TUniPanel(Tab.Controls[J]);
          Break;
        end;
      if Pnl = nil then
        Exit;
      BorderStyle := bsNone;
      BorderIcons := [];
      Parent := Pnl;
      Align := alClient;
      if AGizle or (MF.NavPage.ActivePage <> Tab) then
        Visible := False
      else
        Visible := True;
      Exit;
    end;
end;

procedure TfrmCrmPotansiyelListe.GomuluDurumaGetir;
begin
  ListeSekmesineGeriAl(not GomuluNavSekmesiMi);
  HedefPotansiyelIdEdit := nil;
  OnPotansiyelSecildi := nil;
  OnPotansiyelSecildiCoklu := nil;
  FCokluSecimModu := False;
  SecimModuToolbarGuncelle;
end;

procedure TfrmCrmPotansiyelListe.UniFormShow(Sender: TObject);
begin
  GomuluDurumaGetir;
  Visible := True;
  FiltreDurumlariDoldur;
  GridCheckSecimAyar(False);
  btnListeleClick(Sender);
  SecimModuToolbarGuncelle;
end;

end.
