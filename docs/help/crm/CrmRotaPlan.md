# CRM - Rota Planı

**FormName:** `CrmRotaPlan`

## Bu ekran ne işe yarar?

Günlük saha rotasının durak, personel, GPS ve görev otomasyonu ile planlanması.

## Ne zaman kullanılır?

- Çok duraklı ziyaret planı oluştururken
- Onay sonrası görev üretimi ve km hesabı

## Önemli bölümler

| Bölüm | Açıklama |
|-------|----------|
| Durak grid | Sıra, cari/potansiyel, km, plan saatleri |
| Personel | Rotaya atanan kullanıcılar |
| Zaman planı | Ziyaret dk, mesai, hız; önizleme |
| GPS baş/bitiş | Şube tanımlarından veya manuel |

## İş kuralları

- ONAYLI rotada görev oluşturma parametreye bağlıdır.
- Rota iptalinde bağlı görevler silinmez, IPTAL durumuna çekilir.
- Google Directions ile mesafe güncellenebilir.

## İlgili ekranlar

- CrmRotaListesi, CrmRotaKmRapor, CrmRotaZamanPlan (önizleme)
