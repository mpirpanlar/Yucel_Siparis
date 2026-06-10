unit CrmBaglantiDurumU;

{ CRM aktivite/gorev: teklif/siparis baglantisi ve olay bazli durum kurallari (A/B/C). }

interface

uses
  SysUtils, DBAccess, Uni;

const
  CRM_KAYNAK_TEKLIF     = 'TEKLIF_BAGLANDI';
  CRM_KAYNAK_SIPARIS    = 'SIPARIS_BAGLANDI';
  CRM_KAYNAK_GOREV_TAM  = 'GOREV_TAMAMLANDI';
  CRM_KAYNAK_KAPANIS    = 'KAPANIS_DURUM';

type
  TCrmBaglantiKuralSonuc = record
    Bulundu: Boolean;
    HedefDurumId: Int64;
    HedefDurumAd: string;
    PromptKullanici: Boolean;
    SessizUygula: Boolean;
  end;

function CrmBaglantiKuralGet(AQ: TUniQuery; const AKaynakTip: string): TCrmBaglantiKuralSonuc;
function CrmDurumKapanisMi(AQ: TUniQuery; ADurumId: Int64): Boolean;
function CrmKaynakTipAciklama(const AKaynakTip: string): string;

implementation

function CrmKaynakTipAciklama(const AKaynakTip: string): string;
begin
  if SameText(AKaynakTip, CRM_KAYNAK_TEKLIF) then
    Result := 'Teklif ba'#287'land' + #305
  else if SameText(AKaynakTip, CRM_KAYNAK_SIPARIS) then
    Result := 'Sipari'#351' ba'#287'land' + #305
  else if SameText(AKaynakTip, CRM_KAYNAK_GOREV_TAM) then
    Result := 'G'#246'rev tamamland' + #305
  else if SameText(AKaynakTip, CRM_KAYNAK_KAPANIS) then
    Result := 'Kapan'#305#351' durumu'
  else
    Result := AKaynakTip;
end;

function CrmBaglantiKuralGet(AQ: TUniQuery; const AKaynakTip: string): TCrmBaglantiKuralSonuc;
begin
  FillChar(Result, SizeOf(Result), 0);
  if (AQ = nil) or (Trim(AKaynakTip) = '') then
    Exit;
  try
    AQ.Close;
    AQ.SQL.Text :=
      'SELECT TOP 1 R.HEDEF_DURUM_ID, R.PROMPT_KULLANICI, R.SESSIZ_UYGULA, ' +
      'D.KOD + N'' - '' + ISNULL(D.ACIKLAMA, N'''') AS DURUM_AD ' +
      'FROM dbo.CRM_BAGLANTI_DURUM_KURAL R ' +
      'INNER JOIN dbo.CRM_AKTIVITE_DURUM D ON D.DURUM_ID = R.HEDEF_DURUM_ID ' +
      'WHERE R.KAYNAK_TIP = :KT AND R.AKTIF = 1 ' +
      'ORDER BY R.SIRA, R.KURAL_ID';
    AQ.ParamByName('KT').AsString := UpperCase(Trim(AKaynakTip));
    AQ.Open;
    if AQ.IsEmpty then
      Exit;
    Result.Bulundu := True;
    Result.HedefDurumId := AQ.FieldByName('HEDEF_DURUM_ID').AsLargeInt;
    Result.HedefDurumAd := Trim(AQ.FieldByName('DURUM_AD').AsString);
    Result.PromptKullanici := AQ.FieldByName('PROMPT_KULLANICI').AsBoolean;
    Result.SessizUygula := AQ.FieldByName('SESSIZ_UYGULA').AsBoolean;
  except
    FillChar(Result, SizeOf(Result), 0);
  end;
  AQ.Close;
end;

function CrmDurumKapanisMi(AQ: TUniQuery; ADurumId: Int64): Boolean;
begin
  Result := False;
  if (AQ = nil) or (ADurumId <= 0) then
    Exit;
  try
    AQ.Close;
    AQ.SQL.Text :=
      'SELECT ISNULL(KAPANIS_MI, 0) AS KM FROM dbo.CRM_AKTIVITE_DURUM WHERE DURUM_ID = :D';
    AQ.ParamByName('D').AsLargeInt := ADurumId;
    AQ.Open;
    if not AQ.IsEmpty then
      Result := AQ.FieldByName('KM').AsBoolean;
  except
    Result := False;
  end;
  AQ.Close;
end;

end.
