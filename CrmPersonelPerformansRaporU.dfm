object frmCrmPersonelPerformansRapor: TfrmCrmPersonelPerformansRapor
  Left = 0
  Top = 0
  ClientHeight = 640
  ClientWidth = 1100
  Caption = 'CRM - Personel Performans Raporu'
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
      Height = 52
      Hint = ''
      TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      LayoutConfig.Width = '100%'
      object lblBas: TUniLabel
        Left = 12
        Top = 16
        Width = 55
        Height = 13
        Hint = ''
        Caption = 'Ba'#351'lang'#305#231
        TabOrder = 0
      end
      object dtBas: TUniDateTimePicker
        Left = 80
        Top = 12
        Width = 110
        Height = 24
        Hint = ''
        DateTime = 46109.000000000000000000
        DateFormat = 'dd/MM/yyyy'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 1
        DisabledDates = <>
      end
      object lblBit: TUniLabel
        Left = 200
        Top = 16
        Width = 22
        Height = 13
        Hint = ''
        Caption = 'Biti'#351
        TabOrder = 2
      end
      object dtBit: TUniDateTimePicker
        Left = 232
        Top = 12
        Width = 110
        Height = 24
        Hint = ''
        DateTime = 46109.000000000000000000
        DateFormat = 'dd/MM/yyyy'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 3
        DisabledDates = <>
      end
      object lblPersonel: TUniLabel
        Left = 360
        Top = 16
        Width = 45
        Height = 13
        Hint = ''
        Caption = 'Personel'
        TabOrder = 4
      end
      object cbPersonel: TUniComboBox
        Left = 420
        Top = 12
        Width = 200
        Height = 24
        Hint = ''
        Style = csDropDownList
        TabOrder = 5
      end
      object btnGetir: TUniButton
        Left = 640
        Top = 10
        Width = 90
        Height = 30
        Hint = ''
        Caption = 'Getir'
        TabOrder = 6
        OnClick = btnGetirClick
      end
      object btnKapat: TUniButton
        Left = 1000
        Top = 0
        Width = 100
        Height = 52
        Hint = ''
        Caption = 'Kapat'
        Align = alRight
        TabOrder = 7
        OnClick = btnKapatClick
      end
    end
    object pgc: TUniPageControl
      Left = 0
      Top = 52
      Width = 1100
      Height = 588
      Hint = ''
      ActivePage = tsGorevOzet
      Align = alClient
      TabOrder = 1
      LayoutConfig.Flex = 1
      LayoutConfig.Width = '100%'
      object tsGorevOzet: TUniTabSheet
        Hint = ''
        Caption = 'G'#246'rev '#214'zeti'
        object grdGorevOzet: TUniDBGrid
          Left = 0
          Top = 0
          Width = 1092
          Height = 558
          Hint = ''
          DataSource = dsGorevOzet
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgAutoRefreshRow]
          ReadOnly = True
          WebOptions.Paged = False
          WebOptions.FetchAll = True
          LoadMask.Message = 'Y'#252'kleniyor...'
          Align = alClient
          TabOrder = 0
        end
      end
      object tsGorevDetay: TUniTabSheet
        Hint = ''
        Caption = 'G'#246'rev Detay'
        object grdGorevDetay: TUniDBGrid
          Left = 0
          Top = 0
          Width = 1092
          Height = 558
          Hint = ''
          DataSource = dsGorevDetay
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgAutoRefreshRow]
          ReadOnly = True
          WebOptions.Paged = False
          WebOptions.FetchAll = True
          LoadMask.Message = 'Y'#252'kleniyor...'
          Align = alClient
          TabOrder = 0
        end
      end
      object tsTeklifOzet: TUniTabSheet
        Hint = ''
        Caption = 'Teklif '#214'zeti'
        object grdTeklifOzet: TUniDBGrid
          Left = 0
          Top = 0
          Width = 1092
          Height = 558
          Hint = ''
          DataSource = dsTeklifOzet
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgAutoRefreshRow]
          ReadOnly = True
          WebOptions.Paged = False
          WebOptions.FetchAll = True
          LoadMask.Message = 'Y'#252'kleniyor...'
          Align = alClient
          TabOrder = 0
        end
      end
      object tsTeklifDetay: TUniTabSheet
        Hint = ''
        Caption = 'Teklif Detay'
        object grdTeklifDetay: TUniDBGrid
          Left = 0
          Top = 0
          Width = 1092
          Height = 558
          Hint = ''
          DataSource = dsTeklifDetay
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgAutoRefreshRow]
          ReadOnly = True
          WebOptions.Paged = False
          WebOptions.FetchAll = True
          LoadMask.Message = 'Y'#252'kleniyor...'
          Align = alClient
          TabOrder = 0
        end
      end
    end
  end
  object qGorevOzet: TUniQuery
    Connection = frmDM.conAsya
    Left = 520
    Top = 320
  end
  object dsGorevOzet: TUniDataSource
    DataSet = qGorevOzet
    Left = 520
    Top = 368
  end
  object qGorevDetay: TUniQuery
    Connection = frmDM.conAsya
    Left = 600
    Top = 320
  end
  object dsGorevDetay: TUniDataSource
    DataSet = qGorevDetay
    Left = 600
    Top = 368
  end
  object qTeklifOzet: TUniQuery
    Connection = frmDM.conAsya
    Left = 680
    Top = 320
  end
  object dsTeklifOzet: TUniDataSource
    DataSet = qTeklifOzet
    Left = 680
    Top = 368
  end
  object qTeklifDetay: TUniQuery
    Connection = frmDM.conAsya
    Left = 760
    Top = 320
  end
  object dsTeklifDetay: TUniDataSource
    DataSet = qTeklifDetay
    Left = 760
    Top = 368
  end
  object qExec: TUniQuery
    Connection = frmDM.conAsya
    Left = 840
    Top = 320
  end
end
