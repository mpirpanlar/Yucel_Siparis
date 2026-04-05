object frmCrmPotansiyel: TfrmCrmPotansiyel
  Left = 0
  Top = 0
  ClientHeight = 640
  ClientWidth = 920
  Caption = 'CRM - Potansiyel musteri'
  OnShow = UniFormShow
  BorderStyle = bsNone
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  PixelsPerInch = 96
  TextHeight = 13
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
    object panFooter: TUniPanel
      Left = 0
      Top = 588
      Width = 920
      Height = 52
      Hint = ''
      Align = alBottom
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      object btnKaydet: TUniButton
        Left = 320
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
    object pc: TUniPageControl
      Left = 0
      Top = 0
      Width = 920
      Height = 588
      Hint = ''
      Align = alClient
      TabOrder = 0
      object tabFirma: TUniTabSheet
        Hint = ''
        Caption = 'Firma / ticari'
        object lblUnvan: TUniLabel
          Left = 16
          Top = 16
          Width = 100
          Height = 17
          Caption = 'Firma unvan *'
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
          Width = 90
          Height = 17
          Caption = 'Kisa ad'
          TabOrder = 2
        end
        object edKisa: TUniEdit
          Left = 128
          Top = 48
          Width = 360
          Height = 27
          Text = ''
          TabOrder = 3
        end
        object lblMustTip: TUniLabel
          Left = 512
          Top = 52
          Width = 80
          Height = 17
          Caption = 'Musteri tipi'
          TabOrder = 4
        end
        object cbMustTip: TUniComboBox
          Left = 600
          Top = 48
          Width = 288
          Height = 27
          Style = csDropDownList
          Text = ''
          TabOrder = 5
          IconItems = <>
        end
        object lblVdaire: TUniLabel
          Left = 16
          Top = 88
          Width = 80
          Height = 17
          Caption = 'Vergi dairesi'
          TabOrder = 6
        end
        object edVdaire: TUniEdit
          Left = 128
          Top = 84
          Width = 360
          Height = 27
          Text = ''
          TabOrder = 7
        end
        object lblVno: TUniLabel
          Left = 512
          Top = 88
          Width = 60
          Height = 17
          Caption = 'Vergi no'
          TabOrder = 8
        end
        object edVno: TUniEdit
          Left = 600
          Top = 84
          Width = 288
          Height = 27
          Text = ''
          TabOrder = 9
        end
        object lblTc: TUniLabel
          Left = 16
          Top = 124
          Width = 100
          Height = 17
          Caption = 'TC kimlik no'
          TabOrder = 10
        end
        object edTc: TUniEdit
          Left = 128
          Top = 120
          Width = 200
          Height = 27
          Text = ''
          TabOrder = 11
        end
        object lblMersis: TUniLabel
          Left = 352
          Top = 124
          Width = 50
          Height = 17
          Caption = 'MERSIS'
          TabOrder = 12
        end
        object edMersis: TUniEdit
          Left = 408
          Top = 120
          Width = 200
          Height = 27
          Text = ''
          TabOrder = 13
        end
        object lblSektor: TUniLabel
          Left = 16
          Top = 160
          Width = 60
          Height = 17
          Caption = 'Sektor'
          TabOrder = 14
        end
        object edSektor: TUniEdit
          Left = 128
          Top = 156
          Width = 360
          Height = 27
          Text = ''
          TabOrder = 15
        end
        object lblFaal: TUniLabel
          Left = 16
          Top = 196
          Width = 100
          Height = 17
          Caption = 'Faaliyet konusu'
          TabOrder = 16
        end
        object edFaal: TUniEdit
          Left = 128
          Top = 192
          Width = 760
          Height = 27
          Text = ''
          TabOrder = 17
        end
        object lblCalisan: TUniLabel
          Left = 16
          Top = 232
          Width = 90
          Height = 17
          Caption = 'Calisan sayisi'
          TabOrder = 18
        end
        object edCalisan: TUniEdit
          Left = 128
          Top = 228
          Width = 100
          Height = 27
          Text = ''
          TabOrder = 19
        end
        object lblCiro: TUniLabel
          Left = 256
          Top = 232
          Width = 120
          Height = 17
          Caption = 'Tahmini yillik ciro'
          TabOrder = 20
        end
        object edCiro: TUniEdit
          Left = 384
          Top = 228
          Width = 120
          Height = 27
          Text = ''
          TabOrder = 21
        end
        object lblPara: TUniLabel
          Left = 528
          Top = 232
          Width = 70
          Height = 17
          Caption = 'Para birimi'
          TabOrder = 22
        end
        object cbPara: TUniComboBox
          Left = 608
          Top = 228
          Width = 100
          Height = 27
          Style = csDropDownList
          Text = ''
          TabOrder = 23
          IconItems = <>
        end
        object lblKaynak: TUniLabel
          Left = 16
          Top = 268
          Width = 100
          Height = 17
          Caption = 'Kaynak (referans)'
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
      object tabAdres: TUniTabSheet
        Hint = ''
        Caption = 'Adres'
        object lblUlke: TUniLabel
          Left = 16
          Top = 16
          Width = 40
          Height = 17
          Caption = 'Ulke'
          TabOrder = 0
        end
        object edUlke: TUniEdit
          Left = 128
          Top = 12
          Width = 200
          Height = 27
          Text = ''
          TabOrder = 1
        end
        object lblIl: TUniLabel
          Left = 360
          Top = 16
          Width = 20
          Height = 17
          Caption = 'Il'
          TabOrder = 2
        end
        object edIl: TUniEdit
          Left = 400
          Top = 12
          Width = 200
          Height = 27
          Text = ''
          TabOrder = 3
        end
        object lblIlce: TUniLabel
          Left = 16
          Top = 52
          Width = 30
          Height = 17
          Caption = 'Ilce'
          TabOrder = 4
        end
        object edIlce: TUniEdit
          Left = 128
          Top = 48
          Width = 200
          Height = 27
          Text = ''
          TabOrder = 5
        end
        object lblPk: TUniLabel
          Left = 360
          Top = 52
          Width = 60
          Height = 17
          Caption = 'Posta kodu'
          TabOrder = 6
        end
        object edPk: TUniEdit
          Left = 440
          Top = 48
          Width = 100
          Height = 27
          Text = ''
          TabOrder = 7
        end
        object lblAdres: TUniLabel
          Left = 16
          Top = 88
          Width = 50
          Height = 17
          Caption = 'Adres'
          TabOrder = 8
        end
        object mmAdres: TUniMemo
          Left = 128
          Top = 84
          Width = 760
          Height = 200
          TabOrder = 9
        end
      end
      object tabKonum: TUniTabSheet
        Hint = ''
        Caption = 'Konum / harita'
        object lblGpsE: TUniLabel
          Left = 16
          Top = 16
          Width = 120
          Height = 17
          Caption = 'GPS enlem'
        end
        object edGpsEnlem: TUniEdit
          Left = 144
          Top = 12
          Width = 160
          Height = 27
          Text = ''
          TabOrder = 0
        end
        object lblGpsB: TUniLabel
          Left = 320
          Top = 16
          Width = 90
          Height = 17
          Caption = 'GPS boylam'
        end
        object edGpsBoylam: TUniEdit
          Left = 416
          Top = 12
          Width = 160
          Height = 27
          Text = ''
          TabOrder = 1
        end
        object btnHaritaKonum: TUniButton
          Left = 600
          Top = 10
          Width = 200
          Height = 32
          Caption = 'Haritadan konum sec (Google)'
          TabOrder = 2
          OnClick = btnHaritaKonumClick
        end
        object lblHarFmt: TUniLabel
          Left = 16
          Top = 56
          Width = 200
          Height = 17
          Caption = 'Harita / geocoder adres satiri'
        end
        object mmHaritaAdres: TUniMemo
          Left = 16
          Top = 76
          Width = 880
          Height = 120
          TabOrder = 3
        end
        object lblKonumBilgi: TUniLabel
          Left = 16
          Top = 204
          Width = 880
          Height = 40
          Caption = 'Haritada tiklayin, Yansit ile forma alin, Tamam ile karta aktarın. Anahtar: CrmMapsConfigU.'
        end
      end
      object tabIletisim: TUniTabSheet
        Hint = ''
        Caption = 'Iletisim / yetkili'
        object lblTel: TUniLabel
          Left = 16
          Top = 16
          Width = 70
          Height = 17
          Caption = 'Tel (sabit)'
          TabOrder = 0
        end
        object edTel: TUniEdit
          Left = 128
          Top = 12
          Width = 200
          Height = 27
          Text = ''
          TabOrder = 1
        end
        object lblTel2: TUniLabel
          Left = 352
          Top = 16
          Width = 46
          Height = 17
          Caption = 'Tel 2'
          TabOrder = 2
        end
        object edTel2: TUniEdit
          Left = 408
          Top = 12
          Width = 200
          Height = 27
          Text = ''
          TabOrder = 3
        end
        object lblCep: TUniLabel
          Left = 632
          Top = 16
          Width = 50
          Height = 17
          Caption = 'Cep tel'
          TabOrder = 4
        end
        object edCep: TUniEdit
          Left = 688
          Top = 12
          Width = 200
          Height = 27
          Text = ''
          TabOrder = 5
        end
        object lblFaks: TUniLabel
          Left = 16
          Top = 52
          Width = 40
          Height = 17
          Caption = 'Faks'
          TabOrder = 6
        end
        object edFaks: TUniEdit
          Left = 128
          Top = 48
          Width = 200
          Height = 27
          Text = ''
          TabOrder = 7
        end
        object lblEposta: TUniLabel
          Left = 352
          Top = 52
          Width = 50
          Height = 17
          Caption = 'E-posta'
          TabOrder = 8
        end
        object edEposta: TUniEdit
          Left = 408
          Top = 48
          Width = 480
          Height = 27
          Text = ''
          TabOrder = 9
        end
        object lblWeb: TUniLabel
          Left = 16
          Top = 88
          Width = 60
          Height = 17
          Caption = 'Web sitesi'
          TabOrder = 10
        end
        object edWeb: TUniEdit
          Left = 128
          Top = 84
          Width = 760
          Height = 27
          Text = ''
          TabOrder = 11
        end
        object lblYetAd: TUniLabel
          Left = 16
          Top = 132
          Width = 100
          Height = 17
          Caption = 'Yetkili ad soyad'
          TabOrder = 12
        end
        object edYetAd: TUniEdit
          Left = 128
          Top = 128
          Width = 360
          Height = 27
          Text = ''
          TabOrder = 13
        end
        object lblYetUnv: TUniLabel
          Left = 512
          Top = 132
          Width = 50
          Height = 17
          Caption = 'Unvan'
          TabOrder = 14
        end
        object edYetUnv: TUniEdit
          Left = 576
          Top = 128
          Width = 312
          Height = 27
          Text = ''
          TabOrder = 15
        end
        object lblYetEposta: TUniLabel
          Left = 16
          Top = 168
          Width = 100
          Height = 17
          Caption = 'Yetkili e-posta'
          TabOrder = 16
        end
        object edYetEposta: TUniEdit
          Left = 128
          Top = 164
          Width = 360
          Height = 27
          Text = ''
          TabOrder = 17
        end
        object lblYetTel: TUniLabel
          Left = 512
          Top = 168
          Width = 60
          Height = 17
          Caption = 'Yetkili tel'
          TabOrder = 18
        end
        object edYetTel: TUniEdit
          Left = 576
          Top = 164
          Width = 312
          Height = 27
          Text = ''
          TabOrder = 19
        end
        object lblMuhAd: TUniLabel
          Left = 16
          Top = 204
          Width = 110
          Height = 17
          Caption = 'Muhasebe yetkilisi'
          TabOrder = 20
        end
        object edMuhAd: TUniEdit
          Left = 128
          Top = 200
          Width = 360
          Height = 27
          Text = ''
          TabOrder = 21
        end
        object lblMuhTel: TUniLabel
          Left = 16
          Top = 240
          Width = 70
          Height = 17
          Caption = 'Muh. tel'
          TabOrder = 22
        end
        object edMuhTel: TUniEdit
          Left = 128
          Top = 236
          Width = 200
          Height = 27
          Text = ''
          TabOrder = 23
        end
        object lblMuhEposta: TUniLabel
          Left = 352
          Top = 240
          Width = 80
          Height = 17
          Caption = 'Muh. e-posta'
          TabOrder = 24
        end
        object edMuhEposta: TUniEdit
          Left = 440
          Top = 236
          Width = 448
          Height = 27
          Text = ''
          TabOrder = 25
        end
      end
      object tabTakip: TUniTabSheet
        Hint = ''
        Caption = 'Durum / Netsis / notlar'
        object lblDurum: TUniLabel
          Left = 16
          Top = 16
          Width = 50
          Height = 17
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
          KeyField = 'POTANSIYEL_DURUM_ID'
          ListSource = dsDurLkp
          TabOrder = 1
        end
        object chkIlkTar: TUniCheckBox
          Left = 16
          Top = 52
          Width = 180
          Height = 22
          Caption = 'Ilk iletisim tarihi var'
          TabOrder = 2
        end
        object dtIlk: TUniDateTimePicker
          Left = 200
          Top = 48
          Width = 160
          Height = 27
          DateFormat = 'dd/MM/yyyy'
          TimeFormat = 'HH:mm:ss'
          TabOrder = 3
        end
        object chkSonTakip: TUniCheckBox
          Left = 16
          Top = 88
          Width = 160
          Height = 22
          Caption = 'Son takip tarihi var'
          TabOrder = 4
        end
        object dtSonTakip: TUniDateTimePicker
          Left = 200
          Top = 84
          Width = 160
          Height = 27
          DateFormat = 'dd/MM/yyyy'
          TimeFormat = 'HH:mm:ss'
          TabOrder = 5
        end
        object chkSonraki: TUniCheckBox
          Left = 16
          Top = 124
          Width = 170
          Height = 22
          Caption = 'Sonraki aksiyon tarihi'
          TabOrder = 6
        end
        object dtSonraki: TUniDateTimePicker
          Left = 200
          Top = 120
          Width = 160
          Height = 27
          DateFormat = 'dd/MM/yyyy'
          TimeFormat = 'HH:mm:ss'
          TabOrder = 7
        end
        object lblNot: TUniLabel
          Left = 16
          Top = 164
          Width = 40
          Height = 17
          Caption = 'Notlar'
          TabOrder = 8
        end
        object mmNot: TUniMemo
          Left = 128
          Top = 160
          Width = 760
          Height = 120
          TabOrder = 9
        end
        object lblNetsis: TUniLabel
          Left = 16
          Top = 296
          Width = 200
          Height = 17
          Caption = 'Netsis cari kodu (baglanti)'
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
          Caption = 'Netsis cari bul'
          TabOrder = 12
          OnClick = btnCariBulClick
        end
        object btnNetsisTemizle: TUniButton
          Left = 576
          Top = 290
          Width = 120
          Height = 30
          Caption = 'Baglantiyi sil'
          TabOrder = 13
          OnClick = btnNetsisTemizleClick
        end
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
