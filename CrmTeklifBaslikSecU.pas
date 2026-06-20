unit CrmTeklifBaslikSecU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniEdit, uniButton,
  uniBasicGrid, uniDBGrid, Data.DB, MemDS, DBAccess, Uni, uniLabel;

type
  TCrmBaslikSecMod = (cbsTeklifAcik, cbsSiparisNetsis);
  TCrmTeklifSecildiEvent = procedure(Sender: TObject; const AFisNo: string) of object;

  TfrmCrmTeklifBaslikSec = class(TUniForm)
    pnlToolbar: TUniPanel;
    lblBilgi: TUniLabel;
    edArama: TUniEdit;
    btnListele: TUniButton;
    btnSec: TUniButton;
    btnKapat: TUniButton;
    grdTeklif: TUniDBGrid;
    qTeklif: TUniQuery;
    dsTeklif: TUniDataSource;
    procedure UniFormShow(Sender: TObject);
    procedure btnListeleClick(Sender: TObject);
    procedure btnSecClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure edAramaKeyPress(Sender: TObject; var Key: Char);
    procedure grdTeklifAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
  private
    procedure SecVeKapat;
    procedure TemizleReferanslar;
    procedure ModArayuzGuncelle;
    function SqlQuote(const S: string): string;
  public
    SecimModu: TCrmBaslikSecMod;
    FiltreCariKod: string;
    HedefTeklifEdit: TUniEdit;
    HedefSiparisEdit: TUniEdit;
    HedefSiparisTarLabel: TUniLabel;
    OnTeklifSecildi: TCrmTeklifSecildiEvent;
    OnSiparisSecildi: TCrmTeklifSecildiEvent;
  end;

function frmCrmTeklifBaslikSec: TfrmCrmTeklifBaslikSec;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, DMU, Genel;

function frmCrmTeklifBaslikSec: TfrmCrmTeklifBaslikSec;
begin
  Result := TfrmCrmTeklifBaslikSec(UniMainModule.GetFormInstance(TfrmCrmTeklifBaslikSec));
end;

function TfrmCrmTeklifBaslikSec.SqlQuote(const S: string): string;
begin
  Result := StringReplace(Trim(S), '''', '''''', [rfReplaceAll]);
end;

procedure TfrmCrmTeklifBaslikSec.TemizleReferanslar;
begin
  OnTeklifSecildi := nil;
  OnSiparisSecildi := nil;
  HedefTeklifEdit := nil;
  HedefSiparisEdit := nil;
  HedefSiparisTarLabel := nil;
  FiltreCariKod := '';
  SecimModu := cbsTeklifAcik;
end;

procedure TfrmCrmTeklifBaslikSec.ModArayuzGuncelle;
begin
  if SecimModu = cbsSiparisNetsis then
  begin
    Caption := 'Siparis Secimi (Siparis Basligi)';
    lblBilgi.Caption :=
      'Acik siparis basligi kayitlari (Netsis''e gonderilmis, kapali kayitlar haric). FisNo / cari kod yazip Listele; ' +
      'secili satiri Sec veya cift tiklayin.';
    btnSec.Hint := 'Secili siparis fis numarasini aktarir';
  end
  else
  begin
    Caption := 'Teklif Secimi (Siparis Basligi)';
    lblBilgi.Caption :=
      'Acik teklif kayitlari (Netsis''e gonderilmemis, kapali kayitlar haric). FisNo / cari kod yazip Listele; ' +
      'secili satiri Sec veya cift tiklayin.';
    btnSec.Hint := 'Secili teklif fis numarasini aktarir';
  end;
end;

procedure TfrmCrmTeklifBaslikSec.UniFormShow(Sender: TObject);
begin
  qTeklif.Close;
  ModArayuzGuncelle;
  if SecimModu = cbsSiparisNetsis then
  begin
    if Trim(FiltreCariKod) <> '' then
      edArama.Text := Trim(FiltreCariKod);
  end
  else if Trim(edArama.Text) = '' then
  begin
    if Trim(FiltreCariKod) <> '' then
      edArama.Text := Trim(FiltreCariKod);
  end;
end;

procedure TfrmCrmTeklifBaslikSec.btnListeleClick(Sender: TObject);
var
  SQL, F, Ck: string;
begin
  F := SqlQuote(edArama.Text);
  Ck := SqlQuote(FiltreCariKod);
  SQL :=
    'SELECT TOP 400 SB.FisNo, SB.CariKod, C.CARI_ISIM AS CARI_AD, SB.Tarih, SB.Saat, SB.NetsisSiparisNo ' +
    'FROM SIPARIS_BASLIK SB WITH(NOLOCK) ' +
    'LEFT JOIN YUCEL..HV_CARI_LISTESI C WITH(NOLOCK) ON C.CARI_KOD = SB.CariKod ' +
    'WHERE 1=1 AND ISNULL(SB.AcikKapali, 0) = 0 ';
  if SecimModu = cbsSiparisNetsis then
    SQL := SQL + 'AND ISNULL(SB.NetsisSiparisNo, '''') <> '''' '
  else
    SQL := SQL + 'AND ISNULL(SB.NetsisSiparisNo, '''') = '''' ';
  if Ck <> '' then
    SQL := SQL + 'AND SB.CariKod = ''' + Ck + ''' ';
  if F <> '' then
    SQL := SQL +
      'AND (SB.FisNo LIKE ''%' + F + '%'' OR SB.CariKod LIKE ''%' + F + '%'' ' +
      'OR ISNULL(C.CARI_ISIM, '''') LIKE ''%' + F + '%'' ' +
      'OR ISNULL(SB.NetsisSiparisNo, '''') LIKE ''%' + F + '%'') ';
  SQL := SQL + 'ORDER BY SB.Tarih DESC, SB.Saat DESC, SB.FisNo DESC';
  qTeklif.Connection := frmDM.conAsya;
  Genel.xTabloAc(qTeklif, SQL);
end;

procedure TfrmCrmTeklifBaslikSec.SecVeKapat;
var
  FisNo: string;
  Tar: TDateTime;
begin
  if not qTeklif.Active or qTeklif.IsEmpty then
  begin
    UniMainModule.saHata.Show('Once listele yapin ve bir satir secin.');
    Exit;
  end;
  FisNo := Trim(qTeklif.FieldByName('FisNo').AsString);
  if SecimModu = cbsSiparisNetsis then
  begin
    if Assigned(HedefSiparisEdit) then
      HedefSiparisEdit.Text := FisNo;
    if Assigned(HedefSiparisTarLabel) then
    begin
      Tar := 0;
      if (qTeklif.FindField('Tarih') <> nil) and not qTeklif.FieldByName('Tarih').IsNull then
        Tar := qTeklif.FieldByName('Tarih').AsDateTime;
      if Tar > 0 then
        HedefSiparisTarLabel.Caption := FormatDateTime('dd.mm.yyyy', Tar)
      else
        HedefSiparisTarLabel.Caption := '';
    end;
    if Assigned(OnSiparisSecildi) then
      OnSiparisSecildi(Self, FisNo);
  end
  else
  begin
    if Assigned(HedefTeklifEdit) then
      HedefTeklifEdit.Text := FisNo;
    if Assigned(OnTeklifSecildi) then
      OnTeklifSecildi(Self, FisNo);
  end;
  TemizleReferanslar;
  Close;
end;

procedure TfrmCrmTeklifBaslikSec.btnSecClick(Sender: TObject);
begin
  SecVeKapat;
end;

procedure TfrmCrmTeklifBaslikSec.btnKapatClick(Sender: TObject);
begin
  TemizleReferanslar;
  Close;
end;

procedure TfrmCrmTeklifBaslikSec.edAramaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnListeleClick(Sender);
  end;
end;

procedure TfrmCrmTeklifBaslikSec.grdTeklifAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
begin
  if SameText(EventName, 'celldblclick') then
    SecVeKapat;
end;

end.
