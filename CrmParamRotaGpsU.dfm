object frmCrmParamRotaGps: TfrmCrmParamRotaGps
  Left = 0
  Top = 0
  ClientHeight = 560
  ClientWidth = 920
  Caption = 'CRM - Rota GPS Tan'#305'mlar'#305
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
    Width = 920
    Height = 560
    Hint = ''
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    Layout = 'vbox'
    object pnlToolbar: TUniPanel
      Left = 0
      Top = 0
      Width = 920
      Height = 44
      Hint = ''
      TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      Color = 10865101
      LayoutConfig.Width = '100%'
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
      object btnKaydet: TUniButton
        Left = 104
        Top = 6
        Width = 100
        Height = 30
        Hint = ''
        Caption = 'Kaydet'
        TabOrder = 1
        ClientEvents.UniEvents.Strings = (
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
          'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
        OnClick = btnKaydetClick
      end
      object btnKapat: TUniButton
        Left = 810
        Top = 6
        Width = 100
        Height = 30
        Hint = ''
        Align = alRight
        Caption = 'Kapat'
        TabOrder = 2
        ClientEvents.UniEvents.Strings = (
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
          'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'secondary'#39';'#13#10'}')
        OnClick = btnKapatClick
      end
    end
    object panDetay: TUniPanel
      Left = 0
      Top = 44
      Width = 920
      Height = 132
      Hint = ''
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      LayoutConfig.Width = '100%'
      object lblSube: TUniLabel
        Left = 12
        Top = 12
        Width = 80
        Height = 17
        Hint = ''
        Caption = #350'ube kodu'
        TabOrder = 0
      end
      object edSubeKodu: TUniEdit
        Left = 100
        Top = 8
        Width = 80
        Height = 27
        Hint = ''
        ReadOnly = True
        Text = ''
        TabOrder = 1
      end
      object lblBasBaslik: TUniLabel
        Left = 12
        Top = 48
        Width = 120
        Height = 17
        Hint = ''
        Caption = 'Ba'#351'lang'#305#231' (GPSX / GPSY)'
        ParentFont = False
        Font.Style = [fsBold]
        TabOrder = 2
      end
      object edBasEnlem: TUniEdit
        Left = 140
        Top = 44
        Width = 140
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 3
        FieldLabel = 'Enlem (GPSX)'
        FieldLabelWidth = 100
      end
      object edBasBoylam: TUniEdit
        Left = 400
        Top = 44
        Width = 140
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 4
        FieldLabel = 'Boylam (GPSY)'
        FieldLabelWidth = 100
      end
      object btnHarBas: TUniButton
        Left = 560
        Top = 42
        Width = 120
        Height = 30
        Hint = ''
        Caption = 'Haritadan'
        TabOrder = 5
        OnClick = btnHarBasClick
      end
      object lblBitBaslik: TUniLabel
        Left = 12
        Top = 88
        Width = 120
        Height = 17
        Hint = ''
        Caption = 'Biti'#351' (enlem / boylam)'
        ParentFont = False
        Font.Style = [fsBold]
        TabOrder = 6
      end
      object edBitEnlem: TUniEdit
        Left = 140
        Top = 84
        Width = 140
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 7
        FieldLabel = 'Biti'#351' enlem'
        FieldLabelWidth = 100
      end
      object edBitBoylam: TUniEdit
        Left = 400
        Top = 84
        Width = 140
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 8
        FieldLabel = 'Biti'#351' boylam'
        FieldLabelWidth = 100
      end
      object btnHarBit: TUniButton
        Left = 560
        Top = 82
        Width = 120
        Height = 30
        Hint = ''
        Caption = 'Haritadan'
        TabOrder = 9
        OnClick = btnHarBitClick
      end
    end
    object grd: TUniDBGrid
      Left = 0
      Top = 176
      Width = 920
      Height = 384
      Hint = ''
      DataSource = dsParam
      LayoutConfig.Flex = 1
      LayoutConfig.Height = '100%'
      LayoutConfig.Width = '100%'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
      ReadOnly = True
      WebOptions.Paged = False
      WebOptions.FetchAll = True
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          FieldName = 'SUBE_KODU'
          Title.Caption = #350'ube'
          Width = 64
        end
        item
          FieldName = 'GPSX'
          Title.Caption = 'Ba'#351'lang'#305#231' enlem'
          Width = 110
        end
        item
          FieldName = 'GPSY'
          Title.Caption = 'Ba'#351'lang'#305#231' boylam'
          Width = 110
        end
        item
          FieldName = 'ROTA_BITIS_ENLEM'
          Title.Caption = 'Biti'#351' enlem'
          Width = 110
        end
        item
          FieldName = 'ROTA_BITIS_BOYLAM'
          Title.Caption = 'Biti'#351' boylam'
          Width = 110
        end>
    end
  end
  object qParam: TUniQuery
    Connection = frmDM.conAsya
    Left = 760
    Top = 300
  end
  object dsParam: TUniDataSource
    DataSet = qParam
    OnDataChange = dsParamDataChange
    Left = 792
    Top = 300
  end
  object qExec: TUniQuery
    Connection = frmDM.conAsya
    Left = 760
    Top = 348
  end
end
