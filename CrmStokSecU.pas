unit CrmStokSecU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniEdit, uniButton,
  uniBasicGrid, uniDBGrid, Data.DB, MemDS, DBAccess, Uni, uniLabel;

type
  TfrmCrmStokSec = class(TUniForm)
    pnlToolbar: TUniPanel;
    lblBilgi: TUniLabel;
    edArama: TUniEdit;
    btnListele: TUniButton;
    btnSec: TUniButton;
    btnKapat: TUniButton;
    grdStok: TUniDBGrid;
    spStokListe: TUniStoredProc;
    dsStok: TUniDataSource;
    procedure UniFormShow(Sender: TObject);
    procedure btnListeleClick(Sender: TObject);
    procedure btnSecClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure edAramaKeyPress(Sender: TObject; var Key: Char);
    procedure grdStokAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
  private
    procedure StokSecVeKapat;
  public
    { ShowModal oncesi atanir; Sec ile doldurulur. }
    HedefStokKod: TUniEdit;
    HedefStokAd: TUniEdit;
    HedefBirimFiyat: TUniEdit;
  end;

function frmCrmStokSec: TfrmCrmStokSec;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, DMU, TmpU;

function frmCrmStokSec: TfrmCrmStokSec;
begin
  Result := TfrmCrmStokSec(UniMainModule.GetFormInstance(TfrmCrmStokSec));
end;

procedure TfrmCrmStokSec.UniFormShow(Sender: TObject);
begin
  spStokListe.Close;
end;

procedure TfrmCrmStokSec.btnListeleClick(Sender: TObject);
begin
  spStokListe.Close;
  spStokListe.Prepare;
  spStokListe.ParamByName('sube').AsInteger := Tmp.xSubeKodu;
  spStokListe.ParamByName('depo').AsInteger := Tmp.xKullaniciDepo;
  spStokListe.ParamByName('stok').AsString := Trim(edArama.Text);
  spStokListe.ExecProc;
end;

procedure TfrmCrmStokSec.StokSecVeKapat;
var
  F: TField;
  V: Double;
begin
  if not spStokListe.Active or spStokListe.IsEmpty then
  begin
    UniMainModule.saHata.Show('Once listele yapin ve bir satir secin.');
    Exit;
  end;
  if Assigned(HedefStokKod) then
    HedefStokKod.Text := Trim(spStokListe.FieldByName('STOK_KODU').AsString);
  if Assigned(HedefStokAd) then
    HedefStokAd.Text := Trim(spStokListe.FieldByName('STOK_ADI').AsString);
  if Assigned(HedefBirimFiyat) then
  begin
    F := spStokListe.FindField('SATIS_FIAT1');
    if not Assigned(F) then
      F := spStokListe.FindField('SF1');
    if Assigned(F) and (not F.IsNull) then
    begin
      V := F.AsFloat;
      HedefBirimFiyat.Text := StringReplace(FormatFloat('0.####', V), ',', '.', []);
    end;
  end;
  HedefStokKod := nil;
  HedefStokAd := nil;
  HedefBirimFiyat := nil;
  Close;
end;

procedure TfrmCrmStokSec.btnSecClick(Sender: TObject);
begin
  StokSecVeKapat;
end;

procedure TfrmCrmStokSec.btnKapatClick(Sender: TObject);
begin
  HedefStokKod := nil;
  HedefStokAd := nil;
  HedefBirimFiyat := nil;
  Close;
end;

procedure TfrmCrmStokSec.edAramaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnListeleClick(Sender);
  end;
end;

procedure TfrmCrmStokSec.grdStokAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if SameText(EventName, 'celldblclick') then
    StokSecVeKapat;
end;

end.
