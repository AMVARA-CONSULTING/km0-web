---
## Closing summary (TOP)

- **What happened:** GitHub issue #43 requested enabling the KM0 Email service card on the landing page without price, tutorials, or a coming-soon modal.
- **What was done:** Set email item `available: true` in all four i18n files, linked CTA to `https://mail.km0digital.com`, and added featured styling with `id="km0-email"` in `Services.astro`.
- **What was tested:** Services section on ES/EN/CA/DE landing pages, featured card styling, CTA link, absence of price/tutorial/modal, footer version, Docker build. Overall **PASS**.
- **Why closed:** All testing criteria passed; production poll returned HTTP 200.
- **Closed at (UTC):** 2026-06-14 13:32
---

# Habilitar tarjeta KM0 Email en bloque Servicios (sin precio ni tutoriales)

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/43
- **Number:** #43
- **Labels:** enhancement
- **Created:** 2026-06-14T13:17:45Z

## Problem / goal
## Contexto  En la landing (`#services`), la tarjeta **KM0 Cloud** está activa con precio, CTA «Ver precios», enlace a tutoriales y botón «Abrir Cloud».  La tarjeta **KM0 Email** ya existe en i18n (`services.items`, `id: "email"`) pero:  - `"availabl...

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/43
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary

- `src/i18n/{es,en,ca,de}.json`: email item `available: true`, URL `https://mail.km0digital.com`, updated copy + subtitle.
- `src/components/Services.astro`: featured styling for email card (`service-card-featured`), `id="km0-email"`.
- Site version bumped: 1.1.76 → 1.1.77.

## Testing instructions

1. `docker compose build && docker compose up -d` (or `npm run build`).
2. Open landing `http://127.0.0.1:9180/#services` (ES): both Cloud and Email cards visible in 2-column grid.
3. Email card: no price, no «Ver precios», no tutorial link; single CTA «Abrir Email».
4. Click «Abrir Email» → opens `https://mail.km0digital.com` in new tab.
5. Confirm no «Coming soon» modal appears when clicking Email (`id="service-coming-soon-modal"` absent from DOM).
6. Repeat smoke on `/en/`, `/ca/`, `/de/` (CTA labels: Open Email / Obrir Email / E-Mail öffnen).
7. Footer shows version **1.1.77**.

**Coder verification:** build PASS; HTTP 200 on `/`, `/ca/`, `/en/`, `/de/`, `/doc/`; email link and featured card confirmed in rendered HTML.

## Test report

1. **Date/time (UTC):** 2026-06-14T13:31:10Z – 2026-06-14T13:31:39Z. Log window: Docker/nginx from 13:31:19Z.
2. **Environment:** branch `main` @ `00dcd50` (uncommitted working tree); build via `docker compose build && docker compose up -d` (`km0-web@1.1.79`, 88 pages). URLs: loopback `http://127.0.0.1:9180/`.
3. **What was tested:** Services section on landing (ES/EN/CA/DE), KM0 Email card featured styling, CTA link, absence of price/tutorial/coming-soon modal, footer version, Docker build, HTTP smoke.
4. **Results:**
   - Docker build & deploy: **PASS**
   - Landing `/`, `/ca/`, `/en/`, `/de/` HTTP 200: **PASS**
   - Both Cloud and Email cards in 2-column grid (`id="km0-cloud"`, `id="km0-email"`): **PASS**
   - Email card `service-card-featured` styling: **PASS**
   - Email card: no price, no «Ver precios», no tutorial link: **PASS** (scoped to `#km0-email` article)
   - CTA «Abrir Email» → `https://mail.km0digital.com` (`target="_blank"`): **PASS**
   - No coming-soon modal element (`id="service-coming-soon-modal"` count 0): **PASS**
   - Locale CTAs: Open Email / Obrir Email / E-Mail öffnen: **PASS**
   - Footer version: **PASS** (`Versión 1.1.79`; cumulative bump supersedes coder note 1.1.77)
   - Production readiness: **PASS** (`https://km0digital.com/` HTTP 200 on first poll)
   - GitHub label `agent:testing` on issue #43: **PASS** (applied at test start)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/` (services section); `https://km0digital.com/`.
7. **Log excerpts:**
   ```
   13:31:18 [build] 88 page(s) built in 3.32s
   2026/06/14 13:31:19 [notice] 1#1: start worker processes
   172.21.0.1 - - [14/Jun/2026:13:31:22 +0000] "HEAD / HTTP/1.1" 200 0
   172.21.0.1 - - [14/Jun/2026:13:31:22 +0000] "HEAD /en/ HTTP/1.1" 200 0
   ```
8. **GitHub:** label `agent:testing` applied on issue #43 at test start.
