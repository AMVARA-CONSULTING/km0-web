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

- Form POST: `/hooks/ideas` (proxied to `km0-ideas-receiver` on `:9181`)
- Receiver script: `scripts/receive-idea.sh` (webhook hook in `hooks/hooks.json`)
- Queue volume: Docker `km0-ideas-spool` → `/var/spool/km0-ideas/incoming` (production host path: `/var/spool/km0-ideas/incoming`)
- Secret processor (Script 2): host-only, see [user-ideas-queue-plan.md](./user-ideas-queue-plan.md)

```bash
curl -sI http://127.0.0.1:9180/ideas/ http://127.0.0.1:9180/en/ideas/
curl -s -X POST http://127.0.0.1:9180/hooks/ideas \
  -H 'Content-Type: application/json' \
  -d '{"idea":"Test feedback","locale":"en"}'
docker compose exec km0-ideas-receiver ls -la /var/spool/km0-ideas/incoming/
```

---

## Component inventory

| Component | Version / detail | Location |
|-----------|------------------|----------|
| Astro site | km0-web 1.1.0 | `/opt/km0-web/` |
| Docker image | `km0-km0-web` | Built from `/opt/km0-web/Dockerfile` |
| Container | `km0-web` | `127.0.0.1:9180→80` |
| Ideas receiver | `km0-ideas-receiver` | `127.0.0.1:9181→9000` (webhook) |
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
