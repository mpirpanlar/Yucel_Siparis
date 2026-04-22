object frmCrmGorev: TfrmCrmGorev
  Left = 0
  Top = 0
  ClientHeight = 536
  ClientWidth = 640
  Caption = 'Yeni G'#246'rev'
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
    Height = 536
    Hint = ''
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    object panMain: TUniPanel
      Left = 0
      Top = 0
      Width = 640
      Height = 484
      Hint = ''
      Align = alClient
      TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      object lblKonu: TUniLabel
        Left = 16
        Top = 12
        Width = 27
        Height = 13
        Hint = ''
        Caption = 'Konu'
        TabOrder = 0
      end
      object edKonu: TUniEdit
        Left = 160
        Top = 8
        Width = 440
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 1
      end
      object lblAciklama: TUniLabel
        Left = 16
        Top = 48
        Width = 45
        Height = 13
        Hint = ''
        Caption = 'A'#231#305'klama'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Height = -12
        TabOrder = 2
      end
      object mmAciklama: TUniMemo
        Left = 160
        Top = 44
        Width = 440
        Height = 72
        Hint = ''
        TabOrder = 3
      end
      object lblCari: TUniLabel
        Left = 16
        Top = 128
        Width = 60
        Height = 13
        Hint = ''
        Caption = 'Cari (Netsis)'
        TabOrder = 4
      end
      object edCariKod: TUniEdit
        Left = 160
        Top = 124
        Width = 300
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 5
      end
      object btnCariBul: TUniButton
        Left = 470
        Top = 122
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
        TabOrder = 6
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
        OnClick = btnCariBulClick
      end
      object lblBagliTeklif: TUniLabel
        Left = 16
        Top = 164
        Width = 73
        Height = 13
        Hint = ''
        Caption = 'Ba'#287'l'#305' Teklif No'
        TabOrder = 7
      end
      object edBagliTeklifNo: TUniEdit
        Left = 160
        Top = 160
        Width = 440
        Height = 27
        Hint = 'Tekliften acilan gorevlerde dolu gelir; salt okunur'
        Text = ''
        TabOrder = 8
        ReadOnly = True
      end
      object lblBitis: TUniLabel
        Left = 16
        Top = 200
        Width = 63
        Height = 13
        Hint = ''
        Caption = 'Termin Tarihi'
        TabOrder = 9
      end
      object dtBitis: TUniDateTimePicker
        Left = 160
        Top = 196
        Width = 200
        Height = 27
        Hint = ''
        DateTime = 46132.000000000000000000
        DateFormat = 'dd/MM/yyyy'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 10
        DisabledDates = <>
      end
      object lblOncelik: TUniLabel
        Left = 16
        Top = 236
        Width = 39
        Height = 13
        Hint = ''
        Caption = #214'ncelik'
        TabOrder = 11
      end
      object cbOncelik: TUniComboBox
        Left = 160
        Top = 232
        Width = 200
        Height = 27
        Hint = ''
        Style = csDropDownList
        Text = ''
        TabOrder = 12
        IconItems = <>
      end
      object lblAtanan: TUniLabel
        Left = 16
        Top = 272
        Width = 37
        Height = 13
        Hint = ''
        Caption = 'Atanan'
        TabOrder = 13
      end
      object lkAtanan: TUniDBLookupComboBox
        Left = 160
        Top = 268
        Width = 440
        Height = 27
        Hint = ''
        ListField = 'KullaniciAd'
        ListSource = dsKullanici
        KeyField = 'KullaniciID'
        ListFieldIndex = 0
        TabOrder = 14
        Color = clWindow
      end
      object lblDurum: TUniLabel
        Left = 16
        Top = 308
        Width = 35
        Height = 13
        Hint = ''
        Caption = 'Durum'
        TabOrder = 15
      end
      object lkDurum: TUniDBLookupComboBox
        Left = 160
        Top = 304
        Width = 440
        Height = 27
        Hint = ''
        ListField = 'AD'
        ListSource = dsDurLkp
        KeyField = 'DURUM_ID'
        ListFieldIndex = 0
        TabOrder = 16
        Color = clWindow
      end
    end
    object panFooter: TUniPanel
      Left = 0
      Top = 484
      Width = 640
      Height = 52
      Hint = ''
      Align = alBottom
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      object btnKaydet: TUniButton
        Left = 160
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
  object qKullanici: TUniQuery
    Connection = frmDM.conAsya
    Left = 560
    Top = 40
  end
  object dsKullanici: TUniDataSource
    DataSet = qKullanici
    Left = 560
    Top = 88
  end
  object qInsAkt: TUniQuery
    Connection = frmDM.conAsya
    Left = 560
    Top = 136
  end
  object qLoad: TUniQuery
    Connection = frmDM.conAsya
    Left = 560
    Top = 184
  end
  object qInsGor: TUniQuery
    Connection = frmDM.conAsya
    Left = 560
    Top = 232
  end
  object qDurLkp: TUniQuery
    Connection = frmDM.conAsya
    Left = 560
    Top = 280
  end
  object dsDurLkp: TUniDataSource
    DataSet = qDurLkp
    Left = 560
    Top = 328
  end
end
