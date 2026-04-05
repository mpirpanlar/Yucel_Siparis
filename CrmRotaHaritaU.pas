unit CrmRotaHaritaU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniURLFrame, uniPanel, uniButton;

type
  TfrmCrmRotaHarita = class(TUniForm)
    rootPanel: TUniPanel;
    urlFrame: TUniURLFrame;
    panTop: TUniPanel;
    btnKapat: TUniButton;
    procedure UniFormShow(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
  private
  public
    HaritaUrl: string;
  end;

function frmCrmRotaHarita: TfrmCrmRotaHarita;

implementation

{$R *.dfm}

uses
  uniGUIApplication, MainModule, Main;

function frmCrmRotaHarita: TfrmCrmRotaHarita;
begin
  Result := TfrmCrmRotaHarita(UniMainModule.GetFormInstance(TfrmCrmRotaHarita));
end;

procedure TfrmCrmRotaHarita.UniFormShow(Sender: TObject);
begin
  if Trim(HaritaUrl) <> '' then
    urlFrame.URL := HaritaUrl;
end;

procedure TfrmCrmRotaHarita.btnKapatClick(Sender: TObject);
begin
  HaritaUrl := '';
  Close;
end;

end.
