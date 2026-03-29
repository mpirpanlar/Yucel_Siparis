object frmCrmTeklif: TfrmCrmTeklif
  Left = 0
  Top = 0
  ClientHeight = 720
  ClientWidth = 960
  Caption = 'CRM - Teklif'
  OnShow = UniFormShow
  BorderStyle = bsNone
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  PixelsPerInch = 96
  TextHeight = 13
  object rootPanel: TUniContainerPanel
    Left = 0
    Top = 0
    Width = 960
    Height = 720
    Hint = ''
    ParentColor = False
    Align = alClient
    TabOrder = 0
    Layout = 'vbox'
    object panToolbar: TUniPanel
      Left = 0
      Top = 0
      Width = 960
      Height = 48
      Hint = ''
      TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      Color = 10865101
      LayoutConfig.Width = '100%'
      object btnKaydet: TUniButton
        Left = 12
        Top = 8
        Width = 110
        Height = 32
        Hint = ''
        Caption = 'Kaydet'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 0
        ClientEvents.UniEvents.Strings = (
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
          'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
        OnClick = btnKaydetClick
      end
      object lblTeklifNo: TUniLabel
        Left = 132
        Top = 14
        Width = 58
        Height = 17
        Hint = ''
        Caption = 'Teklif no'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        TabOrder = 2
      end
      object edTeklifNo: TUniEdit
        Left = 198
        Top = 10
        Width = 150
        Height = 27
        Hint = ''
        Text = ''
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Height = -12
        Font.Name = 'Segoe UI'
        ReadOnly = True
        TabOrder = 3
      end
      object btnOnizle: TUniButton
        Left = 356
        Top = 8
        Width = 110
        Height = 32
        Hint = ''
        Caption = 'Onizleme'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 4
        ClientEvents.UniEvents.Strings = (
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
          'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'secondary'#39';'#13#10'}')
        OnClick = btnOnizleClick
      end
      object btnYeniAktivite: TUniButton
        Left = 472
        Top = 8
        Width = 150
        Height = 32
        Hint = 'Bu teklifle on baglantili yeni CRM aktivitesi acar'
        Caption = 'Yeni aktivite'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 5
        ClientEvents.UniEvents.Strings = (
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
          'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'secondary'#39';'#13#10'}')
        OnClick = btnYeniAktiviteClick
      end
      object btnYeniGorev: TUniButton
        Left = 630
        Top = 8
        Width = 140
        Height = 32
        Hint = 'Bu teklifle bagli yeni CRM gorevi (TASK) acar; TEKLIF_ID kayda yazilir'
        Caption = 'Yeni gorev'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 6
        ClientEvents.UniEvents.Strings = (
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
          'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'secondary'#39';'#13#10'}')
        OnClick = btnYeniGorevClick
      end
      object btnKapat: TUniButton
        Left = 848
        Top = 8
        Width = 100
        Height = 32
        Hint = ''
        Align = alRight
        Caption = 'Kapat'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 7
        ClientEvents.UniEvents.Strings = (
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
          'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'secondary'#39';'#13#10'}')
        OnClick = btnKapatClick
      end
    end
    object panUst: TUniPanel
      Left = 0
      Top = 48
      Width = 960
      Height = 268
      Hint = ''
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      LayoutConfig.Width = '100%'
      object lblBaslik: TUniLabel
        Left = 12
        Top = 14
        Width = 80
        Height = 17
        Hint = ''
        Caption = 'Baslik'
        TabOrder = 0
      end
      object edBaslik: TUniEdit
        Left = 100
        Top = 10
        Width = 500
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 1
      end
      object lblDurum: TUniLabel
        Left = 620
        Top = 14
        Width = 60
        Height = 17
        Hint = ''
        Caption = 'Durum'
        TabOrder = 2
      end
      object lkDurum: TUniDBLookupComboBox
        Left = 680
        Top = 10
        Width = 260
        Height = 27
        Hint = ''
        ListField = 'AD'
        KeyField = 'TEKLIF_DURUM_ID'
        ListSource = dsDurLkp
        TabOrder = 3
      end
      object lblCari: TUniLabel
        Left = 12
        Top = 50
        Width = 80
        Height = 17
        Hint = ''
        Caption = 'Cari kod'
        TabOrder = 4
      end
      object edCariKod: TUniEdit
        Left = 100
        Top = 46
        Width = 200
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 5
      end
      object btnCariBul: TUniButton
        Left = 308
        Top = 44
        Width = 90
        Height = 30
        Hint = ''
        Caption = 'Bul'
        TabOrder = 6
        OnClick = btnCariBulClick
      end
      object lblTeklifTar: TUniLabel
        Left = 420
        Top = 50
        Width = 70
        Height = 17
        Hint = ''
        Caption = 'Teklif tar.'
        TabOrder = 7
      end
      object dtTeklif: TUniDateTimePicker
        Left = 500
        Top = 46
        Width = 150
        Height = 27
        Hint = ''
        DateTime = 45292.670659988430000000
        DateFormat = 'dd/MM/yyyy'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 8
        DisabledDates = <>
      end
      object lblGecer: TUniLabel
        Left = 668
        Top = 50
        Width = 60
        Height = 17
        Hint = ''
        Caption = 'Gecerlilik'
        TabOrder = 9
      end
      object dtGecer: TUniDateTimePicker
        Left = 740
        Top = 46
        Width = 150
        Height = 27
        Hint = ''
        DateTime = 45292.670659988430000000
        DateFormat = 'dd/MM/yyyy'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 10
        DisabledDates = <>
      end
      object lblSiparis: TUniLabel
        Left = 12
        Top = 86
        Width = 120
        Height = 17
        Hint = ''
        Caption = 'Siparis no (ERP)'
        TabOrder = 11
      end
      object edSiparis: TUniEdit
        Left = 100
        Top = 82
        Width = 320
        Height = 27
        Hint = 'Netsis / ERP siparis referansi'
        Text = ''
        TabOrder = 12
      end
      object lblNot: TUniLabel
        Left = 12
        Top = 122
        Width = 80
        Height = 17
        Hint = ''
        Caption = 'Aciklama'
        TabOrder = 13
      end
      object mmNot: TUniMemo
        Left = 100
        Top = 118
        Width = 840
        Height = 130
        Hint = ''
        TabOrder = 14
      end
    end
    object panAktBagli: TUniPanel
      Left = 0
      Top = 316
      Width = 960
      Height = 110
      Hint = ''
      TabOrder = 2
      BorderStyle = ubsNone
      Caption = ''
      Color = 16448250
      Layout = 'vbox'
      LayoutConfig.Width = '100%'
      object lblBagliAkt: TUniLabel
        Left = 0
        Top = 0
        Width = 960
        Height = 22
        Hint = ''
        Caption = 'Bagli aktiviteler (bos olabilir; cift tik: ac)'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Height = -12
        Font.Name = 'Segoe UI'
        TabOrder = 0
        LayoutConfig.Width = '100%'
      end
      object grdAktBagli: TUniDBGrid
        Left = 0
        Top = 22
        Width = 960
        Height = 88
        Hint = ''
        DataSource = dsAktBagli
        LayoutConfig.Flex = 1
        LayoutConfig.Width = '100%'
        LayoutConfig.Height = '100%'
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
        ReadOnly = True
        WebOptions.Paged = False
        WebOptions.FetchAll = True
        TabOrder = 1
        OnAjaxEvent = grdAktBagliAjaxEvent
        Columns = <
          item
            FieldName = 'AKTIVITE_ID'
            Title.Caption = 'ID'
            Width = 50
          end
          item
            FieldName = 'TIP_GORUNEN'
            Title.Caption = 'Tip'
            Width = 80
          end
          item
            FieldName = 'KONU'
            Title.Caption = 'Konu'
            Width = 260
          end
          item
            FieldName = 'AKTIVITE_TARIHI'
            Title.Caption = 'Tarih'
            Width = 120
          end
          item
            FieldName = 'DURUM'
            Title.Caption = 'Durum'
            Width = 70
          end
          item
            FieldName = 'SIPARIS_NO'
            Title.Caption = 'Siparis no'
            Width = 90
          end>
      end
    end
    object panGorBagli: TUniPanel
      Left = 0
      Top = 426
      Width = 960
      Height = 110
      Hint = ''
      TabOrder = 3
      BorderStyle = ubsNone
      Caption = ''
      Color = 16709015
      Layout = 'vbox'
      LayoutConfig.Width = '100%'
      object lblBagliGor: TUniLabel
        Left = 0
        Top = 0
        Width = 960
        Height = 22
        Hint = ''
        Caption = 'Bagli gorevler (TASK; bos olabilir; cift tik: ac)'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Height = -12
        Font.Name = 'Segoe UI'
        TabOrder = 0
        LayoutConfig.Width = '100%'
      end
      object grdGorBagli: TUniDBGrid
        Left = 0
        Top = 22
        Width = 960
        Height = 88
        Hint = ''
        DataSource = dsGorBagli
        LayoutConfig.Flex = 1
        LayoutConfig.Width = '100%'
        LayoutConfig.Height = '100%'
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
        ReadOnly = True
        WebOptions.Paged = False
        WebOptions.FetchAll = True
        TabOrder = 1
        OnAjaxEvent = grdGorBagliAjaxEvent
        Columns = <
          item
            FieldName = 'AKTIVITE_ID'
            Title.Caption = 'Akt. ID'
            Width = 55
          end
          item
            FieldName = 'KONU'
            Title.Caption = 'Konu'
            Width = 240
          end
          item
            FieldName = 'AKTIVITE_TARIHI'
            Title.Caption = 'Tarih'
            Width = 120
          end
          item
            FieldName = 'DURUM'
            Title.Caption = 'Durum'
            Width = 70
          end
          item
            FieldName = 'BITIS_TARIHI'
            Title.Caption = 'Termin'
            Width = 120
          end
          item
            FieldName = 'ONCELIK'
            Title.Caption = 'Oncelik'
            Width = 70
          end
          item
            FieldName = 'TAMAMLANDI'
            Title.Caption = 'Tamam'
            Width = 55
          end>
      end
    end
    object panSatirOrta: TUniSimplePanel
      Left = 0
      Top = 536
      Width = 960
      Height = 200
      Hint = ''
      ParentColor = False
      TabOrder = 4
      Layout = 'vbox'
      LayoutConfig.Flex = 1
      LayoutConfig.Width = '100%'
      LayoutConfig.Height = '100%'
      object lblTeklifSatirlari: TUniLabel
        Left = 0
        Top = 0
        Width = 960
        Height = 22
        Hint = ''
        Caption = 'Teklif satirlari (CRM_TEKLIF_SATIR)'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Height = -12
        Font.Style = [fsBold]
        Font.Name = 'Segoe UI'
        TabOrder = 0
        LayoutConfig.Width = '100%'
      end
      object grd: TUniDBGrid
        Left = 0
        Top = 22
        Width = 960
        Height = 178
        Hint = ''
        DataSource = dsSatir
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
        ReadOnly = True
        WebOptions.Paged = False
        WebOptions.FetchAll = True
        TabOrder = 1
        LayoutConfig.Flex = 1
        LayoutConfig.Width = '100%'
        LayoutConfig.Height = '100%'
        Columns = <
          item
            FieldName = 'STOK_KOD'
            Title.Caption = 'Stok kod'
            Width = 100
          end
          item
            FieldName = 'STOK_ADI'
            Title.Caption = 'Stok adi'
            Width = 220
          end
          item
            FieldName = 'MIKTAR'
            Title.Caption = 'Miktar'
            Width = 80
          end
          item
            FieldName = 'BIRIM'
            Title.Caption = 'Birim'
            Width = 60
          end
          item
            FieldName = 'BIRIM_FIYAT'
            Title.Caption = 'Birim fiyat'
            Width = 90
          end
          item
            FieldName = 'TUTAR'
            Title.Caption = 'Tutar'
            Width = 90
          end>
      end
    end
    object panSatir: TUniPanel
      Left = 0
      Top = 624
      Width = 960
      Height = 88
      Hint = ''
      TabOrder = 5
      LayoutConfig.Width = '100%'
      BorderStyle = ubsNone
      Caption = ''
      Color = clBtnFace
      object lblStokKod: TUniLabel
        Left = 12
        Top = 12
        Width = 70
        Height = 17
        Hint = ''
        Caption = 'Stok kod'
        TabOrder = 0
      end
      object edStokKod: TUniEdit
        Left = 88
        Top = 8
        Width = 98
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 1
      end
      object btnStokBul: TUniButton
        Left = 190
        Top = 6
        Width = 44
        Height = 30
        Hint = ''
        Caption = 'Bul'
        TabOrder = 2
        OnClick = btnStokBulClick
      end
      object lblStokAd: TUniLabel
        Left = 242
        Top = 12
        Width = 52
        Height = 17
        Hint = ''
        Caption = 'Stok ad'
        TabOrder = 3
      end
      object edStokAd: TUniEdit
        Left = 300
        Top = 8
        Width = 200
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 4
      end
      object lblMiktar: TUniLabel
        Left = 508
        Top = 12
        Width = 44
        Height = 17
        Hint = ''
        Caption = 'Miktar'
        TabOrder = 4
      end
      object edMiktar: TUniEdit
        Left = 560
        Top = 8
        Width = 80
        Height = 27
        Hint = ''
        Text = '1'
        TabOrder = 5
      end
      object lblFiyat: TUniLabel
        Left = 652
        Top = 12
        Width = 56
        Height = 17
        Hint = ''
        Caption = 'Birim fiyat'
        TabOrder = 6
      end
      object edBirimFiyat: TUniEdit
        Left = 716
        Top = 8
        Width = 90
        Height = 27
        Hint = ''
        Text = '0'
        TabOrder = 7
      end
      object btnSatirEkle: TUniButton
        Left = 816
        Top = 6
        Width = 60
        Height = 30
        Hint = ''
        Caption = 'Ekle'
        TabOrder = 8
        OnClick = btnSatirEkleClick
      end
      object btnSatirSil: TUniButton
        Left = 882
        Top = 6
        Width = 60
        Height = 30
        Hint = ''
        Caption = 'Sil'
        TabOrder = 9
        OnClick = btnSatirSilClick
      end
      object lblToplamCap: TUniLabel
        Left = 12
        Top = 52
        Width = 80
        Height = 17
        Hint = ''
        Caption = 'Satir toplami'
        TabOrder = 10
      end
      object lblToplam: TUniLabel
        Left = 100
        Top = 52
        Width = 120
        Height = 17
        Hint = ''
        Caption = '0,00'
        TabOrder = 11
      end
    end
  end
  object qExec: TUniQuery
    Connection = frmDM.conAsya
    Left = 800
    Top = 320
  end
  object qLoad: TUniQuery
    Connection = frmDM.conAsya
    Left = 840
    Top = 320
  end
  object qSatir: TUniQuery
    Connection = frmDM.conAsya
    Left = 800
    Top = 368
  end
  object dsSatir: TUniDataSource
    DataSet = qSatir
    Left = 832
    Top = 368
  end
  object qDurLkp: TUniQuery
    Connection = frmDM.conAsya
    Left = 880
    Top = 320
  end
  object dsDurLkp: TUniDataSource
    DataSet = qDurLkp
    Left = 912
    Top = 320
  end
  object qAktBagli: TUniQuery
    Connection = frmDM.conAsya
    Left = 800
    Top = 416
  end
  object dsAktBagli: TUniDataSource
    DataSet = qAktBagli
    Left = 832
    Top = 416
  end
  object qGorBagli: TUniQuery
    Connection = frmDM.conAsya
    Left = 800
    Top = 464
  end
  object dsGorBagli: TUniDataSource
    DataSet = qGorBagli
    Left = 832
    Top = 464
  end
end
