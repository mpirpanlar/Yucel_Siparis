object frmCrmPotansiyel: TfrmCrmPotansiyel
  Left = 0
  Top = 0
  ClientHeight = 640
  ClientWidth = 920
  Caption = 'CRM - Potansiyel M'#252#351'teri'
  OnShow = UniFormShow
  BorderStyle = bsNone
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  TextHeight = 15
  object rootPanel: TUniPanel
    Left = 0
    Top = 0
    Width = 920
    Height = 640
    Hint = ''
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    Layout = 'vbox'
    object pc: TUniPageControl
      Left = 0
      Top = 0
      Width = 920
      Height = 588
      Hint = ''
      ActivePage = tabTakip
      TabOrder = 0
      LayoutConfig.Flex = 1
      LayoutConfig.Height = '100%'
      LayoutConfig.Width = '100%'
      object tabFirma: TUniTabSheet
        Hint = ''
        Caption = 'Firma / Ticari'
        Layout = 'fit'
        object panFirma: TUniPanel
          Left = 0
          Top = 0
          Width = 912
          Height = 552
          Hint = ''
          Align = alClient
          TabOrder = 0
          BorderStyle = ubsNone
          Caption = ''
          ClientEvents.UniEvents.Strings = (
            
              'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      config.' +
              'autoScroll = true;'#13#10'      config.scrollable = true;'#13#10'}')
          object lblUnvan: TUniLabel
            Left = 16
            Top = 16
            Width = 71
            Height = 13
            Hint = ''
            Caption = 'Firma Unvan *'
            TabOrder = 0
          end
          object edUnvan: TUniEdit
            Left = 128
            Top = 12
            Width = 760
            Height = 27
            Hint = 'Ticari unvan / tam ad'
            Text = ''
            TabOrder = 1
          end
          object lblKisa: TUniLabel
            Left = 16
            Top = 52
            Width = 36
            Height = 13
            Hint = ''
            Caption = 'K'#305'sa Ad'
            TabOrder = 2
          end
          object edKisa: TUniEdit
            Left = 128
            Top = 48
            Width = 360
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 3
          end
          object lblMustTip: TUniLabel
            Left = 512
            Top = 52
            Width = 59
            Height = 13
            Hint = ''
            Caption = 'M'#252#351'teri Tipi'
            TabOrder = 4
          end
          object cbMustTip: TUniComboBox
            Left = 600
            Top = 48
            Width = 288
            Height = 27
            Hint = ''
            Style = csDropDownList
            Text = ''
            TabOrder = 5
            IconItems = <>
          end
          object lblVdaire: TUniLabel
            Left = 16
            Top = 88
            Width = 63
            Height = 13
            Hint = ''
            Caption = 'Vergi Dairesi'
            TabOrder = 6
          end
          object edVdaire: TUniEdit
            Left = 128
            Top = 84
            Width = 360
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 7
          end
          object lblVno: TUniLabel
            Left = 512
            Top = 88
            Width = 43
            Height = 13
            Hint = ''
            Caption = 'Vergi No'
            TabOrder = 8
          end
          object edVno: TUniEdit
            Left = 600
            Top = 84
            Width = 288
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 9
          end
          object lblTc: TUniLabel
            Left = 16
            Top = 124
            Width = 61
            Height = 13
            Hint = ''
            Caption = 'TC Kimlik No'
            TabOrder = 10
          end
          object edTc: TUniEdit
            Left = 128
            Top = 120
            Width = 200
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 11
          end
          object lblMersis: TUniLabel
            Left = 352
            Top = 124
            Width = 38
            Height = 13
            Hint = ''
            Caption = 'MERSIS'
            TabOrder = 12
          end
          object edMersis: TUniEdit
            Left = 408
            Top = 120
            Width = 200
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 13
          end
          object lblSektor: TUniLabel
            Left = 16
            Top = 160
            Width = 33
            Height = 13
            Hint = ''
            Caption = 'Sekt'#246'r'
            TabOrder = 14
          end
          object edSektor: TUniEdit
            Left = 128
            Top = 156
            Width = 360
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 15
          end
          object lblFaal: TUniLabel
            Left = 16
            Top = 196
            Width = 81
            Height = 13
            Hint = ''
            Caption = 'Faaliyet Konusu'
            TabOrder = 16
          end
          object edFaal: TUniEdit
            Left = 128
            Top = 192
            Width = 760
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 17
          end
          object lblCalisan: TUniLabel
            Left = 16
            Top = 232
            Width = 67
            Height = 13
            Hint = ''
            Caption = #199'al'#305#351'an Say'#305's'#305
            TabOrder = 18
          end
          object edCalisan: TUniEdit
            Left = 128
            Top = 228
            Width = 100
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 19
          end
          object lblCiro: TUniLabel
            Left = 256
            Top = 232
            Width = 87
            Height = 13
            Hint = ''
            Caption = 'Tahmini Y'#305'll'#305'k Ciro'
            TabOrder = 20
          end
          object edCiro: TUniEdit
            Left = 384
            Top = 228
            Width = 120
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 21
          end
          object lblPara: TUniLabel
            Left = 528
            Top = 232
            Width = 54
            Height = 13
            Hint = ''
            Caption = 'Para Birimi'
            TabOrder = 22
          end
          object cbPara: TUniComboBox
            Left = 608
            Top = 228
            Width = 100
            Height = 27
            Hint = ''
            Style = csDropDownList
            Text = ''
            TabOrder = 23
            IconItems = <>
          end
          object lblKaynak: TUniLabel
            Left = 16
            Top = 268
            Width = 87
            Height = 13
            Hint = ''
            Caption = 'Kaynak (Referans)'
            TabOrder = 24
          end
          object edKaynak: TUniEdit
            Left = 128
            Top = 264
            Width = 360
            Height = 27
            Hint = 'Orn: web, fuar, telefon, referans'
            Text = ''
            TabOrder = 25
          end
        end
      end
      object tabAdres: TUniTabSheet
        Hint = ''
        Caption = 'Adres'
        Layout = 'fit'
        object panAdres: TUniPanel
          Left = 0
          Top = 0
          Width = 912
          Height = 552
          Hint = ''
          Align = alClient
          TabOrder = 0
          BorderStyle = ubsNone
          Caption = ''
          ClientEvents.UniEvents.Strings = (
            
              'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      config.' +
              'autoScroll = true;'#13#10'      config.scrollable = true;'#13#10'}')
          object lblUlke: TUniLabel
            Left = 16
            Top = 16
            Width = 23
            Height = 13
            Hint = ''
            Caption = #220'lke'
            TabOrder = 0
          end
          object edUlke: TUniEdit
            Left = 128
            Top = 12
            Width = 200
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 1
          end
          object lblIl: TUniLabel
            Left = 360
            Top = 16
            Width = 6
            Height = 13
            Hint = ''
            Caption = #304'l'
            TabOrder = 2
          end
          object edIl: TUniEdit
            Left = 400
            Top = 12
            Width = 200
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 3
          end
          object lblIlce: TUniLabel
            Left = 16
            Top = 52
            Width = 17
            Height = 13
            Hint = ''
            Caption = #304'l'#231'e'
            TabOrder = 4
          end
          object edIlce: TUniEdit
            Left = 128
            Top = 48
            Width = 200
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 5
          end
          object lblPk: TUniLabel
            Left = 360
            Top = 52
            Width = 58
            Height = 13
            Hint = ''
            Caption = 'Posta Kodu'
            TabOrder = 6
          end
          object edPk: TUniEdit
            Left = 440
            Top = 48
            Width = 100
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 7
          end
          object lblAdres: TUniLabel
            Left = 16
            Top = 88
            Width = 29
            Height = 13
            Hint = ''
            Caption = 'Adres'
            TabOrder = 8
          end
          object mmAdres: TUniMemo
            Left = 128
            Top = 84
            Width = 760
            Height = 200
            Hint = ''
            TabOrder = 9
          end
        end
      end
      object tabKonum: TUniTabSheet
        Hint = ''
        Caption = 'Konum / Harita'
        Layout = 'fit'
        object panKonum: TUniPanel
          Left = 0
          Top = 0
          Width = 912
          Height = 552
          Hint = ''
          Align = alClient
          TabOrder = 0
          BorderStyle = ubsNone
          Caption = ''
          ClientEvents.UniEvents.Strings = (
            
              'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      config.' +
              'autoScroll = true;'#13#10'      config.scrollable = true;'#13#10'}')
          object lblGpsE: TUniLabel
            Left = 16
            Top = 16
            Width = 54
            Height = 13
            Hint = ''
            Caption = 'GPS Enlem'
            TabOrder = 4
          end
          object edGpsEnlem: TUniEdit
            Left = 144
            Top = 12
            Width = 160
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 0
          end
          object lblGpsB: TUniLabel
            Left = 320
            Top = 16
            Width = 60
            Height = 13
            Hint = ''
            Caption = 'GPS Boylam'
            TabOrder = 5
          end
          object edGpsBoylam: TUniEdit
            Left = 416
            Top = 12
            Width = 160
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 1
          end
          object btnHaritaKonum: TUniButton
            Left = 600
            Top = 10
            Width = 200
            Height = 32
            Hint = ''
            Caption = 'Haritadan Konum Se'#231' (Google)'
            TabOrder = 2
            OnClick = btnHaritaKonumClick
          end
          object lblHarFmt: TUniLabel
            Left = 16
            Top = 56
            Width = 149
            Height = 13
            Hint = ''
            Caption = 'Harita / Geocoder Adres Sat'#305'r'#305
            TabOrder = 6
          end
          object mmHaritaAdres: TUniMemo
            Left = 16
            Top = 76
            Width = 880
            Height = 120
            Hint = ''
            TabOrder = 3
          end
          object lblKonumBilgi: TUniLabel
            Left = 16
            Top = 204
            Width = 471
            Height = 13
            Hint = ''
            Caption = 'Haritada t'#305'klay'#305'n, Yans'#305't ile forma al'#305'n, Tamam ile karta aktar'#305'n. Anahtar: CrmMapsConfigU.'
            TabOrder = 7
          end
        end
      end
      object tabIletisim: TUniTabSheet
        Hint = ''
        Caption = #304'leti'#351'im / Yetkili'
        Layout = 'fit'
        object panIletisim: TUniPanel
          Left = 0
          Top = 0
          Width = 912
          Height = 552
          Hint = ''
          Align = alClient
          TabOrder = 0
          BorderStyle = ubsNone
          Caption = ''
          ClientEvents.UniEvents.Strings = (
            
              'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      config.' +
              'autoScroll = true;'#13#10'      config.scrollable = true;'#13#10'}')
          object lblTel: TUniLabel
            Left = 16
            Top = 16
            Width = 47
            Height = 13
            Hint = ''
            Caption = 'Tel (Sabit)'
            TabOrder = 0
          end
          object edTel: TUniEdit
            Left = 128
            Top = 12
            Width = 200
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 1
          end
          object lblTel2: TUniLabel
            Left = 352
            Top = 16
            Width = 22
            Height = 13
            Hint = ''
            Caption = 'Tel 2'
            TabOrder = 2
          end
          object edTel2: TUniEdit
            Left = 408
            Top = 12
            Width = 200
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 3
          end
          object lblCep: TUniLabel
            Left = 632
            Top = 16
            Width = 36
            Height = 13
            Hint = ''
            Caption = 'Cep Tel'
            TabOrder = 4
          end
          object edCep: TUniEdit
            Left = 688
            Top = 12
            Width = 200
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 5
          end
          object lblFaks: TUniLabel
            Left = 16
            Top = 52
            Width = 23
            Height = 13
            Hint = ''
            Caption = 'Faks'
            TabOrder = 6
          end
          object edFaks: TUniEdit
            Left = 128
            Top = 48
            Width = 200
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 7
          end
          object lblEposta: TUniLabel
            Left = 352
            Top = 52
            Width = 39
            Height = 13
            Hint = ''
            Caption = 'E-posta'
            TabOrder = 8
          end
          object edEposta: TUniEdit
            Left = 408
            Top = 48
            Width = 480
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 9
          end
          object lblWeb: TUniLabel
            Left = 16
            Top = 88
            Width = 53
            Height = 13
            Hint = ''
            Caption = 'Web Sitesi'
            TabOrder = 10
          end
          object edWeb: TUniEdit
            Left = 128
            Top = 84
            Width = 760
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 11
          end
          object lblYetAd: TUniLabel
            Left = 16
            Top = 132
            Width = 78
            Height = 13
            Hint = ''
            Caption = 'Yetkili Ad Soyad'
            TabOrder = 12
          end
          object edYetAd: TUniEdit
            Left = 128
            Top = 128
            Width = 360
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 13
          end
          object lblYetUnv: TUniLabel
            Left = 512
            Top = 132
            Width = 33
            Height = 13
            Hint = ''
            Caption = 'Unvan'
            TabOrder = 14
          end
          object edYetUnv: TUniEdit
            Left = 576
            Top = 128
            Width = 312
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 15
          end
          object lblYetEposta: TUniLabel
            Left = 16
            Top = 168
            Width = 71
            Height = 13
            Hint = ''
            Caption = 'Yetkili E-posta'
            TabOrder = 16
          end
          object edYetEposta: TUniEdit
            Left = 128
            Top = 164
            Width = 360
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 17
          end
          object lblYetTel: TUniLabel
            Left = 512
            Top = 168
            Width = 45
            Height = 13
            Hint = ''
            Caption = 'Yetkili Tel'
            TabOrder = 18
          end
          object edYetTel: TUniEdit
            Left = 576
            Top = 164
            Width = 312
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 19
          end
          object lblMuhAd: TUniLabel
            Left = 16
            Top = 204
            Width = 95
            Height = 13
            Hint = ''
            Caption = 'Muhasebe Yetkilisi'
            TabOrder = 20
          end
          object edMuhAd: TUniEdit
            Left = 128
            Top = 200
            Width = 360
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 21
          end
          object lblMuhTel: TUniLabel
            Left = 16
            Top = 240
            Width = 43
            Height = 13
            Hint = ''
            Caption = 'Muh. Tel'
            TabOrder = 22
          end
          object edMuhTel: TUniEdit
            Left = 128
            Top = 236
            Width = 200
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 23
          end
          object lblMuhEposta: TUniLabel
            Left = 352
            Top = 240
            Width = 69
            Height = 13
            Hint = ''
            Caption = 'Muh. E-posta'
            TabOrder = 24
          end
          object edMuhEposta: TUniEdit
            Left = 440
            Top = 236
            Width = 448
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 25
          end
        end
      end
      object tabTakip: TUniTabSheet
        Hint = ''
        Caption = 'Durum / Netsis / Notlar'
        Layout = 'fit'
        object panTakip: TUniPanel
          Left = 0
          Top = 0
          Width = 912
          Height = 552
          Hint = ''
          Align = alClient
          TabOrder = 0
          BorderStyle = ubsNone
          Caption = ''
          ClientEvents.UniEvents.Strings = (
            
              'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      config.' +
              'autoScroll = true;'#13#10'      config.scrollable = true;'#13#10'}')
          object lblDurum: TUniLabel
            Left = 16
            Top = 16
            Width = 43
            Height = 13
            Hint = ''
            Caption = 'Durum *'
            TabOrder = 0
          end
          object lkDurum: TUniDBLookupComboBox
            Left = 128
            Top = 12
            Width = 760
            Height = 27
            Hint = ''
            ListField = 'AD'
            ListSource = dsDurLkp
            KeyField = 'POTANSIYEL_DURUM_ID'
            ListFieldIndex = 0
            TabOrder = 1
            Color = clWindow
          end
          object chkIlkTar: TUniCheckBox
            Left = 16
            Top = 52
            Width = 180
            Height = 22
            Hint = ''
            Caption = #304'lk '#304'leti'#351'im Tarihi Var'
            TabOrder = 2
          end
          object dtIlk: TUniDateTimePicker
            Left = 200
            Top = 48
            Width = 160
            Height = 27
            Hint = ''
            DateTime = 46159.000000000000000000
            DateFormat = 'dd/MM/yyyy'
            TimeFormat = 'HH:mm:ss'
            TabOrder = 3
            DisabledDates = <>
          end
          object chkSonTakip: TUniCheckBox
            Left = 16
            Top = 88
            Width = 160
            Height = 22
            Hint = ''
            Caption = 'Son Takip Tarihi Var'
            TabOrder = 4
          end
          object dtSonTakip: TUniDateTimePicker
            Left = 200
            Top = 84
            Width = 160
            Height = 27
            Hint = ''
            DateTime = 46159.000000000000000000
            DateFormat = 'dd/MM/yyyy'
            TimeFormat = 'HH:mm:ss'
            TabOrder = 5
            DisabledDates = <>
          end
          object chkSonraki: TUniCheckBox
            Left = 16
            Top = 124
            Width = 170
            Height = 22
            Hint = ''
            Caption = 'Sonraki Aksiyon Tarihi'
            TabOrder = 6
          end
          object dtSonraki: TUniDateTimePicker
            Left = 200
            Top = 120
            Width = 160
            Height = 27
            Hint = ''
            DateTime = 46159.000000000000000000
            DateFormat = 'dd/MM/yyyy'
            TimeFormat = 'HH:mm:ss'
            TabOrder = 7
            DisabledDates = <>
          end
          object lblNot: TUniLabel
            Left = 16
            Top = 164
            Width = 32
            Height = 13
            Hint = ''
            Caption = 'Notlar'
            TabOrder = 8
          end
          object mmNot: TUniMemo
            Left = 128
            Top = 160
            Width = 760
            Height = 120
            Hint = ''
            TabOrder = 9
          end
          object lblNetsis: TUniLabel
            Left = 16
            Top = 296
            Width = 134
            Height = 13
            Hint = ''
            Caption = 'Netsis Cari Kodu (Ba'#287'lant'#305')'
            TabOrder = 10
          end
          object edNetsis: TUniEdit
            Left = 240
            Top = 292
            Width = 200
            Height = 27
            Hint = 'Bul ile HV_CARI_LISTESI veya manuel'
            Text = ''
            TabOrder = 11
          end
          object btnCariBul: TUniButton
            Left = 448
            Top = 290
            Width = 120
            Height = 30
            Hint = ''
            Caption = 'Netsis Cari Bul'
            TabOrder = 12
            OnClick = btnCariBulClick
          end
          object btnNetsisTemizle: TUniButton
            Left = 576
            Top = 290
            Width = 120
            Height = 30
            Hint = ''
            Caption = 'Ba'#287'lant'#305'y'#305' Sil'
            TabOrder = 13
            OnClick = btnNetsisTemizleClick
          end
          object btnNetsisCariOlustur: TUniButton
            Left = 704
            Top = 290
            Width = 184
            Height = 30
            Hint = 'Potansiyel icin yeni Netsis cari hesabi olusturur'
            Caption = 'Netsis Cari Olu'#351'tur'
            ParentFont = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Segoe UI Semibold'
            Font.Style = [fsBold]
            TabOrder = 14
            ClientEvents.UniEvents.Strings = (
              
                'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
                'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
            OnClick = btnNetsisCariOlusturClick
          end
        end
      end
    end
    object panFooter: TUniPanel
      Left = 0
      Top = 588
      Width = 920
      Height = 52
      Hint = ''
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      LayoutConfig.Width = '100%'
      object btnYeniAktivite: TUniButton
        Left = 16
        Top = 8
        Width = 140
        Height = 36
        Hint = ''
        Caption = 'Yeni Aktivite'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 2
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'secondary'#39';'#13#10'}')
        OnClick = btnYeniAktiviteClick
      end
      object btnYeniGorev: TUniButton
        Left = 168
        Top = 8
        Width = 140
        Height = 36
        Hint = ''
        Caption = 'Yeni G'#246'rev'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 3
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'secondary'#39';'#13#10'}')
        OnClick = btnYeniGorevClick
      end
      object btnKaydet: TUniButton
        Left = 328
        Top = 8
        Width = 140
        Height = 36
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
        ScreenMask.Enabled = True
        OnClick = btnKaydetClick
      end
      object btnKapat: TUniButton
        Left = 760
        Top = 8
        Width = 100
        Height = 36
        Hint = ''
        Caption = 'Kapat'
        TabOrder = 1
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'secondary'#39';'#13#10'}')
        OnClick = btnKapatClick
      end
    end
  end
  object qLoad: TUniQuery
    Connection = frmDM.conAsya
    Left = 40
    Top = 40
  end
  object qExec: TUniQuery
    Connection = frmDM.conAsya
    Left = 80
    Top = 40
  end
  object qDurLkp: TUniQuery
    Connection = frmDM.conAsya
    Left = 120
    Top = 40
  end
  object dsDurLkp: TUniDataSource
    DataSet = qDurLkp
    Left = 160
    Top = 40
  end
end
