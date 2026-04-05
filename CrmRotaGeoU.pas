unit CrmRotaGeoU;

interface

uses
  System.SysUtils, System.Math;

function CrmHaversineKm(Lat1, Lng1, Lat2, Lng2: Double): Double;
{ Buyuk daireye gore P noktasinin A-B buyuk daire hattina en yakin uzakligi (yaklasik, km). }
function CrmCrossTrackDistanceKm(LatP, LngP, LatA, LngA, LatB, LngB: Double): Double;
{ Esik asilirsa aciklayici metin; bos ise uyari yok / kontrol yapilmadi. }
function CrmRotaKoridorUyari(const UyariEsikKm: Integer;
  LatP, LngP, LatA, LngA, LatB, LngB: Double): string;

implementation

const
  EarthRadiusKm = 6371.0;

function Rad(const Deg: Double): Double;
begin
  Result := Deg * (Pi / 180);
end;

function CrmHaversineKm(Lat1, Lng1, Lat2, Lng2: Double): Double;
var
  DLa, DLo, A, C: Double;
begin
  DLa := Rad(Lat2 - Lat1);
  DLo := Rad(Lng2 - Lng1);
  A := Sin(DLa / 2) * Sin(DLa / 2) +
    Cos(Rad(Lat1)) * Cos(Rad(Lat2)) * Sin(DLo / 2) * Sin(DLo / 2);
  C := 2 * ArcTan2(Sqrt(A), Sqrt(Max(0, 1 - A)));
  Result := EarthRadiusKm * C;
end;

function CrmBearingRad(Lat1, Lng1, Lat2, Lng2: Double): Double;
var
  Y, X: Double;
begin
  Y := Sin(Rad(Lng2 - Lng1)) * Cos(Rad(Lat2));
  X := Cos(Rad(Lat1)) * Sin(Rad(Lat2)) - Sin(Rad(Lat1)) * Cos(Rad(Lat2)) * Cos(Rad(Lng2 - Lng1));
  Result := ArcTan2(Y, X);
end;

function CrmCrossTrackDistanceKm(LatP, LngP, LatA, LngA, LatB, LngB: Double): Double;
var
  D13, D12: Double;
  B13, B12: Double;
  Dx: Double;
begin
  D13 := CrmHaversineKm(LatA, LngA, LatP, LngP) / EarthRadiusKm;
  D12 := CrmHaversineKm(LatA, LngA, LatB, LngB) / EarthRadiusKm;
  if (D12 < 1E-9) or (D13 < 1E-9) then
    Exit(0);
  B13 := CrmBearingRad(LatA, LngA, LatP, LngP);
  B12 := CrmBearingRad(LatA, LngA, LatB, LngB);
  Dx := ArcSin(Sin(D13) * Sin(B13 - B12));
  Result := Abs(Dx) * EarthRadiusKm;
end;

function CrmRotaKoridorUyari(const UyariEsikKm: Integer;
  LatP, LngP, LatA, LngA, LatB, LngB: Double): string;
var
  D: Double;
begin
  Result := '';
  if UyariEsikKm <= 0 then
    Exit;
  if (LatP = 0) and (LngP = 0) then
    Exit('Konum yok (GPS). Koridor kontrolu yapilamadi.');
  if (LatA = 0) and (LngA = 0) then
    Exit('Rota baslangic ekseni tanimli degil.');
  if (LatB = 0) and (LngB = 0) then
    Exit('Rota bitis ekseni tanimli degil.');
  D := CrmCrossTrackDistanceKm(LatP, LngP, LatA, LngA, LatB, LngB);
  if D <= UyariEsikKm then
    Exit;
  Result := Format('Rota ekseninden uzak (yaklasik %.0f km; esik %d km). Isterseniz ekleyebilirsiniz.',
    [D, UyariEsikKm]);
end;

end.
