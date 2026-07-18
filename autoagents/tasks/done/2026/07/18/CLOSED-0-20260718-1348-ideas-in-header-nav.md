---
## Closing summary (TOP)

- **What happened:** Ideas was only in the footer, so the Ideas zone was hard to find from the primary navbar.
- **What was done:** Added Ideas to `headerNavLinks` after Blog, removed Tutorials from the header (kept in footer), and updated `docs/design/ia-map.md` to match; version 1.1.146.
- **What was tested:** Desktop and mobile nav show Ideas on all locales; Tutorials absent from header and present in footer; ≤7 items; routes 200; Overall PASS.
- **Why closed:** All acceptance criteria passed; no anti-slop regressions (nav-only change).
- **Closed at (UTC):** 2026-07-18 14:18
---

# NEW-Task: Add Ideas to primary header nav

## Origin
- **Source:** Direct operator request (skip GitHub). Ideas is important and not findable in the navbar.
- **No GitHub issue** (`NEW-0`).

## Problem / goal
`/ideas/` exists and is labeled in i18n (`m.nav.ideas`), but it only appears in the **footer** explore column. The **primary header** (`headerNavLinks` in `src/lib/site-nav.ts`) has no Ideas link, so visitors cannot see how to open the Ideas zone from the navbar.

## Diagnosis (locked)
| Surface | Ideas today |
|---------|-------------|
| Header (`headerNavLinks`) | **Missing** |
| Footer (`footerNavColumns` → explore) | Present → `/ideas/` |
| Route | `localeHref(locale, '/ideas/')` works (es/ca/en/de pages) |

Current header (7 items): home, services, pricing, blog, tutorials, meeting, contact.

## Locked IA decision
1. **Add Ideas to the primary header** so it is visible in desktop nav and mobile menu (both consume `headerNavLinks`).
2. **Keep header ≤7 items:** remove **Tutorials** from the header only. Tutorials stay in the **footer** explore column (already there). Do not remove Ideas from the footer.
3. **Href:** `localeHref(locale, '/ideas/')` (English path segment; locale prefix as configured).
4. **Label:** existing `m.nav.ideas` (es/ca/en/de already set).
5. **Placement:** after **Blog**, before **Meeting** (order: … blog → **ideas** → meeting → contact).

Do **not** invent a second Ideas URL or put Ideas only behind Contact.

## Scope (only)
1. `src/lib/site-nav.ts` → `headerNavLinks`: insert Ideas; remove Tutorials from this array.
2. Confirm `Header.astro` (and mobile drawer if separate) renders from `headerNavLinks` with no hardcoded list that omits Ideas.
3. **Required docs:** update `docs/design/ia-map.md` Primary nav line to  
   `Home · Services · Pricing · Blog · Ideas · Encuentros · Contact`  
   and move Tutorials from primary into Secondary (footer / overflow) next to Presentation / FAQ / etc. (Ideas leaves Secondary-only status).
4. Build; bump; Testing instructions; `UNTESTED-`.

## Out of scope
- Redesigning the Ideas form or page chrome
- Changing footer column structure beyond verifying Ideas remains
- Adding Ideas as a home hash section
- Purple/CTA pill spam for Ideas in the hero

## Acceptance (hard)
- [ ] Desktop header shows **Ideas** (localized label) linking to `/ideas/` (and `/en/ideas/`, `/ca/ideas/`, `/de/ideas/`)
- [ ] Mobile nav shows the same Ideas item
- [ ] Tutorials is **not** in the header; still reachable from the footer
- [ ] Header still has ≤7 primary items
- [ ] Active/current state works on Ideas page if the header supports it for other routes
- [ ] `docs/design/ia-map.md` primary/secondary lists match the swap
- [ ] Version bumped; locales 200

## Testing instructions

### What changed
- `src/lib/site-nav.ts` `headerNavLinks`: Tutorials removed; Ideas inserted after Blog (order: home, services, pricing, blog, ideas, meeting, contact). Still 7 items.
- `Header.astro` unchanged: desktop + mobile both map `headerNavLinks`.
- Footer explore column unchanged (still has Ideas + Tutorials).
- `docs/design/ia-map.md` primary/secondary lists updated to match.
- Version: **1.1.146** (footer).

### Deploy
```bash
./scripts/bump-patch-version.sh   # already run → 1.1.146
docker compose build && docker compose up -d
```

### HTTP / nav evidence (coder ran)
```bash
# Ideas routes 200
curl -sI http://127.0.0.1:9180/ideas/ http://127.0.0.1:9180/en/ideas/ \
  http://127.0.0.1:9180/ca/ideas/ http://127.0.0.1:9180/de/ideas/
# → HTTP/1.1 200 OK each

# Primary nav (ES): Ideas present, Tutorials absent
# masthead__links + masthead__mobile-list:
#   Inicio, Servicios, Precios, Blog, Ideas (/ideas/), Encuentros, Contacto

# Primary nav (EN):
#   Home, Services, Pricing, Blog, Ideas (/en/ideas/), Meetings, Contact

# Footer still has /ideas/ and /tutorials/
# Footer version: Versión 1.1.146
```

### Browser (tester)
- [ ] Open `/` and `/en/`: header contains Ideas; click opens Ideas form page
- [ ] Open mobile menu: Ideas present; same order as desktop
- [ ] Tutorials not in header; footer explore still has Ideas + Tutorials
- [ ] Confirm ≤7 primary items and `docs/design/ia-map.md` matches live nav

## References
- src/lib/site-nav.ts (`headerNavLinks`, `footerNavColumns`)
- src/components/Header.astro
- src/views/Ideas.astro
- docs/design/ia-map.md
- docs/runbook.md

## Test report

1. **Date/time (UTC):** 2026-07-18 14:15:23 start → 14:16:00 end. Log window: `docker logs --since 5m km0-web` (14:15:36–14:15:45Z).
2. **Environment:** branch `main` (working tree with uncommitted coder changes); `docker compose build && docker compose up -d`; loopback `http://127.0.0.1:9180/`; production `https://km0digital.com/` HEAD only (200; deploy of this change not required for local pass).
3. **What was tested:** Ideas in primary header (desktop + mobile), Tutorials removed from header but kept in footer, ≤7 items, locale hrefs, `ia-map.md` vs live nav, version 1.1.146, Ideas routes 200, active-state parity with other routes.
4. **Results:**
   - Desktop header shows Ideas (localized) → `/ideas/` (and `/en/ideas/`, `/ca/ideas/`, `/de/ideas/`): **PASS** - ES: Ideas→`/ideas/`; EN: Ideas→`/en/ideas/`; CA: Idees→`/ca/ideas/`; DE: Ideen→`/de/ideas/`. Order after Blog, before Meeting/Encuentros.
   - Mobile nav same Ideas item / order: **PASS** - `masthead__mobile-list` mirrors desktop (7 items, Ideas present).
   - Tutorials not in header; footer still has Ideas + Tutorials: **PASS** - no `tutorial` in desktop/mobile header hrefs; footer still links `/ideas/` and `/tutorials/` (ES label Tutoriales).
   - Header ≤7 primary items: **PASS** - desktop count=7, mobile count=7.
   - Active/current state on Ideas if header supports it: **PASS** - Header has no route `aria-current` / `--active` for pricing, meeting, doc, or ideas (parity; only lang switcher uses `--active`).
   - `docs/design/ia-map.md` matches: **PASS** - Primary: `Home · Services · Pricing · Blog · Ideas · Encuentros · Contact`; Secondary lists Tutorials.
   - Version bumped; locales 200: **PASS** - footer `Versión 1.1.146` / `Version 1.1.146`; `/` `/ca/` `/en/` `/de/` `/doc/` `/ideas/` (all locales) `/tutorials/` → 200. Build green (km0-web@1.1.146). Container healthy.
5. **Overall: PASS**
6. **URLs:** `http://127.0.0.1:9180/`, `/en/`, `/ca/`, `/de/`, `/ideas/`, `/en/ideas/`, `/ca/ideas/`, `/de/ideas/`, `/doc/`, `/en/doc/day-0/`, `/tutorials/`; `https://km0digital.com/` HEAD 200.
7. **Logs:** nginx start 14:15:36Z; access log 200s for tested paths; no error lines in window. `docker compose ps`: healthy on `127.0.0.1:9180->80/tcp`.
