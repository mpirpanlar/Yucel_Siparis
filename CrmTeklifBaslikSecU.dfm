object frmCrmTeklifBaslikSec: TfrmCrmTeklifBaslikSec
  Left = 0
  Top = 0
  ClientHeight = 520
  ClientWidth = 920
  Caption = 'Teklif Se'#231'imi (Sipari'#351' Ba'#351'l'#305#287#305')'
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
      Width = 520
      Height = 13
      Hint = ''
      Caption = 
        'Netsis''e g'#246'nderilmemi'#351' sipari'#351' ba'#351'l'#305#287#305' kayitlari. FisNo / cari ' +
        'kod yazip Listele; se'#231'ili sat'#305'r'#305' Se'#231' veya '#231'ift t'#305'klay'#305'n.'
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
      EmptyText = 'FisNo / cari kod / cari ad'
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
      Hint = 'Secili teklif fis numarasini aktarir'
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
  object grdTeklif: TUniDBGrid
    Left = 0
    Top = 92
    Width = 920
    Height = 428
    Hint = ''
    DataSource = dsTeklif
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
    ReadOnly = True
    WebOptions.Paged = False
    WebOptions.FetchAll = True
    LoadMask.Message = 'Loading data...'
    Align = alClient
    TabOrder = 1
    OnAjaxEvent = grdTeklifAjaxEvent
    Columns = <
      item
        FieldName = 'FisNo'
        Title.Caption = 'Fis No'
        Width = 140
        ReadOnly = True
      end
      item
        FieldName = 'CariKod'
        Title.Caption = 'Cari Kod'
        Width = 100
        ReadOnly = True
      end
      item
        FieldName = 'CARI_AD'
        Title.Caption = 'Cari Ad'
        Width = 200
        ReadOnly = True
      end
      item
        FieldName = 'Tarih'
        Title.Caption = 'Tarih'
        Width = 100
        ReadOnly = True
      end
      item
        FieldName = 'Saat'
        Title.Caption = 'Saat'
        Width = 80
        ReadOnly = True
      end
      item
        FieldName = 'NetsisSiparisNo'
        Title.Caption = 'Netsis Sip.No'
        Width = 120
        ReadOnly = True
      end>
  end
  object qTeklif: TUniQuery
    Connection = frmDM.conAsya
    Left = 800
    Top = 400
  end
  object dsTeklif: TUniDataSource
    DataSet = qTeklif
    Left = 832
    Top = 400
  end
end
