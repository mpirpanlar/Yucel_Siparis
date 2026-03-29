object frmCrmTeklifListe: TfrmCrmTeklifListe
  Left = 0
  Top = 0
  ClientHeight = 560
  ClientWidth = 900
  Caption = 'frmCrmTeklifListe'
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
    Height = 560
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
    object panFilt: TUniPanel
      Left = 0
      Top = 48
      Width = 900
      Height = 72
      Hint = ''
      Align = alTop
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      object lblFiltCari: TUniLabel
        Left = 8
        Top = 12
        Width = 28
        Height = 17
        Hint = ''
        Caption = 'Cari'
        TabOrder = 0
      end
      object edFiltCari: TUniEdit
        Left = 40
        Top = 8
        Width = 88
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 1
      end
      object lblFiltNo: TUniLabel
        Left = 136
        Top = 12
        Width = 50
        Height = 17
        Hint = ''
        Caption = 'Teklif no'
        TabOrder = 2
      end
      object edFiltNo: TUniEdit
        Left = 190
        Top = 8
        Width = 80
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 3
      end
      object chkTarih: TUniCheckBox
        Left = 278
        Top = 10
        Width = 110
        Height = 22
        Hint = ''
        Caption = 'Tarih filtresi'
        TabOrder = 4
      end
      object lblFiltTarBas: TUniLabel
        Left = 390
        Top = 12
        Width = 20
        Height = 17
        Hint = ''
        Caption = 'Bas'
        TabOrder = 5
      end
      object dtFiltBas: TUniDateTimePicker
        Left = 414
        Top = 8
        Width = 118
        Height = 27
        Hint = ''
        DateFormat = 'dd/MM/yyyy'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 6
      end
      object lblFiltTarBit: TUniLabel
        Left = 538
        Top = 12
        Width = 18
        Height = 17
        Hint = ''
        Caption = 'Bit'
        TabOrder = 7
      end
      object dtFiltBit: TUniDateTimePicker
        Left = 560
        Top = 8
        Width = 118
        Height = 27
        Hint = ''
        DateFormat = 'dd/MM/yyyy'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 8
      end
      object lblFiltDur: TUniLabel
        Left = 686
        Top = 12
        Width = 38
        Height = 17
        Hint = ''
        Caption = 'Durum'
        TabOrder = 9
      end
      object cbFiltDurum: TUniComboBox
        Left = 728
        Top = 8
        Width = 160
        Height = 27
        Hint = ''
        Style = csDropDownList
        Text = ''
        TabOrder = 10
      end
      object lblFiltSip: TUniLabel
        Left = 8
        Top = 44
        Width = 70
        Height = 17
        Hint = ''
        Caption = 'Siparis no'
        TabOrder = 11
      end
      object edFiltSip: TUniEdit
        Left = 82
        Top = 40
        Width = 140
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 12
      end
    end
    object grd: TUniDBGrid
      Left = 0
      Top = 120
      Width = 900
      Height = 440
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
          FieldName = 'TEKLIF_ID'
          Title.Caption = 'ID'
          Width = 50
        end
        item
          FieldName = 'TEKLIF_NO'
          Title.Caption = 'Teklif no'
          Width = 100
        end
        item
          FieldName = 'SIPARIS_NO'
          Title.Caption = 'Siparis no'
          Width = 90
        end
        item
          FieldName = 'CARI_KOD'
          Title.Caption = 'Cari'
          Width = 80
        end
        item
          FieldName = 'BASLIK'
          Title.Caption = 'Baslik'
          Width = 200
        end
        item
          FieldName = 'TEKLIF_TARIHI'
          Title.Caption = 'Tarih'
          Width = 115
        end
        item
          FieldName = 'DURUM'
          Title.Caption = 'Durum'
          Width = 75
        end
        item
          FieldName = 'TOPLAM_NET'
          Title.Caption = 'Toplam'
          Width = 85
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
  object qFilt: TUniQuery
    Connection = frmDM.conAsya
    Left = 800
    Top = 408
  end
end
