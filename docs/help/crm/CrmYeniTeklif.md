# CRM - Teklif Kartı

**FormName:** `CrmYeniTeklif`

## Bu ekran ne işe yarar?

CRM teklif başlığı, satırları, durumu ve ERP (SIPARIS_BASLIK) bağlantısının yönetimi.

## Ne zaman kullanılır?

- Müşteriye fiyat teklifi hazırlarken
- Tekliften aktivite/görev oluştururken

## Önemli alanlar

| Alan | Açıklama |
|------|----------|
| Teklif No | ERP fis numarası (SIPARIS_BASLIK) |
| Durum | Teklif durum parametresi |
| Geçerlilik | Teklif geçerlilik tarihi |
| Satırlar | Stok, miktar, birim fiyat |

## İş kuralları

- Kapalı teklifler düzenleme kilidine tabi olabilir (açık/kapalı yönetimi).
- Aktivite/görev ile teklif ilişkilendirilebilir.

## İlgili ekranlar

- CrmTeklifListesi, CrmYeniAktivite, CrmYeniGorev
