unit CrmRotaMesafeU;

{ Google Directions API ile yol mesafesi (km); GPS eksik bacak secenekleri. }

interface

uses
  System.SysUtils, DBAccess, Uni;

type
  TCrmRotaNokta = record
    Lat, Lng: Double;
    Ad: string;
    function HasGps: Boolean;
  end;

  TCrmGpsEksikMod = (geSifirVeUyari, geToplamHaric);

  TCrmRotaMesafeSonuc = record
    ToplamKm: Double;
    BacakKm: TArray<Double>;
    BacakGpsEksik: TArray<Boolean>;
    Hata: string;
    function Basarili: Boolean;
  end;

function CrmRotaNoktaGecerli(const Lat, Lng: Double): Boolean;
function CrmRotaYolMesafeHesapla(const Noktalar: array of TCrmRotaNokta;
  AGpsEksikMod: TCrmGpsEksikMod): TCrmRotaMesafeSonuc;
function CrmRotaMesafeDbHesaplaKaydet(AConn: TUniConnection; const ARotaId: Int64;
  AGpsEksikMod: TCrmGpsEksikMod): TCrmRotaMesafeSonuc;
procedure CrmRotaMesafeDbKaydet(AConn: TUniConnection; const ARotaId: Int64;
  const ASonuc: TCrmRotaMesafeSonuc; AGpsEksikMod: TCrmGpsEksikMod);

implementation

uses
  System.Classes, System.Math, System.Net.HttpClient, System.NetEncoding, System.JSON,
  CrmMapsConfigU, CrmRotaGeoU;

function TCrmRotaMesafeSonuc.Basarili: Boolean;
begin
  Result := Trim(Hata) = '';
end;

function TCrmRotaNokta.HasGps: Boolean;
begin
  Result := CrmRotaNoktaGecerli(Lat, Lng);
end;

function CrmRotaNoktaGecerli(const Lat, Lng: Double): Boolean;
begin
  Result := (Abs(Lat) > 1E-7) and (Abs(Lng) > 1E-7);
end;

function LatLngParam(const Lat, Lng: Double): string;
begin
  Result := Format('%.6f,%.6f', [Lat, Lng], TFormatSettings.Invariant);
end;

function JsonPairValue(AObj: TJSONObject; const AName: string): TJSONValue;
var
  P: TJSONPair;
begin
  Result := nil;
  if AObj = nil then
    Exit;
  P := AObj.Get(AName);
  if P <> nil then
    Result := P.JsonValue;
end;

function JsonStr(AObj: TJSONObject; const AName: string): string;
var
  V: TJSONValue;
begin
  Result := '';
  V := JsonPairValue(AObj, AName);
  if V <> nil then
    Result := V.Value;
end;

function ParseDirectionsLegMeters(const AJson: string; out ALegM: TArray<Integer>; out AErr: string): Boolean;
var
  Root: TJSONValue;
  Routes, Legs, Leg, Dist, DistVal: TJSONValue;
  Route0, LegObj, DistObj: TJSONObject;
  I, N: Integer;
  St: string;
begin
  Result := False;
  SetLength(ALegM, 0);
  AErr := '';
  Root := TJSONObject.ParseJSONValue(AJson);
  if Root = nil then
  begin
    AErr := 'Directions yaniti okunamadi.';
    Exit;
  end;
  try
    if not (Root is TJSONObject) then
    begin
      AErr := 'Gecersiz JSON.';
      Exit;
    end;
    St := JsonStr(TJSONObject(Root), 'status');
    if SameText(St, 'OK') then
    begin
      Routes := JsonPairValue(TJSONObject(Root), 'routes');
      if (Routes = nil) or not (Routes is TJSONArray) or (TJSONArray(Routes).Count = 0) then
      begin
        AErr := 'Rota bulunamadi.';
        Exit;
      end;
      Route0 := TJSONArray(Routes).Items[0] as TJSONObject;
      Legs := JsonPairValue(Route0, 'legs');
      if (Legs = nil) or not (Legs is TJSONArray) then
      begin
        AErr := 'Bacak bilgisi yok.';
        Exit;
      end;
      N := TJSONArray(Legs).Count;
      SetLength(ALegM, N);
      for I := 0 to N - 1 do
      begin
        Leg := TJSONArray(Legs).Items[I];
        if not (Leg is TJSONObject) then
        begin
          ALegM[I] := 0;
          Continue;
        end;
        LegObj := Leg as TJSONObject;
        Dist := JsonPairValue(LegObj, 'distance');
        if (Dist <> nil) and (Dist is TJSONObject) then
        begin
          DistObj := Dist as TJSONObject;
          DistVal := JsonPairValue(DistObj, 'value');
          if DistVal <> nil then
            ALegM[I] := StrToIntDef(DistVal.Value, 0)
          else
            ALegM[I] := 0;
        end
        else
          ALegM[I] := 0;
      end;
      Result := True;
      Exit;
    end;
    AErr := St;
    if AErr = '' then
      AErr := 'UNKNOWN';
    if AErr = 'REQUEST_DENIED' then
      AErr := AErr + ' (Directions API / anahtar kontrolu)';
  finally
    Root.Free;
  end;
end;

function FetchDirectionsLegMeters(const Origin, Dest: TCrmRotaNokta;
  const Waypoints: array of TCrmRotaNokta; out ALegM: TArray<Integer>; out AErr: string): Boolean;
var
  Http: THTTPClient;
  Resp: IHTTPResponse;
  Url, Wp, Key: string;
  I: Integer;
  SL: TStringList;
begin
  Result := False;
  SetLength(ALegM, 0);
  AErr := '';
  if not Origin.HasGps or not Dest.HasGps then
  begin
    AErr := 'Baslangic veya bitis GPS eksik.';
    Exit;
  end;
  Key := Trim(CrmGoogleMapsBrowserApiKey);
  if Key = '' then
  begin
    AErr := 'Google Maps API anahtari tanimli degil.';
    Exit;
  end;
  Url := 'https://maps.googleapis.com/maps/api/directions/json?origin=' +
    TNetEncoding.URL.Encode(LatLngParam(Origin.Lat, Origin.Lng)) +
    '&destination=' + TNetEncoding.URL.Encode(LatLngParam(Dest.Lat, Dest.Lng)) +
    '&language=tr&units=metric&key=' + Key;
  SL := TStringList.Create;
  try
    for I := 0 to High(Waypoints) do
      if Waypoints[I].HasGps then
        SL.Add(LatLngParam(Waypoints[I].Lat, Waypoints[I].Lng));
    if SL.Count > 0 then
    begin
      Wp := SL.DelimitedText;
      Wp := StringReplace(Wp, ',', '|', [rfReplaceAll]);
      Url := Url + '&waypoints=' + TNetEncoding.URL.Encode(Wp);
    end;
  finally
    SL.Free;
  end;
  Http := THTTPClient.Create;
  try
    Http.ConnectionTimeout := 15000;
    Http.ResponseTimeout := 30000;
    Resp := Http.Get(Url);
    if Resp.StatusCode <> 200 then
    begin
      AErr := Format('HTTP %d', [Resp.StatusCode]);
      Exit;
    end;
    Result := ParseDirectionsLegMeters(Resp.ContentAsString, ALegM, AErr);
  finally
    Http.Free;
  end;
end;

procedure BacakKmEkle(var ASonuc: TCrmRotaMesafeSonuc; const AKm: Double; AGpsEksik: Boolean;
  AGpsEksikMod: TCrmGpsEksikMod);
var
  N: Integer;
begin
  N := Length(ASonuc.BacakKm);
  SetLength(ASonuc.BacakKm, N + 1);
  SetLength(ASonuc.BacakGpsEksik, N + 1);
  ASonuc.BacakKm[N] := AKm;
  ASonuc.BacakGpsEksik[N] := AGpsEksik;
  if AGpsEksik then
  begin
    if AGpsEksikMod = geSifirVeUyari then
      ASonuc.ToplamKm := ASonuc.ToplamKm + 0;
  end
  else
    ASonuc.ToplamKm := ASonuc.ToplamKm + AKm;
end;

function HaversineBacakKm(const A, B: TCrmRotaNokta): Double;
begin
  Result := CrmHaversineKm(A.Lat, A.Lng, B.Lat, B.Lng);
end;

function CrmRotaYolMesafeHesapla(const Noktalar: array of TCrmRotaNokta;
  AGpsEksikMod: TCrmGpsEksikMod): TCrmRotaMesafeSonuc;
var
  N, I, SegStart, SegEnd, WpCnt, LegIdx, ChunkEnd, J: Integer;
  Origin, Dest: TCrmRotaNokta;
  Wps: array of TCrmRotaNokta;
  LegM: TArray<Integer>;
  Err: string;
  Km: Double;
  GpsOk: Boolean;
  UsedFallback: Boolean;

  procedure ApplyLegs(const AFrom, ATo: Integer; const ALegM: TArray<Integer>; var ALegIdx: Integer);
  var
    Li: Integer;
  begin
    for Li := AFrom to ATo - 1 do
    begin
      GpsOk := Noktalar[Li].HasGps and Noktalar[Li + 1].HasGps;
      if GpsOk and (ALegIdx < Length(ALegM)) then
      begin
        Km := ALegM[ALegIdx] / 1000.0;
        Inc(ALegIdx);
        BacakKmEkle(Result, Km, False, AGpsEksikMod);
      end
      else
      begin
        if GpsOk then
          Km := HaversineBacakKm(Noktalar[Li], Noktalar[Li + 1])
        else
          Km := 0;
        BacakKmEkle(Result, Km, not GpsOk, AGpsEksikMod);
      end;
    end;
  end;

  procedure ApplyHaversineFallback(const AFrom, ATo: Integer);
  var
    Li: Integer;
  begin
    for Li := AFrom to ATo - 1 do
    begin
      GpsOk := Noktalar[Li].HasGps and Noktalar[Li + 1].HasGps;
      if GpsOk then
        Km := HaversineBacakKm(Noktalar[Li], Noktalar[Li + 1])
      else
        Km := 0;
      BacakKmEkle(Result, Km, not GpsOk, AGpsEksikMod);
    end;
  end;

begin
  Result.ToplamKm := 0;
  Result.Hata := '';
  SetLength(Result.BacakKm, 0);
  SetLength(Result.BacakGpsEksik, 0);
  N := Length(Noktalar);
  if N < 2 then
  begin
    Result.Hata := 'En az iki nokta gerekli.';
    Exit;
  end;
  UsedFallback := False;
  SegStart := 0;
  while SegStart < N - 1 do
  begin
    if not Noktalar[SegStart].HasGps then
    begin
      BacakKmEkle(Result, 0, True, AGpsEksikMod);
      Inc(SegStart);
      Continue;
    end;
    SegEnd := SegStart + 1;
    while (SegEnd < N) and not Noktalar[SegEnd].HasGps do
    begin
      BacakKmEkle(Result, 0, True, AGpsEksikMod);
      Inc(SegEnd);
    end;
    if SegEnd >= N then
      Break;
    Origin := Noktalar[SegStart];
    ChunkEnd := SegEnd;
    if (SegEnd - SegStart) > 24 then
      ChunkEnd := SegStart + 24;
    Dest := Noktalar[ChunkEnd];
    WpCnt := ChunkEnd - SegStart - 1;
    SetLength(Wps, WpCnt);
    for J := 0 to WpCnt - 1 do
      Wps[J] := Noktalar[SegStart + 1 + J];
    if FetchDirectionsLegMeters(Origin, Dest, Wps, LegM, Err) then
    begin
      LegIdx := 0;
      ApplyLegs(SegStart, ChunkEnd, LegM, LegIdx);
    end
    else
    begin
      UsedFallback := True;
      ApplyHaversineFallback(SegStart, ChunkEnd);
      if Result.Hata = '' then
        Result.Hata := 'Directions: ' + Err + ' (kuus uçusu yedek)';
    end;
    SegStart := ChunkEnd;
  end;
  if UsedFallback and (Result.ToplamKm > 0) then
    { uyari zaten Hata alaninda };
end;

procedure CrmRotaMesafeDbKaydet(AConn: TUniConnection; const ARotaId: Int64;
  const ASonuc: TCrmRotaMesafeSonuc; AGpsEksikMod: TCrmGpsEksikMod);
var
  Q, Qu: TUniQuery;
  I: Integer;
  DurakIds: TArray<Int64>;
begin
  if ARotaId <= 0 then
    Exit;
  Q := TUniQuery.Create(nil);
  Qu := TUniQuery.Create(nil);
  try
    Q.Connection := AConn;
    Qu.Connection := AConn;
    Qu.SQL.Text :=
      'UPDATE dbo.CRM_ROTA_PLAN SET TOPLAM_YOL_KM = :TK, MESAFE_HESAP_UTC = SYSUTCDATETIME(), ' +
      'GPS_EKSIK_MOD = :MOD WHERE ROTA_ID = :R';
    Qu.ParamByName('TK').AsFloat := ASonuc.ToplamKm;
    Qu.ParamByName('MOD').AsInteger := Ord(AGpsEksikMod);
    Qu.ParamByName('R').AsLargeInt := ARotaId;
    Qu.Execute;
    Q.SQL.Text :=
      'SELECT DURAK_ID FROM dbo.CRM_ROTA_PLAN_DURAK WHERE ROTA_ID = :R ORDER BY SIRA, DURAK_ID';
    Q.ParamByName('R').AsLargeInt := ARotaId;
    Q.Open;
    SetLength(DurakIds, Q.RecordCount);
    I := 0;
    while not Q.Eof do
    begin
      DurakIds[I] := Q.FieldByName('DURAK_ID').AsLargeInt;
      Inc(I);
      Q.Next;
    end;
    Q.Close;
    for I := 0 to High(DurakIds) do
    begin
      Qu.Close;
      Qu.SQL.Text :=
        'UPDATE dbo.CRM_ROTA_PLAN_DURAK SET BACAK_KM = :BK, GPS_EKSIK = :GE WHERE DURAK_ID = :D';
      if I < Length(ASonuc.BacakKm) then
        Qu.ParamByName('BK').AsFloat := ASonuc.BacakKm[I]
      else
        Qu.ParamByName('BK').Clear;
      if (I < Length(ASonuc.BacakGpsEksik)) and ASonuc.BacakGpsEksik[I] then
        Qu.ParamByName('GE').AsInteger := 1
      else
        Qu.ParamByName('GE').AsInteger := 0;
      Qu.ParamByName('D').AsLargeInt := DurakIds[I];
      Qu.Execute;
    end;
  finally
    Qu.Free;
    Q.Free;
  end;
end;

function CrmRotaMesafeDbHesaplaKaydet(AConn: TUniConnection; const ARotaId: Int64;
  AGpsEksikMod: TCrmGpsEksikMod): TCrmRotaMesafeSonuc;
var
  Q, Qd: TUniQuery;
  Noktalar: TArray<TCrmRotaNokta>;
  BasLa, BasLn, BitLa, BitLn: Double;
  HasBit: Boolean;
  Tam: TCrmRotaMesafeSonuc;
  DurakCnt, I, Idx: Integer;
  DurakIds: TArray<Int64>;
begin
  Result.ToplamKm := 0;
  Result.Hata := 'Rota bulunamadi.';
  SetLength(Result.BacakKm, 0);
  SetLength(Result.BacakGpsEksik, 0);
  if ARotaId <= 0 then
    Exit;
  Q := TUniQuery.Create(nil);
  Qd := TUniQuery.Create(nil);
  try
    Q.Connection := AConn;
    Qd.Connection := AConn;
    Q.SQL.Text :=
      'SELECT BASLANGIC_ENLEM, BASLANGIC_BOYLAM, BITIS_ENLEM, BITIS_BOYLAM FROM dbo.CRM_ROTA_PLAN WHERE ROTA_ID = :R';
    Q.ParamByName('R').AsLargeInt := ARotaId;
    Q.Open;
    if Q.IsEmpty then
      Exit;
    BasLa := Q.FieldByName('BASLANGIC_ENLEM').AsFloat;
    BasLn := Q.FieldByName('BASLANGIC_BOYLAM').AsFloat;
    BitLa := Q.FieldByName('BITIS_ENLEM').AsFloat;
    BitLn := Q.FieldByName('BITIS_BOYLAM').AsFloat;
    HasBit := CrmRotaNoktaGecerli(BitLa, BitLn);
    Q.Close;
    Qd.SQL.Text :=
      'SELECT DURAK_ID, GPS_ENLEM, GPS_BOYLAM, UNVAN_SNAPSHOT FROM dbo.CRM_ROTA_PLAN_DURAK ' +
      'WHERE ROTA_ID = :R ORDER BY SIRA, DURAK_ID';
    Qd.ParamByName('R').AsLargeInt := ARotaId;
    Qd.Open;
    DurakCnt := Qd.RecordCount;
    SetLength(DurakIds, DurakCnt);
    SetLength(Noktalar, 1 + DurakCnt + Ord(HasBit));
    Idx := 0;
    Noktalar[Idx].Lat := BasLa;
    Noktalar[Idx].Lng := BasLn;
    Noktalar[Idx].Ad := 'Baslangic';
    Inc(Idx);
    I := 0;
    while not Qd.Eof do
    begin
      DurakIds[I] := Qd.FieldByName('DURAK_ID').AsLargeInt;
      Noktalar[Idx].Lat := Qd.FieldByName('GPS_ENLEM').AsFloat;
      Noktalar[Idx].Lng := Qd.FieldByName('GPS_BOYLAM').AsFloat;
      Noktalar[Idx].Ad := Qd.FieldByName('UNVAN_SNAPSHOT').AsString;
      Inc(Idx);
      Inc(I);
      Qd.Next;
    end;
    if HasBit then
    begin
      Noktalar[Idx].Lat := BitLa;
      Noktalar[Idx].Lng := BitLn;
      Noktalar[Idx].Ad := 'Bitis';
    end;
    Tam := CrmRotaYolMesafeHesapla(Noktalar, AGpsEksikMod);
    Result := Tam;
    SetLength(Result.BacakKm, DurakCnt);
    SetLength(Result.BacakGpsEksik, DurakCnt);
    for I := 0 to DurakCnt - 1 do
    begin
      if I < Length(Tam.BacakKm) then
      begin
        Result.BacakKm[I] := Tam.BacakKm[I];
        Result.BacakGpsEksik[I] := Tam.BacakGpsEksik[I];
      end;
    end;
    Result.ToplamKm := Tam.ToplamKm;
    Result.Hata := Tam.Hata;
    CrmRotaMesafeDbKaydet(AConn, ARotaId, Result, AGpsEksikMod);
  finally
    Qd.Free;
    Q.Free;
  end;
end;

end.
