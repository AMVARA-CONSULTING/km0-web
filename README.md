# KM0 — Web

Public marketing landing for **KM0 Digital** (Kilometer / Kilòmetre / Kilómetro 0 in localized site copy).

**Production:** Spanish (default) [https://km0.amvara.de](https://km0.amvara.de) · Catalan [/ca/](https://km0.amvara.de/ca/) · English [/en/](https://km0.amvara.de/en/)

![Hero preview — KM0 Digital](docs/preview-hero.png)

## About

KM0 connects people, ideas, and opportunities from the point of origin. This repository is the public marketing site with informational sections, brand identity (orange → magenta → purple → blue gradient), and smooth scroll animations.

Translations live in **`src/i18n/{es,ca,en}.json`**; default language is Spanish at `/`.

**Core message:** *ORIGEN LOCAL. IMPACTO DIGITAL.* — *CONECTA. TRANSFORMA. IMPULSA.*

(Project docs and this README are mainly in English; on-site wording follows each locale.)

## Version

RELEASE version lives in **`VERSION`** (semver, one line). When you bump releases, keep it in sync with **`package.json`** `version`.

## Locales

| Language | Path |
|---------|------|
| Spanish (default) | `/` |
| Catalan | `/ca/` |
| English | `/en/` |

Edit **`src/i18n/es.json`**, **`ca.json`**, and **`en.json`** together so keys stay aligned.

## Stack

| Layer | Technology |
|-------|------------|
| Frontend | [Astro](https://astro.build) 5 + [Tailwind CSS](https://tailwindcss.com) |
| Build | Node 22 (multi-stage Docker) |
| Static server | nginx (Alpine) in container |
| Production | Docker Compose → `127.0.0.1:9180` behind host Nginx (TLS) |

## Repository layout

```
├── src/
│   ├── i18n/           # Translation JSON + helpers
│   ├── components/
│   ├── layouts/
│   ├── pages/
│   ├── views/          # Shared Landing.astro
│   ├── scripts/
│   └── styles/
├── public/brand/       # logo.png, brand-guide.png
├── docs/
│   ├── brand-tokens.md
│   ├── runbook.md      # server operations
│   └── preview-hero.png
├── nginx/              # container config + host vhost template
├── Dockerfile
└── docker-compose.yml
```

## Quick start

### Docker (recommended)

```bash
git clone git@github.com:Luipy56/km0-web.git
cd km0-web
docker compose build
docker compose up -d
curl -sI http://127.0.0.1:9180/
```

### Local development (Node on host)

```bash
npm install
npm run dev      # http://localhost:4321
npm run build    # output in dist/
```

## Editing content

| Change | Location |
|--------|----------|
| Translate text | **`src/i18n/es.json`**, **`ca.json`**, **`en.json`** |
| Sections / markup | **`src/views/Landing.astro`** and **`src/components/*.astro`** |
| Colors and brand | `docs/brand-tokens.md`, `src/styles/tokens.css`, `tailwind.config.mjs` |
| Logo and images | `public/brand/` |
| Domain / SEO | `astro.config.mjs` (`site`) |

After changes on the server:

```bash
docker compose build && docker compose up -d
```

## Server deployment

The host reverse proxy terminates TLS and proxies to `127.0.0.1:9180`. Nginx template: `nginx/sites-available/km0`.

Full operations guide: **[docs/runbook.md](docs/runbook.md)** (TLS, ports, troubleshooting, coexistence with OpenCloud at **`cloud.km0.amvara.de`**).

## Architecture

```
Internet → Nginx (km0.amvara.de:443) → 127.0.0.1:9180 (km0-web container)
```

OpenCloud (file storage) runs at **[https://cloud.km0.amvara.de](https://cloud.km0.amvara.de)** — separate hostname from this marketing site.

## License

Private project — © KM0 Digital.
