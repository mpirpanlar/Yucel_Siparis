unit NetsisEntegrasyon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses, uniGUIDialogs, uniPageControl, uniPanel, Main, uniButton, StrUtils,
  uniGUIClasses, uniGUIForm, Data.DB, MemDS, DBAccess, Uni, MainModule, DMU, UniguiApplication, uniSweetAlert ,
  ServerModule, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, Netopenx50_TLB;



//  Procedure NetsisBaglan();
//  Procedure NetsisMusteriSiparisi();

  var
  Kullanici,Sifre, Firma : String;
  AktifDekontNo, Sube : Integer;



implementation

  Uses Genel, SiparisDMU;

//procedure NetsisBaglan;
//var
//  Kernel: IKernel;
//  Sirket: ISirket;
//begin
//
//  UniMainModule.saKaydet.Show('0.');
//
//  Kullanici:='egehayat';
//  Sifre:='Eh2210?!';
//  Firma:='XXYUCEL2022';
//  Sube := 0;
//
//  if Kernel = nil then
//    begin
//      try
//        Kernel:=CoKernel.Create;
//        Sirket := Kernel.yeniSirket(vtMSSQL, Firma, 'TemelSet', '', Kullanici, Sifre, Sube);
////        Sirket := Kernel.yeniSirket(vtMSSQL, txtSirket1.Text, 'TemelSet', '', 'BYS2', 'BYS3', 0);
//
//      except
//        On E:Exception do
//          begin
//            Screen.Cursor := crDefault;
//            ShowMessage('Baðlantý Hatasý -> ' + E.Message);
//            Abort;
//          end;
//      end;
//
//      UniMainModule.saKaydet.Show('1.');
//    end;
//
//
//end;

//procedure NetsisMusteriSiparisi();
//Var
//  Kernel : IKernel;
//  Sirket : ISirket;
//  Siparis : IFatura;
//  SipUst : IFatUst;
//  SipKalem : IFatKalem;
//Begin
//
//  try
//
//    NetsisBaglan;
//
//    Siparis := Kernel.yeniFatura(Sirket,ftSSip);
//    //Siparis Ust Bilgilerini Olustur
//    SipUst := Siparis.Ust;
//    SipUst.FATIRS_NO := frmSiparisDM.qFisBaslik.FieldByName('FisNo').AsString;
//    SipUst.TIPI := ft_Acik;
//    SipUst.CariKod := frmSiparisDM.qFisBaslik.FieldByName('CariKod').AsString;
//    SipUst.TARIH := frmSiparisDM.qFisBaslik.FieldByName('Tarih').AsDateTime;
//    SipUst.SIPARIS_TEST := frmSiparisDM.qFisBaslik.FieldByName('Tarih').AsDateTime;
//
//    UniMainModule.saKaydet.Show('2.');
//
//
//    frmSiparisDM.qFisDetay.First;
//    while not frmSiparisDM.qFisDetay.Eof do
//      begin
//        SipKalem := Siparis.kalemYeni(frmSiparisDM.qFisDetay.FieldByName('StokKod').AsString);
//        SipKalem.STra_GCMIK := frmSiparisDM.qFisDetay.FieldByName('Miktar').AsFloat;
//        SipKalem.Olcubr := 1;
//        SipKalem.CEVRIM := frmSiparisDM.qFisDetay.FieldByName('Carpan').AsFloat;
//        SipKalem.STra_DOVTIP := StrToInt(frmSiparisDM.qFisDetay.FieldByName('ParaBirimi').AsString);
//        SipKalem.STra_DOVFIAT := frmSiparisDM.qFisDetay.FieldByName('BirimFiyat').AsFloat;
//        SipKalem.STra_KDV := frmSiparisDM.qFisDetay.FieldByName('Kdv').AsFloat;
//        SipKalem.STra_BF := frmSiparisDM.qFisDetay.FieldByName('NetBirimFiyat').AsFloat;
//        SipKalem.STra_SatIsk := 0;
//        SipKalem.STra_SatIsk3 := 0;
//        SipKalem.STra_NF := frmSiparisDM.qFisDetay.FieldByName('NetBirimFiyat').AsFloat;
//
//        SipKalem.DEPO_KODU :=  xKullaniciDepo;
//
//        SipKalem.D_YEDEK10 := SipUst.Tarih;
//
//        frmSiparisDM.qFisDetay.Next;
//      end;
//
//    UniMainModule.saKaydet.Show('3.');
//
//
//    //Kayýtlarý saklama
//    Siparis.kayitYeni;
//    UniMainModule.saKaydet.Show('');
//
//    SipKalem := nil;
//    SipUst := nil;
//    Siparis := nil;
//
//    Sirket := nil;
//    Kernel := nil;
//
//  except
//    On E:Exception do
//      begin
//
//        SipKalem := nil;
//        SipUst := nil;
//        Siparis := nil;
//
//
//        Sirket := nil;
//        Kernel := nil;
//
//        UniMainModule.saHata.Show(E.Message);
//      end;
//
//  end;
//
//
//
//
//end;

end.
