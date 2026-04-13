unit CrmHaritaSecU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniMemo, uniButton, uniURLFrame,
  uniBasicGrid, uniDBGrid, Data.DB, MemDS, DBAccess, Uni;

type
  TfrmCrmHaritaSec = class(TUniForm)
    rootPanel: TUniPanel;
    urlMap: TUniURLFrame;
    panBottom: TUniPanel;
    lblLat: TUniLabel;
    edLat: TUniEdit;
    lblLng: TUniLabel;
    edLng: TUniEdit;
    lblAdr: TUniLabel;
    mmAdr: TUniMemo;
    btnYansit: TUniButton;
    btnTamam: TUniButton;
    btnIptal: TUniButton;
    grdPick: TUniDBGrid;
    qPick: TUniQuery;
    dsPick: TUniDataSource;
    procedure UniFormShow(Sender: TObject);
    procedure btnTamamClick(Sender: TObject);
    procedure btnIptalClick(Sender: TObject);
    procedure grdPickAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
  private
    FInitLat: Double;
    FInitLng: Double;
    procedure MapHtmlUretVeGoster;
    function ParamsStr(const Params: TUniStrings; const Key: string): string;
  public
    { Secim sonrasi doldurulacak kontroller (opsiyonel). }
    HedefEnlemEdit: TUniEdit;
    HedefBoylamEdit: TUniEdit;
    HedefHaritaAdresMemo: TUniMemo;
    procedure MerkezAyarla(ALat, ALng: Double);
  end;

function frmCrmHaritaSec: TfrmCrmHaritaSec;

implementation

{$R *.dfm}

uses
  System.IOUtils, System.StrUtils, System.NetEncoding,
  ServerModule,
  CrmMapsConfigU,
  Main, MainModule;

{ Tarayici JS: CrmHaritaSecU.dfm icinde frmCrmHaritaSec.ClientEvents (afterScript)
  ve btnYansit.ClientEvents (click). UniGUI, ClientEvents.UniEvents.Text ile
  kodda atama yapildiginda JS'i virgune gore bolerek bozuyor; bu yuzden dfm kullanilir. }

function frmCrmHaritaSec: TfrmCrmHaritaSec;
begin
  Result := TfrmCrmHaritaSec(UniMainModule.GetFormInstance(TfrmCrmHaritaSec));
end;

procedure TfrmCrmHaritaSec.MerkezAyarla(ALat, ALng: Double);
begin
  FInitLat := ALat;
  FInitLng := ALng;
end;

function TfrmCrmHaritaSec.ParamsStr(const Params: TUniStrings; const Key: string): string;
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

procedure TfrmCrmHaritaSec.MapHtmlUretVeGoster;
var
  Sl: TStringList;
  Fn: string;
  Html, Key: string;
  FS: TFormatSettings;
begin
  Key := Trim(CrmGoogleMapsBrowserApiKey);
  if (Key = '') or SameText(Key, 'YOUR_BROWSER_KEY_HERE') then
  begin
    UniMainModule.saHata.Show(
      'Google Maps API anahtari CrmMapsConfigU biriminde tanimli degil. Anahtari ekleyip uygulamayi yeniden derleyin.');
    Exit;
  end;

  FS := TFormatSettings.Invariant;
  Fn := 'crm_map_' + IntToStr(GetTickCount) + '_' + IntToStr(Random(99999)) + '.html';

  Html :=
    '<!DOCTYPE html><html><head><meta charset="utf-8"/>'#10 +
    '<style>html,body,' + '#map' + '{height:100%;margin:0}</style>'#10 +
    '<script>'#10 +
    'function crmSetHaritaPick(lat,lng,addr){'#10 +
    'var o={lat:lat,lng:lng,addr:(addr||'''')};'#10 +
    'var s=JSON.stringify(o);'#10 +
    '{ try{ if(window.parent&&window.parent!==window) window.parent.sessionStorage.setItem(''crmHaritaPick'',s);}catch(e){} }'#10 +
    'try{ sessionStorage.setItem(''crmHaritaPick'',s);}catch(e){}'#10 +
    '}'#10 +
    'function initMap(){'#10 +
    'var c={lat:' + FormatFloat('0.######', FInitLat, FS) + ',lng:' + FormatFloat('0.######', FInitLng, FS) + '};'#10 +
    'var map=new google.maps.Map(document.getElementById(''map''),{zoom:8,center:c});'#10 +
    'var mk=null;var geocoder=new google.maps.Geocoder();'#10 +
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

procedure TfrmCrmHaritaSec.UniFormShow(Sender: TObject);
begin
  if FInitLat = 0 then
    FInitLat := 41.015;
  if FInitLng = 0 then
    FInitLng := 28.979;
  edLat.Text := '';
  edLng.Text := '';
  mmAdr.Clear;
  qPick.Close;
  qPick.SQL.Text := 'SELECT CAST(1 AS INT) AS KOD WHERE 0 = 1';
  qPick.Open;
  MapHtmlUretVeGoster;
end;

{ btnYansit tarayicida cBtnYansitClick ile ajaxRequest cagirir; burada karsilanir. }
procedure TfrmCrmHaritaSec.grdPickAjaxEvent(Sender: TComponent; EventName: string;
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
  edLat.Text := FormatFloat('0.######', Lat, FS);
  edLng.Text := FormatFloat('0.######', Lng, FS);
  mmAdr.Text := Addr;
end;

procedure TfrmCrmHaritaSec.btnTamamClick(Sender: TObject);
begin
  if Assigned(HedefEnlemEdit) then
    HedefEnlemEdit.Text := Trim(edLat.Text);
  if Assigned(HedefBoylamEdit) then
    HedefBoylamEdit.Text := Trim(edLng.Text);
  if Assigned(HedefHaritaAdresMemo) then
    HedefHaritaAdresMemo.Text := Trim(mmAdr.Text);
  HedefEnlemEdit := nil;
  HedefBoylamEdit := nil;
  HedefHaritaAdresMemo := nil;
  Close;
end;

procedure TfrmCrmHaritaSec.btnIptalClick(Sender: TObject);
begin
  HedefEnlemEdit := nil;
  HedefBoylamEdit := nil;
  HedefHaritaAdresMemo := nil;
  Close;
end;

end.
