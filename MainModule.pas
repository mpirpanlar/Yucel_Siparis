unit MainModule;

interface

uses
  uniGUIMainModule, SysUtils, Classes, uniGUIBaseClasses, uniGUIClasses,
  uniGUIForm, uniSweetAlert, uniImageList;

type
  { Rota plan: potansiyel listesinden secim; menude Create edilen form ile GetFormInstance ayni olmayabilir. }
  TCrmPotListeSecildiEvent = procedure(Sender: TObject; APotansiyelId: Int64) of object;

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
  public
    { Potansiyel listesi acilmadan once atanir; secimden sonra temizlenir. }
    property CrmPotListeSecimCallback: TCrmPotListeSecildiEvent
      read FCrmPotListeSecimCallback write FCrmPotListeSecimCallback;
    { Callback sadece bu form orneginde (modal liste) Satir sec / cift tik ile calisir. }
    property CrmPotListeSecimKaynakListe: TUniForm
      read FCrmPotListeSecimKaynakListe write FCrmPotListeSecimKaynakListe;
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

initialization
  RegisterMainModuleClass(TUniMainModule);
end.
