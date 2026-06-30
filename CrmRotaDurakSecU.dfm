object frmCrmRotaDurakSec: TfrmCrmRotaDurakSec
  Left = 0
  Top = 0
  ClientHeight = 620
  ClientWidth = 960
  Caption = 'CRM - Rota durak se'#231'imi (b'#246'lge)'
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  TextHeight = 15
  object rootPanel: TUniPanel
    Left = 0
    Top = 0
    Width = 960
    Height = 620
    Hint = ''
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    Layout = 'vbox'
    object panFilt: TUniPanel
      Left = 0
      Top = 0
      Width = 960
      Height = 88
      Hint = ''
      TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      LayoutConfig.Width = '100%'
      object lblIl: TUniLabel
        Left = 12
        Top = 12
        Width = 12
        Height = 13
        Hint = ''
        Caption = #304'l'
        TabOrder = 0
      end
      object cbIl: TUniComboBox
        Left = 40
        Top = 8
        Width = 160
        Height = 24
        Hint = ''
        Style = csDropDown
        Text = ''
        TabOrder = 1
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'  config.edita' +
            'ble = true;'#13#10'  config.queryMode = '#39'local'#39';'#13#10'  config.forceSelecti' +
            'on = true;'#13#10'  config.typeAhead = true;'#13#10'  config.minChars = 1;'#13#10'}')
        OnChange = cbIlChange
      end
      object lblIlce: TUniLabel
        Left = 212
        Top = 12
        Width = 24
        Height = 13
        Hint = ''
        Caption = #304'l'#231'e'
        TabOrder = 2
      end
      object cbIlce: TUniComboBox
        Left = 248
        Top = 8
        Width = 160
        Height = 24
        Hint = ''
        Style = csDropDown
        Text = ''
        TabOrder = 3
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'  config.edita' +
            'ble = true;'#13#10'  config.queryMode = '#39'local'#39';'#13#10'  config.forceSelecti' +
            'on = true;'#13#10'  config.typeAhead = true;'#13#10'  config.minChars = 1;'#13#10'}')
      end
      object chkSadeceGps: TUniCheckBox
        Left = 420
        Top = 10
        Width = 180
        Height = 17
        Hint = ''
        Caption = 'Yaln'#305'z GPS''i olanlar'
        TabOrder = 4
      end
      object chkKaynakCari: TUniCheckBox
        Left = 12
        Top = 44
        Width = 120
        Height = 17
        Hint = ''
        Caption = 'Netsis cari'
        Checked = True
        TabOrder = 5
      end
      object chkKaynakPot: TUniCheckBox
        Left = 140
        Top = 44
        Width = 120
        Height = 17
        Hint = ''
        Caption = 'Potansiyel'
        Checked = True
        TabOrder = 6
      end
      object btnListele: TUniButton
        Left = 620
        Top = 8
        Width = 120
        Height = 32
        Hint = ''
        Caption = 'Listele'
        TabOrder = 7
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
        OnClick = btnListeleClick
      end
    end
    object grd: TUniDBGrid
      Left = 0
      Top = 88
      Width = 960
      Height = 480
      Hint = ''
      DataSource = dsList
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgMultiSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
      ReadOnly = True
      WebOptions.Paged = False
      WebOptions.FetchAll = True
      LoadMask.Message = 'Y'#252'kleniyor...'
      LayoutConfig.Flex = 1
      LayoutConfig.Height = '100%'
      LayoutConfig.Width = '100%'
      TabOrder = 1
      OnSelectionChange = grdSelectionChange
      Columns = <
        item
          FieldName = 'TIP'
          Title.Caption = 'T'
          Width = 30
        end
        item
          FieldName = 'KOD'
          Title.Caption = 'Cari kod'
          Width = 90
        end
        item
          FieldName = 'POTID'
          Title.Caption = 'Pot.id'
          Width = 60
        end
        item
          FieldName = 'UNVAN'
          Title.Caption = #220'nvan'
          Width = 220
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
        end
        item
          FieldName = 'ENLEM'
          Title.Caption = 'Enlem'
          Width = 75
        end
        item
          FieldName = 'BOYLAM'
          Title.Caption = 'Boylam'
          Width = 75
        end>
    end
    object panAlt: TUniPanel
      Left = 0
      Top = 568
      Width = 960
      Height = 52
      Hint = ''
      TabOrder = 2
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      LayoutConfig.Width = '100%'
      object lblSecili: TUniLabel
        Left = 12
        Top = 18
        Width = 50
        Height = 13
        Hint = ''
        Caption = 'Se'#231'ili: 0'
        TabOrder = 0
      end
      object btnHarita: TUniButton
        Left = 280
        Top = 10
        Width = 140
        Height = 32
        Hint = ''
        Caption = 'Haritada g'#246'ster'
        TabOrder = 1
        OnClick = btnHaritaClick
      end
      object btnRotayaEkle: TUniButton
        Left = 440
        Top = 10
        Width = 140
        Height = 32
        Hint = ''
        Caption = 'Rotaya ekle'
        TabOrder = 2
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
        OnClick = btnRotayaEkleClick
      end
      object btnKapat: TUniButton
        Left = 840
        Top = 10
        Width = 100
        Height = 32
        Hint = ''
        Caption = 'Kapat'
        TabOrder = 3
        OnClick = btnKapatClick
      end
    end
  end
  object qList: TUniQuery
    Connection = frmDM.conAsya
    Left = 40
    Top = 560
  end
  object dsList: TUniDataSource
    DataSet = qList
    Left = 72
    Top = 560
  end
  object qIl: TUniQuery
    Connection = frmDM.conAsya
    Left = 104
    Top = 560
  end
  object qIlce: TUniQuery
    Connection = frmDM.conAsya
    Left = 136
    Top = 560
  end
end
