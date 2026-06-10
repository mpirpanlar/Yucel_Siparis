unit CrmRotaDurakSecU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  System.Contnrs,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniLabel,
  uniEdit, uniButton, uniCheckBox, uniComboBox, uniMultiItem,
  uniBasicGrid, uniDBGrid, Data.DB, MemDS, DBAccess, Uni;

type
  TRotaSecimKayit = class
  public
    Tip: Char;
    CariKod: string;
    PotId: Int64;
    Unvan: string;
    Il, Ilce, Adres: string;
    GpsE, GpsB: Double;
  end;

  TOnRotaDurakSecimEvent = procedure(Sender: TObject; AListe: TObjectList) of object;

  TfrmCrmRotaDurakSec = class(TUniForm)
    rootPanel: TUniPanel;
    panFilt: TUniPanel;
    lblIl: TUniLabel;
    cbIl: TUniComboBox;
    lblIlce: TUniLabel;
    cbIlce: TUniComboBox;
    chkSadeceGps: TUniCheckBox;
    chkKaynakCari: TUniCheckBox;
    chkKaynakPot: TUniCheckBox;
    btnListele: TUniButton;
    grd: TUniDBGrid;
    panAlt: TUniPanel;
    lblSecili: TUniLabel;
    btnHarita: TUniButton;
    btnRotayaEkle: TUniButton;
    btnKapat: TUniButton;
    qList: TUniQuery;
    dsList: TUniDataSource;
    qIl: TUniQuery;
    qIlce: TUniQuery;
    procedure UniFormShow(Sender: TObject);
    procedure btnListeleClick(Sender: TObject);
    procedure btnHaritaClick(Sender: TObject);
    procedure btnRotayaEkleClick(Sender: TObject);
    procedure btnKapatClick(Sender: TObject);
    procedure cbIlChange(Sender: TObject);
    procedure grdSelectionChange(Sender: TObject);
  private
    FBasLat, FBasLng: Double;
    FOnSecimTamam: TOnRotaDurakSecimEvent;
    procedure IlleriDoldur;
    procedure IlceleriDoldur;
    function SeciliKayitListesi: TObjectList;
    function HaritaJsonSecili: string;
    procedure GuncelleSeciliSayisi;
  public
    property BaslangicLat: Double read FBasLat write FBasLat;
    property BaslangicLng: Double read FBasLng write FBasLng;
    property OnSecimTamam: TOnRotaDurakSecimEvent read FOnSecimTamam write FOnSecimTamam;
  end;

function frmCrmRotaDurakSec: TfrmCrmRotaDurakSec;

implementation

{$R *.dfm}

uses
  System.IOUtils, System.Math,
  ServerModule,
  uniGUIApplication, MainModule, DMU, CrmMapsConfigU, CrmRotaHaritaU;

function frmCrmRotaDurakSec: TfrmCrmRotaDurakSec;
begin
  Result := TfrmCrmRotaDurakSec(UniMainModule.GetFormInstance(TfrmCrmRotaDurakSec));
end;

procedure TfrmCrmRotaDurakSec.UniFormShow(Sender: TObject);
begin
  if cbIl.Items.Count = 0 then
  begin
    cbIl.Items.Add('(T'#252'm'#252')');
    IlleriDoldur;
  end;
  cbIl.ItemIndex := 0;
  IlceleriDoldur;
  chkSadeceGps.Checked := False;
  chkKaynakCari.Checked := True;
  chkKaynakPot.Checked := True;
  qList.Close;
  GuncelleSeciliSayisi;
end;

procedure TfrmCrmRotaDurakSec.IlleriDoldur;
begin
  qIl.Close;
  qIl.SQL.Text :=
    'SELECT IL FROM (' +
    'SELECT DISTINCT LTRIM(RTRIM(ISNULL(C.CARI_IL, N''''))) AS IL FROM YUCEL..HV_CARI_LISTESI C WITH(NOLOCK) ' +
    'WHERE LTRIM(RTRIM(ISNULL(C.CARI_IL, N''''))) <> N'''' ' +
    'UNION ' +
    'SELECT DISTINCT LTRIM(RTRIM(ISNULL(P.IL, N''''))) FROM dbo.CRM_POTANSIYEL_MUSTERI P WITH(NOLOCK) ' +
    'WHERE LTRIM(RTRIM(ISNULL(P.IL, N''''))) <> N'''' ' +
    ') X WHERE IL <> '''' ORDER BY IL';
  qIl.Open;
  while not qIl.Eof do
  begin
    cbIl.Items.Add(qIl.Fields[0].AsString);
    qIl.Next;
  end;
  qIl.Close;
end;

procedure TfrmCrmRotaDurakSec.IlceleriDoldur;
var
  Il: string;
begin
  cbIlce.Items.Clear;
  cbIlce.Items.Add('(T'#252'm'#252')');
  if cbIl.ItemIndex <= 0 then
  begin
    cbIlce.ItemIndex := 0;
    Exit;
  end;
  Il := cbIl.Items[cbIl.ItemIndex];
  qIlce.Close;
  qIlce.SQL.Text :=
    'SELECT ILCE FROM (' +
    'SELECT DISTINCT LTRIM(RTRIM(ISNULL(C.CARI_ILCE, N''''))) AS ILCE FROM YUCEL..HV_CARI_LISTESI C WITH(NOLOCK) ' +
    'WHERE LTRIM(RTRIM(ISNULL(C.CARI_IL, N''''))) = :IL AND LTRIM(RTRIM(ISNULL(C.CARI_ILCE, N''''))) <> N'''' ' +
    'UNION ' +
    'SELECT DISTINCT LTRIM(RTRIM(ISNULL(P.ILCE, N''''))) FROM dbo.CRM_POTANSIYEL_MUSTERI P WITH(NOLOCK) ' +
    'WHERE LTRIM(RTRIM(ISNULL(P.IL, N''''))) = :IL AND LTRIM(RTRIM(ISNULL(P.ILCE, N''''))) <> N'''' ' +
    ') X WHERE ILCE <> '''' ORDER BY ILCE';
  qIlce.ParamByName('IL').AsString := Il;
  qIlce.Open;
  while not qIlce.Eof do
  begin
    cbIlce.Items.Add(qIlce.Fields[0].AsString);
    qIlce.Next;
  end;
  qIlce.Close;
  cbIlce.ItemIndex := 0;
end;

procedure TfrmCrmRotaDurakSec.cbIlChange(Sender: TObject);
begin
  IlceleriDoldur;
end;

procedure TfrmCrmRotaDurakSec.btnListeleClick(Sender: TObject);
var
  SQL: string;
  Il, Ilce: string;
begin
  SQL := '';
  if chkKaynakCari.Checked then
    SQL :=
      'SELECT N''C'' AS TIP, C.CARI_KOD AS KOD, CAST(NULL AS BIGINT) AS POTID, C.CARI_ISIM AS UNVAN, ' +
      'ISNULL(C.CARI_IL, N'''') AS IL, ISNULL(C.CARI_ILCE, N'''') AS ILCE, ISNULL(C.CARI_ADRES, N'''') AS ADRES, ' +
      'COALESCE(NULLIF(T.KULL1N, 0), L.GPS_ENLEM) AS ENLEM, COALESCE(NULLIF(T.KULL2N, 0), L.GPS_BOYLAM) AS BOYLAM ' +
      'FROM YUCEL..HV_CARI_LISTESI C WITH(NOLOCK) ' +
      'LEFT JOIN TBLCASABITEK T WITH(NOLOCK) ON T.CARI_KOD = C.CARI_KOD ' +
      'LEFT JOIN dbo.CRM_CARI_LOKASYON L WITH(NOLOCK) ON L.CARI_KOD = C.CARI_KOD ' +
      'WHERE 1 = 1';

  if chkKaynakPot.Checked then
  begin
    if SQL <> '' then
      SQL := SQL + ' UNION ALL ';
    SQL := SQL +
      'SELECT N''P'' AS TIP, CAST(NULL AS VARCHAR(50)) AS KOD, P.POTANSIYEL_ID AS POTID, P.FIRMA_UNVAN AS UNVAN, ' +
      'ISNULL(P.IL, N'''') AS IL, ISNULL(P.ILCE, N'''') AS ILCE, ISNULL(P.ADRES, N'''') AS ADRES, ' +
      'P.GPS_ENLEM AS ENLEM, P.GPS_BOYLAM AS BOYLAM ' +
      'FROM dbo.CRM_POTANSIYEL_MUSTERI P WITH(NOLOCK) WHERE 1 = 1';
  end;

  if SQL = '' then
  begin
    UniMainModule.saHata.Show('En az bir kaynak (Netsis cari veya potansiyel) se'#231'iniz.');
    Exit;
  end;

  Il := '';
  Ilce := '';
  if cbIl.ItemIndex > 0 then
    Il := cbIl.Items[cbIl.ItemIndex];
  if cbIlce.ItemIndex > 0 then
    Ilce := cbIlce.Items[cbIlce.ItemIndex];

  qList.Close;
  qList.SQL.Text := 'SELECT * FROM (' + SQL + ') Q WHERE 1 = 1';
  if Il <> '' then
  begin
    qList.SQL.Text := qList.SQL.Text + ' AND Q.IL = :IL';
    qList.ParamByName('IL').AsString := Il;
  end;
  if Ilce <> '' then
  begin
    qList.SQL.Text := qList.SQL.Text + ' AND Q.ILCE = :ILCE';
    qList.ParamByName('ILCE').AsString := Ilce;
  end;
  if chkSadeceGps.Checked then
    qList.SQL.Text := qList.SQL.Text +
      ' AND Q.ENLEM IS NOT NULL AND Q.BOYLAM IS NOT NULL AND ABS(Q.ENLEM) > 1E-7 AND ABS(Q.BOYLAM) > 1E-7';
  qList.SQL.Text := qList.SQL.Text + ' ORDER BY Q.TIP, Q.UNVAN';
  qList.Open;
  GuncelleSeciliSayisi;
end;

procedure TfrmCrmRotaDurakSec.GuncelleSeciliSayisi;
begin
  if grd.SelectedRows.Count > 0 then
    lblSecili.Caption := Format('Se'#231'ili: %d', [grd.SelectedRows.Count])
  else
    lblSecili.Caption := 'Se'#231'ili: 0';
end;

procedure TfrmCrmRotaDurakSec.grdSelectionChange(Sender: TObject);
begin
  GuncelleSeciliSayisi;
end;

function TfrmCrmRotaDurakSec.SeciliKayitListesi: TObjectList;
var
  I: Integer;
  It: TRotaSecimKayit;
  Bm: TBookmark;
begin
  Result := TObjectList.Create(True);
  if not qList.Active or qList.IsEmpty or (grd.SelectedRows.Count = 0) then
    Exit;
  for I := 0 to grd.SelectedRows.Count - 1 do
  begin
    Bm := grd.SelectedRows[I];
    qList.Bookmark := Bm;
    It := TRotaSecimKayit.Create;
    It.Tip := qList.FieldByName('TIP').AsString[1];
    if qList.FieldByName('KOD').IsNull then
      It.CariKod := ''
    else
      It.CariKod := Trim(qList.FieldByName('KOD').AsString);
    if qList.FieldByName('POTID').IsNull then
      It.PotId := 0
    else
      It.PotId := qList.FieldByName('POTID').AsLargeInt;
    It.Unvan := qList.FieldByName('UNVAN').AsString;
    It.Il := qList.FieldByName('IL').AsString;
    It.Ilce := qList.FieldByName('ILCE').AsString;
    It.Adres := qList.FieldByName('ADRES').AsString;
    if qList.FieldByName('ENLEM').IsNull then
      It.GpsE := 0
    else
      It.GpsE := qList.FieldByName('ENLEM').AsFloat;
    if qList.FieldByName('BOYLAM').IsNull then
      It.GpsB := 0
    else
      It.GpsB := qList.FieldByName('BOYLAM').AsFloat;
    Result.Add(It);
  end;
end;

function TfrmCrmRotaDurakSec.HaritaJsonSecili: string;
var
  SL: TStringList;
  FS: TFormatSettings;
  I: Integer;
  It: TRotaSecimKayit;
  Liste: TObjectList;

  procedure EkleNokta(const ALa, ALn: Double; const ALabel: string);
  begin
    if (Abs(ALa) < 1E-7) or (Abs(ALn) < 1E-7) then
      Exit;
    SL.Add('{lat:' + FormatFloat('0.######', ALa, FS) + ',lng:' + FormatFloat('0.######', ALn, FS) +
      ',label:"' + ALabel + '"}');
  end;

begin
  Result := '';
  Liste := SeciliKayitListesi;
  try
    if (Liste.Count = 0) and (Abs(FBasLat) < 1E-7) then
      Exit;
    FS := TFormatSettings.Invariant;
    SL := TStringList.Create;
    try
      EkleNokta(FBasLat, FBasLng, 'B');
      for I := 0 to Liste.Count - 1 do
      begin
        It := TRotaSecimKayit(Liste[I]);
        EkleNokta(It.GpsE, It.GpsB, Copy(It.Unvan, 1, 20));
      end;
      if SL.Count = 0 then
        Exit;
      Result := SL[0];
      for I := 1 to SL.Count - 1 do
        Result := Result + ',' + SL[I];
      Result := '[' + Result + ']';
    finally
      SL.Free;
    end;
  finally
    Liste.Free;
  end;
end;

procedure TfrmCrmRotaDurakSec.btnHaritaClick(Sender: TObject);
var
  Pts, Key, Html, Fn: string;
  Sl: TStringList;
begin
  Pts := HaritaJsonSecili;
  if Pts = '' then
  begin
    UniMainModule.saHata.Show('Harita i'#231'in en az bir ge'#231'erli koordinat se'#231'iniz.');
    Exit;
  end;
  Key := Trim(CrmGoogleMapsBrowserApiKey);
  if (Key = '') or SameText(Key, 'YOUR_BROWSER_KEY_HERE') then
  begin
    UniMainModule.saHata.Show('Google Maps anahtar'#305' CrmMapsConfigU i'#231'inde tan'#305'mlanmal'#305'.');
    Exit;
  end;
  Fn := 'crm_rota_sec_' + IntToStr(GetTickCount) + '.html';
  Html :=
    '<!DOCTYPE html><html><head><meta charset="utf-8"/><style>html,body,#map{height:100%;margin:0}</style>' +
    '<script>var routePts=' + Pts + ';function initMap(){var map=new google.maps.Map(document.getElementById("map"),' +
    '{zoom:8,center:routePts[0]});for(var i=0;i<routePts.length;i++)new google.maps.Marker({position:routePts[i],' +
    'map:map,label:String(routePts[i].label||"")});var b=new google.maps.LatLngBounds();routePts.forEach(function(p){b.extend(p);});' +
    'map.fitBounds(b);}</script>' +
    '<script async defer src="https://maps.googleapis.com/maps/api/js?key=' + Key + '&callback=initMap"></script>' +
    '</head><body><div id="map"></div></body></html>';
  Sl := TStringList.Create;
  try
    Sl.Text := Html;
    Sl.SaveToFile(TPath.Combine(UniServerModule.LocalCachePath, Fn), TEncoding.UTF8);
  finally
    Sl.Free;
  end;
  frmCrmRotaHarita.HaritaUrl := UniServerModule.LocalCacheURL + Fn;
  frmCrmRotaHarita.ShowModal;
end;

procedure TfrmCrmRotaDurakSec.btnRotayaEkleClick(Sender: TObject);
var
  Liste: TObjectList;
begin
  Liste := SeciliKayitListesi;
  try
    if Liste.Count = 0 then
    begin
      UniMainModule.saHata.Show(#214'nce listele yap'#305'n ve en az bir sat'#305'r se'#231'in.');
      Exit;
    end;
    if Assigned(FOnSecimTamam) then
      FOnSecimTamam(Self, Liste);
    ModalResult := mrOk;
  finally
    Liste.Free;
  end;
end;

procedure TfrmCrmRotaDurakSec.btnKapatClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
