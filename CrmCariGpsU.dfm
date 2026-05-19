object frmCrmCariGps: TfrmCrmCariGps
  Left = 0
  Top = 0
  ClientHeight = 420
  ClientWidth = 720
  Caption = 'frmCrmCariGps'
  OnShow = UniFormShow
  BorderStyle = bsNone
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  TextHeight = 15
  object rootPanel: TUniPanel
    Left = 0
    Top = 0
    Width = 720
    Height = 420
    Hint = ''
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    object panMain: TUniPanel
      Left = 0
      Top = 0
      Width = 720
      Height = 360
      Hint = ''
      Align = alClient
      TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      object lblCariKod: TUniLabel
        Left = 16
        Top = 16
        Width = 48
        Height = 15
        Hint = ''
        Caption = 'Cari kod'
        TabOrder = 0
      end
      object edCariKod: TUniEdit
        Left = 128
        Top = 12
        Width = 180
        Height = 28
        Hint = ''
        Text = ''
        ReadOnly = True
        TabOrder = 1
      end
      object lblCariIsim: TUniLabel
        Left = 16
        Top = 52
        Width = 45
        Height = 15
        Hint = ''
        Caption = 'Cari adi'
        TabOrder = 2
      end
      object edCariIsim: TUniEdit
        Left = 128
        Top = 48
        Width = 560
        Height = 28
        Hint = ''
        Text = ''
        ReadOnly = True
        TabOrder = 3
      end
      object lblGpsE: TUniLabel
        Left = 16
        Top = 96
        Width = 108
        Height = 15
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
        Left = 344
        Top = 96
        Width = 114
        Height = 15
        Hint = ''
        Caption = 'GPS boylam (KULL2N)'
        TabOrder = 6
      end
      object edGpsBoylam: TUniEdit
        Left = 464
        Top = 92
        Width = 200
        Height = 28
        Hint = ''
        Text = ''
        TabOrder = 7
      end
      object btnHaritaKonum: TUniButton
        Left = 16
        Top = 132
        Width = 240
        Height = 32
        Hint = ''
        Caption = 'Haritadan konum sec (Google)'
        TabOrder = 8
        OnClick = btnHaritaKonumClick
      end
      object lblHarFmt: TUniLabel
        Left = 16
        Top = 176
        Width = 149
        Height = 15
        Hint = ''
        Caption = 'Harita / geocoder adres satiri'
        TabOrder = 9
      end
      object mmHaritaAdres: TUniMemo
        Left = 16
        Top = 196
        Width = 672
        Height = 140
        Hint = ''
        Lines.Strings = (
          '')
        TabOrder = 10
      end
    end
    object panFooter: TUniPanel
      Left = 0
      Top = 360
      Width = 720
      Height = 60
      Hint = ''
      Align = alBottom
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      object btnKaydet: TUniButton
        Left = 240
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
        Left = 560
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
