object frmCrmMenu: TfrmCrmMenu
  Left = 0
  Top = 0
  ClientHeight = 659
  ClientWidth = 1026
  Caption = 'frmCrmMenu'
  BorderStyle = bsNone
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  PixelsPerInch = 96
  TextHeight = 13
  object UniContainerPanel1: TUniContainerPanel
    Left = 18
    Top = 19
    Width = 952
    Height = 593
    Hint = ''
    ParentColor = False
    TabOrder = 0
    Layout = 'hbox'
    object UniSimplePanel1: TUniSimplePanel
      Left = 16
      Top = 24
      Width = 256
      Height = 553
      Hint = ''
      ParentColor = False
      TabOrder = 1
      Layout = 'vbox'
      object UniPanel1: TUniPanel
        Left = 16
        Top = 16
        Width = 193
        Height = 28
        Hint = ''
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Palatino Linotype'
        Font.Style = [fsBold, fsItalic]
        TabOrder = 2
        Caption = #304#351'lemler'
        Color = 2237106
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '2 2 5 2'
      end
      object btnYeniAktivite: TUniButton
        Left = 16
        Top = 51
        Width = 193
        Height = 38
        Hint = ''
        Caption = 'Yeni Aktivite'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Segoe UI'
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
        Left = 16
        Top = 95
        Width = 193
        Height = 38
        Hint = ''
        Caption = 'Yeni G'#246'rev'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsItalic]
        TabOrder = 3
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        ScreenMask.Message = 'L'#252'tfen bekleyiniz...'
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '11 2 2 2'
        OnClick = btnYeniGorevClick
      end
      object btnYeniTeklif: TUniButton
        Left = 16
        Top = 139
        Width = 193
        Height = 38
        Hint = ''
        Caption = 'Yeni Teklif'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsItalic]
        TabOrder = 4
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        ScreenMask.Message = 'L'#252'tfen bekleyiniz...'
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '11 2 2 2'
        OnClick = btnYeniTeklifClick
      end
    end
    object UniSimplePanel2: TUniSimplePanel
      Left = 296
      Top = 24
      Width = 256
      Height = 553
      Hint = ''
      ParentColor = False
      TabOrder = 2
      Layout = 'vbox'
      object UniPanel2: TUniPanel
        Left = 16
        Top = 16
        Width = 193
        Height = 28
        Hint = ''
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Palatino Linotype'
        Font.Style = [fsBold, fsItalic]
        TabOrder = 2
        Caption = 'Raporlar'
        Color = 2237106
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '2 2 5 2'
      end
      object btnAktiviteListesi: TUniButton
        Left = 16
        Top = 50
        Width = 193
        Height = 38
        Hint = ''
        Caption = 'Aktivite Listesi'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Segoe UI'
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
        Left = 16
        Top = 95
        Width = 193
        Height = 38
        Hint = ''
        Caption = 'G'#246'rev Listesi'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsItalic]
        TabOrder = 3
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '11 2 2 2'
        OnClick = btnGorevListesiClick
      end
      object btnTeklifListesi: TUniButton
        Left = 16
        Top = 139
        Width = 193
        Height = 38
        Hint = ''
        Caption = 'Teklif Listesi'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsItalic]
        TabOrder = 4
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '11 2 2 2'
        OnClick = btnTeklifListesiClick
      end
      object btnCariOzet: TUniButton
        Left = 16
        Top = 188
        Width = 193
        Height = 38
        Hint = ''
        Caption = 'Cari CRM '#214'zeti'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsItalic]
        TabOrder = 5
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        ScreenMask.Message = 'L'#252'tfen bekleyiniz...'
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '11 2 2 2'
        OnClick = btnCariOzetClick
      end
    end
  end
end
