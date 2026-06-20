{$define UNIGUI_VCL} // Comment out this line to turn this project into an ISAPI module

{$ifndef UNIGUI_VCL}
library
{$else}
program
{$endif}
  Siparis;

uses
  uniGUIISAPI,
  Forms,
  ServerModule in 'ServerModule.pas' {UniServerModule: TUniGUIServerModule},
  MainModule in 'MainModule.pas' {UniMainModule: TUniGUIMainModule},
  Main in 'Main.pas' {MainForm: TUniForm},
  SiparisU in 'SiparisU.pas' {frmSiparis: TUniForm},
  SiparisMenuU in 'SiparisMenuU.pas' {frmSiparisMenu: TUniForm},
  Genel in 'Genel.pas',
  StokBulU in 'StokBulU.pas' {frmStokBul: TUniForm},
  DMU in 'DMU.pas' {frmDM: TDataModule},
  SiparisDMU in 'SiparisDMU.pas' {frmSiparisDM: TDataModule},
  NetsisEntegrasyon in 'NetsisEntegrasyon.pas',
  DovizTLCevrimU in 'DovizTLCevrimU.pas' {frmDovizTLCevrim: TUniForm},
  SiparisListesiU in 'SiparisListesiU.pas' {frmSiparisListesi: TUniForm},
  PDFGosterU in 'PDFGosterU.pas' {frmPDFGoster: TUniForm},
  StokListesiU in 'StokListesiU.pas' {frmStokListesi: TUniForm},
  YuklemeTalebiU in 'YuklemeTalebiU.pas' {frmYuklemeTalebi: TUniForm},
  CariRisk2U in 'CariRisk2U.pas' {frmCariRisk2: TUniForm},
  LoginU in 'LoginU.pas' {frmLogin: TUniLoginForm},
  KullanicilarU in 'KullanicilarU.pas' {frmKullanicilar: TUniForm},
  ParametreMenuU in 'ParametreMenuU.pas' {frmParametreMenu: TUniForm},
  YuklemeTalebi2U in 'YuklemeTalebi2U.pas' {frmYuklemeTalebi2: TUniForm},
  TmpU in 'TmpU.pas' {Tmp: TDataModule},
  StokCariDetayU in 'StokCariDetayU.pas' {frmStokCariDetay: TUniForm},
  CariDetayU in 'CariDetayU.pas' {frmCariDetay: TUniForm},
  SiparisSatirGuncelleU in 'SiparisSatirGuncelleU.pas' {frmSiparisSatirGuncelle: TUniForm},
  CariRiskU in 'CariRiskU.pas' {frmCariRisk: TUniForm},
  MaliyetTriggerGuncelleU in 'MaliyetTriggerGuncelleU.pas' {frmMaliyetTriggerGuncelle: TUniForm},
  CariListesiU in 'CariListesiU.pas' {frmCariListesi: TUniForm},
  CrmSchemaU in 'CrmSchemaU.pas',
  CrmMapsConfigU in 'CrmMapsConfigU.pas',
  CrmRotaGeoU in 'CrmRotaGeoU.pas',
  CrmRotaGorevU in 'CrmRotaGorevU.pas',
  CrmRotaMesafeU in 'CrmRotaMesafeU.pas',
  CrmHaritaSecU in 'CrmHaritaSecU.pas' {frmCrmHaritaSec: TUniForm},
  CrmRotaHaritaU in 'CrmRotaHaritaU.pas' {frmCrmRotaHarita: TUniForm},
  CrmRotaU in 'CrmRotaU.pas' {frmCrmRotaPlan: TUniForm},
  CrmRotaDurakSecU in 'CrmRotaDurakSecU.pas' {frmCrmRotaDurakSec: TUniForm},
  CrmRotaListeU in 'CrmRotaListeU.pas' {frmCrmRotaListe: TUniForm},
  CrmMenuU in 'CrmMenuU.pas' {frmCrmMenu: TUniForm},
  CrmAktiviteU in 'CrmAktiviteU.pas' {frmCrmAktivite: TUniForm},
  CrmGorevU in 'CrmGorevU.pas' {frmCrmGorev: TUniForm},
  CrmCariSecU in 'CrmCariSecU.pas' {frmCrmCariSec: TUniForm},
  CrmSiparisSecU in 'CrmSiparisSecU.pas' {frmCrmSiparisSec: TUniForm},
  CrmTeklifBaslikSecU in 'CrmTeklifBaslikSecU.pas' {frmCrmTeklifBaslikSec: TUniForm},
  CrmBaglantiDurumU in 'CrmBaglantiDurumU.pas',
  CrmParamBaglantiDurumU in 'CrmParamBaglantiDurumU.pas' {frmCrmParamBaglantiDurum: TUniForm},
  CrmStokSecU in 'CrmStokSecU.pas' {frmCrmStokSec: TUniForm},
  CrmAktiviteListeU in 'CrmAktiviteListeU.pas' {frmCrmAktiviteListe: TUniForm},
  CrmGorevListeU in 'CrmGorevListeU.pas' {frmCrmGorevListe: TUniForm},
  CrmParamAktiviteTipU in 'CrmParamAktiviteTipU.pas' {frmCrmParamAktiviteTip: TUniForm},
  CrmParamAktiviteDurumU in 'CrmParamAktiviteDurumU.pas' {frmCrmParamAktiviteDurum: TUniForm},
  CrmParamTeklifDurumU in 'CrmParamTeklifDurumU.pas' {frmCrmParamTeklifDurum: TUniForm},
  CrmTeklifU in 'CrmTeklifU.pas' {frmCrmTeklif: TUniForm},
  CrmTeklifListeU in 'CrmTeklifListeU.pas' {frmCrmTeklifListe: TUniForm},
  CrmCariOzetU in 'CrmCariOzetU.pas' {frmCrmCariOzet: TUniForm},
  CrmParamPotansiyelDurumU in 'CrmParamPotansiyelDurumU.pas' {frmCrmParamPotansiyelDurum: TUniForm},
  CrmPotansiyelU in 'CrmPotansiyelU.pas' {frmCrmPotansiyel: TUniForm},
  CrmPotansiyelListeU in 'CrmPotansiyelListeU.pas' {frmCrmPotansiyelListe: TUniForm},
  CrmCariGpsListeU in 'CrmCariGpsListeU.pas' {frmCrmCariGpsListe: TUniForm},
  CrmCariGpsU in 'CrmCariGpsU.pas' {frmCrmCariGps: TUniForm},
  CrmSoruSetiU in 'CrmSoruSetiU.pas' {frmCrmSoruSeti: TUniForm},
  CrmKontrolRaporU in 'CrmKontrolRaporU.pas' {frmCrmKontrolRapor: TUniForm},
  CrmTakvimU in 'CrmTakvimU.pas' {frmCrmTakvim: TUniForm},
  CrmAktiviteLogU in 'CrmAktiviteLogU.pas',
  CrmAktiviteKontrolU in 'CrmAktiviteKontrolU.pas',
  CrmAktiviteRaporU in 'CrmAktiviteRaporU.pas' {frmCrmAktiviteRapor: TUniForm},
  CrmAktiviteTarihceU in 'CrmAktiviteTarihceU.pas' {frmCrmAktiviteTarihce: TUniForm},
  CrmRotaKmRaporU in 'CrmRotaKmRaporU.pas' {frmCrmRotaKmRapor: TUniForm},
  CrmPotSecU in 'CrmPotSecU.pas' {frmCrmPotSec: TUniForm};

{$R *.res}

{$ifndef UNIGUI_VCL}
exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;
{$endif}

begin
{$ifdef UNIGUI_VCL}
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  TUniServerModule.Create(Application);
  Application.Run;
{$endif}
end.
