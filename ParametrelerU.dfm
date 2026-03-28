object frmParametreler: TfrmParametreler
  Left = 0
  Top = 0
  ClientHeight = 818
  ClientWidth = 1263
  Caption = 'frmParametreler'
  OnShow = UniFormShow
  BorderStyle = bsNone
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  AlignmentControl = uniAlignmentClient
  Layout = 'fit'
  PixelsPerInch = 96
  TextHeight = 13
  object UniContainerPanel1: TUniContainerPanel
    Left = 14
    Top = 21
    Width = 1163
    Height = 753
    Hint = ''
    ParentColor = False
    TabOrder = 0
    Layout = 'vbox'
    object UniPanel2: TUniPanel
      Left = 31
      Top = 11
      Width = 938
      Height = 35
      Hint = ''
      TabOrder = 1
      BorderStyle = ubsNone
      Caption = ''
      Color = 6309686
      Layout = 'hbox'
      LayoutConfig.Width = '100%'
      object bntKaydet: TUniButton
        Left = 15
        Top = 6
        Width = 100
        Height = 25
        Hint = ''
        Caption = 'Kaydet'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 1
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      config.' +
            'cls="btnKaydet";'#13#10'}')
        ScreenMask.Enabled = True
        LayoutConfig.Margin = '3 5 3 3'
        OnClick = bntKaydetClick
      end
      object btnDuzenle: TUniButton
        Left = 137
        Top = 6
        Width = 100
        Height = 25
        Hint = ''
        Caption = 'D'#252'zenle'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 3
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      config.' +
            'cls="btnDuzenle";'#13#10'}')
        LayoutConfig.Margin = '3 5 3 3'
        OnClick = btnDuzenleClick
      end
      object btnKapat: TUniButton
        Left = 389
        Top = 6
        Width = 100
        Height = 25
        Hint = ''
        Caption = 'Kapat'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        TabOrder = 2
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      config.' +
            'cls="btnKapat";'#13#10'}')
        LayoutConfig.Margin = '3 5 3 3'
        OnClick = btnKapatClick
      end
    end
    object UniPanel1: TUniPanel
      Left = 31
      Top = 48
      Width = 938
      Height = 32
      Hint = ''
      TabOrder = 3
      BorderStyle = ubsNone
      Caption = ''
      Color = 9470064
      Layout = 'hbox'
      LayoutConfig.Width = '100%'
      object btnGenel: TUniSpeedButton
        Left = 12
        Top = 4
        Width = 89
        Height = 24
        Hint = ''
        GroupIndex = 1
        Down = True
        Caption = 'Genel'
        ParentColor = False
        Color = clWindow
        LayoutConfig.Margin = '3 3 3 3'
        TabOrder = 1
        OnClick = btnGenelClick
      end
      object btnYetkili: TUniSpeedButton
        Left = 107
        Top = 4
        Width = 89
        Height = 24
        Hint = ''
        GroupIndex = 1
        Caption = 'Fatura'
        ParentColor = False
        Color = clWindow
        LayoutConfig.Margin = '3 3 3 3'
        TabOrder = 2
        OnClick = btnYetkiliClick
      end
      object btnBanka: TUniSpeedButton
        Left = 202
        Top = 4
        Width = 89
        Height = 24
        Hint = ''
        Visible = False
        GroupIndex = 1
        Caption = 'Bankalar'
        ParentColor = False
        Color = clWindow
        LayoutConfig.Margin = '3 3 3 3'
        TabOrder = 3
      end
    end
    object UniSimplePanel4: TUniSimplePanel
      Left = 31
      Top = 86
      Width = 1090
      Height = 587
      Hint = ''
      ParentColor = False
      TabOrder = 2
      Layout = 'vbox'
      LayoutConfig.Flex = 1
      LayoutConfig.Height = '100%'
      LayoutConfig.Width = '100%'
      object UniPageControl1: TUniPageControl
        Left = 3
        Top = 16
        Width = 1062
        Height = 545
        Hint = ''
        ActivePage = tabGenel
        TabBarVisible = False
        LayoutConfig.Height = '100%'
        LayoutConfig.Width = '100%'
        LayoutConfig.Margin = '5 5 5 5'
        TabOrder = 1
        object tabGenel: TUniTabSheet
          Hint = ''
          Caption = 'Genel Bilgiler'
          ClientEvents.UniEvents.Strings = (
            
              'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'   config.dis' +
              'abledCls = "_x-item-disabled";'#13#10'}')
          Layout = 'hbox'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 289
          ExplicitHeight = 193
          object UniSimplePanel2: TUniSimplePanel
            Left = 24
            Top = 17
            Width = 260
            Height = 432
            Hint = ''
            ParentColor = False
            TabOrder = 0
            Layout = 'vbox'
            LayoutConfig.Height = '100%'
            LayoutConfig.Margin = '2 2 2 2'
            object UniDBCheckBox2: TUniDBCheckBox
              Left = 23
              Top = 17
              Width = 150
              Height = 22
              Hint = ''
              DataField = 'AutoCari'
              ValueChecked = '1'
              ValueUnchecked = '0'
              Caption = 'Otomatik Cari Kod'
              ParentFont = False
              Font.Height = -15
              TabOrder = 1
              ParentColor = False
              Color = clBtnFace
              LayoutConfig.Width = '100%'
              LayoutConfig.Margin = '5 5 5 5'
              FieldLabelWidth = 110
            end
            object UniDBCheckBox3: TUniDBCheckBox
              Left = 23
              Top = 45
              Width = 150
              Height = 22
              Hint = ''
              DataField = 'AutoStok'
              ValueChecked = '1'
              ValueUnchecked = '0'
              Caption = 'Otomatik Stok Kod'
              ParentFont = False
              Font.Height = -15
              TabOrder = 2
              ParentColor = False
              Color = clBtnFace
              LayoutConfig.Width = '100%'
              LayoutConfig.Margin = '5 5 5 5'
              FieldLabelWidth = 110
            end
            object edCariKod: TUniDBEdit
              Left = 13
              Top = 93
              Width = 225
              Height = 22
              Hint = ''
              DataField = 'CariOnEk'
              TabOrder = 3
              LayoutConfig.Width = '100%'
              LayoutConfig.Margin = '3 3 3 3'
              FieldLabel = 'Cari Kod '#214'n Eki'
              FieldLabelWidth = 120
              FieldLabelFont.Height = -15
            end
            object UniDBEdit1: TUniDBEdit
              Left = 13
              Top = 133
              Width = 225
              Height = 22
              Hint = ''
              DataField = 'StokOnEk'
              TabOrder = 4
              LayoutConfig.Width = '100%'
              LayoutConfig.Margin = '3 3 3 3'
              FieldLabel = 'Stok Kod '#214'n Eki'
              FieldLabelWidth = 120
              FieldLabelFont.Height = -15
            end
            object edCariNo: TUniEdit
              Left = 13
              Top = 176
              Width = 220
              Hint = ''
              Text = ''
              TabOrder = 5
              FieldLabel = 'Cari Kod No'
              FieldLabelWidth = 120
              Triggers = <
                item
                  ImageIndex = 4
                  ButtonId = 0
                  HandleClicks = True
                end>
              LayoutConfig.Width = '100%'
              LayoutConfig.Margin = '3 3 3 3'
              OnTriggerEvent = edCariNoTriggerEvent
            end
            object edStokNo: TUniEdit
              Left = 13
              Top = 216
              Width = 220
              Hint = ''
              Text = ''
              TabOrder = 6
              FieldLabel = 'Stok Kod No'
              FieldLabelWidth = 120
              Triggers = <
                item
                  ImageIndex = 4
                  ButtonId = 0
                  HandleClicks = True
                end>
              LayoutConfig.Width = '100%'
              LayoutConfig.Margin = '3 3 3 3'
              OnTriggerEvent = edStokNoTriggerEvent
            end
            object lcParaBirimi: TUniDBLookupComboBox
              Left = 13
              Top = 263
              Width = 225
              Hint = ''
              ListField = 'CurrencyCode'
              KeyField = 'CurrencyCode'
              ListFieldIndex = 0
              DataField = 'YerelParaBirimi'
              TabOrder = 7
              Color = clWindow
              LayoutConfig.Width = '100%'
              LayoutConfig.Margin = '3 3 3 3'
              FieldLabel = 'Yerel Para Birimi'
              FieldLabelWidth = 120
            end
          end
          object UniSimplePanel1: TUniSimplePanel
            Left = 303
            Top = 17
            Width = 260
            Height = 432
            Hint = ''
            ParentColor = False
            TabOrder = 1
            Layout = 'vbox'
            LayoutConfig.Height = '100%'
            LayoutConfig.Margin = '2 2 2 2'
          end
        end
        object TabFatura: TUniTabSheet
          Hint = ''
          Caption = 'Fatura'
          Layout = 'hbox'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 256
          ExplicitHeight = 128
          object UniSimplePanel3: TUniSimplePanel
            Left = 32
            Top = 25
            Width = 280
            Height = 432
            Hint = ''
            ParentColor = False
            TabOrder = 0
            Layout = 'vbox'
            LayoutConfig.Height = '100%'
            LayoutConfig.Margin = '2 2 2 2'
            object UniDBCheckBox4: TUniDBCheckBox
              Left = 23
              Top = 17
              Width = 210
              Height = 22
              Hint = ''
              DataField = 'Ftr_SatisGuncelle'
              ValueChecked = '1'
              ValueUnchecked = '0'
              Caption = 'Sat'#305#351' Fiyatlar'#305' Stok Kart'#305'na '#304#351'lensin'
              ParentFont = False
              Font.Height = -15
              TabOrder = 1
              ParentColor = False
              Color = clBtnFace
              LayoutConfig.Width = '100%'
              LayoutConfig.Margin = '5 5 5 5'
              FieldLabelWidth = 110
            end
            object UniDBCheckBox5: TUniDBCheckBox
              Left = 23
              Top = 45
              Width = 218
              Height = 22
              Hint = ''
              DataField = 'Ftr_AlisGuncelle'
              ValueChecked = '1'
              ValueUnchecked = '0'
              Caption = 'Al'#305#351' Fiyatlar'#305' Stok Kart'#305'na '#304#351'lensin'
              ParentFont = False
              Font.Height = -15
              TabOrder = 2
              ParentColor = False
              Color = clBtnFace
              LayoutConfig.Width = '100%'
              LayoutConfig.Margin = '5 5 5 5'
              FieldLabelWidth = 110
            end
            object UniDBCheckBox6: TUniDBCheckBox
              Left = 23
              Top = 73
              Width = 218
              Height = 22
              Hint = ''
              DataField = 'Ftr_SatisFiyatKontrol'
              ValueChecked = '1'
              ValueUnchecked = '0'
              Caption = 'Sat'#305#351' Faturas'#305' Fiyat Kontrol'#252
              ParentFont = False
              Font.Height = -15
              TabOrder = 3
              ParentColor = False
              Color = clBtnFace
              LayoutConfig.Width = '100%'
              LayoutConfig.Margin = '5 5 5 5'
              FieldLabelWidth = 110
            end
            object UniDBComboBox1: TUniDBComboBox
              Left = 68
              Top = 113
              Width = 145
              Hint = ''
              DataField = 'Ftr_BFiyatHane'
              Items.Strings = (
                '2'
                '4')
              TabOrder = 4
              FieldLabel = 'Fatura Birim Fiyat Virg'#252'lden Sonra'
              FieldLabelWidth = 200
              LayoutConfig.Width = '100%'
              LayoutConfig.Margin = '5 5 5 5'
              IconItems = <>
            end
            object UniDBComboBox2: TUniDBComboBox
              Left = 68
              Top = 153
              Width = 145
              Hint = ''
              DataField = 'Ftr_MiktarHane'
              Items.Strings = (
                '2'
                '4')
              TabOrder = 5
              FieldLabel = 'Fatura Miktar Virg'#252'lden Sonra'
              FieldLabelWidth = 200
              LayoutConfig.Width = '100%'
              LayoutConfig.Margin = '5 5 5 5'
              IconItems = <>
            end
          end
          object UniSimplePanel5: TUniSimplePanel
            Left = 343
            Top = 25
            Width = 320
            Height = 432
            Hint = ''
            ParentColor = False
            TabOrder = 1
            Layout = 'vbox'
            LayoutConfig.Height = '100%'
            LayoutConfig.Margin = '2 2 2 2'
            object UniDBEdit3: TUniDBEdit
              Left = 15
              Top = 17
              Width = 225
              Height = 22
              Hint = ''
              DataField = 'FaturaSeri'
              TabOrder = 1
              LayoutConfig.Width = '100%'
              LayoutConfig.Margin = '3 3 3 3'
              FieldLabel = 'Ka'#287#305't Fatura Seri'
              FieldLabelWidth = 160
              FieldLabelFont.Height = -15
            end
            object UniDBEdit4: TUniDBEdit
              Left = 15
              Top = 45
              Width = 225
              Height = 22
              Hint = ''
              DataField = 'FaturaNoFormat'
              TabOrder = 2
              LayoutConfig.Width = '100%'
              LayoutConfig.Margin = '3 3 3 3'
              FieldLabel = 'Ka'#287#305't Fatura Format'
              FieldLabelWidth = 160
              FieldLabelFont.Height = -15
            end
            object edFaturaSeriNo: TUniEdit
              Left = 15
              Top = 73
              Width = 220
              Hint = ''
              Text = ''
              TabOrder = 3
              FieldLabel = 'Ka'#287#305't Fatura No'
              FieldLabelWidth = 160
              FieldLabelFont.Height = -15
              Triggers = <
                item
                  ImageIndex = 4
                  ButtonId = 0
                  HandleClicks = True
                end>
              LayoutConfig.Width = '100%'
              LayoutConfig.Margin = '3 3 3 3'
              OnTriggerEvent = edFaturaSeriNoTriggerEvent
            end
            object UniDBEdit5: TUniDBEdit
              Left = 15
              Top = 101
              Width = 225
              Height = 22
              Hint = ''
              DataField = 'EFaturaSeri'
              TabOrder = 4
              LayoutConfig.Width = '100%'
              LayoutConfig.Margin = '3 3 3 3'
              FieldLabel = 'E - Fatura Seri'
              FieldLabelWidth = 160
              FieldLabelFont.Height = -15
            end
            object UniDBEdit6: TUniDBEdit
              Left = 15
              Top = 129
              Width = 225
              Height = 22
              Hint = ''
              DataField = 'EFaturaNoFormat'
              TabOrder = 5
              LayoutConfig.Width = '100%'
              LayoutConfig.Margin = '3 3 3 3'
              FieldLabel = 'E - Fatura Format'
              FieldLabelWidth = 160
              FieldLabelFont.Height = -15
            end
            object edEFaturaSeriNo: TUniEdit
              Left = 15
              Top = 157
              Width = 220
              Hint = ''
              Text = ''
              ParentFont = False
              TabOrder = 6
              FieldLabel = 'E - Fatura No'
              FieldLabelWidth = 160
              FieldLabelFont.Height = -15
              Triggers = <
                item
                  ImageIndex = 4
                  ButtonId = 0
                  HandleClicks = True
                end>
              LayoutConfig.Width = '100%'
              LayoutConfig.Margin = '3 3 3 3'
              OnTriggerEvent = edEFaturaSeriNoTriggerEvent
            end
            object UniDBEdit7: TUniDBEdit
              Left = 15
              Top = 185
              Width = 225
              Height = 22
              Hint = ''
              DataField = 'EArsivSeri'
              TabOrder = 7
              LayoutConfig.Width = '100%'
              LayoutConfig.Margin = '3 3 3 3'
              FieldLabel = 'E-Ar'#351'iv Fatura Seri'
              FieldLabelWidth = 160
              FieldLabelFont.Height = -15
            end
            object UniDBEdit8: TUniDBEdit
              Left = 15
              Top = 213
              Width = 225
              Height = 22
              Hint = ''
              DataField = 'EArsivNoFormat'
              TabOrder = 8
              LayoutConfig.Width = '100%'
              LayoutConfig.Margin = '3 3 3 3'
              FieldLabel = 'E-Ar'#351'iv Fatura Format'
              FieldLabelWidth = 160
              FieldLabelFont.Height = -15
            end
            object edEArsivSeriNo: TUniEdit
              Left = 15
              Top = 255
              Width = 220
              Hint = ''
              Text = ''
              ParentFont = False
              TabOrder = 9
              FieldLabel = 'E - Fatura No'
              FieldLabelWidth = 160
              FieldLabelFont.Height = -15
              Triggers = <
                item
                  ImageIndex = 4
                  ButtonId = 0
                  HandleClicks = True
                end>
              LayoutConfig.Width = '100%'
              LayoutConfig.Margin = '3 3 3 3'
              OnTriggerEvent = edEArsivSeriNoTriggerEvent
            end
          end
        end
        object tabBanka: TUniTabSheet
          Hint = ''
          Caption = 'Bankalar'
          Layout = 'vbox'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 256
          ExplicitHeight = 128
          object UniPanel5: TUniPanel
            Left = 23
            Top = 8
            Width = 811
            Height = 40
            Hint = ''
            TabOrder = 1
            BorderStyle = ubsNone
            Caption = ''
            Collapsed = True
            Layout = 'hbox'
            LayoutConfig.Width = '100%'
            LayoutConfig.Margin = '8 3 3 3'
            object UniButton1: TUniButton
              Left = 23
              Top = 5
              Width = 78
              Height = 20
              Hint = ''
              Caption = 'Yeni Sat'#305'r'
              ParentFont = False
              Font.Charset = TURKISH_CHARSET
              Font.Color = clWhite
              Font.Height = -12
              Font.Name = 'Trebuchet MS'
              TabOrder = 1
              ClientEvents.UniEvents.Strings = (
                
                  'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      config.' +
                  'cls="btnYeni";'#13#10'}')
              LayoutConfig.Margin = '3 5 0 20'
            end
            object UniButton2: TUniButton
              Left = 121
              Top = 5
              Width = 78
              Height = 20
              Hint = ''
              Caption = 'Sat'#305'r Kaydet'
              ParentFont = False
              Font.Charset = TURKISH_CHARSET
              Font.Color = clWhite
              Font.Height = -12
              Font.Name = 'Trebuchet MS'
              TabOrder = 2
              ClientEvents.UniEvents.Strings = (
                
                  'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      config.' +
                  'cls="btnKaydet";'#13#10'}')
              ScreenMask.Enabled = True
              LayoutConfig.Margin = '3 5 0 5'
            end
            object UniButton3: TUniButton
              Left = 205
              Top = 5
              Width = 78
              Height = 20
              Hint = ''
              Caption = 'Sat'#305'r Sil'
              ParentFont = False
              Font.Charset = TURKISH_CHARSET
              Font.Color = clWhite
              Font.Height = -12
              Font.Name = 'Trebuchet MS'
              TabOrder = 3
              ClientEvents.UniEvents.Strings = (
                
                  'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      config.' +
                  'cls="btnSil";'#13#10'}')
              ScreenMask.Enabled = True
              LayoutConfig.Margin = '3 5 0 5'
            end
          end
          object UniDBGrid2: TUniDBGrid
            Left = 23
            Top = 67
            Width = 794
            Height = 400
            Hint = ''
            WebOptions.Paged = False
            LoadMask.Message = 'Loading data...'
            LayoutConfig.Margin = '0 3 3 3'
            TabOrder = 0
            Columns = <
              item
                FieldName = 'BankaAd'#305
                Title.Caption = 'Banka Ad'#305
                Width = 150
              end
              item
                FieldName = 'ParaBirimi'
                Title.Caption = 'P.Birimi'
                Width = 75
              end
              item
                FieldName = 'Iban'
                Title.Caption = 'IBAN'
                Width = 140
              end
              item
                FieldName = 'BankaYetkili'
                Title.Caption = 'Yetkili'
                Width = 130
              end
              item
                FieldName = 'BankaTelefon'
                Title.Caption = 'Telefon'
                Width = 95
              end
              item
                FieldName = 'BankaAciklama'
                Title.Caption = 'A'#231#305'klama'
                Width = 180
              end>
          end
        end
      end
    end
  end
  object saSor: TUniSweetAlert
    Title = 'SER'#304' DE'#286#304#350'T'#304'R'
    Text = 'De'#287'i'#351'tirmek '#304'stedi'#287'inize Emin misiniz ?'
    ConfirmButtonText = 'Evet'
    CancelButtonText = 'Hay'#305'r'
    AlertType = atQuestion
    Padding = 20
    ShowCancelButton = True
    OnConfirm = saSorConfirm
    Left = 40
    Top = 160
  end
end
