# Kilómetro 0 Digital — Web

Static landing site for **Kilómetro 0 Digital**: local origin, digital impact.

**Production:** [https://km0.amvara.de](https://km0.amvara.de)

![Hero preview — Kilómetro 0 Digital](docs/preview-hero.png)

## About

KM0 Digital connects people, ideas, and opportunities from the point of origin. This repository is the public marketing site: a single page with informational sections, brand identity (orange → magenta → purple → blue gradient), and smooth scroll animations.

**Core message:** *ORIGEN LOCAL. IMPACTO DIGITAL.* — *CONECTA. TRANSFORMA. IMPULSA.*

(Site copy is in Spanish; project documentation is in English.)

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
│   ├── components/     # Hero, Values, Meaning, Mission, Merch, Contact, etc.
│   ├── layouts/
│   ├── pages/
│   ├── scripts/        # scroll-reveal (Intersection Observer)
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
| Text and sections | `src/components/*.astro`, `src/pages/index.astro` |
| Colors and brand | `docs/brand-tokens.md`, `src/styles/tokens.css`, `tailwind.config.mjs` |
| Logo and images | `public/brand/` |
| Domain / SEO | `astro.config.mjs` (`site`) |

After changes on the server:

```bash
docker compose build && docker compose up -d
```

## Server deployment

The host reverse proxy terminates TLS and proxies to `127.0.0.1:9180`. Nginx template: `nginx/sites-available/km0`.

Full operations guide: **[docs/runbook.md](docs/runbook.md)** (TLS, ports, troubleshooting, coexistence with OpenCloud at `cloud.amvara.de`).

## Architecture

```
Internet → Nginx (km0.amvara.de:443) → 127.0.0.1:9180 (km0-web container)
```

OpenCloud (file storage) runs at **[https://cloud.amvara.de](https://cloud.amvara.de)** — separate hostname from this marketing site.

## License

Private project — © Kilómetro 0 Digital.
