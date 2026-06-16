unit CrmPotSecU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniEdit, uniButton,
  uniBasicGrid, uniDBGrid, Data.DB, MemDS, DBAccess, Uni, uniLabel, MainModule;

type
  TfrmCrmPotSec = class(TUniForm)
    pnlToolbar: TUniPanel;
    lblBilgi: TUniLabel;
    lblSecili: TUniLabel;
    edArama: TUniEdit;
    btnListele: TUniButton;
    btnSec: TUniButton;
    btnKapat: TUniButton;
    grdPot: TUniDBGrid;
    qPot: TUniQuery;
    dsPot: TUniDataSource;
    procedure UniFormShow(Sender: TObject);
    procedure btnListeleClick(Sender: TObject);
    procedure btnSecClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure edAramaKeyPress(Sender: TObject; var Key: Char);
    procedure grdPotAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure grdPotSelectionChange(Sender: TObject);
  private
    FCokluSecimModu: Boolean;
    procedure PotansiyelSecVeKapat;
    procedure PotansiyelCokluSecVeKapat;
    procedure GuncelleSeciliSayisi;
    function SeciliPotIdListesi: TStringList;
    function PotIdOkuSatirdan: Int64;
    function SqlQuote(const S: string): string;
    procedure SecimModuArayuz;
    procedure GridCheckSecimAyar(ACoklu: Boolean);
    function CokluSecimYolu: Boolean;
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

function frmCrmPotSec: TfrmCrmPotSec;

implementation

{$R *.dfm}

uses
  uniGUIApplication, DMU, Genel;

function frmCrmPotSec: TfrmCrmPotSec;
begin
  Result := TfrmCrmPotSec(UniMainModule.GetFormInstance(TfrmCrmPotSec));
end;

procedure TfrmCrmPotSec.SecimModuHazirla(ACoklu: Boolean);
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

function TfrmCrmPotSec.SqlQuote(const S: string): string;
begin
  Result := StringReplace(Trim(S), '''', '''''', [rfReplaceAll]);
end;

function TfrmCrmPotSec.CokluSecimYolu: Boolean;
begin
  Result := FCokluSecimModu or Assigned(OnPotansiyelSecildiCoklu);
end;

procedure TfrmCrmPotSec.GridCheckSecimAyar(ACoklu: Boolean);
begin
  grdPot.Options := grdPot.Options + [dgCheckSelect, dgCheckSelectCheckOnly, dgAlwaysShowSelection, dgRowSelect];
  if ACoklu then
    grdPot.Options := grdPot.Options + [dgMultiSelect]
  else
    grdPot.Options := grdPot.Options - [dgMultiSelect];
end;

procedure TfrmCrmPotSec.SecimToolbarYenile;
begin
  SecimModuArayuz;
end;

procedure TfrmCrmPotSec.SecimModuArayuz;
begin
  if CokluSecimYolu then
  begin
    FCokluSecimModu := True;
    GridCheckSecimAyar(True);
    btnSec.Caption := 'Se'#231'ilenleri ekle';
    btnSec.Hint := 'Isaretli satirlari rotaya eklemek uzere dondurur';
    lblBilgi.Caption :=
      'Firma unvani / Netsis kodu yazip Listele; satir basindaki kutuyu isaretleyin, ardindan Secilenleri ekle.';
    lblSecili.Visible := True;
    GuncelleSeciliSayisi;
  end
  else
  begin
    GridCheckSecimAyar(False);
    btnSec.Caption := 'Se'#231;
    btnSec.Hint := 'Isaretli satiri aktarir';
    lblBilgi.Caption :=
      'Firma unvani / Netsis kodu yazip Listele; satir basindaki kutuyu isaretleyin veya satira cift tiklayin.';
    lblSecili.Visible := False;
  end;
end;

procedure TfrmCrmPotSec.UniFormShow(Sender: TObject);
begin
  qPot.Close;
  SecimModuArayuz;
end;

procedure TfrmCrmPotSec.GuncelleSeciliSayisi;
begin
  if not lblSecili.Visible then
    Exit;
  if grdPot.SelectedRows.Count > 0 then
    lblSecili.Caption := Format('Secili: %d', [grdPot.SelectedRows.Count])
  else
    lblSecili.Caption := 'Secili: 0';
end;

procedure TfrmCrmPotSec.grdPotSelectionChange(Sender: TObject);
begin
  GuncelleSeciliSayisi;
end;

function TfrmCrmPotSec.PotIdOkuSatirdan: Int64;
var
  F: TField;
begin
  Result := 0;
  if not qPot.Active or qPot.IsEmpty then
    Exit;
  qPot.CheckBrowseMode;
  F := qPot.FindField('POTANSIYEL_ID');
  if (F = nil) or F.IsNull then
    Exit;
  Result := F.AsLargeInt;
  if Result <= 0 then
    Result := F.AsInteger;
end;

function TfrmCrmPotSec.SeciliPotIdListesi: TStringList;
var
  I: Integer;
  Bm: TBookmark;
  PotId: Int64;
  IdStr: string;
begin
  Result := TStringList.Create;
  Result.Sorted := True;
  Result.Duplicates := dupIgnore;
  if not qPot.Active or qPot.IsEmpty then
    Exit;
  qPot.CheckBrowseMode;
  if grdPot.SelectedRows.Count > 0 then
  begin
    for I := 0 to grdPot.SelectedRows.Count - 1 do
    begin
      Bm := grdPot.SelectedRows[I];
      qPot.Bookmark := Bm;
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

procedure TfrmCrmPotSec.PotansiyelCokluSecVeKapat;
var
  Liste: TStringList;
begin
  Liste := SeciliPotIdListesi;
  if Liste.Count = 0 then
  begin
    Liste.Free;
    UniMainModule.saHata.Show('Once listele yapin ve en az bir satir secin.');
    Exit;
  end;
  if Assigned(OnPotansiyelSecildiCoklu) then
    OnPotansiyelSecildiCoklu(Self, Liste)
  else
    Liste.Free;
  OnPotansiyelSecildi := nil;
  OnPotansiyelSecildiCoklu := nil;
  FCokluSecimModu := False;
  Close;
end;

procedure TfrmCrmPotSec.SecimYapVeKapat;
begin
  if CokluSecimYolu and (grdPot.SelectedRows.Count > 1) then
    PotansiyelCokluSecVeKapat
  else if Assigned(OnPotansiyelSecildi) then
    PotansiyelSecVeKapat
  else if CokluSecimYolu then
    PotansiyelCokluSecVeKapat
  else
    PotansiyelSecVeKapat;
end;

procedure TfrmCrmPotSec.btnListeleClick(Sender: TObject);
var
  SQL, F: string;
begin
  F := SqlQuote(edArama.Text);
  SQL :=
    'SELECT TOP 400 P.POTANSIYEL_ID, P.FIRMA_UNVAN, P.KISA_AD, P.NETSIS_CARI_KOD, D.KOD AS DURUM_KOD, ' +
    'P.IL, P.ILCE, P.EPOSTA, P.TELEFON_SABIT, P.OLUSTURMA_UTC ' +
    'FROM dbo.CRM_POTANSIYEL_MUSTERI P ' +
    'INNER JOIN dbo.CRM_POTANSIYEL_DURUM D ON D.POTANSIYEL_DURUM_ID = P.POTANSIYEL_DURUM_ID ';
  if F = '' then
    SQL := SQL + 'ORDER BY P.POTANSIYEL_ID DESC'
  else
    SQL := SQL +
      'WHERE (DBO.TRK(P.FIRMA_UNVAN) LIKE ''%' + F + '%'' OR P.NETSIS_CARI_KOD LIKE ''%' + F + '%'' ' +
      'OR CAST(P.POTANSIYEL_ID AS VARCHAR(20)) LIKE ''%' + F + '%'') ' +
      'ORDER BY P.POTANSIYEL_ID DESC';
  Genel.xTabloAc(qPot, SQL);
end;

procedure TfrmCrmPotSec.PotansiyelSecVeKapat;
var
  PotId: Int64;
  Unvan: string;
begin
  if not qPot.Active or qPot.IsEmpty then
  begin
    UniMainModule.saHata.Show('Once listele yapin ve bir satir secin.');
    Exit;
  end;
  qPot.CheckBrowseMode;
  if grdPot.SelectedRows.Count > 0 then
    qPot.Bookmark := grdPot.SelectedRows[0];
  PotId := PotIdOkuSatirdan;
  if PotId <= 0 then
  begin
    UniMainModule.saHata.Show('Once listele yapin ve bir satir secin.');
    Exit;
  end;
  Unvan := '';
  if (qPot.FindField('FIRMA_UNVAN') <> nil) and not qPot.FieldByName('FIRMA_UNVAN').IsNull then
    Unvan := Trim(qPot.FieldByName('FIRMA_UNVAN').AsString);
  if Assigned(HedefPotansiyelIdEdit) then
    HedefPotansiyelIdEdit.Text := IntToStr(PotId);
  if Assigned(HedefPotansiyelUnvanLabel) then
    HedefPotansiyelUnvanLabel.Caption := Unvan;
  if Assigned(OnPotansiyelSecildi) then
    OnPotansiyelSecildi(Self, PotId);
  OnPotansiyelSecildi := nil;
  HedefPotansiyelIdEdit := nil;
  HedefPotansiyelUnvanLabel := nil;
  Close;
end;

procedure TfrmCrmPotSec.btnSecClick(Sender: TObject);
begin
  SecimYapVeKapat;
end;

procedure TfrmCrmPotSec.btnKapatClick(Sender: TObject);
begin
  OnPotansiyelSecildi := nil;
  OnPotansiyelSecildiCoklu := nil;
  FCokluSecimModu := False;
  HedefPotansiyelIdEdit := nil;
  HedefPotansiyelUnvanLabel := nil;
  if UniMainModule.CrmRotaDurakSecimAktif then
    UniMainModule.CrmRotaDurakSecimBitir;
  Close;
end;

procedure TfrmCrmPotSec.edAramaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnListeleClick(Sender);
  end;
end;

procedure TfrmCrmPotSec.grdPotAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if SameText(EventName, 'celldblclick') then
    SecimYapVeKapat;
end;

end.
