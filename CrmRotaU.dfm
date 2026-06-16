object frmCrmRotaPlan: TfrmCrmRotaPlan
  Left = 0
  Top = 0
  ClientHeight = 700
  ClientWidth = 1020
  Caption = 'CRM - Rota plan'#305
  OnShow = UniFormShow
  BorderStyle = bsNone
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  OnCreate = UniFormCreate
  OnDestroy = UniFormDestroy
  TextHeight = 15
  object rootPanel: TUniPanel
    Left = 0
    Top = 0
    Width = 1020
    Height = 700
    Hint = ''
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    Layout = 'vbox'
    object panUst: TUniPanel
      Left = 0
      Top = 0
      Width = 1020
      Height = 232
      Hint = ''
      TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      Color = clWhite
      LayoutConfig.Width = '100%'
      object lblBaslik: TUniLabel
        Left = 12
        Top = 12
        Width = 30
        Height = 13
        Hint = ''
        Caption = 'Ba'#351'l'#305'k'
        TabOrder = 12
      end
      object edBaslik: TUniEdit
        Left = 96
        Top = 8
        Width = 880
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 0
      end
      object lblDetay: TUniLabel
        Left = 12
        Top = 48
        Width = 57
        Height = 13
        Hint = ''
        Caption = 'Detay / not'
        TabOrder = 13
      end
      object mmDetay: TUniMemo
        Left = 96
        Top = 44
        Width = 880
        Height = 72
        Hint = ''
        TabOrder = 1
      end
      object lblPlanTar: TUniLabel
        Left = 12
        Top = 128
        Width = 52
        Height = 13
        Hint = ''
        Caption = 'Plan tarihi'
        TabOrder = 14
      end
      object dtPlan: TUniDateTimePicker
        Left = 96
        Top = 124
        Width = 140
        Height = 27
        Hint = ''
        DateTime = 45592.000000000000000000
        DateFormat = 'dd/MM/yyyy'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 2
        DisabledDates = <>
      end
      object lblDurum: TUniLabel
        Left = 260
        Top = 128
        Width = 35
        Height = 13
        Hint = ''
        Caption = 'Durum'
        TabOrder = 15
      end
      object cbDurum: TUniComboBox
        Left = 316
        Top = 124
        Width = 140
        Height = 27
        Hint = ''
        Style = csDropDownList
        Text = ''
        TabOrder = 3
        IconItems = <>
      end
      object lblEsik: TUniLabel
        Left = 480
        Top = 128
        Width = 67
        Height = 13
        Hint = ''
        Caption = 'Uyar'#305' e'#351'ik km'
        TabOrder = 16
      end
      object edEsikKm: TUniEdit
        Left = 588
        Top = 124
        Width = 60
        Height = 27
        Hint = ''
        Text = '80'
        TabOrder = 4
      end
      object lblEsikAcik: TUniLabel
        Left = 660
        Top = 128
        Width = 226
        Height = 13
        Hint = ''
        Caption = '(Rota eksenine g'#246're '#231'apraz sapma uyar'#305's'#305')'
        TabOrder = 17
      end
      object lblBasE: TUniLabel
        Left = 12
        Top = 168
        Width = 83
        Height = 13
        Hint = ''
        Caption = 'Ba'#351'lang'#305#231' GPS X'
        TabOrder = 18
      end
      object edBasEnlem: TUniEdit
        Left = 120
        Top = 164
        Width = 100
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 5
      end
      object lblBasB: TUniLabel
        Left = 228
        Top = 168
        Width = 37
        Height = 13
        Hint = ''
        Caption = 'GPS Y'
        TabOrder = 19
      end
      object edBasBoylam: TUniEdit
        Left = 276
        Top = 164
        Width = 100
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 6
      end
      object btnHarBas: TUniButton
        Left = 388
        Top = 162
        Width = 120
        Height = 30
        Hint = ''
        Caption = 'Haritadan'
        TabOrder = 7
        OnClick = btnHarBasClick
      end
      object lblBitE: TUniLabel
        Left = 520
        Top = 168
        Width = 56
        Height = 13
        Hint = ''
        Caption = 'Biti'#351' enlem'
        TabOrder = 20
      end
      object edBitEnlem: TUniEdit
        Left = 596
        Top = 164
        Width = 100
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 8
      end
      object lblBitB: TUniLabel
        Left = 704
        Top = 168
        Width = 37
        Height = 13
        Hint = ''
        Caption = 'boylam'
        TabOrder = 21
      end
      object edBitBoylam: TUniEdit
        Left = 752
        Top = 164
        Width = 100
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 9
      end
      object btnHarBit: TUniButton
        Left = 864
        Top = 162
        Width = 120
        Height = 30
        Hint = ''
        Caption = 'Haritadan'
        TabOrder = 10
        OnClick = btnHarBitClick
      end
    end
    object panDurakBar: TUniPanel
      Left = 0
      Top = 232
      Width = 1020
      Height = 76
      Hint = ''
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      LayoutConfig.Width = '100%'
      object btnEkleCari: TUniButton
        Left = 8
        Top = 8
        Width = 140
        Height = 28
        Hint = ''
        Caption = 'Durak: Netsis cari'
        TabOrder = 0
        OnClick = btnEkleCariClick
      end
      object btnEklePot: TUniButton
        Left = 156
        Top = 8
        Width = 140
        Height = 28
        Hint = ''
        Caption = 'Durak: Potansiyel'
        TabOrder = 1
        OnClick = btnEklePotClick
      end
      object btnEkleBolge: TUniButton
        Left = 304
        Top = 8
        Width = 140
        Height = 28
        Hint = 'Il / ilce filtresi ile cari ve potansiyel toplu se'#231'im'
        Caption = 'B'#246'lgeden se'#231
        TabOrder = 8
        OnClick = btnEkleBolgeClick
      end
      object btnDurakSil: TUniButton
        Left = 452
        Top = 8
        Width = 100
        Height = 28
        Hint = ''
        Caption = 'Durak sil'
        TabOrder = 2
        OnClick = btnDurakSilClick
      end
      object btnUyariYenile: TUniButton
        Left = 560
        Top = 8
        Width = 120
        Height = 28
        Hint = ''
        Caption = 'Uyar'#305'lar'#305' yenile'
        TabOrder = 3
        OnClick = btnUyariYenileClick
      end
      object btnDurakYukari: TUniButton
        Left = 688
        Top = 8
        Width = 72
        Height = 28
        Hint = 'Se'#231'ili dura'#287#305' yukar'#305' ta'#351#305
        Caption = 'Yukar'#305
        TabOrder = 4
        OnClick = btnDurakYukariClick
      end
      object btnDurakAsagi: TUniButton
        Left = 766
        Top = 8
        Width = 72
        Height = 28
        Hint = 'Se'#231'ili dura'#287#305' a'#351'a'#287#305' ta'#351#305
        Caption = 'A'#351'a'#287#305
        TabOrder = 5
        OnClick = btnDurakAsagiClick
      end
      object btnOtomatikSirala: TUniButton
        Left = 844
        Top = 8
        Width = 120
        Height = 28
        Hint = 'Ba'#351'lang'#305#231' GPS noktas'#305'na g'#246're mesafe s'#305'ras'#305
        Caption = 'Otomatik s'#305'rala'
        TabOrder = 6
        OnClick = btnOtomatikSiralaClick
      end
      object btnGorevOlustur: TUniButton
        Left = 8
        Top = 40
        Width = 160
        Height = 28
        Hint = 'T'#252'm duraklar i'#231'in g'#246'rev olu'#351'tur veya g'#252'ncelle'
        Caption = 'G'#246'revleri olu'#351'tur'
        TabOrder = 7
        OnClick = btnGorevOlusturClick
      end
      object lblDurakAcik: TUniLabel
        Left = 180
        Top = 44
        Width = 820
        Height = 26
        Hint = ''
        AutoSize = False
        Caption = 
          'Uyar'#305': rota ekseninden sapma. Bacak km: onceki noktadan duraga mesafe (GPS eksikse 0).'
        TabOrder = 9
      end
    end
    object panPersonel: TUniPanel
      Left = 0
      Top = 276
      Width = 1020
      Height = 72
      Hint = ''
      TabOrder = 2
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      LayoutConfig.Width = '100%'
      object lblAtanan: TUniLabel
        Left = 8
        Top = 8
        Width = 90
        Height = 13
        Hint = ''
        Caption = 'Atanan personel'
        TabOrder = 0
      end
      object lkPersonel: TUniDBLookupComboBox
        Left = 8
        Top = 28
        Width = 200
        Height = 24
        Hint = ''
        ListField = 'KullaniciAd'
        ListSource = dsKullanici
        KeyField = 'KullaniciID'
        ListFieldIndex = 0
        TabOrder = 1
        Color = clWindow
      end
      object btnPersEkle: TUniButton
        Left = 216
        Top = 26
        Width = 60
        Height = 28
        Hint = ''
        Caption = 'Ekle'
        TabOrder = 2
        OnClick = btnPersEkleClick
      end
      object btnPersSil: TUniButton
        Left = 280
        Top = 26
        Width = 60
        Height = 28
        Hint = ''
        Caption = 'Sil'
        TabOrder = 3
        OnClick = btnPersSilClick
      end
      object lbPersonel: TUniListBox
        Left = 360
        Top = 8
        Width = 280
        Height = 56
        Hint = ''
        TabOrder = 4
      end
      object lblToplamKm: TUniLabel
        Left = 660
        Top = 8
        Width = 120
        Height = 13
        Hint = ''
        Caption = 'Toplam yol: - km'
        TabOrder = 5
      end
      object cbGpsMod: TUniComboBox
        Left = 660
        Top = 28
        Width = 220
        Height = 24
        Hint = ''
        Style = csDropDownList
        Text = ''
        TabOrder = 6
        IconItems = <>
      end
      object btnMesafeHesapla: TUniButton
        Left = 888
        Top = 26
        Width = 120
        Height = 28
        Hint = ''
        Caption = 'Yol km hesapla'
        TabOrder = 7
        OnClick = btnMesafeHesaplaClick
      end
    end
    object grdDurak: TUniDBGrid
      Left = 0
      Top = 348
      Width = 1020
      Height = 300
      Hint = ''
      DataSource = dsGrid
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
      ReadOnly = True
      WebOptions.Paged = False
      WebOptions.FetchAll = True
      LoadMask.Message = 'Y'#252'kleniyor...'
      LayoutConfig.Flex = 1
      LayoutConfig.Height = '100%'
      LayoutConfig.Width = '100%'
      TabOrder = 3
      Columns = <
        item
          FieldName = 'SIRA'
          Title.Caption = 'S'#305'ra'
          Width = 45
          ReadOnly = True
        end
        item
          FieldName = 'TIP'
          Title.Caption = 'T'
          Width = 30
          ReadOnly = True
        end
        item
          FieldName = 'CARI_KOD'
          Title.Caption = 'Cari kod'
          Width = 90
          ReadOnly = True
        end
        item
          FieldName = 'POTID'
          Title.Caption = 'Pot.id'
          Width = 60
          ReadOnly = True
        end
        item
          FieldName = 'UNVAN'
          Title.Caption = #220'nvan'
          Width = 180
          ReadOnly = True
        end
        item
          FieldName = 'IL'
          Title.Caption = #304'l'
          Width = 70
          ReadOnly = True
        end
        item
          FieldName = 'ILCE'
          Title.Caption = #304'l'#231'e'
          Width = 80
          ReadOnly = True
        end
        item
          FieldName = 'ENLEM'
          Title.Caption = 'Enlem'
          Width = 75
          ReadOnly = True
        end
        item
          FieldName = 'BOYLAM'
          Title.Caption = 'Boylam'
          Width = 75
          ReadOnly = True
        end
        item
          FieldName = 'UYARI'
          Title.Caption = 'Uyar'#305
          Width = 180
          ReadOnly = True
        end
        item
          FieldName = 'BACAK_KM'
          Title.Caption = 'Bacak km'
          Width = 70
          ReadOnly = True
        end>
    end
    object panFooter: TUniPanel
      Left = 0
      Top = 648
      Width = 1020
      Height = 52
      Hint = ''
      TabOrder = 4
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      LayoutConfig.Width = '100%'
      object btnKaydet: TUniButton
        Left = 320
        Top = 8
        Width = 140
        Height = 36
        Hint = ''
        Caption = 'Kaydet'
        TabOrder = 0
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
        ScreenMask.Enabled = True
        OnClick = btnKaydetClick
      end
      object btnRotaHarita: TUniButton
        Left = 480
        Top = 8
        Width = 180
        Height = 36
        Hint = ''
        Caption = 'Rotay'#305' haritada'
        TabOrder = 1
        OnClick = btnRotaHaritaClick
      end
      object btnKapat: TUniButton
        Left = 880
        Top = 8
        Width = 100
        Height = 36
        Hint = ''
        Caption = 'Kapat'
        TabOrder = 2
        OnClick = btnKapatClick
      end
    end
  end
  object qGrid: TUniQuery
    Connection = frmDM.conAsya
    Left = 40
    Top = 640
  end
  object dsGrid: TUniDataSource
    DataSet = qGrid
    Left = 72
    Top = 640
  end
  object qExec: TUniQuery
    Connection = frmDM.conAsya
    Left = 104
    Top = 640
  end
  object qLoad: TUniQuery
    Connection = frmDM.conAsya
    Left = 136
    Top = 640
  end
  object qNetsis: TUniQuery
    Connection = frmDM.conNetsis
    Left = 168
    Top = 640
  end
  object qTmp: TUniQuery
    Connection = frmDM.conAsya
    Left = 200
    Top = 640
  end
  object qKullanici: TUniQuery
    Connection = frmDM.conAsya
    Left = 232
    Top = 640
  end
  object dsKullanici: TUniDataSource
    DataSet = qKullanici
    Left = 264
    Top = 640
  end
  object saMukerrer: TUniSweetAlert
    Title = 'M'#252'kerrer durak'
    Text = 'Bu kay'#305't zaten rotada.'
    ConfirmButtonText = 'Yine de ekle'
    CancelButtonText = 'Yaln'#305'z yeni olanlar'
    AlertType = atQuestion
    Padding = 20
    ShowCancelButton = True
    OnConfirm = saMukerrerConfirm
    OnDismiss = saMukerrerDismiss
    Left = 296
    Top = 640
  end
  object saOnayGorev: TUniSweetAlert
    Title = 'G'#246'rev olu'#351'tur'
    Text = 'Rota onayland'#305'. G'#246'revler olu'#351'turulsun mu?'
    ConfirmButtonText = 'Evet, olu'#351'tur'
    CancelButtonText = 'Hay'#305'r'
    AlertType = atQuestion
    Padding = 20
    ShowCancelButton = True
    OnConfirm = saOnayGorevConfirm
    Left = 328
    Top = 640
  end
end
