unit PDFGosterU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniURLFrame, uniButton, uniPanel;

type
  TfrmPDFGoster = class(TUniForm)
    UniURLFrame1: TUniURLFrame;
    UniPanel2: TUniPanel;
    UniButton2: TUniButton;
    procedure UniButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmPDFGoster: TfrmPDFGoster;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, Main;

function frmPDFGoster: TfrmPDFGoster;
begin
  Result := TfrmPDFGoster(UniMainModule.GetFormInstance(TfrmPDFGoster));
end;

procedure TfrmPDFGoster.UniButton2Click(Sender: TObject);
begin
//    MainForm.NavPage.ActivePage.Close;
    frmPDFGoster.Close;
end;

end.
