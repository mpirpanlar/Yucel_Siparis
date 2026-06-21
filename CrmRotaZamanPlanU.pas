unit CrmRotaZamanPlanU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniButton, uniURLFrame;

type
  TRotaZamanOnizlemeItem = record
    Sira: Integer;
    Unvan: string;
    BasZaman: TDateTime;
    BitZaman: TDateTime;
    YolDk: Integer;
    PersonelAd: string;
  end;

  TfrmCrmRotaZamanPlan = class(TUniForm)
    rootPanel: TUniPanel;
    panTop: TUniPanel;
    lblOzet: TUniLabel;
    btnGorevOlustur: TUniButton;
    btnKapat: TUniButton;
    urlCal: TUniURLFrame;
    procedure UniFormShow(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure btnGorevOlusturClick(Sender: TObject);
  private
    FItems: TArray<TRotaZamanOnizlemeItem>;
    FOzet: string;
    procedure TakvimHtmlGoster;
    procedure EtkinlikleriGoster;
    function JsonEscape(const S: string): string;
    function TarihIso(const ADt: TDateTime): string;
    function EtkinlikRengi(ASira: Integer): string;
  public
    OnGorevOlusturOnay: TNotifyEvent;
    procedure Hazirla(const AItems: TArray<TRotaZamanOnizlemeItem>; const AOzet: string);
  end;

function frmCrmRotaZamanPlan: TfrmCrmRotaZamanPlan;

implementation

{$R *.dfm}

uses
  System.IOUtils, System.DateUtils, System.NetEncoding,
  ServerModule, MainModule, Main, Genel, uniGUIApplication;

function frmCrmRotaZamanPlan: TfrmCrmRotaZamanPlan;
begin
  Result := TfrmCrmRotaZamanPlan(UniMainModule.GetFormInstance(TfrmCrmRotaZamanPlan));
end;

function TfrmCrmRotaZamanPlan.JsonEscape(const S: string): string;
begin
  Result := S;
  Result := StringReplace(Result, '\', '\\', [rfReplaceAll]);
  Result := StringReplace(Result, '"', '\"', [rfReplaceAll]);
  Result := StringReplace(Result, #13, '\r', [rfReplaceAll]);
  Result := StringReplace(Result, #10, '\n', [rfReplaceAll]);
end;

function TfrmCrmRotaZamanPlan.TarihIso(const ADt: TDateTime): string;
begin
  Result := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', ADt);
end;

function TfrmCrmRotaZamanPlan.EtkinlikRengi(ASira: Integer): string;
const
  Renkler: array[0..7] of string = (
    '#1565c0', '#2e7d32', '#e65100', '#6a1b9a', '#00838f', '#c62828', '#4527a0', '#558b2f');
begin
  Result := Renkler[ASira mod Length(Renkler)];
end;

procedure TfrmCrmRotaZamanPlan.TakvimHtmlGoster;
var
  Sl: TStringList;
  Fn, Html, EvArr, Title, IdStr, InitialDate: string;
  I: Integer;
  It: TRotaZamanOnizlemeItem;
begin
  Fn := 'crm_rota_zaman_' + IntToStr(GetTickCount) + '_' + IntToStr(Random(99999)) + '.html';
  InitialDate := FormatDateTime('yyyy-mm-dd', Date);
  EvArr := '[';
  for I := 0 to High(FItems) do
  begin
    It := FItems[I];
    if I = 0 then
      InitialDate := FormatDateTime('yyyy-mm-dd', DateOf(It.BasZaman));
    if I > 0 then
      EvArr := EvArr + ',';
    Title := Format('%d: %s', [It.Sira, It.Unvan]);
    if Trim(It.PersonelAd) <> '' then
      Title := Title + ' (' + It.PersonelAd + ')';
    IdStr := 'rz' + IntToStr(It.Sira);
    EvArr := EvArr + Format(
      '{id:"%s",title:"%s",start:"%s",end:"%s",backgroundColor:"%s",borderColor:"%s"}',
      [IdStr, JsonEscape(Title), TarihIso(It.BasZaman), TarihIso(It.BitZaman),
       EtkinlikRengi(It.Sira), EtkinlikRengi(It.Sira)]);
  end;
  EvArr := EvArr + ']';
  Html :=
    '<!DOCTYPE html><html><head><meta charset="utf-8"/>'#10 +
    '<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.min.css" rel="stylesheet"/>'#10 +
    '<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js"></script>'#10 +
    '<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/core/locales/tr.global.min.js"></script>'#10 +
    '<style>html,body,#cal{height:100%;margin:0;font-family:Segoe UI,sans-serif}</style>'#10 +
    '</head><body><div id="cal"></div>'#10 +
    '<script>'#10 +
    'var initialEvents=' + EvArr + ';'#10 +
    'var calendar;'#10 +
    'document.addEventListener("DOMContentLoaded",function(){'#10 +
    'var el=document.getElementById("cal");'#10 +
    'calendar=new FullCalendar.Calendar(el,{'#10 +
    'initialView:"timeGridWeek",initialDate:"' + InitialDate + '",locale:"tr",'#10 +
    'headerToolbar:{left:"prev,next today",center:"title",right:"dayGridMonth,timeGridWeek,timeGridDay"},'#10 +
    'height:"100%",slotMinTime:"07:00:00",slotMaxTime:"21:00:00",events:initialEvents,'#10 +
    'eventTimeFormat:{hour:"2-digit",minute:"2-digit",hour12:false}'#10 +
    '}); calendar.render();'#10 +
    '});'#10 +
    '</script></body></html>';

  Sl := TStringList.Create;
  try
    Sl.Text := Html;
    Sl.SaveToFile(TPath.Combine(UniServerModule.LocalCachePath, Fn), TEncoding.UTF8);
  finally
    Sl.Free;
  end;
  urlCal.URL := UniServerModule.LocalCacheURL + Fn;
end;

procedure TfrmCrmRotaZamanPlan.EtkinlikleriGoster;
var
  Json, EncJson: string;
  I: Integer;
  Title, IdStr: string;
  It: TRotaZamanOnizlemeItem;
begin
  Json := '[';
  for I := 0 to High(FItems) do
  begin
    It := FItems[I];
    if I > 0 then
      Json := Json + ',';
    Title := Format('%d: %s', [It.Sira, It.Unvan]);
    if Trim(It.PersonelAd) <> '' then
      Title := Title + ' (' + It.PersonelAd + ')';
    IdStr := 'rz' + IntToStr(It.Sira);
    Json := Json + Format(
      '{"id":"%s","title":"%s","start":"%s","end":"%s","backgroundColor":"%s","borderColor":"%s"}',
      [IdStr, JsonEscape(Title), TarihIso(It.BasZaman), TarihIso(It.BitZaman),
       EtkinlikRengi(It.Sira), EtkinlikRengi(It.Sira)]);
  end;
  Json := Json + ']';
  if UniSession = nil then
    Exit;
  EncJson := TNetEncoding.URL.Encode(Json);
  UniSession.AddJS(
    'try{' +
    '(function(){var j=decodeURIComponent("' + EncJson + '");' +
    'function push(){try{' +
    'var cmp=Ext.ComponentQuery.query("[name=urlCalRotaZaman]")[0];' +
    'if(cmp&&cmp.getFrame()&&cmp.getFrame().contentWindow&&cmp.getFrame().contentWindow.calendar){' +
    'cmp.getFrame().contentWindow.calendar.removeAllEvents();' +
    'cmp.getFrame().contentWindow.calendar.addEventSource(JSON.parse(j));return true;}' +
    '}catch(e){}return false;}' +
    'if(!push())Ext.defer(push,400);})();' +
    '}catch(e){}');
end;

procedure TfrmCrmRotaZamanPlan.Hazirla(const AItems: TArray<TRotaZamanOnizlemeItem>;
  const AOzet: string);
begin
  FItems := AItems;
  FOzet := AOzet;
end;

procedure TfrmCrmRotaZamanPlan.UniFormShow(Sender: TObject);
begin
  Caption := 'CRM - Rota zaman plan'#305' '#246'nizleme';
  lblOzet.Caption := FOzet;
  TakvimHtmlGoster;
  EtkinlikleriGoster;
end;

procedure TfrmCrmRotaZamanPlan.btnGorevOlusturClick(Sender: TObject);
begin
  if Assigned(OnGorevOlusturOnay) then
    OnGorevOlusturOnay(Self);
  ModalResult := mrOk;
end;

procedure TfrmCrmRotaZamanPlan.btnKapatClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
