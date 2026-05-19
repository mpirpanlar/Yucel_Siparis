object frmCrmRotaListe: TfrmCrmRotaListe
  Left = 0
  Top = 0
  ClientHeight = 560
  ClientWidth = 1000
  Caption = 'CRM - Rota planlama listesi'
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
        TabOrder = 0
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
        OnClick = btnListeleClick
      end
      object btnYeni: TUniButton
        Left = 120
        Top = 8
        Width = 120
        Height = 32
        Hint = ''
        Caption = 'Yeni rota'
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
        OnClick = btnYeniClick
      end
      object btnAc: TUniButton
        Left = 248
        Top = 8
        Width = 120
        Height = 32
        Hint = ''
        Caption = 'Kayd'#305' a'#231
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
        OnClick = btnAcClick
      end
      object btnSil: TUniButton
        Left = 376
        Top = 8
        Width = 100
        Height = 32
        Hint = ''
        Caption = 'Sil'
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
        OnClick = btnSilClick
      end
      object btnKapat: TUniButton
        Left = 888
        Top = 8
        Width = 100
        Height = 32
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
    object panFilt: TUniPanel
      Left = 0
      Top = 48
      Width = 1000
      Height = 64
      Hint = ''
      Align = alTop
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      object lblFiltBaslik: TUniLabel
        Left = 12
        Top = 16
        Width = 80
        Height = 17
        Hint = ''
        Caption = 'Ba'#351'l'#305'k filtre'
        TabOrder = 0
      end
      object edFiltBaslik: TUniEdit
        Left = 96
        Top = 12
        Width = 360
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 1
      end
    end
    object grd: TUniDBGrid
      Left = 0
      Top = 112
      Width = 1000
      Height = 448
      Hint = ''
      DataSource = dsList
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
      ReadOnly = True
      WebOptions.Paged = False
      WebOptions.FetchAll = True
      LoadMask.Message = 'Y'#252'kleniyor...'
      Align = alClient
      TabOrder = 2
      OnAjaxEvent = grdAjaxEvent
      Columns = <
        item
          FieldName = 'ROTA_ID'
          Title.Caption = 'ID'
          Width = 55
        end
        item
          FieldName = 'BASLIK'
          Title.Caption = 'Ba'#351'l'#305'k'
          Width = 280
        end
        item
          FieldName = 'DURUM'
          Title.Caption = 'Durum'
          Width = 80
        end
        item
          FieldName = 'PLANLAMA_TARIHI'
          Title.Caption = 'Plan tarihi'
          Width = 100
        end
        item
          FieldName = 'OLUSTURMA_UTC'
          Title.Caption = 'Olu'#351'turma'
          Width = 130
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
  object qExec: TUniQuery
    Connection = frmDM.conAsya
    Left = 808
    Top = 360
  end
  object saSil: TUniSweetAlert
    Title = 'Rota sil'
    Text = 'Se'#231'ili rota ve t'#252'm duraklar'#305' silinecek. Emin misiniz?'
    ConfirmButtonText = 'Evet, sil'
    CancelButtonText = #304'ptal'
    AlertType = atQuestion
    Padding = 20
    ShowCancelButton = True
    OnConfirm = saSilConfirm
    Left = 776
    Top = 360
  end
  object saSilOk: TUniSweetAlert
    Title = 'Title'
    TitleText = 'Silme '#304#351'lemi Ba'#351'ar'#305'l'#305'.'
    ConfirmButtonText = 'Tamam'
    CancelButtonText = 'Cancel'
    Padding = 20
    Left = 744
    Top = 360
  end
end
