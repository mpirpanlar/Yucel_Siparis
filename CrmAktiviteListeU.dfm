object frmCrmAktiviteListe: TfrmCrmAktiviteListe
  Left = 0
  Top = 0
  ClientHeight = 600
  ClientWidth = 980
  Caption = 'CRM - Aktivite Listesi'
  OnShow = UniFormShow
  BorderStyle = bsNone
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  OnDestroy = UniFormDestroy
  TextHeight = 15
  object rootPanel: TUniPanel
    Left = 0
    Top = 0
    Width = 980
    Height = 600
    Hint = ''
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    Layout = 'vbox'
    object pnlToolbar: TUniPanel
      Left = 0
      Top = 0
      Width = 980
      Height = 48
      Hint = ''
      TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      Color = 10865101
      LayoutConfig.Width = '100%'
      object btnListele: TUniButton
        Left = 12
        Top = 8
        Width = 110
        Height = 32
        Hint = ''
        Caption = 'Listele'
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
        OnClick = btnListeleClick
      end
      object btnAc: TUniButton
        Left = 132
        Top = 8
        Width = 140
        Height = 32
        Hint = ''
        Caption = 'Kayd'#305' A'#231
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 1
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'secondary'#39';'#13#10'}')
        OnClick = btnAcClick
      end
      object btnKapat: TUniButton
        Left = 880
        Top = 0
        Width = 100
        Height = 48
        Hint = ''
        Caption = 'Kapat'
        Align = alRight
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
        OnClick = btnKapatClick
      end
    end
    object panFilt: TUniPanel
      Left = 0
      Top = 48
      Width = 980
      Height = 96
      Hint = ''
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      LayoutConfig.Width = '100%'
      object lblFiltTip: TUniLabel
        Left = 8
        Top = 10
        Width = 15
        Height = 13
        Hint = ''
        Caption = 'Tip'
        TabOrder = 0
      end
      object ccTip: TUniComboBox
        Left = 36
        Top = 6
        Width = 150
        Height = 27
        Hint = 'Birden fazla tip se'#231'ilebilir'
        Style = csDropDownList
        Text = ''
        TabOrder = 1
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'  config.mult' +
            'iSelect = true;'#13#10'  config.queryMode = '#39'local'#39';'#13#10'  config.forceSe' +
            'lection = true;'#13#10'}')
        IconItems = <>
      end
      object lblFiltDurum: TUniLabel
        Left = 196
        Top = 10
        Width = 35
        Height = 13
        Hint = ''
        Caption = 'Durum'
        TabOrder = 2
      end
      object ccDurum: TUniComboBox
        Left = 240
        Top = 6
        Width = 150
        Height = 27
        Hint = 'Birden fazla durum se'#231'ilebilir'
        Style = csDropDownList
        Text = ''
        TabOrder = 3
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'  config.mult' +
            'iSelect = true;'#13#10'  config.queryMode = '#39'local'#39';'#13#10'  config.forceSe' +
            'lection = true;'#13#10'}')
        IconItems = <>
      end
      object lblFiltOnc: TUniLabel
        Left = 400
        Top = 10
        Width = 39
        Height = 13
        Hint = ''
        Caption = #214'ncelik'
        TabOrder = 4
      end
      object ccOncelik: TUniComboBox
        Left = 448
        Top = 6
        Width = 130
        Height = 27
        Hint = 'Birden fazla '#246'ncelik se'#231'ilebilir'
        Style = csDropDownList
        Text = ''
        TabOrder = 5
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'  config.mult' +
            'iSelect = true;'#13#10'  config.queryMode = '#39'local'#39';'#13#10'  config.forceSe' +
            'lection = true;'#13#10'}')
        IconItems = <>
      end
      object chkTarih: TUniCheckBox
        Left = 8
        Top = 46
        Width = 100
        Height = 22
        Hint = ''
        Checked = True
        Caption = 'Tarih Filtresi'
        TabOrder = 6
      end
      object lblFiltTarBas: TUniLabel
        Left = 112
        Top = 48
        Width = 49
        Height = 13
        Hint = ''
        Caption = 'Ba'#351'lang'#305#231
        TabOrder = 7
      end
      object dtFiltBas: TUniDateTimePicker
        Left = 176
        Top = 44
        Width = 110
        Height = 27
        Hint = ''
        DateTime = 45658.000000000000000000
        DateFormat = 'dd/MM/yyyy'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 8
        DisabledDates = <>
      end
      object lblFiltTarBit: TUniLabel
        Left = 294
        Top = 48
        Width = 22
        Height = 13
        Hint = ''
        Caption = 'Biti'#351
        TabOrder = 9
      end
      object dtFiltBit: TUniDateTimePicker
        Left = 324
        Top = 44
        Width = 110
        Height = 27
        Hint = ''
        DateTime = 45658.000000000000000000
        DateFormat = 'dd/MM/yyyy'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 10
        DisabledDates = <>
      end
      object lblFiltCari: TUniLabel
        Left = 448
        Top = 48
        Width = 20
        Height = 13
        Hint = ''
        Caption = 'Cari'
        TabOrder = 11
      end
      object edFiltCari: TUniEdit
        Left = 480
        Top = 44
        Width = 72
        Height = 27
        Hint = 'Cari kod veya unvan (opsiyonel)'
        Text = ''
        TabOrder = 12
      end
      object lblFiltCariUnvan: TUniLabel
        Left = 556
        Top = 48
        Width = 3
        Height = 13
        Hint = ''
        Caption = ''
        TabOrder = 13
      end
      object btnCariBul: TUniButton
        Left = 680
        Top = 42
        Width = 36
        Height = 28
        Hint = 'Netsis cari se'#231
        Caption = '...'
        TabOrder = 14
        OnClick = btnCariBulClick
      end
      object lblFiltPot: TUniLabel
        Left = 724
        Top = 48
        Width = 52
        Height = 13
        Hint = ''
        Caption = 'Potansiyel'
        TabOrder = 15
      end
      object edFiltPotId: TUniEdit
        Left = 788
        Top = 44
        Width = 48
        Height = 27
        Hint = ''
        Visible = False
        Text = ''
        TabOrder = 16
      end
      object lblFiltPotUnvan: TUniLabel
        Left = 788
        Top = 48
        Width = 3
        Height = 13
        Hint = ''
        Caption = ''
        TabOrder = 17
      end
      object btnPotBul: TUniButton
        Left = 936
        Top = 42
        Width = 36
        Height = 28
        Hint = 'Potansiyel m'#252#351'teri se'#231
        Caption = '...'
        TabOrder = 18
        OnClick = btnPotBulClick
      end
    end
    object grd: TUniDBGrid
      Left = 0
      Top = 144
      Width = 980
      Height = 456
      Hint = ''
      DataSource = dsList
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
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
      TabOrder = 2
      OnAjaxEvent = grdAjaxEvent
      Columns = <
        item
          FieldName = 'AKTIVITE_ID'
          Title.Caption = 'ID'
          Width = 55
          ReadOnly = True
        end
        item
          FieldName = 'TIP_AD'
          Title.Caption = 'Tip'
          Width = 90
          ReadOnly = True
        end
        item
          FieldName = 'KONU'
          Title.Caption = 'Konu'
          Width = 220
          ReadOnly = True
        end
        item
          FieldName = 'CARI_KOD'
          Title.Caption = 'Cari Kod'
          Width = 80
          ReadOnly = True
        end
        item
          FieldName = 'CARI_ISIM'
          Title.Caption = 'Cari '#220'nvan'
          Width = 160
          ReadOnly = True
        end
        item
          FieldName = 'POT_UNVAN'
          Title.Caption = 'Potansiyel'
          Width = 140
          ReadOnly = True
        end
        item
          FieldName = 'TEKLIF_NO'
          Title.Caption = 'Teklif No'
          Width = 90
          ReadOnly = True
        end
        item
          FieldName = 'SIPARIS_NO'
          Title.Caption = 'Sipari'#351' No'
          Width = 85
          ReadOnly = True
        end
        item
          FieldName = 'AKTIVITE_TARIHI'
          Title.Caption = 'Tarih'
          Width = 115
          ReadOnly = True
        end
        item
          FieldName = 'DURUM_AD'
          Title.Caption = 'Durum'
          Width = 90
          ReadOnly = True
        end
        item
          FieldName = 'ONCELIK'
          Title.Caption = #214'ncelik'
          Width = 70
          ReadOnly = True
        end>
    end
  end
  object qList: TUniQuery
    Connection = frmDM.conAsya
    Left = 880
    Top = 360
  end
  object dsList: TUniDataSource
    DataSet = qList
    Left = 912
    Top = 360
  end
  object qFilt: TUniQuery
    Connection = frmDM.conAsya
    Left = 848
    Top = 360
  end
end
