unit CrmAktiviteKontrolU;

{ CRM aktivite / gorev kontrol listesi (soru setleri) — ortak UI ve kayit. }

interface

uses
  SysUtils, Classes, Controls, Forms, System.Generics.Collections,
  uniGUIBaseClasses, uniGUIClasses, uniGUITypes, uniPanel, uniLabel, uniEdit, uniMemo,
  uniDateTimePicker, uniComboBox, uniCheckBox, DBAccess, Uni;

type
  TCrmSoruKontrol = class
  public
    SoruId: Int64;
    SetId: Int64;
    Tipi: string;
    Zorunlu: Boolean;
    SetZorunlu: Boolean;
    Metni: string;
    Ana: TControl;
    SecenekIds: array of Int64;
    Checkler: array of TUniCheckBox;
  end;

  TCrmAktiviteKontrolYonetici = class
  private
    FOwner: TComponent;
    FPanel: TUniPanel;
    FqKontrol: TUniQuery;
    FqSecenek: TUniQuery;
    FqCevap: TUniQuery;
    FqExec: TUniQuery;
    FKontroller: TObjectList<TCrmSoruKontrol>;
    FDinamik: TObjectList<TComponent>;
    FAktiviteId: Int64;
    FBosMesaj: string;
    FOnSekmeGoster: TNotifyEvent;
    procedure ControlsTemizle;
    procedure SoruOlustur(var AY: Integer);
    procedure CevaplariYukle;
    procedure BosMesajGoster(const AMesaj: string);
  public
    constructor Create(AOwner: TComponent; APanel: TUniPanel;
      AqKontrol, AqSecenek, AqCevap, AqExec: TUniQuery);
    destructor Destroy; override;
    procedure Yukle(AktiviteTipId: Int64; AktiviteId: Int64; const ABosMesaj: string = '');
    procedure YukleSet(ASetId: Int64; AktiviteId: Int64; const ABosMesaj: string = '');
    procedure Temizle;
    function Dogrula: Boolean;
    procedure CevaplariKaydet(AktiviteId: Int64);
    property OnSekmeGoster: TNotifyEvent read FOnSekmeGoster write FOnSekmeGoster;
  end;

function CrmKontrolTamamlamaGerekli(AQ: TUniQuery; ADurumId: Int64; const ADurumKod: string;
  AGorevModu: Boolean): Boolean;
procedure CrmDateTimePickerFormat(ADt: TUniDateTimePicker);

implementation

uses
  Graphics, System.Math, TmpU, MainModule, CrmBaglantiDurumU;

const
  CRM_KONTROL_KENAR = 16;
  CRM_KONTROL_GIRIS = 24;
  CRM_KONTROL_GENISLIK = 580;
  CRM_KONTROL_ETIKET_GEN = 580;
  CRM_KONTROL_ETIKET_MIN = 22;
  CRM_KONTROL_ARALIK = 12;
  CRM_KONTROL_MEMO_YUK = 72;
  CRM_KONTROL_CHK_YUK = 26;

function CrmSoruEtiketYukseklik(const AMetin: string; AGenislik: Integer): Integer;
var
  CharsPerLine, Satir: Integer;
begin
  CharsPerLine := Max(24, AGenislik div 8);
  if Trim(AMetin) = '' then
    Exit(CRM_KONTROL_ETIKET_MIN);
  Satir := (Length(Trim(AMetin)) + CharsPerLine - 1) div CharsPerLine;
  if Satir < 1 then
    Satir := 1;
  Result := Satir * 18 + 8;
  if Result < CRM_KONTROL_ETIKET_MIN then
    Result := CRM_KONTROL_ETIKET_MIN;
end;

procedure CrmDateTimePickerFormat(ADt: TUniDateTimePicker);
begin
  ADt.Kind := tUniDateTime;
  ADt.UseSystemFormats := False;
  ADt.DateFormat := 'dd.mm.yyyy';
  ADt.TimeFormat := 'HH:mm';
end;

function CrmKontrolTamamlamaGerekli(AQ: TUniQuery; ADurumId: Int64; const ADurumKod: string;
  AGorevModu: Boolean): Boolean;
begin
  Result := CrmDurumKapanisMi(AQ, ADurumId);
  if AGorevModu and (not Result) and SameText(Trim(ADurumKod), 'TAMAMLANDI') then
    Result := True;
end;

constructor TCrmAktiviteKontrolYonetici.Create(AOwner: TComponent; APanel: TUniPanel;
  AqKontrol, AqSecenek, AqCevap, AqExec: TUniQuery);
begin
  inherited Create;
  FOwner := AOwner;
  FPanel := APanel;
  FqKontrol := AqKontrol;
  FqSecenek := AqSecenek;
  FqCevap := AqCevap;
  FqExec := AqExec;
  FKontroller := TObjectList<TCrmSoruKontrol>.Create(True);
  FDinamik := TObjectList<TComponent>.Create(False);
  FBosMesaj := 'Bu kayit tipi icin tanimli soru seti yok.';
end;

destructor TCrmAktiviteKontrolYonetici.Destroy;
begin
  Temizle;
  FDinamik.Free;
  FKontroller.Free;
  inherited;
end;

procedure TCrmAktiviteKontrolYonetici.ControlsTemizle;
var
  I: Integer;
begin
  FKontroller.Clear;
  for I := FDinamik.Count - 1 downto 0 do
    FDinamik[I].Free;
  FDinamik.Clear;
end;

procedure TCrmAktiviteKontrolYonetici.Temizle;
begin
  ControlsTemizle;
  FAktiviteId := 0;
end;

procedure TCrmAktiviteKontrolYonetici.BosMesajGoster(const AMesaj: string);
var
  lbl: TUniLabel;
begin
  lbl := TUniLabel.Create(FOwner);
  lbl.Parent := FPanel;
  lbl.Left := 12;
  lbl.Top := 12;
  lbl.Width := 600;
  lbl.Caption := AMesaj;
  FDinamik.Add(lbl);
end;

procedure TCrmAktiviteKontrolYonetici.SoruOlustur(var AY: Integer);
var
  K: TCrmSoruKontrol;
  lbl: TUniLabel;
  cb: TUniComboBox;
  ed: TUniEdit;
  mm: TUniMemo;
  dt: TUniDateTimePicker;
  chk: TUniCheckBox;
  Tipi, Cap: string;
  N, LblH: Integer;
begin
  K := TCrmSoruKontrol.Create;
  K.SoruId := FqKontrol.FieldByName('SORU_ID').AsLargeInt;
  K.SetId := FqKontrol.FieldByName('SET_ID').AsLargeInt;
  K.Tipi := FqKontrol.FieldByName('CEVAP_TIPI').AsString;
  K.Zorunlu := FqKontrol.FieldByName('ZORUNLU').AsBoolean;
  K.SetZorunlu := FqKontrol.FieldByName('ZORUNLU_MU').AsBoolean;
  K.Metni := FqKontrol.FieldByName('SORU_METNI').AsString;
  Tipi := K.Tipi;

  if K.Zorunlu then
    Cap := '(*) ' + K.Metni
  else
    Cap := K.Metni;
  LblH := CrmSoruEtiketYukseklik(Cap, CRM_KONTROL_ETIKET_GEN);

  lbl := TUniLabel.Create(FOwner);
  lbl.Parent := FPanel;
  lbl.Left := CRM_KONTROL_KENAR;
  lbl.Top := AY;
  lbl.Width := CRM_KONTROL_ETIKET_GEN;
  lbl.Height := LblH;
  lbl.AutoSize := False;
  lbl.Caption := Cap;
  FDinamik.Add(lbl);
  AY := AY + LblH + 6;

  if SameText(Tipi, 'EVET_HAYIR') then
  begin
    cb := TUniComboBox.Create(FOwner);
    cb.Parent := FPanel;
    cb.Left := CRM_KONTROL_GIRIS;
    cb.Top := AY;
    cb.Width := 220;
    cb.Items.Add('Evet');
    cb.Items.Add('Hay' + #$0131 + 'r');
    cb.ItemIndex := -1;
    K.Ana := cb;
    FDinamik.Add(cb);
    AY := AY + 34 + CRM_KONTROL_ARALIK;
  end
  else if SameText(Tipi, 'PUAN') then
  begin
    cb := TUniComboBox.Create(FOwner);
    cb.Parent := FPanel;
    cb.Left := CRM_KONTROL_GIRIS;
    cb.Top := AY;
    cb.Width := 120;
    cb.Items.Add('1');
    cb.Items.Add('2');
    cb.Items.Add('3');
    cb.Items.Add('4');
    cb.Items.Add('5');
    cb.ItemIndex := -1;
    K.Ana := cb;
    FDinamik.Add(cb);
    AY := AY + 34 + CRM_KONTROL_ARALIK;
  end
  else if SameText(Tipi, 'TEK_SECIM') then
  begin
    FqSecenek.Close;
    FqSecenek.SQL.Text :=
      'SELECT SECENEK_ID, METIN FROM dbo.CRM_SORU_SECENEK ' +
      'WHERE SORU_ID = :S AND AKTIF = 1 ORDER BY SIRA, SECENEK_ID';
    FqSecenek.ParamByName('S').AsLargeInt := K.SoruId;
    FqSecenek.Open;
    cb := TUniComboBox.Create(FOwner);
    cb.Parent := FPanel;
    cb.Left := CRM_KONTROL_GIRIS;
    cb.Top := AY;
    cb.Width := CRM_KONTROL_GENISLIK;
    N := 0;
    while not FqSecenek.Eof do
    begin
      cb.Items.Add(FqSecenek.FieldByName('METIN').AsString);
      SetLength(K.SecenekIds, N + 1);
      K.SecenekIds[N] := FqSecenek.FieldByName('SECENEK_ID').AsLargeInt;
      Inc(N);
      FqSecenek.Next;
    end;
    FqSecenek.Close;
    cb.ItemIndex := -1;
    K.Ana := cb;
    FDinamik.Add(cb);
    AY := AY + 34 + CRM_KONTROL_ARALIK;
  end
  else if SameText(Tipi, 'COK_SECIM') then
  begin
    FqSecenek.Close;
    FqSecenek.SQL.Text :=
      'SELECT SECENEK_ID, METIN FROM dbo.CRM_SORU_SECENEK ' +
      'WHERE SORU_ID = :S AND AKTIF = 1 ORDER BY SIRA, SECENEK_ID';
    FqSecenek.ParamByName('S').AsLargeInt := K.SoruId;
    FqSecenek.Open;
    N := 0;
    while not FqSecenek.Eof do
    begin
      chk := TUniCheckBox.Create(FOwner);
      chk.Parent := FPanel;
      chk.Left := CRM_KONTROL_GIRIS;
      chk.Top := AY;
      chk.Width := CRM_KONTROL_GENISLIK;
      chk.Height := CRM_KONTROL_CHK_YUK;
      chk.Caption := FqSecenek.FieldByName('METIN').AsString;
      SetLength(K.SecenekIds, N + 1);
      SetLength(K.Checkler, N + 1);
      K.SecenekIds[N] := FqSecenek.FieldByName('SECENEK_ID').AsLargeInt;
      K.Checkler[N] := chk;
      FDinamik.Add(chk);
      AY := AY + CRM_KONTROL_CHK_YUK;
      Inc(N);
      FqSecenek.Next;
    end;
    FqSecenek.Close;
    AY := AY + CRM_KONTROL_ARALIK;
  end
  else if SameText(Tipi, 'SAYI') then
  begin
    ed := TUniEdit.Create(FOwner);
    ed.Parent := FPanel;
    ed.Left := CRM_KONTROL_GIRIS;
    ed.Top := AY;
    ed.Width := 220;
    K.Ana := ed;
    FDinamik.Add(ed);
    AY := AY + 34 + CRM_KONTROL_ARALIK;
  end
  else if SameText(Tipi, 'TARIH') then
  begin
    dt := TUniDateTimePicker.Create(FOwner);
    dt.Parent := FPanel;
    dt.Left := CRM_KONTROL_GIRIS;
    dt.Top := AY;
    dt.Width := 220;
    CrmDateTimePickerFormat(dt);
    dt.DateTime := Now;
    K.Ana := dt;
    FDinamik.Add(dt);
    AY := AY + 34 + CRM_KONTROL_ARALIK;
  end
  else
  begin
    mm := TUniMemo.Create(FOwner);
    mm.Parent := FPanel;
    mm.Left := CRM_KONTROL_GIRIS;
    mm.Top := AY;
    mm.Width := CRM_KONTROL_GENISLIK;
    mm.Height := CRM_KONTROL_MEMO_YUK;
    K.Ana := mm;
    FDinamik.Add(mm);
    AY := AY + CRM_KONTROL_MEMO_YUK + CRM_KONTROL_ARALIK;
  end;

  FKontroller.Add(K);
end;

procedure TCrmAktiviteKontrolYonetici.Yukle(AktiviteTipId: Int64; AktiviteId: Int64;
  const ABosMesaj: string);
var
  AY: Integer;
  LastSet: Int64;
  lbl: TUniLabel;
  Mesaj: string;
begin
  FAktiviteId := AktiviteId;
  if ABosMesaj <> '' then
    FBosMesaj := ABosMesaj;
  ControlsTemizle;

  if AktiviteTipId <= 0 then
  begin
    BosMesajGoster(FBosMesaj);
    Exit;
  end;

  FqKontrol.Close;
  FqKontrol.SQL.Text :=
    'SELECT S.SET_ID, S.BASLIK, A.ZORUNLU_MU, Q.SORU_ID, Q.SORU_METNI, Q.CEVAP_TIPI, Q.ZORUNLU ' +
    'FROM dbo.CRM_TIP_SORU_SETI A ' +
    'INNER JOIN dbo.CRM_SORU_SETI S ON S.SET_ID = A.SET_ID AND S.AKTIF = 1 ' +
    'INNER JOIN dbo.CRM_SORU Q ON Q.SET_ID = S.SET_ID AND Q.AKTIF = 1 ' +
    'WHERE A.AKTIVITE_TIP_ID = :TID AND A.AKTIF = 1 ' +
    'ORDER BY S.SIRA, S.SET_ID, Q.SIRA, Q.SORU_ID';
  FqKontrol.ParamByName('TID').AsLargeInt := AktiviteTipId;
  FqKontrol.Open;

  AY := 10;
  LastSet := -1;
  while not FqKontrol.Eof do
  begin
    if FqKontrol.FieldByName('SET_ID').AsLargeInt <> LastSet then
    begin
      LastSet := FqKontrol.FieldByName('SET_ID').AsLargeInt;
      lbl := TUniLabel.Create(FOwner);
      lbl.Parent := FPanel;
      lbl.Left := 8;
      lbl.Top := AY;
      lbl.Width := 610;
      lbl.ParentFont := False;
      lbl.Font.Style := [fsBold];
      lbl.Font.Height := -14;
      lbl.Caption := FqKontrol.FieldByName('BASLIK').AsString;
      FDinamik.Add(lbl);
      AY := AY + 32;
    end;
    SoruOlustur(AY);
    FqKontrol.Next;
  end;
  FqKontrol.Close;

  if FKontroller.Count = 0 then
  begin
    Mesaj := FBosMesaj;
    if Mesaj = '' then
      Mesaj := 'Bu kayit tipi icin tanimli soru seti yok.';
    BosMesajGoster(Mesaj);
  end
  else if FAktiviteId > 0 then
    CevaplariYukle;
end;

procedure TCrmAktiviteKontrolYonetici.YukleSet(ASetId: Int64; AktiviteId: Int64;
  const ABosMesaj: string);
var
  AY: Integer;
  LastSet: Int64;
  lbl: TUniLabel;
  Mesaj: string;
begin
  FAktiviteId := AktiviteId;
  if ABosMesaj <> '' then
    FBosMesaj := ABosMesaj;
  ControlsTemizle;

  if ASetId <= 0 then
  begin
    BosMesajGoster(FBosMesaj);
    Exit;
  end;

  FqKontrol.Close;
  FqKontrol.SQL.Text :=
    'SELECT S.SET_ID, S.BASLIK, CAST(1 AS BIT) AS ZORUNLU_MU, Q.SORU_ID, Q.SORU_METNI, Q.CEVAP_TIPI, Q.ZORUNLU ' +
    'FROM dbo.CRM_SORU_SETI S ' +
    'INNER JOIN dbo.CRM_SORU Q ON Q.SET_ID = S.SET_ID AND Q.AKTIF = 1 ' +
    'WHERE S.SET_ID = :SID AND S.AKTIF = 1 ' +
    'ORDER BY Q.SIRA, Q.SORU_ID';
  FqKontrol.ParamByName('SID').AsLargeInt := ASetId;
  FqKontrol.Open;

  AY := 10;
  LastSet := -1;
  while not FqKontrol.Eof do
  begin
    if FqKontrol.FieldByName('SET_ID').AsLargeInt <> LastSet then
    begin
      LastSet := FqKontrol.FieldByName('SET_ID').AsLargeInt;
      lbl := TUniLabel.Create(FOwner);
      lbl.Parent := FPanel;
      lbl.Left := 8;
      lbl.Top := AY;
      lbl.Width := 610;
      lbl.ParentFont := False;
      lbl.Font.Style := [fsBold];
      lbl.Font.Height := -14;
      lbl.Caption := FqKontrol.FieldByName('BASLIK').AsString;
      FDinamik.Add(lbl);
      AY := AY + 32;
    end;
    SoruOlustur(AY);
    FqKontrol.Next;
  end;
  FqKontrol.Close;

  if FKontroller.Count = 0 then
  begin
    Mesaj := FBosMesaj;
    if Mesaj = '' then
      Mesaj := 'Bu kayit tipi icin tanimli soru seti yok.';
    BosMesajGoster(Mesaj);
  end
  else if FAktiviteId > 0 then
    CevaplariYukle;
end;

procedure TCrmAktiviteKontrolYonetici.CevaplariYukle;
var
  I, J: Integer;
  K: TCrmSoruKontrol;
  CevapId, SecId: Int64;
begin
  for I := 0 to FKontroller.Count - 1 do
  begin
    K := FKontroller[I];
    FqCevap.Close;
    FqCevap.SQL.Text :=
      'SELECT CEVAP_ID, CEVAP_METIN, CEVAP_SAYI, CEVAP_TARIH, CEVAP_BIT ' +
      'FROM dbo.CRM_AKTIVITE_CEVAP WHERE AKTIVITE_ID = :A AND SORU_ID = :S';
    FqCevap.ParamByName('A').AsLargeInt := FAktiviteId;
    FqCevap.ParamByName('S').AsLargeInt := K.SoruId;
    FqCevap.Open;
    if FqCevap.IsEmpty then
    begin
      FqCevap.Close;
      Continue;
    end;
    CevapId := FqCevap.FieldByName('CEVAP_ID').AsLargeInt;

    if SameText(K.Tipi, 'EVET_HAYIR') then
    begin
      if not FqCevap.FieldByName('CEVAP_BIT').IsNull then
      begin
        if FqCevap.FieldByName('CEVAP_BIT').AsBoolean then
          TUniComboBox(K.Ana).ItemIndex := 0
        else
          TUniComboBox(K.Ana).ItemIndex := 1;
      end;
    end
    else if SameText(K.Tipi, 'PUAN') then
    begin
      if not FqCevap.FieldByName('CEVAP_SAYI').IsNull then
        TUniComboBox(K.Ana).ItemIndex := Trunc(FqCevap.FieldByName('CEVAP_SAYI').AsFloat) - 1;
    end
    else if SameText(K.Tipi, 'SAYI') then
    begin
      if not FqCevap.FieldByName('CEVAP_SAYI').IsNull then
        TUniEdit(K.Ana).Text := FloatToStr(FqCevap.FieldByName('CEVAP_SAYI').AsFloat);
    end
    else if SameText(K.Tipi, 'TARIH') then
    begin
      if not FqCevap.FieldByName('CEVAP_TARIH').IsNull then
        TUniDateTimePicker(K.Ana).DateTime := FqCevap.FieldByName('CEVAP_TARIH').AsDateTime;
    end
    else if SameText(K.Tipi, 'METIN') then
      TUniMemo(K.Ana).Text := FqCevap.FieldByName('CEVAP_METIN').AsString
    else if SameText(K.Tipi, 'TEK_SECIM') then
    begin
      FqCevap.Close;
      FqCevap.SQL.Text :=
        'SELECT TOP 1 SECENEK_ID FROM dbo.CRM_AKTIVITE_CEVAP_SECENEK WHERE CEVAP_ID = :C';
      FqCevap.ParamByName('C').AsLargeInt := CevapId;
      FqCevap.Open;
      if not FqCevap.IsEmpty and not FqCevap.FieldByName('SECENEK_ID').IsNull then
      begin
        SecId := FqCevap.FieldByName('SECENEK_ID').AsLargeInt;
        for J := 0 to High(K.SecenekIds) do
          if K.SecenekIds[J] = SecId then
          begin
            TUniComboBox(K.Ana).ItemIndex := J;
            Break;
          end;
      end;
    end
    else if SameText(K.Tipi, 'COK_SECIM') then
    begin
      FqCevap.Close;
      FqCevap.SQL.Text :=
        'SELECT SECENEK_ID FROM dbo.CRM_AKTIVITE_CEVAP_SECENEK WHERE CEVAP_ID = :C';
      FqCevap.ParamByName('C').AsLargeInt := CevapId;
      FqCevap.Open;
      while not FqCevap.Eof do
      begin
        if not FqCevap.FieldByName('SECENEK_ID').IsNull then
        begin
          SecId := FqCevap.FieldByName('SECENEK_ID').AsLargeInt;
          for J := 0 to High(K.SecenekIds) do
            if K.SecenekIds[J] = SecId then
            begin
              K.Checkler[J].Checked := True;
              Break;
            end;
        end;
        FqCevap.Next;
      end;
    end;
    FqCevap.Close;
  end;
end;

function TCrmAktiviteKontrolYonetici.Dogrula: Boolean;
var
  I, J: Integer;
  K: TCrmSoruKontrol;
  Cevaplandi: Boolean;
begin
  Result := True;
  for I := 0 to FKontroller.Count - 1 do
  begin
    K := FKontroller[I];
    if not (K.Zorunlu and K.SetZorunlu) then
      Continue;
    Cevaplandi := False;
    if SameText(K.Tipi, 'EVET_HAYIR') or SameText(K.Tipi, 'PUAN') or SameText(K.Tipi, 'TEK_SECIM') then
      Cevaplandi := TUniComboBox(K.Ana).ItemIndex >= 0
    else if SameText(K.Tipi, 'COK_SECIM') then
    begin
      for J := 0 to High(K.Checkler) do
        if K.Checkler[J].Checked then
        begin
          Cevaplandi := True;
          Break;
        end;
    end
    else if SameText(K.Tipi, 'SAYI') then
      Cevaplandi := Trim(TUniEdit(K.Ana).Text) <> ''
    else if SameText(K.Tipi, 'TARIH') then
      Cevaplandi := True
    else
      Cevaplandi := Trim(TUniMemo(K.Ana).Text) <> '';
    if not Cevaplandi then
    begin
      Result := False;
      if Assigned(FOnSekmeGoster) then
        FOnSekmeGoster(Self);
      UniMainModule.saHata.Show('Zorunlu kontrol sorusu cevaplanmali: ' + K.Metni);
      Exit;
    end;
  end;
end;

procedure TCrmAktiviteKontrolYonetici.CevaplariKaydet(AktiviteId: Int64);
var
  I, J, Cod: Integer;
  K: TCrmSoruKontrol;
  Cevaplandi: Boolean;
  CevapId: Int64;
begin
  if AktiviteId <= 0 then
    Exit;
  FAktiviteId := AktiviteId;
  for I := 0 to FKontroller.Count - 1 do
  begin
    K := FKontroller[I];

    FqExec.Close;
    FqExec.SQL.Text :=
      'DELETE FROM dbo.CRM_AKTIVITE_CEVAP WHERE AKTIVITE_ID = :A AND SORU_ID = :S';
    FqExec.ParamByName('A').AsLargeInt := AktiviteId;
    FqExec.ParamByName('S').AsLargeInt := K.SoruId;
    FqExec.Execute;

    Cevaplandi := False;
    FqExec.Close;
    FqExec.SQL.Text :=
      'INSERT INTO dbo.CRM_AKTIVITE_CEVAP (AKTIVITE_ID, SET_ID, SORU_ID, SORU_METNI_KOPYA, ' +
      'CEVAP_TIPI, CEVAP_METIN, CEVAP_SAYI, CEVAP_TARIH, CEVAP_BIT, CEVAPLAYAN_KULLANICI_ID) ' +
      'OUTPUT INSERTED.CEVAP_ID ' +
      'VALUES (:A, :SETID, :S, :MK, :CT, :CM, :CS, :CD, :CB, :KUL)';
    FqExec.ParamByName('A').AsLargeInt := AktiviteId;
    FqExec.ParamByName('SETID').AsLargeInt := K.SetId;
    FqExec.ParamByName('S').AsLargeInt := K.SoruId;
    FqExec.ParamByName('MK').AsString := K.Metni;
    FqExec.ParamByName('CT').AsString := K.Tipi;
    FqExec.ParamByName('CM').Clear;
    FqExec.ParamByName('CS').Clear;
    FqExec.ParamByName('CD').Clear;
    FqExec.ParamByName('CB').Clear;
    FqExec.ParamByName('KUL').AsInteger := Tmp.xKullaniciID;

    Cod := -1;
    if SameText(K.Tipi, 'EVET_HAYIR') then
    begin
      if TUniComboBox(K.Ana).ItemIndex >= 0 then
      begin
        Cevaplandi := True;
        FqExec.ParamByName('CB').AsBoolean := (TUniComboBox(K.Ana).ItemIndex = 0);
      end;
    end
    else if SameText(K.Tipi, 'PUAN') then
    begin
      if TUniComboBox(K.Ana).ItemIndex >= 0 then
      begin
        Cevaplandi := True;
        FqExec.ParamByName('CS').AsFloat := TUniComboBox(K.Ana).ItemIndex + 1;
      end;
    end
    else if SameText(K.Tipi, 'SAYI') then
    begin
      if Trim(TUniEdit(K.Ana).Text) <> '' then
      begin
        Cevaplandi := True;
        FqExec.ParamByName('CS').AsFloat := StrToFloatDef(Trim(TUniEdit(K.Ana).Text), 0);
      end;
    end
    else if SameText(K.Tipi, 'TARIH') then
    begin
      Cevaplandi := True;
      FqExec.ParamByName('CD').AsDateTime := TUniDateTimePicker(K.Ana).DateTime;
    end
    else if SameText(K.Tipi, 'TEK_SECIM') then
    begin
      Cod := TUniComboBox(K.Ana).ItemIndex;
      if Cod >= 0 then
      begin
        Cevaplandi := True;
        FqExec.ParamByName('CM').AsString := TUniComboBox(K.Ana).Items[Cod];
      end;
    end
    else if SameText(K.Tipi, 'COK_SECIM') then
    begin
      for J := 0 to High(K.Checkler) do
        if K.Checkler[J].Checked then
        begin
          Cevaplandi := True;
          Break;
        end;
    end
    else if Trim(TUniMemo(K.Ana).Text) <> '' then
    begin
      Cevaplandi := True;
      FqExec.ParamByName('CM').AsString := TUniMemo(K.Ana).Text;
    end;

    if not Cevaplandi then
      Continue;

    FqExec.Open;
    if FqExec.Fields[0].IsNull then
      CevapId := 0
    else
      CevapId := FqExec.Fields[0].AsLargeInt;
    FqExec.Close;
    if CevapId <= 0 then
      Continue;

    if SameText(K.Tipi, 'TEK_SECIM') and (Cod >= 0) and (Cod <= High(K.SecenekIds)) then
    begin
      FqExec.Close;
      FqExec.SQL.Text :=
        'INSERT INTO dbo.CRM_AKTIVITE_CEVAP_SECENEK (CEVAP_ID, SECENEK_ID, SECENEK_METNI_KOPYA) ' +
        'VALUES (:C, :SEC, :MK)';
      FqExec.ParamByName('C').AsLargeInt := CevapId;
      FqExec.ParamByName('SEC').AsLargeInt := K.SecenekIds[Cod];
      FqExec.ParamByName('MK').AsString := TUniComboBox(K.Ana).Items[Cod];
      FqExec.Execute;
    end
    else if SameText(K.Tipi, 'COK_SECIM') then
    begin
      for J := 0 to High(K.Checkler) do
        if K.Checkler[J].Checked then
        begin
          FqExec.Close;
          FqExec.SQL.Text :=
            'INSERT INTO dbo.CRM_AKTIVITE_CEVAP_SECENEK (CEVAP_ID, SECENEK_ID, SECENEK_METNI_KOPYA) ' +
            'VALUES (:C, :SEC, :MK)';
          FqExec.ParamByName('C').AsLargeInt := CevapId;
          FqExec.ParamByName('SEC').AsLargeInt := K.SecenekIds[J];
          FqExec.ParamByName('MK').AsString := K.Checkler[J].Caption;
          FqExec.Execute;
        end;
    end;
  end;
end;

end.
