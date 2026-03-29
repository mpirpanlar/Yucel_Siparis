object frmCrmStokSec: TfrmCrmStokSec
  Left = 0
  Top = 0
  ClientHeight = 520
  ClientWidth = 920
  Caption = 'Netsis Stok Secimi'
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
      Width = 890
      Height = 28
      Hint = ''
      Caption = 
        'Stok kodu veya arama metni yazip Listele (Siparis teki HSP_STOKLISTESI); satiri secip Sec veya cift tiklayin. Birim fiyat SATIS_FIAT1 ile doldurulur.'
      ParentFont = False
      Font.Charset = TURKISH_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Segoe UI'
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
      Font.Name = 'Segoe UI'
      TabOrder = 1
      EmptyText = 'Stok kod / ad'
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
      Hint = 'Secili satiri teklif satirina aktarir'
      Caption = 'Sec'
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
  object grdStok: TUniDBGrid
    Left = 0
    Top = 92
    Width = 920
    Height = 428
    Hint = ''
    Align = alClient
    DataSource = dsStok
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
    ReadOnly = True
    WebOptions.Paged = False
    WebOptions.FetchAll = True
    TabOrder = 1
    OnAjaxEvent = grdStokAjaxEvent
    Columns = <
      item
        FieldName = 'STOK_KODU'
        Title.Caption = 'Stok kod'
        Width = 110
      end
      item
        FieldName = 'STOK_ADI'
        Title.Caption = 'Stok adi'
        Width = 280
      end
      item
        FieldName = 'SATIS_FIAT1'
        Title.Caption = 'Satis fiat 1'
        Width = 90
      end>
  end
  object dsStok: TUniDataSource
    DataSet = spStokListe
    Left = 832
    Top = 400
  end
  object spStokListe: TUniStoredProc
    StoredProcName = 'HSP_STOKLISTESI;1'
    SQL.Strings = (
      '{:RETURN_VALUE = CALL HSP_STOKLISTESI;1 (:sube, :depo, :stok)}')
    Connection = frmDM.conNetsis
    Left = 784
    Top = 400
    ParamData = <
      item
        DataType = ftInteger
        Name = 'RETURN_VALUE'
        ParamType = ptResult
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'sube'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftInteger
        Name = 'depo'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'stok'
        ParamType = ptInput
        Size = 50
        Value = nil
      end>
    CommandStoredProcName = 'HSP_STOKLISTESI;1'
  end
end
