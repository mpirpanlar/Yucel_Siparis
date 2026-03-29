object frmCrmParamAktiviteDurum: TfrmCrmParamAktiviteDurum
  Left = 0
  Top = 0
  ClientHeight = 520
  ClientWidth = 880
  Caption = 'CRM - Aktivite Durumlar'#305
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
    Width = 880
    Height = 520
    Hint = ''
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    object pnlToolbar: TUniPanel
      Left = 0
      Top = 0
      Width = 880
      Height = 44
      Hint = ''
      Align = alTop
      TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      Color = 10865101
      object btnListele: TUniButton
        Left = 8
        Top = 6
        Width = 90
        Height = 30
        Hint = ''
        Caption = 'Listele'
        TabOrder = 0
        ClientEvents.UniEvents.Strings = (
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
          'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
        OnClick = btnListeleClick
      end
      object btnYeni: TUniButton
        Left = 104
        Top = 6
        Width = 90
        Height = 30
        Hint = ''
        Caption = 'Yeni'
        TabOrder = 1
        ClientEvents.UniEvents.Strings = (
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
          'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'secondary'#39';'#13#10'}')
        OnClick = btnYeniClick
      end
      object btnKaydet: TUniButton
        Left = 200
        Top = 6
        Width = 100
        Height = 30
        Hint = ''
        Caption = 'Kaydet'
        TabOrder = 2
        ClientEvents.UniEvents.Strings = (
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
          'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
        OnClick = btnKaydetClick
      end
      object btnKapat: TUniButton
        Left = 770
        Top = 6
        Width = 100
        Height = 30
        Hint = ''
        Align = alRight
        Caption = 'Kapat'
        TabOrder = 3
        ClientEvents.UniEvents.Strings = (
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
          'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'secondary'#39';'#13#10'}')
        OnClick = btnKapatClick
      end
    end
    object panDetay: TUniPanel
      Left = 0
      Top = 44
      Width = 880
      Height = 96
      Hint = ''
      Align = alTop
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      object lblKod: TUniLabel
        Left = 12
        Top = 12
        Width = 80
        Height = 17
        Hint = ''
        Caption = 'Kod'
        TabOrder = 0
      end
      object edKod: TUniEdit
        Left = 100
        Top = 8
        Width = 160
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 1
      end
      object lblAciklama: TUniLabel
        Left = 280
        Top = 12
        Width = 80
        Height = 17
        Hint = ''
        Caption = 'Aciklama'
        TabOrder = 2
      end
      object edAciklama: TUniEdit
        Left = 360
        Top = 8
        Width = 500
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 3
      end
      object chkAktif: TUniCheckBox
        Left = 100
        Top = 44
        Width = 120
        Height = 22
        Hint = ''
        Caption = 'Aktif'
        TabOrder = 4
      end
      object lblSira: TUniLabel
        Left = 240
        Top = 46
        Width = 60
        Height = 17
        Hint = ''
        Caption = 'Sira'
        TabOrder = 5
      end
      object edSira: TUniEdit
        Left = 300
        Top = 42
        Width = 80
        Height = 27
        Hint = ''
        Text = '0'
        TabOrder = 6
      end
    end
    object grd: TUniDBGrid
      Left = 0
      Top = 140
      Width = 880
      Height = 380
      Hint = ''
      Align = alClient
      DataSource = dsDur
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
      ReadOnly = True
      WebOptions.Paged = False
      WebOptions.FetchAll = True
      TabOrder = 2
    end
  end
  object qDur: TUniQuery
    Connection = frmDM.conAsya
    Left = 760
    Top = 300
  end
  object dsDur: TUniDataSource
    DataSet = qDur
    OnDataChange = dsDurDataChange
    Left = 792
    Top = 300
  end
  object qExec: TUniQuery
    Connection = frmDM.conAsya
    Left = 760
    Top = 348
  end
end
