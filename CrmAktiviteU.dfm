object frmCrmAktivite: TfrmCrmAktivite
  Left = 0
  Top = 0
  ClientHeight = 780
  ClientWidth = 640
  Caption = 'Yeni Aktivite'
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
    Width = 640
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
      Width = 640
      Height = 728
      Hint = ''
      ActivePage = tsGenel
      LayoutConfig.Flex = 1
      LayoutConfig.Height = '100%'
      LayoutConfig.Width = '100%'
      TabOrder = 0
      object tsGenel: TUniTabSheet
        Hint = ''
        Caption = 'Genel'
        Layout = 'vbox'
        object panMain: TUniPanel
          Left = 0
          Top = 0
          Width = 632
          Height = 520
          Hint = ''
          Align = alClient
          TabOrder = 0
          ClientEvents.UniEvents.Strings = (
            
              'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      config.' +
              'autoScroll = true;'#13#10'      config.scrollable = true;'#13#10'}')
          BorderStyle = ubsNone
          Caption = ''
          LayoutConfig.Flex = 1
          LayoutConfig.Width = '100%'
          ExplicitTop = -2
          object lblTip: TUniLabel
            Left = 16
            Top = 16
            Width = 15
            Height = 13
            Hint = ''
            Caption = 'Tip'
            TabOrder = 16
          end
          object lkTip: TUniDBLookupComboBox
            Left = 120
            Top = 12
            Width = 480
            Height = 27
            Hint = ''
            ListField = 'AD'
            ListSource = dsTipLkp
            KeyField = 'TIP_ID'
            ListFieldIndex = 0
            TabOrder = 1
            Color = clWindow
            OnCloseUp = lkTipCloseUp
          end
          object lblKonu: TUniLabel
            Left = 16
            Top = 52
            Width = 27
            Height = 13
            Hint = ''
            Caption = 'Konu'
            TabOrder = 17
          end
          object edKonu: TUniEdit
            Left = 120
            Top = 48
            Width = 480
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 2
          end
          object lblAciklama: TUniLabel
            Left = 16
            Top = 88
            Width = 45
            Height = 13
            Hint = ''
            Caption = 'A'#231#305'klama'
            ParentFont = False
            Font.Charset = TURKISH_CHARSET
            Font.Height = -12
            TabOrder = 18
          end
          object mmAciklama: TUniMemo
            Left = 120
            Top = 84
            Width = 480
            Height = 88
            Hint = ''
            TabOrder = 3
          end
          object lblCari: TUniLabel
            Left = 16
            Top = 184
            Width = 60
            Height = 13
            Hint = ''
            Caption = 'Cari (Netsis)'
            TabOrder = 19
          end
          object edCariKod: TUniEdit
            Left = 120
            Top = 178
            Width = 340
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 4
            OnChange = edCariKodChange
          end
          object btnCariBul: TUniButton
            Left = 470
            Top = 178
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
            TabOrder = 5
            ClientEvents.UniEvents.Strings = (
              
                'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
                'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
            OnClick = btnCariBulClick
          end
          object lblCariAd: TUniLabel
            Left = 120
            Top = 208
            Width = 480
            Height = 15
            Hint = ''
            AutoSize = False
            Caption = ''
            ParentFont = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clGray
            Font.Height = -12
            TabOrder = 20
          end
          object lblPot: TUniLabel
            Left = 16
            Top = 228
            Width = 52
            Height = 13
            Hint = ''
            Caption = 'Potansiyel'
            TabOrder = 21
          end
          object edPotId: TUniEdit
            Left = 120
            Top = 224
            Width = 340
            Height = 27
            Hint = ''
            Text = ''
            TabOrder = 6
            OnExit = edPotIdExit
          end
          object btnPotBul: TUniButton
            Left = 470
            Top = 222
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
            TabOrder = 7
            ClientEvents.UniEvents.Strings = (
              
                'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
                'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
            OnClick = btnPotBulClick
          end
          object lblPotUnvan: TUniLabel
            Left = 120
            Top = 252
            Width = 480
            Height = 15
            Hint = ''
            AutoSize = False
            Caption = ''
            ParentFont = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clGray
            Font.Height = -12
            TabOrder = 22
          end
          object lblTeklif: TUniLabel
            Left = 16
            Top = 276
            Width = 55
            Height = 13
            Hint = ''
            Caption = 'Teklif No'
            TabOrder = 23
          end
          object edTeklifNo: TUniEdit
            Left = 120
            Top = 272
            Width = 340
            Height = 27
            Hint = 'SIPARIS_BASLIK fis numarasi'
            Text = ''
            TabOrder = 8
            ReadOnly = True
          end
          object btnTeklifSec: TUniButton
            Left = 470
            Top = 270
            Width = 130
            Height = 30
            Hint = 'Netsis''e gonderilmemis siparis basligi sec'
            Caption = 'Teklif Se'#231
            ParentFont = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Segoe UI Semibold'
            Font.Style = [fsBold]
            TabOrder = 9
            ClientEvents.UniEvents.Strings = (
              
                'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
                'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'secondary'#39';'#13#10'}')
            OnClick = btnTeklifSecClick
          end
          object lblSiparis: TUniLabel
            Left = 16
            Top = 311
            Width = 77
            Height = 13
            Hint = ''
            Caption = 'Sip.No (NETS'#304'S)'
            TabOrder = 24
          end
          object edSiparis: TUniEdit
            Left = 120
            Top = 307
            Width = 340
            Height = 27
            Hint = 'Netsis siparis referansi (secim ile)'
            Text = ''
            TabOrder = 10
            ReadOnly = True
          end
          object btnSiparisBul: TUniButton
            Left = 470
            Top = 305
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
            TabOrder = 11
            ClientEvents.UniEvents.Strings = (
              
                'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
                'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'secondary'#39';'#13#10'}')
            OnClick = btnSiparisBulClick
          end
          object lblSiparisTar: TUniLabel
            Left = 120
            Top = 336
            Width = 480
            Height = 15
            Hint = ''
            AutoSize = False
            Caption = ''
            ParentFont = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clGray
            Font.Height = -12
            TabOrder = 25
          end
          object lblSiparisAcik: TUniLabel
            Left = 120
            Top = 340
            Width = 380
            Height = 15
            Hint = ''
            AutoSize = False
            Caption = ''
            ParentFont = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clGray
            Font.Height = -12
            TabOrder = 26
          end
          object lblTarih: TUniLabel
            Left = 16
            Top = 379
            Width = 78
            Height = 13
            Hint = ''
            Caption = 'Ba'#351'lang'#305#231' Tarihi'
            TabOrder = 27
          end
          object dtAktivite: TUniDateTimePicker
            Left = 120
            Top = 375
            Width = 280
            Height = 27
            Hint = ''
            DateTime = 46109.000000000000000000
            Kind = tUniDateTime
            DateFormat = 'dd.mm.yyyy'
            TimeFormat = 'HH:mm'
            TabOrder = 12
            UseSystemFormats = False
            OnChange = dtAktiviteChange
            DisabledDates = <>
          end
          object lblSureDakika: TUniLabel
            Left = 410
            Top = 379
            Width = 58
            Height = 13
            Hint = ''
            Caption = 'S'#252're (dk)'
            TabOrder = 30
          end
          object edSureDakika: TUniEdit
            Left = 480
            Top = 375
            Width = 80
            Height = 27
            Hint = 'Sure dakika; bitis tarihi otomatik hesaplanir'
            Text = ''
            TabOrder = 31
            OnExit = edSureDakikaExit
          end
          object lblBitis: TUniLabel
            Left = 16
            Top = 415
            Width = 82
            Height = 13
            Hint = ''
            Caption = 'Biti'#351' Tarihi'
            TabOrder = 28
          end
          object dtAktiviteBitis: TUniDateTimePicker
            Left = 120
            Top = 411
            Width = 280
            Height = 27
            Hint = ''
            DateTime = 46109.000000000000000000
            Kind = tUniDateTime
            DateFormat = 'dd.mm.yyyy'
            TimeFormat = 'HH:mm'
            TabOrder = 13
            UseSystemFormats = False
            OnChange = dtAktiviteBitisChange
            DisabledDates = <>
          end
          object lblDurum: TUniLabel
            Left = 16
            Top = 451
            Width = 35
            Height = 13
            Hint = ''
            Caption = 'Durum'
            TabOrder = 29
          end
          object lkDurum: TUniDBLookupComboBox
            Left = 120
            Top = 447
            Width = 460
            Height = 27
            Hint = ''
            ListField = 'AD'
            ListSource = dsDurLkp
            KeyField = 'DURUM_ID'
            ListFieldIndex = 0
            TabOrder = 14
            Color = clWindow
            OnCloseUp = lkDurumCloseUp
          end
          object lblOncelik: TUniLabel
            Left = 16
            Top = 487
            Width = 39
            Height = 13
            Hint = ''
            Caption = #214'ncelik'
            TabOrder = 0
          end
          object cbOncelik: TUniComboBox
            Left = 120
            Top = 483
            Width = 200
            Height = 27
            Hint = ''
            Style = csDropDownList
            Text = ''
            TabOrder = 15
            IconItems = <>
          end
          object lblYapan: TUniLabel
            Left = 330
            Top = 487
            Width = 32
            Height = 13
            Hint = ''
            Caption = 'Yapan'
            TabOrder = 30
          end
          object lblYapanDeger: TUniLabel
            Left = 380
            Top = 487
            Width = 220
            Height = 13
            Hint = ''
            Caption = ''
            ParentFont = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clGray
            Font.Height = -12
            TabOrder = 31
          end
        end
        object panEkler: TUniPanel
          Left = 0
          Top = 520
          Width = 632
          Height = 180
          Hint = ''
          Align = alBottom
          TabOrder = 1
          BorderStyle = ubsNone
          Caption = ''
          Layout = 'vbox'
          LayoutConfig.Flex = 1
          LayoutConfig.Height = '100%'
          LayoutConfig.Width = '100%'
          object lblEkler: TUniLabel
            Left = 16
            Top = 4
            Width = 68
            Height = 13
            Hint = ''
            Caption = 'Ekler (Dosya)'
            ParentFont = False
            Font.Charset = TURKISH_CHARSET
            Font.Color = clNavy
            Font.Height = -12
            Font.Style = [fsBold]
            TabOrder = 0
          end
          object panEkBar: TUniPanel
            Left = 0
            Top = 20
            Width = 632
            Height = 40
            Hint = ''
            TabOrder = 1
            BorderStyle = ubsNone
            Caption = ''
            LayoutConfig.Width = '100%'
            object btnEkEkle: TUniButton
              Left = 12
              Top = 4
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
              TabOrder = 1
              ClientEvents.UniEvents.Strings = (
                
                  'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
                  'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
              OnClick = btnEkEkleClick
            end
            object btnEkIndir: TUniButton
              Left = 172
              Top = 4
              Width = 130
              Height = 30
              Hint = 'Se'#231'ili eki indir'
              Caption = #304'ndir'
              ParentFont = False
              Font.Charset = TURKISH_CHARSET
              Font.Height = -12
              Font.Name = 'Segoe UI Semibold'
              Font.Style = [fsBold]
              TabOrder = 2
              OnClick = btnEkIndirClick
            end
            object btnEkSil: TUniButton
              Left = 312
              Top = 4
              Width = 130
              Height = 30
              Hint = 'Se'#231'ili eki sil'
              Caption = 'Sil'
              ParentFont = False
              Font.Charset = TURKISH_CHARSET
              Font.Height = -12
              Font.Name = 'Segoe UI Semibold'
              Font.Style = [fsBold]
              TabOrder = 3
              OnClick = btnEkSilClick
            end
          end
          object grdEk: TUniDBGrid
            Left = 0
            Top = 60
            Width = 632
            Height = 260
            Hint = ''
            DataSource = dsEk
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgTabs, dgAutoRefreshRow]
            ReadOnly = True
            WebOptions.Paged = False
            WebOptions.FetchAll = True
            LoadMask.Message = 'Loading data...'
            LayoutConfig.Flex = 1
            LayoutConfig.Height = '100%'
            LayoutConfig.Width = '100%'
            TabOrder = 3
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
      end
      object tsKontrol: TUniTabSheet
        Hint = ''
        Caption = 'Kontrol Listesi'
        Layout = 'vbox'
        object panKontrolTb: TUniPanel
          Left = 0
          Top = 0
          Width = 632
          Height = 40
          Hint = ''
          TabOrder = 0
          BorderStyle = ubsNone
          Caption = ''
          Color = 15790320
          LayoutConfig.Width = '100%'
          object lblKontrolBilgi: TUniLabel
            Left = 12
            Top = 12
            Width = 160
            Height = 13
            Hint = ''
            Caption = 'Aktivite tipine ba'#287'l'#305' soru setleri'
            TabOrder = 2
          end
          object btnKontrolKaydet: TUniButton
            Left = 470
            Top = 6
            Width = 150
            Height = 28
            Hint = ''
            Caption = 'Cevaplar'#305' Kaydet'
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
            OnClick = btnKontrolKaydetClick
          end
        end
        object panKontrol: TUniPanel
          Left = 0
          Top = 40
          Width = 632
          Height = 660
          Hint = ''
          TabOrder = 1
          ClientEvents.UniEvents.Strings = (
            
              'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      config.' +
              'autoScroll = true;'#13#10'      config.scrollable = true;'#13#10'}')
          BorderStyle = ubsNone
          Caption = ''
          LayoutConfig.Flex = 1
          LayoutConfig.Height = '100%'
          LayoutConfig.Width = '100%'
        end
      end
      object tsTarihce: TUniTabSheet
        Hint = ''
        Caption = 'Tarih'#231'e'
        Layout = 'fit'
        object grdTarihce: TUniDBGrid
          Left = 0
          Top = 0
          Width = 632
          Height = 700
          Hint = ''
          DataSource = dsLog
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgTabs, dgCancelOnExit]
          ReadOnly = True
          WebOptions.Paged = False
          WebOptions.FetchAll = True
          LoadMask.Message = 'Loading data...'
          LayoutConfig.Flex = 1
          LayoutConfig.Height = '100%'
          LayoutConfig.Width = '100%'
          TabOrder = 0
        end
      end
    end
    object panFooter: TUniPanel
      Left = 0
      Top = 728
      Width = 640
      Height = 52
      Hint = ''
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      LayoutConfig.Width = '100%'
      object btnKaydet: TUniButton
        Left = 120
        Top = 10
        Width = 140
        Height = 36
        Hint = ''
        Caption = 'Aktivite Kaydet'
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
    end
  end
  object fuEk: TUniFileUpload
    MaxAllowedSize = 52428800
    Title = 'Dosya Ekle'
    Messages.Uploading = 'Uploading...'
    Messages.PleaseWait = 'Please Wait'
    Messages.Cancel = 'Cancel'
    Messages.Processing = 'Processing...'
    Messages.UploadError = 'Upload Error'
    Messages.Upload = 'Upload'
    Messages.NoFileError = 'Please select a file'
    Messages.BrowseText = 'Browse...'
    Messages.UploadTimeout = 'Timeout occurred...'
    Messages.MaxSizeError = 'File is bigger than maximum allowed size'
    Messages.MaxFilesError = 'You can upload maximum %d files.'
    Width = 160
    ButtonOnly = True
    OnCompleted = fuEkCompleted
    Left = 288
    Top = 608
  end
  object qExec: TUniQuery
    Connection = frmDM.conAsya
    Left = 328
    Top = 608
  end
  object qLoad: TUniQuery
    Connection = frmDM.conAsya
    Left = 392
    Top = 592
  end
  object qTipLkp: TUniQuery
    Connection = frmDM.conAsya
    Left = 512
    Top = 632
  end
  object dsTipLkp: TUniDataSource
    DataSet = qTipLkp
    Left = 464
    Top = 632
  end
  object qDurLkp: TUniQuery
    Connection = frmDM.conAsya
    Left = 528
    Top = 608
  end
  object dsDurLkp: TUniDataSource
    DataSet = qDurLkp
    Left = 568
    Top = 592
  end
  object qEk: TUniQuery
    Connection = frmDM.conAsya
    Left = 408
    Top = 552
  end
  object dsEk: TUniDataSource
    DataSet = qEk
    Left = 456
    Top = 584
  end
  object qEkExec: TUniQuery
    Connection = frmDM.conAsya
    Left = 472
    Top = 528
  end
  object qKontrol: TUniQuery
    Connection = frmDM.conAsya
    Left = 328
    Top = 552
  end
  object qSecenek: TUniQuery
    Connection = frmDM.conAsya
    Left = 360
    Top = 552
  end
  object qCevap: TUniQuery
    Connection = frmDM.conAsya
    Left = 392
    Top = 552
  end
  object qKontrolExec: TUniQuery
    Connection = frmDM.conAsya
    Left = 424
    Top = 552
  end
  object qLog: TUniQuery
    Connection = frmDM.conAsya
    Left = 488
    Top = 552
  end
  object dsLog: TUniDataSource
    DataSet = qLog
    Left = 520
    Top = 552
  end
  object qLogExec: TUniQuery
    Connection = frmDM.conAsya
    Left = 552
    Top = 552
  end
  object saBaglantiDurum: TUniSweetAlert
    Title = 'Durum g'#252'ncelle'
    ConfirmButtonText = 'Evet'
    CancelButtonText = 'Hay'#305'r'
    AlertType = atQuestion
    Padding = 20
    ShowCancelButton = True
    OnConfirm = saBaglantiDurumConfirm
    Left = 320
    Top = 600
  end
end
