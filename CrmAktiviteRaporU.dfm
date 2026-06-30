object frmCrmAktiviteRapor: TfrmCrmAktiviteRapor
  Left = 0
  Top = 0
  ClientHeight = 680
  ClientWidth = 1100
  Caption = 'CRM - Aktivite Durum Raporu'
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
    Width = 1100
    Height = 680
    Hint = ''
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    Layout = 'vbox'
    object panTop: TUniPanel
      Left = 0
      Top = 0
      Width = 1100
      Height = 110
      Hint = ''
      TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      LayoutConfig.Width = '100%'
      object lblTarihTur: TUniLabel
        Left = 12
        Top = 8
        Width = 55
        Height = 13
        Hint = ''
        Caption = 'Tarih T'#252'r'#252
        TabOrder = 0
      end
      object cbTarihTur: TUniComboBox
        Left = 12
        Top = 26
        Width = 140
        Height = 24
        Hint = ''
        Style = csDropDownList
        TabOrder = 1
      end
      object lblBas: TUniLabel
        Left = 162
        Top = 8
        Width = 55
        Height = 13
        Hint = ''
        Caption = 'Ba'#351'lang'#305#231
        TabOrder = 2
      end
      object dtBas: TUniDateTimePicker
        Left = 162
        Top = 26
        Width = 110
        Height = 24
        Hint = ''
        DateTime = 46109.000000000000000000
        DateFormat = 'dd/MM/yyyy'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 3
        DisabledDates = <>
      end
      object lblBit: TUniLabel
        Left = 282
        Top = 8
        Width = 22
        Height = 13
        Hint = ''
        Caption = 'Biti'#351
        TabOrder = 4
      end
      object dtBit: TUniDateTimePicker
        Left = 282
        Top = 26
        Width = 110
        Height = 24
        Hint = ''
        DateTime = 46109.000000000000000000
        DateFormat = 'dd/MM/yyyy'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 5
        DisabledDates = <>
      end
      object lblKaynak: TUniLabel
        Left = 404
        Top = 8
        Width = 40
        Height = 13
        Hint = ''
        Caption = 'Kaynak'
        TabOrder = 6
      end
      object cbKaynak: TUniComboBox
        Left = 404
        Top = 26
        Width = 100
        Height = 24
        Hint = ''
        Style = csDropDownList
        TabOrder = 7
      end
      object lblTip: TUniLabel
        Left = 514
        Top = 8
        Width = 65
        Height = 13
        Hint = ''
        Caption = 'Aktivite Tipi'
        TabOrder = 8
      end
      object lkTip: TUniDBLookupComboBox
        Left = 514
        Top = 26
        Width = 200
        Height = 24
        Hint = ''
        ListField = 'AD'
        ListSource = dsTipLkp
        KeyField = 'TIP_ID'
        ListFieldIndex = 0
        TabOrder = 9
        Color = clWindow
      end
      object lblDurum: TUniLabel
        Left = 724
        Top = 8
        Width = 35
        Height = 13
        Hint = ''
        Caption = 'Durum'
        TabOrder = 10
      end
      object lkDurum: TUniDBLookupComboBox
        Left = 724
        Top = 26
        Width = 180
        Height = 24
        Hint = ''
        ListField = 'AD'
        ListSource = dsDurLkp
        KeyField = 'DURUM_ID'
        ListFieldIndex = 0
        TabOrder = 11
        Color = clWindow
      end
      object lblPersonel: TUniLabel
        Left = 12
        Top = 56
        Width = 45
        Height = 13
        Hint = ''
        Caption = 'Personel'
        TabOrder = 12
      end
      object cbPersonel: TUniComboBox
        Left = 12
        Top = 74
        Width = 140
        Height = 24
        Hint = ''
        Style = csDropDownList
        TabOrder = 13
      end
      object lblDurumGrup: TUniLabel
        Left = 162
        Top = 56
        Width = 60
        Height = 13
        Hint = ''
        Caption = 'Durum Grubu'
        TabOrder = 14
      end
      object cbDurumGrup: TUniComboBox
        Left = 162
        Top = 74
        Width = 140
        Height = 24
        Hint = ''
        Style = csDropDownList
        TabOrder = 15
      end
      object lblCari: TUniLabel
        Left = 314
        Top = 56
        Width = 22
        Height = 13
        Hint = ''
        Caption = 'Cari'
        TabOrder = 16
      end
      object edCari: TUniEdit
        Left = 314
        Top = 74
        Width = 120
        Height = 24
        Hint = ''
        Text = ''
        TabOrder = 17
      end
      object btnGetir: TUniButton
        Left = 450
        Top = 72
        Width = 120
        Height = 28
        Hint = ''
        Caption = 'Raporu Getir'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 18
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
        OnClick = btnGetirClick
      end
      object btnAc: TUniButton
        Left = 578
        Top = 72
        Width = 120
        Height = 28
        Hint = ''
        Caption = 'Kayd'#305' A'#231
        TabOrder = 19
        OnClick = btnAcClick
      end
      object btnKapat: TUniButton
        Left = 1000
        Top = 0
        Width = 100
        Height = 110
        Hint = ''
        Caption = 'Kapat'
        Align = alRight
        TabOrder = 20
        OnClick = btnKapatClick
      end
    end
    object pgc: TUniPageControl
      Left = 0
      Top = 110
      Width = 1100
      Height = 570
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
          Width = 1092
          Height = 542
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
          Columns = <
            item
              FieldName = 'AKTIVITE_ID'
              Title.Caption = 'ID'
              Width = 55
            end
            item
              FieldName = 'KAYNAK'
              Title.Caption = 'Kaynak'
              Width = 70
            end
            item
              FieldName = 'TIP'
              Title.Caption = 'Tip'
              Width = 60
            end
            item
              FieldName = 'KONU'
              Title.Caption = 'Konu'
              Width = 200
            end
            item
              FieldName = 'CARI_KOD'
              Title.Caption = 'Cari'
              Width = 80
            end
            item
              FieldName = 'OLUSTURAN'
              Title.Caption = 'Olu'#351'turan'
              Width = 100
            end
            item
              FieldName = 'ATANAN'
              Title.Caption = 'Atanan'
              Width = 100
            end
            item
              FieldName = 'PLAN_TARIHI'
              Title.Caption = 'Plan tarihi'
              Width = 120
            end
            item
              FieldName = 'DURUM'
              Title.Caption = 'Durum'
              Width = 80
            end
            item
              FieldName = 'TAMAMLANMA_TARIHI'
              Title.Caption = 'Tamamlanma'
              Width = 120
            end
            item
              FieldName = 'GECIKME_GUN'
              Title.Caption = 'Gecikme'
              Width = 65
            end>
        end
      end
      object tsOzetDurum: TUniTabSheet
        Hint = ''
        Caption = #214'zet - Durum'
        Layout = 'fit'
        object grdOzetDurum: TUniDBGrid
          Left = 0
          Top = 0
          Width = 1092
          Height = 542
          Hint = ''
          DataSource = dsOzetDurum
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
          Columns = <
            item
              FieldName = 'DURUM'
              Title.Caption = 'Durum'
              Width = 200
            end
            item
              FieldName = 'ADET'
              Title.Caption = 'Adet'
              Width = 80
            end>
        end
      end
      object tsOzetPersonel: TUniTabSheet
        Hint = ''
        Caption = #214'zet - Personel'
        Layout = 'fit'
        object grdOzetPersonel: TUniDBGrid
          Left = 0
          Top = 0
          Width = 1092
          Height = 542
          Hint = ''
          DataSource = dsOzetPersonel
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
          Columns = <
            item
              FieldName = 'PERSONEL'
              Title.Caption = 'Personel'
              Width = 180
            end
            item
              FieldName = 'ACIK'
              Title.Caption = 'A'#231#305'k'
              Width = 70
            end
            item
              FieldName = 'TAMAMLANAN'
              Title.Caption = 'Tamamlanan'
              Width = 90
            end
            item
              FieldName = 'GECIKEN'
              Title.Caption = 'Geciken'
              Width = 70
            end>
        end
      end
      object tsYapilmayan: TUniTabSheet
        Hint = ''
        Caption = 'Yap'#305'lmayanlar'
        Layout = 'fit'
        object grdYapilmayan: TUniDBGrid
          Left = 0
          Top = 0
          Width = 1092
          Height = 542
          Hint = ''
          DataSource = dsYapilmayan
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
          Columns = <
            item
              FieldName = 'AKTIVITE_ID'
              Title.Caption = 'ID'
              Width = 55
            end
            item
              FieldName = 'KAYNAK'
              Title.Caption = 'Kaynak'
              Width = 70
            end
            item
              FieldName = 'KONU'
              Title.Caption = 'Konu'
              Width = 200
            end
            item
              FieldName = 'CARI_KOD'
              Title.Caption = 'Cari'
              Width = 80
            end
            item
              FieldName = 'ATANAN'
              Title.Caption = 'Atanan'
              Width = 100
            end
            item
              FieldName = 'PLAN_TARIHI'
              Title.Caption = 'Plan tarihi'
              Width = 120
            end
            item
              FieldName = 'DURUM'
              Title.Caption = 'Durum'
              Width = 80
            end
            item
              FieldName = 'GECIKME_GUN'
              Title.Caption = 'Gecikme'
              Width = 65
            end>
        end
      end
    end
  end
  object qTipLkp: TUniQuery
    Connection = frmDM.conAsya
    Left = 800
    Top = 140
  end
  object dsTipLkp: TUniDataSource
    DataSet = qTipLkp
    Left = 832
    Top = 140
  end
  object qDurLkp: TUniQuery
    Connection = frmDM.conAsya
    Left = 800
    Top = 180
  end
  object dsDurLkp: TUniDataSource
    DataSet = qDurLkp
    Left = 832
    Top = 180
  end
  object qDetay: TUniQuery
    Connection = frmDM.conAsya
    Left = 800
    Top = 220
  end
  object dsDetay: TUniDataSource
    DataSet = qDetay
    Left = 832
    Top = 220
  end
  object qOzetDurum: TUniQuery
    Connection = frmDM.conAsya
    Left = 800
    Top = 260
  end
  object dsOzetDurum: TUniDataSource
    DataSet = qOzetDurum
    Left = 832
    Top = 260
  end
  object qOzetPersonel: TUniQuery
    Connection = frmDM.conAsya
    Left = 800
    Top = 300
  end
  object dsOzetPersonel: TUniDataSource
    DataSet = qOzetPersonel
    Left = 832
    Top = 300
  end
  object qYapilmayan: TUniQuery
    Connection = frmDM.conAsya
    Left = 800
    Top = 340
  end
  object dsYapilmayan: TUniDataSource
    DataSet = qYapilmayan
    Left = 832
    Top = 340
  end
end
