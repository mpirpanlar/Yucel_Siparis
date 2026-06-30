object frmCrmTakvim: TfrmCrmTakvim
  Left = 0
  Top = 0
  ClientHeight = 700
  ClientWidth = 1100
  Caption = 'CRM - Takvim'
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
    Width = 1100
    Height = 700
    Hint = ''
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    Layout = 'vbox'
    object panTop: TUniPanel
      Left = 0
      Top = 0
      Width = 1100
      Height = 52
      Hint = ''
      Align = alTop
      TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      LayoutConfig.Width = '100%'
      object lblKaynak: TUniLabel
        Left = 12
        Top = 16
        Width = 40
        Height = 13
        Hint = ''
        Caption = 'Kaynak'
        TabOrder = 0
      end
      object chkAktivite: TUniCheckBox
        Left = 60
        Top = 14
        Width = 80
        Height = 22
        Hint = ''
        Caption = 'Aktivite'
        Checked = True
        TabOrder = 1
        OnChange = FiltreDegisti
      end
      object chkGorev: TUniCheckBox
        Left = 150
        Top = 14
        Width = 70
        Height = 22
        Hint = ''
        Caption = 'G'#246'rev'
        Checked = True
        TabOrder = 2
        OnChange = FiltreDegisti
      end
      object lblPersonel: TUniLabel
        Left = 240
        Top = 16
        Width = 45
        Height = 13
        Hint = ''
        Caption = 'Personel'
        TabOrder = 3
      end
      object cbPersonel: TUniComboBox
        Left = 300
        Top = 12
        Width = 220
        Height = 24
        Hint = ''
        Style = csDropDownList
        TabOrder = 4
        OnChange = FiltreDegisti
      end
      object chkTamamlanan: TUniCheckBox
        Left = 540
        Top = 14
        Width = 130
        Height = 22
        Hint = ''
        Caption = 'Tamamlanan g'#246'ster'
        TabOrder = 5
        OnChange = FiltreDegisti
      end
      object btnYenile: TUniButton
        Left = 690
        Top = 10
        Width = 100
        Height = 30
        Hint = ''
        Caption = 'Yenile'
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
        OnClick = btnYenileClick
      end
      object btnKapat: TUniButton
        Left = 1000
        Top = 0
        Width = 100
        Height = 52
        Hint = ''
        Caption = 'Kapat'
        Align = alRight
        TabOrder = 7
        OnClick = btnKapatClick
      end
    end
    object urlCal: TUniURLFrame
      Left = 0
      Top = 52
      Width = 1100
      Height = 648
      Hint = ''
      TabOrder = 1
      ParentColor = False
      Color = clBtnFace
      LayoutConfig.Flex = 1
      LayoutConfig.Height = '100%'
      LayoutConfig.Width = '100%'
      ClientEvents.UniEvents.Strings = (
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'  config.name' +
          ' = '#39'urlCal'#39';'#13#10'}')
    end
    object btnCalHook: TUniButton
      Left = 0
      Top = 0
      Width = 1
      Height = 1
      Hint = ''
      Visible = False
      TabOrder = 2
      ClientEvents.UniEvents.Strings = (
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'  config.name' +
          ' = '#39'btnCalHook'#39';'#13#10'}')
      OnAjaxEvent = btnCalHookAjaxEvent
    end
  end
  object qEvt: TUniQuery
    Connection = frmDM.conAsya
    Left = 520
    Top = 320
  end
end
