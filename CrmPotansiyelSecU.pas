unit CrmPotansiyelSecU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniButton, uniCheckBox, uniComboBox,
  uniBasicGrid, uniDBGrid, Data.DB, MemDS, DBAccess, Uni, MainModule,
  uniMultiItem;

type
  TfrmCrmPotansiyelSec = class(TUniForm)
    rootPanel: TUniPanel;
    pnlToolbar: TUniPanel;
    lblBilgi: TUniLabel;
    lblSecili: TUniLabel;
    btnListele: TUniButton;
    btnSec: TUniButton;
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
    procedure btnSecClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure grdAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure grdSelectionChange(Sender: TObject);
    procedure UniFormDestroy(Sender: TObject);
  private
    FCokluSecimModu: Boolean;
    procedure GridCheckSecimAyar(ACoklu: Boolean);
    procedure GuncelleSeciliSayisi;
    function SeciliPotIdListesi: TStringList;
    function PotIdOkuSatirdan: Int64;
    function PotSeciliPotansiyelId(out APotId: Int64): Boolean;
    procedure FiltreDurumlariDoldur;
    procedure SecimModuArayuz;
    function CokluSecimYolu: Boolean;
    procedure PotansiyelSecVeKapat;
    procedure PotansiyelCokluSecVeKapat;
    procedure SecimYapVeKapat;
  public
    HedefPotansiyelIdEdit: TUniEdit;
    HedefPotansiyelUnvanLabel: TUniLabel;
    OnPotansiyelSecildi: TCrmPotListeSecildiEvent;
    OnPotansiyelSecildiCoklu: TCrmPotListeSecildiCokluEvent;
    property CokluSecimModu: Boolean read FCokluSecimModu write FCokluSecimModu;
    procedure SecimToolbarYenile;
    procedure SecimModuHazirla(ACoklu: Boolean);
  end;

function frmCrmPotansiyelSec: TfrmCrmPotansiyelSec;
function CrmPotansiyelSecFormOlustur: TfrmCrmPotansiyelSec;

implementation

{$R *.dfm}

uses
  uniGUIApplication, DMU;

function frmCrmPotansiyelSec: TfrmCrmPotansiyelSec;
begin
  Result := TfrmCrmPotansiyelSec(UniMainModule.GetFormInstance(TfrmCrmPotansiyelSec));
end;

function CrmPotansiyelSecFormOlustur: TfrmCrmPotansiyelSec;
begin
  Result := TfrmCrmPotansiyelSec.Create(UniApplication);
end;

procedure TfrmCrmPotansiyelSec.SecimModuHazirla(ACoklu: Boolean);
begin
  FCokluSecimModu := ACoklu;
  if ACoklu then
  begin
    OnPotansiyelSecildi := nil;
    HedefPotansiyelIdEdit := nil;
    HedefPotansiyelUnvanLabel := nil;
  end
  else
    OnPotansiyelSecildiCoklu := nil;
  SecimModuArayuz;
end;

function TfrmCrmPotansiyelSec.CokluSecimYolu: Boolean;
begin
  Result := FCokluSecimModu or Assigned(OnPotansiyelSecildiCoklu);
end;

procedure TfrmCrmPotansiyelSec.GridCheckSecimAyar(ACoklu: Boolean);
begin
  grd.Options := [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect,
    dgCheckSelect, dgCheckSelectCheckOnly, dgAlwaysShowSelection, dgConfirmDelete, dgTabs,
    dgCancelOnExit, dgAutoRefreshRow];
  if ACoklu then
    grd.Options := grd.Options + [dgMultiSelect];
end;

procedure TfrmCrmPotansiyelSec.SecimToolbarYenile;
begin
  SecimModuArayuz;
end;

procedure TfrmCrmPotansiyelSec.SecimModuArayuz;
begin
  if CokluSecimYolu then
  begin
    FCokluSecimModu := True;
    GridCheckSecimAyar(True);
    btnSec.Caption := 'Se'#231'ilenleri ekle';
    btnSec.Hint := 'Isaretli potansiyelleri rotaya eklemek uzere dondurur';
    lblBilgi.Caption :=
      'Filtre + Listele; satir basindaki kutulari isaretleyin, ardindan Secilenleri ekle.';
    lblSecili.Visible := True;
    GuncelleSeciliSayisi;
  end
  else
  begin
    GridCheckSecimAyar(False);
    btnSec.Caption := 'Se'#231;
    btnSec.Hint := 'Isaretli satiri aktarir';
    lblBilgi.Caption :=
      'Filtre + Listele; satir basindaki kutuyu isaretleyin veya satira cift tiklayin.';
    lblSecili.Visible := False;
  end;
end;

procedure TfrmCrmPotansiyelSec.UniFormShow(Sender: TObject);
begin
  FiltreDurumlariDoldur;
  SecimModuArayuz;
  btnListeleClick(Sender);
end;

procedure TfrmCrmPotansiyelSec.GuncelleSeciliSayisi;
begin
  if not lblSecili.Visible then
    Exit;
  if grd.SelectedRows.Count > 0 then
    lblSecili.Caption := Format('Se'#231'ili: %d', [grd.SelectedRows.Count])
  else
    lblSecili.Caption := 'Se'#231'ili: 0';
end;

procedure TfrmCrmPotansiyelSec.grdSelectionChange(Sender: TObject);
begin
  GuncelleSeciliSayisi;
end;

function TfrmCrmPotansiyelSec.PotIdOkuSatirdan: Int64;
var
  F: TField;
begin
  Result := 0;
  if not qList.Active or qList.IsEmpty then
    Exit;
  qList.CheckBrowseMode;
  F := qList.FindField('POTANSIYEL_ID');
  if (F = nil) or F.IsNull then
    Exit;
  Result := F.AsLargeInt;
  if Result <= 0 then
    Result := F.AsInteger;
end;

function TfrmCrmPotansiyelSec.PotSeciliPotansiyelId(out APotId: Int64): Boolean;
begin
  APotId := 0;
  if not qList.Active or qList.IsEmpty then
    Exit(False);
  qList.CheckBrowseMode;
  if grd.SelectedRows.Count > 0 then
    qList.Bookmark := grd.SelectedRows[0];
  APotId := PotIdOkuSatirdan;
  Result := APotId > 0;
end;

function TfrmCrmPotansiyelSec.SeciliPotIdListesi: TStringList;
var
  I: Integer;
  Bm: TBookmark;
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
      PotId := PotIdOkuSatirdan;
      if PotId > 0 then
      begin
        IdStr := IntToStr(PotId);
        if Result.IndexOf(IdStr) < 0 then
          Result.Add(IdStr);
      end;
    end;
  end
  else
  begin
    PotId := PotIdOkuSatirdan;
    if PotId > 0 then
      Result.Add(IntToStr(PotId));
  end;
end;

procedure TfrmCrmPotansiyelSec.FiltreDurumlariDoldur;
begin
  cbFiltDurum.Items.Clear;
  cbFiltDurum.Items.Add('(T'#252'm'#252')');
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

procedure TfrmCrmPotansiyelSec.PotansiyelCokluSecVeKapat;
var
  Liste: TStringList;
begin
  Liste := SeciliPotIdListesi;
  if Liste.Count = 0 then
  begin
    Liste.Free;
    UniMainModule.saHata.Show(#214'nce listele yap'#305'n ve en az bir sat'#305'r se'#231'in.');
    Exit;
  end;
  if Assigned(OnPotansiyelSecildiCoklu) then
    OnPotansiyelSecildiCoklu(Self, Liste)
  else
    Liste.Free;
  OnPotansiyelSecildi := nil;
  OnPotansiyelSecildiCoklu := nil;
  HedefPotansiyelIdEdit := nil;
  HedefPotansiyelUnvanLabel := nil;
  FCokluSecimModu := False;
  Close;
end;

procedure TfrmCrmPotansiyelSec.PotansiyelSecVeKapat;
var
  PotId: Int64;
  Unvan: string;
begin
  if not PotSeciliPotansiyelId(PotId) then
  begin
    UniMainModule.saHata.Show(#214'nce listele yap'#305'n ve bir sat'#305'r se'#231'in.');
    Exit;
  end;
  Unvan := '';
  if (qList.FindField('FIRMA_UNVAN') <> nil) and not qList.FieldByName('FIRMA_UNVAN').IsNull then
    Unvan := Trim(qList.FieldByName('FIRMA_UNVAN').AsString);
  if Assigned(HedefPotansiyelIdEdit) then
    HedefPotansiyelIdEdit.Text := IntToStr(PotId);
  if Assigned(HedefPotansiyelUnvanLabel) then
    HedefPotansiyelUnvanLabel.Caption := Unvan;
  if Assigned(OnPotansiyelSecildi) then
    OnPotansiyelSecildi(Self, PotId);
  if UniSession <> nil then
    UniSession.Synchronize;
  OnPotansiyelSecildi := nil;
  HedefPotansiyelIdEdit := nil;
  HedefPotansiyelUnvanLabel := nil;
  Close;
end;

procedure TfrmCrmPotansiyelSec.SecimYapVeKapat;
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

procedure TfrmCrmPotansiyelSec.btnListeleClick(Sender: TObject);
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
    Sql := Sql + ' AND P.NETSIS_CARI_KOD IS NOT NULL AND LTRIM(RTRIM(P.NETSIS_CARI_KOD)) <> ' + #39#39;
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

procedure TfrmCrmPotansiyelSec.btnSecClick(Sender: TObject);
begin
  SecimYapVeKapat;
end;

procedure TfrmCrmPotansiyelSec.btnKapatClick(Sender: TObject);
begin
  OnPotansiyelSecildi := nil;
  OnPotansiyelSecildiCoklu := nil;
  FCokluSecimModu := False;
  HedefPotansiyelIdEdit := nil;
  HedefPotansiyelUnvanLabel := nil;
  UniMainModule.CrmPotListeSecimCallback := nil;
  UniMainModule.CrmPotListeSecimKaynakListe := nil;
  if UniMainModule.CrmRotaDurakSecimAktif then
    UniMainModule.CrmRotaDurakSecimBitir;
  Close;
end;

procedure TfrmCrmPotansiyelSec.grdAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if SameText(EventName, 'celldblclick') then
    SecimYapVeKapat;
end;

procedure TfrmCrmPotansiyelSec.UniFormDestroy(Sender: TObject);
begin
  OnPotansiyelSecildi := nil;
  OnPotansiyelSecildiCoklu := nil;
  FCokluSecimModu := False;
  HedefPotansiyelIdEdit := nil;
  HedefPotansiyelUnvanLabel := nil;
end;

end.
