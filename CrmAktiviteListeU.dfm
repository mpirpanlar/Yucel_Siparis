object frmCrmAktiviteListe: TfrmCrmAktiviteListe
  Left = 0
  Top = 0
  ClientHeight = 480
  ClientWidth = 900
  Caption = 'frmCrmAktiviteListe'
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
        Caption = 'Kayd'#305' A'#231
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
        Left = 800
        Top = 0
        Width = 100
        Height = 48
        Hint = ''
        Caption = 'Kapat'
        Align = alRight
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
      DataSource = dsList
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
      ReadOnly = True
      WebOptions.Paged = False
      WebOptions.FetchAll = True
      LoadMask.Message = 'Loading data...'
      Align = alClient
      TabOrder = 1
      OnAjaxEvent = grdAjaxEvent
      Columns = <
        item
          FieldName = 'AKTIVITE_ID'
          Title.Caption = 'ID'
          Width = 55
          ReadOnly = True
        end
        item
          FieldName = 'TIP'
          Title.Caption = 'Tip'
          Width = 70
          ReadOnly = True
        end
        item
          FieldName = 'KONU'
          Title.Caption = 'Konu'
          Width = 260
          ReadOnly = True
        end
        item
          FieldName = 'CARI_KOD'
          Title.Caption = 'Cari'
          Width = 90
          ReadOnly = True
        end
        item
          FieldName = 'TEKLIF_NO'
          Title.Caption = 'Teklif no'
          Width = 100
          ReadOnly = True
        end
        item
          FieldName = 'SIPARIS_NO'
          Title.Caption = 'Siparis no'
          Width = 90
          ReadOnly = True
        end
        item
          FieldName = 'AKTIVITE_TARIHI'
          Title.Caption = 'Tarih'
          Width = 120
          ReadOnly = True
        end
        item
          FieldName = 'DURUM'
          Title.Caption = 'Durum'
          Width = 80
          ReadOnly = True
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
