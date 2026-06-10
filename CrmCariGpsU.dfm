object frmCrmCariGps: TfrmCrmCariGps
  Left = 0
  Top = 0
  ClientHeight = 640
  ClientWidth = 960
  Caption = 'CRM - Netsis Cari GPS'
  OnShow = UniFormShow
  BorderStyle = bsNone
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  OnCreate = UniFormCreate
  TextHeight = 15
  object rootPanel: TUniPanel
    Left = 0
    Top = 0
    Width = 960
    Height = 640
    Hint = ''
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    object panMain: TUniPanel
      Left = 0
      Top = 0
      Width = 960
      Height = 580
      Hint = ''
      Align = alClient
      TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      DesignSize = (
        960
        580)
      object lblCariKod: TUniLabel
        Left = 16
        Top = 16
        Width = 43
        Height = 13
        Hint = ''
        Caption = 'Cari kod'
        TabOrder = 0
      end
      object edCariKod: TUniEdit
        Left = 128
        Top = 12
        Width = 200
        Height = 28
        Hint = ''
        Text = ''
        TabOrder = 1
        ReadOnly = True
      end
      object lblCariIsim: TUniLabel
        Left = 16
        Top = 52
        Width = 39
        Height = 13
        Hint = ''
        Caption = 'Cari ad'#305
        TabOrder = 2
      end
      object edCariIsim: TUniEdit
        Left = 128
        Top = 48
        Width = 200
        Height = 28
        Hint = ''
        Text = ''
        TabOrder = 3
        ReadOnly = True
      end
      object lblGpsE: TUniLabel
        Left = 16
        Top = 96
        Width = 101
        Height = 13
        Hint = ''
        Caption = 'GPS enlem (KULL1N)'
        TabOrder = 4
      end
      object edGpsEnlem: TUniEdit
        Left = 128
        Top = 92
        Width = 200
        Height = 28
        Hint = ''
        Text = ''
        TabOrder = 5
      end
      object lblGpsB: TUniLabel
        Left = 16
        Top = 136
        Width = 107
        Height = 13
        Hint = ''
        Caption = 'GPS boylam (KULL2N)'
        TabOrder = 6
      end
      object edGpsBoylam: TUniEdit
        Left = 128
        Top = 132
        Width = 200
        Height = 28
        Hint = ''
        Text = ''
        TabOrder = 7
      end
      object lblHarFmt: TUniLabel
        Left = 16
        Top = 176
        Width = 188
        Height = 13
        Hint = ''
        Caption = 'Harita / geocoder adres (bilgi ama'#231'l'#305')'
        TabOrder = 8
      end
      object mmHaritaAdres: TUniMemo
        Left = 16
        Top = 196
        Width = 300
        Height = 72
        Hint = ''
        Lines.Strings = (
          '')
        TabOrder = 9
      end
      object lblBilgi: TUniLabel
        Left = 16
        Top = 276
        Width = 300
        Height = 72
        Hint = ''
        AutoSize = False
        Caption = 
          'Haritada t'#305'klayarak konum se'#231'in. Kaydet yaln'#305'zca GPS koordinatla' +
          'r'#305'n'#305' Netsis TBLCASABITEK (KULL1N/KULL2N) alanlar'#305'na yazar; cari ' +
          'adres sat'#305'rlar'#305'n'#305' otomatik g'#252'ncellenmez.'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clGray
        Font.Height = -12
        TabOrder = 10
      end
      object btnHaritaKonum: TUniButton
        Left = 16
        Top = 360
        Width = 300
        Height = 32
        Hint = 'Tam ekran harita se'#231'im penceresi'
        Caption = 'Tam ekran harita'
        TabOrder = 11
        OnClick = btnHaritaKonumClick
      end
      object btnHaritaYenile: TUniButton
        Left = 16
        Top = 400
        Width = 300
        Height = 32
        Hint = 'Haritay'#305' mevcut koordinatlara odakla'
        Caption = 'Haritay'#305' yenile'
        TabOrder = 12
        OnClick = btnHaritaYenileClick
      end
      object urlMap: TUniURLFrame
        Left = 336
        Top = 8
        Width = 612
        Height = 560
        Hint = ''
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 13
        ParentColor = False
        Color = clBtnFace
      end
    end
    object panFooter: TUniPanel
      Left = 0
      Top = 580
      Width = 960
      Height = 60
      Hint = ''
      Align = alBottom
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      object btnKaydet: TUniButton
        Left = 340
        Top = 12
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
      object btnKapat: TUniButton
        Left = 840
        Top = 12
        Width = 100
        Height = 36
        Hint = ''
        Caption = 'Kapat'
        TabOrder = 1
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'secondary'#39';'#13#10'}')
        OnClick = btnKapatClick
      end
    end
  end
  object btnMapPick: TUniButton
    Left = 48
    Top = 600
    Width = 1
    Height = 1
    Hint = ''
    Visible = False
    Caption = 'MapPick'
    TabOrder = 1
    ClientEvents.UniEvents.Strings = (
      
        'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'  config.name' +
        ' = '#39'btnMapPick'#39';'#13#10'}')
    OnAjaxEvent = btnMapPickAjaxEvent
  end
  object qLoad: TUniQuery
    Connection = frmDM.conNetsis
    Left = 560
    Top = 16
  end
  object qExec: TUniQuery
    Connection = frmDM.conNetsis
    Left = 624
    Top = 16
  end
end
