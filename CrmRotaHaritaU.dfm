object frmCrmRotaHarita: TfrmCrmRotaHarita
  Left = 0
  Top = 0
  ClientHeight = 640
  ClientWidth = 1000
  Caption = 'CRM - Rota haritasi'
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
    Width = 1000
    Height = 640
    Hint = ''
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    object panTop: TUniPanel
      Left = 0
      Top = 0
      Width = 1000
      Height = 40
      Hint = ''
      Align = alTop
      TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      Color = 10865101
      object btnKapat: TUniButton
        Left = 880
        Top = 6
        Width = 100
        Height = 28
        Hint = ''
        Caption = 'Kapat'
        TabOrder = 0
        OnClick = btnKapatClick
      end
    end
    object urlFrame: TUniURLFrame
      Left = 0
      Top = 40
      Width = 1000
      Height = 600
      Hint = ''
      Align = alClient
      TabOrder = 1
    end
  end
end
