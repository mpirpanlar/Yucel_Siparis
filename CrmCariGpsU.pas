unit CrmCariGpsU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniMemo, uniButton, MemDS, DBAccess, Uni, uniURLFrame, Data.DB;

type
  TfrmCrmCariGps = class(TUniForm)
    rootPanel: TUniPanel;
    panMain: TUniPanel;
    lblCariKod: TUniLabel;
    edCariKod: TUniEdit;
    lblCariIsim: TUniLabel;
    edCariIsim: TUniEdit;
    lblGpsE: TUniLabel;
    edGpsEnlem: TUniEdit;
    lblGpsB: TUniLabel;
    edGpsBoylam: TUniEdit;
    btnHaritaKonum: TUniButton;
    btnHaritaYenile: TUniButton;
    lblHarFmt: TUniLabel;
    lblBilgi: TUniLabel;
    mmHaritaAdres: TUniMemo;
    urlMap: TUniURLFrame;
    panFooter: TUniPanel;
    btnKaydet: TUniButton;
    btnKapat: TUniButton;
    btnMapPick: TUniButton;
    qLoad: TUniQuery;
    qExec: TUniQuery;
    procedure UniFormCreate(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure btnHaritaKonumClick(Sender: TObject);
    procedure btnHaritaYenileClick(Sender: TObject);
    procedure btnMapPickAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
  private
    FCariKod: string;
    FMapLat: Double;
    FMapLng: Double;
    function ParseDecimal(const S: string): Double;
    function DecimalToText(const V: Double): string;
    procedure DecimalToParam(Q: TUniQuery; const N: string; const V: Double);
    function ParamsStr(const Params: TUniStrings; const Key: string): string;
    procedure HaritaMerkezGuncelle;
    procedure MapHtmlGoster;
    procedure HaritaWebKancalari;
    procedure HaritaSecimUygula(const ALat, ALng: Double; const AAddr: string);
    procedure YukleKayit;
  public
  end;

function frmCrmCariGps: TfrmCrmCariGps;

implementation

{$R *.dfm}

uses
  System.IOUtils, System.StrUtils, System.NetEncoding, System.Math,
  ServerModule, CrmMapsConfigU,
  uniGUIApplication, MainModule, DMU, CrmHaritaSecU, Main;

function frmCrmCariGps: TfrmCrmCariGps;
begin
  Result := TfrmCrmCariGps(UniMainModule.GetFormInstance(TfrmCrmCariGps));
end;

function TfrmCrmCariGps.ParseDecimal(const S: string): Double;
var
  T: string;
  FS: TFormatSettings;
begin
  T := Trim(StringReplace(S, ',', '.', [rfReplaceAll]));
  FS := TFormatSettings.Invariant;
  FS.DecimalSeparator := '.';
  Result := StrToFloatDef(T, 0, FS);
end;

function TfrmCrmCariGps.DecimalToText(const V: Double): string;
begin
  if Abs(V) < 1E-12 then
    Result := ''
  else
    Result := FormatFloat('0.########', V, TFormatSettings.Invariant);
end;

procedure TfrmCrmCariGps.DecimalToParam(Q: TUniQuery; const N: string; const V: Double);
begin
  if Abs(V) < 1E-12 then
    Q.ParamByName(N).Clear
  else
    Q.ParamByName(N).AsFloat := V;
end;

function TfrmCrmCariGps.ParamsStr(const Params: TUniStrings; const Key: string): string;
var
  I: Integer;
  P, Prefix: string;
begin
  Result := '';
  if Params = nil then
    Exit;
  Prefix := LowerCase(Key) + '=';
  for I := 0 to Params.Count - 1 do
  begin
    P := Params.Strings[I];
    if StartsText(Prefix, LowerCase(P)) then
    begin
      Result := Copy(P, Length(Key) + 2, MaxInt);
      Exit;
    end;
  end;
  for I := 0 to Params.Count - 1 do
  begin
    P := Params.Strings[I];
    if ContainsText(P, Key + '=') then
    begin
      Result := Copy(P, Pos(Key + '=', P) + Length(Key) + 1, MaxInt);
      Exit;
    end;
  end;
end;

procedure TfrmCrmCariGps.HaritaMerkezGuncelle;
var
  La, Ln: Double;
begin
  La := ParseDecimal(edGpsEnlem.Text);
  Ln := ParseDecimal(edGpsBoylam.Text);
  if (Abs(La) < 1E-9) and (Abs(Ln) < 1E-9) then
  begin
    FMapLat := 41.015;
    FMapLng := 28.979;
  end
  else
  begin
    FMapLat := La;
    FMapLng := Ln;
  end;
end;

procedure TfrmCrmCariGps.MapHtmlGoster;
var
  Sl: TStringList;
  Fn, Html, Key, SHasGps: string;
  FS: TFormatSettings;
  HasGps: Boolean;
  Zoom: Integer;
begin
  HaritaMerkezGuncelle;
  Key := Trim(CrmGoogleMapsBrowserApiKey);
  if (Key = '') or SameText(Key, 'YOUR_BROWSER_KEY_HERE') then
  begin
    UniMainModule.saHata.Show(
      'Google Maps API anahtar'#305' CrmMapsConfigU biriminde tan'#305'ml'#305' de'#287'il.');
    Exit;
  end;

  HasGps := (Abs(ParseDecimal(edGpsEnlem.Text)) > 1E-9) or
    (Abs(ParseDecimal(edGpsBoylam.Text)) > 1E-9);
  if HasGps then
  begin
    Zoom := 14;
    SHasGps := 'true';
  end
  else
  begin
    Zoom := 8;
    SHasGps := 'false';
  end;

  FS := TFormatSettings.Invariant;
  Fn := 'crm_cari_gps_' + IntToStr(GetTickCount) + '_' + IntToStr(Random(99999)) + '.html';

  Html :=
    '<!DOCTYPE html><html><head><meta charset="utf-8"/>'#10 +
    '<style>html,body,#map{height:100%;margin:0}</style>'#10 +
    '<script>'#10 +
    'function crmSetHaritaPick(lat,lng,addr){'#10 +
    'var o={lat:lat,lng:lng,addr:(addr||'''')};'#10 +
    'var s=JSON.stringify(o);'#10 +
    'try{ sessionStorage.setItem(''crmHaritaPick'',s);}catch(e){}'#10 +
    'try{'#10 +
    'if(window.parent&&window.parent!==window){'#10 +
    'window.parent.sessionStorage.setItem(''crmHaritaPick'',s);'#10 +
    'window.parent.postMessage({__crmHaritaPick:1,lat:lat,lng:lng,addr:(addr||'''')},''*'');'#10 +
    '}'#10 +
    '}catch(e){}'#10 +
    '}'#10 +
    'function initMap(){'#10 +
    'var c={lat:' + FormatFloat('0.######', FMapLat, FS) + ',lng:' + FormatFloat('0.######', FMapLng, FS) + '};'#10 +
    'var hasGps=' + SHasGps + ';'#10 +
    'var map=new google.maps.Map(document.getElementById(''map''),{zoom:' + IntToStr(Zoom) + ',center:c});'#10 +
    'var mk=null;var geocoder=new google.maps.Geocoder();'#10 +
    'if(hasGps){mk=new google.maps.Marker({position:c,map:map});}'#10 +
    'map.addListener(''click'',function(ev){'#10 +
    'var lat=ev.latLng.lat(),lng=ev.latLng.lng();'#10 +
    'if(mk) mk.setMap(null); mk=new google.maps.Marker({position:ev.latLng,map:map});'#10 +
    'crmSetHaritaPick(lat,lng,'''');'#10 +
    'geocoder.geocode({location:ev.latLng},function(res,status){'#10 +
    'var addr=''''; if(status===''OK'' && res && res[0]) addr=res[0].formatted_address||'''';'#10 +
    'crmSetHaritaPick(lat,lng,addr);});'#10 +
    '}); }'#10 +
    '</script>'#10 +
    '<script async defer src="https://maps.googleapis.com/maps/api/js?key=' + Key +
    '&callback=initMap"></script>'#10 +
    '</head><body><div id="map"></div></body></html>';

  Sl := TStringList.Create;
  try
    Sl.Text := Html;
    Sl.SaveToFile(TPath.Combine(UniServerModule.LocalCachePath, Fn), TEncoding.UTF8);
  finally
    Sl.Free;
  end;
  urlMap.URL := UniServerModule.LocalCacheURL + Fn;
end;

procedure TfrmCrmCariGps.HaritaWebKancalari;
begin
  if UniSession = nil then
    Exit;
  UniSession.AddJS(
    'try{' +
    'if(!window.__crmCariGpsPickMsg){window.__crmCariGpsPickMsg=1;' +
    'window.addEventListener("message",function(ev){try{' +
    'var d=ev.data;if(!d||!d.__crmHaritaPick)return;' +
    'var o={lat:d.lat,lng:d.lng,addr:(d.addr||"")};' +
    'sessionStorage.setItem("crmHaritaPick",JSON.stringify(o));' +
    'var btn=Ext.ComponentQuery.query("[name=btnMapPick]")[0];' +
    'if(btn){ajaxRequest(btn,"mapPick",["lat="+o.lat,"lng="+o.lng,"addr="+encodeURIComponent(o.addr||"")]);}' +
    '}catch(e){}});}' +
    '}catch(e){}');
end;

procedure TfrmCrmCariGps.HaritaSecimUygula(const ALat, ALng: Double; const AAddr: string);
begin
  edGpsEnlem.Text := DecimalToText(ALat);
  edGpsBoylam.Text := DecimalToText(ALng);
  if Trim(AAddr) <> '' then
    mmHaritaAdres.Text := AAddr;
end;

procedure TfrmCrmCariGps.btnMapPickAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
var
  LatS, LngS, Addr: string;
  FS: TFormatSettings;
  Lat, Lng: Double;
begin
  if not SameText(EventName, 'mapPick') then
    Exit;
  LatS := ParamsStr(Params, 'lat');
  LngS := ParamsStr(Params, 'lng');
  Addr := ParamsStr(Params, 'addr');
  Addr := TNetEncoding.URL.Decode(Addr);
  FS := TFormatSettings.Invariant;
  FS.DecimalSeparator := '.';
  Lat := 0;
  Lng := 0;
  if not TryStrToFloat(Trim(LatS), Lat, FS) then
    Lat := 0;
  if not TryStrToFloat(Trim(LngS), Lng, FS) then
    Lng := 0;
  HaritaSecimUygula(Lat, Lng, Addr);
end;

procedure TfrmCrmCariGps.UniFormCreate(Sender: TObject);
begin
  Align := alClient;
end;

procedure TfrmCrmCariGps.YukleKayit;
var
  Ge, Gb: Double;
begin
  qLoad.Close;
  qLoad.SQL.Text :=
    'SELECT C.CARI_KOD, C.CARI_ISIM, T.KULL1N, T.KULL2N ' +
    'FROM TBLCASABIT C WITH(NOLOCK) ' +
    'LEFT JOIN TBLCASABITEK T WITH(NOLOCK) ON T.CARI_KOD = C.CARI_KOD ' +
    'WHERE C.CARI_KOD = :K';
  qLoad.ParamByName('K').AsString := FCariKod;
  qLoad.Open;
  if qLoad.IsEmpty then
  begin
    UniMainModule.saHata.Show('Cari bulunamad'#305': ' + FCariKod);
    Exit;
  end;

  edCariKod.Text := Trim(qLoad.FieldByName('CARI_KOD').AsString);
  edCariIsim.Text := Trim(qLoad.FieldByName('CARI_ISIM').AsString);

  Ge := 0;
  Gb := 0;
  if (qLoad.FindField('KULL1N') <> nil) and not qLoad.FieldByName('KULL1N').IsNull then
    Ge := qLoad.FieldByName('KULL1N').AsFloat;
  if (qLoad.FindField('KULL2N') <> nil) and not qLoad.FieldByName('KULL2N').IsNull then
    Gb := qLoad.FieldByName('KULL2N').AsFloat;

  edGpsEnlem.Text := DecimalToText(Ge);
  edGpsBoylam.Text := DecimalToText(Gb);
  mmHaritaAdres.Clear;

  Caption := 'Netsis Cari GPS - ' + edCariKod.Text;
  qLoad.Close;

  HaritaWebKancalari;
  MapHtmlGoster;
end;

procedure TfrmCrmCariGps.UniFormShow(Sender: TObject);
begin
  Align := alClient;
  FCariKod := Trim(Hint);
  if FCariKod = '' then
  begin
    UniMainModule.saHata.Show('Cari kodu belirtilmedi.');
    Exit;
  end;
  edCariKod.ReadOnly := True;
  edCariIsim.ReadOnly := True;
  YukleKayit;
end;

procedure TfrmCrmCariGps.btnHaritaYenileClick(Sender: TObject);
begin
  MapHtmlGoster;
end;

procedure TfrmCrmCariGps.btnHaritaKonumClick(Sender: TObject);
begin
  with frmCrmHaritaSec do
  begin
    MerkezAyarla(ParseDecimal(edGpsEnlem.Text), ParseDecimal(edGpsBoylam.Text));
    HedefEnlemEdit := edGpsEnlem;
    HedefBoylamEdit := edGpsBoylam;
    HedefHaritaAdresMemo := mmHaritaAdres;
    if ShowModal = mrOK then
      MapHtmlGoster;
  end;
end;

procedure TfrmCrmCariGps.btnKaydetClick(Sender: TObject);
var
  Ge, Gb: Double;
  N: Integer;
begin
  if Trim(FCariKod) = '' then
    Exit;

  Ge := ParseDecimal(edGpsEnlem.Text);
  Gb := ParseDecimal(edGpsBoylam.Text);

  qExec.Close;
  qExec.SQL.Text :=
    'UPDATE TBLCASABITEK SET KULL1N = :K1, KULL2N = :K2 WHERE CARI_KOD = :K';
  qExec.ParamByName('K').AsString := FCariKod;
  DecimalToParam(qExec, 'K1', Ge);
  DecimalToParam(qExec, 'K2', Gb);
  qExec.Execute;
  N := qExec.RowsAffected;

  if N = 0 then
  begin
    qExec.Close;
    qExec.SQL.Text :=
      'INSERT INTO TBLCASABITEK (CARI_KOD, KULL1N, KULL2N) VALUES (:K, :K1, :K2)';
    qExec.ParamByName('K').AsString := FCariKod;
    DecimalToParam(qExec, 'K1', Ge);
    DecimalToParam(qExec, 'K2', Gb);
    try
      qExec.Execute;
    except
      on E: Exception do
      begin
        UniMainModule.saHata.Show(
          'TBLCASABITEK g'#252'ncellenemedi. Cari i'#231'in Netsis ek kart kayd'#305' olmayabilir.'#13#10 + E.Message);
        Exit;
      end;
    end;
  end;

  UniMainModule.saKaydet.Show('GPS koordinatlar'#305' kaydedildi.');
  MapHtmlGoster;
end;

procedure TfrmCrmCariGps.btnKapatClick(Sender: TObject);
begin
  MainForm.NavPage.ActivePage.Close;
end;

end.
