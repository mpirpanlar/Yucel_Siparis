unit CrmMenuU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniPanel, uniGUIBaseClasses;

type
  TfrmCrmMenu = class(TUniForm)
    UniContainerPanel1: TUniContainerPanel;
    UniSimplePanel1: TUniSimplePanel;
    UniPanel1: TUniPanel;
    btnYeniAktivite: TUniButton;
    btnYeniGorev: TUniButton;
    UniSimplePanel2: TUniSimplePanel;
    UniPanel2: TUniPanel;
    btnAktiviteListesi: TUniButton;
    btnGorevListesi: TUniButton;
    btnYeniTeklif: TUniButton;
    btnYeniPotansiyel: TUniButton;
    btnYeniRotaPlan: TUniButton;
    btnTeklifListesi: TUniButton;
    btnPotansiyelListesi: TUniButton;
    btnTanimliRota: TUniButton;
    btnCariOzet: TUniButton;
    procedure btnYeniAktiviteClick(Sender: TObject);
    procedure btnYeniGorevClick(Sender: TObject);
    procedure btnAktiviteListesiClick(Sender: TObject);
    procedure btnGorevListesiClick(Sender: TObject);
    procedure btnYeniTeklifClick(Sender: TObject);
    procedure btnYeniPotansiyelClick(Sender: TObject);
    procedure btnTeklifListesiClick(Sender: TObject);
    procedure btnPotansiyelListesiClick(Sender: TObject);
    procedure btnTanimliRotaClick(Sender: TObject);
    procedure btnYeniRotaPlanClick(Sender: TObject);
    procedure btnCariOzetClick(Sender: TObject);
  private
  public
  end;

function frmCrmMenu: TfrmCrmMenu;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, Genel, CrmAktiviteU, CrmGorevU,
  CrmAktiviteListeU, CrmGorevListeU, CrmTeklifU, CrmTeklifListeU, CrmCariOzetU,
  CrmPotansiyelU, CrmPotansiyelListeU, CrmRotaListeU, CrmRotaU;

function frmCrmMenu: TfrmCrmMenu;
begin
  Result := TfrmCrmMenu(UniMainModule.GetFormInstance(TfrmCrmMenu));
end;

procedure TfrmCrmMenu.btnYeniAktiviteClick(Sender: TObject);
begin
  xFormShow(TfrmCrmAktivite, 'CrmYeniAktivite', 1, '');
end;

procedure TfrmCrmMenu.btnYeniGorevClick(Sender: TObject);
begin
  xFormShow(TfrmCrmGorev, 'CrmYeniGorev', 1, '');
end;

procedure TfrmCrmMenu.btnAktiviteListesiClick(Sender: TObject);
begin
  xFormShow(TfrmCrmAktiviteListe, 'CrmAktiviteListesi', 1, '');
end;

procedure TfrmCrmMenu.btnGorevListesiClick(Sender: TObject);
begin
  xFormShow(TfrmCrmGorevListe, 'CrmGorevListesi', 1, '');
end;

procedure TfrmCrmMenu.btnYeniTeklifClick(Sender: TObject);
begin
  xFormShow(TfrmCrmTeklif, 'CrmYeniTeklif', 1, '');
end;

procedure TfrmCrmMenu.btnYeniPotansiyelClick(Sender: TObject);
begin
  xFormShow(TfrmCrmPotansiyel, 'CrmYeniPotansiyel', 1, '0');
end;

procedure TfrmCrmMenu.btnTeklifListesiClick(Sender: TObject);
begin
  xFormShow(TfrmCrmTeklifListe, 'CrmTeklifListesi', 1, '');
end;

procedure TfrmCrmMenu.btnPotansiyelListesiClick(Sender: TObject);
begin
  xFormShow(TfrmCrmPotansiyelListe, 'CrmPotansiyelListesi', 1, '');
end;

procedure TfrmCrmMenu.btnTanimliRotaClick(Sender: TObject);
begin
  xFormShow(TfrmCrmRotaListe, 'CrmRotaListesi', 1, '');
end;

procedure TfrmCrmMenu.btnYeniRotaPlanClick(Sender: TObject);
begin
  xFormShow(TfrmCrmRotaPlan, 'CrmRotaPlan', 1, '0');
end;

procedure TfrmCrmMenu.btnCariOzetClick(Sender: TObject);
begin
  xFormShow(TfrmCrmCariOzet, 'CrmCariOzet', 1, '');
end;

end.
