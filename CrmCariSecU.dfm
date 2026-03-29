object frmCrmCariSec: TfrmCrmCariSec
  Left = 0
  Top = 0
  ClientHeight = 520
  ClientWidth = 900
  Caption = 'Netsis Cari Secimi'
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
    Width = 900
    Height = 92
    Hint = ''
    Align = alTop
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    object lblBilgi: TUniLabel
      Left = 12
      Top = 8
      Width = 870
      Height = 28
      Hint = ''
      Caption = 'Cari adi/kodu yazip Listele; satir secip Se'#351' veya satira cift tiklayin.'
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
      EmptyText = 'Cari ad / kod'
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
      Hint = 'Secili satiri aktarir'
      Caption = 'Se'#351
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
  object grdCari: TUniDBGrid
    Left = 0
    Top = 92
    Width = 900
    Height = 428
    Hint = ''
    Align = alClient
    DataSource = dsCari
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
    ReadOnly = True
    WebOptions.Paged = False
    WebOptions.FetchAll = True
    TabOrder = 1
    OnAjaxEvent = grdCariAjaxEvent
  end
  object qCari: TUniQuery
    Connection = frmDM.conNetsis
    Left = 800
    Top = 400
  end
  object dsCari: TUniDataSource
    DataSet = qCari
    Left = 832
    Top = 400
  end
end
