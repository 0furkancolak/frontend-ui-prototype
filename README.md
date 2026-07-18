# frontend-ui-prototype

Claude Code ve Codex için ortak, soru odaklı ve prototype-first frontend skill'i.

## Yeni varsayılan

Skill doğrudan framework projesi oluşturmaz. Varsayılan prototype çıktısı yalnızca:

```text
prototype/<slug>/
├── index.html
├── DESIGN.md
└── Makefile
```

- Bütün HTML, CSS, JavaScript, mock data ve inline SVG tek `index.html` içindedir.
- Tailwind CSS browser CDN üzerinden gelir.
- Lucide, Alpine.js veya Motion yalnızca gerçekten gerekliyse eklenir ve sürümleri sabitlenir.
- `package.json`, `node_modules`, Vite, React, Next.js veya build adımı oluşturulmaz.
- `Makefile`, sıfır kurulumla local server ve doğrulama komutlarını sağlar.

## Skill akışı

1. Mevcut context ve repository incelenir.
2. Eksik kalan ürün kararları için en fazla yedi somut soru sorulur.
3. Mevcut app varsa ürün gerçeği, route'lar, ekranlar, görsel dil ve gerçek özellikler çıkarılır.
4. Resmî Google `DESIGN.md` formatı ve güncel design-system katalogları araştırılır.
5. Yapısal olarak farklı üç tasarım yönü kullanıcıya sunulur.
6. Kullanıcı yön seçer; “sen seç” dediyse skill gerekçeli seçim yapar.
7. Projeye özel `DESIGN.md` oluşturulur.
8. Screenshot, fotoğraf, generated imagery veya illustration stratejisi belirlenir.
9. Tek `index.html` geliştirilir.
10. Desktop, tablet ve mobile viewport'larda browser kontrolü ve en az bir revizyon yapılır.
11. Prototype handoff'unda durulur.

## Temiz kurulum

```bash
unzip frontend-ui-prototype.zip
cd frontend-ui-prototype
chmod +x scripts/*.sh
make reinstall
```

Bu komut önce eski `frontend-ui-prototype` symlink'lerini kaldırır, paketi doğrular ve Claude Code ile Codex'e yeniden kurar.

Global hedefler:

```text
~/.claude/skills/frontend-ui-prototype
~/.agents/skills/frontend-ui-prototype
```

## Diğer Make hedefleri

```bash
make help
make validate
make install
make install-claude
make install-codex
make reinstall
make uninstall
make clean
make package
```

## Claude Code kullanımı

```text
/frontend-ui-prototype
```

Örnek:

```text
/frontend-ui-prototype
Mevcut uygulamayı incele. Önce bana eksik ürün sorularını sor. Ardından uygun DESIGN.md yönlerini web'den araştır ve seçim için getir. Seçimden sonra bütün prototype kodunu tek index.html içinde, CDN paketleriyle üret. DESIGN.md ve Makefile ekle. Production geliştirmeye geçme.
```

## Codex kullanımı

```text
$frontend-ui-prototype
```

Örnek:

```text
$frontend-ui-prototype inspect the existing app, ask the missing concrete questions, research three suitable DESIGN.md directions, then build the selected direction as one CDN-powered index.html with DESIGN.md and Makefile. Stop at prototype handoff.
```

## Prototype Makefile

Üretilen prototype klasöründe:

```bash
make serve        # http://localhost:4173
make open
make check
make design-lint
make clean
make reset
```

`make serve` için Node veya package manager gerekmez; Python'un standart HTTP server'ını kullanır.

## `frontend-design` ile ilişki

Anthropic'in `frontend-design` skill'i görsel kalite ve frontend estetiği için kullanılabilir. `frontend-ui-prototype` ise sorular, mevcut ürün incelemesi, `DESIGN.md` araştırması, görsel strateji, tek dosyalı prototype sözleşmesi ve browser doğrulamasını zorunlu kılar.
