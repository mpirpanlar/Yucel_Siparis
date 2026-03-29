unit CrmSchemaU;

{ CRM semasi: ASYA_ENTEGRE uzerinde surumlu DDL.
  Yeni surum: CRM_SCHEMA_TARGET_VERSION artirin ve CrmSchemaApplyMigration icine case ekleyin. }

interface

uses
  DBAccess, Uni;

const
  CRM_SCHEMA_TARGET_VERSION = 2;

procedure CrmEnsureDatabase(AConn: TUniConnection);

implementation

uses
  SysUtils, Classes;

function CrmScalarInt(AConn: TUniConnection; const ASQL: string): Integer;
var
  Q: TUniQuery;
begin
  Result := 0;
  Q := TUniQuery.Create(nil);
  try
    Q.Connection := AConn;
    Q.SQL.Text := ASQL;
    Q.Open;
    if not Q.Fields[0].IsNull then
      Result := Q.Fields[0].AsInteger;
    Q.Close;
  finally
    Q.Free;
  end;
end;

function CrmSchemaGetVersion(AConn: TUniConnection): Integer;
{ SQL Server CASE kisa devre garanti etmez; ELSE icindeki FROM dbo.CRM_SCHEMA_GECMIS tablo yokken
  baglama asamasinda hata uretebilir. Once yalnizca OBJECT_ID; tablo varsa ayri SELECT ile MAX. }
begin
  Result := 0;
  if (AConn = nil) or not AConn.Connected then
    Exit;
  if CrmScalarInt(AConn,
    'SELECT CASE WHEN OBJECT_ID(''dbo.CRM_SCHEMA_GECMIS'',''U'') IS NULL THEN 0 ELSE 1 END') = 0 then
    Exit;
  Result := CrmScalarInt(AConn,
    'SELECT ISNULL(MAX(SURUM_NO), 0) FROM dbo.CRM_SCHEMA_GECMIS');
end;

procedure CrmExec(AConn: TUniConnection; const ASQL: string);
var
  Q: TUniQuery;
begin
  Q := TUniQuery.Create(nil);
  try
    Q.Connection := AConn;
    Q.SQL.Text := ASQL;
    Q.Execute;
  finally
    Q.Free;
  end;
end;

procedure CrmSchemaApplyMigration1(AConn: TUniConnection);
begin
  CrmExec(AConn,
    'IF OBJECT_ID(''dbo.CRM_SCHEMA_GECMIS'',''U'') IS NULL ' +
    'CREATE TABLE dbo.CRM_SCHEMA_GECMIS (' +
    'SURUM_NO INT NOT NULL CONSTRAINT PK_CRM_SCHEMA_GECMIS PRIMARY KEY, ' +
    'UYGULANMA_UTC DATETIME2(3) NOT NULL CONSTRAINT DF_CRM_SCH_UTC DEFAULT (SYSUTCDATETIME()), ' +
    'ACIKLAMA VARCHAR(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL)');

  CrmExec(AConn,
    'IF OBJECT_ID(''dbo.CRM_AKTIVITE'',''U'') IS NULL ' +
    'CREATE TABLE dbo.CRM_AKTIVITE (' +
    'AKTIVITE_ID BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_CRM_AKTIVITE PRIMARY KEY, ' +
    'TIP VARCHAR(30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, ' +
    'KONU VARCHAR(250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, ' +
    'ACIKLAMA VARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'CARI_KOD VARCHAR(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'AKTIVITE_TARIHI DATETIME2(3) NOT NULL, ' +
    'DURUM VARCHAR(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT DF_CRM_AKT_DURUM DEFAULT (''ACIK''), ' +
    'OLUSTURAN_KULLANICI_ID INT NULL, ' +
    'OLUSTURMA_UTC DATETIME2(3) NOT NULL CONSTRAINT DF_CRM_AKT_OLUSTR DEFAULT (SYSUTCDATETIME()), ' +
    'GUNCELLEME_UTC DATETIME2(3) NULL, ' +
    'CONSTRAINT CK_CRM_AKT_TIP CHECK (TIP IN (''CALL'', ''MEETING'', ''EMAIL'', ''TASK'', ''NOTE'', ''OTHER'')), ' +
    'CONSTRAINT CK_CRM_AKT_DURUM CHECK (DURUM IN (''ACIK'', ''TAMAMLANDI'', ''IPTAL'')) )');

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = ''IX_CRM_AKT_CARI'' AND object_id = OBJECT_ID(''dbo.CRM_AKTIVITE'')) ' +
    'CREATE INDEX IX_CRM_AKT_CARI ON dbo.CRM_AKTIVITE (CARI_KOD)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = ''IX_CRM_AKT_TAR'' AND object_id = OBJECT_ID(''dbo.CRM_AKTIVITE'')) ' +
    'CREATE INDEX IX_CRM_AKT_TAR ON dbo.CRM_AKTIVITE (AKTIVITE_TARIHI)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = ''IX_CRM_AKT_TIP_DURUM'' AND object_id = OBJECT_ID(''dbo.CRM_AKTIVITE'')) ' +
    'CREATE INDEX IX_CRM_AKT_TIP_DURUM ON dbo.CRM_AKTIVITE (TIP, DURUM)');

  CrmExec(AConn,
    'IF OBJECT_ID(''dbo.CRM_GOREV'',''U'') IS NULL ' +
    'CREATE TABLE dbo.CRM_GOREV (' +
    'GOREV_ID BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_CRM_GOREV PRIMARY KEY, ' +
    'AKTIVITE_ID BIGINT NOT NULL, ' +
    'ATANAN_KULLANICI_ID INT NULL, ' +
    'BITIS_TARIHI DATETIME2(3) NULL, ' +
    'ONCELIK VARCHAR(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT DF_CRM_GRV_ONCELIK DEFAULT (''NORMAL''), ' +
    'TAMAMLANDI BIT NOT NULL CONSTRAINT DF_CRM_GRV_TAM DEFAULT (0), ' +
    'TAMAMLANMA_UTC DATETIME2(3) NULL, ' +
    'CONSTRAINT UQ_CRM_GOREV_AKT UNIQUE (AKTIVITE_ID), ' +
    'CONSTRAINT FK_CRM_GOREV_AKT FOREIGN KEY (AKTIVITE_ID) REFERENCES dbo.CRM_AKTIVITE (AKTIVITE_ID) ON DELETE CASCADE, ' +
    'CONSTRAINT CK_CRM_GRV_ONCELIK CHECK (ONCELIK IN (''DUSUK'', ''NORMAL'', ''YUKSEK'', ''ACIL'')) )');

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = ''IX_CRM_GRV_ATANAN'' AND object_id = OBJECT_ID(''dbo.CRM_GOREV'')) ' +
    'CREATE INDEX IX_CRM_GRV_ATANAN ON dbo.CRM_GOREV (ATANAN_KULLANICI_ID, TAMAMLANDI)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = ''IX_CRM_GRV_BITIS'' AND object_id = OBJECT_ID(''dbo.CRM_GOREV'')) ' +
    'CREATE INDEX IX_CRM_GRV_BITIS ON dbo.CRM_GOREV (BITIS_TARIHI)');

  if CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.tables WHERE name = ''FormName'' AND schema_id = SCHEMA_ID(''dbo'')') > 0 then
  begin
    CrmExec(AConn,
      'INSERT INTO dbo.FormName (FormName, FormCaption) SELECT v.FN, v.FC FROM (VALUES ' +
      '(''CrmYeniAktivite'', ''CRM - Yeni Aktivite''), (''CrmYeniGorev'', ''CRM - Yeni Gorev'')) AS v(FN, FC) ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.FormName f WHERE f.FormName = v.FN)');
  end;

  if (CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.tables WHERE name = ''YETKI'' AND schema_id = SCHEMA_ID(''dbo'')') > 0) and
     (CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.tables WHERE name = ''KULLANICIGRUP'' AND schema_id = SCHEMA_ID(''dbo'')') > 0) then
  begin
    CrmExec(AConn,
      'INSERT INTO dbo.YETKI (KullaniciGrupID, FormName, Gor, Sil, Degistir, Kaydet) ' +
      'SELECT g.KullaniciGrupID, ''CrmYeniAktivite'', 1, 1, 1, 1 FROM dbo.KULLANICIGRUP g ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.YETKI y WHERE y.KullaniciGrupID = g.KullaniciGrupID AND y.FormName = ''CrmYeniAktivite'')');
    CrmExec(AConn,
      'INSERT INTO dbo.YETKI (KullaniciGrupID, FormName, Gor, Sil, Degistir, Kaydet) ' +
      'SELECT g.KullaniciGrupID, ''CrmYeniGorev'', 1, 1, 1, 1 FROM dbo.KULLANICIGRUP g ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.YETKI y WHERE y.KullaniciGrupID = g.KullaniciGrupID AND y.FormName = ''CrmYeniGorev'')');
  end;

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_SCHEMA_GECMIS WHERE SURUM_NO = 1) ' +
    'INSERT INTO dbo.CRM_SCHEMA_GECMIS (SURUM_NO, ACIKLAMA) VALUES (1, ''CRM ilk tablolar (aktivite, gorev, sema gecmisi)'')');
end;

procedure CrmSchemaApplyMigration2(AConn: TUniConnection);
begin
  if CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.tables WHERE name = ''FormName'' AND schema_id = SCHEMA_ID(''dbo'')') > 0 then
  begin
    CrmExec(AConn,
      'INSERT INTO dbo.FormName (FormName, FormCaption) SELECT v.FN, v.FC FROM (VALUES ' +
      '(''CrmAktiviteListesi'', ''CRM - Aktivite Listesi''), (''CrmGorevListesi'', ''CRM - Gorev Listesi'')) AS v(FN, FC) ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.FormName f WHERE f.FormName = v.FN)');
  end;

  if (CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.tables WHERE name = ''YETKI'' AND schema_id = SCHEMA_ID(''dbo'')') > 0) and
     (CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.tables WHERE name = ''KULLANICIGRUP'' AND schema_id = SCHEMA_ID(''dbo'')') > 0) then
  begin
    CrmExec(AConn,
      'INSERT INTO dbo.YETKI (KullaniciGrupID, FormName, Gor, Sil, Degistir, Kaydet) ' +
      'SELECT g.KullaniciGrupID, ''CrmAktiviteListesi'', 1, 1, 1, 1 FROM dbo.KULLANICIGRUP g ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.YETKI y WHERE y.KullaniciGrupID = g.KullaniciGrupID AND y.FormName = ''CrmAktiviteListesi'')');
    CrmExec(AConn,
      'INSERT INTO dbo.YETKI (KullaniciGrupID, FormName, Gor, Sil, Degistir, Kaydet) ' +
      'SELECT g.KullaniciGrupID, ''CrmGorevListesi'', 1, 1, 1, 1 FROM dbo.KULLANICIGRUP g ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.YETKI y WHERE y.KullaniciGrupID = g.KullaniciGrupID AND y.FormName = ''CrmGorevListesi'')');
  end;

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_SCHEMA_GECMIS WHERE SURUM_NO = 2) ' +
    'INSERT INTO dbo.CRM_SCHEMA_GECMIS (SURUM_NO, ACIKLAMA) VALUES (2, ''CRM liste formlari (FormName, YETKI)'')');
end;

procedure CrmSchemaApplyMigration(const AConn: TUniConnection; AVersion: Integer);
begin
  case AVersion of
    1: CrmSchemaApplyMigration1(AConn);
    2: CrmSchemaApplyMigration2(AConn);
  else
    raise Exception.CreateFmt('CRM sema: bilinmeyen migrasyon surumu %d', [AVersion]);
  end;
end;

procedure CrmEnsureDatabase(AConn: TUniConnection);
var
  V, Target: Integer;
begin
  if (AConn = nil) or not AConn.Connected then
    Exit;
  Target := CRM_SCHEMA_TARGET_VERSION;
  V := CrmSchemaGetVersion(AConn);
  while V < Target do
  begin
    Inc(V);
    CrmSchemaApplyMigration(AConn, V);
  end;
end;

end.
