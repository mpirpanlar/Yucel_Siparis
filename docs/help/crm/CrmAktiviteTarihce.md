# CRM - Aktivite Tarihçe

**FormName:** `CrmAktiviteTarihce`

## Bu ekran ne işe yarar?

Seçilen aktivite kaydının alan değişiklik geçmişini (audit log) listeler.

## Ne zaman kullanılır?

- Kim, ne zaman, hangi alanı değiştirdi sorusu
- Denetim ve destek

## Grid kolonları

| Sütun | Açıklama |
|-------|----------|
| Tarih | Değişim zamanı |
| Kullanıcı | İşlemi yapan |
| Alan | Değişen alan adı |
| Eski / Yeni | Önceki ve sonraki değer |

## İş kuralları

- Kayıt `CRM_AKTIVITE_DEGISIM_LOG` tablosundan okunur.
- Kart üzerindeki Tarihçe sekmesi ile aynı veri kaynağı.

## İlgili ekranlar

- CrmYeniAktivite, CrmYeniGorev
