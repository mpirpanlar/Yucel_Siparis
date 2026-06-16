object frmCrmSoruSeti: TfrmCrmSoruSeti
  Left = 0
  Top = 0
  ClientHeight = 720
  ClientWidth = 1010
  Caption = 'CRM - Kontrol Listesi (Soru Setleri)'
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
    Width = 1010
    Height = 720
    Hint = ''
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    Layout = 'fit'
    object pgc: TUniPageControl
      Left = 0
      Top = 0
      Width = 1010
      Height = 720
      Hint = ''
      ActivePage = tsSet
      Align = alClient
      TabOrder = 0
      object tsSet: TUniTabSheet
        Hint = ''
        Caption = 'Soru Setleri'
        object lblSorular: TUniLabel
          Left = 8
          Top = 230
          Width = 44
          Height = 17
          Hint = ''
          Caption = 'Sorular'
          ParentFont = False
          Font.Height = -13
          Font.Style = [fsBold]
          TabOrder = 1
        end
        object lblSecenekler: TUniLabel
          Left = 8
          Top = 506
          Width = 245
          Height = 17
          Hint = ''
          Caption = 'Se'#231'enekler (Tek/'#199'ok se'#231'im sorular'#305' i'#231'in)'
          ParentFont = False
          Font.Height = -13
          Font.Style = [fsBold]
          TabOrder = 2
        end
        object panSetTb: TUniPanel
          Left = 0
          Top = 0
          Width = 1002
          Height = 40
          Hint = ''
          Align = alTop
          TabOrder = 0
          BorderStyle = ubsNone
          Caption = ''
          Color = 10865101
          object btnListele: TUniButton
            Left = 8
            Top = 6
            Width = 90
            Height = 28
            Hint = ''
            Caption = 'Listele'
            TabOrder = 0
            OnClick = btnListeleClick
          end
          object btnYeniSet: TUniButton
            Left = 104
            Top = 6
            Width = 90
            Height = 28
            Hint = ''
            Caption = 'Yeni Set'
            TabOrder = 1
            OnClick = btnYeniSetClick
          end
          object btnSetKaydet: TUniButton
            Left = 200
            Top = 6
            Width = 100
            Height = 28
            Hint = ''
            Caption = 'Set Kaydet'
            TabOrder = 2
            OnClick = btnSetKaydetClick
          end
          object btnSetSil: TUniButton
            Left = 306
            Top = 6
            Width = 90
            Height = 28
            Hint = ''
            Caption = 'Set Sil'
            TabOrder = 3
            OnClick = btnSetSilClick
          end
          object btnKapat: TUniButton
            Left = 902
            Top = 0
            Width = 100
            Height = 40
            Hint = ''
            Caption = 'Kapat'
            Align = alRight
            TabOrder = 4
            OnClick = btnKapatClick
          end
        end
        object grdSet: TUniDBGrid
          Left = 8
          Top = 48
          Width = 380
          Height = 172
          Hint = ''
          DataSource = dsSet
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgTabs, dgCancelOnExit]
          ReadOnly = True
          WebOptions.Paged = False
          WebOptions.FetchAll = True
          LoadMask.Message = 'Loading data...'
          TabOrder = 3
        end
        object panSetDetay: TUniPanel
          Left = 396
          Top = 48
          Width = 600
          Height = 172
          Hint = ''
          TabOrder = 4
          BorderStyle = ubsNone
          Caption = ''
          Color = 15790320
          object lblKod: TUniLabel
            Left = 8
            Top = 12
            Width = 20
            Height = 13
            Hint = ''
            Caption = 'Kod'
            TabOrder = 0
          end
          object edKod: TUniEdit
            Left = 90
            Top = 8
            Width = 160
            Height = 24
            Hint = ''
            Text = ''
            TabOrder = 1
          end
          object lblBaslik: TUniLabel
            Left = 8
            Top = 48
            Width = 30
            Height = 13
            Hint = ''
            Caption = 'Ba'#351'l'#305'k'
            TabOrder = 2
          end
          object edBaslik: TUniEdit
            Left = 90
            Top = 44
            Width = 480
            Height = 24
            Hint = ''
            Text = ''
            TabOrder = 3
          end
          object lblSetAciklama: TUniLabel
            Left = 8
            Top = 84
            Width = 45
            Height = 13
            Hint = ''
            Caption = 'A'#231#305'klama'
            TabOrder = 4
          end
          object edSetAciklama: TUniEdit
            Left = 90
            Top = 80
            Width = 480
            Height = 24
            Hint = ''
            Text = ''
            TabOrder = 5
          end
          object chkSetAktif: TUniCheckBox
            Left = 90
            Top = 120
            Width = 80
            Height = 22
            Hint = ''
            Caption = 'Aktif'
            TabOrder = 6
          end
          object lblSetSira: TUniLabel
            Left = 200
            Top = 122
            Width = 19
            Height = 13
            Hint = ''
            Caption = 'S'#305'ra'
            TabOrder = 7
          end
          object edSetSira: TUniEdit
            Left = 240
            Top = 118
            Width = 80
            Height = 24
            Hint = ''
            Text = '0'
            TabOrder = 8
          end
        end
        object btnSoruYeni: TUniButton
          Left = 8
          Top = 250
          Width = 90
          Height = 28
          Hint = ''
          Caption = 'Yeni Soru'
          TabOrder = 5
          OnClick = btnSoruYeniClick
        end
        object btnSoruKaydet: TUniButton
          Left = 104
          Top = 250
          Width = 110
          Height = 28
          Hint = ''
          Caption = 'Soru Kaydet'
          TabOrder = 6
          OnClick = btnSoruKaydetClick
        end
        object btnSoruSil: TUniButton
          Left = 220
          Top = 250
          Width = 90
          Height = 28
          Hint = ''
          Caption = 'Soru Sil'
          TabOrder = 7
          OnClick = btnSoruSilClick
        end
        object grdSoru: TUniDBGrid
          Left = 8
          Top = 286
          Width = 560
          Height = 210
          Hint = ''
          DataSource = dsSoru
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgTabs, dgCancelOnExit]
          ReadOnly = True
          WebOptions.Paged = False
          WebOptions.FetchAll = True
          LoadMask.Message = 'Loading data...'
          TabOrder = 8
        end
        object panSoruDetay: TUniPanel
          Left = 576
          Top = 286
          Width = 420
          Height = 210
          Hint = ''
          TabOrder = 9
          BorderStyle = ubsNone
          Caption = ''
          Color = 15790320
          object lblSoruMetni: TUniLabel
            Left = 8
            Top = 8
            Width = 57
            Height = 13
            Hint = ''
            Caption = 'Soru Metni'
            TabOrder = 0
          end
          object edSoruMetni: TUniMemo
            Left = 8
            Top = 26
            Width = 404
            Height = 70
            Hint = ''
            TabOrder = 1
          end
          object lblCevapTipi: TUniLabel
            Left = 8
            Top = 112
            Width = 52
            Height = 13
            Hint = ''
            Caption = 'Cevap Tipi'
            TabOrder = 2
          end
          object cbCevapTipi: TUniComboBox
            Left = 90
            Top = 108
            Width = 200
            Height = 24
            Hint = ''
            Text = ''
            TabOrder = 3
            IconItems = <>
          end
          object chkZorunlu: TUniCheckBox
            Left = 300
            Top = 110
            Width = 110
            Height = 22
            Hint = ''
            Caption = 'Zorunlu'
            TabOrder = 4
          end
          object lblSoruSira: TUniLabel
            Left = 8
            Top = 148
            Width = 19
            Height = 13
            Hint = ''
            Caption = 'S'#305'ra'
            TabOrder = 5
          end
          object edSoruSira: TUniEdit
            Left = 90
            Top = 144
            Width = 70
            Height = 24
            Hint = ''
            Text = '0'
            TabOrder = 6
          end
          object chkSoruAktif: TUniCheckBox
            Left = 180
            Top = 146
            Width = 100
            Height = 22
            Hint = ''
            Caption = 'Aktif'
            TabOrder = 7
          end
        end
        object grdSec: TUniDBGrid
          Left = 8
          Top = 526
          Width = 400
          Height = 150
          Hint = ''
          DataSource = dsSec
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgTabs, dgCancelOnExit]
          ReadOnly = True
          WebOptions.Paged = False
          WebOptions.FetchAll = True
          LoadMask.Message = 'Loading data...'
          TabOrder = 10
        end
        object edSecSira: TUniEdit
          Left = 420
          Top = 526
          Width = 60
          Height = 24
          Hint = ''
          Text = '0'
          TabOrder = 11
        end
        object edSecMetin: TUniEdit
          Left = 490
          Top = 526
          Width = 300
          Height = 24
          Hint = ''
          Text = ''
          TabOrder = 12
        end
        object btnSecEkle: TUniButton
          Left = 800
          Top = 524
          Width = 90
          Height = 28
          Hint = ''
          Caption = 'Se'#231'enek Ekle'
          TabOrder = 13
          OnClick = btnSecEkleClick
        end
        object btnSecSil: TUniButton
          Left = 800
          Top = 560
          Width = 90
          Height = 28
          Hint = ''
          Caption = 'Se'#231'enek Sil'
          TabOrder = 14
          OnClick = btnSecSilClick
        end
      end
      object tsAtama: TUniTabSheet
        Hint = ''
        Caption = 'Tip - Set Atama'
        Layout = 'vbox'
        object lblAtamaTip: TUniLabel
          Left = 8
          Top = 16
          Width = 59
          Height = 13
          Hint = ''
          Caption = 'Aktivite / G'#246'rev Tipi'
          TabOrder = 0
        end
        object lkTip: TUniDBLookupComboBox
          Left = 90
          Top = 12
          Width = 400
          Height = 24
          Hint = ''
          ListField = 'AD'
          ListSource = dsTipLkp
          KeyField = 'TIP_ID'
          ListFieldIndex = 0
          TabOrder = 1
          Color = clWindow
          OnCloseUp = lkTipCloseUp
        end
        object lblSetEkle: TUniLabel
          Left = 8
          Top = 56
          Width = 46
          Height = 13
          Hint = ''
          Caption = 'Soru Seti'
          TabOrder = 2
        end
        object lkSetEkle: TUniDBLookupComboBox
          Left = 90
          Top = 52
          Width = 400
          Height = 24
          Hint = ''
          ListField = 'AD'
          ListSource = dsSetLkp
          KeyField = 'SET_ID'
          ListFieldIndex = 0
          TabOrder = 3
          Color = clWindow
        end
        object chkAtaZorunlu: TUniCheckBox
          Left = 510
          Top = 54
          Width = 120
          Height = 22
          Hint = ''
          Checked = True
          Caption = 'Zorunlu'
          TabOrder = 4
        end
        object btnAta: TUniButton
          Left = 640
          Top = 50
          Width = 90
          Height = 28
          Hint = ''
          Caption = 'Ata / G'#252'ncelle'
          TabOrder = 5
          OnClick = btnAtaClick
        end
        object btnAtaKaldir: TUniButton
          Left = 740
          Top = 50
          Width = 110
          Height = 28
          Hint = ''
          Caption = 'Atamay'#305' Kald'#305'r'
          TabOrder = 6
          OnClick = btnAtaKaldirClick
        end
        object grdAtama: TUniDBGrid
          Left = 8
          Top = 92
          Width = 980
          Height = 570
          Hint = ''
          DataSource = dsAtama
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgTabs, dgCancelOnExit]
          ReadOnly = True
          WebOptions.Paged = False
          WebOptions.FetchAll = True
          LoadMask.Message = 'Loading data...'
          LayoutConfig.Flex = 1
          LayoutConfig.Width = '100%'
          TabOrder = 7
        end
      end
    end
  end
  object qSet: TUniQuery
    Connection = frmDM.conAsya
    Left = 760
    Top = 8
  end
  object dsSet: TUniDataSource
    DataSet = qSet
    OnDataChange = dsSetDataChange
    Left = 792
    Top = 8
  end
  object qSoru: TUniQuery
    Connection = frmDM.conAsya
    Left = 760
    Top = 48
  end
  object dsSoru: TUniDataSource
    DataSet = qSoru
    OnDataChange = dsSoruDataChange
    Left = 792
    Top = 48
  end
  object qSec: TUniQuery
    Connection = frmDM.conAsya
    Left = 760
    Top = 88
  end
  object dsSec: TUniDataSource
    DataSet = qSec
    Left = 792
    Top = 88
  end
  object qTipLkp: TUniQuery
    Connection = frmDM.conAsya
    Left = 760
    Top = 128
  end
  object dsTipLkp: TUniDataSource
    DataSet = qTipLkp
    Left = 792
    Top = 128
  end
  object qSetLkp: TUniQuery
    Connection = frmDM.conAsya
    Left = 760
    Top = 168
  end
  object dsSetLkp: TUniDataSource
    DataSet = qSetLkp
    Left = 792
    Top = 168
  end
  object qAtama: TUniQuery
    Connection = frmDM.conAsya
    Left = 760
    Top = 208
  end
  object dsAtama: TUniDataSource
    DataSet = qAtama
    Left = 792
    Top = 208
  end
  object qExec: TUniQuery
    Connection = frmDM.conAsya
    Left = 760
    Top = 248
  end
end
