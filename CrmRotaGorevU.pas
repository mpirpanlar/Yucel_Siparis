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
    DurakDakika: Integer;
  end;

function CrmAktiviteDurumIdByKod(AConn: TUniConnection; const AKod: string): Int64;
procedure CrmGorevIptalById(AQ: TUniQuery; AGorevId: Int64);
procedure CrmRotaGorevleriniIptal(AQ: TUniQuery; ARotaId: Int64; AClearDurakLink: Boolean);
function CrmRotaGorevAyarOku(AConn: TUniConnection; ASubeKodu: Integer): TRotaGorevAyar;
function CrmRotaGorevZamanHesapla(const AAyar: TRotaGorevAyar; APlanTarihi: TDateTime;
  ADurakSira: Integer): TDateTime;
function CrmRotaPersonelAtananId(const APersonelIds: array of Integer; ADurakSira: Integer): Integer;
function CrmRotaGorevBitisTarihi(AAktiviteTarihi: TDateTime): TDateTime;

implementation

uses
  DateUtils;

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
  Result.ZamanMod := ROTA_GOREV_ZAMAN_GUN;
  Result.BasSaat := '09:00';
  Result.DurakDakika := 45;
  if (AConn = nil) or not AConn.Connected then
    Exit;
  Q := TUniQuery.Create(nil);
  try
    Q.Connection := AConn;
    Q.SQL.Text :=
      'SELECT ROTA_ONAYDA_GOREV_OTO, ROTA_GOREV_ZAMAN_MOD, ROTA_GOREV_BAS_SAAT, ROTA_GOREV_DURAK_DK ' +
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
    if (Q.FindField('ROTA_GOREV_DURAK_DK') <> nil) and not Q.FieldByName('ROTA_GOREV_DURAK_DK').IsNull then
      Result.DurakDakika := Q.FieldByName('ROTA_GOREV_DURAK_DK').AsInteger;
    Q.Close;
    if Result.DurakDakika <= 0 then
      Result.DurakDakika := 45;
    if Result.BasSaat = '' then
      Result.BasSaat := '09:00';
    if (Result.OnayGorevOto < ROTA_GOREV_OTO_KAPALI) or (Result.OnayGorevOto > ROTA_GOREV_OTO_HER) then
      Result.OnayGorevOto := ROTA_GOREV_OTO_SOR;
  finally
    Q.Free;
  end;
end;

function CrmSaatDakikaParse(const ASaat: string; out ASa, ADk: Integer): Boolean;
var
  T, P: string;
begin
  Result := False;
  ASa := 9;
  ADk := 0;
  T := Trim(StringReplace(ASaat, '.', ':', [rfReplaceAll]));
  P := T;
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

function CrmRotaGorevZamanHesapla(const AAyar: TRotaGorevAyar; APlanTarihi: TDateTime;
  ADurakSira: Integer): TDateTime;
var
  Sa, Dk, TopDk, Sira: Integer;
begin
  Result := DateOf(APlanTarihi);
  if AAyar.ZamanMod <> ROTA_GOREV_ZAMAN_GUN_SAAT then
    Exit;
  CrmSaatDakikaParse(AAyar.BasSaat, Sa, Dk);
  Sira := ADurakSira;
  if Sira < 1 then
    Sira := 1;
  TopDk := (Sira - 1) * AAyar.DurakDakika;
  Result := IncMinute(EncodeTime(Sa, Dk, 0, 0), TopDk);
  Result := DateOf(APlanTarihi) + (Result - DateOf(Result));
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

function CrmRotaGorevBitisTarihi(AAktiviteTarihi: TDateTime): TDateTime;
begin
  Result := DateOf(AAktiviteTarihi) + 7;
end;

end.
