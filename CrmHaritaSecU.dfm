object frmCrmHaritaSec: TfrmCrmHaritaSec
  Left = 0
  Top = 0
  ClientHeight = 620
  ClientWidth = 900
  Caption = 'CRM - Haritadan konum sec'
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
    Width = 900
    Height = 620
    Hint = ''
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    object urlMap: TUniURLFrame
      Left = 0
      Top = 0
      Width = 900
      Height = 392
      Hint = ''
      Align = alClient
      TabOrder = 0
      ParentColor = False
      Color = clBtnFace
    end
    object panBottom: TUniPanel
      Left = 0
      Top = 392
      Width = 900
      Height = 228
      Hint = ''
      Align = alBottom
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      object lblLat: TUniLabel
        Left = 12
        Top = 12
        Width = 31
        Height = 13
        Hint = ''
        Caption = 'Enlem'
        TabOrder = 7
      end
      object edLat: TUniEdit
        Left = 80
        Top = 8
        Width = 120
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 0
      end
      object lblLng: TUniLabel
        Left = 220
        Top = 12
        Width = 37
        Height = 13
        Hint = ''
        Caption = 'Boylam'
        TabOrder = 8
      end
      object edLng: TUniEdit
        Left = 280
        Top = 8
        Width = 120
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 1
      end
      object btnYansit: TUniButton
        Left = 420
        Top = 6
        Width = 189
        Height = 32
        Hint = ''
        Caption = 'Haritayi Forma Yans'#305't'
        TabOrder = 2
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'  config.name' +
            ' = '#39'btnYansit'#39';'#13#10'}')
        OnAjaxEvent = btnYansitAjaxEvent
      end
      object lblAdr: TUniLabel
        Left = 12
        Top = 48
        Width = 65
        Height = 13
        Hint = ''
        Caption = 'Harita adresi'
        TabOrder = 9
      end
      object mmAdr: TUniMemo
        Left = 12
        Top = 68
        Width = 860
        Height = 90
        Hint = ''
        TabOrder = 3
      end
      object btnTamam: TUniButton
        Left = 600
        Top = 170
        Width = 120
        Height = 34
        Hint = ''
        Caption = 'Tamam'
        TabOrder = 4
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
        OnClick = btnTamamClick
      end
      object btnIptal: TUniButton
        Left = 740
        Top = 170
        Width = 120
        Height = 34
        Hint = ''
        Caption = 'Iptal'
        TabOrder = 5
        OnClick = btnIptalClick
      end
    end
  end
end
