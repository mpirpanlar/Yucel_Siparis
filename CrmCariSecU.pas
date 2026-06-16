unit CrmCariSecU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniEdit, uniButton,
  uniBasicGrid, uniDBGrid, Data.DB, MemDS, DBAccess, Uni, uniLabel;

type
  TCrmCariSecildiEvent = procedure(Sender: TObject; const ACariKod: string) of object;
  TCrmCariSecildiCokluEvent = procedure(Sender: TObject; ACariKodlar: TStringList) of object;

  TfrmCrmCariSec = class(TUniForm)
    pnlToolbar: TUniPanel;
    lblBilgi: TUniLabel;
    lblSecili: TUniLabel;
    edArama: TUniEdit;
    btnListele: TUniButton;
    btnSec: TUniButton;
    btnKapat: TUniButton;
    grdCari: TUniDBGrid;
    qCari: TUniQuery;
    dsCari: TUniDataSource;
    procedure UniFormShow(Sender: TObject);
    procedure btnListeleClick(Sender: TObject);
    procedure btnSecClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure edAramaKeyPress(Sender: TObject; var Key: Char);
    procedure grdCariAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure grdCariSelectionChange(Sender: TObject);
  private
    FCokluSecimModu: Boolean;
    procedure CariSecVeKapat;
    procedure CokluSecVeKapat;
    procedure GuncelleSeciliSayisi;
    function SeciliCariKodlari: TStringList;
    function SqlQuote(const S: string): string;
    procedure SecimModuArayuz;
    procedure GridCheckSecimAyar(ACoklu: Boolean);
    function CokluSecimYolu: Boolean;
    procedure SecimYapVeKapat;
  public
    { Siparis / StokBul benzeri: ShowModal oncesi atanir, Sec ile doldurulur. }
    HedefCariEdit: TUniEdit;
    { HedefCariEdit ile ayni mantik: secimde griddeki CARI_ISIM yazilir. }
    HedefCariAdLabel: TUniLabel;
    { Atanirsa cari seciminde kod ile birlikte cagrilir (rota plan vb.). }
    OnCariSecildi: TCrmCariSecildiEvent;
    { Rota plan: birden fazla cari kodu; liste sahipligi cagirana gecer. }
    OnCariSecildiCoklu: TCrmCariSecildiCokluEvent;
    property CokluSecimModu: Boolean read FCokluSecimModu write FCokluSecimModu;
    procedure SecimToolbarYenile;
  end;

function frmCrmCariSec: TfrmCrmCariSec;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, DMU, Genel;

function frmCrmCariSec: TfrmCrmCariSec;
begin
  Result := TfrmCrmCariSec(UniMainModule.GetFormInstance(TfrmCrmCariSec));
end;

function TfrmCrmCariSec.SqlQuote(const S: string): string;
begin
  Result := StringReplace(Trim(S), '''', '''''', [rfReplaceAll]);
end;

function TfrmCrmCariSec.CokluSecimYolu: Boolean;
begin
  Result := FCokluSecimModu or Assigned(OnCariSecildiCoklu);
end;

procedure TfrmCrmCariSec.GridCheckSecimAyar(ACoklu: Boolean);
begin
  grdCari.Options := grdCari.Options + [dgCheckSelect, dgCheckSelectCheckOnly, dgAlwaysShowSelection, dgRowSelect];
  if ACoklu then
    grdCari.Options := grdCari.Options + [dgMultiSelect]
  else
    grdCari.Options := grdCari.Options - [dgMultiSelect];
end;

procedure TfrmCrmCariSec.SecimToolbarYenile;
begin
  SecimModuArayuz;
end;

procedure TfrmCrmCariSec.SecimModuArayuz;
begin
  if CokluSecimYolu then
  begin
    FCokluSecimModu := True;
    GridCheckSecimAyar(True);
    btnSec.Caption := 'Se'#231'ilenleri ekle';
    btnSec.Hint := 'Isaretli satirlari rotaya eklemek uzere dondurur';
    lblBilgi.Caption :=
      'Cari adi/kodu yazip Listele; satir basindaki kutuyu isaretleyin, ardindan Secilenleri ekle.';
    lblSecili.Visible := True;
    GuncelleSeciliSayisi;
  end
  else
  begin
    GridCheckSecimAyar(False);
    btnSec.Caption := 'Se'#231;
    btnSec.Hint := 'Isaretli satiri aktarir';
    lblBilgi.Caption :=
      'Cari adi/kodu yazip Listele; satir basindaki kutuyu isaretleyin veya satira cift tiklayin.';
    lblSecili.Visible := False;
  end;
end;

procedure TfrmCrmCariSec.UniFormShow(Sender: TObject);
begin
  qCari.Close;
  SecimModuArayuz;
end;

procedure TfrmCrmCariSec.GuncelleSeciliSayisi;
begin
  if not lblSecili.Visible then
    Exit;
  if grdCari.SelectedRows.Count > 0 then
    lblSecili.Caption := Format('Secili: %d', [grdCari.SelectedRows.Count])
  else
    lblSecili.Caption := 'Secili: 0';
end;

procedure TfrmCrmCariSec.grdCariSelectionChange(Sender: TObject);
begin
  GuncelleSeciliSayisi;
end;

function TfrmCrmCariSec.SeciliCariKodlari: TStringList;
var
  I: Integer;
  Bm: TBookmark;
  Ck: string;
begin
  Result := TStringList.Create;
  Result.Sorted := True;
  Result.Duplicates := dupIgnore;
  if not qCari.Active or qCari.IsEmpty then
    Exit;
  qCari.CheckBrowseMode;
  if grdCari.SelectedRows.Count > 0 then
  begin
    for I := 0 to grdCari.SelectedRows.Count - 1 do
    begin
      Bm := grdCari.SelectedRows[I];
      qCari.Bookmark := Bm;
      Ck := Trim(qCari.FieldByName('CARI_KOD').AsString);
      if (Ck <> '') and (Result.IndexOf(Ck) < 0) then
        Result.Add(Ck);
    end;
  end
  else
  begin
    Ck := Trim(qCari.FieldByName('CARI_KOD').AsString);
    if Ck <> '' then
      Result.Add(Ck);
  end;
end;

procedure TfrmCrmCariSec.CokluSecVeKapat;
var
  Liste: TStringList;
begin
  Liste := SeciliCariKodlari;
  if Liste.Count = 0 then
  begin
    Liste.Free;
    UniMainModule.saHata.Show('Once listele yapin ve en az bir satir secin.');
    Exit;
  end;
  if Assigned(OnCariSecildiCoklu) then
    OnCariSecildiCoklu(Self, Liste)
  else
    Liste.Free;
  OnCariSecildi := nil;
  OnCariSecildiCoklu := nil;
  FCokluSecimModu := False;
  Close;
end;

procedure TfrmCrmCariSec.SecimYapVeKapat;
begin
  if CokluSecimYolu and (grdCari.SelectedRows.Count > 1) then
    CokluSecVeKapat
  else if Assigned(OnCariSecildi) then
    CariSecVeKapat
  else if CokluSecimYolu then
    CokluSecVeKapat
  else
    CariSecVeKapat;
end;

procedure TfrmCrmCariSec.btnListeleClick(Sender: TObject);
var
  SQL: string;
  F: string;
begin
  F := SqlQuote(edArama.Text);
  if F = '' then
    SQL := 'SELECT TOP 400 * FROM YUCEL..HV_CARI_LISTESI ORDER BY CARI_KOD'
  else
    SQL :=
      'SELECT * FROM YUCEL..HV_CARI_LISTESI WHERE ' +
      '(DBO.TRK(CARI_ISIM) LIKE ''%' + F + '%'' OR CARI_KOD LIKE ''%' + F + '%'') ' +
      'ORDER BY CARI_KOD';
  Genel.xTabloAc(qCari, SQL);
end;

procedure TfrmCrmCariSec.CariSecVeKapat;
var
  Ck, Ci: string;
begin
  if not qCari.Active or qCari.IsEmpty then
  begin
    UniMainModule.saHata.Show('Once listele yapin ve bir satir secin.');
    Exit;
  end;
  qCari.CheckBrowseMode;
  if grdCari.SelectedRows.Count > 0 then
    qCari.Bookmark := grdCari.SelectedRows[0];
  Ck := Trim(qCari.FieldByName('CARI_KOD').AsString);
  Ci := '';
  if (qCari.FindField('CARI_ISIM') <> nil) and not qCari.FieldByName('CARI_ISIM').IsNull then
    Ci := Trim(qCari.FieldByName('CARI_ISIM').AsString);
  if Assigned(HedefCariEdit) then
    HedefCariEdit.Text := Ck;
  if Assigned(HedefCariAdLabel) then
    HedefCariAdLabel.Caption := Ci;
  if Assigned(OnCariSecildi) then
    OnCariSecildi(Self, Ck);
  OnCariSecildi := nil;
  HedefCariEdit := nil;
  HedefCariAdLabel := nil;
  Close;
end;

procedure TfrmCrmCariSec.btnSecClick(Sender: TObject);
begin
  SecimYapVeKapat;
end;

procedure TfrmCrmCariSec.btnKapatClick(Sender: TObject);
begin
  OnCariSecildi := nil;
  OnCariSecildiCoklu := nil;
  FCokluSecimModu := False;
  HedefCariEdit := nil;
  HedefCariAdLabel := nil;
  if UniMainModule.CrmRotaDurakSecimAktif then
    UniMainModule.CrmRotaDurakSecimBitir;
  Close;
end;

procedure TfrmCrmCariSec.edAramaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnListeleClick(Sender);
  end;
end;

procedure TfrmCrmCariSec.grdCariAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if SameText(EventName, 'celldblclick') then
    SecimYapVeKapat;
end;

end.
