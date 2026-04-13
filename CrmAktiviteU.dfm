object frmCrmAktivite: TfrmCrmAktivite
  Left = 0
  Top = 0
  ClientHeight = 512
  ClientWidth = 640
  Caption = 'Yeni Aktivite'
  OnShow = UniFormShow
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  TextHeight = 15
  object rootPanel: TUniPanel
    Left = 0
    Top = 0
    Width = 640
    Height = 512
    Hint = ''
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    object panMain: TUniPanel
      Left = 0
      Top = 0
      Width = 640
      Height = 460
      Hint = ''
      Align = alClient
      TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      object lblTip: TUniLabel
        Left = 16
        Top = 16
        Width = 15
        Height = 13
        Hint = ''
        Caption = 'Tip'
        TabOrder = 0
      end
      object lkTip: TUniDBLookupComboBox
        Left = 120
        Top = 12
        Width = 480
        Height = 27
        Hint = ''
        ListField = 'AD'
        ListSource = dsTipLkp
        KeyField = 'TIP_ID'
        ListFieldIndex = 0
        TabOrder = 1
        Color = clWindow
      end
      object lblKonu: TUniLabel
        Left = 16
        Top = 52
        Width = 27
        Height = 13
        Hint = ''
        Caption = 'Konu'
        TabOrder = 2
      end
      object edKonu: TUniEdit
        Left = 120
        Top = 48
        Width = 480
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 3
      end
      object lblAciklama: TUniLabel
        Left = 16
        Top = 88
        Width = 45
        Height = 13
        Hint = ''
        Caption = 'A'#231#305'klama'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Height = -12
        TabOrder = 4
      end
      object mmAciklama: TUniMemo
        Left = 120
        Top = 84
        Width = 480
        Height = 88
        Hint = ''
        TabOrder = 5
      end
      object lblCari: TUniLabel
        Left = 16
        Top = 184
        Width = 60
        Height = 13
        Hint = ''
        Caption = 'Cari (Netsis)'
        TabOrder = 6
      end
      object edCariKod: TUniEdit
        Left = 120
        Top = 180
        Width = 340
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 7
      end
      object btnCariBul: TUniButton
        Left = 470
        Top = 178
        Width = 130
        Height = 30
        Hint = 'Netsis cari listesi'
        Caption = 'Cari listele'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 8
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
        OnClick = btnCariBulClick
      end
      object lblTeklif: TUniLabel
        Left = 16
        Top = 220
        Width = 55
        Height = 13
        Hint = ''
        Caption = 'Bagli teklif'
        TabOrder = 9
      end
      object lkTeklif: TUniDBLookupComboBox
        Left = 120
        Top = 216
        Width = 340
        Height = 27
        Hint = ''
        ListField = 'AD'
        ListSource = dsTekLkp
        KeyField = 'TEKLIF_ID'
        ListFieldIndex = 0
        TabOrder = 10
        Color = clWindow
      end
      object btnTeklifYenile: TUniButton
        Left = 470
        Top = 214
        Width = 130
        Height = 30
        Hint = 'Teklif listesini cariye gore yeniler'
        Caption = 'Teklif yukle'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 11
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'secondary'#39';'#13#10'}')
        OnClick = btnTeklifYenileClick
      end
      object lblSiparis: TUniLabel
        Left = 16
        Top = 256
        Width = 79
        Height = 13
        Hint = ''
        Caption = 'Siparis no (ERP)'
        TabOrder = 12
      end
      object edSiparis: TUniEdit
        Left = 120
        Top = 252
        Width = 340
        Height = 27
        Hint = 'Netsis / ERP siparis referansi (tekliften bagimsiz)'
        Text = ''
        TabOrder = 13
      end
      object lblTarih: TUniLabel
        Left = 16
        Top = 292
        Width = 24
        Height = 13
        Hint = ''
        Caption = 'Tarih'
        TabOrder = 14
      end
      object dtAktivite: TUniDateTimePicker
        Left = 120
        Top = 288
        Width = 200
        Height = 27
        Hint = ''
        DateTime = 46109.000000000000000000
        DateFormat = 'dd/MM/yyyy'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 15
        DisabledDates = <>
      end
      object lblDurum: TUniLabel
        Left = 16
        Top = 328
        Width = 35
        Height = 13
        Hint = ''
        Caption = 'Durum'
        TabOrder = 16
      end
      object lkDurum: TUniDBLookupComboBox
        Left = 120
        Top = 324
        Width = 460
        Height = 27
        Hint = ''
        ListField = 'AD'
        ListSource = dsDurLkp
        KeyField = 'DURUM_ID'
        ListFieldIndex = 0
        TabOrder = 17
        Color = clWindow
      end
    end
    object panFooter: TUniPanel
      Left = 0
      Top = 460
      Width = 640
      Height = 52
      Hint = ''
      Align = alBottom
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      object btnKaydet: TUniButton
        Left = 120
        Top = 10
        Width = 140
        Height = 36
        Hint = ''
        Caption = 'Kaydet'
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
        ScreenMask.Enabled = True
        OnClick = btnKaydetClick
      end
    end
  end
  object qExec: TUniQuery
    Connection = frmDM.conAsya
    Left = 560
    Top = 360
  end
  object qLoad: TUniQuery
    Connection = frmDM.conAsya
    Left = 560
    Top = 400
  end
  object qTipLkp: TUniQuery
    Connection = frmDM.conAsya
    Left = 560
    Top = 440
  end
  object dsTipLkp: TUniDataSource
    DataSet = qTipLkp
    Left = 592
    Top = 440
  end
  object qDurLkp: TUniQuery
    Connection = frmDM.conAsya
    Left = 560
    Top = 480
  end
  object dsDurLkp: TUniDataSource
    DataSet = qDurLkp
    Left = 592
    Top = 480
  end
  object qTekLkp: TUniQuery
    Connection = frmDM.conAsya
    Left = 560
    Top = 520
  end
  object dsTekLkp: TUniDataSource
    DataSet = qTekLkp
    Left = 592
    Top = 520
  end
end
