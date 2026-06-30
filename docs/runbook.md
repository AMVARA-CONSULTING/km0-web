# Operations Runbook - Kilómetro 0 Digital Web

**URL:** https://km0digital.com (`/` = Spanish default locale) · **Català:** `/ca/` · **English:** `/en/` · **Deutsch:** `/de/` · **Blog:** `/doc/` (nav label: “Blog”)

**Server:** `116.202.10.106` · **Deployed:** 2026-05-21

---

## Locales (i18n)

| Locale | Path | Copy file |
|--------|------|-----------|
| Spanish (default) | `/` | `src/i18n/es.json` |
| Catalan | `/ca/` | `src/i18n/ca.json` |
| English | `/en/` | `src/i18n/en.json` |
| German | `/de/` | `src/i18n/de.json` |

- Configuración Astro i18n: `astro.config.mjs` (`defaultLocale: es`, `prefixDefaultLocale: false`).
- Shared view: `src/views/Landing.astro`; page entries in `src/pages/index.astro`, `src/pages/{ca,en,de}/index.astro`.
- SEO (canonical, `hreflang`, `x-default`): `src/layouts/Layout.astro`.
- Locale switcher (CA | DE | EN | ES) and hash anchors `/#id` or `/ca/#id`: `src/components/Header.astro` and `src/i18n/paths.ts`.
- Sitemap alternates: `@astrojs/sitemap` in `astro.config.mjs` (BCP-47 locale codes: `es`, `ca`, `en`, `de`).

### SEO and search indexing

- **robots.txt:** `public/robots.txt` (allows all crawlers, references sitemap).
- **Sitemap:** built at `/sitemap-index.xml` via `@astrojs/sitemap`.
- **Canonical / hreflang / JSON-LD:** `src/layouts/Layout.astro`, `src/components/SeoManager.astro`.
- **Brand keyword:** home `meta.title` and `meta.description` in `src/i18n/*.json` include `km0digital`.

**Operator tasks (production, manual):**

1. [Google Search Console](https://search.google.com/search-console/about): verify `km0digital.com`, submit `https://km0digital.com/sitemap-index.xml`.
2. [Bing Webmaster Tools](https://www.bing.com/webmasters/about): verify the domain and submit the same sitemap (helps non-Google search engines and regional filters).

```bash
curl -sI https://km0digital.com/robots.txt
curl -s https://km0digital.com/robots.txt
curl -sI https://km0digital.com/sitemap-index.xml
curl -s https://km0digital.com/sitemap-index.xml | head -20
```

```bash
curl -sI http://127.0.0.1:9180/ http://127.0.0.1:9180/ca/ http://127.0.0.1:9180/en/
curl -sI http://127.0.0.1:9180/doc/ http://127.0.0.1:9180/doc/day-0/
curl -sI http://127.0.0.1:9180/ca/doc/ http://127.0.0.1:9180/en/doc/day-0/
```

### Blog (`/doc/`)

| Path | View |
|------|------|
| `/doc/`, `/ca/doc/`, `/en/doc/`, `/de/doc/` | `src/views/DocIndex.astro` |
| `/doc/day-0/`, etc. | `src/views/DocPost.astro` |

- Markdown entries: `src/content/doc/{es,ca,en,de}/<slug>.md`
- Schema: `src/content.config.ts` (`title`, `description`, `pubDate`, `locale`)
- Home: **Services** section (`#services`) between Values and Meaning; Cloud/Email links in i18n `services.items`

**Add a post:** create the `.md` in each locale (same filename slug, e.g. `day-0.md`), then `docker compose build && docker compose up -d`.

### User ideas (`/ideas/`)

| Path | View |
|------|------|
| `/ideas/`, `/ca/ideas/`, `/en/ideas/`, `/de/ideas/` | `src/views/Ideas.astro` |

- Form POST: `/hooks/ideas` (host nginx → webhook systemd on `:9181`)
- Receiver: `scripts/receive-idea.sh` via [adnanh/webhook](https://github.com/adnanh/webhook) (`km0-ideas-receiver.service`)
- Dev email: `scripts/notify-idea-email.sh` (AutoMail API, fire-and-forget on enqueue; `AUTOMAIL_TOKEN` in repo-root `.env`)
- Queue spool: `/var/spool/km0-ideas/incoming` (host bind mount, no Docker sidecar)
- Processor (autoissue): `scripts/autoissue.sh` + `autoissue/autoissue-agent.md` (cursor-agent drafts, then `gh issue create`), triggered by `km0-idea-processor.path` (see [user-ideas-queue-plan.md](./user-ideas-queue-plan.md))

```bash
# First-time host setup (spool dirs + webhook + systemd)
sudo ./scripts/setup-ideas-processor.sh

# AutoMail (host only, add to repo-root .env, never commit):
# AUTOMAIL_TOKEN=...
# AUTOMAIL_NOTIFY_TO=yoelberjaga@gmail.com

# Manual drain / replay
sudo ./scripts/autoissue.sh
ls -la /var/spool/km0-ideas/{incoming,processed,failed}/
```

```bash
curl -sI http://127.0.0.1:9180/ideas/ http://127.0.0.1:9180/en/ideas/
curl -s -X POST http://127.0.0.1:9181/hooks/ideas \
  -H 'Content-Type: application/json' \
  -d '{"idea":"Test feedback","locale":"en"}'
ls -la /var/spool/km0-ideas/incoming/
systemctl status km0-ideas-receiver
```

### Cloud users (`/cloud/`)

| Path | View |
|------|------|
| `/cloud/`, `/ca/cloud/`, `/en/cloud/`, `/de/cloud/` | `src/views/CloudUsers.astro` |

- Build-time count from OpenCloud Graph API: `https://cloud.km0digital.com/graph/v1.0/users`
- Credentials (never in frontend or git): `CLOUD_ADMIN_USER` and `CLOUD_APP_TOKEN` in repo-root `.env` (see `.env.example`)
- Docker: `docker-compose.yml` passes those vars as build args; `.env` is excluded from the image via `.dockerignore`
- **`CLOUD_APP_TOKEN` expires after 12 months**; renew in OpenCloud admin, update `.env`, then rebuild
- Optional CI: store the same names as GitHub Actions secrets (`gh secret set CLOUD_ADMIN_USER`, `gh secret set CLOUD_APP_TOKEN`)

```bash
# Local check (requires .env)
set -a && source .env && set +a
curl -sS 'https://cloud.km0digital.com/graph/v1.0/users' \
  -u "${CLOUD_ADMIN_USER}:${CLOUD_APP_TOKEN}" | jq '.value | length'

curl -sI http://127.0.0.1:9180/cloud/ http://127.0.0.1:9180/en/cloud/
curl -s http://127.0.0.1:9180/en/cloud/ | grep -o 'cloud-users-count'
```

---

## Component inventory

| Component | Version / detail | Location |
|-----------|------------------|----------|
| Astro site | km0-web 1.1.0 | `/opt/km0-web/` |
| Docker image | `km0-km0-web` | Built from `/opt/km0-web/Dockerfile` |
| Container | `km0-web` | `127.0.0.1:9180→80` |
| Ideas receiver | `km0-ideas-receiver.service` (host webhook) | `127.0.0.1:9181` |
| Nginx vhost | `km0digital.com` | `/etc/nginx/sites-available/km0` |
| TLS | Let's Encrypt | `/etc/letsencrypt/live/km0digital.com/` |
| OpenCloud (separate) | `cloud.km0digital.com` → `:9200` | `/opt/opencloud/` |

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
curl -sI https://km0digital.com/
ss -tlnp | grep 9180
```

---

## Edit content (no backend)

1. **Translations:** edit `src/i18n/es.json`, `ca.json`, `en.json`, and `de.json` (keep the same keys across locales).
2. **Blog:** `src/content/doc/{locale}/<slug>.md` (see Blog section above).
3. **Layout or sections:** `src/components/*.astro` or `src/views/Landing.astro`.
4. **Brand / colors:** `docs/brand-tokens.md`, `src/styles/tokens.css`, `tailwind.config.mjs`.
5. **Images:** `public/brand/`.
6. Deploy: `docker compose build && docker compose up -d`.

**Footer version:** `package.json` `version` (e.g. `1.1.1`) is shown on every page. Autoagents coders run **`./scripts/bump-patch-version.sh`** once per completed task (patch +1).

---

## Dependencies (npm)

Direct dependencies in **`package.json`** use exact semver (no `^` or `~`). Transitive dependencies are locked in **`package-lock.json`** with resolved URLs and integrity hashes. **`.npmrc`** sets `save-exact=true` and `package-lock=true`.

| Context | Command |
|---------|---------|
| Local install | `npm ci` |
| Docker build | `npm ci` (see `Dockerfile`) |
| Add direct dep | `npm install name@x.y.z` |
| Refresh lockfile after `package.json` edit | `npm install --package-lock-only` |

Avoid `npm install` or `npm update` without a deliberate bump; that can rewrite transitive pins. After any dependency change: commit `package.json` and `package-lock.json`, then `docker compose build && docker compose up -d`.

---

## Nginx (host reverse proxy)

**Active site:** `/etc/nginx/sites-available/km0`  
**Template in repo:** `/opt/km0-web/nginx/sites-available/km0`

| Port | Behaviour |
|------|-----------|
| 80 | ACME challenge + redirect to HTTPS |
| 443 | TLS termination → `proxy_pass http://127.0.0.1:9180` (except `POST /hooks/ideas` → `:9181`) |

### Reload after config change

```bash
sudo ./scripts/deploy-host-nginx-km0.sh
# or manually:
cp /opt/km0-web/nginx/sites-available/km0 /etc/nginx/sites-available/km0
nginx -t && systemctl reload nginx
```

Enable site (if missing):

```bash
ln -sf /etc/nginx/sites-available/km0 /etc/nginx/sites-enabled/km0
```

---

## TLS (Let's Encrypt)

**Certificate:** `/etc/letsencrypt/live/km0digital.com/` (apex only; add `www` to DNS and re-run certbot with `-d www.km0digital.com` when needed)

Check expiry:

```bash
openssl x509 -in /etc/letsencrypt/live/km0digital.com/fullchain.pem -noout -dates
```

Renewal test:

```bash
certbot renew --dry-run
systemctl status certbot.timer
```

Re-issue if needed:

```bash
certbot certonly --webroot -w /var/www/certbot \
  -d km0digital.com -d www.km0digital.com \
  --email admin@amvara.de --agree-tos --no-eff-email
```

**Domain migration (2026-05-26):** Before running certbot, create DNS A records:

| Host | Type | Value |
|------|------|-------|
| `km0digital.com` | A | `116.202.10.106` |
| `www.km0digital.com` | A | `116.202.10.106` (or CNAME → `km0digital.com`) |

After DNS propagates:

```bash
certbot certonly --webroot -w /var/www/certbot \
  -d km0digital.com -d www.km0digital.com \
  --email admin@amvara.de --agree-tos --no-eff-email
cp /opt/km0-web/nginx/sites-available/km0 /etc/nginx/sites-available/km0
nginx -t && systemctl reload nginx
```

The repo vhost redirects `km0.amvara.de` and `www.km0digital.com` → `https://km0digital.com`.

---

## OpenCloud coexistence

The marketing site uses **km0digital.com**. OpenCloud was moved to **cloud.km0digital.com** to avoid vhost conflict.

| Service | Hostname | Backend |
|---------|----------|---------|
| KM0 landing | `km0digital.com` | `127.0.0.1:9180` |
| OpenCloud | `cloud.km0digital.com` | `127.0.0.1:9200` |

**Required:** DNS A record `cloud.km0digital.com` → `116.202.10.106`, then:

```bash
certbot certonly --webroot -w /var/www/certbot \
  -d cloud.km0digital.com \
  --email admin@amvara.de --agree-tos --no-eff-email
```

Update `/etc/nginx/sites-available/opencloud` to use Let's Encrypt paths (see `/opt/opencloud/nginx/sites-available/opencloud`), set `INSECURE=false` in `/opt/opencloud/opencloud-compose/.env`, then:

```bash
cd /opt/opencloud/opencloud-compose
docker compose down && docker compose up -d
nginx -t && systemctl reload nginx
```

Until DNS exists, OpenCloud uses a self-signed cert on `cloud.km0digital.com` (`/etc/nginx/ssl/cloud-selfsigned.*`).

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

## Git and GitHub

| Item | Value |
|------|--------|
| Remote (SSH) | `git@github.com:AMVARA-CONSULTING/km0-web.git` |
| Web UI | https://github.com/AMVARA-CONSULTING/km0-web |
| Working tree | `/opt/km0-web` |

### Deploy key (SSH) on this server

Add the **public** key below as a **Deploy key** on the GitHub repo (Settings → Deploy keys → Add, enable write if you push from the server).

| File | Path |
|------|------|
| Private key (do not share) | `/root/.ssh/github_luipy56_ed25519` |
| Public key (for GitHub) | `/root/.ssh/github_luipy56_ed25519.pub` |
| SSH config for `github.com` | `/root/.ssh/config` → `IdentityFile` above |

Show public key:

```bash
cat /root/.ssh/github_luipy56_ed25519.pub
```

---

## File map

```
/opt/km0-web/
├── src/                    # Astro source
│   ├── i18n/               # es.json, ca.json, en.json, paths, types
│   ├── views/              # Landing.astro (shared)
├── public/brand/           # logo.png, brand-guide.png
├── Dockerfile
├── docker-compose.yml
├── nginx/
│   ├── container.conf      # nginx inside container
│   └── sites-available/km0 # host vhost template
└── docs/
    ├── runbook.md                  # this file
    ├── brand-tokens.md             # colors, copy
    └── user-ideas-queue-plan.md    # user comment intake (queue + secret processor)
```

---

## Related design docs

| Doc | Topic |
|-----|--------|
| [user-ideas-queue-plan.md](./user-ideas-queue-plan.md) | Public form → spool JSON → host-only secret script |

---

## Change log

| Date | Change |
|------|--------|
| 2026-05-21 | Initial deploy: Astro, Docker :9180, Nginx km0digital.com, LE TLS |
| 2026-05-21 | OpenCloud moved to cloud.km0digital.com (DNS + LE pending) |
| 2026-05-21 | i18n: `/` ES, `/ca/` CA, `/en/` EN; JSON strings + hreflang |
| 2026-05-26 | Domain migration: `km0.amvara.de` → `km0digital.com` (301 redirect from old hostname) |
