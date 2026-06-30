/*
  CRM surum 34 - Tablo audit log (UPDATE/DELETE trigger).
  Mevcut alan degisiklik logu CRM_AKTIVITE_LOG -> CRM_AKTIVITE_DEGISIM_LOG olarak yeniden adlandirilir.
  Her CRM_* kaynak tablo icin CRM_{Tablo}_Log tablosu ve TR_{Tablo}_Log_UD trigger olusturulur.
  INSERT loglanmaz. _Log ve _DEGISIM_LOG tablolarina trigger konmaz.
*/
SET NOCOUNT ON;

IF OBJECT_ID(N'dbo.CRM_AKTIVITE_LOG', N'U') IS NOT NULL
   AND OBJECT_ID(N'dbo.CRM_AKTIVITE_DEGISIM_LOG', N'U') IS NULL
  EXEC sp_rename N'dbo.CRM_AKTIVITE_LOG', N'CRM_AKTIVITE_DEGISIM_LOG';

IF EXISTS (
  SELECT 1 FROM sys.key_constraints k
  WHERE k.name = N'PK_CRM_AKTIVITE_LOG'
    AND k.parent_object_id = OBJECT_ID(N'dbo.CRM_AKTIVITE_DEGISIM_LOG'))
  EXEC sp_rename N'PK_CRM_AKTIVITE_LOG', N'PK_CRM_AKTIVITE_DEGISIM_LOG', N'OBJECT';

DECLARE @Tbl SYSNAME;
DECLARE @LogTbl SYSNAME;
DECLARE @TrgName SYSNAME;
DECLARE @Sql NVARCHAR(MAX);
DECLARE @ColDefs NVARCHAR(MAX);
DECLARE @InsCols NVARCHAR(MAX);
DECLARE @SelCols NVARCHAR(MAX);

DECLARE cur CURSOR LOCAL FAST_FORWARD FOR
  SELECT t.name
  FROM sys.tables t
  WHERE t.schema_id = SCHEMA_ID(N'dbo')
    AND t.name LIKE N'CRM[_]%' ESCAPE N'\'
    AND t.name NOT LIKE N'%[_]Log' ESCAPE N'\'
    AND t.name NOT LIKE N'%[_]DEGISIM_LOG' ESCAPE N'\'
    AND t.name <> N'CRM_SCHEMA_GECMIS'
  ORDER BY t.name;

OPEN cur;
FETCH NEXT FROM cur INTO @Tbl;

WHILE @@FETCH_STATUS = 0
BEGIN
  SET @LogTbl = @Tbl + N'_Log';
  SET @TrgName = N'TR_' + @Tbl + N'_Log_UD';

  IF OBJECT_ID(N'dbo.' + @LogTbl, N'U') IS NULL
  BEGIN
    SET @ColDefs = N'';
    SELECT @ColDefs = @ColDefs + CASE WHEN @ColDefs = N'' THEN N'' ELSE N', ' END +
      N'[' + c.name + N'] ' +
      CASE
        WHEN t.name IN (N'nvarchar', N'nchar') AND c.max_length < 0 THEN UPPER(t.name) + N'(MAX)'
        WHEN t.name IN (N'nvarchar', N'nchar') THEN UPPER(t.name) + N'(' + CAST(c.max_length / 2 AS VARCHAR(10)) + N')'
        WHEN t.name IN (N'varchar', N'char') AND c.max_length < 0 THEN UPPER(t.name) + N'(MAX)'
        WHEN t.name IN (N'varchar', N'char') THEN UPPER(t.name) + N'(' + CAST(c.max_length AS VARCHAR(10)) + N')'
        WHEN t.name IN (N'varbinary', N'binary') AND c.max_length < 0 THEN UPPER(t.name) + N'(MAX)'
        WHEN t.name IN (N'varbinary', N'binary') THEN UPPER(t.name) + N'(' + CAST(c.max_length AS VARCHAR(10)) + N')'
        WHEN t.name IN (N'decimal', N'numeric') THEN UPPER(t.name) + N'(' + CAST(c.precision AS VARCHAR(10)) + N',' + CAST(c.scale AS VARCHAR(10)) + N')'
        WHEN t.name = N'datetime2' THEN N'DATETIME2(' + CAST(c.scale AS VARCHAR(10)) + N')'
        WHEN t.name = N'datetimeoffset' THEN N'DATETIMEOFFSET(' + CAST(c.scale AS VARCHAR(10)) + N')'
        WHEN t.name = N'time' THEN N'TIME(' + CAST(c.scale AS VARCHAR(10)) + N')'
        ELSE UPPER(t.name)
      END + N' NULL'
    FROM sys.columns c
    INNER JOIN sys.types t ON c.user_type_id = t.user_type_id
    WHERE c.object_id = OBJECT_ID(N'dbo.' + @Tbl)
    ORDER BY c.column_id;

    SET @Sql = N'CREATE TABLE dbo.' + QUOTENAME(@LogTbl) + N' (' +
      N'LOG_ROW_ID BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_AUD_' + @Tbl + N' PRIMARY KEY, ' +
      N'LOG_ACTION CHAR(1) NOT NULL, ' +
      N'LOG_UTC DATETIME2(3) NOT NULL CONSTRAINT DF_AUD_' + @Tbl + N'_UTC DEFAULT (SYSUTCDATETIME()), ' +
      N'LOG_DB_USER SYSNAME NULL, LOG_APP_USER INT NULL, ' + @ColDefs + N')';
    EXEC sp_executesql @Sql;
    PRINT N'Olusturuldu: ' + @LogTbl;
  END;

  SET @InsCols = N'';
  SET @SelCols = N'';
  SELECT @InsCols = @InsCols + CASE WHEN @InsCols = N'' THEN N'' ELSE N', ' END + N'[' + c.name + N']',
         @SelCols = @SelCols + CASE WHEN @SelCols = N'' THEN N'' ELSE N', ' END + N'd.[' + c.name + N']'
  FROM sys.columns c
  WHERE c.object_id = OBJECT_ID(N'dbo.' + @Tbl)
  ORDER BY c.column_id;

  IF @InsCols <> N''
  BEGIN
    SET @Sql = N'IF OBJECT_ID(N''dbo.' + @TrgName + N''', N''TR'') IS NOT NULL DROP TRIGGER dbo.' + QUOTENAME(@TrgName);
    EXEC sp_executesql @Sql;

    SET @Sql = N'CREATE TRIGGER dbo.' + QUOTENAME(@TrgName) + N' ON dbo.' + QUOTENAME(@Tbl) + N' AFTER UPDATE, DELETE AS ' +
      N'BEGIN SET NOCOUNT ON; IF TRIGGER_NESTLEVEL() > 1 RETURN; ' +
      N'INSERT INTO dbo.' + QUOTENAME(@LogTbl) + N' (LOG_ACTION, LOG_DB_USER, LOG_APP_USER, ' + @InsCols + N') ' +
      N'SELECT CASE WHEN EXISTS(SELECT 1 FROM inserted) THEN ''U'' ELSE ''D'' END, ' +
      N'SUSER_SNAME(), TRY_CAST(SESSION_CONTEXT(N''CRM_APP_USER'') AS INT), ' + @SelCols + N' FROM deleted d; END';
    EXEC sp_executesql @Sql;
    PRINT N'Trigger: ' + @TrgName;
  END;

  FETCH NEXT FROM cur INTO @Tbl;
END;

CLOSE cur;
DEALLOCATE cur;

IF OBJECT_ID(N'dbo.CRM_SCHEMA_GECMIS', N'U') IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM dbo.CRM_SCHEMA_GECMIS WHERE SURUM_NO = 34)
  INSERT INTO dbo.CRM_SCHEMA_GECMIS (SURUM_NO, ACIKLAMA)
  VALUES (34, N'CRM tablo audit: DEGISIM_LOG rename + CRM_*_Log trigger');

PRINT N'CRM surum 34 audit tamamlandi.';
