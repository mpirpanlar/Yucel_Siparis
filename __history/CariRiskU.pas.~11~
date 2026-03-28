unit CariRiskU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniButton, uniBasicGrid,
  uniDBGrid, uniMultiItem, uniComboBox, uniEdit, uniDateTimePicker, uniPanel,
  uniBitBtn, uniMenuButton, uniSweetAlert, Data.DB, MemDS, DBAccess, Uni,
  Vcl.Menus, uniMainMenu, uniScreenMask, uniGridExporters;

type
  TfrmCariRisk = class(TUniForm)
    popYazdir: TUniPopupMenu;
    btnHtml: TUniMenuItem;
    btnXls: TUniMenuItem;
    btnCsv: TUniMenuItem;
    qCariListesi: TUniQuery;
    qCariListesiSUBE_KODU: TSmallintField;
    qCariListesiISLETME_KODU: TSmallintField;
    qCariListesiCARI_KOD: TStringField;
    qCariListesiCARI_TEL: TStringField;
    qCariListesiCARI_IL: TStringField;
    qCariListesiULKE_KODU: TStringField;
    qCariListesiCARI_ISIM: TStringField;
    qCariListesiCARI_TIP: TStringField;
    qCariListesiGRUP_KODU: TStringField;
    qCariListesiRAPOR_KODU1: TStringField;
    qCariListesiRAPOR_KODU2: TStringField;
    qCariListesiRAPOR_KODU3: TStringField;
    qCariListesiRAPOR_KODU4: TStringField;
    qCariListesiRAPOR_KODU5: TStringField;
    qCariListesiCARI_ADRES: TStringField;
    qCariListesiCARI_ILCE: TStringField;
    qCariListesiVERGI_DAIRESI: TStringField;
    qCariListesiVERGI_NUMARASI: TStringField;
    qCariListesiFAX: TStringField;
    qCariListesiPOSTAKODU: TStringField;
    qCariListesiDETAY_KODU: TSmallintField;
    qCariListesiNAKLIYE_KATSAYISI: TFloatField;
    qCariListesiRISK_SINIRI: TFloatField;
    qCariListesiTEMINATI: TFloatField;
    qCariListesiCARISK: TFloatField;
    qCariListesiCCRISK: TFloatField;
    qCariListesiSARISK: TFloatField;
    qCariListesiSCRISK: TFloatField;
    qCariListesiCM_BORCT: TFloatField;
    qCariListesiCM_ALACT: TFloatField;
    qCariListesiCM_RAP_TARIH: TDateTimeField;
    qCariListesiKOSULKODU: TStringField;
    qCariListesiISKONTO_ORANI: TFloatField;
    qCariListesiVADE_GUNU: TSmallintField;
    qCariListesiLISTE_FIATI: TByteField;
    qCariListesiACIK1: TStringField;
    qCariListesiACIK2: TStringField;
    qCariListesiACIK3: TStringField;
    qCariListesiM_KOD: TStringField;
    qCariListesiDOVIZ_TIPI: TByteField;
    qCariListesiDOVIZ_TURU: TByteField;
    qCariListesiHESAPTUTMASEKLI: TStringField;
    qCariListesiDOVIZLIMI: TStringField;
    qCariListesiUPDATE_KODU: TStringField;
    qCariListesiPLASIYER_KODU: TStringField;
    qCariListesiLOKALDEPO: TSmallintField;
    qCariListesiEMAIL: TStringField;
    qCariListesiWEB: TStringField;
    qCariListesiKURFARKIBORC: TStringField;
    qCariListesiKURFARKIALAC: TStringField;
    qCariListesiS_YEDEK1: TStringField;
    qCariListesiS_YEDEK2: TStringField;
    qCariListesiF_YEDEK1: TFloatField;
    qCariListesiF_YEDEK2: TFloatField;
    qCariListesiC_YEDEK1: TStringField;
    qCariListesiC_YEDEK2: TStringField;
    qCariListesiB_YEDEK1: TByteField;
    qCariListesiI_YEDEK1: TSmallintField;
    qCariListesiL_YEDEK1: TIntegerField;
    qCariListesiFIYATGRUBU: TStringField;
    qCariListesiKAYITYAPANKUL: TStringField;
    qCariListesiKAYITTARIHI: TDateTimeField;
    qCariListesiDUZELTMEYAPANKUL: TStringField;
    qCariListesiDUZELTMETARIHI: TDateTimeField;
    qCariListesiODEMETIPI: TByteField;
    qCariListesiONAYTIPI: TStringField;
    qCariListesiONAYNUM: TIntegerField;
    qCariListesiMUSTERIBAZIKDV: TStringField;
    qCariListesiAGIRLIK_ISK: TFloatField;
    qCariListesiCARI_TEL2: TStringField;
    qCariListesiCARI_TEL3: TStringField;
    qCariListesiFAX2: TStringField;
    qCariListesiGSM1: TStringField;
    qCariListesiGSM2: TStringField;
    qCariListesiGEKAPHESAPLANMASIN: TStringField;
    qCariListesiONCEKI_KOD: TStringField;
    qCariListesiSONRAKI_KOD: TStringField;
    qCariListesiSONCARIKODU: TStringField;
    qCariListesiTESLIMCARIBAGLIMI: TStringField;
    qCariListesiBAGLICARIKOD: TStringField;
    qCariListesiFABRIKA_KODU: TStringField;
    qCariListesiKULL1N: TFloatField;
    qCariListesiKULL2N: TFloatField;
    qCariListesiKULL3N: TFloatField;
    qCariListesiKULL4N: TFloatField;
    qCariListesiKULL5N: TFloatField;
    qCariListesiKULL6N: TFloatField;
    qCariListesiKULL7N: TFloatField;
    qCariListesiKULL8N: TFloatField;
    qCariListesiKULL1S: TStringField;
    qCariListesiKULL2S: TStringField;
    qCariListesiKULL3S: TStringField;
    qCariListesiKULL4S: TStringField;
    qCariListesiKULL5S: TStringField;
    qCariListesiKULL6S: TStringField;
    qCariListesiKULL7S: TStringField;
    qCariListesiKULL8S: TStringField;
    qCariListesiSALES_VOLUME: TFloatField;
    qCariListesiPRIM: TFloatField;
    qCariListesiCIRO_TARIHI: TStringField;
    qCariListesiESKI_YENI: TStringField;
    qCariListesiODEKOD: TStringField;
    qCariListesiTCKIMLIKNO: TStringField;
    qCariListesiCARIALIAS: TStringField;
    qCariListesiCARIKOMTIP: TStringField;
    qCariListesiCARIEIRSALIAS: TStringField;
    qCariListesiDOVIZ_CEVRIM: TByteField;
    qCariListesiEIRSSABLONKOD: TStringField;
    qCariListesiMUHASEBAT: TStringField;
    qCariListesiCARIRISK: TStringField;
    qCariListesiEFAT_DZNADI: TStringField;
    qCariListesiEARS_DZNADI: TStringField;
    qCariListesiEIRS_DZNADI: TStringField;
    qCariListesiEMUST_DZNADI: TStringField;
    qCariListesiEARS_INT_DZNADI: TStringField;
    qCariListesiBAKIYE: TFloatField;
    qFisTip: TUniQuery;
    saKaydet: TUniSweetAlert;
    saMesaj: TUniSweetAlert;
    UniContainerPanel1: TUniContainerPanel;
    UniPanel2: TUniPanel;
    UniMenuButton1: TUniMenuButton;
    UniButton2: TUniButton;
    UniButton1: TUniButton;
    UniPanel6: TUniPanel;
    btnKaydet: TUniButton;
    btnSil: TUniButton;
    UniPanel1: TUniPanel;
    UniSimplePanel3: TUniSimplePanel;
    UniDateTimePicker1: TUniDateTimePicker;
    UniDateTimePicker2: TUniDateTimePicker;
    edCariKod: TUniEdit;
    cbFaturaDurum: TUniComboBox;
    btnListele: TUniButton;
    UniSimplePanel2: TUniSimplePanel;
    UniDBGrid1: TUniDBGrid;
    UniGridCSVExporter1: TUniGridCSVExporter;
    UniGridExcelExporter1: TUniGridExcelExporter;
    UniGridHTMLExporter1: TUniGridHTMLExporter;
    UniScreenMask1: TUniScreenMask;
    procedure UniButton2Click(Sender: TObject);
  private
    { Private declarations }
    SQL : string;

  public
    { Public declarations }
  end;

function frmCariRisk: TfrmCariRisk;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, Main, DMU;

function frmCariRisk: TfrmCariRisk;
begin
  Result := TfrmCariRisk(UniMainModule.GetFormInstance(TfrmCariRisk));
end;

procedure TfrmCariRisk.UniButton2Click(Sender: TObject);
begin
    MainForm.NavPage.ActivePage.Close;
end;

end.
