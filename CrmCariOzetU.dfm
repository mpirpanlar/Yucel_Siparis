object frmCrmCariOzet: TfrmCrmCariOzet
  Left = 0
  Top = 0
  ClientHeight = 560
  ClientWidth = 960
  Caption = 'frmCrmCariOzet'
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
    Width = 960
    Height = 560
    Hint = ''
    Align = alClient
    TabOrder = 0
    BorderStyle = ubsNone
    Caption = ''
    object pnlToolbar: TUniPanel
      Left = 0
      Top = 0
      Width = 960
      Height = 48
      Hint = ''
      Align = alTop
      TabOrder = 0
      BorderStyle = ubsNone
      Caption = ''
      Color = 10865101
      object lblCari: TUniLabel
        Left = 12
        Top = 14
        Width = 43
        Height = 13
        Hint = ''
        Caption = 'Cari Kod'
        ParentFont = False
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        TabOrder = 0
      end
      object edCariKod: TUniEdit
        Left = 78
        Top = 10
        Width = 160
        Height = 27
        Hint = ''
        Text = ''
        TabOrder = 1
      end
      object btnCariBul: TUniButton
        Left = 244
        Top = 8
        Width = 72
        Height = 30
        Hint = ''
        Caption = 'Bul'
        TabOrder = 2
        OnClick = btnCariBulClick
      end
      object btnListele: TUniButton
        Left = 324
        Top = 8
        Width = 100
        Height = 30
        Hint = ''
        Caption = 'Listele'
        TabOrder = 3
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'primary'#39';'#13#10'}')
        OnClick = btnListeleClick
      end
      object btnAc: TUniButton
        Left = 432
        Top = 8
        Width = 120
        Height = 30
        Hint = ''
        Caption = 'Kayd'#305' A'#231
        TabOrder = 4
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'secondary'#39';'#13#10'}')
        OnClick = btnAcClick
      end
      object btnKapat: TUniButton
        Left = 860
        Top = 0
        Width = 100
        Height = 48
        Hint = ''
        Caption = 'Kapat'
        Align = alRight
        TabOrder = 5
        ClientEvents.UniEvents.Strings = (
          
            'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'      sender.' +
            'xtype = '#39'button'#39';'#13#10'      sender.ui = '#39'secondary'#39';'#13#10'}')
        OnClick = btnKapatClick
      end
    end
    object pcMain: TUniPageControl
      Left = 0
      Top = 48
      Width = 960
      Height = 512
      Hint = ''
      ActivePage = tabAktivite
      Align = alClient
      TabOrder = 1
      object tabAktivite: TUniTabSheet
        Hint = ''
        Caption = 'Aktiviteler'
        object panAkt: TUniPanel
          Left = 0
          Top = 0
          Width = 952
          Height = 484
          Hint = ''
          Align = alClient
          TabOrder = 0
          BorderStyle = ubsNone
          Caption = ''
          object grdAkt: TUniDBGrid
            Left = 0
            Top = 0
            Width = 952
            Height = 484
            Hint = ''
            DataSource = dsAkt
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
            ReadOnly = True
            WebOptions.Paged = False
            WebOptions.FetchAll = True
            LoadMask.Message = 'Loading data...'
            Align = alClient
            TabOrder = 0
            OnAjaxEvent = grdAktAjaxEvent
            Columns = <
              item
                FieldName = 'AKTIVITE_ID'
                Title.Caption = 'ID'
                Width = 50
                ReadOnly = True
              end
              item
                FieldName = 'TIP_GORUNEN'
                Title.Caption = 'Tip'
                Width = 90
                ReadOnly = True
              end
              item
                FieldName = 'KONU'
                Title.Caption = 'Konu'
                Width = 200
                ReadOnly = True
              end
              item
                FieldName = 'TEKLIF_NO'
                Title.Caption = 'Teklif no'
                Width = 90
                ReadOnly = True
              end
              item
                FieldName = 'SIPARIS_NO'
                Title.Caption = 'Siparis no'
                Width = 85
                ReadOnly = True
              end
              item
                FieldName = 'AKTIVITE_TARIHI'
                Title.Caption = 'Tarih'
                Width = 130
                ReadOnly = True
              end
              item
                FieldName = 'DURUM'
                Title.Caption = 'Durum'
                Width = 90
                ReadOnly = True
              end>
          end
        end
      end
      object tabGorev: TUniTabSheet
        Hint = ''
        Caption = 'G'#246'revler'
        object panGrv: TUniPanel
          Left = 0
          Top = 0
          Width = 952
          Height = 484
          Hint = ''
          Align = alClient
          TabOrder = 0
          BorderStyle = ubsNone
          Caption = ''
          object grdGrv: TUniDBGrid
            Left = 0
            Top = 0
            Width = 952
            Height = 484
            Hint = ''
            DataSource = dsGrv
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
            ReadOnly = True
            WebOptions.Paged = False
            WebOptions.FetchAll = True
            LoadMask.Message = 'Loading data...'
            Align = alClient
            TabOrder = 0
            OnAjaxEvent = grdGrvAjaxEvent
            Columns = <
              item
                FieldName = 'GOREV_ID'
                Title.Caption = 'Gorev ID'
                Width = 70
                ReadOnly = True
              end
              item
                FieldName = 'KONU'
                Title.Caption = 'Konu'
                Width = 260
                ReadOnly = True
              end
              item
                FieldName = 'AKTIVITE_TARIHI'
                Title.Caption = 'Aktivite tar.'
                Width = 120
                ReadOnly = True
              end
              item
                FieldName = 'DURUM'
                Title.Caption = 'Durum'
                Width = 80
                ReadOnly = True
              end
              item
                FieldName = 'BITIS_TARIHI'
                Title.Caption = 'Bitis'
                Width = 120
                ReadOnly = True
              end
              item
                FieldName = 'ONCELIK'
                Title.Caption = 'Oncelik'
                Width = 70
                ReadOnly = True
              end
              item
                FieldName = 'TAMAMLANDI'
                Title.Caption = 'Tamam'
                Width = 60
                ReadOnly = True
              end>
          end
        end
      end
      object tabTeklif: TUniTabSheet
        Hint = ''
        Caption = 'Teklifler'
        object panTek: TUniPanel
          Left = 0
          Top = 0
          Width = 952
          Height = 484
          Hint = ''
          Align = alClient
          TabOrder = 0
          BorderStyle = ubsNone
          Caption = ''
          object grdTek: TUniDBGrid
            Left = 0
            Top = 0
            Width = 952
            Height = 484
            Hint = ''
            DataSource = dsTek
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgTabs, dgCancelOnExit, dgAutoRefreshRow]
            ReadOnly = True
            WebOptions.Paged = False
            WebOptions.FetchAll = True
            LoadMask.Message = 'Loading data...'
            Align = alClient
            TabOrder = 0
            OnAjaxEvent = grdTekAjaxEvent
            Columns = <
              item
                FieldName = 'TEKLIF_ID'
                Title.Caption = 'ID'
                Width = 50
                ReadOnly = True
              end
              item
                FieldName = 'TEKLIF_NO'
                Title.Caption = 'Teklif no'
                Width = 100
                ReadOnly = True
              end
              item
                FieldName = 'SIPARIS_NO'
                Title.Caption = 'Siparis no'
                Width = 90
                ReadOnly = True
              end
              item
                FieldName = 'BASLIK'
                Title.Caption = 'Baslik'
                Width = 220
                ReadOnly = True
              end
              item
                FieldName = 'TEKLIF_TARIHI'
                Title.Caption = 'Teklif tar.'
                Width = 130
                ReadOnly = True
              end
              item
                FieldName = 'DURUM'
                Title.Caption = 'Durum'
                Width = 90
                ReadOnly = True
              end
              item
                FieldName = 'TOPLAM_NET'
                Title.Caption = 'Toplam'
                Width = 90
                ReadOnly = True
              end>
          end
        end
      end
    end
  end
  object qAkt: TUniQuery
    Connection = frmDM.conAsya
    Left = 800
    Top = 400
  end
  object dsAkt: TUniDataSource
    DataSet = qAkt
    Left = 832
    Top = 400
  end
  object qGrv: TUniQuery
    Connection = frmDM.conAsya
    Left = 880
    Top = 400
  end
  object dsGrv: TUniDataSource
    DataSet = qGrv
    Left = 912
    Top = 400
  end
  object qTek: TUniQuery
    Connection = frmDM.conAsya
    Left = 800
    Top = 448
  end
  object dsTek: TUniDataSource
    DataSet = qTek
    Left = 832
    Top = 448
  end
end
