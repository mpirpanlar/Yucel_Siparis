object frmCrmMenu: TfrmCrmMenu
  Left = 0
  Top = 0
  ClientHeight = 620
  ClientWidth = 1200
  Caption = 'frmCrmMenu'
  BorderStyle = bsNone
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  TextHeight = 15
  object UniContainerPanel1: TUniContainerPanel
    Left = 0
    Top = 0
    Width = 1200
    Height = 620
    Hint = ''
    Align = alClient
    ParentColor = False
    TabOrder = 0
    Layout = 'hbox'
    LayoutConfig.Padding = '12'
    object UniSimplePanel1: TUniSimplePanel
      Left = 12
      Top = 12
      Width = 380
      Height = 596
      Hint = ''
      ParentColor = False
      TabOrder = 0
      Layout = 'vbox'
      LayoutConfig.Flex = 1
      LayoutConfig.Margin = '0 8 0 0'
      object UniPanel1: TUniPanel
        Left = 0
        Top = 0
        Width = 380
        Height = 28
        Hint = ''
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Palatino Linotype'
        Font.Style = [fsBold]
        TabOrder = 0
        Caption = #304#351'lemler'
        Color = clFirebrick
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '2 2 5 2'
      end
      object btnYeniAktivite: TUniButton
        Left = 0
        Top = 35
        Width = 380
        Height = 38
        Hint = ''
        Caption = 'Yeni Aktivite'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Style = [fsItalic]
        TabOrder = 1
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        ScreenMask.Message = 'L'#252'tfen bekleyiniz...'
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '2 2 2 2'
        OnClick = btnYeniAktiviteClick
      end
      object btnYeniGorev: TUniButton
        Left = 0
        Top = 79
        Width = 380
        Height = 38
        Hint = ''
        Caption = 'Yeni G'#246'rev'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Style = [fsItalic]
        TabOrder = 2
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        ScreenMask.Message = 'L'#252'tfen bekleyiniz...'
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '8 2 2 2'
        OnClick = btnYeniGorevClick
      end
      object btnYeniTeklif: TUniButton
        Left = 0
        Top = 123
        Width = 380
        Height = 38
        Hint = ''
        Caption = 'Yeni Teklif'
        Visible = False
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Style = [fsItalic]
        TabOrder = 3
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        ScreenMask.Message = 'L'#252'tfen bekleyiniz...'
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '8 2 2 2'
        OnClick = btnYeniTeklifClick
      end
      object btnYeniPotansiyel: TUniButton
        Left = 0
        Top = 167
        Width = 380
        Height = 38
        Hint = ''
        Caption = 'Yeni Potansiyel M'#252#351'teri'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Style = [fsItalic]
        TabOrder = 4
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        ScreenMask.Message = 'L'#252'tfen bekleyiniz...'
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '8 2 2 2'
        OnClick = btnYeniPotansiyelClick
      end
      object btnYeniRotaPlan: TUniButton
        Left = 0
        Top = 211
        Width = 380
        Height = 38
        Hint = ''
        Caption = 'Yeni Rota Planlamas'#305
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Style = [fsItalic]
        TabOrder = 5
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        ScreenMask.Message = 'L'#252'tfen bekleyiniz...'
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '8 2 2 2'
        OnClick = btnYeniRotaPlanClick
      end
      object btnSoruSeti: TUniButton
        Left = 0
        Top = 255
        Width = 380
        Height = 38
        Hint = ''
        Caption = 'Kontrol Listesi Tan'#305'mlar'#305
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Style = [fsItalic]
        TabOrder = 6
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        ScreenMask.Message = 'L'#252'tfen bekleyiniz...'
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '8 2 2 2'
        OnClick = btnSoruSetiClick
      end
    end
    object UniSimplePanel2: TUniSimplePanel
      Left = 400
      Top = 12
      Width = 380
      Height = 596
      Hint = ''
      ParentColor = False
      TabOrder = 1
      Layout = 'vbox'
      LayoutConfig.Flex = 1
      LayoutConfig.Margin = '0 8 0 0'
      object UniPanel2: TUniPanel
        Left = 0
        Top = 0
        Width = 380
        Height = 28
        Hint = ''
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Palatino Linotype'
        Font.Style = [fsBold]
        TabOrder = 0
        Caption = 'Listeler'
        Color = clFirebrick
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '2 2 5 2'
      end
      object btnAktiviteListesi: TUniButton
        Left = 0
        Top = 35
        Width = 380
        Height = 38
        Hint = ''
        Caption = 'Aktivite Listesi'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Style = [fsItalic]
        TabOrder = 1
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '2 2 2 2'
        OnClick = btnAktiviteListesiClick
      end
      object btnGorevListesi: TUniButton
        Left = 0
        Top = 79
        Width = 380
        Height = 38
        Hint = ''
        Caption = 'G'#246'rev Listesi'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Style = [fsItalic]
        TabOrder = 2
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '8 2 2 2'
        OnClick = btnGorevListesiClick
      end
      object btnTeklifListesi: TUniButton
        Left = 0
        Top = 123
        Width = 380
        Height = 38
        Hint = ''
        Caption = 'Teklif Listesi'
        Visible = False
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Style = [fsItalic]
        TabOrder = 3
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '8 2 2 2'
        OnClick = btnTeklifListesiClick
      end
      object btnPotansiyelListesi: TUniButton
        Left = 0
        Top = 167
        Width = 380
        Height = 38
        Hint = ''
        Caption = 'Potansiyel M'#252#351'teri Listesi'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Style = [fsItalic]
        TabOrder = 4
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '8 2 2 2'
        OnClick = btnPotansiyelListesiClick
      end
      object btnTanimliRota: TUniButton
        Left = 0
        Top = 211
        Width = 380
        Height = 38
        Hint = ''
        Caption = 'Tan'#305'ml'#305' Rota Planlamalar'#305
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Style = [fsItalic]
        TabOrder = 5
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        ScreenMask.Message = 'L'#252'tfen bekleyiniz...'
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '8 2 2 2'
        OnClick = btnTanimliRotaClick
      end
      object btnCariGpsListe: TUniButton
        Left = 0
        Top = 255
        Width = 380
        Height = 38
        Hint = ''
        Caption = 'Netsis Cari GPS'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Style = [fsItalic]
        TabOrder = 6
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        ScreenMask.Message = 'L'#252'tfen bekleyiniz...'
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '8 2 2 2'
        OnClick = btnCariGpsListeClick
      end
    end
    object UniSimplePanel3: TUniSimplePanel
      Left = 788
      Top = 12
      Width = 400
      Height = 596
      Hint = ''
      ParentColor = False
      TabOrder = 2
      Layout = 'vbox'
      LayoutConfig.Flex = 1
      object UniPanel3: TUniPanel
        Left = 0
        Top = 0
        Width = 400
        Height = 28
        Hint = ''
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Palatino Linotype'
        Font.Style = [fsBold]
        TabOrder = 0
        Caption = 'Raporlar'
        Color = clFirebrick
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '2 2 5 2'
      end
      object btnCariOzet: TUniButton
        Left = 0
        Top = 35
        Width = 400
        Height = 38
        Hint = ''
        Caption = 'Cari CRM '#214'zeti'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Style = [fsItalic]
        TabOrder = 1
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        ScreenMask.Message = 'L'#252'tfen bekleyiniz...'
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '2 2 2 2'
        OnClick = btnCariOzetClick
      end
      object btnKontrolRapor: TUniButton
        Left = 0
        Top = 79
        Width = 400
        Height = 38
        Hint = ''
        Caption = 'Kontrol Listesi Raporu'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Style = [fsItalic]
        TabOrder = 2
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        ScreenMask.Message = 'L'#252'tfen bekleyiniz...'
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '8 2 2 2'
        OnClick = btnKontrolRaporClick
      end
      object btnTakvim: TUniButton
        Left = 0
        Top = 123
        Width = 400
        Height = 38
        Hint = ''
        Caption = 'CRM Takvimi'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Style = [fsItalic]
        TabOrder = 3
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        ScreenMask.Message = 'L'#252'tfen bekleyiniz...'
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '8 2 2 2'
        OnClick = btnTakvimClick
      end
      object btnAktiviteRapor: TUniButton
        Left = 0
        Top = 167
        Width = 400
        Height = 38
        Hint = ''
        Caption = 'Aktivite Durum Raporu'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Style = [fsItalic]
        TabOrder = 4
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        ScreenMask.Message = 'L'#252'tfen bekleyiniz...'
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '8 2 2 2'
        OnClick = btnAktiviteRaporClick
      end
      object btnAktiviteTarihce: TUniButton
        Left = 0
        Top = 211
        Width = 400
        Height = 38
        Hint = ''
        Caption = 'Aktivite / G'#246'rev Tarih'#231'esi'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Style = [fsItalic]
        TabOrder = 5
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        ScreenMask.Message = 'L'#252'tfen bekleyiniz...'
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '8 2 2 2'
        OnClick = btnAktiviteTarihceClick
      end
      object btnRotaKmRapor: TUniButton
        Left = 0
        Top = 255
        Width = 400
        Height = 38
        Hint = ''
        Caption = 'Rota Km Raporu'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Style = [fsItalic]
        TabOrder = 6
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        ScreenMask.Message = 'L'#252'tfen bekleyiniz...'
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '8 2 2 2'
        OnClick = btnRotaKmRaporClick
      end
    end
  end
end
