unit KullaniciGrupU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniBasicGrid, uniDBGrid, uniPanel, uniButton,
  uniBitBtn, uniMenuButton, uniGUIBaseClasses, Data.DB, DBAccess, Uni, MemDS,
  uniDBVerticalGrid, uniDBVerticalTreeGrid, uniDBTreeGrid, uniSweetAlert;

type
  TfrmKullaniciGrup = class(TUniForm)
    UniContainerPanel1: TUniContainerPanel;
    UniPanel2: TUniPanel;
    btnKapat: TUniButton;
    UniSimplePanel3: TUniSimplePanel;
    qKullaniciGrup: TUniQuery;
    dsKullaniciGrup: TUniDataSource;
    qYetki: TUniQuery;
    dsYetki: TUniDataSource;
    UniDBGrid1: TUniDBGrid;
    btnYeni: TUniButton;
    bntKaydet: TUniButton;
    btnDuzenle: TUniButton;
    btnSil: TUniButton;
    saSil: TUniSweetAlert;
    qYetkiFormName: TStringField;
    qYetkiKullaniciGrupID: TIntegerField;
    qYetkiGor: TByteField;
    qYetkiSil: TByteField;
    qYetkiDegistir: TByteField;
    qYetkiKaydet: TByteField;
    qYetkiFormCaption: TWideStringField;
    UniDBGrid3: TUniDBGrid;
    procedure UniFormShow(Sender: TObject);
    procedure UniDBGrid1CellClick(Column: TUniDBGridColumn);
    procedure bntKaydetClick(Sender: TObject);
    procedure btnDuzenleClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure saSilConfirm(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure btnYeniClick(Sender: TObject);
  private

    { Private declarations }
  public
    { Public declarations }
  end;

function frmKullaniciGrup: TfrmKullaniciGrup;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, StrUtils, uniStrUtils, Genel, Main, DMU;

function frmKullaniciGrup: TfrmKullaniciGrup;
begin
  Result := TfrmKullaniciGrup(UniMainModule.GetFormInstance(TfrmKullaniciGrup));
end;

procedure TfrmKullaniciGrup.bntKaydetClick(Sender: TObject);
begin
  if qKullaniciGrup.State IN [dsEdit,dsInsert] then qKullaniciGrup.Post;
  if qYetki.State IN [dsEdit,dsInsert] then qYetki.Post;
  UniMainModule.saKaydet.Show;

end;

procedure TfrmKullaniciGrup.btnDuzenleClick(Sender: TObject);
begin
  UniDBGrid1.Options := UniDBGrid1.Options + [dgEditing];
  UniDBGrid3.Options := UniDBGrid3.Options + [dgEditing];

end;

procedure TfrmKullaniciGrup.btnSilClick(Sender: TObject);
begin
  saSil.Show();
end;

procedure TfrmKullaniciGrup.btnYeniClick(Sender: TObject);
begin
  UniDBGrid1.Options := UniDBGrid1.Options + [dgEditing];
  qKullaniciGrup.Append;

  UniDBGrid3.Options := UniDBGrid3.Options + [dgEditing];
  qYetki.Append;
end;

procedure TfrmKullaniciGrup.saSilConfirm(Sender: TObject);
begin
    qKullaniciGrup.Delete;
    UniMainModule.saHata.Show('Silme iþlemi tamamlandý.');
end;

procedure TfrmKullaniciGrup.btnKapatClick(Sender: TObject);
begin
    MainForm.NavPage.ActivePage.Close;
end;

procedure TfrmKullaniciGrup.UniDBGrid1CellClick(Column: TUniDBGridColumn);
begin
  qYetki.Close;
  qYetki.ParamByName('KullaniciGrupID').AsString:=qKullaniciGrup.FieldByName('KullaniciGrupID').AsString;
  qYetki.Open;
end;

procedure TfrmKullaniciGrup.UniFormShow(Sender: TObject);
begin
  qKullaniciGrup.Open;
end;

end.
