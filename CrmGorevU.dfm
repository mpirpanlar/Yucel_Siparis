object frmCrmGorev: TfrmCrmGorev
  Left = 0
  Top = 0
  ClientHeight = 480
  ClientWidth = 900
  Caption = 'Yeni G'#246'rev'
  OnCreate = UniFormCreate
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
    Height = 780
    Hint = ''
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    Layout = 'vbox'
    object pgc: TUniPageControl
      Left = 0
      Top = 0
      Width = 720
      Height = 728
      Hint = ''
      ActivePage = tsGenel
      TabOrder = 0
      LayoutConfig.Flex = 1
      LayoutConfig.Height = '100%'
      LayoutConfig.Width = '100%'
      object tsGenel: TUniTabSheet
        Hint = ''
        Caption = 'Genel'
        Layout = 'fit'
        object panMain: TUniPanel
          Left = 0
          Top = 0
          Width = 712
          Height = 700
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
            Left = 120
            Top = 8
            Width = 560
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
            Left = 120
            Top = 44
            Width = 560
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
            Left = 120
            Top = 124
            Width = 340
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
            Caption = 'Cari Listele'
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
          object lblCariAd: TUniLabel
            Left = 120
            Top = 152
            Width = 560
            Height = 15
            Hint = ''
            AutoSize = False
            Caption = ''
            ParentFont = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clGray
            Font.Height = -12
            TabOrder = 7
          end
          object lblPot: TUniLabel
            Left = 16
            Top = 172
            Width = 55
            Height = 13
            Hint = ''
            Caption = 'Potansiyel'
            TabOrder = 8
          end
          object edPotId: TUniEdit
            Left = 120
            Top = 168
            Width = 340
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 9
            ReadOnly = True
          end
          object btnPotBul: TUniButton
            Left = 470
            Top = 166
            Width = 130
            Height = 30
            Hint = 'Potansiyel m'#252#351'teri listesi'
            Caption = 'Potansiyel Se'#231
            ParentFont = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Segoe UI Semibold'
            Font.Style = [fsBold]
            TabOrder = 10
            ClientEvents.UniEvents.Strings = (
              
                'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
                'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
            OnClick = btnPotBulClick
          end
          object lblPotUnvan: TUniLabel
            Left = 120
            Top = 196
            Width = 560
            Height = 15
            Hint = ''
            AutoSize = False
            Caption = ''
            ParentFont = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clGray
            Font.Height = -12
            TabOrder = 11
          end
          object lblTeklif: TUniLabel
            Left = 16
            Top = 220
            Width = 55
            Height = 13
            Hint = ''
            Caption = 'Ba'#287'l'#305' Teklif'
            TabOrder = 12
          end
          object lkTeklif: TUniDBLookupComboBox
            Left = 120
            Top = 216
            Width = 340
            Height = 27
            Hint = ''
            ListField = 'AD'
            ListSource = dsTekLkp
            KeyField = 'TEKLIF_ID'
            ListFieldIndex = 0
            TabOrder = 13
            Color = clWindow
            OnCloseUp = lkTeklifCloseUp
          end
          object btnTeklifYenile: TUniButton
            Left = 470
            Top = 214
            Width = 130
            Height = 30
            Hint = 'Teklif listesini cariye gore yeniler'
            Caption = 'Teklif Y'#252'kle'
            ParentFont = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Segoe UI Semibold'
            Font.Style = [fsBold]
            TabOrder = 14
            OnClick = btnTeklifYenileClick
          end
          object lblSiparis: TUniLabel
            Left = 16
            Top = 256
            Width = 95
            Height = 13
            Hint = ''
            Caption = 'Sipari'#351' No (NETS'#304'S)'
            TabOrder = 15
          end
          object edSiparis: TUniEdit
            Left = 120
            Top = 252
            Width = 340
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 16
            ReadOnly = True
          end
          object btnSiparisBul: TUniButton
            Left = 470
            Top = 250
            Width = 130
            Height = 30
            Hint = 'Netsis siparis listesi'
            Caption = 'Sipari'#351' Se'#231
            ParentFont = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Segoe UI Semibold'
            Font.Style = [fsBold]
            TabOrder = 17
            OnClick = btnSiparisBulClick
          end
          object lblSiparisTar: TUniLabel
            Left = 120
            Top = 280
            Width = 100
            Height = 15
            Hint = ''
            AutoSize = False
            Caption = ''
            ParentFont = False
            Font.Color = clGray
            Font.Height = -12
            TabOrder = 18
          end
          object lblSiparisAcik: TUniLabel
            Left = 220
            Top = 280
            Width = 460
            Height = 15
            Hint = ''
            AutoSize = False
            Caption = ''
            ParentFont = False
            Font.Color = clGray
            Font.Height = -12
            TabOrder = 19
          end
          object lblGorevTar: TUniLabel
            Left = 16
            Top = 304
            Width = 58
            Height = 13
            Hint = ''
            Caption = 'G'#246'rev Tarihi'
            TabOrder = 20
          end
          object dtAktivite: TUniDateTimePicker
            Left = 120
            Top = 300
            Width = 200
            Height = 27
            Hint = ''
            DateTime = 46132.000000000000000000
            DateFormat = 'dd/MM/yyyy'
            TimeFormat = 'HH:mm:ss'
            TabOrder = 21
            DisabledDates = <>
          end
          object lblBitis: TUniLabel
            Left = 16
            Top = 340
            Width = 63
            Height = 13
            Hint = ''
            Caption = 'Termin Tarihi'
            TabOrder = 22
          end
          object dtBitis: TUniDateTimePicker
            Left = 120
            Top = 336
            Width = 200
            Height = 27
            Hint = ''
            DateTime = 46132.000000000000000000
            DateFormat = 'dd/MM/yyyy'
            TimeFormat = 'HH:mm:ss'
            TabOrder = 23
            DisabledDates = <>
          end
          object lblOncelik: TUniLabel
            Left = 16
            Top = 376
            Width = 39
            Height = 13
            Hint = ''
            Caption = #214'ncelik'
            TabOrder = 24
          end
          object cbOncelik: TUniComboBox
            Left = 120
            Top = 372
            Width = 200
            Height = 27
            Hint = ''
            Style = csDropDownList
            Text = ''
            TabOrder = 25
            IconItems = <>
          end
          object lblAtanan: TUniLabel
            Left = 16
            Top = 412
            Width = 37
            Height = 13
            Hint = ''
            Caption = 'Atanan'
            TabOrder = 26
          end
          object lkAtanan: TUniDBLookupComboBox
            Left = 120
            Top = 408
            Width = 560
            Height = 27
            Hint = ''
            ListField = 'KullaniciAd'
            ListSource = dsKullanici
            KeyField = 'KullaniciID'
            ListFieldIndex = 0
            TabOrder = 27
            Color = clWindow
          end
          object lblDurum: TUniLabel
            Left = 16
            Top = 448
            Width = 35
            Height = 13
            Hint = ''
            Caption = 'Durum'
            TabOrder = 28
          end
          object lkDurum: TUniDBLookupComboBox
            Left = 120
            Top = 444
            Width = 560
            Height = 27
            Hint = ''
            ListField = 'AD'
            ListSource = dsDurLkp
            KeyField = 'DURUM_ID'
            ListFieldIndex = 0
            TabOrder = 29
            Color = clWindow
            OnCloseUp = lkDurumCloseUp
          end
        end
      end
      object tsEkler: TUniTabSheet
        Hint = ''
        Caption = 'Ekler'
        Layout = 'vbox'
        object panEkBar: TUniPanel
          Left = 0
          Top = 0
          Width = 712
          Height = 44
          Hint = ''
          TabOrder = 0
          BorderStyle = ubsNone
          Caption = ''
          LayoutConfig.Width = '100%'
            object btnEkEkle: TUniButton
              Left = 12
              Top = 6
              Width = 150
              Height = 30
              Hint = 'PDF, PNG, JPG, Excel, Word vb. dosya ekleyin'
              Caption = 'Dosya Ekle'
              ParentFont = False
              Font.Charset = TURKISH_CHARSET
              Font.Color = clWhite
              Font.Height = -12
              Font.Name = 'Segoe UI Semibold'
              Font.Style = [fsBold]
              TabOrder = 0
              ClientEvents.UniEvents.Strings = (
                
                  'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
                  'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
              OnClick = btnEkEkleClick
            end
            object btnEkIndir: TUniButton
              Left = 172
              Top = 6
              Width = 130
              Height = 30
              Hint = 'Se'#231'ili eki indir'
              Caption = #304'ndir'
              ParentFont = False
              Font.Charset = TURKISH_CHARSET
              Font.Height = -12
              Font.Name = 'Segoe UI Semibold'
              Font.Style = [fsBold]
              TabOrder = 1
              OnClick = btnEkIndirClick
            end
            object btnEkSil: TUniButton
              Left = 312
              Top = 6
              Width = 130
              Height = 30
              Hint = 'Se'#231'ili eki sil'
              Caption = 'Sil'
              ParentFont = False
              Font.Charset = TURKISH_CHARSET
              Font.Height = -12
              Font.Name = 'Segoe UI Semibold'
              Font.Style = [fsBold]
              TabOrder = 2
              OnClick = btnEkSilClick
            end
        end
        object grdEk: TUniDBGrid
          Left = 0
          Top = 44
          Width = 712
          Height = 656
          Hint = ''
          DataSource = dsEk
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgTabs, dgAutoRefreshRow]
          ReadOnly = True
          WebOptions.Paged = False
          WebOptions.FetchAll = True
          LoadMask.Message = 'Loading data...'
          TabOrder = 1
          LayoutConfig.Flex = 1
          LayoutConfig.Width = '100%'
          LayoutConfig.Height = '100%'
          OnAjaxEvent = grdEkAjaxEvent
          Columns = <
            item
              FieldName = 'EK_ID'
              Title.Caption = 'ID'
              Width = 55
              ReadOnly = True
            end
            item
              FieldName = 'DOSYA_ADI'
              Title.Caption = 'Dosya Ad'#305
              Width = 320
              ReadOnly = True
            end
            item
              FieldName = 'UZANTI'
              Title.Caption = 'T'#252'r'
              Width = 70
              ReadOnly = True
            end
            item
              FieldName = 'BOYUT'
              Title.Caption = 'Boyut (byte)'
              Width = 100
              ReadOnly = True
            end
            item
              FieldName = 'YUKLEME_UTC'
              Title.Caption = 'Y'#252'kleme'
              Width = 140
              ReadOnly = True
            end>
        end
      end
      object tsTarihce: TUniTabSheet
        Hint = ''
        Caption = 'Tarih'#231'e'
        Layout = 'fit'
        object grdTarihce: TUniDBGrid
          Left = 0
          Top = 0
          Width = 712
          Height = 700
          Hint = ''
          DataSource = dsLog
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgTabs, dgCancelOnExit]
          ReadOnly = True
          WebOptions.Paged = False
          WebOptions.FetchAll = True
          LoadMask.Message = 'Loading data...'
          TabOrder = 0
          LayoutConfig.Flex = 1
          LayoutConfig.Width = '100%'
          LayoutConfig.Height = '100%'
        end
      end
    end
    object panFooter: TUniPanel
      Left = 0
      Top = 728
      Width = 720
      Height = 52
      Hint = ''
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      LayoutConfig.Width = '100%'
      object btnKaydet: TUniButton
        Left = 240
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
      object btnKapat: TUniButton
        Left = 400
        Top = 10
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
  object qLog: TUniQuery
    Connection = frmDM.conAsya
    Left = 560
    Top = 376
  end
  object dsLog: TUniDataSource
    DataSet = qLog
    Left = 592
    Top = 376
  end
  object qLogExec: TUniQuery
    Connection = frmDM.conAsya
    Left = 624
    Top = 376
  end
  object qTekLkp: TUniQuery
    Connection = frmDM.conAsya
    Left = 560
    Top = 424
  end
  object dsTekLkp: TUniDataSource
    DataSet = qTekLkp
    Left = 592
    Top = 424
  end
  object qEk: TUniQuery
    Connection = frmDM.conAsya
    Left = 560
    Top = 472
  end
  object dsEk: TUniDataSource
    DataSet = qEk
    Left = 592
    Top = 472
  end
  object qEkExec: TUniQuery
    Connection = frmDM.conAsya
    Left = 624
    Top = 472
  end
  object saBaglantiDurum: TUniSweetAlert
    Title = 'Durum g'#252'ncelle'
    ConfirmButtonText = 'Evet'
    CancelButtonText = 'Hay'#305'r'
    AlertType = atQuestion
    Padding = 20
    ShowCancelButton = True
    OnConfirm = saBaglantiDurumConfirm
    Left = 480
    Top = 424
  end
end
