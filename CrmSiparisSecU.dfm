object frmCrmSiparisSec: TfrmCrmSiparisSec
  Left = 0
  Top = 0
  ClientHeight = 520
  ClientWidth = 920
  Caption = 'Netsis Sipari'#351' Se'#231'imi'
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  BorderIcons = [biSystemMenu]
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  TextHeight = 15
  object pnlToolbar: TUniPanel
    Left = 0
    Top = 0
    Width = 920
    Height = 92
    Hint = ''
    Align = alTop
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    object lblBilgi: TUniLabel
      Left = 12
      Top = 8
      Width = 420
      Height = 13
      Hint = ''
      Caption = 
        'Netsis sipari'#351' kodu / a'#231#305'klama yaz'#305'p Listele; se'#231'ili sat'#305'r'#305' Se'#231 +
        ' veya '#231'ift t'#305'klay'#305'n.'
      ParentFont = False
      Font.Charset = TURKISH_CHARSET
      Font.Color = clGray
      Font.Height = -12
      TabOrder = 0
    end
    object edArama: TUniEdit
      Left = 12
      Top = 44
      Width = 420
      Height = 28
      Hint = ''
      Text = ''
      ParentFont = False
      Font.Charset = TURKISH_CHARSET
      Font.Height = -13
      TabOrder = 1
      EmptyText = 'Sipari'#351' kod / a'#231#305'klama / cari'
      ClearButton = True
      OnKeyPress = edAramaKeyPress
    end
    object btnListele: TUniButton
      Left = 442
      Top = 42
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
      ScreenMask.Enabled = True
      ScreenMask.Message = 'Yukleniyor...'
      OnClick = btnListeleClick
    end
    object btnSec: TUniButton
      Left = 562
      Top = 42
      Width = 120
      Height = 32
      Hint = 'Secili siparisi aktarir'
      Caption = 'Se'#231
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
      Left = 692
      Top = 42
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
        'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      config.' +
        'cls="btnKapat";'#13#10'}')
      OnClick = btnKapatClick
    end
  end
  object grdSiparis: TUniDBGrid
    Left = 0
    Top = 92
    Width = 920
    Height = 428
    Hint = ''
    DataSource = dsSiparis
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
    ReadOnly = True
    WebOptions.Paged = False
    WebOptions.FetchAll = True
    LoadMask.Message = 'Loading data...'
    Align = alClient
    TabOrder = 1
    OnAjaxEvent = grdSiparisAjaxEvent
    Columns = <
      item
        FieldName = 'SIPARIS_KOD'
        Title.Caption = 'Kod'
        Width = 120
        ReadOnly = True
      end
      item
        FieldName = 'SIPARIS_TARIHI'
        Title.Caption = 'Tarih'
        Width = 100
        ReadOnly = True
      end
      item
        FieldName = 'SIPARIS_ACIKLAMA'
        Title.Caption = 'A'#231#305'klama'
        Width = 260
        ReadOnly = True
      end
      item
        FieldName = 'CARI_KOD'
        Title.Caption = 'Cari Kod'
        Width = 90
        ReadOnly = True
      end
      item
        FieldName = 'CARI_ISIM'
        Title.Caption = 'Cari '#220'nvan'
        Width = 200
        ReadOnly = True
      end>
  end
  object qSiparis: TUniQuery
    Connection = frmDM.conNetsis
    Left = 800
    Top = 400
  end
  object dsSiparis: TUniDataSource
    DataSet = qSiparis
    Left = 832
    Top = 400
  end
end
