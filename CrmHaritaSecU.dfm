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
  ClientEvents.UniEvents.Strings = (
    
      'afterScript=function afterScript(sender)'#13#10'{'#13#10' try { var g = window' +
      '.__crmHaritaGrdBridge; if (!g) g = Ext.ComponentQuery.query('#39'[name=grdPick' +
      ']'#39')[0]; if (!g) g = Ext.ComponentQuery.query('#39'unidbgrid'#39')[0];'#13#10' if (' +
      '!g && sender) g = sender.down('#39'unidbgrid'#39'); if (g) window.__crmHaritaGrdB' +
      'ridge = g; } catch (e) { }'#13#10'}')
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
        Width = 160
        Height = 32
        Hint = ''
        Caption = 'Haritayi forma yansit'
        TabOrder = 2
        ClientEvents.UniEvents.Strings = (
          
            'click=function click(sender, e, eOpts)'#13#10'{'#13#10'  var raw = sessionSt' +
            'orage.getItem('#39'crmHaritaPick'#39');'#13#10'  if (!raw && window.parent && ' +
            'window.parent !== window) try { raw = window.parent.sessionStora' +
            'ge.getItem('#39'crmHaritaPick'#39'); } catch (ex) {}'#13#10'  if (!raw) { Ext.' +
            'Msg.alert('#39'Harita'#39','#39'Once haritada bir nokta secin.'#39'); return;'#13#10' ' +
            ' }'#13#10'  var o = JSON.parse(raw);'#13#10'  var g = window.__crmHaritaGrdB' +
            'ridge;'#13#10'  if (!g) g = Ext.ComponentQuery.query('#39'[name=grdPick]'#39')' +
            '[0];'#13#10'  if (!g) g = Ext.ComponentQuery.query('#39'unidbgrid'#39')[0];'#13#10' ' +
            ' if (!g && sender && sender.up) g = sender.up('#39'form'#39') && sender.' +
            'up('#39'form'#39').down('#39'unidbgrid'#39');'#13#10'  if (!g) { Ext.Msg.alert('#39'Hata'#39',' +
            #39'Kopru yok; sayfayi yenileyin.'#39'); return;'#13#10'  }'#13#10'  ajaxRequest(g,' +
            ' '#39'mapPick'#39', ['#13#10'    '#39'lat='#39'+o.lat,'#13#10'    '#39'lng='#39'+o.lng,'#13#10'    '#39'addr='#39 +
            '+encodeURIComponent(o.addr || '#39#39')'#13#10'  ]);'#13#10'}')
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
    object grdPick: TUniDBGrid
      Left = 2400
      Top = 2400
      Width = 24
      Height = 24
      Hint = ''
      DataSource = dsPick
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect]
      WebOptions.Paged = False
      WebOptions.FetchAll = True
      LoadMask.Message = 'Loading data...'
      TabOrder = 2
      OnAjaxEvent = grdPickAjaxEvent
      Columns = <
        item
          FieldName = 'KOD'
          Title.Caption = 'K'
          Width = 40
        end>
    end
  end
  object qPick: TUniQuery
    Connection = frmDM.conAsya
    Left = 40
    Top = 560
  end
  object dsPick: TUniDataSource
    DataSet = qPick
    Left = 72
    Top = 560
  end
end
