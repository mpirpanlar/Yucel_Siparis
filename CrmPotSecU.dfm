object frmCrmPotSec: TfrmCrmPotSec
  Left = 0
  Top = 0
  ClientHeight = 520
  ClientWidth = 900
  Caption = 'CRM - Potansiyel Secimi'
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
      Width = 329
      Height = 13
      Hint = ''
      Caption = 
        'Firma unvani / Netsis kodu yazip Listele; satir secip Sec veya sa' +
        'tira cift tiklayin.'
      ParentFont = False
      Font.Charset = TURKISH_CHARSET
      Font.Color = clGray
      Font.Height = -12
      TabOrder = 0
    end
    object lblSecili: TUniLabel
      Left = 12
      Top = 28
      Width = 60
      Height = 13
      Hint = ''
      Visible = False
      Caption = 'Secili: 0'
      ParentFont = False
      Font.Charset = TURKISH_CHARSET
      Font.Color = clGray
      Font.Height = -12
      TabOrder = 5
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
      EmptyText = 'Firma unvan / Netsis kod'
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
  object grdPot: TUniDBGrid
    Left = 0
    Top = 92
    Width = 900
    Height = 428
    Hint = ''
    DataSource = dsPot
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgCheckSelect, dgCheckSelectCheckOnly, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
    ReadOnly = True
    WebOptions.Paged = False
    WebOptions.FetchAll = True
    LoadMask.Message = 'Loading data...'
    Align = alClient
    TabOrder = 1
    OnAjaxEvent = grdPotAjaxEvent
    OnSelectionChange = grdPotSelectionChange
  end
  object qPot: TUniQuery
    Connection = frmDM.conAsya
    Left = 800
    Top = 400
  end
  object dsPot: TUniDataSource
    DataSet = qPot
    Left = 832
    Top = 400
  end
end
