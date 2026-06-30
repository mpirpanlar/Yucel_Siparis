# CRM - Aktivite Listesi

**FormName:** `CrmAktiviteListesi`

## Bu ekran ne işe yarar?

Kayıtlı CRM aktivitelerini (görev tipi hariç) filtreleyerek listeler. Satırdan veya **Kaydı Aç** ile aktivite kartına geçilir.

## Ne zaman kullanılır?

- Belirli tarih aralığındaki ziyaret, arama, toplantı vb. aktiviteleri görmek için
- Cari veya potansiyel müşteriye bağlı aktiviteleri aramak için
- Durum / tip / öncelik bazında takip için

## Filtreler ve alanlar

| Alan | Zorunlu | Açıklama | Örnek |
|------|---------|----------|-------|
| Tip | Hayır | Çoklu seçim; aktivite tipi (CRM parametrelerinden) | ZIYARET, ARAMA |
| Durum | Hayır | Çoklu seçim; aktivite durumu | PLANLANDI, TAMAMLANDI |
| Öncelik | Hayır | Çoklu seçim | NORMAL, YUKSEK |
| Tarih aralığı | Hayır | İşaretlenirse başlangıç–bitiş arası filtreler; varsayılan son 30 gün | 01.06.2026 – 30.06.2026 |
| Cari kod | Hayır | Netsis cari kodu; **Cari Bul** ile seçilir | 120.01.001 |
| Potansiyel | Hayır | Potansiyel müşteri ID; **Potansiyel Bul** ile seçilir | 42 |

## Grid sütunları

| Sütun | Açıklama |
|-------|----------|
| ID | Aktivite kayıt numarası |
| Tip | Aktivite tipi kodu / açıklaması |
| Konu | Kısa başlık |
| Cari Kod / Ünvan | Bağlı Netsis cari |
| Potansiyel | Potansiyel müşteri unvanı |
| Teklif No / Sipariş No | ERP bağlantıları |
| Tarih | Planlanan aktivite tarihi |
| Durum / Öncelik | Güncel durum ve öncelik |

## Butonlar

| Buton | Açıklama |
|-------|----------|
| Listele | Seçili filtrelere göre gridi doldurur |
| Kaydı Aç | Seçili satırın aktivite kartını açar (çift tıklama da açar) |
| Cari Bul / Potansiyel Bul | Filtre alanlarına kayıt seçer |
| Yardım | Bu sayfayı gösterir |
| Kapat | Sekmeyi kapatır, ana menüye döner |

## İş kuralları

- Liste yalnızca `TIP <> TASK` aktiviteleri gösterir; görevler **Görev Listesi** ekranındadır.
- Admin olmayan kullanıcılar yalnızca yetkili oldukları kayıtları görür (yetki tanımına bağlı).
- Tarih filtresi kapalıyken son 30 gün varsayılan uygulanır.

## İlgili ekranlar

- **CrmYeniAktivite** — yeni aktivite kartı
- **CrmGorevListesi** — görev (TASK) kayıtları
- **CrmAktiviteRapor** — durum / gecikme raporu
- **CrmTakvim** — takvim görünümü

## Sık sorulan sorular

**S:** Görevler listede görünmüyor.  
**C:** Görevler ayrı tiptir; **CRM - Görev Listesi** ekranını kullanın.

**S:** Potansiyel filtresi çalışmıyor.  
**C:** Önce **Potansiyel Bul** ile geçerli bir potansiyel seçin, ardından **Listele** deyin.
