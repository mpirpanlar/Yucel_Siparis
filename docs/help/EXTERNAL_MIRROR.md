# CRM Yardım — Harici Mirror (GitBook / Notion)

Repo’daki `docs/help/crm/*.md` dosyaları **kaynak gerçeği**dir. Harici wiki yalnızca kopya/ eğitim kanalı olarak kullanılmalıdır.

## GitBook

1. GitHub repo’yu GitBook space’e bağlayın (`docs/help/crm` klasörü).
2. Her `.md` dosyası bir sayfa; dosya adı = FormName.
3. CI (opsiyonel): PR merge sonrası GitBook sync tetiklenir.
4. Uygulama içi yardım GitBook’a bağımlı değildir; canlıda statik HTML kullanılır.

## Notion

1. `docs/help/crm` içeriğini Notion database veya sayfa ağacına aktarın.
2. Eğitim ekibi Notion AI ile düzenleyebilir; değişiklikleri periyodik olarak repo `.md` dosyalarına geri alın (PR).
3. PDF export: Notion → Export → PDF (müşteri eğitim seti).

## Önerilen iş akışı

| Adım | Araç |
|------|------|
| Taslak / kod eşlemesi | Cursor + repo |
| Türkçe düzenleme | ChatGPT / insan review |
| Versiyonlama | Git (`docs/help/`) |
| HTML build | `tools/help-build.ps1` |
| Canlı okuyucu | UniGUI `CrmHelpU` |
| Harici eğitim | GitBook veya Notion mirror |

## Senkron kuralı

Yeni CRM ekranı veya anlamlı alan değişikliğinde ilgili `{FormName}.md` güncellenir, `help-build.ps1` çalıştırılır, HTML commit edilir. Harici mirror aylık veya release bazında yenilenir.
