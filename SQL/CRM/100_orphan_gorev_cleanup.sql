/*
  CRM yetim gorev / aktivite ve rota durak referans temizligi.

  Ne yapar:
  1) CRM_GOREV satiri olmayan TASK aktivitelerini siler (takvimde gorunmez ama veri kirliligi)
  2) Var olmayan GOREV_ID'ye isaret eden rota duraklarini NULL yapar
  3) (Opsiyonel) Tum rota bagli gorevleri silmek icin asagidaki blogu acin

  NOT: Asagidaki DELETE yalnizca durakta referansi OLMAYAN gorevleri siler;
  rota plani gorevleri KALIR:
    DELETE FROM CRM_GOREV WHERE GOREV_ID NOT IN (SELECT GOREV_ID FROM CRM_ROTA_PLAN_DURAK)
*/

SET NOCOUNT ON;

DECLARE @n INT;

/* --- 1) Durakta gecersiz GOREV_ID referanslari --- */
IF OBJECT_ID(N'dbo.CRM_ROTA_PLAN_DURAK', N'U') IS NOT NULL
   AND OBJECT_ID(N'dbo.CRM_GOREV', N'U') IS NOT NULL
BEGIN
  UPDATE D
  SET D.GOREV_ID = NULL
  FROM dbo.CRM_ROTA_PLAN_DURAK D
  WHERE D.GOREV_ID IS NOT NULL
    AND NOT EXISTS (SELECT 1 FROM dbo.CRM_GOREV G WHERE G.GOREV_ID = D.GOREV_ID);
  SET @n = @@ROWCOUNT;
  PRINT 'CRM_ROTA_PLAN_DURAK gecersiz GOREV_ID temizlendi: ' + CAST(@n AS VARCHAR(20));
END;

/* --- 2) Yetim TASK aktiviteleri (gorev kaydi yok) --- */
IF OBJECT_ID(N'dbo.CRM_AKTIVITE', N'U') IS NOT NULL
   AND OBJECT_ID(N'dbo.CRM_GOREV', N'U') IS NOT NULL
BEGIN
  SELECT @n = COUNT(*)
  FROM dbo.CRM_AKTIVITE A
  WHERE A.TIP = 'TASK'
    AND NOT EXISTS (SELECT 1 FROM dbo.CRM_GOREV G WHERE G.AKTIVITE_ID = A.AKTIVITE_ID);
  PRINT 'Silinecek yetim TASK aktivite (once): ' + CAST(@n AS VARCHAR(20));

  DELETE A
  FROM dbo.CRM_AKTIVITE A
  WHERE A.TIP = 'TASK'
    AND NOT EXISTS (SELECT 1 FROM dbo.CRM_GOREV G WHERE G.AKTIVITE_ID = A.AKTIVITE_ID);
  SET @n = @@ROWCOUNT;
  PRINT 'Yetim TASK aktivite silindi: ' + CAST(@n AS VARCHAR(20));
END;

/* --- 3) OPSIYONEL: Rota duraklarina bagli tum gorevleri silmek --- */
/*
IF OBJECT_ID(N'dbo.CRM_GOREV', N'U') IS NOT NULL
   AND OBJECT_ID(N'dbo.CRM_ROTA_PLAN_DURAK', N'U') IS NOT NULL
BEGIN
  DELETE G
  FROM dbo.CRM_GOREV G
  WHERE EXISTS (
    SELECT 1 FROM dbo.CRM_ROTA_PLAN_DURAK D WHERE D.GOREV_ID = G.GOREV_ID);

  UPDATE dbo.CRM_ROTA_PLAN_DURAK SET GOREV_ID = NULL WHERE GOREV_ID IS NOT NULL;

  DELETE A
  FROM dbo.CRM_AKTIVITE A
  WHERE A.TIP = 'TASK'
    AND NOT EXISTS (SELECT 1 FROM dbo.CRM_GOREV G WHERE G.AKTIVITE_ID = A.AKTIVITE_ID);

  PRINT 'Rota bagli gorevler silindi (opsiyonel blok).';
END;
*/

PRINT '';
PRINT '=== Dogrulama sorgulari ===';
PRINT 'BIROL admin mi:';
PRINT '  SELECT K.KullaniciAd, G.KullaniciGrupAd, G.Admin';
PRINT '  FROM dbo.Kullanici K';
PRINT '  INNER JOIN dbo.KULLANICIGRUP G ON G.KullaniciGrupID = K.KullaniciGrupID';
PRINT '  WHERE K.KullaniciAd = N''BIROL'';';
PRINT '';
PRINT 'Kalan rota gorevleri:';
PRINT '  SELECT G.GOREV_ID, G.ATANAN_KULLANICI_ID, A.KONU';
PRINT '  FROM dbo.CRM_GOREV G';
PRINT '  INNER JOIN dbo.CRM_AKTIVITE A ON A.AKTIVITE_ID = G.AKTIVITE_ID';
PRINT '  INNER JOIN dbo.CRM_ROTA_PLAN_DURAK D ON D.GOREV_ID = G.GOREV_ID;';
