unit MainModule;

interface

uses
  uniGUIMainModule, SysUtils, Classes, System.Contnrs, uniGUIBaseClasses, uniGUIClasses,
  uniGUIForm, uniSweetAlert, uniImageList;

type
  { Potansiyel listesi (NavPage gomulu ornek) icin tekli secim. }
  TCrmPotListeSecildiEvent = procedure(Sender: TObject; APotansiyelId: Int64) of object;
  TCrmPotListeSecildiCokluEvent = procedure(Sender: TObject; APotIds: TStringList) of object;
  TCrmCariSecildiEvent = procedure(Sender: TObject; const ACariKod: string) of object;
  TCrmCariSecildiCokluEvent = procedure(Sender: TObject; ACariKodlar: TStringList) of object;
  TCrmRotaBolgeSecildiEvent = procedure(Sender: TObject; AListe: TObjectList) of object;

  TUniMainModule = class(TUniGUIMainModule)
    saYetki: TUniSweetAlert;
    saHata: TUniSweetAlert;
    Resim_24: TUniNativeImageList;
    saKaydet: TUniSweetAlert;
    saHata_1: TUniSweetAlert;
    saFiyat: TUniSweetAlert;
    procedure UniGUIMainModuleSessionTimeout(ASession: TObject;
      var ExtendTimeOut: Integer);
  private
    FCrmPotListeSecimCallback: TCrmPotListeSecildiEvent;
    FCrmPotListeSecimKaynakListe: TUniForm;
    FCrmRotaCariSecildi: TCrmCariSecildiEvent;
    FCrmRotaCariSecildiCoklu: TCrmCariSecildiCokluEvent;
    FCrmRotaPotSecildi: TCrmPotListeSecildiEvent;
    FCrmRotaPotSecildiCoklu: TCrmPotListeSecildiCokluEvent;
    FCrmRotaBolgeSecildi: TCrmRotaBolgeSecildiEvent;
  public
    { Potansiyel listesi acilmadan once atanir; secimden sonra temizlenir. }
    property CrmPotListeSecimCallback: TCrmPotListeSecildiEvent
      read FCrmPotListeSecimCallback write FCrmPotListeSecimCallback;
    { Callback sadece bu form orneginde (modal liste) Satir sec / cift tik ile calisir. }
    property CrmPotListeSecimKaynakListe: TUniForm
      read FCrmPotListeSecimKaynakListe write FCrmPotListeSecimKaynakListe;
    { NavPage'deki rota sekmesi (Create) icin cari/pot secim koprusu; handler'lar burada tutulur. }
    procedure CrmRotaCariSecimHazirla(const AOnTek: TCrmCariSecildiEvent;
      const AOnCoklu: TCrmCariSecildiCokluEvent);
    procedure CrmRotaPotSecimHazirla(const AOnTek: TCrmPotListeSecildiEvent;
      const AOnCoklu: TCrmPotListeSecildiCokluEvent);
    procedure CrmRotaBolgeSecimHazirla(const AOnSecim: TCrmRotaBolgeSecildiEvent);
    procedure CrmRotaDurakSecimBitir;
    function CrmRotaDurakSecimAktif: Boolean;
    procedure CrmRotaBridgeCariSecildi(Sender: TObject; const ACariKod: string);
    procedure CrmRotaBridgeCariSecildiCoklu(Sender: TObject; ACariKodlar: TStringList);
    procedure CrmRotaBridgePotSecildi(Sender: TObject; APotId: Int64);
    procedure CrmRotaBridgePotSecildiCoklu(Sender: TObject; APotIds: TStringList);
    procedure CrmRotaBridgeBolgeSecildi(Sender: TObject; AListe: TObjectList);
  end;

//  var
//  xKullaniciGrupID, xSubeKodu, xKullaniciDepo, xKullaniciAdmin : Integer;
//  xParaBirimi, xNetsisProjeUygulamasi, xNetsisSirketKodu, xKullaniciAdi, xNetsisKullanici, xNetsisSifre, xNetsisPlasiyer : String;

function UniMainModule: TUniMainModule;

implementation

{$R *.dfm}

uses
  UniGUIVars, ServerModule, uniGUIApplication, SiparisU, SiparisDMU;

function UniMainModule: TUniMainModule;
begin
  Result := TUniMainModule(UniApplication.UniMainModule)
end;

procedure TUniMainModule.UniGUIMainModuleSessionTimeout(ASession: TObject;
  var ExtendTimeOut: Integer);
begin
  ExtendTimeOut := 1800000;
end;

procedure TUniMainModule.CrmRotaCariSecimHazirla(const AOnTek: TCrmCariSecildiEvent;
  const AOnCoklu: TCrmCariSecildiCokluEvent);
begin
  FCrmRotaCariSecildi := AOnTek;
  FCrmRotaCariSecildiCoklu := AOnCoklu;
end;

procedure TUniMainModule.CrmRotaPotSecimHazirla(const AOnTek: TCrmPotListeSecildiEvent;
  const AOnCoklu: TCrmPotListeSecildiCokluEvent);
begin
  FCrmRotaPotSecildi := AOnTek;
  FCrmRotaPotSecildiCoklu := AOnCoklu;
end;

procedure TUniMainModule.CrmRotaBolgeSecimHazirla(const AOnSecim: TCrmRotaBolgeSecildiEvent);
begin
  FCrmRotaBolgeSecildi := AOnSecim;
end;

procedure TUniMainModule.CrmRotaDurakSecimBitir;
begin
  FCrmRotaCariSecildi := nil;
  FCrmRotaCariSecildiCoklu := nil;
  FCrmRotaPotSecildi := nil;
  FCrmRotaPotSecildiCoklu := nil;
  FCrmRotaBolgeSecildi := nil;
end;

function TUniMainModule.CrmRotaDurakSecimAktif: Boolean;
begin
  Result :=
    Assigned(FCrmRotaCariSecildi) or Assigned(FCrmRotaCariSecildiCoklu) or
    Assigned(FCrmRotaPotSecildi) or Assigned(FCrmRotaPotSecildiCoklu) or
    Assigned(FCrmRotaBolgeSecildi);
end;

procedure TUniMainModule.CrmRotaBridgeCariSecildi(Sender: TObject; const ACariKod: string);
begin
  if Assigned(FCrmRotaCariSecildi) then
    FCrmRotaCariSecildi(Sender, ACariKod);
  CrmRotaDurakSecimBitir;
end;

procedure TUniMainModule.CrmRotaBridgeCariSecildiCoklu(Sender: TObject;
  ACariKodlar: TStringList);
begin
  if Assigned(FCrmRotaCariSecildiCoklu) then
    FCrmRotaCariSecildiCoklu(Sender, ACariKodlar);
  CrmRotaDurakSecimBitir;
end;

procedure TUniMainModule.CrmRotaBridgePotSecildi(Sender: TObject; APotId: Int64);
begin
  if Assigned(FCrmRotaPotSecildi) then
    FCrmRotaPotSecildi(Sender, APotId);
  CrmRotaDurakSecimBitir;
end;

procedure TUniMainModule.CrmRotaBridgePotSecildiCoklu(Sender: TObject; APotIds: TStringList);
begin
  if Assigned(FCrmRotaPotSecildiCoklu) then
    FCrmRotaPotSecildiCoklu(Sender, APotIds);
  CrmRotaDurakSecimBitir;
end;

procedure TUniMainModule.CrmRotaBridgeBolgeSecildi(Sender: TObject; AListe: TObjectList);
begin
  if Assigned(FCrmRotaBolgeSecildi) then
    FCrmRotaBolgeSecildi(Sender, AListe);
  FCrmRotaBolgeSecildi := nil;
end;

initialization
  RegisterMainModuleClass(TUniMainModule);
end.
