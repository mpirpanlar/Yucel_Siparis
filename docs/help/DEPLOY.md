# CRM Yardım — Canlı Deploy Checklist

Kaynak dosyalar repo kökünde `docs/help/crm/*.md` ve derlenmiş çıktı `help/html/crm/` altındadır.

## Deploy adımları

1. **HTML üret (geliştirme PC)**
   ```powershell
   cd D:\GitHubProjeler\Unigui\Yucel_Siparis
   powershell -ExecutionPolicy Bypass -File tools\help-build.ps1
   ```
2. **Sunucuya kopyala** — EXE ile aynı köke:
   ```
   help\
     html\
       crm\
         *.html
         help.css
   ```
   Örnek: `C:\inetpub\wwwroot\Siparis\help\html\crm\`
3. **EXE güncelle** — `CrmHelpU.pas` ve yardım butonu bağlı formlar yeni build ile deploy edilir.
4. **IIS / uygulama havuzu** — Statik dosya servisi için ek ayar gerekmez; içerik `LocalCachePath` üzerinden iframe ile sunulur.
5. **Doğrulama**
   - CRM menüsünden bir ekran aç → **Yardım** butonu görünmeli.
   - Yardım modalında Türkçe içerik yüklenmeli (404 veya boş sayfa olmamalı).
   - Eksik ekran için `_genel.html` fallback metni görünebilir.

## Güncelleme

- Yalnızca metin değişikliği: `help/html/crm/` klasörünü sunucuya kopyalamak yeterli (EXE yeniden deploy şart değil).
- Yeni ekran / buton: EXE + HTML birlikte deploy edilmeli.

## Dosya yolu (runtime)

Uygulama şu yolu okur: `{ExeDir}\help\html\crm\{FormName}.html`

FormName değerleri `CrmMenuU.pas` ve `dbo.FormName` tablosu ile aynı olmalıdır (ör. `CrmAktiviteListesi`).
