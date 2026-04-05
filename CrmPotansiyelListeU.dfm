object frmCrmPotansiyelListe: TfrmCrmPotansiyelListe
  Left = 0
  Top = 0
  ClientHeight = 560
  ClientWidth = 1000
  Caption = 'CRM - Potansiyel musteri listesi'
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
    Width = 1000
    Height = 560
    Hint = ''
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    object pnlToolbar: TUniPanel
      Left = 0
      Top = 0
      Width = 1000
      Height = 48
      Hint = ''
      Align = alTop
      TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      Color = 10865101
      object lblSecimBilgi: TUniLabel
        Left = 12
        Top = 4
        Width = 608
        Height = 13
        Hint = ''
        Visible = False
        Caption = 
          'Filtre + Listele; istenen satira tiklayin, ardindan asagidaki Sa' +
          'tir sec ile onaylayin. Cift tik da ayni sekilde secer ve kapatir' +
          '.'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clGray
        Font.Height = -12
        TabOrder = 0
      end
      object btnListele: TUniButton
        Left = 12
        Top = 8
        Width = 100
        Height = 32
        Hint = ''
        Caption = 'Listele'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 1
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
        OnClick = btnListeleClick
      end
      object btnSatirSec: TUniButton
        Left = 246
        Top = 8
        Width = 140
        Height = 32
        Hint = 
          'Izgarada isaretli satiri rota duragi olarak alir ve pencereyi ka' +
          'patir'
        Caption = 'Satir sec'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 2
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
        ScreenMask.Enabled = True
        ScreenMask.Message = 'Isleniyor...'
        OnClick = btnSatirSecClick
      end
      object btnYeni: TUniButton
        Left = 120
        Top = 8
        Width = 120
        Height = 32
        Hint = ''
        Caption = 'Yeni kay'#305't'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 3
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'secondary'#39';'#13#10'}')
        OnClick = btnYeniClick
      end
      object btnAc: TUniButton
        Left = 392
        Top = 8
        Width = 120
        Height = 32
        Hint = ''
        Caption = 'Kayd'#305' a'#231
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 4
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'secondary'#39';'#13#10'}')
        OnClick = btnAcClick
      end
      object btnKapat: TUniButton
        Left = 888
        Top = 8
        Width = 100
        Height = 32
        Hint = ''
        Caption = 'Kapat'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 5
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'secondary'#39';'#13#10'}')
        OnClick = btnKapatClick
      end
    end
    object panFilt: TUniPanel
      Left = 0
      Top = 48
      Width = 1000
      Height = 72
      Hint = ''
      Align = alTop
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      object lblFiltUnvan: TUniLabel
        Left = 12
        Top = 12
        Width = 70
        Height = 13
        Hint = ''
        Caption = 'Firma / unvan'
        TabOrder = 0
      end
      object edFiltUnvan: TUniEdit
        Left = 108
        Top = 8
        Width = 260
        Height = 27
        Hint = 'Kismi eslesme'
        Text = ''
        TabOrder = 1
      end
      object lblFiltNetsis: TUniLabel
        Left = 388
        Top = 12
        Width = 75
        Height = 13
        Hint = ''
        Caption = 'Netsis cari kod'
        TabOrder = 2
      end
      object edFiltNetsis: TUniEdit
        Left = 484
        Top = 8
        Width = 140
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 3
      end
      object lblFiltDur: TUniLabel
        Left = 640
        Top = 12
        Width = 35
        Height = 13
        Hint = ''
        Caption = 'Durum'
        TabOrder = 4
      end
      object cbFiltDurum: TUniComboBox
        Left = 716
        Top = 8
        Width = 200
        Height = 27
        Hint = ''
        Style = csDropDownList
        Text = ''
        TabOrder = 5
        IconItems = <>
      end
      object chkSadeceNetsis: TUniCheckBox
        Left = 12
        Top = 44
        Width = 320
        Height = 22
        Hint = ''
        Caption = 'Sadece Netsis cariye bagli kayitlar'
        TabOrder = 6
      end
    end
    object grd: TUniDBGrid
      Left = 0
      Top = 120
      Width = 1000
      Height = 440
      Hint = ''
      DataSource = dsList
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
      ReadOnly = True
      WebOptions.Paged = False
      WebOptions.FetchAll = True
      LoadMask.Message = 'Loading data...'
      Align = alClient
      TabOrder = 2
      OnAjaxEvent = grdAjaxEvent
      OnCellClick = grdCellClick
      Columns = <
        item
          FieldName = 'POTANSIYEL_ID'
          Title.Caption = 'ID'
          Width = 55
          ReadOnly = True
        end
        item
          FieldName = 'FIRMA_UNVAN'
          Title.Caption = 'Firma unvan'
          Width = 260
          ReadOnly = True
        end
        item
          FieldName = 'KISA_AD'
          Title.Caption = 'Kisa ad'
          Width = 120
          ReadOnly = True
        end
        item
          FieldName = 'NETSIS_CARI_KOD'
          Title.Caption = 'Netsis cari'
          Width = 100
          ReadOnly = True
        end
        item
          FieldName = 'DURUM_KOD'
          Title.Caption = 'Durum'
          Width = 110
          ReadOnly = True
        end
        item
          FieldName = 'IL'
          Title.Caption = 'Il'
          Width = 80
          ReadOnly = True
        end
        item
          FieldName = 'ILCE'
          Title.Caption = 'Ilce'
          Width = 90
          ReadOnly = True
        end
        item
          FieldName = 'EPOSTA'
          Title.Caption = 'E-posta'
          Width = 150
          ReadOnly = True
        end
        item
          FieldName = 'TELEFON_SABIT'
          Title.Caption = 'Telefon'
          Width = 100
          ReadOnly = True
        end
        item
          FieldName = 'OLUSTURMA_UTC'
          Title.Caption = 'Olusturma'
          Width = 130
          ReadOnly = True
        end>
    end
  end
  object qList: TUniQuery
    Connection = frmDM.conAsya
    Left = 840
    Top = 360
  end
  object dsList: TUniDataSource
    DataSet = qList
    Left = 872
    Top = 360
  end
  object qFilt: TUniQuery
    Connection = frmDM.conAsya
    Left = 840
    Top = 408
  end
end
