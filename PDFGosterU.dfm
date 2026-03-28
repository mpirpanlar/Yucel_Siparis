object frmPDFGoster: TfrmPDFGoster
  Left = 0
  Top = 0
  ClientHeight = 665
  ClientWidth = 1055
  Caption = 'PDF G'#246'ster'
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  PixelsPerInch = 96
  TextHeight = 13
  object UniURLFrame1: TUniURLFrame
    Left = 39
    Top = 52
    Width = 969
    Height = 563
    Hint = ''
    TabOrder = 0
    ParentColor = False
    Color = clBtnFace
    object UniPanel2: TUniPanel
      Left = 28
      Top = 19
      Width = 938
      Height = 35
      Hint = ''
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      Color = 10865101
      Layout = 'hbox'
      LayoutConfig.Width = '100%'
      object UniButton2: TUniButton
        Left = 54
        Top = 3
        Width = 100
        Height = 28
        Hint = ''
        Caption = 'Kapat'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 1
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'secondary'#39';'#13#10'}')
        LayoutConfig.Margin = '3 5 3 3'
        OnClick = UniButton2Click
      end
    end
  end
end
