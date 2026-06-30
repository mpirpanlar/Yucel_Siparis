unit CrmAktiviteLogU;

{ CRM aktivite/gorev degisiklik logu (CRM_AKTIVITE_DEGISIM_LOG). }

interface

uses
  SysUtils, DBAccess, Uni;

procedure CrmLogEkle(AQ: TUniQuery; AAktiviteId: Int64; const AKaynak, AIslem, AAlanAdi,
  AEskiDeger, AYeniDeger, AAciklama: string; AKullaniciId: Integer);

procedure CrmLogAlanDegisti(AQ: TUniQuery; AAktiviteId: Int64; const AKaynak, AIslem,
  AAlanAdi, AEskiDeger, AYeniDeger: string; AKullaniciId: Integer);

procedure CrmTarihceYukle(AQ: TUniQuery; AAktiviteId: Int64);

function CrmStrEsit(const A, B: string): Boolean;
function CrmMetinKirp(const S: string; AMax: Integer = 500): string;
function CrmTarihMetin(const ADt: TDateTime): string;
function CrmDurumMetni(AQ: TUniQuery; ADurumId: Int64): string;
function CrmKullaniciMetni(AQ: TUniQuery; AKullaniciId: Integer): string;

implementation

function CrmStrEsit(const A, B: string): Boolean;
begin
  Result := SameText(Trim(A), Trim(B));
end;

function CrmMetinKirp(const S: string; AMax: Integer): string;
begin
  Result := Trim(S);
  if Length(Result) > AMax then
    SetLength(Result, AMax);
end;

function CrmTarihMetin(const ADt: TDateTime): string;
begin
  if Trunc(ADt) <= 0 then
    Result := ''
  else if ADt = Trunc(ADt) then
    Result := FormatDateTime('dd.mm.yyyy', ADt)
  else
    Result := FormatDateTime('dd.mm.yyyy hh:nn', ADt);
end;

function CrmDurumMetni(AQ: TUniQuery; ADurumId: Int64): string;
begin
  Result := '';
  if (AQ = nil) or (ADurumId <= 0) then
    Exit;
  AQ.Close;
  AQ.SQL.Text :=
    'SELECT KOD + N'' - '' + ISNULL(ACIKLAMA, N'''') AS AD FROM dbo.CRM_AKTIVITE_DURUM WHERE DURUM_ID = :D';
  AQ.ParamByName('D').AsLargeInt := ADurumId;
  AQ.Open;
  if not AQ.IsEmpty then
    Result := Trim(AQ.FieldByName('AD').AsString);
  AQ.Close;
end;

function CrmKullaniciMetni(AQ: TUniQuery; AKullaniciId: Integer): string;
begin
  Result := '';
  if (AQ = nil) or (AKullaniciId <= 0) then
    Exit;
  AQ.Close;
  AQ.SQL.Text := 'SELECT KullaniciAd FROM dbo.Kullanici WHERE KullaniciID = :K';
  AQ.ParamByName('K').AsInteger := AKullaniciId;
  AQ.Open;
  if not AQ.IsEmpty then
    Result := Trim(AQ.FieldByName('KullaniciAd').AsString);
  AQ.Close;
end;

procedure CrmLogEkle(AQ: TUniQuery; AAktiviteId: Int64; const AKaynak, AIslem, AAlanAdi,
  AEskiDeger, AYeniDeger, AAciklama: string; AKullaniciId: Integer);
begin
  if (AQ = nil) or (AAktiviteId <= 0) then
    Exit;
  AQ.Close;
  AQ.SQL.Text :=
    'INSERT INTO dbo.CRM_AKTIVITE_DEGISIM_LOG (AKTIVITE_ID, KAYNAK, ISLEM, ALAN_ADI, ESKI_DEGER, YENI_DEGER, ACIKLAMA, KULLANICI_ID) ' +
    'VALUES (:AID, :KAY, :ISL, :ALAN, :ESK, :YEN, :ACK, :KUL)';
  AQ.ParamByName('AID').AsLargeInt := AAktiviteId;
  AQ.ParamByName('KAY').AsString := AKaynak;
  AQ.ParamByName('ISL').AsString := AIslem;
  if Trim(AAlanAdi) <> '' then
    AQ.ParamByName('ALAN').AsString := AAlanAdi
  else
    AQ.ParamByName('ALAN').Clear;
  if Trim(AEskiDeger) <> '' then
    AQ.ParamByName('ESK').AsString := CrmMetinKirp(AEskiDeger)
  else
    AQ.ParamByName('ESK').Clear;
  if Trim(AYeniDeger) <> '' then
    AQ.ParamByName('YEN').AsString := CrmMetinKirp(AYeniDeger)
  else
    AQ.ParamByName('YEN').Clear;
  if Trim(AAciklama) <> '' then
    AQ.ParamByName('ACK').AsString := CrmMetinKirp(AAciklama)
  else
    AQ.ParamByName('ACK').Clear;
  if AKullaniciId > 0 then
    AQ.ParamByName('KUL').AsInteger := AKullaniciId
  else
    AQ.ParamByName('KUL').Clear;
  AQ.Execute;
end;

procedure CrmLogAlanDegisti(AQ: TUniQuery; AAktiviteId: Int64; const AKaynak, AIslem,
  AAlanAdi, AEskiDeger, AYeniDeger: string; AKullaniciId: Integer);
begin
  if CrmStrEsit(AEskiDeger, AYeniDeger) then
    Exit;
  CrmLogEkle(AQ, AAktiviteId, AKaynak, AIslem, AAlanAdi, AEskiDeger, AYeniDeger, '', AKullaniciId);
end;

procedure CrmTarihceYukle(AQ: TUniQuery; AAktiviteId: Int64);
begin
  if AQ = nil then
    Exit;
  AQ.Close;
  if AAktiviteId <= 0 then
    Exit;
  AQ.SQL.Text :=
    'SELECT L.LOG_ID, CONVERT(varchar(19), L.ISLEM_UTC, 120) AS ISLEM_ZAMANI, ' +
    'ISNULL(K.KullaniciAd, '''') AS KULLANICI, L.KAYNAK, L.ISLEM, L.ALAN_ADI, ' +
    'L.ESKI_DEGER, L.YENI_DEGER, L.ACIKLAMA ' +
    'FROM dbo.CRM_AKTIVITE_DEGISIM_LOG L ' +
    'LEFT JOIN dbo.Kullanici K ON K.KullaniciID = L.KULLANICI_ID ' +
    'WHERE L.AKTIVITE_ID = :AID ' +
    'ORDER BY L.ISLEM_UTC DESC, L.LOG_ID DESC';
  AQ.ParamByName('AID').AsLargeInt := AAktiviteId;
  AQ.Open;
end;

end.
