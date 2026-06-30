object frmCrmKontrolRapor: TfrmCrmKontrolRapor
  Left = 0
  Top = 0
  ClientHeight = 640
  ClientWidth = 1010
  Caption = 'CRM - Kontrol Listesi Raporu'
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
    Width = 1010
    Height = 640
    Hint = ''
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    Layout = 'vbox'
    object panTop: TUniPanel
      Left = 0
      Top = 0
      Width = 1010
      Height = 88
      Hint = ''
      TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      LayoutConfig.Width = '100%'
      object lblTip: TUniLabel
        Left = 12
        Top = 12
        Width = 80
        Height = 13
        Hint = ''
        Caption = 'Aktivite Tipi'
        TabOrder = 0
      end
      object lkTip: TUniDBLookupComboBox
        Left = 12
        Top = 30
        Width = 320
        Height = 24
        Hint = ''
        ListField = 'AD'
        ListSource = dsTipLkp
        KeyField = 'TIP_ID'
        ListFieldIndex = 0
        TabOrder = 1
        Color = clWindow
      end
      object lblSet: TUniLabel
        Left = 348
        Top = 12
        Width = 80
        Height = 13
        Hint = ''
        Caption = 'Soru Seti'
        TabOrder = 2
      end
      object lkSet: TUniDBLookupComboBox
        Left = 348
        Top = 30
        Width = 320
        Height = 24
        Hint = ''
        ListField = 'AD'
        ListSource = dsSetLkp
        KeyField = 'SET_ID'
        ListFieldIndex = 0
        TabOrder = 3
        Color = clWindow
      end
      object lblBas: TUniLabel
        Left = 684
        Top = 12
        Width = 80
        Height = 13
        Hint = ''
        Caption = 'Ba'#351'lang'#305#231
        TabOrder = 4
      end
      object dtBas: TUniDateTimePicker
        Left = 684
        Top = 30
        Width = 130
        Height = 24
        Hint = ''
        DateTime = 46109.000000000000000000
        DateFormat = 'dd/MM/yyyy'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 5
        DisabledDates = <>
      end
      object lblBit: TUniLabel
        Left = 824
        Top = 12
        Width = 40
        Height = 13
        Hint = ''
        Caption = 'Biti'#351
        TabOrder = 6
      end
      object dtBit: TUniDateTimePicker
        Left = 824
        Top = 30
        Width = 130
        Height = 24
        Hint = ''
        DateTime = 46109.000000000000000000
        DateFormat = 'dd/MM/yyyy'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 7
        DisabledDates = <>
      end
      object btnGetir: TUniButton
        Left = 12
        Top = 58
        Width = 120
        Height = 26
        Hint = ''
        Caption = 'Raporu Getir'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 8
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
        OnClick = btnGetirClick
      end
      object btnKapat: TUniButton
        Left = 910
        Top = 0
        Width = 100
        Height = 88
        Hint = ''
        Caption = 'Kapat'
        Align = alRight
        TabOrder = 9
        OnClick = btnKapatClick
      end
    end
    object pgc: TUniPageControl
      Left = 0
      Top = 88
      Width = 1010
      Height = 552
      Hint = ''
      ActivePage = tsDetay
      TabOrder = 1
      LayoutConfig.Flex = 1
      LayoutConfig.Height = '100%'
      LayoutConfig.Width = '100%'
      object tsDetay: TUniTabSheet
        Hint = ''
        Caption = 'Detay'
        Layout = 'fit'
        object grdDetay: TUniDBGrid
          Left = 0
          Top = 0
          Width = 1002
          Height = 524
          Hint = ''
          DataSource = dsDetay
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgTabs, dgCancelOnExit]
          ReadOnly = True
          WebOptions.Paged = False
          WebOptions.FetchAll = True
          LoadMask.Message = 'Loading data...'
          LayoutConfig.Flex = 1
          LayoutConfig.Height = '100%'
          LayoutConfig.Width = '100%'
          ClientEvents.UniEvents.Strings = (
            
              'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'  config.force' +
              'Fit = true;'#13#10'}')
          TabOrder = 0
        end
      end
      object tsOzet: TUniTabSheet
        Hint = ''
        Caption = #214'zet'
        Layout = 'fit'
        object grdOzet: TUniDBGrid
          Left = 0
          Top = 0
          Width = 1002
          Height = 524
          Hint = ''
          DataSource = dsOzet
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgTabs, dgCancelOnExit]
          ReadOnly = True
          WebOptions.Paged = False
          WebOptions.FetchAll = True
          LoadMask.Message = 'Loading data...'
          LayoutConfig.Flex = 1
          LayoutConfig.Height = '100%'
          LayoutConfig.Width = '100%'
          ClientEvents.UniEvents.Strings = (
            
              'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'  config.force' +
              'Fit = true;'#13#10'}')
          TabOrder = 0
        end
      end
    end
  end
  object qTipLkp: TUniQuery
    Connection = frmDM.conAsya
    Left = 720
    Top = 120
  end
  object dsTipLkp: TUniDataSource
    DataSet = qTipLkp
    Left = 752
    Top = 120
  end
  object qSetLkp: TUniQuery
    Connection = frmDM.conAsya
    Left = 720
    Top = 160
  end
  object dsSetLkp: TUniDataSource
    DataSet = qSetLkp
    Left = 752
    Top = 160
  end
  object qDetay: TUniQuery
    Connection = frmDM.conAsya
    Left = 720
    Top = 200
  end
  object dsDetay: TUniDataSource
    DataSet = qDetay
    Left = 752
    Top = 200
  end
  object qOzet: TUniQuery
    Connection = frmDM.conAsya
    Left = 720
    Top = 240
  end
  object dsOzet: TUniDataSource
    DataSet = qOzet
    Left = 752
    Top = 240
  end
end
