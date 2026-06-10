unit TmpU;

interface

uses
  SysUtils, Classes;

type
  TTmp = class(TDataModule)
  private
    { Private declarations }
    yKullaniciID:integer;
    yKullaniciGrupID, ySubeKodu, yKullaniciDepo, yKullaniciAdmin : Integer;
    yParaBirimi, yNetsisProjeUygulamasi, yNetsisSirketKodu, yKullaniciAdi, yNetsisKullanici, yNetsisSifre, yNetsisPlasiyer : String;
    yDovizTakip : SmallInt;
    yCrmYeniAktiviteTeklifId: Int64;
    yCrmYeniAktivitePotId: Int64;
    yCrmYeniGorevTeklifId: Int64;
    yCrmYeniGorevPotId: Int64;

  public
    { Public declarations }

  published
    property xKullaniciID:integer read yKullaniciID write yKullaniciID;
    property xKullaniciGrupID : Integer read yKullaniciGrupID write yKullaniciGrupID;
    property xSubeKodu : Integer read ySubeKodu write ySubeKodu;
    property xKullaniciDepo : Integer read yKullaniciDepo write yKullaniciDepo;
    property xKullaniciAdmin : Integer read yKullaniciAdmin write yKullaniciAdmin;
    property xParaBirimi : String read yParaBirimi write yParaBirimi;
    property xNetsisProjeUygulamasi : String  read yNetsisProjeUygulamasi write yNetsisProjeUygulamasi;
    property xNetsisSirketKodu : String read yNetsisSirketKodu write yNetsisSirketKodu;
    property xKullaniciAdi : String read yKullaniciAdi write yKullaniciAdi;
    property xNetsisKullanici : String read yNetsisKullanici write yNetsisKullanici;
    property xNetsisSifre : String read yNetsisSifre write yNetsisSifre;
    property xNetsisPlasiyer : String read yNetsisPlasiyer write yNetsisPlasiyer;
    property xDovizTakip : SmallInt read yDovizTakip write yDovizTakip;
    property xCrmYeniAktiviteTeklifId: Int64 read yCrmYeniAktiviteTeklifId write yCrmYeniAktiviteTeklifId;
    property xCrmYeniAktivitePotId: Int64 read yCrmYeniAktivitePotId write yCrmYeniAktivitePotId;
    property xCrmYeniGorevTeklifId: Int64 read yCrmYeniGorevTeklifId write yCrmYeniGorevTeklifId;
    property xCrmYeniGorevPotId: Int64 read yCrmYeniGorevPotId write yCrmYeniGorevPotId;

  end;

function Tmp: TTmp;

implementation

{$R *.dfm}

uses
  UniGUIVars, uniGUIMainModule, MainModule;

function Tmp: TTmp;
begin
  Result := TTmp(UniMainModule.GetModuleInstance(TTmp));
end;

initialization
  RegisterModuleClass(TTmp);

end.
