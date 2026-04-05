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
  PixelsPerInch = 96
  TextHeight = 13
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
        TabOrder = 0
        OnClick = btnListeleClick
      end
      object btnYeni: TUniButton
        Left = 120
        Top = 8
        Width = 120
        Height = 32
        Hint = ''
        Caption = 'Yeni rota'
        TabOrder = 1
        OnClick = btnYeniClick
      end
      object btnAc: TUniButton
        Left = 248
        Top = 8
        Width = 100
        Height = 32
        Hint = ''
        Caption = 'Ac'
        TabOrder = 2
        OnClick = btnAcClick
      end
      object btnKapat: TUniButton
        Left = 880
        Top = 8
        Width = 100
        Height = 32
        Hint = ''
        Caption = 'Kapat'
        TabOrder = 3
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
      object lblFiltBaslik: TUniLabel
        Left = 12
        Top = 16
        Width = 80
        Height = 17
        Hint = ''
        Caption = 'Baslik filtre'
      end
      object edFiltBaslik: TUniEdit
        Left = 96
        Top = 12
        Width = 360
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 0
      end
    end
    object grd: TUniDBGrid
      Left = 0
      Top = 112
      Width = 1000
      Height = 448
      Hint = ''
      Align = alClient
      DataSource = dsList
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
      ReadOnly = True
      WebOptions.Paged = False
      WebOptions.FetchAll = True
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
          Title.Caption = 'Baslik'
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
          Title.Caption = 'Olusturma'
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
end
