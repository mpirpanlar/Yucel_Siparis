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
    btnTeklifListesi: TUniButton;
    btnCariOzet: TUniButton;
    procedure btnYeniAktiviteClick(Sender: TObject);
    procedure btnYeniGorevClick(Sender: TObject);
    procedure btnAktiviteListesiClick(Sender: TObject);
    procedure btnGorevListesiClick(Sender: TObject);
    procedure btnYeniTeklifClick(Sender: TObject);
    procedure btnTeklifListesiClick(Sender: TObject);
    procedure btnCariOzetClick(Sender: TObject);
  private
  public
  end;

function frmCrmMenu: TfrmCrmMenu;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, Genel, CrmAktiviteU, CrmGorevU,
  CrmAktiviteListeU, CrmGorevListeU, CrmTeklifU, CrmTeklifListeU, CrmCariOzetU;

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

procedure TfrmCrmMenu.btnTeklifListesiClick(Sender: TObject);
begin
  xFormShow(TfrmCrmTeklifListe, 'CrmTeklifListesi', 1, '');
end;

procedure TfrmCrmMenu.btnCariOzetClick(Sender: TObject);
begin
  xFormShow(TfrmCrmCariOzet, 'CrmCariOzet', 1, '');
end;

end.
