unit DMU;

interface

uses
  SysUtils, Classes, Data.DB, DBAccess, Uni, UniProvider, SQLServerUniProvider,
  MemDS;

type
  TfrmDM = class(TDataModule)
    upSQLServer: TSQLServerUniProvider;
    conNetsis: TUniConnection;
    conAsya: TUniConnection;
    qParametre: TUniQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmDM: TfrmDM;

implementation

{$R *.dfm}

uses
  UniGUIVars, uniGUIMainModule, MainModule;

function frmDM: TfrmDM;
begin
  Result := TfrmDM(UniMainModule.GetModuleInstance(TfrmDM));
end;

initialization
  RegisterModuleClass(TfrmDM);

end.
