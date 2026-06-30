/*
  CRM test verilerini temizleme scripti
  Veritabani: ASYA_ENTEGRE (conAsya)

  SILINIR:
    - Aktivite, gorev, ekler, loglar, kontrol listesi cevaplari
    - Rota planlari (duraklar, personel atamalari)
    - Teklifler ve satirlari
    - Potansiyel musteriler
    - Cari GPS lokasyon kayitlari (CRM_CARI_LOKASYON)

  SILINMEZ (parametre / seed):
    - CRM_SCHEMA_GECMIS
    - CRM_AKTIVITE_TIP, CRM_AKTIVITE_DURUM
    - CRM_TEKLIF_DURUM, CRM_POTANSIYEL_DURUM
    - CRM_BAGLANTI_DURUM_KURAL
    - PARAMETRE tablosu
    - Netsis cari verileri (YUCEL..HV_CARI_LISTESI vb.)

  Opsiyonel B bolumu: ornek/test soru setlerini de siler.

  ONEMLI: Once yedek alin. Ilk calistirmada COMMIT yerine ROLLBACK kullanarak
  dry-run yapabilirsiniz (asagidaki COMMIT satirini yorumlayin).
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

-- USE ASYA_ENTEGRE;
GO

BEGIN TRANSACTION;

DECLARE @n INT;

PRINT '=== CRM test veri temizligi basladi ===';
PRINT CONVERT(VARCHAR(30), GETDATE(), 120);

SELECT @n = COUNT(*) FROM dbo.CRM_AKTIVITE;
PRINT 'CRM_AKTIVITE (once): ' + CAST(@n AS VARCHAR(20));

SELECT @n = COUNT(*) FROM dbo.CRM_GOREV;
PRINT 'CRM_GOREV (once): ' + CAST(@n AS VARCHAR(20));

SELECT @n = COUNT(*) FROM dbo.CRM_ROTA_PLAN;
PRINT 'CRM_ROTA_PLAN (once): ' + CAST(@n AS VARCHAR(20));

SELECT @n = COUNT(*) FROM dbo.CRM_TEKLIF;
PRINT 'CRM_TEKLIF (once): ' + CAST(@n AS VARCHAR(20));

SELECT @n = COUNT(*) FROM dbo.CRM_POTANSIYEL_MUSTERI;
PRINT 'CRM_POTANSIYEL_MUSTERI (once): ' + CAST(@n AS VARCHAR(20));

SELECT @n = COUNT(*) FROM dbo.CRM_CARI_LOKASYON;
PRINT 'CRM_CARI_LOKASYON (once): ' + CAST(@n AS VARCHAR(20));

PRINT '';

/* ------------------------------------------------------------------
   1) Aktivite / gorev ve bagli kayitlar
   (CRM_GOREV, CRM_AKTIVITE_EK, CRM_AKTIVITE_DEGISIM_LOG,
    CRM_AKTIVITE_CEVAP, CRM_AKTIVITE_CEVAP_SECENEK -> CASCADE)
   ------------------------------------------------------------------ */
IF OBJECT_ID(N'dbo.CRM_AKTIVITE', N'U') IS NOT NULL
BEGIN
  DELETE FROM dbo.CRM_AKTIVITE;
  PRINT 'CRM_AKTIVITE ve bagli kayitlar silindi.';
END;

/* ------------------------------------------------------------------
   2) Rota planlari (durak + personel CASCADE)
   ------------------------------------------------------------------ */
IF OBJECT_ID(N'dbo.CRM_ROTA_PLAN', N'U') IS NOT NULL
BEGIN
  DELETE FROM dbo.CRM_ROTA_PLAN;
  PRINT 'CRM_ROTA_PLAN ve bagli kayitlar silindi.';
END;

/* ------------------------------------------------------------------
   3) Teklifler (satirlar CASCADE)
   ------------------------------------------------------------------ */
IF OBJECT_ID(N'dbo.CRM_TEKLIF', N'U') IS NOT NULL
BEGIN
  DELETE FROM dbo.CRM_TEKLIF;
  PRINT 'CRM_TEKLIF ve satirlari silindi.';
END;

/* ------------------------------------------------------------------
   4) Potansiyel musteriler
   ------------------------------------------------------------------ */
IF OBJECT_ID(N'dbo.CRM_POTANSIYEL_MUSTERI', N'U') IS NOT NULL
BEGIN
  DELETE FROM dbo.CRM_POTANSIYEL_MUSTERI;
  PRINT 'CRM_POTANSIYEL_MUSTERI silindi.';
END;

/* ------------------------------------------------------------------
   5) Cari GPS lokasyonlari (test koordinatlari)
   ------------------------------------------------------------------ */
IF OBJECT_ID(N'dbo.CRM_CARI_LOKASYON', N'U') IS NOT NULL
BEGIN
  DELETE FROM dbo.CRM_CARI_LOKASYON;
  PRINT 'CRM_CARI_LOKASYON silindi.';
END;

/* ------------------------------------------------------------------
   OPSIYONEL B: Test / ornek soru setleri
   (CRM_SORU, CRM_SORU_SECENEK, CRM_TIP_SORU_SETI -> CASCADE)
   Parametre tipleri ve durumlar korunur; sadece soru setleri gider.
   Istemezseniz asagidaki blogu yorum satiri yapin.
   ------------------------------------------------------------------ */
IF OBJECT_ID(N'dbo.CRM_SORU_SETI', N'U') IS NOT NULL
BEGIN
  DELETE FROM dbo.CRM_SORU_SETI;
  PRINT 'CRM_SORU_SETI ve bagli sorular silindi (opsiyonel).';
END;

PRINT '';
PRINT '=== Silme sonrasi kayit sayilari ===';

SELECT @n = COUNT(*) FROM dbo.CRM_AKTIVITE;
PRINT 'CRM_AKTIVITE (sonra): ' + CAST(@n AS VARCHAR(20));

SELECT @n = COUNT(*) FROM dbo.CRM_GOREV;
PRINT 'CRM_GOREV (sonra): ' + CAST(@n AS VARCHAR(20));

SELECT @n = COUNT(*) FROM dbo.CRM_ROTA_PLAN;
PRINT 'CRM_ROTA_PLAN (sonra): ' + CAST(@n AS VARCHAR(20));

SELECT @n = COUNT(*) FROM dbo.CRM_TEKLIF;
PRINT 'CRM_TEKLIF (sonra): ' + CAST(@n AS VARCHAR(20));

SELECT @n = COUNT(*) FROM dbo.CRM_POTANSIYEL_MUSTERI;
PRINT 'CRM_POTANSIYEL_MUSTERI (sonra): ' + CAST(@n AS VARCHAR(20));

SELECT @n = COUNT(*) FROM dbo.CRM_CARI_LOKASYON;
PRINT 'CRM_CARI_LOKASYON (sonra): ' + CAST(@n AS VARCHAR(20));

IF OBJECT_ID(N'dbo.CRM_SORU_SETI', N'U') IS NOT NULL
BEGIN
  SELECT @n = COUNT(*) FROM dbo.CRM_SORU_SETI;
  PRINT 'CRM_SORU_SETI (sonra): ' + CAST(@n AS VARCHAR(20));
END;

PRINT '';
PRINT '=== Kimlik (IDENTITY) sifirlama (opsiyonel) ===';
PRINT 'Asagidaki RESEED blogunu acarsaniz yeni kayitlar 1''den baslar.';

/*
DBCC CHECKIDENT ('dbo.CRM_AKTIVITE', RESEED, 0);
DBCC CHECKIDENT ('dbo.CRM_GOREV', RESEED, 0);
DBCC CHECKIDENT ('dbo.CRM_ROTA_PLAN', RESEED, 0);
DBCC CHECKIDENT ('dbo.CRM_ROTA_PLAN_DURAK', RESEED, 0);
DBCC CHECKIDENT ('dbo.CRM_TEKLIF', RESEED, 0);
DBCC CHECKIDENT ('dbo.CRM_TEKLIF_SATIR', RESEED, 0);
DBCC CHECKIDENT ('dbo.CRM_POTANSIYEL_MUSTERI', RESEED, 0);
DBCC CHECKIDENT ('dbo.CRM_AKTIVITE_DEGISIM_LOG', RESEED, 0);
DBCC CHECKIDENT ('dbo.CRM_AKTIVITE_EK', RESEED, 0);
DBCC CHECKIDENT ('dbo.CRM_SORU_SETI', RESEED, 0);
*/

-- Dry-run icin: COMMIT yerine ROLLBACK kullanin
COMMIT TRANSACTION;
-- ROLLBACK TRANSACTION;

PRINT '=== Tamamlandi ===';
GO
