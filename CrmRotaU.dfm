object frmCrmRotaPlan: TfrmCrmRotaPlan
  Left = 0
  Top = 0
  ClientHeight = 700
  ClientWidth = 1020
  Caption = 'CRM - Rota plani'
  OnShow = UniFormShow
  BorderStyle = bsNone
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  OnCreate = UniFormCreate
  OnDestroy = UniFormDestroy
  TextHeight = 15
  object rootPanel: TUniPanel
    Left = 0
    Top = 0
    Width = 1020
    Height = 700
    Hint = ''
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    object panUst: TUniPanel
      Left = 0
      Top = 0
      Width = 1020
      Height = 232
      Hint = ''
      Align = alTop
      TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      Color = clWhite
      object lblBaslik: TUniLabel
        Left = 12
        Top = 12
        Width = 30
        Height = 13
        Hint = ''
        Caption = 'Baslik'
        TabOrder = 12
      end
      object edBaslik: TUniEdit
        Left = 96
        Top = 8
        Width = 880
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 0
      end
      object lblDetay: TUniLabel
        Left = 12
        Top = 48
        Width = 57
        Height = 13
        Hint = ''
        Caption = 'Detay / not'
        TabOrder = 13
      end
      object mmDetay: TUniMemo
        Left = 96
        Top = 44
        Width = 880
        Height = 72
        Hint = ''
        TabOrder = 1
      end
      object lblPlanTar: TUniLabel
        Left = 12
        Top = 128
        Width = 52
        Height = 13
        Hint = ''
        Caption = 'Plan tarihi'
        TabOrder = 14
      end
      object dtPlan: TUniDateTimePicker
        Left = 96
        Top = 124
        Width = 140
        Height = 27
        Hint = ''
        DateTime = 45592.000000000000000000
        DateFormat = 'dd/MM/yyyy'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 2
        DisabledDates = <>
      end
      object lblDurum: TUniLabel
        Left = 260
        Top = 128
        Width = 35
        Height = 13
        Hint = ''
        Caption = 'Durum'
        TabOrder = 15
      end
      object cbDurum: TUniComboBox
        Left = 316
        Top = 124
        Width = 140
        Height = 27
        Hint = ''
        Style = csDropDownList
        Text = ''
        TabOrder = 3
        IconItems = <>
      end
      object lblEsik: TUniLabel
        Left = 480
        Top = 128
        Width = 67
        Height = 13
        Hint = ''
        Caption = 'Uyari esik km'
        TabOrder = 16
      end
      object edEsikKm: TUniEdit
        Left = 588
        Top = 124
        Width = 60
        Height = 27
        Hint = ''
        Text = '80'
        TabOrder = 4
      end
      object lblEsikAcik: TUniLabel
        Left = 660
        Top = 128
        Width = 226
        Height = 13
        Hint = ''
        Caption = '(Rota eksenine gore capraz sapma uyaris'#196#177')'
        TabOrder = 17
      end
      object lblBasE: TUniLabel
        Left = 12
        Top = 168
        Width = 83
        Height = 13
        Hint = ''
        Caption = 'Baslangic enlem'
        TabOrder = 18
      end
      object edBasEnlem: TUniEdit
        Left = 120
        Top = 164
        Width = 100
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 5
      end
      object lblBasB: TUniLabel
        Left = 228
        Top = 168
        Width = 37
        Height = 13
        Hint = ''
        Caption = 'boylam'
        TabOrder = 19
      end
      object edBasBoylam: TUniEdit
        Left = 276
        Top = 164
        Width = 100
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 6
      end
      object btnHarBas: TUniButton
        Left = 388
        Top = 162
        Width = 120
        Height = 30
        Hint = ''
        Caption = 'Haritadan'
        TabOrder = 7
        OnClick = btnHarBasClick
      end
      object lblBitE: TUniLabel
        Left = 520
        Top = 168
        Width = 56
        Height = 13
        Hint = ''
        Caption = 'Bitis enlem'
        TabOrder = 20
      end
      object edBitEnlem: TUniEdit
        Left = 596
        Top = 164
        Width = 100
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 8
      end
      object lblBitB: TUniLabel
        Left = 704
        Top = 168
        Width = 37
        Height = 13
        Hint = ''
        Caption = 'boylam'
        TabOrder = 21
      end
      object edBitBoylam: TUniEdit
        Left = 752
        Top = 164
        Width = 100
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 9
      end
      object btnHarBit: TUniButton
        Left = 864
        Top = 162
        Width = 120
        Height = 30
        Hint = ''
        Caption = 'Haritadan'
        TabOrder = 10
        OnClick = btnHarBitClick
      end
    end
    object panDurakBar: TUniPanel
      Left = 0
      Top = 232
      Width = 1020
      Height = 44
      Hint = ''
      Align = alTop
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      object btnEkleCari: TUniButton
        Left = 8
        Top = 8
        Width = 140
        Height = 28
        Hint = ''
        Caption = 'Durak: Netsis cari'
        TabOrder = 0
        OnClick = btnEkleCariClick
      end
      object btnEklePot: TUniButton
        Left = 156
        Top = 8
        Width = 160
        Height = 28
        Hint = ''
        Caption = 'Durak: Potansiyel'
        TabOrder = 1
        OnClick = btnEklePotClick
      end
      object btnDurakSil: TUniButton
        Left = 324
        Top = 8
        Width = 100
        Height = 28
        Hint = ''
        Caption = 'Durak sil'
        TabOrder = 2
        OnClick = btnDurakSilClick
      end
      object btnUyariYenile: TUniButton
        Left = 432
        Top = 8
        Width = 140
        Height = 28
        Hint = ''
        Caption = 'Uyarilari yenile'
        TabOrder = 3
        OnClick = btnUyariYenileClick
      end
    end
    object panFooter: TUniPanel
      Left = 0
      Top = 648
      Width = 1020
      Height = 52
      Hint = ''
      Align = alBottom
      TabOrder = 3
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      object btnKaydet: TUniButton
        Left = 320
        Top = 8
        Width = 140
        Height = 36
        Hint = ''
        Caption = 'Kaydet'
        TabOrder = 0
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
        ScreenMask.Enabled = True
        OnClick = btnKaydetClick
      end
      object btnRotaHarita: TUniButton
        Left = 480
        Top = 8
        Width = 180
        Height = 36
        Hint = ''
        Caption = 'Rotayi haritada'
        TabOrder = 1
        OnClick = btnRotaHaritaClick
      end
      object btnKapat: TUniButton
        Left = 880
        Top = 8
        Width = 100
        Height = 36
        Hint = ''
        Caption = 'Kapat'
        TabOrder = 2
        OnClick = btnKapatClick
      end
    end
    object grdDurak: TUniDBGrid
      Left = 0
      Top = 276
      Width = 1020
      Height = 372
      Hint = ''
      DataSource = dsGrid
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
      ReadOnly = True
      WebOptions.Paged = False
      WebOptions.FetchAll = True
      LoadMask.Message = 'Loading data...'
      Align = alClient
      TabOrder = 2
      Columns = <
        item
          FieldName = 'SIRA'
          Title.Caption = 'Sira'
          Width = 45
          ReadOnly = True
        end
        item
          FieldName = 'TIP'
          Title.Caption = 'T'
          Width = 30
          ReadOnly = True
        end
        item
          FieldName = 'CARI_KOD'
          Title.Caption = 'Cari kod'
          Width = 90
          ReadOnly = True
        end
        item
          FieldName = 'POTID'
          Title.Caption = 'Pot.id'
          Width = 60
          ReadOnly = True
        end
        item
          FieldName = 'UNVAN'
          Title.Caption = 'Unvan'
          Width = 180
          ReadOnly = True
        end
        item
          FieldName = 'IL'
          Title.Caption = 'Il'
          Width = 70
          ReadOnly = True
        end
        item
          FieldName = 'ILCE'
          Title.Caption = 'Ilce'
          Width = 80
          ReadOnly = True
        end
        item
          FieldName = 'ENLEM'
          Title.Caption = 'Enlem'
          Width = 75
          ReadOnly = True
        end
        item
          FieldName = 'BOYLAM'
          Title.Caption = 'Boylam'
          Width = 75
          ReadOnly = True
        end
        item
          FieldName = 'UYARI'
          Title.Caption = 'Uyari'
          Width = 240
          ReadOnly = True
        end>
    end
  end
  object qGrid: TUniQuery
    Connection = frmDM.conAsya
    Left = 40
    Top = 640
  end
  object dsGrid: TUniDataSource
    DataSet = qGrid
    Left = 72
    Top = 640
  end
  object qExec: TUniQuery
    Connection = frmDM.conAsya
    Left = 104
    Top = 640
  end
  object qLoad: TUniQuery
    Connection = frmDM.conAsya
    Left = 136
    Top = 640
  end
  object qNetsis: TUniQuery
    Connection = frmDM.conNetsis
    Left = 168
    Top = 640
  end
  object qTmp: TUniQuery
    Connection = frmDM.conAsya
    Left = 200
    Top = 640
  end
end
