object frmCrmAktiviteTarihce: TfrmCrmAktiviteTarihce
  Left = 0
  Top = 0
  ClientHeight = 640
  ClientWidth = 1050
  Caption = 'CRM - Aktivite / G'#246'rev Tarih'#231'esi'
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
    Width = 1050
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
      Width = 1050
      Height = 88
      Hint = ''
      TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      LayoutConfig.Width = '100%'
      object lblBas: TUniLabel
        Left = 12
        Top = 12
        Width = 55
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
        Left = 142
        Top = 12
        Width = 22
        Height = 13
        Hint = ''
        Caption = 'Biti'#351
        TabOrder = 2
      end
      object dtBit: TUniDateTimePicker
        Left = 142
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
      object lblKaynak: TUniLabel
        Left = 280
        Top = 12
        Width = 40
        Height = 13
        Hint = ''
        Caption = 'Kaynak'
        TabOrder = 4
      end
      object cbKaynak: TUniComboBox
        Left = 280
        Top = 30
        Width = 120
        Height = 24
        Hint = ''
        Style = csDropDownList
        TabOrder = 5
      end
      object lblAktId: TUniLabel
        Left = 412
        Top = 12
        Width = 55
        Height = 13
        Hint = ''
        Caption = 'Aktivite ID'
        TabOrder = 6
      end
      object edAktiviteId: TUniEdit
        Left = 412
        Top = 30
        Width = 90
        Height = 24
        Hint = ''
        Text = ''
        TabOrder = 7
      end
      object lblCari: TUniLabel
        Left = 514
        Top = 12
        Width = 22
        Height = 13
        Hint = ''
        Caption = 'Cari'
        TabOrder = 8
      end
      object edCari: TUniEdit
        Left = 514
        Top = 30
        Width = 120
        Height = 24
        Hint = ''
        Text = ''
        TabOrder = 9
      end
      object btnGetir: TUniButton
        Left = 12
        Top = 58
        Width = 120
        Height = 26
        Hint = ''
        Caption = 'Listele'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 10
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
        OnClick = btnGetirClick
      end
      object btnAc: TUniButton
        Left = 142
        Top = 58
        Width = 120
        Height = 26
        Hint = ''
        Caption = 'Kayd'#305' A'#231
        TabOrder = 11
        OnClick = btnAcClick
      end
      object btnKapat: TUniButton
        Left = 950
        Top = 0
        Width = 100
        Height = 88
        Hint = ''
        Caption = 'Kapat'
        Align = alRight
        TabOrder = 12
        OnClick = btnKapatClick
      end
    end
    object grd: TUniDBGrid
      Left = 0
      Top = 88
      Width = 1050
      Height = 552
      Hint = ''
      DataSource = dsList
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgTabs, dgCancelOnExit]
      ReadOnly = True
      WebOptions.Paged = False
      WebOptions.FetchAll = True
      LoadMask.Message = 'Loading data...'
      LayoutConfig.Flex = 1
      LayoutConfig.Height = '100%'
      LayoutConfig.Width = '100%'
      TabOrder = 1
      Columns = <
        item
          FieldName = 'ISLEM_ZAMANI'
          Title.Caption = 'Tarih'
          Width = 130
          ReadOnly = True
        end
        item
          FieldName = 'KULLANICI'
          Title.Caption = 'Kullan'#305'c'#305
          Width = 90
          ReadOnly = True
        end
        item
          FieldName = 'AKTIVITE_ID'
          Title.Caption = 'Akt. ID'
          Width = 70
          ReadOnly = True
        end
        item
          FieldName = 'KONU'
          Title.Caption = 'Konu'
          Width = 180
          ReadOnly = True
        end
        item
          FieldName = 'KAYNAK'
          Title.Caption = 'Kaynak'
          Width = 70
          ReadOnly = True
        end
        item
          FieldName = 'ISLEM'
          Title.Caption = #304#351'lem'
          Width = 100
          ReadOnly = True
        end
        item
          FieldName = 'ALAN_ADI'
          Title.Caption = 'Alan'
          Width = 90
          ReadOnly = True
        end
        item
          FieldName = 'ESKI_DEGER'
          Title.Caption = 'Eski'
          Width = 120
          ReadOnly = True
        end
        item
          FieldName = 'YENI_DEGER'
          Title.Caption = 'Yeni'
          Width = 120
          ReadOnly = True
        end>
    end
  end
  object qList: TUniQuery
    Connection = frmDM.conAsya
    Left = 480
    Top = 120
  end
  object dsList: TUniDataSource
    DataSet = qList
    Left = 512
    Top = 120
  end
end
