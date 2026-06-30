# Genel yardım

**FormName:** `_genel`

## Bu ekran ne işe yarar?

CRM modülü ekranları için bağlam yardımı. Ekrana özel içerik yoksa bu sayfa gösterilir.

## Ne zaman kullanılır?

- İlgili ekranın `help/html/crm/{FormName}.html` dosyası henüz oluşturulmadığında
- Yeni eklenen bir form için dokümantasyon beklenirken

## İlgili ekranlar

- CRM menüsündeki tüm liste, kart ve rapor ekranları

## Sık sorulan sorular

**S:** Yardım butonu görünmüyor.  
**C:** Ekranın üst araç çubuğunda `Kapat` düğmesi olan formlarda otomatik eklenir. Form henüz güncellenmemiş olabilir.

**S:** İçerik güncel değil.  
**C:** `docs/help/crm/` altındaki Markdown dosyasını güncelleyip `tools/help-build.ps1` çalıştırın ve `help/html/crm/` klasörünü sunucuya kopyalayın.
