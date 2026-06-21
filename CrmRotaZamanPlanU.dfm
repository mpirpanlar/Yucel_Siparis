object frmCrmRotaZamanPlan: TfrmCrmRotaZamanPlan
  Left = 0
  Top = 0
  ClientHeight = 620
  ClientWidth = 960
  Caption = 'CRM - Rota zaman plan'#305' '#246'nizleme'
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  TextHeight = 15
  object rootPanel: TUniPanel
    Left = 0
    Top = 0
    Width = 960
    Height = 620
    Hint = ''
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    Layout = 'vbox'
    object panTop: TUniPanel
      Left = 0
      Top = 0
      Width = 960
      Height = 72
      Hint = ''
      TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      LayoutConfig.Width = '100%'
      object lblOzet: TUniLabel
        Left = 12
        Top = 8
        Width = 620
        Height = 56
        Hint = ''
        AutoSize = False
        Caption = 'Zaman plan'#305' '#246'zeti'
        TabOrder = 0
      end
      object btnGorevOlustur: TUniButton
        Left = 640
        Top = 20
        Width = 150
        Height = 32
        Hint = ''
        Caption = 'G'#246'revleri olu'#351'tur'
        TabOrder = 1
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
        OnClick = btnGorevOlusturClick
      end
      object btnKapat: TUniButton
        Left = 800
        Top = 20
        Width = 100
        Height = 32
        Hint = ''
        Caption = 'Kapat'
        TabOrder = 2
        OnClick = btnKapatClick
      end
    end
    object urlCal: TUniURLFrame
      Left = 0
      Top = 72
      Width = 960
      Height = 548
      Hint = ''
      TabOrder = 1
      LayoutConfig.Flex = 1
      LayoutConfig.Width = '100%'
      LayoutConfig.Height = '100%'
      ClientEvents.UniEvents.Strings = (
        
          'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'  config.name' +
          ' = '#39'urlCalRotaZaman'#39';'#13#10'}')
    end
  end
end
