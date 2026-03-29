object frmCrmGorevListe: TfrmCrmGorevListe
  Left = 0
  Top = 0
  ClientHeight = 480
  ClientWidth = 900
  Caption = 'CRM - Gorev listesi'
  OnShow = UniFormShow
  BorderStyle = bsNone
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  PixelsPerInch = 96
  TextHeight = 13
  object rootPanel: TUniPanel
    Left = 0
    Top = 0
    Width = 900
    Height = 480
    Hint = ''
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    object pnlToolbar: TUniPanel
      Left = 0
      Top = 0
      Width = 900
      Height = 48
      Hint = ''
      Align = alTop
      TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      Color = 10865101
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
        Caption = 'Kaydi ac'
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
        Left = 788
        Top = 8
        Width = 100
        Height = 32
        Hint = ''
        Align = alRight
        Caption = 'Kapat'
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
    object grd: TUniDBGrid
      Left = 0
      Top = 48
      Width = 900
      Height = 432
      Hint = ''
      Align = alClient
      DataSource = dsList
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
      ReadOnly = True
      WebOptions.Paged = False
      WebOptions.FetchAll = True
      TabOrder = 1
      OnAjaxEvent = grdAjaxEvent
      Columns = <
        item
          FieldName = 'GOREV_ID'
          Title.Caption = 'Gorev ID'
          Width = 70
        end
        item
          FieldName = 'AKTIVITE_ID'
          Title.Caption = 'Akt. ID'
          Width = 60
        end
        item
          FieldName = 'KONU'
          Title.Caption = 'Konu'
          Width = 220
        end
        item
          FieldName = 'CARI_KOD'
          Title.Caption = 'Cari'
          Width = 90
        end
        item
          FieldName = 'TEKLIF_NO'
          Title.Caption = 'Teklif no'
          Width = 100
        end
        item
          FieldName = 'DURUM'
          Title.Caption = 'Durum'
          Width = 75
        end
        item
          FieldName = 'BITIS_TARIHI'
          Title.Caption = 'Termin'
          Width = 115
        end
        item
          FieldName = 'ONCELIK'
          Title.Caption = 'Oncelik'
          Width = 70
        end
        item
          FieldName = 'TAMAMLANDI'
          Title.Caption = 'Tamam'
          Width = 55
        end>
    end
  end
  object qList: TUniQuery
    Connection = frmDM.conAsya
    Left = 800
    Top = 360
  end
  object dsList: TUniDataSource
    DataSet = qList
    Left = 832
    Top = 360
  end
end
