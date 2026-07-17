---
## Closing summary (TOP)

- **What happened:** Secondary marketing surfaces were remodeled onto shared page-shell tokens so they match the home/blog visual language.
- **What was done:** Applied Paper/Bricolage/Signal styling and light i18n cleanup across pricing, meeting, ideas, presentation, security, legal, and error pages; calendar and ideas form kept action-first.
- **What was tested:** Tester PASS - HTTP spot-checks, anti-slop tokens (no purple/indigo, no Apple gray, no icon-tile trust cards), forms/calendar structure, footer 1.1.108, em-dash, nginx healthy. Closing skim found no ban-list regressions.
- **Why closed:** All acceptance criteria passed; site reads as one remodel, not a glued home.
- **Closed at (UTC):** 2026-07-17 19:06
---

# FEAT-Task: Secondary surfaces consistency (pricing, tutorials, meeting, ideas, legal/security)

## GitHub Issue
- **Number:** #79
- **Title:** Remodel: secondary surfaces consistency
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/79
- **Labels:** agent:wip
- **Depends / notes:** remodel epic order; after home + blog chrome

## Problem / goal

After home and blog, secondary pages often keep old gray Apple-surface + Inter + gradient CTA DNA. Remodel must feel like **one site**, not a new home glued to old subpages.

## High-level instructions for coder

1. Apply tokens + anti-slop skill to:
   - `/pricing/`, `/tutorials/` (+ post chrome if not done), `/meeting/`, `/ideas/`, `/presentation/`, `/security/`, `/legal/`, error pages
2. Reuse Header/Footer/button/type from landing - no one-off purple.
3. Light copy cleanup on page-level i18n keys (pricing tables stay factual; cut duplicated trust paragraphs).
4. Meeting/ideas: prioritize clarity of action (pick a date / submit idea) over decoration.
5. Build + bump. Use GitHub issue #79.

## Acceptance

- Spot-check each route in es + en: same type/color language as home
- No ban-list hits
- Forms and calendars still work

## Implementation notes (coder)

- Shared shell: `.page-shell`, `.page-masthead`, `.page-band`, `.page-toc` in `src/styles/global.css`
- Remodeled views: Pricing, Meeting, Ideas, Presentation, Security, Legal, ErrorPage
- Calendar / event cards / ideas form: Paper/Snow/Mist + Signal; no `#F5F5F7`, no trust-card hover grid, no pill differentiators
- Tutorials already used doc chrome from earlier FEATs; left aligned with same tokens
- i18n light rewrite (es/ca/en/de): pricing trust shortened; presentation marketese cut; meeting/ideas action-first
- Site version: **1.1.108**

## Testing instructions

1. `docker compose build && docker compose up -d` (or confirm container healthy on `:9180`).
2. HTTP spot-check (expect **200** unless noted):
   - `curl -sI http://127.0.0.1:9180/pricing/` and `/en/pricing/`
   - `/meeting/`, `/en/meeting/`, `/ideas/`, `/en/ideas/`
   - `/presentation/`, `/en/presentation/`
   - `/security/`, `/legal/`, `/tutorials/`, `/doc/`
   - `/403/` → 200 with custom page; `/404.html` may return nginx **404** status but body must include locale error heading + `btn-primary`
3. Visual / anti-slop (es + en):
   - Paper background (`#EEF0F2`), Bricolage display, Signal teal CTAs (`btn-primary`), no purple/indigo, no Apple `#F5F5F7`, no centered dual-pill hero, no icon-tile trust cards on pricing
   - Pricing: split masthead (copy + capacity figure), comparison table, ops list (not cards), custom CTA
   - Meeting: left masthead; calendar interactive (month nav, event days open detail); upcoming list readable
   - Ideas: form submit still posts to `/hooks/ideas` (no need to spam production; check fields/labels render)
   - Presentation: paper grid hero (not dark navy), download uses `btn-primary`, sections are editorial lists not equal card grids
4. Footer shows **Versión 1.1.108** (or locale equivalent).
5. `./scripts/check-no-em-dash.sh` → OK.
6. `docker logs --since 10m km0-web` → no build/runtime errors beyond normal access logs.

## References
- `docs/brand-tokens.md`
- `docs/design/ia-map.md`
- `docs/design/anti-slop-doctrine.md`

## Test report

- **Date/time (UTC):** 2026-07-17 19:05:03 start → 19:05:30 end
- **Log window:** `docker logs --since 15m km0-web` (deploy from prior FEAT-78 window still healthy; 19:04–19:05 UTC)
- **Environment:** branch `main`; container already rebuilt via `docker compose build && docker compose up -d` (healthy on `:9180`); loopback + production
- **What was tested:** HTTP on secondary routes; anti-slop tokens; pricing/meeting/ideas/presentation structure; 403/404; footer 1.1.108; em-dash; nginx logs

### Results

| Criterion | Result | Evidence |
|-----------|--------|----------|
| 1. Deploy healthy | PASS | `docker compose ps`: Up (healthy); nginx started 19:04:32 |
| 2. HTTP 200 spot-check | PASS | `/pricing/`, `/en/pricing/`, `/meeting/`, `/en/meeting/`, `/ideas/`, `/en/ideas/`, `/presentation/`, `/en/presentation/`, `/security/`, `/legal/`, `/tutorials/`, `/doc/`, `/403/` all 200; `/404.html` returns 404 status with custom body (as allowed) |
| 3a. Anti-slop tokens | PASS | Paper `#eef0f2` in tokens; `page-shell` + Bricolage/`font-display` on remodeled pages; `btn-primary` Signal CTAs; zero `#F5F5F7`, zero purple/indigo/violet in HTML; no `rounded-full` pill clusters on spot-checked pages |
| 3b. Pricing | PASS | Split `page-masthead` + `pricing-hero-capacity`; `<table>` / `pricing-table`; `pricing-ops-list` (not trust cards); custom `btn-primary` CTA |
| 3c. Meeting | PASS | Left `page-masthead`; calendar has `data-meeting-calendar`, month prev/next (`Mes anterior` / `Mes siguiente`), `data-meeting-event-id` |
| 3d. Ideas | PASS | Fields scope/idea/name render; submit uses `btn-primary`; client posts `fetch('/hooks/ideas')` in `src/scripts/ideas-form.ts` (not spammed) |
| 3e. Presentation | PASS | `.presentation-hero` uses `var(--color-paper)` (not dark navy); download `btn-primary` "Descargar PDF"; editorial sections |
| 3f. 403 / 404 | PASS | `/403/` 200: heading "Acceso denegado" + `btn-primary` + `page-shell`; `/404.html` status 404, body "Página no encontrada" + `btn-primary` |
| 4. Footer version | PASS | ES `Versión 1.1.108`; EN `Version 1.1.108` |
| 5. Em dash | PASS | `./scripts/check-no-em-dash.sh` OK |
| 6. Logs | PASS | No `[error]`/`[emerg]`/`[crit]`; access logs 200 for spot-checks |
| Production readiness | PASS | Polled `https://km0digital.com/` → 200 on first try; also `/pricing/`, `/meeting/`, `/ideas/`, `/presentation/` → 200 (same host/container path) |

- **Overall:** **PASS**
- **URLs tested:** `http://127.0.0.1:9180/{pricing,meeting,ideas,presentation,security,legal,tutorials,doc,403}/` (+ en variants); `http://127.0.0.1:9180/404.html`; `https://km0digital.com/` (+ secondary paths)
- **Log excerpts:**
  ```
  2026/07/17 19:04:32 [notice] 1#1: nginx/1.31.3
  Container km0-web: Up (healthy) 127.0.0.1:9180->80/tcp
  ```
