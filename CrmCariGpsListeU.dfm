object frmCrmCariGpsListe: TfrmCrmCariGpsListe
  Left = 0
  Top = 0
  ClientHeight = 520
  ClientWidth = 980
  Caption = 'CRM - Netsis Cari GPS Listesi'
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
    Width = 980
    Height = 520
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
      Height = 52
      Hint = ''
      TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      Color = 10865101
      LayoutConfig.Width = '100%'
      object lblArama: TUniLabel
        Left = 12
        Top = 16
        Width = 58
        Height = 15
        Hint = ''
        Caption = 'Cari ara'
        TabOrder = 0
      end
      object edArama: TUniEdit
        Left = 76
        Top = 10
        Width = 320
        Height = 28
        Hint = ''
        Text = ''
        TabOrder = 1
        OnKeyPress = edAramaKeyPress
      end
      object btnListele: TUniButton
        Left = 408
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
        TabOrder = 2
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
        OnClick = btnListeleClick
      end
      object btnAc: TUniButton
        Left = 528
        Top = 8
        Width = 160
        Height = 32
        Hint = ''
        Caption = 'GPS Kayd'#305'n'#305' A'#231
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 3
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'secondary'#39';'#13#10'}')
        OnClick = btnAcClick
      end
      object btnKapat: TUniButton
        Left = 880
        Top = 0
        Width = 100
        Height = 52
        Hint = ''
        Caption = 'Kapat'
        Align = alRight
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
    object grd: TUniDBGrid
      Left = 0
      Top = 0
      Width = 980
      Height = 468
      Hint = ''
      DataSource = dsList
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
      ReadOnly = True
      WebOptions.Paged = False
      WebOptions.FetchAll = True
      LoadMask.Message = 'Y'#252'kleniyor...'
      LayoutConfig.Flex = 1
      LayoutConfig.Height = '100%'
      LayoutConfig.Width = '100%'
      ClientEvents.UniEvents.Strings = (
        
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'  config.force' +
            'Fit = true;'#13#10'}')
      TabOrder = 1
      OnAjaxEvent = grdAjaxEvent
      Columns = <
        item
          FieldName = 'CARI_KOD'
          Title.Caption = 'Cari kod'
          Width = 110
          ReadOnly = True
        end
        item
          FieldName = 'CARI_ISIM'
          Title.Caption = 'Cari adi'
          Width = 320
          ReadOnly = True
        end
        item
          FieldName = 'CARI_IL'
          Title.Caption = 'Il'
          Width = 90
          ReadOnly = True
        end
        item
          FieldName = 'CARI_ILCE'
          Title.Caption = 'Ilce'
          Width = 90
          ReadOnly = True
        end
        item
          FieldName = 'KULL1N'
          Title.Caption = 'GPS Enlem (KULL1N)'
          Width = 140
          ReadOnly = True
        end
        item
          FieldName = 'KULL2N'
          Title.Caption = 'GPS Boylam (KULL2N)'
          Width = 140
          ReadOnly = True
        end>
    end
  end
  object qList: TUniQuery
    Connection = frmDM.conNetsis
    Left = 800
    Top = 400
  end
  object dsList: TUniDataSource
    DataSet = qList
    Left = 832
    Top = 400
  end
end
