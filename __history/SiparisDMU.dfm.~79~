object frmSiparisDM: TfrmSiparisDM
  Height = 576
  Width = 803
  object qFisBaslik: TUniQuery
    Connection = frmDM.conAsya
    SQL.Strings = (
      'Select * from SIPARIS_BASLIK'
      '-- where FisNo = '#39'T20220000000855'#39
      'Where FisNo=:FisNo')
    BeforePost = qFisBaslikBeforePost
    Left = 32
    Top = 34
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FisNo'
        Value = Null
      end>
  end
  object qFisDetay: TUniQuery
    Connection = frmDM.conAsya
    SQL.Strings = (
      'Select *,'#39'Hari'#231#39' as KdvDahil from SIPARIS_DETAY order by SiraNo')
    MasterSource = dsFisBaslik
    MasterFields = 'FisNo'
    DetailFields = 'FisNo'
    CachedUpdates = True
    BeforePost = qFisDetayBeforePost
    OnCalcFields = qFisDetayCalcFields
    Left = 168
    Top = 42
    ParamData = <
      item
        DataType = ftString
        Name = 'FisNo'
        ParamType = ptInput
        Value = 'T20220000000855'
      end>
    object qFisDetaycKdvTutar: TFloatField
      FieldKind = fkCalculated
      FieldName = 'cKdvTutar'
      DisplayFormat = '#.,##'
      Calculated = True
    end
    object qFisDetaycBrutToplam: TFloatField
      FieldKind = fkCalculated
      FieldName = 'cBrutToplam'
      DisplayFormat = '#.,#####'
      Calculated = True
    end
    object qFisDetaycIskToplam: TFloatField
      FieldKind = fkCalculated
      FieldName = 'cIskToplam'
      DisplayFormat = '#.,##'
      Calculated = True
    end
    object qFisDetaycNetToplam: TFloatField
      FieldKind = fkCalculated
      FieldName = 'cNetToplam'
      DisplayFormat = '#.,#####'
      Calculated = True
    end
    object qFisDetaycNetBirimFiyat: TFloatField
      FieldKind = fkCalculated
      FieldName = 'cNetBirimFiyat'
      DisplayFormat = '#.,#####'
      Calculated = True
    end
    object qFisDetaycKdvBirimFiyat: TFloatField
      FieldKind = fkCalculated
      FieldName = 'cKdvBirimFiyat'
      DisplayFormat = '#.,##'
      Calculated = True
    end
    object qFisDetaycCariBirimFiyat: TFloatField
      FieldKind = fkCalculated
      FieldName = 'cCariBirimFiyat'
      DisplayFormat = '#.,#####'
      Calculated = True
    end
    object qFisDetaycCariToplam: TFloatField
      FieldKind = fkCalculated
      FieldName = 'cCariToplam'
      DisplayFormat = '#.,##'
      Calculated = True
    end
    object qFisDetaycOtvToplam: TFloatField
      FieldKind = fkCalculated
      FieldName = 'cOtvToplam'
      DisplayFormat = '#.,##'
      Calculated = True
    end
    object qFisDetaycOivToplam: TFloatField
      FieldKind = fkCalculated
      FieldName = 'cOivToplam'
      DisplayFormat = '#.,##'
      Calculated = True
    end
    object qFisDetayFisDetayID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'FisDetayID'
    end
    object qFisDetayDepoID: TIntegerField
      FieldName = 'DepoID'
      Required = True
    end
    object qFisDetayBirimFiyat: TFloatField
      FieldName = 'BirimFiyat'
      Required = True
      DisplayFormat = '#.,#####'
    end
    object qFisDetayNetBirimFiyat: TFloatField
      FieldName = 'NetBirimFiyat'
      DisplayFormat = '#.,#####'
    end
    object qFisDetayKdvBirimFiyat: TFloatField
      FieldName = 'KdvBirimFiyat'
      DisplayFormat = '#.,##'
    end
    object qFisDetayMiktar: TFloatField
      FieldName = 'Miktar'
      Required = True
    end
    object qFisDetayGercekMiktar: TFloatField
      FieldName = 'GercekMiktar'
    end
    object qFisDetayKdv: TFloatField
      FieldName = 'Kdv'
      DisplayFormat = '#.,##'
    end
    object qFisDetayKdvTutar: TFloatField
      FieldName = 'KdvTutar'
      DisplayFormat = '#.,##'
    end
    object qFisDetayIskYuzde_1: TFloatField
      FieldName = 'IskYuzde_1'
    end
    object qFisDetayIskTutar: TFloatField
      FieldName = 'IskTutar'
      DisplayFormat = '#.,##'
    end
    object qFisDetayIskToplam: TFloatField
      FieldName = 'IskToplam'
      DisplayFormat = '#.,##'
    end
    object qFisDetayBrutToplam: TFloatField
      FieldName = 'BrutToplam'
      DisplayFormat = '#.,#####'
    end
    object qFisDetayNetToplam: TFloatField
      FieldName = 'NetToplam'
      DisplayFormat = '#.,##'
    end
    object qFisDetaySiraNo: TIntegerField
      FieldName = 'SiraNo'
    end
    object qFisDetayOtvToplam: TFloatField
      FieldName = 'OtvToplam'
    end
    object qFisDetayOtvDeger: TFloatField
      FieldName = 'OtvDeger'
    end
    object qFisDetayOivYuzde: TFloatField
      FieldName = 'OivYuzde'
    end
    object qFisDetayGiren: TFloatField
      FieldName = 'Giren'
    end
    object qFisDetayCikan: TFloatField
      FieldName = 'Cikan'
    end
    object qFisDetayCariBirimFiyat: TFloatField
      FieldName = 'CariBirimFiyat'
      DisplayFormat = '#.,#####'
    end
    object qFisDetayCariToplam: TFloatField
      FieldName = 'CariToplam'
    end
    object qFisDetaySatisKur: TFloatField
      FieldName = 'SatisKur'
      DisplayFormat = '#.,#####'
    end
    object qFisDetayCariKur: TFloatField
      FieldName = 'CariKur'
    end
    object qFisDetayCarpan: TFloatField
      FieldName = 'Carpan'
    end
    object qFisDetayStokTip: TShortintField
      FieldName = 'StokTip'
    end
    object qFisDetayAlisMaliyet: TFloatField
      FieldName = 'AlisMaliyet'
      DisplayFormat = '#.,##'
    end
    object qFisDetaycKdvTevkifat: TFloatField
      FieldKind = fkCalculated
      FieldName = 'cKdvTevkifat'
      Calculated = True
    end
    object qFisDetayTevkifatKdv: TFloatField
      FieldName = 'TevkifatKdv'
    end
    object qFisDetayFisNo: TStringField
      FieldName = 'FisNo'
      Required = True
      Size = 50
    end
    object qFisDetayIskYuzde_2: TFloatField
      FieldName = 'IskYuzde_2'
    end
    object qFisDetayIskYuzde_3: TFloatField
      FieldName = 'IskYuzde_3'
      DisplayFormat = '#.,##'
    end
    object qFisDetayStokAciklama: TStringField
      FieldName = 'StokAciklama'
      Size = 200
    end
    object qFisDetayStokKod: TStringField
      FieldName = 'StokKod'
      Required = True
      Size = 50
    end
    object qFisDetayParaBirimi: TStringField
      FieldName = 'ParaBirimi'
      Size = 5
    end
    object qFisDetayStokDurum: TByteField
      FieldName = 'StokDurum'
    end
    object qFisDetayStokBirim: TStringField
      FieldName = 'StokBirim'
      Required = True
      Size = 30
    end
    object qFisDetayOtvKod: TStringField
      FieldName = 'OtvKod'
      Size = 50
    end
    object qFisDetayOtvOranTutar: TStringField
      FieldName = 'OtvOranTutar'
      Size = 10
    end
    object qFisDetayCariParaBirimi: TStringField
      FieldName = 'CariParaBirimi'
      Size = 5
    end
    object qFisDetaySatisKurBirimi: TStringField
      FieldName = 'SatisKurBirimi'
      Size = 5
    end
    object qFisDetayStokGercekBirim: TStringField
      FieldName = 'StokGercekBirim'
      Size = 30
    end
    object qFisDetayKdvDahil: TStringField
      FieldName = 'KdvDahil'
      ReadOnly = True
      Required = True
      Size = 5
    end
    object qFisDetaySonMaliyetFiyat: TFloatField
      FieldName = 'SonMaliyetFiyat'
      DisplayFormat = '#.,##'
    end
    object qFisDetaySonMaliyetTarih: TDateTimeField
      FieldName = 'SonMaliyetTarih'
    end
    object qFisDetaySonAlisFiyat: TFloatField
      FieldName = 'SonAlisFiyat'
      DisplayFormat = '#.,##'
    end
    object qFisDetaySonAlisTarih: TDateTimeField
      FieldName = 'SonAlisTarih'
    end
    object qFisDetayDovizAdi: TStringField
      FieldName = 'DovizAdi'
      Size = 10
    end
    object qFisDetaycDovizFiyat: TFloatField
      FieldKind = fkCalculated
      FieldName = 'cDovizFiyat'
      DisplayFormat = '#.,##'
      Calculated = True
    end
    object qFisDetayc_BrutFiyat: TFloatField
      FieldKind = fkCalculated
      FieldName = 'c_BrutFiyat'
      DisplayFormat = '#.,##'
      Calculated = True
    end
    object qFisDetayc_NetFiyat: TFloatField
      FieldKind = fkCalculated
      FieldName = 'c_NetFiyat'
      Calculated = True
    end
    object qFisDetayKontrolFiyat: TFloatField
      FieldName = 'KontrolFiyat'
    end
    object qFisDetayOzel1: TStringField
      FieldName = 'Ozel1'
      Size = 50
    end
    object qFisDetayOzel2: TStringField
      FieldName = 'Ozel2'
      Size = 50
    end
    object qFisDetayLDoviz: TStringField
      FieldKind = fkLookup
      FieldName = 'LDoviz'
      LookupDataSet = qDoviz
      LookupKeyFields = 'ISIM'
      LookupResultField = 'ISIM'
      KeyFields = 'DovizAdi'
      Lookup = True
    end
    object qFisDetaySatirEK1: TStringField
      FieldName = 'SatirEK1'
      Size = 50
    end
    object qFisDetaySatirEK2: TStringField
      FieldName = 'SatirEK2'
      Size = 50
    end
    object qFisDetaycNetDovizBirimFiyat: TFloatField
      FieldKind = fkCalculated
      FieldName = 'cNetDovizBirimFiyat'
      Calculated = True
    end
    object qFisDetaycIskTutar1: TFloatField
      FieldKind = fkCalculated
      FieldName = 'cIskTutar1'
      Calculated = True
    end
  end
  object dsFisDetay: TUniDataSource
    DataSet = qFisDetay
    Left = 168
    Top = 98
  end
  object dsFisBaslik: TUniDataSource
    DataSet = qFisBaslik
    Left = 32
    Top = 90
  end
  object qStokSec: TUniQuery
    Connection = frmDM.conNetsis
    SQL.Strings = (
      'SELECT SUBE_KODU'
      ',ISLETME_KODU'
      ',STOK_KODU'
      ',URETICI_KODU'
      ',STOK_ADI'
      ',GRUP_KODU'
      ',KOD_1'
      ',KOD_2'
      ',KOD_3'
      ',KOD_4'
      ',KOD_5'
      ',SATICI_KODU'
      ',OLCU_BR1'
      ',OLCU_BR2'
      ',PAY_1'
      ',PAYDA_1'
      ',OLCU_BR3'
      ',PAY2'
      ',PAYDA2'
      ',FIAT_BIRIMI'
      ',AZAMI_STOK'
      ',ASGARI_STOK'
      ',TEMIN_SURESI'
      ',KUL_MIK'
      ',RISK_SURESI'
      ',ZAMAN_BIRIMI'
      ',SATIS_FIAT1'
      ',SATIS_FIAT2'
      ',SATIS_FIAT3'
      ',SATIS_FIAT4'
      ',SAT_DOV_TIP'
      ',DOV_ALIS_FIAT'
      ',DOV_MAL_FIAT'
      ',DOV_SATIS_FIAT'
      ',MUH_DETAYKODU'
      ',BIRIM_AGIRLIK'
      ',NAKLIYET_TUT'
      ',KDV_ORANI'
      ',ALIS_DOV_TIP'
      ',DEPO_KODU'
      ',DOV_TUR'
      ',URET_OLCU_BR'
      ',BILESENMI'
      ',MAMULMU'
      ',FORMUL_TOPLAMI'
      ',UPDATE_KODU'
      ',MAX_ISKONTO'
      ',ECZACI_KARI'
      ',MIKTAR'
      ',MAL_FAZLASI'
      ',KDV_TENZIL_ORAN'
      ',KILIT'
      ',ONCEKI_KOD'
      ',SONRAKI_KOD'
      ',BARKOD1'
      ',BARKOD2'
      ',BARKOD3'
      ',ALIS_KDV_KODU'
      ',ALIS_FIAT1'
      ',ALIS_FIAT2'
      ',ALIS_FIAT3'
      ',ALIS_FIAT4'
      ',LOT_SIZE'
      ',MIN_SIP_MIKTAR'
      ',SABIT_SIP_ARALIK'
      ',SIP_POLITIKASI'
      ',OZELLIK_KODU1'
      ',OZELLIK_KODU2'
      ',OZELLIK_KODU3'
      ',OZELLIK_KODU4'
      ',OZELLIK_KODU5'
      ',OPSIYON_KODU1'
      ',OPSIYON_KODU2'
      ',OPSIYON_KODU3'
      ',OPSIYON_KODU4'
      ',OPSIYON_KODU5'
      ',BILESEN_OP_KODU'
      ',SIP_VER_MAL'
      ',ELDE_BUL_MAL'
      ',YIL_TAH_KUL_MIK'
      ',EKON_SIP_MIKTAR'
      ',ESKI_RECETE'
      ',OTOMATIK_URETIM'
      ',ALFKOD'
      ',SAFKOD'
      ',KODTURU'
      ',S_YEDEK1'
      ',S_YEDEK2'
      ',F_YEDEK3'
      ',F_YEDEK4'
      ',C_YEDEK5'
      ',C_YEDEK6'
      ',B_YEDEK7'
      ',I_YEDEK8'
      ',L_YEDEK9'
      ',D_YEDEK10'
      ',GIRIS_SERI'
      ',CIKIS_SERI'
      ',SERI_BAK'
      ',SERI_MIK'
      ',SERI_GIR_OT'
      ',SERI_CIK_OT'
      ',SERI_BASLANGIC'
      ',FIYATKODU'
      ',FIYATSIRASI'
      ',PLANLANACAK'
      ',LOT_SIZECUSTOMER'
      ',MIN_SIP_MIKTARCUSTOMER'
      ',GUMRUKTARIFEKODU'
      ',ABCKODU'
      ',PERFORMANSKODU'
      ',SATICISIPKILIT'
      ',MUSTERISIPKILIT'
      ',SATINALMAKILIT'
      ',SATISKILIT'
      ',EN'
      ',BOY'
      ',GENISLIK'
      ',SIPLIMITVAR'
      ',SONSTOKKODU'
      ',ONAYTIPI'
      ',ONAYNUM'
      ',FIKTIF_MAM'
      ',YAPILANDIR'
      ',SBOMVARMI'
      ',BAGLISTOKKOD'
      ',YAPKOD'
      ',ALISTALTEKKILIT'
      ',SATISTALTEKKILIT'
      ',S_YEDEK3'
      ',STOKMEVZUAT'
      ',OTVTEVKIFAT'
      ',SERIBARKOD'
      ' FROM TBLSTSABIT where Stok_Kodu=:StokKod')
    Left = 344
    Top = 42
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'StokKod'
        Value = nil
      end>
  end
  object spStokMaliyetBul: TUniStoredProc
    StoredProcName = 'STOKMALIYETBUL;1'
    SQL.Strings = (
      '{:RETURN_VALUE = CALL STOKMALIYETBUL;1 (:STOK)}')
    Connection = frmDM.conNetsis
    Left = 444
    Top = 105
    ParamData = <
      item
        DataType = ftInteger
        Name = 'RETURN_VALUE'
        ParamType = ptResult
        Value = 0
      end
      item
        DataType = ftString
        Name = 'STOK'
        ParamType = ptInput
        Size = 35
        Value = nil
      end>
    CommandStoredProcName = 'STOKMALIYETBUL;1'
  end
  object qNetsisSubeParametre: TUniQuery
    Connection = frmDM.conNetsis
    SQL.Strings = (
      
        'SELECT SUBE_KODU, ISNULL(YEDEK11,'#39'H'#39') AS YEDEK11 FROM TBLPARAM W' +
        'HERE SUBE_KODU =:Sube')
    Left = 448
    Top = 38
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Sube'
        Value = nil
      end>
  end
  object qDoviz: TUniQuery
    Connection = frmDM.conNetsis
    SQL.Strings = (
      
        'SELECT D.*, K.BIRIM, K.ISIM, K.NETSISSIRA FROM NETSIS.DBO.DOVIZ ' +
        'D '
      'LEFT JOIN NETSIS.DBO.KUR K WITH(NOLOCK) ON (K.SIRA = D.SIRA) '
      'WHERE TARIH =:Tar'
      '-- WHERE TARIH ='#39'2022-10-05'#39
      'UNION ALL '
      'SELECT '#39#39',0,'#39#39',1,'#39#39',1,'#39#39','#39#39','#39#39','#39#39',1,'#39'TL'#39',0 '
      ''
      
        '--SELECT D.*, K.BIRIM, K.ISIM, K.NETSISSIRA FROM NETSIS.DBO.DOVI' +
        'Z D '
      '--LEFT JOIN NETSIS.DBO.KUR K WITH(NOLOCK) ON (K.SIRA = D.SIRA) '
      '--WHERE TARIH = '#39'2022-04-18'#39)
    Left = 554
    Top = 33
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Tar'
        Value = Null
      end>
  end
  object dDoviz: TUniDataSource
    DataSet = qDoviz
    Left = 554
    Top = 89
  end
  object qEk: TUniQuery
    Connection = frmDM.conAsya
    SQL.Strings = (
      'SELECT * FROM FISBASLIK_EK')
    MasterSource = dsFisBaslik
    MasterFields = 'CariKod;FisNo'
    DetailFields = 'CARIKOD;FATIRSNO'
    CachedUpdates = True
    BeforePost = qEkBeforePost
    Left = 32
    Top = 153
    ParamData = <
      item
        DataType = ftString
        Name = 'CariKod'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'FisNo'
        Value = nil
      end>
  end
  object dEk: TUniDataSource
    DataSet = qEk
    Left = 32
    Top = 224
  end
  object db_FisBaslik: TfrxDBDataset
    UserName = 'Fis_Baslik'
    CloseDataSource = False
    DataSet = qFisBaslik
    BCDToCurrency = False
    DataSetOptions = []
    Left = 96
    Top = 32
  end
  object db_FisDetay: TfrxDBDataset
    UserName = 'Fis_Detay'
    CloseDataSource = False
    DataSet = qFisDetay
    BCDToCurrency = False
    DataSetOptions = []
    Left = 248
    Top = 40
    FieldDefs = <
      item
        FieldName = 'cKdvTutar'
        FieldAlias = 'cKdvTutar'
      end
      item
        FieldName = 'cBrutToplam'
        FieldAlias = 'cBrutToplam'
      end
      item
        FieldName = 'cIskToplam'
        FieldAlias = 'cIskToplam'
      end
      item
        FieldName = 'cNetToplam'
        FieldAlias = 'cNetToplam'
      end
      item
        FieldName = 'cNetBirimFiyat'
        FieldAlias = 'cNetBirimFiyat'
      end
      item
        FieldName = 'cKdvBirimFiyat'
        FieldAlias = 'cKdvBirimFiyat'
      end
      item
        FieldName = 'cCariBirimFiyat'
        FieldAlias = 'cCariBirimFiyat'
      end
      item
        FieldName = 'cCariToplam'
        FieldAlias = 'cCariToplam'
      end
      item
        FieldName = 'cOtvToplam'
        FieldAlias = 'cOtvToplam'
      end
      item
        FieldName = 'cOivToplam'
        FieldAlias = 'cOivToplam'
      end
      item
        FieldName = 'FisDetayID'
        FieldAlias = 'FisDetayID'
      end
      item
        FieldName = 'DepoID'
        FieldAlias = 'DepoID'
      end
      item
        FieldName = 'BirimFiyat'
        FieldAlias = 'BirimFiyat'
      end
      item
        FieldName = 'NetBirimFiyat'
        FieldAlias = 'NetBirimFiyat'
      end
      item
        FieldName = 'KdvBirimFiyat'
        FieldAlias = 'KdvBirimFiyat'
      end
      item
        FieldName = 'Miktar'
        FieldAlias = 'Miktar'
      end
      item
        FieldName = 'GercekMiktar'
        FieldAlias = 'GercekMiktar'
      end
      item
        FieldName = 'Kdv'
        FieldAlias = 'Kdv'
      end
      item
        FieldName = 'KdvTutar'
        FieldAlias = 'KdvTutar'
      end
      item
        FieldName = 'IskYuzde_1'
        FieldAlias = 'IskYuzde_1'
      end
      item
        FieldName = 'IskTutar'
        FieldAlias = 'IskTutar'
      end
      item
        FieldName = 'IskToplam'
        FieldAlias = 'IskToplam'
      end
      item
        FieldName = 'BrutToplam'
        FieldAlias = 'BrutToplam'
      end
      item
        FieldName = 'NetToplam'
        FieldAlias = 'NetToplam'
      end
      item
        FieldName = 'SiraNo'
        FieldAlias = 'SiraNo'
      end
      item
        FieldName = 'OtvToplam'
        FieldAlias = 'OtvToplam'
      end
      item
        FieldName = 'OtvDeger'
        FieldAlias = 'OtvDeger'
      end
      item
        FieldName = 'OivYuzde'
        FieldAlias = 'OivYuzde'
      end
      item
        FieldName = 'Giren'
        FieldAlias = 'Giren'
      end
      item
        FieldName = 'Cikan'
        FieldAlias = 'Cikan'
      end
      item
        FieldName = 'CariBirimFiyat'
        FieldAlias = 'CariBirimFiyat'
      end
      item
        FieldName = 'CariToplam'
        FieldAlias = 'CariToplam'
      end
      item
        FieldName = 'SatisKur'
        FieldAlias = 'SatisKur'
      end
      item
        FieldName = 'CariKur'
        FieldAlias = 'CariKur'
      end
      item
        FieldName = 'Carpan'
        FieldAlias = 'Carpan'
      end
      item
        FieldName = 'StokTip'
        FieldAlias = 'StokTip'
      end
      item
        FieldName = 'AlisMaliyet'
        FieldAlias = 'AlisMaliyet'
      end
      item
        FieldName = 'cKdvTevkifat'
        FieldAlias = 'cKdvTevkifat'
      end
      item
        FieldName = 'TevkifatKdv'
        FieldAlias = 'TevkifatKdv'
      end
      item
        FieldName = 'FisNo'
        FieldAlias = 'FisNo'
      end
      item
        FieldName = 'IskYuzde_2'
        FieldAlias = 'IskYuzde_2'
      end
      item
        FieldName = 'IskYuzde_3'
        FieldAlias = 'IskYuzde_3'
      end
      item
        FieldName = 'StokAciklama'
        FieldAlias = 'StokAciklama'
      end
      item
        FieldName = 'StokKod'
        FieldAlias = 'StokKod'
      end
      item
        FieldName = 'ParaBirimi'
        FieldAlias = 'ParaBirimi'
      end
      item
        FieldName = 'StokDurum'
        FieldAlias = 'StokDurum'
      end
      item
        FieldName = 'StokBirim'
        FieldAlias = 'StokBirim'
      end
      item
        FieldName = 'OtvKod'
        FieldAlias = 'OtvKod'
      end
      item
        FieldName = 'OtvOranTutar'
        FieldAlias = 'OtvOranTutar'
      end
      item
        FieldName = 'CariParaBirimi'
        FieldAlias = 'CariParaBirimi'
      end
      item
        FieldName = 'SatisKurBirimi'
        FieldAlias = 'SatisKurBirimi'
      end
      item
        FieldName = 'StokGercekBirim'
        FieldAlias = 'StokGercekBirim'
      end
      item
        FieldName = 'KdvDahil'
        FieldAlias = 'KdvDahil'
      end
      item
        FieldName = 'SonMaliyetFiyat'
        FieldAlias = 'SonMaliyetFiyat'
      end
      item
        FieldName = 'SonMaliyetTarih'
        FieldAlias = 'SonMaliyetTarih'
      end
      item
        FieldName = 'SonAlisFiyat'
        FieldAlias = 'SonAlisFiyat'
      end
      item
        FieldName = 'SonAlisTarih'
        FieldAlias = 'SonAlisTarih'
      end
      item
        FieldName = 'DovizAdi'
        FieldAlias = 'DovizAdi'
      end
      item
        FieldName = 'cDovizFiyat'
        FieldAlias = 'cDovizFiyat'
      end
      item
        FieldName = 'c_BrutFiyat'
        FieldAlias = 'c_BrutFiyat'
      end
      item
        FieldName = 'c_NetFiyat'
        FieldAlias = 'c_NetFiyat'
      end
      item
        FieldName = 'KontrolFiyat'
        FieldAlias = 'KontrolFiyat'
      end
      item
        FieldName = 'Ozel1'
        FieldAlias = 'Ozel1'
      end
      item
        FieldName = 'Ozel2'
        FieldAlias = 'Ozel2'
      end
      item
        FieldName = 'LDoviz'
        FieldAlias = 'LDoviz'
      end
      item
        FieldName = 'SatirEK1'
        FieldAlias = 'SatirEK1'
      end
      item
        FieldName = 'SatirEK2'
        FieldAlias = 'SatirEK2'
      end>
  end
  object db_Ek: TfrxDBDataset
    UserName = 'Ek_Alanlar'
    CloseDataSource = False
    DataSet = qEk
    BCDToCurrency = False
    DataSetOptions = []
    Left = 64
    Top = 160
  end
  object db_DovizKur: TfrxDBDataset
    UserName = 'Doviz_Kur'
    CloseDataSource = False
    DataSet = qDoviz
    BCDToCurrency = False
    DataSetOptions = []
    Left = 624
    Top = 32
  end
  object qCariDizayn: TUniQuery
    Connection = frmDM.conNetsis
    SQL.Strings = (
      'SELECT * FROM TBLCASABIT WHERE CARI_KOD =:Cari')
    Left = 192
    Top = 246
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Cari'
        Value = Null
      end>
  end
  object db_CariDizayn: TfrxDBDataset
    UserName = 'Cari_Kart'
    CloseDataSource = False
    DataSet = qCariDizayn
    BCDToCurrency = False
    DataSetOptions = []
    Left = 264
    Top = 248
  end
  object frxSiparis: TfrxReport
    Version = '2025.2.4'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44208.039242546300000000
    ReportOptions.LastChange = 44208.039242546300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 384
    Top = 304
    Datasets = <
      item
        DataSet = db_CariDizayn
        DataSetName = 'Cari_Kart'
      end
      item
        DataSet = db_DovizKur
        DataSetName = 'Doviz_Kur'
      end
      item
        DataSet = db_Ek
        DataSetName = 'Ek_Alanlar'
      end
      item
        DataSet = db_FisBaslik
        DataSetName = 'Fis_Baslik'
      end
      item
        DataSet = db_FisDetay
        DataSetName = 'Fis_Detay'
      end>
    Variables = <>
    Style = <>
    Watermarks = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
    end
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EmbedFontsIfProtected = False
    InteractiveFormsFontSubset = 'A-Z,a-z,0-9,#43-#47 '
    OpenAfterExport = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    Creator = 'FastReport'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    PDFStandard = psNone
    PDFVersion = pv17
    PDFColorSpace = csDeviceRGB
    Left = 424
    Top = 336
  end
  object qCariEkDizayn: TUniQuery
    Connection = frmDM.conNetsis
    SQL.Strings = (
      'SELECT * FROM TBLCASABITEK WHERE CARI_KOD =:Cari')
    Left = 176
    Top = 334
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Cari'
        Value = nil
      end>
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'Cari_KartEK'
    CloseDataSource = False
    DataSet = qCariEkDizayn
    BCDToCurrency = False
    DataSetOptions = []
    Left = 264
    Top = 344
    FieldDefs = <
      item
        FieldName = 'CARI_KOD'
        FieldAlias = 'CARI_KOD'
      end
      item
        FieldName = 'KAYITTARIHI'
        FieldAlias = 'KAYITTARIHI'
      end
      item
        FieldName = 'KAYITYAPANKUL'
        FieldAlias = 'KAYITYAPANKUL'
      end
      item
        FieldName = 'DUZELTMETARIHI'
        FieldAlias = 'DUZELTMETARIHI'
      end
      item
        FieldName = 'DUZELTMEYAPANKUL'
        FieldAlias = 'DUZELTMEYAPANKUL'
      end
      item
        FieldName = 'KULL1N'
        FieldAlias = 'KULL1N'
      end
      item
        FieldName = 'KULL2N'
        FieldAlias = 'KULL2N'
      end
      item
        FieldName = 'KULL3N'
        FieldAlias = 'KULL3N'
      end
      item
        FieldName = 'KULL4N'
        FieldAlias = 'KULL4N'
      end
      item
        FieldName = 'KULL5N'
        FieldAlias = 'KULL5N'
      end
      item
        FieldName = 'KULL6N'
        FieldAlias = 'KULL6N'
      end
      item
        FieldName = 'KULL7N'
        FieldAlias = 'KULL7N'
      end
      item
        FieldName = 'KULL8N'
        FieldAlias = 'KULL8N'
      end
      item
        FieldName = 'KULL1S'
        FieldAlias = 'KULL1S'
      end
      item
        FieldName = 'KULL2S'
        FieldAlias = 'KULL2S'
      end
      item
        FieldName = 'KULL3S'
        FieldAlias = 'KULL3S'
      end
      item
        FieldName = 'KULL4S'
        FieldAlias = 'KULL4S'
      end
      item
        FieldName = 'KULL5S'
        FieldAlias = 'KULL5S'
      end
      item
        FieldName = 'KULL6S'
        FieldAlias = 'KULL6S'
      end
      item
        FieldName = 'KULL7S'
        FieldAlias = 'KULL7S'
      end
      item
        FieldName = 'KULL8S'
        FieldAlias = 'KULL8S'
      end
      item
        FieldName = 'SALES_VOLUME'
        FieldAlias = 'SALES_VOLUME'
      end
      item
        FieldName = 'PRIM'
        FieldAlias = 'PRIM'
      end
      item
        FieldName = 'CIRO_TARIHI'
        FieldAlias = 'CIRO_TARIHI'
      end
      item
        FieldName = 'ESKI_YENI'
        FieldAlias = 'ESKI_YENI'
      end
      item
        FieldName = 'S_YEDEK1'
        FieldAlias = 'S_YEDEK1'
      end
      item
        FieldName = 'S_YEDEK2'
        FieldAlias = 'S_YEDEK2'
      end
      item
        FieldName = 'F_YEDEK1'
        FieldAlias = 'F_YEDEK1'
      end
      item
        FieldName = 'F_YEDEK2'
        FieldAlias = 'F_YEDEK2'
      end
      item
        FieldName = 'C_YEDEK1'
        FieldAlias = 'C_YEDEK1'
      end
      item
        FieldName = 'C_YEDEK2'
        FieldAlias = 'C_YEDEK2'
      end
      item
        FieldName = 'B_YEDEK1'
        FieldAlias = 'B_YEDEK1'
      end
      item
        FieldName = 'I_YEDEK1'
        FieldAlias = 'I_YEDEK1'
      end
      item
        FieldName = 'L_YEDEK1'
        FieldAlias = 'L_YEDEK1'
      end
      item
        FieldName = 'ODEKOD'
        FieldAlias = 'ODEKOD'
      end
      item
        FieldName = 'TCKIMLIKNO'
        FieldAlias = 'TCKIMLIKNO'
      end
      item
        FieldName = 'CARIALIAS'
        FieldAlias = 'CARIALIAS'
      end
      item
        FieldName = 'CARIKOMTIP'
        FieldAlias = 'CARIKOMTIP'
      end
      item
        FieldName = 'CARIEIRSALIAS'
        FieldAlias = 'CARIEIRSALIAS'
      end
      item
        FieldName = 'DOVIZ_CEVRIM'
        FieldAlias = 'DOVIZ_CEVRIM'
      end
      item
        FieldName = 'EIRSSABLONKOD'
        FieldAlias = 'EIRSSABLONKOD'
      end
      item
        FieldName = 'MUHASEBAT'
        FieldAlias = 'MUHASEBAT'
      end
      item
        FieldName = 'CARIRISK'
        FieldAlias = 'CARIRISK'
      end
      item
        FieldName = 'EFAT_DZNADI'
        FieldAlias = 'EFAT_DZNADI'
      end
      item
        FieldName = 'EARS_DZNADI'
        FieldAlias = 'EARS_DZNADI'
      end
      item
        FieldName = 'EIRS_DZNADI'
        FieldAlias = 'EIRS_DZNADI'
      end
      item
        FieldName = 'EMUST_DZNADI'
        FieldAlias = 'EMUST_DZNADI'
      end
      item
        FieldName = 'EARS_INT_DZNADI'
        FieldAlias = 'EARS_INT_DZNADI'
      end>
  end
  object qCaRisk: TUniQuery
    Connection = frmDM.conNetsis
    SQL.Strings = (
      'SELECT * FROM TBLCARISK WHERE CARIKOD =:Cari')
    Left = 360
    Top = 430
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Cari'
        Value = Null
      end>
  end
  object frxDBDataset2: TfrxDBDataset
    UserName = 'Cari_Risk'
    CloseDataSource = False
    DataSet = qCaRisk
    BCDToCurrency = False
    DataSetOptions = []
    Left = 440
    Top = 432
    FieldDefs = <
      item
        FieldName = 'CARIKOD'
        FieldAlias = 'CARIKOD'
      end
      item
        FieldName = 'RISKGRUP'
        FieldAlias = 'RISKGRUP'
      end
      item
        FieldName = 'RISKLIMITI'
        FieldAlias = 'RISKLIMITI'
      end
      item
        FieldName = 'TEMINATI'
        FieldAlias = 'TEMINATI'
      end
      item
        FieldName = 'CARISK'
        FieldAlias = 'CARISK'
      end
      item
        FieldName = 'CCRISK'
        FieldAlias = 'CCRISK'
      end
      item
        FieldName = 'SARISK'
        FieldAlias = 'SARISK'
      end
      item
        FieldName = 'SCRISK'
        FieldAlias = 'SCRISK'
      end
      item
        FieldName = 'IRSRISK'
        FieldAlias = 'IRSRISK'
      end
      item
        FieldName = 'SIPRISK'
        FieldAlias = 'SIPRISK'
      end
      item
        FieldName = 'RISKLIMITIO'
        FieldAlias = 'RISKLIMITIO'
      end
      item
        FieldName = 'TEMINATIO'
        FieldAlias = 'TEMINATIO'
      end
      item
        FieldName = 'CARISKO'
        FieldAlias = 'CARISKO'
      end
      item
        FieldName = 'CCRISKO'
        FieldAlias = 'CCRISKO'
      end
      item
        FieldName = 'SARISKO'
        FieldAlias = 'SARISKO'
      end
      item
        FieldName = 'SCRISKO'
        FieldAlias = 'SCRISKO'
      end
      item
        FieldName = 'IRSRISKO'
        FieldAlias = 'IRSRISKO'
      end
      item
        FieldName = 'SIPRISKO'
        FieldAlias = 'SIPRISKO'
      end
      item
        FieldName = 'BORCRISKO'
        FieldAlias = 'BORCRISKO'
      end
      item
        FieldName = 'SIPRISKDAVRAN'
        FieldAlias = 'SIPRISKDAVRAN'
      end
      item
        FieldName = 'IRSRISKDAVRAN'
        FieldAlias = 'IRSRISKDAVRAN'
      end
      item
        FieldName = 'FATRISKDAVRAN'
        FieldAlias = 'FATRISKDAVRAN'
      end
      item
        FieldName = 'DOVIZLI'
        FieldAlias = 'DOVIZLI'
      end
      item
        FieldName = 'KAYITYAPANKUL'
        FieldAlias = 'KAYITYAPANKUL'
      end
      item
        FieldName = 'KAYITTARIHI'
        FieldAlias = 'KAYITTARIHI'
      end
      item
        FieldName = 'DUZELTMEYAPANKUL'
        FieldAlias = 'DUZELTMEYAPANKUL'
      end
      item
        FieldName = 'DUZELTMETARIHI'
        FieldAlias = 'DUZELTMETARIHI'
      end
      item
        FieldName = 'YED1RISK'
        FieldAlias = 'YED1RISK'
      end
      item
        FieldName = 'YED2RISK'
        FieldAlias = 'YED2RISK'
      end
      item
        FieldName = 'YED1POZIT'
        FieldAlias = 'YED1POZIT'
      end
      item
        FieldName = 'YED2POZIT'
        FieldAlias = 'YED2POZIT'
      end
      item
        FieldName = 'YED1RISKO'
        FieldAlias = 'YED1RISKO'
      end
      item
        FieldName = 'YED2RISKO'
        FieldAlias = 'YED2RISKO'
      end
      item
        FieldName = 'YED1POZITO'
        FieldAlias = 'YED1POZITO'
      end
      item
        FieldName = 'YED2POZITO'
        FieldAlias = 'YED2POZITO'
      end
      item
        FieldName = 'C_YEDEK1'
        FieldAlias = 'C_YEDEK1'
      end
      item
        FieldName = 'C_YEDEK2'
        FieldAlias = 'C_YEDEK2'
      end
      item
        FieldName = 'INT_YEDEK1'
        FieldAlias = 'INT_YEDEK1'
      end
      item
        FieldName = 'YUKRISKDAVRAN'
        FieldAlias = 'YUKRISKDAVRAN'
      end
      item
        FieldName = 'SEVKRISKDAVRAN'
        FieldAlias = 'SEVKRISKDAVRAN'
      end
      item
        FieldName = 'YUKRISKO'
        FieldAlias = 'YUKRISKO'
      end
      item
        FieldName = 'SEVKRISKO'
        FieldAlias = 'SEVKRISKO'
      end
      item
        FieldName = 'YUKRISK'
        FieldAlias = 'YUKRISK'
      end
      item
        FieldName = 'SEVKRISK'
        FieldAlias = 'SEVKRISK'
      end
      item
        FieldName = 'ONAYTIPI'
        FieldAlias = 'ONAYTIPI'
      end
      item
        FieldName = 'ONAYNUM'
        FieldAlias = 'ONAYNUM'
      end>
  end
  object qFisBaslik2: TUniQuery
    Connection = frmDM.conAsya
    SQL.Strings = (
      'Select * from SIPARIS_BASLIK'
      '-- where FisNo = '#39'T20220000000855'#39
      'Where FisNo=:FisNo')
    BeforePost = qFisBaslikBeforePost
    Left = 48
    Top = 306
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FisNo'
        Value = Null
      end>
  end
  object dFisBaslik2: TUniDataSource
    DataSet = qFisBaslik2
    Left = 48
    Top = 362
  end
end
