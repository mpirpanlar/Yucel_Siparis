unit CrmTakvimU;

{ CRM Aktivite / Gorev takvimi: FullCalendar (TUniURLFrame) + filtreler. }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniButton, uniURLFrame, uniCheckBox, uniComboBox, Data.DB, MemDS,
  DBAccess, Uni, uniMultiItem;

type
  TfrmCrmTakvim = class(TUniForm)
    rootPanel: TUniPanel;
    panTop: TUniPanel;
    lblKaynak: TUniLabel;
    chkAktivite: TUniCheckBox;
    chkGorev: TUniCheckBox;
    lblPersonel: TUniLabel;
    cbPersonel: TUniComboBox;
    chkTamamlanan: TUniCheckBox;
    btnYenile: TUniButton;
    btnKapat: TUniButton;
    urlCal: TUniURLFrame;
    btnCalHook: TUniButton;
    qEvt: TUniQuery;
    procedure UniFormShow(Sender: TObject);
    procedure btnYenileClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure btnCalHookAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure FiltreDegisti(Sender: TObject);
  private
    FRangeBas: TDateTime;
    FRangeBit: TDateTime;
    procedure TakvimHtmlGoster;
    procedure TakvimWebKancalari;
    procedure PersonelComboYukle;
    function ParamsStr(const Params: TUniStrings; const Key: string): string;
    function ParseIsoDatePrefix(const S: string; out ADt: TDateTime): Boolean;
    function JsonEscape(const S: string): string;
    function EtkinlikRengi(const AKaynak, ATip, ADurum: string; ATamamlandi: Boolean): string;
    function TarihIso(const ADt: TDateTime; AAllDay: Boolean): string;
    procedure EtkinlikleriYukle;
    procedure KayitAc(const AId: Int64; const AKind: string);
  public
  end;

function frmCrmTakvim: TfrmCrmTakvim;

implementation

{$R *.dfm}

uses
  System.IOUtils, System.StrUtils, System.NetEncoding, System.DateUtils,
  ServerModule, MainModule, DMU, Main, Genel, TmpU, CrmAktiviteU, CrmGorevU,
  uniGUIApplication;

function frmCrmTakvim: TfrmCrmTakvim;
begin
  Result := TfrmCrmTakvim(UniMainModule.GetFormInstance(TfrmCrmTakvim));
end;

procedure TfrmCrmTakvim.PersonelComboYukle;
begin
  cbPersonel.Items.Clear;
  cbPersonel.Items.Add('T' + #$00FC + 'm' + #$00FC);
  cbPersonel.Items.Add('Bana atanan g' + #$00F6 + 'revler');
  cbPersonel.Items.Add('Benim olu' + #$015F + 'turduklar' + #$0131 + 'm');
  cbPersonel.ItemIndex := 0;
end;

function TfrmCrmTakvim.ParamsStr(const Params: TUniStrings; const Key: string): string;
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
end;

function TfrmCrmTakvim.ParseIsoDatePrefix(const S: string; out ADt: TDateTime): Boolean;
var
  Y, M, D: Word;
  P: string;
begin
  Result := False;
  P := Copy(S, 1, 10);
  if Length(P) < 10 then
    Exit;
  if (P[5] <> '-') or (P[8] <> '-') then
    Exit;
  Y := StrToIntDef(Copy(P, 1, 4), 0);
  M := StrToIntDef(Copy(P, 6, 2), 0);
  D := StrToIntDef(Copy(P, 9, 2), 0);
  if (Y < 1900) or (M < 1) or (M > 12) or (D < 1) or (D > 31) then
    Exit;
  try
    ADt := EncodeDate(Y, M, D);
    Result := True;
  except
    Result := False;
  end;
end;

function TfrmCrmTakvim.JsonEscape(const S: string): string;
begin
  Result := S;
  Result := StringReplace(Result, '\', '\\', [rfReplaceAll]);
  Result := StringReplace(Result, '"', '\"', [rfReplaceAll]);
  Result := StringReplace(Result, #13, '\r', [rfReplaceAll]);
  Result := StringReplace(Result, #10, '\n', [rfReplaceAll]);
end;

function TfrmCrmTakvim.TarihIso(const ADt: TDateTime; AAllDay: Boolean): string;
begin
  if AAllDay then
    Result := FormatDateTime('yyyy-mm-dd', ADt)
  else
    Result := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', ADt);
end;

function TfrmCrmTakvim.EtkinlikRengi(const AKaynak, ATip, ADurum: string; ATamamlandi: Boolean): string;
begin
  if ATamamlandi or SameText(ADurum, 'TAMAMLANDI') or SameText(ADurum, 'IPTAL') or
     SameText(ADurum, 'BITTI') then
    Exit('#9e9e9e');
  if SameText(AKaynak, 'GOREV') then
    Exit('#e65100');
  if SameText(ATip, 'MEETING') then
    Exit('#1565c0');
  if SameText(ATip, 'CALL') then
    Exit('#2e7d32');
  if SameText(ATip, 'EMAIL') then
    Exit('#6a1b9a');
  Result := '#0277bd';
end;

procedure TfrmCrmTakvim.TakvimHtmlGoster;
var
  Sl: TStringList;
  Fn, Html: string;
begin
  Fn := 'crm_cal_' + IntToStr(GetTickCount) + '_' + IntToStr(Random(99999)) + '.html';
  Html :=
    '<!DOCTYPE html><html><head><meta charset="utf-8"/>'#10 +
    '<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.min.css" rel="stylesheet"/>'#10 +
    '<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js"></script>'#10 +
    '<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/core/locales/tr.global.min.js"></script>'#10 +
    '<style>html,body,#cal{height:100%;margin:0;font-family:Segoe UI,sans-serif}</style>'#10 +
    '</head><body><div id="cal"></div>'#10 +
    '<script>'#10 +
    'var calendar;'#10 +
    'document.addEventListener("DOMContentLoaded",function(){'#10 +
    'var el=document.getElementById("cal");'#10 +
    'calendar=new FullCalendar.Calendar(el,{'#10 +
    'initialView:"dayGridMonth",locale:"tr",'#10 +
    'headerToolbar:{left:"prev,next today",center:"title",right:"dayGridMonth,timeGridWeek,timeGridDay"},'#10 +
    'height:"100%",events:[],'#10 +
    'datesSet:function(arg){try{window.parent.postMessage({__crmCalRange:1,start:arg.startStr,end:arg.endStr},"*");}catch(e){}},'#10 +
    'eventClick:function(info){try{window.parent.postMessage({__crmCalClick:1,id:info.event.id,kind:(info.event.extendedProps.kind||"")},"*");}catch(e){}}'#10 +
    '}); calendar.render();'#10 +
    'setTimeout(function(){if(window.crmCalLoadFromParent)window.crmCalLoadFromParent();},150);'#10 +
    '});'#10 +
    'window.crmCalSetEvents=function(arr){if(calendar){calendar.removeAllEvents();if(arr&&arr.length)calendar.addEventSource(arr);}};'#10 +
    'window.crmCalLoadFromParent=function(){try{var raw=window.parent.sessionStorage.getItem("crmCalEvents");if(raw)crmCalSetEvents(JSON.parse(raw));}catch(e){}};'#10 +
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

procedure TfrmCrmTakvim.TakvimWebKancalari;
begin
  if UniSession = nil then
    Exit;
  UniSession.AddJS(
    'try{' +
    'if(!window.__crmCalMsg){window.__crmCalMsg=1;' +
    'window.addEventListener("message",function(ev){try{' +
    'var d=ev.data;if(!d)return;' +
    'var btn=Ext.ComponentQuery.query("[name=btnCalHook]")[0];if(!btn)return;' +
    'if(d.__crmCalRange){ajaxRequest(btn,"calRange",["start="+encodeURIComponent(d.start||""),"end="+encodeURIComponent(d.end||"")]);return;}' +
    'if(d.__crmCalClick){ajaxRequest(btn,"calClick",["id="+encodeURIComponent(d.id||""),"kind="+encodeURIComponent(d.kind||"")]);}' +
    '}catch(e){}});}' +
    '}catch(e){}');
end;

procedure TfrmCrmTakvim.UniFormShow(Sender: TObject);
begin
  Caption := 'CRM - Takvim';
  chkAktivite.Checked := True;
  chkGorev.Checked := True;
  chkTamamlanan.Checked := False;
  PersonelComboYukle;
  FRangeBas := Trunc(StartOfTheMonth(Now));
  FRangeBit := Trunc(EndOfTheMonth(Now)) + 1;
  TakvimHtmlGoster;
  TakvimWebKancalari;
end;

procedure TfrmCrmTakvim.FiltreDegisti(Sender: TObject);
begin
  EtkinlikleriYukle;
end;

procedure TfrmCrmTakvim.btnYenileClick(Sender: TObject);
begin
  EtkinlikleriYukle;
end;

procedure TfrmCrmTakvim.btnKapatClick(Sender: TObject);
begin
  xNavListeKapat(Self);
end;

procedure TfrmCrmTakvim.btnCalHookAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
var
  S, E: string;
begin
  if SameText(EventName, 'calRange') then
  begin
    S := TNetEncoding.URL.Decode(ParamsStr(Params, 'start'));
    E := TNetEncoding.URL.Decode(ParamsStr(Params, 'end'));
    if S <> '' then
    begin
      if not ParseIsoDatePrefix(S, FRangeBas) then
        FRangeBas := Trunc(StartOfTheMonth(Now));
    end;
    if E <> '' then
    begin
      if ParseIsoDatePrefix(E, FRangeBit) then
        FRangeBit := FRangeBit + 1
      else
        FRangeBit := Trunc(EndOfTheMonth(Now)) + 1;
    end;
    EtkinlikleriYukle;
    Exit;
  end;
  if SameText(EventName, 'calClick') then
    KayitAc(StrToInt64Def(TNetEncoding.URL.Decode(ParamsStr(Params, 'id')), 0),
      TNetEncoding.URL.Decode(ParamsStr(Params, 'kind')));
end;

procedure TfrmCrmTakvim.EtkinlikleriYukle;
var
  Json, Baslik, Kaynak, Tip, Durum, Renk: string;
  Aid: Int64;
  Dt: TDateTime;
  AllDay: Boolean;
  IncAkt, IncGrv, IncTam, KulMod, KulId: Integer;
  EncJson: string;
begin
  if (FRangeBas = 0) or (FRangeBit <= FRangeBas) then
  begin
    FRangeBas := Trunc(StartOfTheMonth(Now));
    FRangeBit := Trunc(EndOfTheMonth(Now)) + 1;
  end;

  IncAkt := Ord(chkAktivite.Checked);
  IncGrv := Ord(chkGorev.Checked);
  IncTam := Ord(chkTamamlanan.Checked);
  KulMod := cbPersonel.ItemIndex;
  if KulMod < 0 then
    KulMod := 0;
  KulId := Tmp.xKullaniciID;

  Json := '[';
  qEvt.Close;
  qEvt.SQL.Text :=
    'SELECT A.AKTIVITE_ID, A.KONU, A.AKTIVITE_TARIHI AS ETKINLIK_TARIHI, ' +
    'N''AKTIVITE'' AS KAYNAK, A.TIP, A.DURUM, CAST(0 AS BIT) AS TAMAMLANDI ' +
    'FROM dbo.CRM_AKTIVITE A ' +
    'WHERE A.TIP <> ''TASK'' AND A.AKTIVITE_TARIHI >= :BAS AND A.AKTIVITE_TARIHI < :BIT ' +
    'AND (:IA = 1) ' +
    'AND ((:KM <> 1) OR (A.OLUSTURAN_KULLANICI_ID = :KUL)) ' +
    'AND ((:KM <> 2) OR (A.OLUSTURAN_KULLANICI_ID = :KUL)) ' +
    'AND ((:IT = 1) OR (A.DURUM NOT IN (''TAMAMLANDI'',''IPTAL'',''BITTI''))) ' +
    'UNION ALL ' +
    'SELECT A.AKTIVITE_ID, A.KONU, A.AKTIVITE_TARIHI AS ETKINLIK_TARIHI, N''GOREV'', N''TASK'', A.DURUM, G.TAMAMLANDI ' +
    'FROM dbo.CRM_GOREV G ' +
    'INNER JOIN dbo.CRM_AKTIVITE A ON A.AKTIVITE_ID = G.AKTIVITE_ID ' +
    'WHERE A.AKTIVITE_TARIHI IS NOT NULL AND A.AKTIVITE_TARIHI >= :BAS AND A.AKTIVITE_TARIHI < :BIT ' +
    'AND (:IG = 1) ' +
    'AND ((:KM <> 1) OR (G.ATANAN_KULLANICI_ID = :KUL)) ' +
    'AND ((:KM <> 2) OR (A.OLUSTURAN_KULLANICI_ID = :KUL OR G.ATANAN_KULLANICI_ID = :KUL)) ' +
    'AND ((:IT = 1) OR (G.TAMAMLANDI = 0 AND A.DURUM NOT IN (''TAMAMLANDI'',''IPTAL'',''BITTI''))) ' +
    'ORDER BY ETKINLIK_TARIHI';
  qEvt.ParamByName('BAS').AsDateTime := FRangeBas;
  qEvt.ParamByName('BIT').AsDateTime := FRangeBit;
  qEvt.ParamByName('IA').AsInteger := IncAkt;
  qEvt.ParamByName('IG').AsInteger := IncGrv;
  qEvt.ParamByName('IT').AsInteger := IncTam;
  qEvt.ParamByName('KM').AsInteger := KulMod;
  qEvt.ParamByName('KUL').AsInteger := KulId;
  qEvt.Open;

  while not qEvt.Eof do
  begin
    Aid := qEvt.FieldByName('AKTIVITE_ID').AsLargeInt;
    Baslik := Trim(qEvt.FieldByName('KONU').AsString);
    Kaynak := qEvt.FieldByName('KAYNAK').AsString;
    Tip := qEvt.FieldByName('TIP').AsString;
    Durum := qEvt.FieldByName('DURUM').AsString;
    Dt := qEvt.FieldByName('ETKINLIK_TARIHI').AsDateTime;
    AllDay := (Dt = Trunc(Dt));
    Renk := EtkinlikRengi(Kaynak, Tip, Durum, qEvt.FieldByName('TAMAMLANDI').AsBoolean);

    if Json <> '[' then
      Json := Json + ',';
    if SameText(Kaynak, 'GOREV') then
      Baslik := '[G] ' + Baslik
    else if Tip <> '' then
      Baslik := '[' + Tip + '] ' + Baslik;

    Json := Json + Format(
      '{"id":"%d","title":"%s","start":"%s","allDay":%s,"backgroundColor":"%s","borderColor":"%s",' +
      '"extendedProps":{"kind":"%s"}}',
      [Aid, JsonEscape(Baslik), TarihIso(Dt, AllDay),
       IfThen(AllDay, 'true', 'false'), Renk, Renk, JsonEscape(Kaynak)]);
    qEvt.Next;
  end;
  qEvt.Close;
  Json := Json + ']';

  if UniSession = nil then
    Exit;
  EncJson := TNetEncoding.URL.Encode(Json);
  UniSession.AddJS(
    'try{' +
    '(function(){var j=decodeURIComponent("' + EncJson + '");' +
    'function push(){try{' +
    'sessionStorage.setItem("crmCalEvents",j);' +
    'var cmp=Ext.ComponentQuery.query("[name=urlCal]")[0];' +
    'if(cmp&&cmp.getFrame()&&cmp.getFrame().contentWindow&&cmp.getFrame().contentWindow.crmCalSetEvents){' +
    'cmp.getFrame().contentWindow.crmCalSetEvents(JSON.parse(j));return true;}' +
    '}catch(e){}return false;}' +
    'if(!push())Ext.defer(push,400);})();' +
    '}catch(e){}');
end;

procedure TfrmCrmTakvim.KayitAc(const AId: Int64; const AKind: string);
begin
  if AId <= 0 then
    Exit;
  if SameText(AKind, 'GOREV') then
    xFormShow(TfrmCrmGorev, 'CrmYeniGorev', 1, IntToStr(AId))
  else
    xFormShow(TfrmCrmAktivite, 'CrmYeniAktivite', 1, IntToStr(AId));
end;

end.
