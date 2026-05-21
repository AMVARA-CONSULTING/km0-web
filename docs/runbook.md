# Operations Runbook — Kilómetro 0 Digital Web

**URL:** https://km0.amvara.de (`/` = español por defecto) · **Català:** `/ca/` · **English:** `/en/`

**Server:** `116.202.10.106` · **Deployed:** 2026-05-21

---

## Locales (i18n)

| Idioma | Ruta | Fichero de copy |
|--------|------|-----------------|
| Español (default) | `/` | `src/i18n/es.json` |
| Català | `/ca/` | `src/i18n/ca.json` |
| English | `/en/` | `src/i18n/en.json` |

- Configuración Astro i18n: `astro.config.mjs` (`defaultLocale: es`, `prefixDefaultLocale: false`).
- Vista única: `src/views/Landing.astro`; entradas en `src/pages/index.astro`, `src/pages/ca/index.astro`, `src/pages/en/index.astro`.
- SEO (canonical, `hreflang`, `x-default`): `src/layouts/Layout.astro`.
- Selector CA | ES | EN y anclas `/#id` o `/ca/#id`: `src/components/Header.astro` y `src/i18n/paths.ts`.
- Sitemap con alternates: integración `@astrojs/sitemap` en `astro.config.mjs` (`i18n.locales` usa códigos BCP-47: `es`, `ca`, `en`).

```bash
curl -sI http://127.0.0.1:9180/ http://127.0.0.1:9180/ca/ http://127.0.0.1:9180/en/
```

---

## Component inventory

| Component | Version / detail | Location |
|-----------|------------------|----------|
| Astro site | km0-web 1.0.0 | `/opt/km0-web/` |
| Docker image | `km0-km0-web` | Built from `/opt/km0-web/Dockerfile` |
| Container | `km0-web` | `127.0.0.1:9180→80` |
| Nginx vhost | `km0.amvara.de` | `/etc/nginx/sites-available/km0` |
| TLS | Let's Encrypt | `/etc/letsencrypt/live/km0.amvara.de/` |
| OpenCloud (separate) | `cloud.km0.amvara.de` → `:9200` | `/opt/opencloud/` |

---

## Day-to-day operations

### Working directory

```bash
cd /opt/km0-web
```

### Rebuild and redeploy after content or code changes

```bash
docker compose build
docker compose up -d
docker compose ps
docker compose logs -f km0-web
```

### Verify the site is up

```bash
curl -sI http://127.0.0.1:9180/
curl -sI https://km0.amvara.de/
ss -tlnp | grep 9180
```

---

## Edit content (no backend)

1. **Traducciones:** editar `src/i18n/es.json`, `ca.json` y `en.json` (mismas claves en los tres).
2. **Layout o secciones:** `src/components/*.astro` o `src/views/Landing.astro`.
3. **Marca / colores:** `docs/brand-tokens.md`, `src/styles/tokens.css`, `tailwind.config.mjs`.
4. **Imágenes:** `public/brand/`.
5. Desplegar: `docker compose build && docker compose up -d`.

---

## Nginx (host reverse proxy)

**Active site:** `/etc/nginx/sites-available/km0`  
**Template in repo:** `/opt/km0-web/nginx/sites-available/km0`

| Port | Behaviour |
|------|-----------|
| 80 | ACME challenge + redirect to HTTPS |
| 443 | TLS termination → `proxy_pass http://127.0.0.1:9180` |

### Reload after config change

```bash
nginx -t
systemctl reload nginx
```

Enable site (if missing):

```bash
ln -sf /etc/nginx/sites-available/km0 /etc/nginx/sites-enabled/km0
```

---

## TLS (Let's Encrypt)

**Certificate:** `/etc/letsencrypt/live/km0.amvara.de/`

Check expiry:

```bash
openssl x509 -in /etc/letsencrypt/live/km0.amvara.de/fullchain.pem -noout -dates
```

Renewal test:

```bash
certbot renew --dry-run
systemctl status certbot.timer
```

Re-issue if needed:

```bash
certbot certonly --webroot -w /var/www/certbot \
  -d km0.amvara.de \
  --email admin@amvara.de --agree-tos --no-eff-email
```

---

## OpenCloud coexistence

The marketing site uses **km0.amvara.de**. OpenCloud was moved to **cloud.km0.amvara.de** to avoid vhost conflict.

| Service | Hostname | Backend |
|---------|----------|---------|
| KM0 landing | `km0.amvara.de` | `127.0.0.1:9180` |
| OpenCloud | `cloud.km0.amvara.de` | `127.0.0.1:9200` |

**Required:** DNS A record `cloud.km0.amvara.de` → `116.202.10.106`, then:

```bash
certbot certonly --webroot -w /var/www/certbot \
  -d cloud.km0.amvara.de \
  --email admin@amvara.de --agree-tos --no-eff-email
```

Update `/etc/nginx/sites-available/opencloud` to use Let's Encrypt paths (see `/opt/opencloud/nginx/sites-available/opencloud`), set `INSECURE=false` in `/opt/opencloud/opencloud-compose/.env`, then:

```bash
cd /opt/opencloud/opencloud-compose
docker compose down && docker compose up -d
nginx -t && systemctl reload nginx
```

Until DNS exists, OpenCloud uses a self-signed cert on `cloud.km0.amvara.de` (`/etc/nginx/ssl/cloud-selfsigned.*`).

---

## Troubleshooting

| Symptom | Check |
|---------|-------|
| 502 Bad Gateway | `docker compose ps`; `curl http://127.0.0.1:9180/` |
| Wrong site (OpenCloud) | `nginx -T \| grep server_name`; ensure `km0` site is enabled |
| TLS errors | `certbot certificates`; cert paths in `/etc/nginx/sites-available/km0` |
| Old content after deploy | Re-run `docker compose build` (not just `up`) |
| Animations not working | Browser console; `prefers-reduced-motion` disables motion |

### Logs

```bash
docker compose -f /opt/km0-web/docker-compose.yml logs --tail=50 km0-web
tail -30 /var/log/nginx/error.log
journalctl -u nginx --since "1 hour ago" --no-pager
```

---

## File map

```
/opt/km0-web/
├── src/                    # Astro source
│   ├── i18n/               # es.json, ca.json, en.json, paths, types
│   ├── views/              # Landing.astro (compartida)
├── public/brand/           # logo.png, brand-guide.png
├── Dockerfile
├── docker-compose.yml
├── nginx/
│   ├── container.conf      # nginx inside container
│   └── sites-available/km0 # host vhost template
└── docs/
    ├── runbook.md          # this file
    └── brand-tokens.md     # colors, copy
```

---

## Change log

| Date | Change |
|------|--------|
| 2026-05-21 | Initial deploy: Astro, Docker :9180, Nginx km0.amvara.de, LE TLS |
| 2026-05-21 | OpenCloud moved to cloud.km0.amvara.de (DNS + LE pending) |
| 2026-05-21 | i18n: `/` ES, `/ca/` CA, `/en/` EN; JSON strings + hreflang |
