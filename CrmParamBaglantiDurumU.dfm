object frmCrmParamBaglantiDurum: TfrmCrmParamBaglantiDurum
  Left = 0
  Top = 0
  ClientHeight = 520
  ClientWidth = 920
  Caption = 'CRM - Ba'#287'lant'#305' Durum Kurallar'#305
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
    Width = 920
    Height = 520
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
        OnClick = btnListeleClick
      end
      object btnYeni: TUniButton
        Left = 104
        Top = 6
        Width = 90
        Height = 30
        Hint = ''
        Caption = 'Yeni'
        TabOrder = 1
        OnClick = btnYeniClick
      end
      object btnKaydet: TUniButton
        Left = 200
        Top = 6
        Width = 100
        Height = 30
        Hint = ''
        Caption = 'Kaydet'
        TabOrder = 2
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
        TabOrder = 3
        OnClick = btnKapatClick
      end
    end
    object panDetay: TUniPanel
      Left = 0
      Top = 44
      Width = 920
      Height = 110
      Hint = ''
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      LayoutConfig.Width = '100%'
      object lblKaynak: TUniLabel
        Left = 12
        Top = 12
        Width = 70
        Height = 17
        Hint = ''
        Caption = 'Kaynak Olay'
        TabOrder = 0
      end
      object cbKaynak: TUniComboBox
        Left = 100
        Top = 8
        Width = 220
        Height = 27
        Hint = ''
        Style = csDropDownList
        Text = ''
        TabOrder = 1
      end
      object lblHedefDurum: TUniLabel
        Left = 340
        Top = 12
        Width = 72
        Height = 17
        Hint = ''
        Caption = 'Hedef Durum'
        TabOrder = 2
      end
      object lkHedefDurum: TUniDBLookupComboBox
        Left = 420
        Top = 8
        Width = 480
        Height = 27
        Hint = ''
        ListField = 'AD'
        ListSource = dsDurLkp
        KeyField = 'DURUM_ID'
        ListFieldIndex = 0
        TabOrder = 3
        Color = clWindow
      end
      object chkPrompt: TUniCheckBox
        Left = 100
        Top = 44
        Width = 200
        Height = 22
        Hint = 'A: kullaniciya sor'
        Caption = 'Kullaniciya sor (A)'
        Checked = True
        TabOrder = 4
      end
      object chkSessiz: TUniCheckBox
        Left = 320
        Top = 44
        Width = 200
        Height = 22
        Hint = 'C: otomatik uygula'
        Caption = 'Sessiz uygula (C)'
        TabOrder = 5
      end
      object chkAktif: TUniCheckBox
        Left = 540
        Top = 44
        Width = 80
        Height = 22
        Hint = ''
        Caption = 'Aktif'
        Checked = True
        TabOrder = 6
      end
      object lblSira: TUniLabel
        Left = 640
        Top = 46
        Width = 24
        Height = 17
        Hint = ''
        Caption = 'S'#305'ra'
        TabOrder = 7
      end
      object edSira: TUniEdit
        Left = 672
        Top = 42
        Width = 60
        Height = 27
        Hint = ''
        Text = '0'
        TabOrder = 8
      end
    end
    object grd: TUniDBGrid
      Left = 0
      Top = 154
      Width = 920
      Height = 366
      Hint = ''
      DataSource = dsKural
      LayoutConfig.Flex = 1
      LayoutConfig.Height = '100%'
      LayoutConfig.Width = '100%'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
      ReadOnly = True
      WebOptions.Paged = False
      WebOptions.FetchAll = True
      TabOrder = 2
      Columns = <
        item
          FieldName = 'KAYNAK_TIP'
          Title.Caption = 'Kaynak'
          Width = 140
          ReadOnly = True
        end
        item
          FieldName = 'HEDEF_DURUM_AD'
          Title.Caption = 'Hedef Durum'
          Width = 220
          ReadOnly = True
        end
        item
          FieldName = 'PROMPT_KULLANICI'
          Title.Caption = 'Sor'
          Width = 50
          ReadOnly = True
        end
        item
          FieldName = 'SESSIZ_UYGULA'
          Title.Caption = 'Sessiz'
          Width = 55
          ReadOnly = True
        end
        item
          FieldName = 'AKTIF'
          Title.Caption = 'Aktif'
          Width = 50
          ReadOnly = True
        end
        item
          FieldName = 'SIRA'
          Title.Caption = 'S'#305'ra'
          Width = 50
          ReadOnly = True
        end>
    end
  end
  object qKural: TUniQuery
    Connection = frmDM.conAsya
    Left = 760
    Top = 300
  end
  object dsKural: TUniDataSource
    DataSet = qKural
    OnDataChange = dsKuralDataChange
    Left = 792
    Top = 300
  end
  object qExec: TUniQuery
    Connection = frmDM.conAsya
    Left = 760
    Top = 348
  end
  object qDurLkp: TUniQuery
    Connection = frmDM.conAsya
    Left = 824
    Top = 300
  end
  object dsDurLkp: TUniDataSource
    DataSet = qDurLkp
    Left = 856
    Top = 300
  end
end
