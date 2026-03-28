unit DovizTLCevrimU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniEdit, uniGUIBaseClasses, uniPanel,
  uniLabel, System.Math;

type
  TfrmDovizTLCevrim = class(TUniForm)
    UniPanel1: TUniPanel;
    btnAktar: TUniButton;
    lblStokKodu: TUniLabel;
    txtTLFiyat: TUniFormattedNumberEdit;
    txtDovizFiyat: TUniFormattedNumberEdit;
    txtKur: TUniFormattedNumberEdit;
    procedure btnAktarClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure txtTLFiyatKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    FisDetayID : Integer;
    StokKodu : String;
    DovizFiyat, Kur, TLFiyat :Real;
  end;

function frmDovizTLCevrim: TfrmDovizTLCevrim;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, SiparisU, SiparisDMU;

function frmDovizTLCevrim: TfrmDovizTLCevrim;
begin
  Result := TfrmDovizTLCevrim(UniMainModule.GetFormInstance(TfrmDovizTLCevrim));
end;

procedure TfrmDovizTLCevrim.txtTLFiyatKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    begin
      btnAktar.Click;
    end;
end;

procedure TfrmDovizTLCevrim.btnAktarClick(Sender: TObject);
begin

  frmDovizTLCevrim.txtDovizFiyat.Value := (frmDovizTLCevrim.txtTLFiyat.Value / frmDovizTLCevrim.txtKur.Value);

  frmSiparisDM.qFisDetay.Edit;

    if frmSiparisDM.qFisDetay.FieldByName('ParaBirimi').Value = '0' then
      begin
        frmSiparisDM.qFisDetay.FieldByName('BirimFiyat').AsFloat := txtTLFiyat.Value;
      end else
      begin
        frmSiparisDM.qFisDetay.FieldByName('BirimFiyat').AsFloat := txtDovizFiyat.Value;
      end;

  frmSiparisDM.qFisDetay.Post;
  Close;
end;

procedure TfrmDovizTLCevrim.UniFormShow(Sender: TObject);
begin
  lblStokKodu.Caption := StokKodu;
  txtDovizFiyat.Value := DovizFiyat;
  txtKur.Value := Kur;
  txtTLFiyat.Value := TLFiyat;
  txtTLFiyat.SetFocus;
  txtTLFiyat.SelectAll;

end;

end.
