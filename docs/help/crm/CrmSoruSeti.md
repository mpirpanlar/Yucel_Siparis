# CRM - Kontrol Listesi Tanımı

**FormName:** `CrmSoruSeti`

## Bu ekran ne işe yarar?

Aktivite tiplerine bağlanacak kontrol listesi (soru seti) tanımlarını yönetir.

## Ne zaman kullanılır?

- Yeni aktivite tipi için zorunlu sorular eklerken
- Kapanış durumunda cevaplanması gereken maddeleri tanımlarken

## Önemli alanlar

| Alan | Açıklama |
|------|----------|
| Soru seti adı | Tanım başlığı |
| Aktivite tipi | Hangi tipe bağlı |
| Sorular | Metin, zorunlu, sıra |

## İş kuralları

- `KAPANIS_MI` durumuna geçişte ilgili soru seti cevapları kontrol edilir.
- Kontrol raporu bu tanımlardan beslenir.

## İlgili ekranlar

- CrmKontrolRapor, CrmYeniAktivite
