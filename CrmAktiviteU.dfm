object frmCrmAktivite: TfrmCrmAktivite
  Left = 0
  Top = 0
  ClientHeight = 780
  ClientWidth = 640
  Caption = 'Yeni Aktivite'
  OnShow = UniFormShow
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
    object pgc: TUniPageControl
      Left = 0
      Top = 0
      Width = 640
      Height = 728
      Hint = ''
      ActivePage = tsGenel
      Align = alClient
      TabOrder = 0
      object tsGenel: TUniTabSheet
        Hint = ''
        Caption = 'Genel'
        object panMain: TUniPanel
          Left = 0
          Top = 0
          Width = 640
          Height = 728
          Hint = ''
          Align = alClient
          TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      object lblTip: TUniLabel
        Left = 16
        Top = 16
        Width = 15
        Height = 13
        Hint = ''
        Caption = 'Tip'
        TabOrder = 0
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
        TabOrder = 2
      end
      object edKonu: TUniEdit
        Left = 120
        Top = 48
        Width = 480
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 3
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
        TabOrder = 4
      end
      object mmAciklama: TUniMemo
        Left = 120
        Top = 84
        Width = 480
        Height = 88
        Hint = ''
        TabOrder = 5
      end
      object lblCari: TUniLabel
        Left = 16
        Top = 184
        Width = 60
        Height = 13
        Hint = ''
        Caption = 'Cari (Netsis)'
        TabOrder = 6
      end
      object edCariKod: TUniEdit
        Left = 120
        Top = 180
        Width = 340
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 7
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
        TabOrder = 8
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
        TabOrder = 18
      end
      object lblTeklif: TUniLabel
        Left = 16
        Top = 244
        Width = 55
        Height = 13
        Hint = ''
        Caption = 'Ba'#287'l'#305' Teklif'
        TabOrder = 9
      end
      object lkTeklif: TUniDBLookupComboBox
        Left = 120
        Top = 240
        Width = 340
        Height = 27
        Hint = ''
        ListField = 'AD'
        ListSource = dsTekLkp
        KeyField = 'TEKLIF_ID'
        ListFieldIndex = 0
        TabOrder = 10
        Color = clWindow
      end
      object btnTeklifYenile: TUniButton
        Left = 470
        Top = 238
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
        TabOrder = 11
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'secondary'#39';'#13#10'}')
        OnClick = btnTeklifYenileClick
      end
      object lblSiparis: TUniLabel
        Left = 16
        Top = 280
        Width = 95
        Height = 13
        Hint = ''
        Caption = 'Sipari'#351' No (NETS'#304'S)'
        TabOrder = 12
      end
      object edSiparis: TUniEdit
        Left = 120
        Top = 276
        Width = 340
        Height = 27
        Hint = 'Netsis / ERP siparis referansi (tekliften bagimsiz)'
        Text = ''
        TabOrder = 13
      end
      object lblTarih: TUniLabel
        Left = 16
        Top = 316
        Width = 24
        Height = 13
        Hint = ''
        Caption = 'Tarih'
        TabOrder = 14
      end
      object dtAktivite: TUniDateTimePicker
        Left = 120
        Top = 312
        Width = 200
        Height = 27
        Hint = ''
        DateTime = 46109.000000000000000000
        DateFormat = 'dd/MM/yyyy'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 15
        DisabledDates = <>
      end
      object lblDurum: TUniLabel
        Left = 16
        Top = 352
        Width = 35
        Height = 13
        Hint = ''
        Caption = 'Durum'
        TabOrder = 16
      end
      object lkDurum: TUniDBLookupComboBox
        Left = 120
        Top = 348
        Width = 460
        Height = 27
        Hint = ''
        ListField = 'AD'
        ListSource = dsDurLkp
        KeyField = 'DURUM_ID'
        ListFieldIndex = 0
        TabOrder = 17
        Color = clWindow
      end
      object lblOncelik: TUniLabel
        Left = 16
        Top = 388
        Width = 39
        Height = 13
        Hint = ''
        Caption = #214'ncelik'
        TabOrder = 19
      end
      object cbOncelik: TUniComboBox
        Left = 120
        Top = 384
        Width = 200
        Height = 27
        Hint = ''
        Style = csDropDownList
        Text = ''
        TabOrder = 20
        IconItems = <>
      end
      object lblEkler: TUniLabel
        Left = 16
        Top = 428
        Width = 68
        Height = 13
        Hint = ''
        Caption = 'Ekler (Dosya)'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Style = [fsBold]
        TabOrder = 21
      end
      object btnEkEkle: TUniButton
        Left = 120
        Top = 446
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
        TabOrder = 22
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
        OnClick = btnEkEkleClick
      end
      object btnEkIndir: TUniButton
        Left = 300
        Top = 446
        Width = 130
        Height = 30
        Hint = 'Se'#231'ili eki indir'
        Caption = #304'ndir'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Height = -12
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 23
        OnClick = btnEkIndirClick
      end
      object btnEkSil: TUniButton
        Left = 440
        Top = 446
        Width = 130
        Height = 30
        Hint = 'Se'#231'ili eki sil'
        Caption = 'Sil'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Height = -12
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 24
        OnClick = btnEkSilClick
      end
      object grdEk: TUniDBGrid
        Left = 16
        Top = 488
        Width = 600
        Height = 228
        Hint = ''
        DataSource = dsEk
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgTabs, dgAutoRefreshRow]
        ReadOnly = True
        WebOptions.Paged = False
        WebOptions.FetchAll = True
        LoadMask.Message = 'Loading data...'
        TabOrder = 25
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
        object panKontrolTb: TUniPanel
          Left = 0
          Top = 0
          Width = 640
          Height = 40
          Hint = ''
          Align = alTop
          TabOrder = 0
          BorderStyle = ubsNone
          Caption = ''
          Color = 15790320
          object lblKontrolBilgi: TUniLabel
            Left = 12
            Top = 12
            Width = 420
            Height = 16
            Hint = ''
            Caption = 'Aktivite tipine ba'#287'l'#305' soru setleri'
            TabOrder = 0
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
            TabOrder = 1
            ClientEvents.UniEvents.Strings = (
              
                'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
                'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
            OnClick = btnKontrolKaydetClick
          end
        end
        object panKontrol: TUniPanel
          Left = 0
          Top = 40
          Width = 640
          Height = 688
          Hint = ''
          Align = alClient
          TabOrder = 1
          BorderStyle = ubsNone
          Caption = ''
          ClientEvents.UniEvents.Strings = (
            
              'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      config' +
              '.autoScroll = true;'#13#10'      config.scrollable = true;'#13#10'}')
        end
      end
      object tsTarihce: TUniTabSheet
        Hint = ''
        Caption = 'Tarih'#231'e'
        object grdTarihce: TUniDBGrid
          Left = 0
          Top = 0
          Width = 632
          Height = 728
          Hint = ''
          DataSource = dsLog
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgTabs, dgCancelOnExit]
          ReadOnly = True
          WebOptions.Paged = False
          WebOptions.FetchAll = True
          LoadMask.Message = 'Loading data...'
          Align = alClient
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
      Align = alBottom
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      Color = 15790320
      object btnKaydet: TUniButton
        Left = 120
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
  object qTekLkp: TUniQuery
    Connection = frmDM.conAsya
    Left = 560
    Top = 520
  end
  object dsTekLkp: TUniDataSource
    DataSet = qTekLkp
    Left = 592
    Top = 520
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
end
