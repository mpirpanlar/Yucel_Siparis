object frmCrmRotaKmRapor: TfrmCrmRotaKmRapor
  Left = 0
  Top = 0
  ClientHeight = 640
  ClientWidth = 1100
  Caption = 'CRM - Rota Km Raporu'
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
      Width = 1100
      Height = 136
      Hint = ''
      TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      LayoutConfig.Width = '100%'
      object lblBas: TUniLabel
        Left = 12
        Top = 12
        Width = 80
        Height = 13
        Hint = ''
        Caption = 'Ba'#351'lang'#305#231
        TabOrder = 0
      end
      object dtBas: TUniDateTimePicker
        Left = 12
        Top = 30
        Width = 120
        Height = 24
        Hint = ''
        DateTime = 46109.000000000000000000
        DateFormat = 'dd/MM/yyyy'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 1
        DisabledDates = <>
      end
      object lblBit: TUniLabel
        Left = 148
        Top = 12
        Width = 40
        Height = 13
        Hint = ''
        Caption = 'Biti'#351
        TabOrder = 2
      end
      object dtBit: TUniDateTimePicker
        Left = 148
        Top = 30
        Width = 120
        Height = 24
        Hint = ''
        DateTime = 46109.000000000000000000
        DateFormat = 'dd/MM/yyyy'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 3
        DisabledDates = <>
      end
      object lblDurum: TUniLabel
        Left = 284
        Top = 12
        Width = 35
        Height = 13
        Hint = ''
        Caption = 'Durum'
        TabOrder = 4
      end
      object cbDurum: TUniComboBox
        Left = 284
        Top = 30
        Width = 120
        Height = 24
        Hint = ''
        Style = csDropDownList
        Text = ''
        TabOrder = 5
        IconItems = <>
      end
      object lblPersonel: TUniLabel
        Left = 420
        Top = 12
        Width = 45
        Height = 13
        Hint = ''
        Caption = 'Personel'
        TabOrder = 6
      end
      object cbPersonel: TUniComboBox
        Left = 420
        Top = 30
        Width = 180
        Height = 24
        Hint = ''
        Style = csDropDownList
        Text = ''
        TabOrder = 7
        IconItems = <>
      end
      object lblGpsMod: TUniLabel
        Left = 616
        Top = 12
        Width = 90
        Height = 13
        Hint = ''
        Caption = 'GPS eksik bacak'
        TabOrder = 8
      end
      object cbGpsMod: TUniComboBox
        Left = 616
        Top = 30
        Width = 200
        Height = 24
        Hint = ''
        Style = csDropDownList
        Text = ''
        TabOrder = 9
        IconItems = <>
      end
      object lblBaslik: TUniLabel
        Left = 828
        Top = 12
        Width = 30
        Height = 13
        Hint = ''
        Caption = 'Ba'#351'l'#305'k'
        TabOrder = 10
      end
      object edBaslik: TUniEdit
        Left = 828
        Top = 30
        Width = 160
        Height = 24
        Hint = ''
        Text = ''
        TabOrder = 11
      end
      object btnGetir: TUniButton
        Left = 12
        Top = 68
        Width = 120
        Height = 28
        Hint = ''
        Caption = 'Raporu Getir'
        TabOrder = 12
        OnClick = btnGetirClick
      end
      object btnMesafeGuncelle: TUniButton
        Left = 140
        Top = 68
        Width = 160
        Height = 28
        Hint = ''
        Caption = 'Mesafeleri G'#252'ncelle'
        TabOrder = 13
        OnClick = btnMesafeGuncelleClick
      end
      object btnAc: TUniButton
        Left = 312
        Top = 68
        Width = 120
        Height = 28
        Hint = ''
        Caption = 'Rotay'#305' A'#231
        TabOrder = 14
        OnClick = btnAcClick
      end
      object btnKapat: TUniButton
        Left = 990
        Top = 0
        Width = 110
        Height = 136
        Hint = ''
        Caption = 'Kapat'
        Align = alRight
        TabOrder = 15
        OnClick = btnKapatClick
      end
      object lblBilgi: TUniLabel
        Left = 12
        Top = 104
        Width = 900
        Height = 26
        Hint = ''
        AutoSize = False
        Caption = 
          'Toplam km: baslangic + duraklar + bitis (kus ucusu). Bacak km: her duraga onceki noktadan mesafe. GPS eksik bacaklar 0 km sayilir veya toplamdan haric tutulur (parametre).'
        TabOrder = 16
      end
    end
    object pgc: TUniPageControl
      Left = 0
      Top = 136
      Width = 1100
      Height = 504
      Hint = ''
      ActivePage = tsRota
      TabOrder = 1
      LayoutConfig.Flex = 1
      LayoutConfig.Height = '100%'
      LayoutConfig.Width = '100%'
      object tsRota: TUniTabSheet
        Hint = ''
        Caption = 'Rota'
        Layout = 'fit'
        object grdRota: TUniDBGrid
          Left = 0
          Top = 0
          Width = 1092
          Height = 500
          Hint = ''
          DataSource = dsRota
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgTabs, dgCancelOnExit]
          ReadOnly = True
          WebOptions.Paged = False
          WebOptions.FetchAll = True
          LoadMask.Message = 'Loading data...'
          LayoutConfig.Flex = 1
          LayoutConfig.Height = '100%'
          LayoutConfig.Width = '100%'
          TabOrder = 0
        end
      end
      object tsBacak: TUniTabSheet
        Hint = ''
        Caption = 'Bacak'
        Layout = 'fit'
        object grdBacak: TUniDBGrid
          Left = 0
          Top = 0
          Width = 1092
          Height = 500
          Hint = ''
          DataSource = dsBacak
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgTabs, dgCancelOnExit]
          ReadOnly = True
          WebOptions.Paged = False
          WebOptions.FetchAll = True
          LoadMask.Message = 'Loading data...'
          LayoutConfig.Flex = 1
          LayoutConfig.Height = '100%'
          LayoutConfig.Width = '100%'
          TabOrder = 0
        end
      end
      object tsOzetPersonel: TUniTabSheet
        Hint = ''
        Caption = #214'zet Personel'
        Layout = 'fit'
        object grdOzetPersonel: TUniDBGrid
          Left = 0
          Top = 0
          Width = 1092
          Height = 500
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
          TabOrder = 0
        end
      end
      object tsOzetDonem: TUniTabSheet
        Hint = ''
        Caption = #214'zet D'#246'nem'
        Layout = 'fit'
        object grdOzetDonem: TUniDBGrid
          Left = 0
          Top = 0
          Width = 1092
          Height = 500
          Hint = ''
          DataSource = dsOzetDonem
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgTabs, dgCancelOnExit]
          ReadOnly = True
          WebOptions.Paged = False
          WebOptions.FetchAll = True
          LoadMask.Message = 'Loading data...'
          LayoutConfig.Flex = 1
          LayoutConfig.Height = '100%'
          LayoutConfig.Width = '100%'
          TabOrder = 0
        end
      end
      object tsGpsEksik: TUniTabSheet
        Hint = ''
        Caption = 'GPS Eksik Cari'
        Layout = 'fit'
        object grdGpsEksik: TUniDBGrid
          Left = 0
          Top = 0
          Width = 1092
          Height = 500
          Hint = ''
          DataSource = dsGpsEksik
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgTabs, dgCancelOnExit]
          ReadOnly = True
          WebOptions.Paged = False
          WebOptions.FetchAll = True
          LoadMask.Message = 'Loading data...'
          LayoutConfig.Flex = 1
          LayoutConfig.Height = '100%'
          LayoutConfig.Width = '100%'
          TabOrder = 0
        end
      end
    end
  end
  object qRota: TUniQuery
    Connection = frmDM.conAsya
    Left = 720
    Top = 120
  end
  object dsRota: TUniDataSource
    DataSet = qRota
    Left = 752
    Top = 120
  end
  object qBacak: TUniQuery
    Connection = frmDM.conAsya
    Left = 720
    Top = 160
  end
  object dsBacak: TUniDataSource
    DataSet = qBacak
    Left = 752
    Top = 160
  end
  object qOzetPersonel: TUniQuery
    Connection = frmDM.conAsya
    Left = 720
    Top = 200
  end
  object dsOzetPersonel: TUniDataSource
    DataSet = qOzetPersonel
    Left = 752
    Top = 200
  end
  object qOzetDonem: TUniQuery
    Connection = frmDM.conAsya
    Left = 720
    Top = 240
  end
  object dsOzetDonem: TUniDataSource
    DataSet = qOzetDonem
    Left = 752
    Top = 240
  end
  object qGpsEksik: TUniQuery
    Connection = frmDM.conNetsis
    Left = 720
    Top = 280
  end
  object dsGpsEksik: TUniDataSource
    DataSet = qGpsEksik
    Left = 752
    Top = 280
  end
  object qExec: TUniQuery
    Connection = frmDM.conAsya
    Left = 720
    Top = 320
  end
end
