/* ============================================================================
   CRM - Aktivite Kontrol Listesi ORNEK VERI (Yucel Group / kompozit-CTP is kolu)
   Hedef DB: ASYA_ENTEGRE
   Calistirma: SSMS'te bu dosyayi UTF-8 olarak acip ilgili veritabaninda calistirin.
   Idempotent: Her set KOD bazinda kontrol edilir; tekrar calistirilinca cogaltmaz.
   Tablolar (sema surum >= 18 olmalidir):
     CRM_SORU_SETI / CRM_SORU / CRM_SORU_SECENEK / CRM_TIP_SORU_SETI
   Cevap tipleri: EVET_HAYIR, TEK_SECIM, COK_SECIM, METIN, SAYI, TARIH, PUAN
   ============================================================================ */

SET NOCOUNT ON;
GO

/* --------------------------------------------------------------------------
   1) MUSTERI ZIYARETI DEGERLENDIRME  (KOD: ZIYARET)
   Atama: MEETING, CALL  (zorunlu)
   -------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM dbo.CRM_SORU_SETI WHERE KOD = 'ZIYARET')
BEGIN
  DECLARE @SetId BIGINT, @SoruId BIGINT;

  INSERT INTO dbo.CRM_SORU_SETI (KOD, BASLIK, ACIKLAMA, AKTIF, SIRA)
  VALUES ('ZIYARET', N'Müşteri Ziyareti Değerlendirme',
          N'Saha/telefon görüşmesi sonrası saha ekibinin doldurduğu değerlendirme.', 1, 10);
  SET @SetId = SCOPE_IDENTITY();

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 10, N'Ziyaret/görüşme gerçekleşti mi?', 'EVET_HAYIR', 1, 1);

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 20, N'Görüşülen yetkilinin pozisyonu', 'TEK_SECIM', 0, 1);
  SET @SoruId = SCOPE_IDENTITY();
  INSERT INTO dbo.CRM_SORU_SECENEK (SORU_ID, SIRA, METIN, AKTIF) VALUES
    (@SoruId, 10, N'Satınalma', 1),
    (@SoruId, 20, N'Teknik / Mühendislik', 1),
    (@SoruId, 30, N'Üst Yönetim', 1),
    (@SoruId, 40, N'Diğer', 1);

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 30, N'Görüşme konuları', 'COK_SECIM', 0, 1);
  SET @SoruId = SCOPE_IDENTITY();
  INSERT INTO dbo.CRM_SORU_SECENEK (SORU_ID, SIRA, METIN, AKTIF) VALUES
    (@SoruId, 10, N'Yeni ürün tanıtımı (CTP levha / tank)', 1),
    (@SoruId, 20, N'Mevcut sipariş takibi', 1),
    (@SoruId, 30, N'Fiyat / teklif görüşmesi', 1),
    (@SoruId, 40, N'Şikayet / iade', 1),
    (@SoruId, 50, N'Teknik destek', 1);

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 40, N'Müşteri ilgi düzeyi (1-5)', 'PUAN', 1, 1);

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 50, N'Sonraki adım / aksiyon', 'METIN', 0, 1);

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 60, N'Bir sonraki temas tarihi', 'TARIH', 0, 1);

  INSERT INTO dbo.CRM_TIP_SORU_SETI (AKTIVITE_TIP_ID, SET_ID, ZORUNLU_MU, AKTIF)
  SELECT TIP_ID, @SetId, 1, 1 FROM dbo.CRM_AKTIVITE_TIP WHERE KOD IN ('MEETING', 'CALL');
END
GO

/* --------------------------------------------------------------------------
   2) TEKLIF ONCESI TEKNIK GEREKSINIM (CTP / KOMPOZIT)  (KOD: TEKNIK_GEREKSINIM)
   Atama: MEETING, EMAIL  (zorunlu)
   -------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM dbo.CRM_SORU_SETI WHERE KOD = 'TEKNIK_GEREKSINIM')
BEGIN
  DECLARE @SetId BIGINT, @SoruId BIGINT;

  INSERT INTO dbo.CRM_SORU_SETI (KOD, BASLIK, ACIKLAMA, AKTIF, SIRA)
  VALUES ('TEKNIK_GEREKSINIM', N'Teklif Öncesi Teknik Gereksinim (CTP/Kompozit)',
          N'Teklif hazırlamadan önce ürün ve uygulama gereksinimlerinin toplanması.', 1, 20);
  SET @SetId = SCOPE_IDENTITY();

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 10, N'Ürün tipi', 'TEK_SECIM', 1, 1);
  SET @SoruId = SCOPE_IDENTITY();
  INSERT INTO dbo.CRM_SORU_SECENEK (SORU_ID, SIRA, METIN, AKTIF) VALUES
    (@SoruId, 10, N'CTP Levha', 1),
    (@SoruId, 20, N'Depolama Tankı', 1),
    (@SoruId, 30, N'Boru / Profil', 1),
    (@SoruId, 40, N'Özel Kompozit Parça', 1);

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 20, N'Uygulama / temas ortamı', 'COK_SECIM', 0, 1);
  SET @SoruId = SCOPE_IDENTITY();
  INSERT INTO dbo.CRM_SORU_SECENEK (SORU_ID, SIRA, METIN, AKTIF) VALUES
    (@SoruId, 10, N'Kimyasal', 1),
    (@SoruId, 20, N'Gıda', 1),
    (@SoruId, 30, N'Su / Atıksu', 1),
    (@SoruId, 40, N'Deniz / Marin', 1),
    (@SoruId, 50, N'Dış cephe / UV', 1);

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 30, N'Çalışma sıcaklığı kritik mi?', 'EVET_HAYIR', 0, 1);

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 40, N'Yangın geciktirici (FR) gereksinimi var mı?', 'EVET_HAYIR', 1, 1);

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 50, N'Tahmini yıllık miktar (ton)', 'SAYI', 0, 1);

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 60, N'Sertifika gereksinimi', 'COK_SECIM', 0, 1);
  SET @SoruId = SCOPE_IDENTITY();
  INSERT INTO dbo.CRM_SORU_SECENEK (SORU_ID, SIRA, METIN, AKTIF) VALUES
    (@SoruId, 10, N'ISO 9001', 1),
    (@SoruId, 20, N'ISO 14001', 1),
    (@SoruId, 30, N'AS9100 (Havacılık)', 1),
    (@SoruId, 40, N'UKCA', 1),
    (@SoruId, 50, N'ASTM', 1),
    (@SoruId, 60, N'Gerekmiyor', 1);

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 70, N'Teknik şartname / çizim alındı mı?', 'EVET_HAYIR', 1, 1);

  INSERT INTO dbo.CRM_TIP_SORU_SETI (AKTIVITE_TIP_ID, SET_ID, ZORUNLU_MU, AKTIF)
  SELECT TIP_ID, @SetId, 1, 1 FROM dbo.CRM_AKTIVITE_TIP WHERE KOD IN ('MEETING', 'EMAIL');
END
GO

/* --------------------------------------------------------------------------
   3) NUMUNE / PROTOTIP TAKIP  (KOD: NUMUNE)
   Atama: CALL, MEETING  (zorunlu degil - bilgi amacli)
   -------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM dbo.CRM_SORU_SETI WHERE KOD = 'NUMUNE')
BEGIN
  DECLARE @SetId BIGINT, @SoruId BIGINT;

  INSERT INTO dbo.CRM_SORU_SETI (KOD, BASLIK, ACIKLAMA, AKTIF, SIRA)
  VALUES ('NUMUNE', N'Numune / Prototip Takip',
          N'Gönderilen kompozit numune/prototipin müşteri tarafında takibi.', 1, 30);
  SET @SetId = SCOPE_IDENTITY();

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 10, N'Numune gönderildi mi?', 'EVET_HAYIR', 1, 1);

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 20, N'Gönderim yöntemi', 'TEK_SECIM', 0, 1);
  SET @SoruId = SCOPE_IDENTITY();
  INSERT INTO dbo.CRM_SORU_SECENEK (SORU_ID, SIRA, METIN, AKTIF) VALUES
    (@SoruId, 10, N'Kargo', 1),
    (@SoruId, 20, N'Elden teslim', 1),
    (@SoruId, 30, N'Saha kurulumu', 1);

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 30, N'Müşteri numuneyi test etti mi?', 'EVET_HAYIR', 0, 1);

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 40, N'Test / değerlendirme sonucu', 'TEK_SECIM', 0, 1);
  SET @SoruId = SCOPE_IDENTITY();
  INSERT INTO dbo.CRM_SORU_SECENEK (SORU_ID, SIRA, METIN, AKTIF) VALUES
    (@SoruId, 10, N'Onaylandı', 1),
    (@SoruId, 20, N'Revizyon gerekli', 1),
    (@SoruId, 30, N'Reddedildi', 1),
    (@SoruId, 40, N'Beklemede', 1);

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 50, N'Müşteri geri bildirim notu', 'METIN', 0, 1);

  INSERT INTO dbo.CRM_TIP_SORU_SETI (AKTIVITE_TIP_ID, SET_ID, ZORUNLU_MU, AKTIF)
  SELECT TIP_ID, @SetId, 0, 1 FROM dbo.CRM_AKTIVITE_TIP WHERE KOD IN ('CALL', 'MEETING');
END
GO

/* --------------------------------------------------------------------------
   4) SIKAYET / SATIS SONRASI KAYIT  (KOD: SIKAYET)
   Atama: CALL, EMAIL  (zorunlu)
   -------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM dbo.CRM_SORU_SETI WHERE KOD = 'SIKAYET')
BEGIN
  DECLARE @SetId BIGINT, @SoruId BIGINT;

  INSERT INTO dbo.CRM_SORU_SETI (KOD, BASLIK, ACIKLAMA, AKTIF, SIRA)
  VALUES ('SIKAYET', N'Şikayet / Satış Sonrası Kayıt',
          N'Müşteri şikayet ve satış sonrası taleplerinin standart kaydı.', 1, 40);
  SET @SetId = SCOPE_IDENTITY();

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 10, N'Şikayet konusu', 'TEK_SECIM', 1, 1);
  SET @SoruId = SCOPE_IDENTITY();
  INSERT INTO dbo.CRM_SORU_SECENEK (SORU_ID, SIRA, METIN, AKTIF) VALUES
    (@SoruId, 10, N'Ürün kalitesi / kusur', 1),
    (@SoruId, 20, N'Teslimat gecikmesi', 1),
    (@SoruId, 30, N'Miktar / eksik teslim', 1),
    (@SoruId, 40, N'Fatura / ödeme', 1),
    (@SoruId, 50, N'Teknik destek', 1),
    (@SoruId, 60, N'Diğer', 1);

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 20, N'Aciliyet düzeyi (1-5)', 'PUAN', 1, 1);

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 30, N'İlgili sipariş / irsaliye no', 'METIN', 0, 1);

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 40, N'Çözüm önerisi / yapılan aksiyon', 'METIN', 1, 1);

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 50, N'Kalite ekibine iletildi mi?', 'EVET_HAYIR', 0, 1);

  INSERT INTO dbo.CRM_TIP_SORU_SETI (AKTIVITE_TIP_ID, SET_ID, ZORUNLU_MU, AKTIF)
  SELECT TIP_ID, @SetId, 1, 1 FROM dbo.CRM_AKTIVITE_TIP WHERE KOD IN ('CALL', 'EMAIL');
END
GO

/* --------------------------------------------------------------------------
   5) FUAR / POTANSIYEL MUSTERI (LEAD) NITELEME  (KOD: LEAD)
   Atama: MEETING, OTHER  (zorunlu)
   -------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM dbo.CRM_SORU_SETI WHERE KOD = 'LEAD')
BEGIN
  DECLARE @SetId BIGINT, @SoruId BIGINT;

  INSERT INTO dbo.CRM_SORU_SETI (KOD, BASLIK, ACIKLAMA, AKTIF, SIRA)
  VALUES ('LEAD', N'Fuar / Potansiyel Müşteri (Lead) Niteleme',
          N'Fuar ve yeni temaslarda potansiyel müşterinin nitelenmesi.', 1, 50);
  SET @SetId = SCOPE_IDENTITY();

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 10, N'Lead kaynağı', 'TEK_SECIM', 1, 1);
  SET @SoruId = SCOPE_IDENTITY();
  INSERT INTO dbo.CRM_SORU_SECENEK (SORU_ID, SIRA, METIN, AKTIF) VALUES
    (@SoruId, 10, N'Fuar', 1),
    (@SoruId, 20, N'Web / İnternet', 1),
    (@SoruId, 30, N'Referans', 1),
    (@SoruId, 40, N'Soğuk arama', 1),
    (@SoruId, 50, N'Mevcut müşteri', 1);

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 20, N'Hedef sektör', 'COK_SECIM', 0, 1);
  SET @SoruId = SCOPE_IDENTITY();
  INSERT INTO dbo.CRM_SORU_SECENEK (SORU_ID, SIRA, METIN, AKTIF) VALUES
    (@SoruId, 10, N'Kimya', 1),
    (@SoruId, 20, N'Gıda', 1),
    (@SoruId, 30, N'Su / Atıksu', 1),
    (@SoruId, 40, N'İnşaat / Altyapı', 1),
    (@SoruId, 50, N'Denizcilik', 1),
    (@SoruId, 60, N'Enerji', 1),
    (@SoruId, 70, N'Diğer', 1);

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 30, N'Karar verici ile görüşüldü mü?', 'EVET_HAYIR', 1, 1);

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 40, N'Tahmini bütçe (TL)', 'SAYI', 0, 1);

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 50, N'Satınalma zaman ufku', 'TEK_SECIM', 0, 1);
  SET @SoruId = SCOPE_IDENTITY();
  INSERT INTO dbo.CRM_SORU_SECENEK (SORU_ID, SIRA, METIN, AKTIF) VALUES
    (@SoruId, 10, N'0-3 ay', 1),
    (@SoruId, 20, N'3-6 ay', 1),
    (@SoruId, 30, N'6-12 ay', 1),
    (@SoruId, 40, N'12+ ay', 1);

  INSERT INTO dbo.CRM_SORU (SET_ID, SIRA, SORU_METNI, CEVAP_TIPI, ZORUNLU, AKTIF)
  VALUES (@SetId, 60, N'Potansiyel değerlendirme (1-5)', 'PUAN', 1, 1);

  INSERT INTO dbo.CRM_TIP_SORU_SETI (AKTIVITE_TIP_ID, SET_ID, ZORUNLU_MU, AKTIF)
  SELECT TIP_ID, @SetId, 1, 1 FROM dbo.CRM_AKTIVITE_TIP WHERE KOD IN ('MEETING', 'OTHER');
END
GO

/* --------------------------------------------------------------------------
   KONTROL: Eklenen setler, soru ve secenek sayilari
   -------------------------------------------------------------------------- */
SELECT S.SET_ID, S.KOD, S.BASLIK,
       (SELECT COUNT(*) FROM dbo.CRM_SORU Q WHERE Q.SET_ID = S.SET_ID) AS SORU_SAYISI,
       (SELECT COUNT(*) FROM dbo.CRM_TIP_SORU_SETI A WHERE A.SET_ID = S.SET_ID) AS ATAMA_SAYISI
FROM dbo.CRM_SORU_SETI S
WHERE S.KOD IN ('ZIYARET', 'TEKNIK_GEREKSINIM', 'NUMUNE', 'SIKAYET', 'LEAD')
ORDER BY S.SIRA, S.SET_ID;
GO
