unit ParametrelerU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniBasicGrid, uniDBGrid, uniDBEdit, uniMultiItem,
  uniComboBox, uniDBComboBox, uniDBLookupComboBox, uniPageControl, uniPanel,
  uniCheckBox, uniDBCheckBox, uniBitBtn, uniSpeedButton, uniEdit, uniButton,
  uniGUIBaseClasses, Data.DB, MemDS, DBAccess, Uni, uniSweetAlert;

type
  TfrmParametreler = class(TUniForm)
    UniContainerPanel1: TUniContainerPanel;
    UniPanel2: TUniPanel;
    bntKaydet: TUniButton;
    btnDuzenle: TUniButton;
    btnKapat: TUniButton;
    UniPanel1: TUniPanel;
    btnGenel: TUniSpeedButton;
    btnYetkili: TUniSpeedButton;
    btnBanka: TUniSpeedButton;
    UniSimplePanel4: TUniSimplePanel;
    UniPageControl1: TUniPageControl;
    tabGenel: TUniTabSheet;
    TabFatura: TUniTabSheet;
    tabBanka: TUniTabSheet;
    UniPanel5: TUniPanel;
    UniButton1: TUniButton;
    UniButton2: TUniButton;
    UniButton3: TUniButton;
    UniDBGrid2: TUniDBGrid;
    UniSimplePanel2: TUniSimplePanel;
    UniDBCheckBox2: TUniDBCheckBox;
    UniDBCheckBox3: TUniDBCheckBox;
    UniSimplePanel1: TUniSimplePanel;
    edCariKod: TUniDBEdit;
    UniDBEdit1: TUniDBEdit;
    edCariNo: TUniEdit;
    edStokNo: TUniEdit;
    lcParaBirimi: TUniDBLookupComboBox;
    UniSimplePanel3: TUniSimplePanel;
    UniDBCheckBox4: TUniDBCheckBox;
    UniDBCheckBox5: TUniDBCheckBox;
    UniSimplePanel5: TUniSimplePanel;
    UniDBCheckBox6: TUniDBCheckBox;
    UniDBEdit3: TUniDBEdit;
    UniDBEdit4: TUniDBEdit;
    edFaturaSeriNo: TUniEdit;
    UniDBEdit5: TUniDBEdit;
    UniDBEdit6: TUniDBEdit;
    edEFaturaSeriNo: TUniEdit;
    UniDBEdit7: TUniDBEdit;
    UniDBEdit8: TUniDBEdit;
    edEArsivSeriNo: TUniEdit;
    saSor: TUniSweetAlert;
    UniDBComboBox1: TUniDBComboBox;
    UniDBComboBox2: TUniDBComboBox;
    procedure UniFormShow(Sender: TObject);
    procedure btnGenelClick(Sender: TObject);
    procedure btnYetkiliClick(Sender: TObject);
    procedure edEArsivSeriNoTriggerEvent(Sender: TUniFormControl;
      AButtonId: Integer);
    procedure edCariNoTriggerEvent(Sender: TUniFormControl; AButtonId: Integer);
    procedure saSorConfirm(Sender: TObject);
    procedure edStokNoTriggerEvent(Sender: TUniFormControl; AButtonId: Integer);
    procedure edFaturaSeriNoTriggerEvent(Sender: TUniFormControl;
      AButtonId: Integer);
    procedure edEFaturaSeriNoTriggerEvent(Sender: TUniFormControl;
      AButtonId: Integer);
    procedure bntKaydetClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure btnDuzenleClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmParametreler: TfrmParametreler;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, DMU, Genel, Main;

function frmParametreler: TfrmParametreler;
begin
  Result := TfrmParametreler(UniMainModule.GetFormInstance(TfrmParametreler));
end;

procedure TfrmParametreler.bntKaydetClick(Sender: TObject);
begin
//  if frmDM.qParametre.State IN [dsEdit,dsInsert] then frmDM.qParametre.Post;
//  frmDM.qParametre.Refresh;
//  UniMainModule.saKaydet.Show;
end;

procedure TfrmParametreler.btnDuzenleClick(Sender: TObject);
begin
    tabGenel.Enabled:=True;
    TabFatura.Enabled:=True;
end;

procedure TfrmParametreler.btnGenelClick(Sender: TObject);
begin
  UniPageControl1.ActivePage:=tabGenel;
end;

procedure TfrmParametreler.btnKapatClick(Sender: TObject);
begin
    MainForm.NavPage.ActivePage.Close;
end;

procedure TfrmParametreler.btnYetkiliClick(Sender: TObject);
begin
  UniPageControl1.ActivePage:=TabFatura;
end;

procedure TfrmParametreler.edCariNoTriggerEvent(Sender: TUniFormControl;
  AButtonId: Integer);
begin
  if AButtonId=0 then begin
    saSor.Tag:=1;
    saSor.Show();
  end;
end;

procedure TfrmParametreler.edEArsivSeriNoTriggerEvent(Sender: TUniFormControl;
  AButtonId: Integer);
begin
  if AButtonId=0 then begin
    saSor.Tag:=5;
    saSor.Show();
  end;
end;

procedure TfrmParametreler.edEFaturaSeriNoTriggerEvent(Sender: TUniFormControl;
  AButtonId: Integer);
begin
  if AButtonId=0 then begin
    saSor.Tag:=4;
    saSor.Show();
  end;
end;

procedure TfrmParametreler.edFaturaSeriNoTriggerEvent(Sender: TUniFormControl;
  AButtonId: Integer);
begin
  if AButtonId=0 then begin
    saSor.Tag:=3;
    saSor.Show();
  end;
end;

procedure TfrmParametreler.edStokNoTriggerEvent(Sender: TUniFormControl;
  AButtonId: Integer);
begin
  if AButtonId=0 then begin
    saSor.Tag:=2;
    saSor.Show();
  end;
end;

procedure TfrmParametreler.saSorConfirm(Sender: TObject);
begin
if saSor.Tag=1 then xUpdateTablo('Update FisNo set FisNo='''+edCariNo.Text+''' where TabloAdi=''CariKart'' ');
if saSor.Tag=2 then xUpdateTablo('Update FisNo set FisNo='''+edStokNo.Text+''' where TabloAdi=''StokKart'' ');
if saSor.Tag=3 then xUpdateTablo('Update FisNo set FisNo='''+edFaturaSeriNo.Text+''' where TabloAdi=''KFatura'' ');
if saSor.Tag=4 then xUpdateTablo('Update FisNo set FisNo='''+edEFaturaSeriNo.Text+''' where TabloAdi=''EFatura'' ');
if saSor.Tag=5 then xUpdateTablo('Update FisNo set FisNo='''+edEArsivSeriNo.Text+''' where TabloAdi=''EArsiv'' ');
end;

procedure TfrmParametreler.UniFormShow(Sender: TObject);
var
  Qry:Tuniquery;
begin
//     Qry:=Tuniquery.Create(nil);
//     Qry.Connection:=frmDM.conAsya;
//
//     xTabloAc(Qry,'Select FisNo FROM FisNo where TabloAdi=''KFatura''');
//     edFaturaSeriNo.Text:=Qry.FieldByName('FisNo').AsString;
//
//     xTabloAc(Qry,'Select FisNo FROM FisNo where TabloAdi=''EFatura''');
//     edEFaturaSeriNo.Text:=Qry.FieldByName('FisNo').AsString;
//
//     xTabloAc(Qry,'Select FisNo FROM FisNo where TabloAdi=''EArsiv''');
//     edEArsivSeriNo.Text:=Qry.FieldByName('FisNo').AsString;
//
//     xTabloAc(Qry,'Select FisNo FROM FisNo where TabloAdi=''CariKart''');
//     edCariNo.Text:=Qry.FieldByName('FisNo').AsString;
//
//     xTabloAc(Qry,'Select FisNo FROM FisNo where TabloAdi=''StokKart''');
//     edStokNo.Text:=Qry.FieldByName('FisNo').AsString;
//     Qry.Free;
//
//    tabGenel.Enabled:=False;
//    TabFatura.Enabled:=false;
end;

end.
