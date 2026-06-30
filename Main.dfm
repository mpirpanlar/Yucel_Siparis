object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 634
  ClientWidth = 1069
  Caption = 'Asya Entegre - Mobil '#304#351'lemler'
  OnShow = UniFormShow
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  TextHeight = 15
  object NavPage: TUniPageControl
    Left = 0
    Top = 45
    Width = 1069
    Height = 567
    Hint = ''
    ActivePage = tabMenu
    Align = alClient
    TabOrder = 0
    object tabMenu: TUniTabSheet
      Hint = ''
      Caption = 'Ana Menu'
      object UniSimplePanel2: TUniSimplePanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 250
        Height = 533
        Hint = ''
        ParentColor = False
        Color = clWhite
        Align = alLeft
        AlignmentControl = uniAlignmentClient
        ParentAlignmentControl = False
        TabOrder = 0
        Layout = 'vbox'
        object UniSimplePanel4: TUniSimplePanel
          Left = 3
          Top = 40
          Width = 500
          Height = 95
          Hint = ''
          ParentColor = False
          Color = clWhite
          TabOrder = 1
          Layout = 'hbox'
          LayoutConfig.Width = '100%'
          LayoutConfig.Margin = '4 0 0 4'
          object btnSiparis: TUniBitBtn
            Left = 3
            Top = 3
            Width = 126
            Height = 67
            Hint = ''
            Caption = 'Sipari'#351'ler'
            ParentFont = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWhite
            Font.Height = -15
            Font.Style = [fsItalic]
            TabOrder = 1
            ClientEvents.UniEvents.Strings = (
              
                'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'  config.cls=' +
                '"btnMenu";'#13#10'}')
            IconAlign = iaBottom
            IconPosition = ipButtonEdge
            ImageIndex = 3
            LayoutConfig.Height = '100%'
            LayoutConfig.Width = '100%'
            LayoutConfig.Margin = '2 2 2 2'
            OnClick = btnSiparisClick
          end
        end
        object UniSimplePanelCRM: TUniSimplePanel
          Left = 3
          Top = 102
          Width = 500
          Height = 95
          Hint = ''
          ParentColor = False
          Color = clWhite
          TabOrder = 2
          Layout = 'hbox'
          LayoutConfig.Width = '100%'
          LayoutConfig.Margin = '15 0 0 4'
          object btnCRM: TUniBitBtn
            Left = 3
            Top = 3
            Width = 126
            Height = 67
            Hint = ''
            Caption = 'CRM'
            ParentFont = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWhite
            Font.Height = -15
            Font.Style = [fsItalic]
            TabOrder = 1
            ClientEvents.UniEvents.Strings = (
              
                'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'  config.cls=' +
                '"btnMenu";'#13#10'}')
            IconAlign = iaBottom
            IconPosition = ipButtonEdge
            ImageIndex = 4
            LayoutConfig.Height = '100%'
            LayoutConfig.Width = '100%'
            LayoutConfig.Margin = '2 2 2 2'
            OnClick = btnCRMClick
          end
        end
        object UniSimplePanel1: TUniSimplePanel
          Left = 3
          Top = 165
          Width = 500
          Height = 95
          Hint = ''
          ParentColor = False
          Color = clWhite
          TabOrder = 3
          Layout = 'hbox'
          LayoutConfig.Width = '100%'
          LayoutConfig.Margin = '15 0 0 4'
          object UniBitBtn10: TUniBitBtn
            Left = 3
            Top = 3
            Width = 126
            Height = 67
            Hint = ''
            Caption = 'Parametreler'
            ParentFont = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWhite
            Font.Height = -15
            Font.Style = [fsItalic]
            TabOrder = 1
            ClientEvents.UniEvents.Strings = (
              
                'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'  config.cls=' +
                '"btnMenu";'#13#10'}')
            IconAlign = iaBottom
            IconPosition = ipButtonEdge
            ImageIndex = 5
            LayoutConfig.Height = '100%'
            LayoutConfig.Width = '100%'
            LayoutConfig.Margin = '2 2 2 2'
            OnClick = UniBitBtn10Click
          end
        end
      end
      object pnlMenu: TUniSimplePanel
        AlignWithMargins = True
        Left = 259
        Top = 3
        Width = 799
        Height = 533
        Hint = ''
        ParentColor = False
        Color = clWhite
        Align = alClient
        AlignmentControl = uniAlignmentClient
        ParentAlignmentControl = False
        TabOrder = 1
        Layout = 'fit'
      end
    end
  end
  object UniPanel1: TUniPanel
    Left = 0
    Top = 0
    Width = 1069
    Height = 45
    Hint = ''
    Align = alTop
    TabOrder = 1
    BorderStyle = ubsNone
    Caption = ''
    Color = 3345606
    ParentAlignmentControl = False
    object lbFirma: TUniLabel
      AlignWithMargins = True
      Left = 520
      Top = 5
      Width = 434
      Height = 37
      Hint = ''
      Margins.Top = 5
      AutoSize = False
      Caption = 'Y'#220'CEL KOMPOZ'#304'T Mlz. Paz. ve Tic. A.'#350'.'
      Align = alRight
      ParentFont = False
      Font.Charset = TURKISH_CHARSET
      Font.Color = clWhite
      Font.Height = -20
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      TabOrder = 1
      LayoutConfig.Margin = '2 0 0 0'
    end
    object UniImage1: TUniImage
      Left = 0
      Top = 0
      Width = 180
      Height = 45
      Hint = ''
      Center = True
      Stretch = True
      Proportional = True
      Url = '/images/HayatYazilim.png'
      Align = alLeft
      LayoutConfig.Height = '100%'
      LayoutConfig.Margin = '2 4 2 8'
    end
    object lblKullanici: TUniLabel
      AlignWithMargins = True
      Left = 960
      Top = 5
      Width = 106
      Height = 37
      Hint = ''
      Margins.Top = 5
      AutoSize = False
      Caption = ''
      Align = alRight
      ParentFont = False
      Font.Charset = TURKISH_CHARSET
      Font.Color = clWhite
      Font.Height = -20
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold, fsItalic]
      TabOrder = 3
      LayoutConfig.Margin = '2 0 0 0'
    end
  end
  object UniStatusBar1: TUniStatusBar
    Left = 0
    Top = 612
    Width = 1069
    Hint = ''
    Panels = <
      item
        Alignment = taCenter
        Text = '1.1.1'
        Width = 50
      end
      item
        Alignment = taCenter
        Text = '1'
        Width = 20
      end
      item
        Width = 100
      end
      item
        Width = 200
      end>
    SizeGrip = False
    Align = alBottom
    ParentColor = False
    Color = 5723991
  end
  object alButonlar: TActionList
    Left = 600
    Top = 488
    object acCariKart: TAction
      Caption = 'acCariKart'
    end
    object acStokKart: TAction
      Caption = 'acStokKart'
    end
    object acCariGrup: TAction
      Caption = 'acCariGrup'
    end
    object acStokGrup: TAction
      Caption = 'acStokGrup'
    end
    object acStokAltGrup: TAction
      Caption = 'acStokAltGrup'
    end
    object acStokMarka: TAction
      Caption = 'acStokMarka'
    end
    object acSatisFaturasi: TAction
      Caption = 'acSatisFaturasi'
    end
    object acCariListesi: TAction
      Caption = 'acCariListesi'
    end
    object acFaturaListesi: TAction
      Caption = 'acFaturaListesi'
    end
    object acAlisFaturasi: TAction
      Caption = 'acAlisFaturasi'
    end
    object acAlisFaturasiIade: TAction
      Caption = 'acAlisFaturasiIade'
    end
    object acSatisFaturasiIade: TAction
      Caption = 'acSatisFaturasiIade'
    end
    object acNakitTahsilat: TAction
      Caption = 'acNakitTahsilat'
    end
    object acGelenHavale: TAction
      Caption = 'acGelenHavale'
    end
    object acNakitOdeme: TAction
      Caption = 'acNakitOdeme'
    end
    object acGidenHavale: TAction
      Caption = 'acGidenHavale'
    end
    object acBorcDekont: TAction
      Caption = 'acBorcDekont'
    end
    object acAlacakDekont: TAction
      Caption = 'acAlacakDekont'
    end
    object acCariVirman: TAction
      Caption = 'acCariVirman'
    end
    object acStokListesi: TAction
      Caption = 'acStokListesi'
    end
    object acKasaKart: TAction
      Caption = 'acKasaKart'
    end
    object acBankaKart: TAction
      Caption = 'acBankaKart'
    end
    object acKasaBankaListesi: TAction
      Caption = 'acKasaBankaListesi'
    end
    object acKasaBankaVirman: TAction
      Caption = 'acKasaBankaVirman'
    end
    object acHizmetKarti: TAction
      Caption = 'acHizmetKarti'
    end
    object acGider: TAction
      Caption = 'acGider'
    end
    object acGiderHareketleri: TAction
      Caption = 'acGiderHareketleri'
    end
    object acGiderKarti: TAction
      Caption = 'acGiderKarti'
    end
    object acGiderListesi: TAction
      Caption = 'acGiderListesi'
    end
    object acGelir: TAction
      Caption = 'acGelir'
    end
    object acStokGiris: TAction
      Caption = 'acStokGiris'
    end
    object acStokCikis: TAction
      Caption = 'acStokCikis'
    end
    object acHizmetListesi: TAction
      Caption = 'acHizmetListesi'
    end
    object acTumStokHareketleri: TAction
      Caption = 'acTumStokHareketleri'
    end
    object acEFaturaGonder: TAction
      Caption = 'acEFaturaGonder'
    end
    object acEFaturaListesi: TAction
      Caption = 'acEFaturaListesi'
    end
    object acStokBirim: TAction
      Caption = 'acStokBirim'
    end
    object acKasaBankaHareket: TAction
      Caption = 'acKasaBankaHareket'
    end
    object acStokModelKart: TAction
      Caption = 'acStokModelKart'
    end
    object acStokRenkKart: TAction
      Caption = 'acStokRenkKart'
    end
    object acStokAstarKart: TAction
      Caption = 'acStokAstarKart'
    end
    object acStokYuzeyKart: TAction
      Caption = 'acStokYuzeyKart'
    end
    object acStokKenarbandKart: TAction
      Caption = 'acStokKenarbandKart'
    end
    object acKasaGiris: TAction
      Caption = 'acKasaGiris'
    end
    object acKasaCikis: TAction
      Caption = 'acKasaCikis'
    end
    object acStokHareket: TAction
      Caption = 'acStokHareket'
    end
    object acSatisSiparisLake: TAction
      Caption = 'acSatisSiparisLake'
    end
  end
  object UniQuery1: TUniQuery
    Connection = frmDM.conNetsis
    Left = 528
    Top = 320
  end
end
