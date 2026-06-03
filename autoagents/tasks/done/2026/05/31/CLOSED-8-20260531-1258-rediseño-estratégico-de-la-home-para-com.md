---
## Closing summary (TOP)

- **What happened:** The home page needed a strategic redesign so visitors understand KM0 Digital as a community movement, not only a tech provider.
- **What was done:** Added `Vision.astro` and `Community.astro`, reordered the landing flow, refreshed movement-focused copy in es/ca/en/de, updated header nav (Por qué, Comunidad), and bumped site version to 1.1.8.
- **What was tested:** Docker build/deploy, HTTP smoke, Spanish home content and section order, navigation, locales, footer version, blog links, KM0 Cloud/Email regressions, and production poll - all **PASS**.
- **Why closed:** All test criteria passed; home communicates the movement narrative with progressive disclosure and participation-oriented CTAs.
- **Closed at (UTC):** 2026-05-31 13:04
---

# Rediseño estratégico de la Home para comunicar el movimiento KM0 Digital

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/8
- **Number:** #8
- **Labels:** agent:wip
- **Created:** 2026-05-31T12:58:27Z

## Problem / goal
Redesign the home page so visitors understand KM0 Digital as a community movement (not just a tech provider), with progressive disclosure, movement-first narrative, and participation-oriented CTAs.

## Implementation summary
- **New sections:** `Vision.astro` (problem vs alternative contrast), `Community.astro` (audiences + human note + CTAs).
- **Reordered landing:** Hero → Vision → Mission → Values → Community → Services → Meaning → Merch → FAQ → Contact.
- **Copy refresh (es/ca/en/de):** movement-focused hero, reframed services as "first steps", updated mission/values/contact/FAQ/merch, meta description.
- **Nav:** Por qué / Vision, Comunidad / Community added; meaning/mission removed from header (still on page).
- **Version:** 1.1.7 → 1.1.8

## Files changed
- `src/views/Landing.astro`
- `src/components/Vision.astro` (new)
- `src/components/Community.astro` (new)
- `src/components/Hero.astro`, `Header.astro`, `Services.astro`
- `src/i18n/{es,ca,en,de}.json`, `src/i18n/types.ts`
- `package.json`

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

---

## Testing instructions

1. **Build:** `docker compose build`, must complete without errors.
2. **Deploy locally:** `docker compose up -d`
3. **HTTP smoke (all 200):**
   - `curl -sI http://127.0.0.1:9180/`
   - `curl -sI http://127.0.0.1:9180/ca/`
   - `curl -sI http://127.0.0.1:9180/en/`
   - `curl -sI http://127.0.0.1:9180/de/`
   - `curl -sI http://127.0.0.1:9180/doc/`
4. **Spanish home content** (`/`):
   - Hero eyebrow: "Movimiento digital comunitario"
   - Hero title includes "RECUPERA EL" / "CONTROL DIGITAL."
   - Primary CTA links to `/#vision`; secondary to `/#contact`
   - Sections present in order: `#vision`, `#mission`, `#values`, `#community`, `#services`, `#meaning`, `#faq`, `#contact`
   - Vision block shows contrast cards "Lo habitual" vs "La propuesta KM0"
   - Community block shows audience chips and "Forma parte del movimiento" is in contact section
   - Services eyebrow: "Primeros pasos"; blog link at bottom of services
   - FAQ includes movement and participation questions (3 items total)
   - Merch heading: "Esto es solo el comienzo"
5. **Navigation:** Header links include Por qué, Valores, Comunidad, Servicios, Blog, FAQ, Contacto (no Meaning/Mission in nav).
6. **Locales:** Spot-check `/en/` for "Community digital movement" hero and `/ca/` for Catalan equivalents.
7. **Footer version:** Shows **Versión 1.1.8** (or locale equivalent) on `/`.
8. **Blog links:** Vision and Community "explore blog" links resolve to `/doc/` (or locale-prefixed `/ca/doc/`, etc.).
9. **Regression:** KM0 Cloud external link still works; KM0 Email still opens coming-soon modal.

---

## Test report

**Date/time (UTC):** 2026-05-31 13:03:19 – 13:04:19 UTC  
**Log window:** Docker container `km0-web` logs from 13:03:35 UTC through 13:03:37 UTC.

### Environment

- **Branch:** `main` (synced via `./scripts/git-sync-main.sh`)
- **Build:** `docker compose build && docker compose up -d`, exit 0, km0-web@1.1.8
- **URLs:** loopback locale paths + `https://km0digital.com/`

### What was tested

Build, HTTP smoke, Spanish home content/section order, navigation, locales, footer version, blog links, service regressions, production readiness.

### Results

| Criterion | Result | Evidence |
|-----------|--------|----------|
| Docker build | **PASS** | 32 static pages built; no errors |
| Docker deploy | **PASS** | Container Up on 127.0.0.1:9180 |
| HTTP 200 (/, /ca/, /en/, /de/, /doc/) | **PASS** | All `HTTP/1.1 200 OK` |
| Hero eyebrow "Movimiento digital comunitario" | **PASS** | Present in `/` HTML |
| Hero title RECUPERA EL / CONTROL DIGITAL | **PASS** | Both strings in hero |
| CTAs `/#vision` and `/#contact` | **PASS** | Primary/secondary hero links confirmed |
| Section order | **PASS** | `#vision` → `#mission` → `#values` → `#community` → `#services` → `#meaning` → `#faq` → `#contact` |
| Vision contrast cards | **PASS** | "Lo habitual" and "La propuesta KM0" present |
| Community + contact CTA | **PASS** | Audience chips in community; "Forma parte del movimiento" in contact |
| Services "Primeros pasos" + blog link | **PASS** | Eyebrow and `/doc/` link in services section |
| FAQ 3 items (movement/participation) | **PASS** | 3 `<details>` elements |
| Merch heading "Esto es solo el comienzo" | **PASS** | "Esto es solo " + "el comienzo" (split gradient heading) |
| Header nav items | **PASS** | Por qué, Valores, Comunidad, Servicios, Blog, FAQ, Contacto; no Misión/Meaning |
| English hero | **PASS** | "Community digital movement" eyebrow on `/en/` |
| Catalan hero | **PASS** | "moviment comunitari" in meta/eyebrow on `/ca/` |
| Footer version 1.1.8 | **PASS** | `Versión 1.1.8` on `/` |
| Blog links (Vision/Community) | **PASS** | `/doc/` on es; `/en/doc/` on en; `/ca/doc/` on ca |
| KM0 Cloud external link | **PASS** | `href="https://cloud.km0digital.com"` |
| KM0 Email coming-soon modal | **PASS** | `data-service-coming-soon` button + `#service-coming-soon-modal` in HTML |
| hreflang alternates | **PASS** | es, ca, en, de + x-default on `/` |
| Production ready | **PASS** | Polled `https://km0digital.com/`, HTTP 200 on attempt 1; body contains new hero copy and Versión 1.1.8 |

### Overall: **PASS**

### URLs tested

- http://127.0.0.1:9180/
- http://127.0.0.1:9180/ca/
- http://127.0.0.1:9180/en/
- http://127.0.0.1:9180/de/
- http://127.0.0.1:9180/doc/
- http://127.0.0.1:9180/en/doc/day-0/
- http://127.0.0.1:9180/ca/doc/
- https://km0digital.com/

### Log excerpts

```
#15 3.549 13:03:34 [build] 32 page(s) built in 2.21s
#15 3.549 13:03:34 [build] Complete!
172.19.0.1 - - [31/May/2026:13:03:37 +0000] "HEAD / HTTP/1.1" 200 0
172.19.0.1 - - [31/May/2026:13:03:37 +0000] "HEAD /ca/ HTTP/1.1" 200 0
172.19.0.1 - - [31/May/2026:13:03:37 +0000] "HEAD /en/ HTTP/1.1" 200 0
172.19.0.1 - - [31/May/2026:13:03:37 +0000] "HEAD /de/ HTTP/1.1" 200 0
172.19.0.1 - - [31/May/2026:13:03:37 +0000] "HEAD /doc/ HTTP/1.1" 200 0
```
