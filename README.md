# Kilómetro 0 Digital — Web

Landing estática del proyecto KM0, construida con **Astro** y servida en producción con **Docker + Nginx**.

**URL pública:** https://km0.amvara.de

## Inicio rápido (desarrollo local con Docker)

```bash
cd /opt/km0-web
docker compose build
docker compose up -d
curl -sI http://127.0.0.1:9180/
```

## Editar contenido

| Qué cambiar | Dónde |
|-------------|-------|
| Textos y secciones | `src/components/*.astro`, `src/pages/index.astro` |
| Colores y marca | `docs/brand-tokens.md`, `src/styles/tokens.css`, `tailwind.config.mjs` |
| Logo e imágenes | `public/brand/` |
| Dominio / SEO | `astro.config.mjs` (`site`) |

Tras editar, redeploy:

```bash
cd /opt/km0-web
docker compose build && docker compose up -d
```

## Documentación operativa

Ver **[docs/runbook.md](docs/runbook.md)** para Nginx, TLS, puertos, troubleshooting y migración de OpenCloud a `cloud.amvara.de`.

## Arquitectura

```
Internet → Nginx (km0.amvara.de:443) → 127.0.0.1:9180 (contenedor km0-web)
```

OpenCloud (almacenamiento) vive en **https://cloud.amvara.de** (requiere registro DNS A).
