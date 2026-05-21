# Kilómetro 0 Digital — Web

Landing estática del proyecto **Kilómetro 0 Digital**: origen local, impacto digital.

**Sitio en producción:** [https://km0.amvara.de](https://km0.amvara.de)

![Vista previa del hero — Kilómetro 0 Digital](docs/preview-hero.png)

## Sobre el proyecto

KM0 Digital conecta personas, ideas y oportunidades desde el punto de origen. Esta web es la presencia pública del proyecto: una sola página con secciones informativas, identidad de marca (gradiente naranja → magenta → púrpura → azul) y animaciones suaves al hacer scroll.

**Mensaje principal:** *ORIGEN LOCAL. IMPACTO DIGITAL.* — *CONECTA. TRANSFORMA. IMPULSA.*

## Stack

| Capa | Tecnología |
|------|------------|
| Frontend | [Astro](https://astro.build) 5 + [Tailwind CSS](https://tailwindcss.com) |
| Build | Node 22 (multi-stage Docker) |
| Servidor estático | nginx (Alpine) en contenedor |
| Producción | Docker Compose → `127.0.0.1:9180` detrás de Nginx host (TLS) |

## Estructura del repositorio

```
├── src/
│   ├── components/     # Hero, Valores, Significado, Misión, Merch, Contacto…
│   ├── layouts/
│   ├── pages/
│   ├── scripts/        # scroll-reveal (Intersection Observer)
│   └── styles/
├── public/brand/       # logo.png, brand-guide.png
├── docs/
│   ├── brand-tokens.md
│   ├── runbook.md      # operación en servidor
│   └── preview-hero.png
├── nginx/              # config contenedor + plantilla vhost host
├── Dockerfile
└── docker-compose.yml
```

## Inicio rápido

### Con Docker (recomendado)

```bash
git clone git@github.com:Luipy56/km0-web.git
cd km0-web
docker compose build
docker compose up -d
curl -sI http://127.0.0.1:9180/
```

### Desarrollo local (Node en el host)

```bash
npm install
npm run dev      # http://localhost:4321
npm run build    # salida en dist/
```

## Editar contenido

| Qué cambiar | Dónde |
|-------------|-------|
| Textos y secciones | `src/components/*.astro`, `src/pages/index.astro` |
| Colores y marca | `docs/brand-tokens.md`, `src/styles/tokens.css`, `tailwind.config.mjs` |
| Logo e imágenes | `public/brand/` |
| Dominio / SEO | `astro.config.mjs` (`site`) |

Tras editar en producción:

```bash
docker compose build && docker compose up -d
```

## Despliegue en servidor

El reverse proxy del host termina TLS y hace proxy a `127.0.0.1:9180`. Plantilla Nginx: `nginx/sites-available/km0`.

Documentación operativa completa: **[docs/runbook.md](docs/runbook.md)** (TLS, puertos, troubleshooting, coexistencia con OpenCloud en `cloud.amvara.de`).

## Arquitectura

```
Internet → Nginx (km0.amvara.de:443) → 127.0.0.1:9180 (contenedor km0-web)
```

OpenCloud (almacenamiento de archivos) está en **[https://cloud.amvara.de](https://cloud.amvara.de)** — dominio separado del sitio de marketing.

## Licencia

Proyecto privado — © Kilómetro 0 Digital.
