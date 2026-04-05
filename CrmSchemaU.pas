unit CrmSchemaU;

{ CRM semasi: ASYA_ENTEGRE uzerinde surumlu DDL.
  Yeni surum: CRM_SCHEMA_TARGET_VERSION artirin ve CrmSchemaApplyMigration icine case ekleyin. }

interface

uses
  DBAccess, Uni;

const
  CRM_SCHEMA_TARGET_VERSION = 12;

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

procedure CrmSchemaApplyMigration3(AConn: TUniConnection);
begin
  CrmExec(AConn,
    'IF OBJECT_ID(''dbo.CRM_AKTIVITE_TIP'',''U'') IS NULL ' +
    'CREATE TABLE dbo.CRM_AKTIVITE_TIP (' +
    'TIP_ID BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_CRM_AKTIVITE_TIP PRIMARY KEY, ' +
    'KOD VARCHAR(30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, ' +
    'ACIKLAMA VARCHAR(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'UST_TIP_ID BIGINT NULL, ' +
    'AKTIF BIT NOT NULL CONSTRAINT DF_CRM_TIP_AKTIF DEFAULT (1), ' +
    'SIRA INT NOT NULL CONSTRAINT DF_CRM_TIP_SIRA DEFAULT (0), ' +
    'CONSTRAINT UQ_CRM_AKTIVITE_TIP_KOD UNIQUE (KOD), ' +
    'CONSTRAINT FK_CRM_TIP_UST FOREIGN KEY (UST_TIP_ID) REFERENCES dbo.CRM_AKTIVITE_TIP (TIP_ID) )');

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = ''IX_CRM_TIP_UST'' AND object_id = OBJECT_ID(''dbo.CRM_AKTIVITE_TIP'')) ' +
    'CREATE INDEX IX_CRM_TIP_UST ON dbo.CRM_AKTIVITE_TIP (UST_TIP_ID)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = ''IX_CRM_TIP_AKT_SIRA'' AND object_id = OBJECT_ID(''dbo.CRM_AKTIVITE_TIP'')) ' +
    'CREATE INDEX IX_CRM_TIP_AKT_SIRA ON dbo.CRM_AKTIVITE_TIP (AKTIF, SIRA)');

  CrmExec(AConn,
    'IF OBJECT_ID(''dbo.CRM_AKTIVITE_DURUM'',''U'') IS NULL ' +
    'CREATE TABLE dbo.CRM_AKTIVITE_DURUM (' +
    'DURUM_ID BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_CRM_AKTIVITE_DURUM PRIMARY KEY, ' +
    'KOD VARCHAR(30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, ' +
    'ACIKLAMA VARCHAR(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'AKTIF BIT NOT NULL CONSTRAINT DF_CRM_DUR_AKTIF DEFAULT (1), ' +
    'SIRA INT NOT NULL CONSTRAINT DF_CRM_DUR_SIRA DEFAULT (0), ' +
    'CONSTRAINT UQ_CRM_AKTIVITE_DURUM_KOD UNIQUE (KOD) )');

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = ''IX_CRM_DUR_AKT_SIRA'' AND object_id = OBJECT_ID(''dbo.CRM_AKTIVITE_DURUM'')) ' +
    'CREATE INDEX IX_CRM_DUR_AKT_SIRA ON dbo.CRM_AKTIVITE_DURUM (AKTIF, SIRA)');

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_AKTIVITE_TIP WHERE KOD = ''CALL'') ' +
    'INSERT INTO dbo.CRM_AKTIVITE_TIP (KOD, ACIKLAMA, UST_TIP_ID, AKTIF, SIRA) VALUES (''CALL'', ''Arama'', NULL, 1, 10)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_AKTIVITE_TIP WHERE KOD = ''MEETING'') ' +
    'INSERT INTO dbo.CRM_AKTIVITE_TIP (KOD, ACIKLAMA, UST_TIP_ID, AKTIF, SIRA) VALUES (''MEETING'', ''Toplanti'', NULL, 1, 20)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_AKTIVITE_TIP WHERE KOD = ''EMAIL'') ' +
    'INSERT INTO dbo.CRM_AKTIVITE_TIP (KOD, ACIKLAMA, UST_TIP_ID, AKTIF, SIRA) VALUES (''EMAIL'', ''E-posta'', NULL, 1, 30)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_AKTIVITE_TIP WHERE KOD = ''NOTE'') ' +
    'INSERT INTO dbo.CRM_AKTIVITE_TIP (KOD, ACIKLAMA, UST_TIP_ID, AKTIF, SIRA) VALUES (''NOTE'', ''Not'', NULL, 1, 40)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_AKTIVITE_TIP WHERE KOD = ''OTHER'') ' +
    'INSERT INTO dbo.CRM_AKTIVITE_TIP (KOD, ACIKLAMA, UST_TIP_ID, AKTIF, SIRA) VALUES (''OTHER'', ''Diger'', NULL, 1, 50)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_AKTIVITE_TIP WHERE KOD = ''TASK'') ' +
    'INSERT INTO dbo.CRM_AKTIVITE_TIP (KOD, ACIKLAMA, UST_TIP_ID, AKTIF, SIRA) VALUES (''TASK'', ''Gorev (sistem)'', NULL, 1, 90)');

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_AKTIVITE_DURUM WHERE KOD = ''ACIK'') ' +
    'INSERT INTO dbo.CRM_AKTIVITE_DURUM (KOD, ACIKLAMA, AKTIF, SIRA) VALUES (''ACIK'', ''Acik'', 1, 10)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_AKTIVITE_DURUM WHERE KOD = ''TAMAMLANDI'') ' +
    'INSERT INTO dbo.CRM_AKTIVITE_DURUM (KOD, ACIKLAMA, AKTIF, SIRA) VALUES (''TAMAMLANDI'', ''Tamamlandi'', 1, 20)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_AKTIVITE_DURUM WHERE KOD = ''IPTAL'') ' +
    'INSERT INTO dbo.CRM_AKTIVITE_DURUM (KOD, ACIKLAMA, AKTIF, SIRA) VALUES (''IPTAL'', ''Iptal'', 1, 30)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_AKTIVITE_DURUM WHERE KOD = ''PLANLANDI'') ' +
    'INSERT INTO dbo.CRM_AKTIVITE_DURUM (KOD, ACIKLAMA, AKTIF, SIRA) VALUES (''PLANLANDI'', ''Planlandi'', 1, 40)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_AKTIVITE_DURUM WHERE KOD = ''GERCEKLESTI'') ' +
    'INSERT INTO dbo.CRM_AKTIVITE_DURUM (KOD, ACIKLAMA, AKTIF, SIRA) VALUES (''GERCEKLESTI'', ''Gerceklesti'', 1, 50)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_AKTIVITE_DURUM WHERE KOD = ''BEKLIYOR'') ' +
    'INSERT INTO dbo.CRM_AKTIVITE_DURUM (KOD, ACIKLAMA, AKTIF, SIRA) VALUES (''BEKLIYOR'', ''Bekliyor'', 1, 60)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_AKTIVITE_DURUM WHERE KOD = ''BITTI'') ' +
    'INSERT INTO dbo.CRM_AKTIVITE_DURUM (KOD, ACIKLAMA, AKTIF, SIRA) VALUES (''BITTI'', ''Bitti'', 1, 70)');

  if CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.columns WHERE object_id = OBJECT_ID(''dbo.CRM_AKTIVITE'') AND name = ''AKTIVITE_TIP_ID''') = 0 then
    CrmExec(AConn, 'ALTER TABLE dbo.CRM_AKTIVITE ADD AKTIVITE_TIP_ID BIGINT NULL');
  if CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.columns WHERE object_id = OBJECT_ID(''dbo.CRM_AKTIVITE'') AND name = ''AKTIVITE_DURUM_ID''') = 0 then
    CrmExec(AConn, 'ALTER TABLE dbo.CRM_AKTIVITE ADD AKTIVITE_DURUM_ID BIGINT NULL');

  CrmExec(AConn,
    'UPDATE a SET a.AKTIVITE_TIP_ID = t.TIP_ID FROM dbo.CRM_AKTIVITE a ' +
    'INNER JOIN dbo.CRM_AKTIVITE_TIP t ON t.KOD = a.TIP WHERE a.AKTIVITE_TIP_ID IS NULL');
  CrmExec(AConn,
    'UPDATE a SET a.AKTIVITE_DURUM_ID = d.DURUM_ID FROM dbo.CRM_AKTIVITE a ' +
    'INNER JOIN dbo.CRM_AKTIVITE_DURUM d ON d.KOD = a.DURUM WHERE a.AKTIVITE_DURUM_ID IS NULL');

  CrmExec(AConn,
    'UPDATE dbo.CRM_AKTIVITE SET AKTIVITE_TIP_ID = (SELECT TOP 1 TIP_ID FROM dbo.CRM_AKTIVITE_TIP WHERE KOD = ''OTHER'') ' +
    'WHERE AKTIVITE_TIP_ID IS NULL');
  CrmExec(AConn,
    'UPDATE dbo.CRM_AKTIVITE SET AKTIVITE_DURUM_ID = (SELECT TOP 1 DURUM_ID FROM dbo.CRM_AKTIVITE_DURUM WHERE KOD = ''ACIK'') ' +
    'WHERE AKTIVITE_DURUM_ID IS NULL');

  CrmExec(AConn,
    'IF EXISTS (SELECT 1 FROM sys.check_constraints WHERE parent_object_id = OBJECT_ID(''dbo.CRM_AKTIVITE'') AND name = ''CK_CRM_AKT_TIP'') ' +
    'ALTER TABLE dbo.CRM_AKTIVITE DROP CONSTRAINT CK_CRM_AKT_TIP');
  CrmExec(AConn,
    'IF EXISTS (SELECT 1 FROM sys.check_constraints WHERE parent_object_id = OBJECT_ID(''dbo.CRM_AKTIVITE'') AND name = ''CK_CRM_AKT_DURUM'') ' +
    'ALTER TABLE dbo.CRM_AKTIVITE DROP CONSTRAINT CK_CRM_AKT_DURUM');

  CrmExec(AConn, 'ALTER TABLE dbo.CRM_AKTIVITE ALTER COLUMN AKTIVITE_TIP_ID BIGINT NOT NULL');
  CrmExec(AConn, 'ALTER TABLE dbo.CRM_AKTIVITE ALTER COLUMN AKTIVITE_DURUM_ID BIGINT NOT NULL');

  if CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.foreign_keys WHERE name = ''FK_CRM_AKTIVITE_TIP'' AND parent_object_id = OBJECT_ID(''dbo.CRM_AKTIVITE'')') = 0 then
    CrmExec(AConn,
      'ALTER TABLE dbo.CRM_AKTIVITE ADD CONSTRAINT FK_CRM_AKTIVITE_TIP FOREIGN KEY (AKTIVITE_TIP_ID) ' +
      'REFERENCES dbo.CRM_AKTIVITE_TIP (TIP_ID)');
  if CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.foreign_keys WHERE name = ''FK_CRM_AKTIVITE_DURUM'' AND parent_object_id = OBJECT_ID(''dbo.CRM_AKTIVITE'')') = 0 then
    CrmExec(AConn,
      'ALTER TABLE dbo.CRM_AKTIVITE ADD CONSTRAINT FK_CRM_AKTIVITE_DURUM FOREIGN KEY (AKTIVITE_DURUM_ID) ' +
      'REFERENCES dbo.CRM_AKTIVITE_DURUM (DURUM_ID)');

  if CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.tables WHERE name = ''FormName'' AND schema_id = SCHEMA_ID(''dbo'')') > 0 then
  begin
    CrmExec(AConn,
      'INSERT INTO dbo.FormName (FormName, FormCaption) SELECT v.FN, v.FC FROM (VALUES ' +
      '(''CrmParamAktiviteTip'', ''CRM - Aktivite Tipleri''), (''CrmParamAktiviteDurum'', ''CRM - Aktivite Durumlari'')) AS v(FN, FC) ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.FormName f WHERE f.FormName = v.FN)');
    CrmExec(AConn,
      'UPDATE dbo.FormName SET FormCaption = N''CRM - Aktivite Durumlar'' + NCHAR(305) WHERE FormName = ''CrmParamAktiviteDurum''');
  end;

  if (CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.tables WHERE name = ''YETKI'' AND schema_id = SCHEMA_ID(''dbo'')') > 0) and
     (CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.tables WHERE name = ''KULLANICIGRUP'' AND schema_id = SCHEMA_ID(''dbo'')') > 0) then
  begin
    CrmExec(AConn,
      'INSERT INTO dbo.YETKI (KullaniciGrupID, FormName, Gor, Sil, Degistir, Kaydet) ' +
      'SELECT g.KullaniciGrupID, ''CrmParamAktiviteTip'', 1, 1, 1, 1 FROM dbo.KULLANICIGRUP g ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.YETKI y WHERE y.KullaniciGrupID = g.KullaniciGrupID AND y.FormName = ''CrmParamAktiviteTip'')');
    CrmExec(AConn,
      'INSERT INTO dbo.YETKI (KullaniciGrupID, FormName, Gor, Sil, Degistir, Kaydet) ' +
      'SELECT g.KullaniciGrupID, ''CrmParamAktiviteDurum'', 1, 1, 1, 1 FROM dbo.KULLANICIGRUP g ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.YETKI y WHERE y.KullaniciGrupID = g.KullaniciGrupID AND y.FormName = ''CrmParamAktiviteDurum'')');
  end;

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_SCHEMA_GECMIS WHERE SURUM_NO = 3) ' +
    'INSERT INTO dbo.CRM_SCHEMA_GECMIS (SURUM_NO, ACIKLAMA) VALUES (3, ''CRM parametre: aktivite tip/durum kartlari, FK'')');
end;

procedure CrmSchemaApplyMigration4(AConn: TUniConnection);
begin
  CrmExec(AConn,
    'IF OBJECT_ID(''dbo.CRM_TEKLIF'',''U'') IS NULL ' +
    'CREATE TABLE dbo.CRM_TEKLIF (' +
    'TEKLIF_ID BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_CRM_TEKLIF PRIMARY KEY, ' +
    'CARI_KOD VARCHAR(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'BASLIK VARCHAR(250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, ' +
    'TEKLIF_TARIHI DATETIME2(3) NOT NULL CONSTRAINT DF_CRM_TKL_TAR DEFAULT (SYSUTCDATETIME()), ' +
    'GECERLILIK_TARIHI DATETIME2(3) NULL, ' +
    'DURUM VARCHAR(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT DF_CRM_TKL_DUR DEFAULT (''TASLAK''), ' +
    'ACIKLAMA VARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'TOPLAM_NET DECIMAL(18,4) NOT NULL CONSTRAINT DF_CRM_TKL_TOP DEFAULT (0), ' +
    'OLUSTURAN_KULLANICI_ID INT NULL, ' +
    'OLUSTURMA_UTC DATETIME2(3) NOT NULL CONSTRAINT DF_CRM_TKL_OLU DEFAULT (SYSUTCDATETIME()), ' +
    'GUNCELLEME_UTC DATETIME2(3) NULL )');

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = ''IX_CRM_TKL_CARI'' AND object_id = OBJECT_ID(''dbo.CRM_TEKLIF'')) ' +
    'CREATE INDEX IX_CRM_TKL_CARI ON dbo.CRM_TEKLIF (CARI_KOD)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = ''IX_CRM_TKL_TAR'' AND object_id = OBJECT_ID(''dbo.CRM_TEKLIF'')) ' +
    'CREATE INDEX IX_CRM_TKL_TAR ON dbo.CRM_TEKLIF (TEKLIF_TARIHI)');

  CrmExec(AConn,
    'IF OBJECT_ID(''dbo.CRM_TEKLIF_SATIR'',''U'') IS NULL ' +
    'CREATE TABLE dbo.CRM_TEKLIF_SATIR (' +
    'SATIR_ID BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_CRM_TEKLIF_SATIR PRIMARY KEY, ' +
    'TEKLIF_ID BIGINT NOT NULL, ' +
    'SIRA INT NOT NULL CONSTRAINT DF_CRM_TKS_SIRA DEFAULT (0), ' +
    'STOK_KOD VARCHAR(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, ' +
    'STOK_ADI VARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'MIKTAR DECIMAL(18,4) NOT NULL, ' +
    'BIRIM VARCHAR(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'BIRIM_FIYAT DECIMAL(18,4) NOT NULL, ' +
    'TUTAR DECIMAL(18,4) NOT NULL, ' +
    'CONSTRAINT FK_CRM_TKS_TKL FOREIGN KEY (TEKLIF_ID) REFERENCES dbo.CRM_TEKLIF (TEKLIF_ID) ON DELETE CASCADE )');

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = ''IX_CRM_TKS_TKL'' AND object_id = OBJECT_ID(''dbo.CRM_TEKLIF_SATIR'')) ' +
    'CREATE INDEX IX_CRM_TKS_TKL ON dbo.CRM_TEKLIF_SATIR (TEKLIF_ID, SIRA)');

  if CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.tables WHERE name = ''FormName'' AND schema_id = SCHEMA_ID(''dbo'')') > 0 then
  begin
    CrmExec(AConn,
      'INSERT INTO dbo.FormName (FormName, FormCaption) SELECT v.FN, v.FC FROM (VALUES ' +
      '(''CrmYeniTeklif'', ''CRM - Teklif''), (''CrmTeklifListesi'', ''CRM - Teklif Listesi'')) AS v(FN, FC) ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.FormName f WHERE f.FormName = v.FN)');
  end;

  if (CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.tables WHERE name = ''YETKI'' AND schema_id = SCHEMA_ID(''dbo'')') > 0) and
     (CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.tables WHERE name = ''KULLANICIGRUP'' AND schema_id = SCHEMA_ID(''dbo'')') > 0) then
  begin
    CrmExec(AConn,
      'INSERT INTO dbo.YETKI (KullaniciGrupID, FormName, Gor, Sil, Degistir, Kaydet) ' +
      'SELECT g.KullaniciGrupID, ''CrmYeniTeklif'', 1, 1, 1, 1 FROM dbo.KULLANICIGRUP g ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.YETKI y WHERE y.KullaniciGrupID = g.KullaniciGrupID AND y.FormName = ''CrmYeniTeklif'')');
    CrmExec(AConn,
      'INSERT INTO dbo.YETKI (KullaniciGrupID, FormName, Gor, Sil, Degistir, Kaydet) ' +
      'SELECT g.KullaniciGrupID, ''CrmTeklifListesi'', 1, 1, 1, 1 FROM dbo.KULLANICIGRUP g ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.YETKI y WHERE y.KullaniciGrupID = g.KullaniciGrupID AND y.FormName = ''CrmTeklifListesi'')');
  end;

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_SCHEMA_GECMIS WHERE SURUM_NO = 4) ' +
    'INSERT INTO dbo.CRM_SCHEMA_GECMIS (SURUM_NO, ACIKLAMA) VALUES (4, ''CRM teklif baslik ve urun satirlari'')');
end;

procedure CrmSchemaApplyMigration5(AConn: TUniConnection);
begin
  CrmExec(AConn,
    'IF OBJECT_ID(''dbo.CRM_TEKLIF_DURUM'',''U'') IS NULL ' +
    'CREATE TABLE dbo.CRM_TEKLIF_DURUM (' +
    'TEKLIF_DURUM_ID BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_CRM_TEKLIF_DURUM PRIMARY KEY, ' +
    'KOD VARCHAR(30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, ' +
    'ACIKLAMA VARCHAR(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'AKTIF BIT NOT NULL CONSTRAINT DF_CRM_TKDUR_AKTIF DEFAULT (1), ' +
    'SIRA INT NOT NULL CONSTRAINT DF_CRM_TKDUR_SIRA DEFAULT (0), ' +
    'CONSTRAINT UQ_CRM_TEKLIF_DURUM_KOD UNIQUE (KOD) )');

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = ''IX_CRM_TKDUR_AKT_SIRA'' AND object_id = OBJECT_ID(''dbo.CRM_TEKLIF_DURUM'')) ' +
    'CREATE INDEX IX_CRM_TKDUR_AKT_SIRA ON dbo.CRM_TEKLIF_DURUM (AKTIF, SIRA)');

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_TEKLIF_DURUM WHERE KOD = ''TASLAK'') ' +
    'INSERT INTO dbo.CRM_TEKLIF_DURUM (KOD, ACIKLAMA, AKTIF, SIRA) VALUES (''TASLAK'', ''Taslak'', 1, 10)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_TEKLIF_DURUM WHERE KOD = ''GONDERILDI'') ' +
    'INSERT INTO dbo.CRM_TEKLIF_DURUM (KOD, ACIKLAMA, AKTIF, SIRA) VALUES (''GONDERILDI'', ''Gonderildi'', 1, 20)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_TEKLIF_DURUM WHERE KOD = ''KABUL'') ' +
    'INSERT INTO dbo.CRM_TEKLIF_DURUM (KOD, ACIKLAMA, AKTIF, SIRA) VALUES (''KABUL'', ''Kabul'', 1, 30)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_TEKLIF_DURUM WHERE KOD = ''RED'') ' +
    'INSERT INTO dbo.CRM_TEKLIF_DURUM (KOD, ACIKLAMA, AKTIF, SIRA) VALUES (''RED'', ''Red'', 1, 40)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_TEKLIF_DURUM WHERE KOD = ''IPTAL'') ' +
    'INSERT INTO dbo.CRM_TEKLIF_DURUM (KOD, ACIKLAMA, AKTIF, SIRA) VALUES (''IPTAL'', ''Iptal'', 1, 50)');

  if CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.columns WHERE object_id = OBJECT_ID(''dbo.CRM_TEKLIF'') AND name = ''TEKLIF_DURUM_ID''') = 0 then
    CrmExec(AConn, 'ALTER TABLE dbo.CRM_TEKLIF ADD TEKLIF_DURUM_ID BIGINT NULL');

  CrmExec(AConn,
    'UPDATE t SET t.TEKLIF_DURUM_ID = d.TEKLIF_DURUM_ID FROM dbo.CRM_TEKLIF t ' +
    'INNER JOIN dbo.CRM_TEKLIF_DURUM d ON d.KOD = t.DURUM WHERE t.TEKLIF_DURUM_ID IS NULL');

  CrmExec(AConn,
    'UPDATE t SET t.TEKLIF_DURUM_ID = (SELECT TOP 1 TEKLIF_DURUM_ID FROM dbo.CRM_TEKLIF_DURUM WHERE KOD = ''TASLAK'') ' +
    'FROM dbo.CRM_TEKLIF t WHERE t.TEKLIF_DURUM_ID IS NULL');

  CrmExec(AConn, 'ALTER TABLE dbo.CRM_TEKLIF ALTER COLUMN TEKLIF_DURUM_ID BIGINT NOT NULL');

  if CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.foreign_keys WHERE name = ''FK_CRM_TEKLIF_TEKLIF_DURUM'' AND parent_object_id = OBJECT_ID(''dbo.CRM_TEKLIF'')') = 0 then
    CrmExec(AConn,
      'ALTER TABLE dbo.CRM_TEKLIF ADD CONSTRAINT FK_CRM_TEKLIF_TEKLIF_DURUM FOREIGN KEY (TEKLIF_DURUM_ID) ' +
      'REFERENCES dbo.CRM_TEKLIF_DURUM (TEKLIF_DURUM_ID)');

  if CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.tables WHERE name = ''FormName'' AND schema_id = SCHEMA_ID(''dbo'')') > 0 then
  begin
    CrmExec(AConn,
      'INSERT INTO dbo.FormName (FormName, FormCaption) SELECT v.FN, v.FC FROM (VALUES ' +
      '(''CrmParamTeklifDurum'', ''CRM - Teklif Durumlari'')) AS v(FN, FC) ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.FormName f WHERE f.FormName = v.FN)');
    CrmExec(AConn,
      'UPDATE dbo.FormName SET FormCaption = N''CRM - Teklif Durumlar'' + NCHAR(305) WHERE FormName = ''CrmParamTeklifDurum''');
  end;

  if (CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.tables WHERE name = ''YETKI'' AND schema_id = SCHEMA_ID(''dbo'')') > 0) and
     (CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.tables WHERE name = ''KULLANICIGRUP'' AND schema_id = SCHEMA_ID(''dbo'')') > 0) then
  begin
    CrmExec(AConn,
      'INSERT INTO dbo.YETKI (KullaniciGrupID, FormName, Gor, Sil, Degistir, Kaydet) ' +
      'SELECT g.KullaniciGrupID, ''CrmParamTeklifDurum'', 1, 1, 1, 1 FROM dbo.KULLANICIGRUP g ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.YETKI y WHERE y.KullaniciGrupID = g.KullaniciGrupID AND y.FormName = ''CrmParamTeklifDurum'')');
  end;

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_SCHEMA_GECMIS WHERE SURUM_NO = 5) ' +
    'INSERT INTO dbo.CRM_SCHEMA_GECMIS (SURUM_NO, ACIKLAMA) VALUES (5, ''CRM teklif durum parametre tablosu ve FK'')');
end;

procedure CrmSchemaApplyMigration6(AConn: TUniConnection);
begin
  if CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.tables WHERE name = ''FormName'' AND schema_id = SCHEMA_ID(''dbo'')') > 0 then
  begin
    CrmExec(AConn,
      'INSERT INTO dbo.FormName (FormName, FormCaption) SELECT v.FN, v.FC FROM (VALUES ' +
      '(''CrmCariOzet'', ''CRM - Cari Ozeti'')) AS v(FN, FC) ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.FormName f WHERE f.FormName = v.FN)');
    CrmExec(AConn,
      'UPDATE dbo.FormName SET FormCaption = N''CRM - Cari '' + NCHAR(214) + N''zeti'' WHERE FormName = ''CrmCariOzet''');
  end;

  if (CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.tables WHERE name = ''YETKI'' AND schema_id = SCHEMA_ID(''dbo'')') > 0) and
     (CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.tables WHERE name = ''KULLANICIGRUP'' AND schema_id = SCHEMA_ID(''dbo'')') > 0) then
  begin
    CrmExec(AConn,
      'INSERT INTO dbo.YETKI (KullaniciGrupID, FormName, Gor, Sil, Degistir, Kaydet) ' +
      'SELECT g.KullaniciGrupID, ''CrmCariOzet'', 1, 1, 1, 1 FROM dbo.KULLANICIGRUP g ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.YETKI y WHERE y.KullaniciGrupID = g.KullaniciGrupID AND y.FormName = ''CrmCariOzet'')');
  end;

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_SCHEMA_GECMIS WHERE SURUM_NO = 6) ' +
    'INSERT INTO dbo.CRM_SCHEMA_GECMIS (SURUM_NO, ACIKLAMA) VALUES (6, ''CRM cari bazli aktivite ve teklif ozet ekrani (FormName, YETKI)'')');
end;

procedure CrmSchemaApplyMigration7(AConn: TUniConnection);
begin
  if CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.columns WHERE object_id = OBJECT_ID(''dbo.CRM_TEKLIF'') AND name = ''TEKLIF_NO''') = 0 then
    CrmExec(AConn,
      'ALTER TABLE dbo.CRM_TEKLIF ADD TEKLIF_NO VARCHAR(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL');

  CrmExec(AConn,
    'UPDATE dbo.CRM_TEKLIF SET TEKLIF_NO = ''TKL-'' + CONVERT(VARCHAR(4), YEAR(TEKLIF_TARIHI)) + ''-'' + CONVERT(VARCHAR(20), TEKLIF_ID) ' +
    'WHERE TEKLIF_NO IS NULL OR LTRIM(RTRIM(TEKLIF_NO)) = ''''');

  if CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.indexes WHERE name = ''UQ_CRM_TEKLIF_NO'' AND object_id = OBJECT_ID(''dbo.CRM_TEKLIF'')') = 0 then
    CrmExec(AConn,
      'CREATE UNIQUE INDEX UQ_CRM_TEKLIF_NO ON dbo.CRM_TEKLIF (TEKLIF_NO) ' +
      'WHERE TEKLIF_NO IS NOT NULL');

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_SCHEMA_GECMIS WHERE SURUM_NO = 7) ' +
    'INSERT INTO dbo.CRM_SCHEMA_GECMIS (SURUM_NO, ACIKLAMA) VALUES (7, ''CRM teklif gorunur belge numarasi TEKLIF_NO'')');
end;

procedure CrmSchemaApplyMigration8(AConn: TUniConnection);
begin
  if CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.columns WHERE object_id = OBJECT_ID(''dbo.CRM_AKTIVITE'') AND name = ''TEKLIF_ID''') = 0 then
    CrmExec(AConn, 'ALTER TABLE dbo.CRM_AKTIVITE ADD TEKLIF_ID BIGINT NULL');

  if CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.indexes WHERE name = ''IX_CRM_AKT_TEKLIF'' AND object_id = OBJECT_ID(''dbo.CRM_AKTIVITE'')') = 0 then
    CrmExec(AConn,
      'CREATE INDEX IX_CRM_AKT_TEKLIF ON dbo.CRM_AKTIVITE (TEKLIF_ID)');

  if CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.foreign_keys WHERE name = ''FK_CRM_AKTIVITE_TEKLIF'' AND parent_object_id = OBJECT_ID(''dbo.CRM_AKTIVITE'')') = 0 then
    CrmExec(AConn,
      'ALTER TABLE dbo.CRM_AKTIVITE ADD CONSTRAINT FK_CRM_AKTIVITE_TEKLIF FOREIGN KEY (TEKLIF_ID) ' +
      'REFERENCES dbo.CRM_TEKLIF (TEKLIF_ID) ON DELETE SET NULL');

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_SCHEMA_GECMIS WHERE SURUM_NO = 8) ' +
    'INSERT INTO dbo.CRM_SCHEMA_GECMIS (SURUM_NO, ACIKLAMA) VALUES (8, ''CRM aktivite istege bagli TEKLIF_ID baglantisi'')');
end;

procedure CrmSchemaApplyMigration9(AConn: TUniConnection);
begin
  if CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.columns WHERE object_id = OBJECT_ID(''dbo.CRM_TEKLIF'') AND name = ''SIPARIS_NO''') = 0 then
    CrmExec(AConn,
      'ALTER TABLE dbo.CRM_TEKLIF ADD SIPARIS_NO VARCHAR(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL');

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_SCHEMA_GECMIS WHERE SURUM_NO = 9) ' +
    'INSERT INTO dbo.CRM_SCHEMA_GECMIS (SURUM_NO, ACIKLAMA) VALUES (9, ''CRM teklif ERP siparis referansi SIPARIS_NO'')');
end;

procedure CrmSchemaApplyMigration10(AConn: TUniConnection);
begin
  if CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.columns WHERE object_id = OBJECT_ID(''dbo.CRM_AKTIVITE'') AND name = ''SIPARIS_NO''') = 0 then
    CrmExec(AConn,
      'ALTER TABLE dbo.CRM_AKTIVITE ADD SIPARIS_NO VARCHAR(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL');

  if CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.indexes WHERE name = ''IX_CRM_AKT_SIPARIS'' AND object_id = OBJECT_ID(''dbo.CRM_AKTIVITE'')') = 0 then
    CrmExec(AConn,
      'CREATE INDEX IX_CRM_AKT_SIPARIS ON dbo.CRM_AKTIVITE (SIPARIS_NO)');

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_SCHEMA_GECMIS WHERE SURUM_NO = 10) ' +
    'INSERT INTO dbo.CRM_SCHEMA_GECMIS (SURUM_NO, ACIKLAMA) VALUES (10, ''CRM aktivite ERP siparis referansi SIPARIS_NO'')');
end;

procedure CrmSchemaApplyMigration11(AConn: TUniConnection);
begin
  CrmExec(AConn,
    'IF OBJECT_ID(''dbo.CRM_POTANSIYEL_DURUM'',''U'') IS NULL ' +
    'CREATE TABLE dbo.CRM_POTANSIYEL_DURUM (' +
    'POTANSIYEL_DURUM_ID BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_CRM_POTANSIYEL_DURUM PRIMARY KEY, ' +
    'KOD VARCHAR(30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, ' +
    'ACIKLAMA VARCHAR(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'AKTIF BIT NOT NULL CONSTRAINT DF_CRM_POTDUR_AKTIF DEFAULT (1), ' +
    'SIRA INT NOT NULL CONSTRAINT DF_CRM_POTDUR_SIRA DEFAULT (0), ' +
    'CONSTRAINT UQ_CRM_POTANSIYEL_DURUM_KOD UNIQUE (KOD) )');

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = ''IX_CRM_POTDUR_AKT_SIRA'' AND object_id = OBJECT_ID(''dbo.CRM_POTANSIYEL_DURUM'')) ' +
    'CREATE INDEX IX_CRM_POTDUR_AKT_SIRA ON dbo.CRM_POTANSIYEL_DURUM (AKTIF, SIRA)');

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_POTANSIYEL_DURUM WHERE KOD = ''YENI'') ' +
    'INSERT INTO dbo.CRM_POTANSIYEL_DURUM (KOD, ACIKLAMA, AKTIF, SIRA) VALUES (''YENI'', ''Yeni / Ilk kontak'', 1, 10)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_POTANSIYEL_DURUM WHERE KOD = ''ILETISIM'') ' +
    'INSERT INTO dbo.CRM_POTANSIYEL_DURUM (KOD, ACIKLAMA, AKTIF, SIRA) VALUES (''ILETISIM'', ''Iletisim suruyor'', 1, 20)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_POTANSIYEL_DURUM WHERE KOD = ''TEKLIF_ASAMASI'') ' +
    'INSERT INTO dbo.CRM_POTANSIYEL_DURUM (KOD, ACIKLAMA, AKTIF, SIRA) VALUES (''TEKLIF_ASAMASI'', ''Teklif asamasinda'', 1, 30)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_POTANSIYEL_DURUM WHERE KOD = ''MUZAKERE'') ' +
    'INSERT INTO dbo.CRM_POTANSIYEL_DURUM (KOD, ACIKLAMA, AKTIF, SIRA) VALUES (''MUZAKERE'', ''Muzakere / pazarlik'', 1, 40)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_POTANSIYEL_DURUM WHERE KOD = ''KAZANILDI'') ' +
    'INSERT INTO dbo.CRM_POTANSIYEL_DURUM (KOD, ACIKLAMA, AKTIF, SIRA) VALUES (''KAZANILDI'', ''Kazanildi (satis otesi: Netsis bagla)'', 1, 50)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_POTANSIYEL_DURUM WHERE KOD = ''KAYBEDILDI'') ' +
    'INSERT INTO dbo.CRM_POTANSIYEL_DURUM (KOD, ACIKLAMA, AKTIF, SIRA) VALUES (''KAYBEDILDI'', ''Kaybedildi / uygun degil'', 1, 60)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_POTANSIYEL_DURUM WHERE KOD = ''NETSIS_BAGLI'') ' +
    'INSERT INTO dbo.CRM_POTANSIYEL_DURUM (KOD, ACIKLAMA, AKTIF, SIRA) VALUES (''NETSIS_BAGLI'', ''Netsis cari ile baglandi'', 1, 70)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_POTANSIYEL_DURUM WHERE KOD = ''PASIF'') ' +
    'INSERT INTO dbo.CRM_POTANSIYEL_DURUM (KOD, ACIKLAMA, AKTIF, SIRA) VALUES (''PASIF'', ''Pasif / takip disi'', 1, 90)');

  CrmExec(AConn,
    'IF OBJECT_ID(''dbo.CRM_POTANSIYEL_MUSTERI'',''U'') IS NULL ' +
    'CREATE TABLE dbo.CRM_POTANSIYEL_MUSTERI (' +
    'POTANSIYEL_ID BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_CRM_POTANSIYEL_MUSTERI PRIMARY KEY, ' +
    'FIRMA_UNVAN VARCHAR(250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, ' +
    'KISA_AD VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'MUSTERI_TIPI VARCHAR(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT DF_CRM_POT_TIP DEFAULT (''KURUMSAL''), ' +
    'VERGI_DAIRESI VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'VERGI_NO VARCHAR(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'TC_KIMLIK_NO VARCHAR(11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'MERSIS_NO VARCHAR(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'NETSIS_CARI_KOD VARCHAR(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'NETSIS_BAGLANTI_UTC DATETIME2(3) NULL, ' +
    'ULKE VARCHAR(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'IL VARCHAR(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'ILCE VARCHAR(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'POSTA_KODU VARCHAR(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'ADRES VARCHAR(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'TELEFON_SABIT VARCHAR(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'TELEFON_CEPTEL VARCHAR(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'TELEFON2 VARCHAR(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'FAKS VARCHAR(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'EPOSTA VARCHAR(120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'WEB VARCHAR(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'YETKILI_AD_SOYAD VARCHAR(120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'YETKILI_UNVAN VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'YETKILI_EPOSTA VARCHAR(120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'YETKILI_TEL VARCHAR(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'MUHASEBE_YETKILI_AD VARCHAR(120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'MUHASEBE_TEL VARCHAR(40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'MUHASEBE_EPOSTA VARCHAR(120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'SEKTOR VARCHAR(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'FAALIYET_KONUSU VARCHAR(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'CALISAN_SAYISI INT NULL, ' +
    'TAHMINI_YILLIK_CIRO DECIMAL(18,2) NULL, ' +
    'PARA_BIRIMI VARCHAR(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT DF_CRM_POT_PB DEFAULT (''TRY''), ' +
    'KAYNAK VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'POTANSIYEL_DURUM_ID BIGINT NOT NULL, ' +
    'ILK_ILETISIM_TARIHI DATE NULL, ' +
    'SON_TAKIP_TARIHI DATE NULL, ' +
    'SONRAKI_AKSYON_TARIHI DATE NULL, ' +
    'NOTLAR VARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'OLUSTURAN_KULLANICI_ID INT NULL, ' +
    'OLUSTURMA_UTC DATETIME2(3) NOT NULL CONSTRAINT DF_CRM_POT_OLU DEFAULT (SYSUTCDATETIME()), ' +
    'GUNCELLEME_UTC DATETIME2(3) NULL, ' +
    'CONSTRAINT FK_CRM_POT_POTDUR FOREIGN KEY (POTANSIYEL_DURUM_ID) REFERENCES dbo.CRM_POTANSIYEL_DURUM (POTANSIYEL_DURUM_ID), ' +
    'CONSTRAINT CK_CRM_POT_MUSTIP CHECK (MUSTERI_TIPI IN (''KURUMSAL'', ''BIREYSEL'')) )');

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = ''IX_CRM_POT_NETSIS'' AND object_id = OBJECT_ID(''dbo.CRM_POTANSIYEL_MUSTERI'')) ' +
    'CREATE INDEX IX_CRM_POT_NETSIS ON dbo.CRM_POTANSIYEL_MUSTERI (NETSIS_CARI_KOD)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = ''IX_CRM_POT_DURUM'' AND object_id = OBJECT_ID(''dbo.CRM_POTANSIYEL_MUSTERI'')) ' +
    'CREATE INDEX IX_CRM_POT_DURUM ON dbo.CRM_POTANSIYEL_MUSTERI (POTANSIYEL_DURUM_ID)');
  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = ''IX_CRM_POT_UNVAN'' AND object_id = OBJECT_ID(''dbo.CRM_POTANSIYEL_MUSTERI'')) ' +
    'CREATE INDEX IX_CRM_POT_UNVAN ON dbo.CRM_POTANSIYEL_MUSTERI (FIRMA_UNVAN)');

  if CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.tables WHERE name = ''FormName'' AND schema_id = SCHEMA_ID(''dbo'')') > 0 then
  begin
    CrmExec(AConn,
      'INSERT INTO dbo.FormName (FormName, FormCaption) SELECT v.FN, v.FC FROM (VALUES ' +
      '(''CrmYeniPotansiyel'', ''CRM - Potansiyel Musteri''), (''CrmPotansiyelListesi'', ''CRM - Potansiyel Musteri Listesi''), ' +
      '(''CrmParamPotansiyelDurum'', ''CRM - Potansiyel Durumlari'')) AS v(FN, FC) ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.FormName f WHERE f.FormName = v.FN)');
    CrmExec(AConn,
      'UPDATE dbo.FormName SET FormCaption = N''CRM - Potansiyel Durumlar'' + NCHAR(305) ' +
      'WHERE FormName = ''CrmParamPotansiyelDurum''');
  end;

  if (CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.tables WHERE name = ''YETKI'' AND schema_id = SCHEMA_ID(''dbo'')') > 0) and
     (CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.tables WHERE name = ''KULLANICIGRUP'' AND schema_id = SCHEMA_ID(''dbo'')') > 0) then
  begin
    CrmExec(AConn,
      'INSERT INTO dbo.YETKI (KullaniciGrupID, FormName, Gor, Sil, Degistir, Kaydet) ' +
      'SELECT g.KullaniciGrupID, ''CrmYeniPotansiyel'', 1, 1, 1, 1 FROM dbo.KULLANICIGRUP g ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.YETKI y WHERE y.KullaniciGrupID = g.KullaniciGrupID AND y.FormName = ''CrmYeniPotansiyel'')');
    CrmExec(AConn,
      'INSERT INTO dbo.YETKI (KullaniciGrupID, FormName, Gor, Sil, Degistir, Kaydet) ' +
      'SELECT g.KullaniciGrupID, ''CrmPotansiyelListesi'', 1, 1, 1, 1 FROM dbo.KULLANICIGRUP g ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.YETKI y WHERE y.KullaniciGrupID = g.KullaniciGrupID AND y.FormName = ''CrmPotansiyelListesi'')');
    CrmExec(AConn,
      'INSERT INTO dbo.YETKI (KullaniciGrupID, FormName, Gor, Sil, Degistir, Kaydet) ' +
      'SELECT g.KullaniciGrupID, ''CrmParamPotansiyelDurum'', 1, 1, 1, 1 FROM dbo.KULLANICIGRUP g ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.YETKI y WHERE y.KullaniciGrupID = g.KullaniciGrupID AND y.FormName = ''CrmParamPotansiyelDurum'')');
  end;

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_SCHEMA_GECMIS WHERE SURUM_NO = 11) ' +
    'INSERT INTO dbo.CRM_SCHEMA_GECMIS (SURUM_NO, ACIKLAMA) VALUES (11, ''CRM potansiyel musteri ve Netsis cari baglanti'')');
end;

procedure CrmSchemaApplyMigration12(AConn: TUniConnection);
begin
  if CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.columns WHERE object_id = OBJECT_ID(''dbo.CRM_POTANSIYEL_MUSTERI'') AND name = ''GPS_ENLEM''') = 0 then
    CrmExec(AConn,
      'ALTER TABLE dbo.CRM_POTANSIYEL_MUSTERI ADD GPS_ENLEM DECIMAL(10,7) NULL, ' +
      'GPS_BOYLAM DECIMAL(10,7) NULL, ' +
      'HARITA_FORMATLI_ADRES VARCHAR(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL');

  CrmExec(AConn,
    'IF OBJECT_ID(''dbo.CRM_CARI_LOKASYON'',''U'') IS NULL ' +
    'CREATE TABLE dbo.CRM_CARI_LOKASYON (' +
    'CARI_KOD VARCHAR(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT PK_CRM_CARI_LOK PRIMARY KEY, ' +
    'GPS_ENLEM DECIMAL(10,7) NULL, ' +
    'GPS_BOYLAM DECIMAL(10,7) NULL, ' +
    'HARITA_FORMATLI_ADRES VARCHAR(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'IL VARCHAR(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'ILCE VARCHAR(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'GUNCELLEME_UTC DATETIME2(3) NULL)');

  CrmExec(AConn,
    'IF OBJECT_ID(''dbo.CRM_ROTA_PLAN'',''U'') IS NULL ' +
    'CREATE TABLE dbo.CRM_ROTA_PLAN (' +
    'ROTA_ID BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_CRM_ROTA_PLAN PRIMARY KEY, ' +
    'BASLIK VARCHAR(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, ' +
    'DETAY VARCHAR(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'BASLANGIC_ENLEM DECIMAL(10,7) NULL, ' +
    'BASLANGIC_BOYLAM DECIMAL(10,7) NULL, ' +
    'BASLANGIC_ADRES VARCHAR(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'BITIS_ENLEM DECIMAL(10,7) NULL, ' +
    'BITIS_BOYLAM DECIMAL(10,7) NULL, ' +
    'BITIS_ADRES VARCHAR(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'ESIK_KM INT NOT NULL CONSTRAINT DF_CRM_ROTA_ESIK DEFAULT (80), ' +
    'PLANLAMA_TARIHI DATE NULL, ' +
    'DURUM VARCHAR(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT DF_CRM_ROTA_DUR DEFAULT (''TASLAK''), ' +
    'OLUSTURAN_KULLANICI_ID INT NULL, ' +
    'OLUSTURMA_UTC DATETIME2(3) NOT NULL CONSTRAINT DF_CRM_ROTA_OLU DEFAULT (SYSUTCDATETIME()), ' +
    'GUNCELLEME_UTC DATETIME2(3) NULL, ' +
    'CONSTRAINT CK_CRM_ROTA_DURUM CHECK (DURUM IN (''TASLAK'', ''ONAYLI'', ''IPTAL'')) )');

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = ''IX_CRM_ROTA_PLAN_TAR'' AND object_id = OBJECT_ID(''dbo.CRM_ROTA_PLAN'')) ' +
    'CREATE INDEX IX_CRM_ROTA_PLAN_TAR ON dbo.CRM_ROTA_PLAN (PLANLAMA_TARIHI)');

  CrmExec(AConn,
    'IF OBJECT_ID(''dbo.CRM_ROTA_PLAN_DURAK'',''U'') IS NULL ' +
    'CREATE TABLE dbo.CRM_ROTA_PLAN_DURAK (' +
    'DURAK_ID BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_CRM_ROTA_DURAK PRIMARY KEY, ' +
    'ROTA_ID BIGINT NOT NULL, ' +
    'SIRA INT NOT NULL, ' +
    'DURAK_TIP CHAR(1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL, ' +
    'NETSIS_CARI_KOD VARCHAR(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'POTANSIYEL_ID BIGINT NULL, ' +
    'UNVAN_SNAPSHOT VARCHAR(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'IL_SNAPSHOT VARCHAR(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'ILCE_SNAPSHOT VARCHAR(80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'ADRES_SNAPSHOT VARCHAR(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'GPS_ENLEM DECIMAL(10,7) NULL, ' +
    'GPS_BOYLAM DECIMAL(10,7) NULL, ' +
    'UYARI_METNI VARCHAR(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, ' +
    'CONSTRAINT FK_CRM_ROTA_DURAK_ROTA FOREIGN KEY (ROTA_ID) REFERENCES dbo.CRM_ROTA_PLAN (ROTA_ID) ON DELETE CASCADE, ' +
    'CONSTRAINT CK_CRM_ROTA_DURAK_TIP CHECK (DURAK_TIP IN (''C'', ''P'')), ' +
    'CONSTRAINT CK_CRM_ROTA_DURAK_REF CHECK ( ' +
    '(DURAK_TIP = ''C'' AND NETSIS_CARI_KOD IS NOT NULL AND POTANSIYEL_ID IS NULL) OR ' +
    '(DURAK_TIP = ''P'' AND POTANSIYEL_ID IS NOT NULL AND NETSIS_CARI_KOD IS NULL) ) )');

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = ''IX_CRM_ROTA_DURAK_ROTA'' AND object_id = OBJECT_ID(''dbo.CRM_ROTA_PLAN_DURAK'')) ' +
    'CREATE INDEX IX_CRM_ROTA_DURAK_ROTA ON dbo.CRM_ROTA_PLAN_DURAK (ROTA_ID, SIRA)');

  if CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.tables WHERE name = ''FormName'' AND schema_id = SCHEMA_ID(''dbo'')') > 0 then
  begin
    CrmExec(AConn,
      'INSERT INTO dbo.FormName (FormName, FormCaption) SELECT v.FN, v.FC FROM (VALUES ' +
      '(''CrmRotaListesi'', ''CRM - Rota planlama listesi''), (''CrmRotaPlan'', ''CRM - Rota plani''), ' +
      '(''CrmHaritaSec'', ''CRM - Haritadan konum sec''), (''CrmRotaHarita'', ''CRM - Rota haritasi'')) AS v(FN, FC) ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.FormName f WHERE f.FormName = v.FN)');
  end;

  if (CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.tables WHERE name = ''YETKI'' AND schema_id = SCHEMA_ID(''dbo'')') > 0) and
     (CrmScalarInt(AConn,
    'SELECT COUNT(*) FROM sys.tables WHERE name = ''KULLANICIGRUP'' AND schema_id = SCHEMA_ID(''dbo'')') > 0) then
  begin
    CrmExec(AConn,
      'INSERT INTO dbo.YETKI (KullaniciGrupID, FormName, Gor, Sil, Degistir, Kaydet) ' +
      'SELECT g.KullaniciGrupID, ''CrmRotaListesi'', 1, 1, 1, 1 FROM dbo.KULLANICIGRUP g ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.YETKI y WHERE y.KullaniciGrupID = g.KullaniciGrupID AND y.FormName = ''CrmRotaListesi'')');
    CrmExec(AConn,
      'INSERT INTO dbo.YETKI (KullaniciGrupID, FormName, Gor, Sil, Degistir, Kaydet) ' +
      'SELECT g.KullaniciGrupID, ''CrmRotaPlan'', 1, 1, 1, 1 FROM dbo.KULLANICIGRUP g ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.YETKI y WHERE y.KullaniciGrupID = g.KullaniciGrupID AND y.FormName = ''CrmRotaPlan'')');
    CrmExec(AConn,
      'INSERT INTO dbo.YETKI (KullaniciGrupID, FormName, Gor, Sil, Degistir, Kaydet) ' +
      'SELECT g.KullaniciGrupID, ''CrmHaritaSec'', 1, 1, 1, 1 FROM dbo.KULLANICIGRUP g ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.YETKI y WHERE y.KullaniciGrupID = g.KullaniciGrupID AND y.FormName = ''CrmHaritaSec'')');
    CrmExec(AConn,
      'INSERT INTO dbo.YETKI (KullaniciGrupID, FormName, Gor, Sil, Degistir, Kaydet) ' +
      'SELECT g.KullaniciGrupID, ''CrmRotaHarita'', 1, 1, 1, 1 FROM dbo.KULLANICIGRUP g ' +
      'WHERE NOT EXISTS (SELECT 1 FROM dbo.YETKI y WHERE y.KullaniciGrupID = g.KullaniciGrupID AND y.FormName = ''CrmRotaHarita'')');
  end;

  CrmExec(AConn,
    'IF NOT EXISTS (SELECT 1 FROM dbo.CRM_SCHEMA_GECMIS WHERE SURUM_NO = 12) ' +
    'INSERT INTO dbo.CRM_SCHEMA_GECMIS (SURUM_NO, ACIKLAMA) VALUES (12, ''CRM rota planlama, cari lokasyon, potansiyel GPS'')');
end;

procedure CrmSchemaApplyMigration(const AConn: TUniConnection; AVersion: Integer);
begin
  case AVersion of
    1: CrmSchemaApplyMigration1(AConn);
    2: CrmSchemaApplyMigration2(AConn);
    3: CrmSchemaApplyMigration3(AConn);
    4: CrmSchemaApplyMigration4(AConn);
    5: CrmSchemaApplyMigration5(AConn);
    6: CrmSchemaApplyMigration6(AConn);
    7: CrmSchemaApplyMigration7(AConn);
    8: CrmSchemaApplyMigration8(AConn);
    9: CrmSchemaApplyMigration9(AConn);
    10: CrmSchemaApplyMigration10(AConn);
    11: CrmSchemaApplyMigration11(AConn);
    12: CrmSchemaApplyMigration12(AConn);
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
