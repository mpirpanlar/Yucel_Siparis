object frmCrmPotansiyelSec: TfrmCrmPotansiyelSec
  Left = 0
  Top = 0
  ClientHeight = 560
  ClientWidth = 1000
  Caption = 'CRM - Potansiyel Se'#231'imi'
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  BorderIcons = [biSystemMenu]
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
    Layout = 'vbox'
    object pnlToolbar: TUniPanel
      Left = 0
      Top = 0
      Width = 1000
      Height = 88
      Hint = ''
      TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      Color = 10865101
      LayoutConfig.Width = '100%'
      object lblBilgi: TUniLabel
        Left = 12
        Top = 8
        Width = 500
        Height = 13
        Hint = ''
        Caption = 
          'Filtre + Listele; satir basindaki kutuyu isaretleyin veya satir' +
          'a cift tiklayin.'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clGray
        Font.Height = -12
        TabOrder = 0
      end
      object lblSecili: TUniLabel
        Left = 12
        Top = 28
        Width = 60
        Height = 13
        Hint = ''
        Visible = False
        Caption = 'Se'#231'ili: 0'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clGray
        Font.Height = -12
        TabOrder = 1
      end
      object btnListele: TUniButton
        Left = 12
        Top = 52
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
        TabOrder = 2
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
        OnClick = btnListeleClick
      end
      object btnSec: TUniButton
        Left = 120
        Top = 52
        Width = 150
        Height = 32
        Hint = ''
        Caption = 'Sat'#305'r Se'#231
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 3
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
        OnClick = btnSecClick
      end
      object btnKapat: TUniButton
        Left = 888
        Top = 52
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
        TabOrder = 4
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'secondary'#39';'#13#10'}')
        OnClick = btnKapatClick
      end
    end
    object panFilt: TUniPanel
      Left = 0
      Top = 88
      Width = 1000
      Height = 72
      Hint = ''
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      LayoutConfig.Width = '100%'
      object lblFiltUnvan: TUniLabel
        Left = 12
        Top = 12
        Width = 70
        Height = 13
        Hint = ''
        Caption = 'Firma / Unvan'
        TabOrder = 0
      end
      object edFiltUnvan: TUniEdit
        Left = 108
        Top = 8
        Width = 260
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 1
      end
      object lblFiltNetsis: TUniLabel
        Left = 388
        Top = 12
        Width = 75
        Height = 13
        Hint = ''
        Caption = 'Netsis Cari Kod'
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
        Caption = 'Sadece Netsis Cariye Ba'#287'l'#305' Kay'#305'tlar'
        TabOrder = 6
      end
    end
    object grd: TUniDBGrid
      Left = 0
      Top = 160
      Width = 1000
      Height = 400
      Hint = ''
      DataSource = dsList
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgCheckSelect, dgCheckSelectCheckOnly, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
      ReadOnly = True
      WebOptions.Paged = False
      WebOptions.FetchAll = True
      LoadMask.Message = 'Y'#252'kleniyor...'
      LayoutConfig.Flex = 1
      LayoutConfig.Height = '100%'
      LayoutConfig.Width = '100%'
      TabOrder = 2
      OnAjaxEvent = grdAjaxEvent
      OnSelectionChange = grdSelectionChange
      Columns = <
        item
          FieldName = 'POTANSIYEL_ID'
          Title.Caption = 'ID'
          Width = 55
        end
        item
          FieldName = 'FIRMA_UNVAN'
          Title.Caption = 'Firma Unvan'
          Width = 260
        end
        item
          FieldName = 'KISA_AD'
          Title.Caption = 'K'#305'sa Ad'
          Width = 120
        end
        item
          FieldName = 'NETSIS_CARI_KOD'
          Title.Caption = 'Netsis Cari'
          Width = 100
        end
        item
          FieldName = 'DURUM_KOD'
          Title.Caption = 'Durum'
          Width = 110
        end
        item
          FieldName = 'IL'
          Title.Caption = #304'l'
          Width = 80
        end
        item
          FieldName = 'ILCE'
          Title.Caption = #304'l'#231'e'
          Width = 90
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
