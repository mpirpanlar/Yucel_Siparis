-- Referans: CRM sema surum 30 (CrmSchemaU.CrmSchemaApplyMigration30).
-- Canlida CrmSchemaU.CrmSchemaApplyMigration30 + CRM_SCHEMA_TARGET_VERSION = 30 ile otomatik uygulanir.

IF COL_LENGTH('dbo.SIPARIS_BASLIK', 'AcikKapaliTarih') IS NULL
  ALTER TABLE dbo.SIPARIS_BASLIK ADD AcikKapaliTarih DATETIME NULL;
