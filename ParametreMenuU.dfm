object frmParametreMenu: TfrmParametreMenu
  Left = 0
  Top = 0
  ClientHeight = 644
  ClientWidth = 940
  Caption = 'frmParametreMenu'
  BorderStyle = bsNone
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  PixelsPerInch = 96
  TextHeight = 13
  object UniContainerPanel1: TUniContainerPanel
    Left = 24
    Top = 24
    Width = 881
    Height = 601
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
        TabOrder = 3
        Caption = #304#351'lemler'
        Color = 2237106
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '2 2 5 2'
      end
      object UniButton1: TUniButton
        Left = 16
        Top = 51
        Width = 193
        Height = 30
        Hint = ''
        Caption = 'Kullan'#305'c'#305'lar'
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
        OnClick = UniButton1Click
      end
      object UniButton2: TUniButton
        Left = 16
        Top = 87
        Width = 193
        Height = 30
        Hint = ''
        Caption = 'Kullan'#305'c'#305' Grup ve Yetkiler'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsItalic]
        TabOrder = 2
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '2 2 2 2'
        OnClick = UniButton2Click
      end
      object UniButton4: TUniButton
        Left = 16
        Top = 123
        Width = 193
        Height = 30
        Hint = ''
        Caption = 'Parametreler'
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
        LayoutConfig.Margin = '2 2 2 2'
        OnClick = UniButton4Click
      end
      object UniButton7: TUniButton
        Left = 16
        Top = 159
        Width = 193
        Height = 30
        Hint = ''
        Visible = False
        Caption = 'E-Fatura Tan'#305'mlar'#305
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
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '2 2 2 2'
        OnClick = UniButton7Click
      end
      object UniButton8: TUniButton
        Left = 16
        Top = 207
        Width = 193
        Height = 30
        Hint = ''
        Visible = False
        Caption = 'Sipari'#351' Bayi Tan'#305'mlar'#305
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsItalic]
        TabOrder = 6
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '2 2 2 2'
        OnClick = UniButton8Click
      end
      object UniButton9: TUniButton
        Left = 16
        Top = 255
        Width = 193
        Height = 30
        Hint = ''
        Visible = False
        Caption = 'Sat'#305#351' Bayileri'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsItalic]
        TabOrder = 7
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '2 2 2 2'
        OnClick = UniButton9Click
      end
      object UniButton10: TUniButton
        Left = 16
        Top = 303
        Width = 193
        Height = 30
        Hint = ''
        Visible = False
        Caption = 'Kurlar'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsItalic]
        TabOrder = 8
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '2 2 2 2'
        OnClick = UniButton10Click
      end
      object UniButton11: TUniButton
        Left = 16
        Top = 351
        Width = 193
        Height = 30
        Hint = ''
        Caption = 'CRM - Aktivite Tipleri'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsItalic]
        TabOrder = 9
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '2 2 2 2'
        OnClick = UniButton11Click
      end
      object UniButton12: TUniButton
        Left = 16
        Top = 387
        Width = 193
        Height = 30
        Hint = ''
        Caption = 'CRM - Aktivite Durumlar'#305
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsItalic]
        TabOrder = 10
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '2 2 2 2'
        OnClick = UniButton12Click
      end
      object UniButton13: TUniButton
        Left = 16
        Top = 423
        Width = 193
        Height = 30
        Hint = ''
        Caption = 'CRM - Teklif Durumlar'#305
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsItalic]
        TabOrder = 11
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '2 2 2 2'
        OnClick = UniButton13Click
      end
    end
    object UniSimplePanel2: TUniSimplePanel
      Left = 296
      Top = 24
      Width = 256
      Height = 553
      Hint = ''
      Visible = False
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
      object UniButton3: TUniButton
        Left = 16
        Top = 51
        Width = 193
        Height = 30
        Hint = ''
        Caption = 'Fatura Listesi'
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
      end
    end
    object UniSimplePanel3: TUniSimplePanel
      Left = 584
      Top = 24
      Width = 256
      Height = 553
      Hint = ''
      Visible = False
      ParentColor = False
      TabOrder = 3
      Layout = 'vbox'
      object UniPanel3: TUniPanel
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
        TabOrder = 3
        Caption = 'E-Fatura / E-Ar'#351'iv'
        Color = 2237106
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '2 2 5 2'
      end
      object UniButton5: TUniButton
        Left = 16
        Top = 51
        Width = 193
        Height = 30
        Hint = ''
        Caption = 'E-Fatura / E-Ar'#351'iv G'#246'nder'
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
      end
      object UniButton6: TUniButton
        Left = 16
        Top = 87
        Width = 193
        Height = 30
        Hint = ''
        Caption = 'E-Fatura / E-Ar'#351'iv Listesi'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = [fsItalic]
        TabOrder = 2
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.cl' +
            's="btnAltMenu";'#13#10'}')
        ScreenMask.Enabled = True
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '2 2 2 2'
      end
    end
  end
end
