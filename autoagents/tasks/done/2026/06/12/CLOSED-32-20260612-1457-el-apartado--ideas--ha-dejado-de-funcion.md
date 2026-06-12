---
## Closing summary (TOP)

- **What happened:** The `/ideas/` form POST to `/hooks/ideas` returned 504 timeouts because production host nginx lacked the hooks location and Docker could not reach the host webhook receiver on `:9181`.
- **What was done:** Deployed host nginx `/hooks/ideas` proxy, bound webhook on `0.0.0.0:9181` with UFW rules for Docker bridge traffic, fixed `host.docker.internal` mapping in docker-compose, added `deploy-host-nginx-km0.sh` and runbook docs. Site version **1.1.75**.
- **What was tested:** **PASS** on all criteria: production and Docker POST paths (`{"ok":true}` HTTP 200), ideas pages, smoke paths, footer version, webhook receiver systemd, host nginx config.
- **Why closed:** Tester overall **PASS**; all testing instructions verified.
- **Closed at (UTC):** 2026-06-12 15:03
---

# El apartado /ideas/ ha dejado de funcionar. Fix it

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/32
- **Number:** #32
- **Labels:** none
- **Created:** 2026-06-12T14:57:34Z

## Problem / goal
El apartado ideas ha dejado de funcionar, en concreto, presiono el botón "enviar" y ni hace nada de nada  Al rato de esperar sale un error en consola. POST 504 Timeout.  Es posible que la actualización del hook no se haya integrado bien ni testesdo?...

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/32
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation (agent 010)

Root cause: after moving the ideas receiver to host systemd (`127.0.0.1:9181`), two integration gaps caused POST 504 timeouts:

1. **Production:** live `/etc/nginx/sites-available/km0` was missing the `location = /hooks/ideas` block (repo template had it but was never deployed). HTTPS POST fell through to the Docker container, which could not reach the host webhook.
2. **Docker dev:** container nginx proxied to `host.docker.internal:9181`, but `host-gateway` resolved to dead `docker0` (`172.17.0.1`), webhook bound only to localhost, and UFW blocked Docker bridge traffic to `:9181`.

### Changes
- `deploy/systemd/km0-ideas-receiver.service`: bind webhook on `0.0.0.0:9181` (UFW still blocks public internet on :9181).
- `docker-compose.yml`: pin `km0` network subnet/gateway; map `host.docker.internal` to `172.21.0.1`.
- `scripts/setup-ideas-processor.sh`: UFW rule for Docker ranges → :9181; sync host nginx vhost from repo on setup.
- `scripts/deploy-host-nginx-km0.sh`: new helper to deploy repo nginx template and reload.
- `docs/runbook.md`: document `/hooks/ideas` on host nginx and deploy script.
- Site version: **1.1.75**

## Testing instructions

1. **Host nginx has hooks location**
   ```bash
   grep -A2 'hooks/ideas' /etc/nginx/sites-available/km0
   sudo ./scripts/deploy-host-nginx-km0.sh   # if out of sync
   ```

2. **Webhook receiver up**
   ```bash
   systemctl status km0-ideas-receiver
   ss -tlnp | grep 9181
   ```

3. **Production POST (HTTPS)**
   ```bash
   curl -s -X POST https://km0digital.com/hooks/ideas \
     -H 'Content-Type: application/json' \
     -d '{"idea":"Test from tester","locale":"en","website":""}'
   ```
   Expect: `{"ok":true}` and HTTP 200 within 1s.

4. **Docker path POST (:9180)**
   ```bash
   curl -s -X POST http://127.0.0.1:9180/hooks/ideas \
     -H 'Content-Type: application/json' \
     -d '{"idea":"Docker path test","locale":"es","website":""}'
   ```
   Expect: `{"ok":true}` and HTTP 200.

5. **Ideas pages load**
   ```bash
   curl -sI http://127.0.0.1:9180/ideas/ http://127.0.0.1:9180/en/ideas/
   ```
   Expect: HTTP 200 for both.

6. **Browser form (manual)**
   - Open `/ideas/` (or `/en/ideas/`), fill idea text, click submit.
   - Expect: thank-you message, no console 504, button stays disabled on success.

7. **Queue file (optional)**
   ```bash
   ls -lt /var/spool/km0-ideas/incoming/ | head -3
   ```

8. **Smoke paths + footer version**
   ```bash
   curl -sI http://127.0.0.1:9180/ /ca/ /en/ /de/ /doc/
   curl -s http://127.0.0.1:9180/ | grep -o 'Versión [0-9.]*'
   ```
   Expect: all 200, footer shows **1.1.75**.
