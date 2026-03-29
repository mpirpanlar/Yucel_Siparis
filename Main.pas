unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, uniButton,
  System.Actions, Vcl.ActnList, uniStatusBar, dxGDIPlusClasses, uniImage,
  uniLabel, uniPanel, uniBitBtn, uniPageControl, Data.DB, MemDS, DBAccess, Uni,
  Vcl.Imaging.pngimage;

type
  TMainForm = class(TUniForm)
    NavPage: TUniPageControl;
    tabMenu: TUniTabSheet;
    UniSimplePanel2: TUniSimplePanel;
    UniSimplePanel4: TUniSimplePanel;
    btnSiparis: TUniBitBtn;
    UniSimplePanelCRM: TUniSimplePanel;
    btnCRM: TUniBitBtn;
    pnlMenu: TUniSimplePanel;
    UniPanel1: TUniPanel;
    lbFirma: TUniLabel;
    UniImage1: TUniImage;
    UniStatusBar1: TUniStatusBar;
    alButonlar: TActionList;
    acCariKart: TAction;
    acStokKart: TAction;
    acCariGrup: TAction;
    acStokGrup: TAction;
    acStokAltGrup: TAction;
    acStokMarka: TAction;
    acSatisFaturasi: TAction;
    acCariListesi: TAction;
    acFaturaListesi: TAction;
    acAlisFaturasi: TAction;
    acAlisFaturasiIade: TAction;
    acSatisFaturasiIade: TAction;
    acNakitTahsilat: TAction;
    acGelenHavale: TAction;
    acNakitOdeme: TAction;
    acGidenHavale: TAction;
    acBorcDekont: TAction;
    acAlacakDekont: TAction;
    acCariVirman: TAction;
    acStokListesi: TAction;
    acKasaKart: TAction;
    acBankaKart: TAction;
    acKasaBankaListesi: TAction;
    acKasaBankaVirman: TAction;
    acHizmetKarti: TAction;
    acGider: TAction;
    acGiderHareketleri: TAction;
    acGiderKarti: TAction;
    acGiderListesi: TAction;
    acGelir: TAction;
    acStokGiris: TAction;
    acStokCikis: TAction;
    acHizmetListesi: TAction;
    acTumStokHareketleri: TAction;
    acEFaturaGonder: TAction;
    acEFaturaListesi: TAction;
    acStokBirim: TAction;
    acKasaBankaHareket: TAction;
    acStokModelKart: TAction;
    acStokRenkKart: TAction;
    acStokAstarKart: TAction;
    acStokYuzeyKart: TAction;
    acStokKenarbandKart: TAction;
    acKasaGiris: TAction;
    acKasaCikis: TAction;
    acStokHareket: TAction;
    acSatisSiparisLake: TAction;
    UniSimplePanel1: TUniSimplePanel;
    UniBitBtn10: TUniBitBtn;
    UniQuery1: TUniQuery;
    lblKullanici: TUniLabel;
    procedure btnSiparisClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure UniBitBtn10Click(Sender: TObject);
    procedure btnCRMClick(Sender: TObject);
  private
    { Private declarations }
  public
       Procedure PanelMenu;
       procedure CheckTab(Sender: TObject; var AllowClose: Boolean);
       procedure SiparisFazlaTeslimatOran;
    { Public declarations }
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, SiparisU, SiparisMenuU, SiparisDMU,
  DMU, Genel, ParametreMenuU, TmpU, CrmMenuU, CrmSchemaU;

procedure TMainForm.SiparisFazlaTeslimatOran;
var
  q: TUniQuery;
begin
  q := TUniQuery.Create(self);
  q.Connection := frmDM.conNetsis;
  q.Close;
  q.SQL.Clear;
  q.SQL.Add('SELECT FAZTESORAN  FROM TBLSFATUPRM');
  q.Open;
  xSiparisFazlaTeslimatOrani := q.FieldByName('FAZTESORAN').AsFloat;
  q.Close;
  FreeAndNil(q);
end;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

procedure TMainForm.btnSiparisClick(Sender: TObject);
begin
  PanelMenu;
  frmSiparisMenu.Parent := pnlMenu;
  frmSiparisMenu.Show;
end;

procedure TMainForm.CheckTab(Sender: TObject; var AllowClose: Boolean);
begin//check if it's last page was closed
  if NavPage.PageCount = 1 then
  begin
    NavPage.Visible := False;
  end;
end;

Procedure TMainForm.PanelMenu;
var
  PanelMenu :TUniPanel;
begin
  pnlMenu.Free;
  PanelMenu := TUniPanel.Create(MainForm);
  PanelMenu.Align := alClient;
  PanelMenu.Parent := tabMenu;
  PanelMenu.AlignmentControl := uniAlignmentClient;
  PanelMenu.Layout := 'fit';
//  PanelMenu.LayoutConfig.Margin:='1 1 1 1';
  PanelMenu.BorderStyle:=ubsNone;
  PanelMenu.Name:='pnlMenu';
  PanelMenu.AlignWithMargins:=true;
end;

procedure TMainForm.UniBitBtn10Click(Sender: TObject);
begin
  PanelMenu;
  frmParametreMenu.Parent := pnlMenu;
  frmParametreMenu.Show;

end;

procedure TMainForm.btnCRMClick(Sender: TObject);
begin
  PanelMenu;
  frmCrmMenu.Parent := pnlMenu;
  frmCrmMenu.Show;
end;

procedure TMainForm.UniFormShow(Sender: TObject);
begin
  try
    CrmEnsureDatabase(frmDM.conAsya);
  except
    on E: Exception do
      UniMainModule.saHata.Show('CRM veritabani semasi: ' + E.Message);
  end;
  SiparisFazlaTeslimatOran;
  lblKullanici.Caption := Tmp.xKullaniciAdi;

end;

initialization
  RegisterAppFormClass(TMainForm);

end.
