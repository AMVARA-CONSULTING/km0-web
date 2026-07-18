---
## Closing summary (TOP)

- **What happened:** Craft parity HARD for pricing and secondary chrome (#99) passed tester Hard gate vs Stirling Pricing.
- **What was done:** Pricing rebuilt as a plan-path argument (Cloud lead, Email/Custom quieter); shared secondary masthead/chrome on Presentation, Meeting, Ideas, Security, Legal, and errors; i18n and version bump shipped.
- **What was tested:** Hard gate PASS (Stirling Pricing beside `/en/pricing/` + presentation/meeting; 3 parity + 3 anti-slop claims; Cloud CTA live 302; locales/secondary 200; no mailto/em dash/purple glow). Soft class-only pass not used.
- **Why closed:** All acceptance criteria and Hard gate protocol fields satisfied; anti-slop skim of pricing paths shows editorial columns with Cloud lead bias, not icon-tile/SaaS-card slop.
- **Closed at (UTC):** 2026-07-18 00:41
---

# FEAT-Task: Pricing + secondary HARD chrome vs Stirling

## GitHub Issue
- **Number:** #99
- **Title:** Craft parity HARD: pricing + secondary pages vs Stirling product chrome
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/99
- **Labels:** enhancement, agent:wip → agent:testing → CLOSED (verified)

## Problem / goal
#94 scaffolding is not enough. Pricing and secondary pages must feel product-priced and professionally calm in a Stirling side-by-side.

## Depends on
#97 preferred.

## Spec
`docs/design/craft-parity-phase.md`; Stirling Pricing; paint secondary chrome patterns.

## High-level instructions for coder
1. Repaint `/pricing/` as a real pricing argument (plans/paths, Cloud CTA, calm compare - no card-grid slop).
2. Presentation, Meeting, Ideas, Security, Legal, errors: intentional chrome under light/dark; shared patterns not one-offs.
3. Type/spacing peer energy under KM0 fonts; no mailto; Hard gate vs Stirling Pricing + one secondary.
4. Build; bump; Hard gate protocol required.

## Acceptance (hard)
- Side-by-side claims required; "has page-masthead" alone = FAIL

## Implementation notes (coder)
- Pricing rebuilt as Stirling-style argument: loud masthead (“One public price.”) + capacity/price proof; **Choose a path** with Cloud lead / Email quiet / Custom (editorial columns with hairlines, Cloud elevated Snow, primary Cloud CTA, quieter text CTAs - not icon-tile cards).
- Calm market compare Snow band kept; why + includes share one section; closer Cloud-primary + contact secondary.
- Shared secondary chrome: `.heading-page` peer H1 scale, `.page-meta`, tighter masthead rhythm in `global.css`; Presentation/Meeting/Ideas/Security/Legal/Errors use it; Meeting gains Snow `page-closer`.
- i18n paths + meeting closer + ideas eyebrow in es/ca/en/de; types updated.
- Site version bumped to **1.1.127**. Docker rebuild healthy; locales and secondary routes 200.

## Testing instructions

### Hard gate protocol

1. **Reference URL(s)** (same session):
   - https://stirling.com/pricing (Editor / Processor / Enterprise plan paths + repeated product CTA)
   - Optional About-energy peer: https://stirling.com/ (or About if open) for secondary calm

2. **KM0 URL(s)** (after `docker compose build && docker compose up -d`):
   - http://127.0.0.1:9180/en/pricing/
   - Secondary: http://127.0.0.1:9180/en/presentation/ (About-like) and/or http://127.0.0.1:9180/en/meeting/
   - Optional dark: Theme → Dark on `/en/pricing/` and `/en/meeting/` - paths, table, mastheads stay readable (no purple glow)

3. **Three parity claims** (non-dev visible; open Stirling Pricing beside KM0 pricing):
   - **Plan paths as the argument:** Under the masthead, three editorial paths (Cloud / Email / Custom) read like Stirling’s Editor / Processor / Enterprise: name, price line, short body, feature list, CTA - Cloud is the lead (Snow elevation + primary button); Email and Custom stay quieter text CTAs. Not a thin FAQ with one button.
   - **Promise + price proof loudness:** First viewport shows kicker “Pricing”, H1 “One public price.”, one support line, primary **Open KM0 Cloud**, and a dominant 500 GB / €1.99 proof - same confidence shape as Stirling’s Pricing title + plan price columns.
   - **Calm compare + closer rhythm:** Snow compare band is a quiet table (cost-per-TB reading), not a sales scoreboard; page closes with Cloud primary + proposal secondary, matching Stirling’s repeated product CTA energy without card-grid slop.

4. **Three anti-slop claims** (what was refused):
   - No equal icon-tile / rounded shadow pricing cards; paths use hairline editorial columns with Cloud lead bias.
   - No purple/indigo gradients, Inter-only stack, or zebra Paper/Snow striping on secondary pages.
   - No mailto; Contact/proposal uses on-site contact hash; dark is optional civic remap, not dark-first or glow lab.

5. **Decisive viewport evidence**:
   - Path: `/en/pricing/` first viewport + “Choose a path” band (and one secondary, e.g. `/en/presentation/` masthead with `.heading-page`).
   - Look for: H1 “One public price.”; 500 GB Signal proof; Cloud path with **Open KM0 Cloud** button; “Calm market compare”; footer Version **1.1.127**.
   - Class-list-only evidence (e.g. “has `page-masthead`”) without side-by-side narration = **FAIL**.

### Smoke checks
```bash
curl -sI http://127.0.0.1:9180/ http://127.0.0.1:9180/en/ http://127.0.0.1:9180/ca/ http://127.0.0.1:9180/de/ http://127.0.0.1:9180/doc/
curl -sI http://127.0.0.1:9180/en/pricing/ http://127.0.0.1:9180/en/presentation/ http://127.0.0.1:9180/en/meeting/ http://127.0.0.1:9180/en/ideas/ http://127.0.0.1:9180/en/security/ http://127.0.0.1:9180/en/legal/
curl -s http://127.0.0.1:9180/en/pricing/ | grep -E 'One public price\.|Choose a path|Calm market compare|1\.1\.127'
docker logs --since 10m km0-web
```

### Browser checklist
- [ ] Stirling Pricing open beside `/en/pricing/` - three parity claims written by tester
- [ ] Path band: Cloud lead vs quieter Email/Custom (not equal cards)
- [ ] Presentation or Meeting masthead feels peer (large H1 + quiet intro + closer where present)
- [ ] Light + Dark both keep pricing paths and secondary mastheads readable
- [ ] No mailto; no em dash; anti-slop holds

## References
- https://stirling.com/pricing
- docs/design/craft-parity-phase.md
- docs/design/stirling-paint-phase.md

## Test report

1. **Date/time (UTC) and log window**
   - Start: 2026-07-18T00:40:17Z
   - End: 2026-07-18T00:41:08Z
   - Log window: `docker logs --since 15m km0-web` (nginx start 00:40:28Z through pricing/secondary HEADs 00:40:53Z)

2. **Environment**
   - Branch: `main` (synced via `./scripts/git-sync-main.sh`)
   - Build: `docker compose build && docker compose up -d` (Astro build `km0-web@1.1.128`, container healthy on `127.0.0.1:9180`)
   - Production readiness: polled `https://km0digital.com/en/pricing/` until HTTP **200**; body already shows “One public price.”, `pricing-path--lead`, footer Version **1.1.128** (no fixed sleep; later FEAT bumps superseded coder note 1.1.127)

3. **What was tested**
   - Hard gate: https://stirling.com/pricing opened in the same session beside KM0 `/en/pricing/` + secondary `/en/presentation/` and `/en/meeting/`
   - Path band CTA hierarchy (Cloud lead vs quieter Email/Custom)
   - Shared secondary chrome (`.heading-page`, `.page-masthead`, Meeting `page-closer`)
   - Theme toggle + dark token remap (no purple glow); no mailto; no em dash
   - Smoke: home locales, `/doc/`, pricing/presentation/meeting/ideas/security/legal 200; Cloud CTA live

4. **Hard gate protocol (tester-authored)**

   **Reference URL(s):** https://stirling.com/pricing (Editor / Processor / Enterprise plan columns + repeated product CTAs; page H1 “Pricing”, free Editor path, usage Processor, Custom Enterprise)

   **KM0 URL(s):** http://127.0.0.1:9180/en/pricing/ (decisive), `/en/presentation/`, `/en/meeting/`; also https://km0digital.com/en/pricing/ (200, same argument)

   **Three parity claims (non-dev visible, Stirling Pricing beside KM0 pricing):**
   1. **Plan paths as the argument:** Under “Choose a path”, three editorial paths read like Stirling’s Editor / Processor / Enterprise: **KM0 Cloud** (`pricing-path--lead`, Snow elevation, Signal meta/price, primary **Open KM0 Cloud** → `https://cloud.km0digital.com/`), **KM0 Email** and **Custom path** with quieter `page-closer__secondary` CTAs (“Open KM0 Email”, “Request a proposal” → `/en/#contact`). Not a thin FAQ with one button.
   2. **Promise + price proof loudness:** First viewport shows kicker “Pricing”, H1 **One public price.**, support “EU storage, no fine print…”, primary **Open KM0 Cloud**, and dominant **500 GB** / **€1.99 /month** proof - same confidence shape as Stirling’s Pricing title + loud plan prices.
   3. **Calm compare + closer rhythm:** Snow “Calm market compare” band is a quiet cost table (not a sales scoreboard); page closes with Cloud primary + “Request a proposal” secondary, matching Stirling’s repeated product-CTA energy without equal card grids.

   **Three anti-slop claims:**
   1. No equal icon-tile / rounded-shadow pricing cards; paths use hairline editorial columns with Cloud lead bias (`pricing-path--lead` background `var(--surface-snow)`).
   2. No purple/indigo/violet in served CSS (counts 0); no `nth-child` zebra striping; secondary pages share `.heading-page` / `.page-masthead` peer chrome (Presentation H1 “Cloud and email in the EU”; Meeting has Snow `page-closer`).
   3. No `mailto:`; proposal/contact uses on-site `/en/#contact`; dark is optional civic remap (`html[data-theme='dark']` Ink/Paper/Signal, comment bans purple glow), not dark-first.

   **Decisive viewport evidence:**
   - Path: `/en/pricing/` first viewport + “Choose a path” band; secondary `/en/presentation/` masthead.
   - Look for: H1 “One public price.”; 500 GB / €1.99; Cloud path with **Open KM0 Cloud** (`btn-primary`); Email/Custom text CTAs; “Calm market compare”; footer **Version 1.1.128**.
   - Cloud CTA HEAD: **302** to live Cloud (product surface).
   - Not class-list-only: side-by-side Stirling plan columns narrated above with CTA class/href evidence.

5. **Results (criteria)**

   | Criterion | Result | Evidence |
   |-----------|--------|----------|
   | Stirling Pricing beside `/en/pricing/` + 3 parity claims | **PASS** | See Hard gate section; Stirling content fetched same session |
   | Path band: Cloud lead vs quieter Email/Custom | **PASS** | `pricing-path--lead` + `btn-primary` vs two `page-closer__secondary` |
   | Presentation/Meeting peer masthead + closer | **PASS** | `.heading-page` + `.page-masthead` on both; Meeting `page-closer` present |
   | Light + Dark readable (theme + tokens) | **PASS** | `data-theme-cycle` on pricing/meeting; dark remaps Signal teal, no purple/glow in tokens |
   | No mailto; no em dash; anti-slop | **PASS** | check scripts OK; CSS purple/indigo/violet 0; no icon-tile classes |
   | Smoke locales + secondary routes 200 | **PASS** | `/`, `/en/`, `/ca/`, `/de/`, `/doc/`, pricing (4 locales), presentation/meeting/ideas/security/legal all 200 |
   | Soft class-only pass forbidden | **PASS** | Report includes Stirling side-by-side narration + CTA hrefs |

6. **Overall: PASS**

7. **URLs tested**
   - http://127.0.0.1:9180/ , `/en/`, `/ca/`, `/de/`, `/doc/`
   - http://127.0.0.1:9180/en/pricing/ , `/ca/pricing/`, `/de/pricing/`, `/pricing/`
   - http://127.0.0.1:9180/en/presentation/ , `/en/meeting/`, `/en/ideas/`, `/en/security/`, `/en/legal/`
   - https://km0digital.com/en/pricing/
   - https://stirling.com/pricing (reference)
   - https://cloud.km0digital.com/ (Cloud CTA, 302)

8. **Relevant log excerpts**
   ```
   2026/07/18 00:40:28 [notice] 1#1: start worker processes
   172.21.0.1 - - [18/Jul/2026:00:40:37 +0000] "HEAD /en/pricing/ HTTP/1.1" 200
   172.21.0.1 - - [18/Jul/2026:00:40:37 +0000] "HEAD /en/presentation/ HTTP/1.1" 200
   172.21.0.1 - - [18/Jul/2026:00:40:37 +0000] "HEAD /en/meeting/ HTTP/1.1" 200
   172.21.0.1 - - [18/Jul/2026:00:40:41 +0000] "GET /en/pricing/ HTTP/1.1" 200
   172.21.0.1 - - [18/Jul/2026:00:40:53 +0000] "HEAD /en/pricing/ HTTP/1.1" 200
   ```

9. **GitHub:** label `agent:testing` applied on issue #99 at test start.

