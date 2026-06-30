unit CrmRotaGorevU;

interface

uses
  SysUtils, Classes, DBAccess, Uni;

const
  ROTA_GOREV_OTO_KAPALI = 0;
  ROTA_GOREV_OTO_SOR    = 1;
  ROTA_GOREV_OTO_HER    = 2;

  ROTA_GOREV_ZAMAN_GUN      = 0;
  ROTA_GOREV_ZAMAN_GUN_SAAT = 1;

type
  TRotaGorevAyar = record
    OnayGorevOto: Integer;
    ZamanMod: Integer;
    BasSaat: string;
    BitSaat: string;
    DurakDakika: Integer;
    MesaiDakika: Integer;
    HizKmh: Integer;
    SoruSetId: Int64;
  end;

  TRotaZamanSlot = record
    Sira: Integer;
    BasZaman: TDateTime;
    BitZaman: TDateTime;
    YolDk: Integer;
    ZiyaretDk: Integer;
  end;

function CrmAktiviteDurumIdByKod(AConn: TUniConnection; const AKod: string): Int64;
procedure CrmGorevIptalById(AQ: TUniQuery; AGorevId: Int64);
procedure CrmRotaGorevleriniIptal(AQ: TUniQuery; ARotaId: Int64; AClearDurakLink: Boolean);
function CrmRotaGorevAyarOku(AConn: TUniConnection; ASubeKodu: Integer): TRotaGorevAyar;
function CrmRotaGorevAyarRotaBirlestir(const AParam: TRotaGorevAyar;
  AZiyaretDk, AHizKmh: Integer; const AMesaiBas, AMesaiBit: string): TRotaGorevAyar;
function CrmRotaGorevSoruSetIdOku(AConn: TUniConnection; ARotaId: Int64; ASubeKodu: Integer): Int64;
function CrmSaatDakikaParse(const ASaat: string; out ASa, ADk: Integer): Boolean;
function CrmMesaiDakikaHesapla(const ABasSaat, ABitSaat: string; AFallbackDk: Integer): Integer;
function CrmRotaGorevZamanHesapla(const AAyar: TRotaGorevAyar; APlanTarihi: TDateTime;
  ADurakSira: Integer): TDateTime;
function CrmRotaGorevZamanlariHesapla(const AAyar: TRotaGorevAyar; APlanTarihi: TDateTime;
  const ABacakKm: array of Double): TArray<TDateTime>;
function CrmRotaZamanSlotlariHesapla(const AAyar: TRotaGorevAyar; APlanTarihi: TDateTime;
  const ABacakKm: array of Double): TArray<TRotaZamanSlot>;
function CrmRotaPersonelAtananId(const APersonelIds: array of Integer; ADurakSira: Integer): Integer;
function CrmRotaGorevBitisTarihi(AAktiviteTarihi: TDateTime; APlanBitis: TDateTime = 0): TDateTime;
function CrmKullaniciRotaGorebilir(AQ: TUniQuery; ARotaId, AKullaniciId, AAdmin: Integer): Boolean;
function CrmKullaniciGorevGorebilir(AQ: TUniQuery; AAktiviteId, AKullaniciId, AAdmin: Integer): Boolean;

implementation

uses
  DateUtils, System.Math;

function CrmAktiviteDurumIdByKod(AConn: TUniConnection; const AKod: string): Int64;
var
  Q: TUniQuery;
begin
  Result := 0;
  if (AConn = nil) or not AConn.Connected then
    Exit;
  Q := TUniQuery.Create(nil);
  try
    Q.Connection := AConn;
    Q.SQL.Text :=
      'SELECT TOP 1 DURUM_ID FROM dbo.CRM_AKTIVITE_DURUM WHERE KOD = :K AND AKTIF = 1 ORDER BY DURUM_ID';
    Q.ParamByName('K').AsString := AKod;
    Q.Open;
    if not Q.IsEmpty then
      Result := Q.Fields[0].AsLargeInt;
    Q.Close;
  finally
    Q.Free;
  end;
end;

procedure CrmGorevIptalById(AQ: TUniQuery; AGorevId: Int64);
var
  Aid, IptalDid: Int64;
begin
  if (AQ = nil) or (AGorevId <= 0) then
    Exit;
  Aid := 0;
  AQ.Close;
  AQ.SQL.Text := 'SELECT AKTIVITE_ID FROM dbo.CRM_GOREV WHERE GOREV_ID = :G';
  AQ.ParamByName('G').AsLargeInt := AGorevId;
  AQ.Open;
  if not AQ.IsEmpty then
    Aid := AQ.Fields[0].AsLargeInt;
  AQ.Close;
  if Aid <= 0 then
    Exit;

  IptalDid := CrmAktiviteDurumIdByKod(AQ.Connection, 'IPTAL');
  AQ.Close;
  if IptalDid > 0 then
    AQ.SQL.Text :=
      'UPDATE dbo.CRM_AKTIVITE SET DURUM = ''IPTAL'', AKTIVITE_DURUM_ID = :DID, ' +
      'GUNCELLEME_UTC = SYSUTCDATETIME() WHERE AKTIVITE_ID = :A AND TIP = ''TASK'''
  else
    AQ.SQL.Text :=
      'UPDATE dbo.CRM_AKTIVITE SET DURUM = ''IPTAL'', GUNCELLEME_UTC = SYSUTCDATETIME() ' +
      'WHERE AKTIVITE_ID = :A AND TIP = ''TASK''';
  AQ.ParamByName('A').AsLargeInt := Aid;
  if IptalDid > 0 then
    AQ.ParamByName('DID').AsLargeInt := IptalDid;
  AQ.Execute;

  AQ.Close;
  AQ.SQL.Text :=
    'UPDATE dbo.CRM_GOREV SET TAMAMLANDI = 0, TAMAMLANMA_UTC = NULL WHERE GOREV_ID = :G';
  AQ.ParamByName('G').AsLargeInt := AGorevId;
  AQ.Execute;
end;

procedure CrmRotaGorevleriniIptal(AQ: TUniQuery; ARotaId: Int64; AClearDurakLink: Boolean);
var
  Gid: Int64;
begin
  if (AQ = nil) or (ARotaId <= 0) then
    Exit;
  AQ.Close;
  AQ.SQL.Text :=
    'SELECT GOREV_ID FROM dbo.CRM_ROTA_PLAN_DURAK WHERE ROTA_ID = :R AND GOREV_ID IS NOT NULL';
  AQ.ParamByName('R').AsLargeInt := ARotaId;
  AQ.Open;
  while not AQ.Eof do
  begin
    Gid := AQ.FieldByName('GOREV_ID').AsLargeInt;
    AQ.Next;
    CrmGorevIptalById(AQ, Gid);
  end;
  AQ.Close;
  if AClearDurakLink then
  begin
    AQ.SQL.Text := 'UPDATE dbo.CRM_ROTA_PLAN_DURAK SET GOREV_ID = NULL WHERE ROTA_ID = :R';
    AQ.ParamByName('R').AsLargeInt := ARotaId;
    AQ.Execute;
  end;
end;

function CrmRotaGorevAyarOku(AConn: TUniConnection; ASubeKodu: Integer): TRotaGorevAyar;
var
  Q: TUniQuery;
begin
  Result.OnayGorevOto := ROTA_GOREV_OTO_SOR;
  Result.ZamanMod := ROTA_GOREV_ZAMAN_GUN_SAAT;
  Result.BasSaat := '09:00';
  Result.BitSaat := '18:00';
  Result.DurakDakika := 45;
  Result.MesaiDakika := 480;
  Result.HizKmh := 50;
  Result.SoruSetId := 0;
  if (AConn = nil) or not AConn.Connected then
    Exit;
  Q := TUniQuery.Create(nil);
  try
    Q.Connection := AConn;
    Q.SQL.Text :=
      'SELECT ROTA_ONAYDA_GOREV_OTO, ROTA_GOREV_ZAMAN_MOD, ROTA_GOREV_BAS_SAAT, ROTA_GOREV_BIT_SAAT, ' +
      'ROTA_GOREV_DURAK_DK, ROTA_GOREV_MESAI_DK, ROTA_GOREV_HIZ_KMH, ROTA_GOREV_SORU_SET_ID ' +
      'FROM dbo.PARAMETRE WITH(NOLOCK) WHERE SUBE_KODU = :SUBE';
    Q.ParamByName('SUBE').AsInteger := ASubeKodu;
    Q.Open;
    if Q.IsEmpty then
      Exit;
    if (Q.FindField('ROTA_ONAYDA_GOREV_OTO') <> nil) and not Q.FieldByName('ROTA_ONAYDA_GOREV_OTO').IsNull then
      Result.OnayGorevOto := Q.FieldByName('ROTA_ONAYDA_GOREV_OTO').AsInteger;
    if (Q.FindField('ROTA_GOREV_ZAMAN_MOD') <> nil) and not Q.FieldByName('ROTA_GOREV_ZAMAN_MOD').IsNull then
      Result.ZamanMod := Q.FieldByName('ROTA_GOREV_ZAMAN_MOD').AsInteger;
    if (Q.FindField('ROTA_GOREV_BAS_SAAT') <> nil) and not Q.FieldByName('ROTA_GOREV_BAS_SAAT').IsNull then
      Result.BasSaat := Trim(Q.FieldByName('ROTA_GOREV_BAS_SAAT').AsString);
    if (Q.FindField('ROTA_GOREV_BIT_SAAT') <> nil) and not Q.FieldByName('ROTA_GOREV_BIT_SAAT').IsNull then
      Result.BitSaat := Trim(Q.FieldByName('ROTA_GOREV_BIT_SAAT').AsString);
    if (Q.FindField('ROTA_GOREV_DURAK_DK') <> nil) and not Q.FieldByName('ROTA_GOREV_DURAK_DK').IsNull then
      Result.DurakDakika := Q.FieldByName('ROTA_GOREV_DURAK_DK').AsInteger;
    if (Q.FindField('ROTA_GOREV_MESAI_DK') <> nil) and not Q.FieldByName('ROTA_GOREV_MESAI_DK').IsNull then
      Result.MesaiDakika := Q.FieldByName('ROTA_GOREV_MESAI_DK').AsInteger;
    if (Q.FindField('ROTA_GOREV_HIZ_KMH') <> nil) and not Q.FieldByName('ROTA_GOREV_HIZ_KMH').IsNull then
      Result.HizKmh := Q.FieldByName('ROTA_GOREV_HIZ_KMH').AsInteger;
    if (Q.FindField('ROTA_GOREV_SORU_SET_ID') <> nil) and not Q.FieldByName('ROTA_GOREV_SORU_SET_ID').IsNull then
      Result.SoruSetId := Q.FieldByName('ROTA_GOREV_SORU_SET_ID').AsLargeInt;
    Q.Close;
    if Result.DurakDakika <= 0 then
      Result.DurakDakika := 45;
    if Result.HizKmh <= 0 then
      Result.HizKmh := 50;
    if Result.BasSaat = '' then
      Result.BasSaat := '09:00';
    if Result.BitSaat = '' then
      Result.BitSaat := '18:00';
    Result.MesaiDakika := CrmMesaiDakikaHesapla(Result.BasSaat, Result.BitSaat, Result.MesaiDakika);
    if (Result.OnayGorevOto < ROTA_GOREV_OTO_KAPALI) or (Result.OnayGorevOto > ROTA_GOREV_OTO_HER) then
      Result.OnayGorevOto := ROTA_GOREV_OTO_SOR;
  finally
    Q.Free;
  end;
end;

function CrmRotaGorevAyarRotaBirlestir(const AParam: TRotaGorevAyar;
  AZiyaretDk, AHizKmh: Integer; const AMesaiBas, AMesaiBit: string): TRotaGorevAyar;
begin
  Result := AParam;
  Result.ZamanMod := ROTA_GOREV_ZAMAN_GUN_SAAT;
  if AZiyaretDk > 0 then
    Result.DurakDakika := AZiyaretDk;
  if AHizKmh > 0 then
    Result.HizKmh := AHizKmh;
  if Trim(AMesaiBas) <> '' then
    Result.BasSaat := Trim(AMesaiBas);
  if Trim(AMesaiBit) <> '' then
    Result.BitSaat := Trim(AMesaiBit);
  Result.MesaiDakika := CrmMesaiDakikaHesapla(Result.BasSaat, Result.BitSaat, Result.MesaiDakika);
end;

function CrmRotaGorevSoruSetIdOku(AConn: TUniConnection; ARotaId: Int64; ASubeKodu: Integer): Int64;
var
  Q: TUniQuery;
begin
  Result := 0;
  if (AConn = nil) or not AConn.Connected then
    Exit;
  if ARotaId > 0 then
  begin
    Q := TUniQuery.Create(nil);
    try
      Q.Connection := AConn;
      Q.SQL.Text :=
        'SELECT GOREV_SORU_SET_ID FROM dbo.CRM_ROTA_PLAN WITH(NOLOCK) WHERE ROTA_ID = :R';
      Q.ParamByName('R').AsLargeInt := ARotaId;
      Q.Open;
      if not Q.IsEmpty then
        if (Q.FindField('GOREV_SORU_SET_ID') <> nil) and not Q.FieldByName('GOREV_SORU_SET_ID').IsNull then
          Result := Q.FieldByName('GOREV_SORU_SET_ID').AsLargeInt;
      Q.Close;
    finally
      Q.Free;
    end;
  end;
  if Result > 0 then
    Exit;
  Result := CrmRotaGorevAyarOku(AConn, ASubeKodu).SoruSetId;
end;

function CrmSaatDakikaParse(const ASaat: string; out ASa, ADk: Integer): Boolean;
var
  T: string;
begin
  Result := False;
  ASa := 9;
  ADk := 0;
  T := Trim(StringReplace(ASaat, '.', ':', [rfReplaceAll]));
  if Pos(':', T) > 0 then
  begin
    ASa := StrToIntDef(Copy(T, 1, Pos(':', T) - 1), 9);
    ADk := StrToIntDef(Copy(T, Pos(':', T) + 1, MaxInt), 0);
  end
  else
    ASa := StrToIntDef(T, 9);
  if (ASa < 0) or (ASa > 23) then
    ASa := 9;
  if (ADk < 0) or (ADk > 59) then
    ADk := 0;
  Result := True;
end;

function CrmMesaiDakikaHesapla(const ABasSaat, ABitSaat: string; AFallbackDk: Integer): Integer;
var
  BasSa, BasDk, BitSa, BitDk, BasTop, BitTop: Integer;
begin
  Result := AFallbackDk;
  if (Trim(ABasSaat) = '') or (Trim(ABitSaat) = '') then
    Exit;
  CrmSaatDakikaParse(ABasSaat, BasSa, BasDk);
  CrmSaatDakikaParse(ABitSaat, BitSa, BitDk);
  BasTop := BasSa * 60 + BasDk;
  BitTop := BitSa * 60 + BitDk;
  if BitTop > BasTop then
    Result := BitTop - BasTop
  else if AFallbackDk > 0 then
    Result := AFallbackDk
  else
    Result := 480;
end;

function CrmRotaZamanSlotlariHesapla(const AAyar: TRotaGorevAyar; APlanTarihi: TDateTime;
  const ABacakKm: array of Double): TArray<TRotaZamanSlot>;
var
  I, N, Gun, Sa, Dk, TravelMin, NeedMin, UsedMin, MesaiDk: Integer;
  GunBas, PlanBas, PlanBit: TDateTime;
begin
  N := Length(ABacakKm);
  SetLength(Result, N);
  if N = 0 then
    Exit;
  MesaiDk := AAyar.MesaiDakika;
  if MesaiDk <= 0 then
    MesaiDk := CrmMesaiDakikaHesapla(AAyar.BasSaat, AAyar.BitSaat, 480);
  CrmSaatDakikaParse(AAyar.BasSaat, Sa, Dk);
  Gun := 0;
  UsedMin := 0;
  for I := 0 to N - 1 do
  begin
    if ABacakKm[I] > 0 then
      TravelMin := Round(ABacakKm[I] / Max(AAyar.HizKmh, 1) * 60)
    else
      TravelMin := 15;
    NeedMin := TravelMin + AAyar.DurakDakika;
    if (MesaiDk > 0) and (UsedMin > 0) and (UsedMin + NeedMin > MesaiDk) then
    begin
      Inc(Gun);
      UsedMin := 0;
    end;
    GunBas := DateOf(APlanTarihi) + Gun;
    PlanBas := IncMinute(GunBas + EncodeTime(Sa, Dk, 0, 0), UsedMin);
    PlanBit := IncMinute(PlanBas, AAyar.DurakDakika);
    Result[I].Sira := I + 1;
    Result[I].BasZaman := PlanBas;
    Result[I].BitZaman := PlanBit;
    Result[I].YolDk := TravelMin;
    Result[I].ZiyaretDk := AAyar.DurakDakika;
    UsedMin := UsedMin + NeedMin;
  end;
end;

function CrmRotaGorevZamanHesapla(const AAyar: TRotaGorevAyar; APlanTarihi: TDateTime;
  ADurakSira: Integer): TDateTime;
var
  Slots: TArray<TRotaZamanSlot>;
  Bacak: array of Double;
  I: Integer;
begin
  Result := DateOf(APlanTarihi);
  if AAyar.ZamanMod <> ROTA_GOREV_ZAMAN_GUN_SAAT then
    Exit;
  SetLength(Bacak, ADurakSira);
  for I := 0 to ADurakSira - 1 do
    Bacak[I] := 0;
  Slots := CrmRotaZamanSlotlariHesapla(AAyar, APlanTarihi, Bacak);
  if (ADurakSira >= 1) and (ADurakSira <= Length(Slots)) then
    Result := Slots[ADurakSira - 1].BasZaman;
end;

function CrmRotaGorevZamanlariHesapla(const AAyar: TRotaGorevAyar; APlanTarihi: TDateTime;
  const ABacakKm: array of Double): TArray<TDateTime>;
var
  Slots: TArray<TRotaZamanSlot>;
  I, N: Integer;
begin
  N := Length(ABacakKm);
  SetLength(Result, N);
  if N = 0 then
    Exit;
  if AAyar.ZamanMod <> ROTA_GOREV_ZAMAN_GUN_SAAT then
  begin
    for I := 0 to N - 1 do
      Result[I] := DateOf(APlanTarihi);
    Exit;
  end;
  Slots := CrmRotaZamanSlotlariHesapla(AAyar, APlanTarihi, ABacakKm);
  for I := 0 to N - 1 do
    Result[I] := Slots[I].BasZaman;
end;

function CrmRotaPersonelAtananId(const APersonelIds: array of Integer; ADurakSira: Integer): Integer;
var
  N, Idx: Integer;
begin
  Result := 0;
  N := Length(APersonelIds);
  if N = 0 then
    Exit;
  if ADurakSira < 1 then
    Idx := 0
  else
    Idx := (ADurakSira - 1) mod N;
  Result := APersonelIds[Idx];
end;

function CrmRotaGorevBitisTarihi(AAktiviteTarihi: TDateTime; APlanBitis: TDateTime): TDateTime;
begin
  if YearOf(APlanBitis) >= 2000 then
    Result := APlanBitis
  else if YearOf(AAktiviteTarihi) >= 2000 then
  begin
    if Frac(AAktiviteTarihi) > 0 then
      Result := IncMinute(AAktiviteTarihi, 30)
    else
      Result := DateOf(AAktiviteTarihi) + EncodeTime(17, 0, 0, 0);
  end
  else
    Result := IncMinute(Now, 30);
end;

function CrmKullaniciRotaGorebilir(AQ: TUniQuery; ARotaId, AKullaniciId, AAdmin: Integer): Boolean;
begin
  if (AAdmin = 1) or (ARotaId <= 0) then
    Exit(True);
  Result := False;
  if (AQ = nil) or (AQ.Connection = nil) or not AQ.Connection.Connected then
    Exit;
  AQ.Close;
  AQ.SQL.Text :=
    'SELECT TOP 1 1 AS OK FROM dbo.CRM_ROTA_PLAN R WHERE R.ROTA_ID = :R ' +
    'AND EXISTS (SELECT 1 FROM dbo.CRM_ROTA_PLAN_PERSONEL RP ' +
    'WHERE RP.ROTA_ID = R.ROTA_ID AND RP.KULLANICI_ID = :K)';
  AQ.ParamByName('R').AsLargeInt := ARotaId;
  AQ.ParamByName('K').AsInteger := AKullaniciId;
  AQ.Open;
  Result := not AQ.IsEmpty;
  AQ.Close;
end;

function CrmKullaniciGorevGorebilir(AQ: TUniQuery; AAktiviteId, AKullaniciId, AAdmin: Integer): Boolean;
begin
  if (AAdmin = 1) or (AAktiviteId <= 0) then
    Exit(True);
  Result := False;
  if (AQ = nil) or (AQ.Connection = nil) or not AQ.Connection.Connected then
    Exit;
  AQ.Close;
  AQ.SQL.Text :=
    'SELECT TOP 1 1 AS OK FROM dbo.CRM_GOREV G WHERE G.AKTIVITE_ID = :A AND G.ATANAN_KULLANICI_ID = :K';
  AQ.ParamByName('A').AsLargeInt := AAktiviteId;
  AQ.ParamByName('K').AsInteger := AKullaniciId;
  AQ.Open;
  Result := not AQ.IsEmpty;
  AQ.Close;
end;

end.
