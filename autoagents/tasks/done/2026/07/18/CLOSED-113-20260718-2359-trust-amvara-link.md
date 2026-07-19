---
## Closing summary (TOP)

- **What happened:** Trust strip operator name was plain text; needed a quiet link to amvara.de.
- **What was done:** Added externalHref for trust operator to https://amvara.de (blank+noopener); normalized footer poweredBy URL; security link kept.
- **What was tested:** Hard gate PASS on four locales: operator link + safety attrs; security locale paths 200; quiet text-link styling.
- **Why closed:** All acceptance and Hard gate criteria passed.
- **Closed at (UTC):** 2026-07-19 00:18
---

# FEAT-Task: Trust strip - link AMVARA CONSULTING S.L. to amvara.de

## GitHub Issue
- **Number:** #113
- **Title:** Trust strip: link AMVARA CONSULTING S.L. to https://amvara.de
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/113
- **Labels:** (agent:planned after sync)

## Origin
- **Source:** Direct operator request + GitHub #113.
- **Brief:** The operator name "AMVARA CONSULTING S.L." in the trust strip should be clickable and go to `https://amvara.de`.

## Problem / goal
Home `#trust` shows Operador / Operator as plain text (`TrustSignals.astro`). Only the Seguridad / Security item is linkable today (`href: 'security'`). Make the AMVARA CONSULTING S.L. value a quiet external link to **`https://amvara.de`** (operator URL; prefer this over existing `https://amvara.de/#/` used elsewhere unless a redirect forces the hash).

## Locked decisions
1. Target URL: **`https://amvara.de`** (external; `target="_blank"` + `rel="noopener noreferrer"`).
2. Surface: trust strip operator item in all four locales; reuse existing `trust__value--link` styling (quiet text link, not a button).
3. Extend the trust item model only as needed (e.g. external URL field or a dedicated `href` variant). Keep security item working.
4. Do **not** rewrite every legal/FAQ plain-text mention of AMVARA CONSULTING S.L. in this FEAT. Footer "Powered by AMVARA" already links; leave it unless it still points at a broken hash and a one-line normalize to `https://amvara.de` is trivial and safe.
5. No mailto; no CTA spam; anti-slop quiet strip stays quiet.

## Scope
1. `src/components/TrustSignals.astro`
2. `src/i18n/types.ts` (trust item href shape)
3. `src/i18n/{es,ca,en,de}.json` (operator item link)
4. `./scripts/bump-patch-version.sh`; build; Testing instructions; `UNTESTED-`.

## Out of scope
- Full legal-page link sweep
- Trust strip visual remodel
- Changing company legal name copy

## Acceptance (hard)
- [x] Operador / Operator value is an `<a>` to `https://amvara.de`
- [x] Opens in a new tab with `noopener noreferrer`
- [x] Works in es/ca/en/de
- [x] Security trust link still works
- [x] No em dash; no mailto; site version bumped (1.2.5 → 1.2.6)
- [x] Hard gate click check (below)

## High-level instructions for coder
- Read issue #113; inspect `TrustSignals.astro` and trust types.
- Minimal model extension; do not invent a card CTA.
- Skills: `km0-anti-slop-design` only if link chrome risks getting loud.
- Deploy verification per `docs/runbook.md`.

## Implementation notes (coder)
- Added optional `externalHref` on trust items (`src/i18n/types.ts`).
- `TrustSignals.astro` resolves external vs on-site (`security`) links; external uses `target="_blank"` + `rel="noopener noreferrer"`.
- Operator item in es/ca/en/de sets `"externalHref": "https://amvara.de"`.
- Trivial footer normalize: `poweredByHtml` `https://amvara.de/#/` → `https://amvara.de` (all locales). Legal/security body HTML left unchanged (out of scope).

## Testing instructions

### Deploy / HTTP
```bash
docker compose build && docker compose up -d
curl -sI http://127.0.0.1:9180/ http://127.0.0.1:9180/ca/ http://127.0.0.1:9180/en/ http://127.0.0.1:9180/de/ http://127.0.0.1:9180/doc/
# expect HTTP/1.1 200 OK each
```

### Click / HTML checks
```bash
# Operator external link (all locales)
for p in / /ca/ /en/ /de/; do
  curl -s "http://127.0.0.1:9180$p" | grep -o 'href="https://amvara.de" class="trust__value trust__value--link" target="_blank" rel="noopener noreferrer"'
done
# Security still locale-aware
curl -s http://127.0.0.1:9180/ | grep -o 'href="/security/" class="trust__value trust__value--link"'
curl -s http://127.0.0.1:9180/en/ | grep -o 'href="/en/security/" class="trust__value trust__value--link"'
curl -sI http://127.0.0.1:9180/security/ http://127.0.0.1:9180/en/security/   # 200
# Footer version
curl -s http://127.0.0.1:9180/ | grep -oE 'Versión [0-9.]+'   # Versión 1.2.6
```

Coder evidence (2026-07-19): locales `/` `/ca/` `/en/` `/de/` `/doc/` → 200; trust operator markup present with `https://amvara.de` + blank + noopener; Security → `/security/` and `/en/security/`; footer `Powered by` → `https://amvara.de`; footer **Versión 1.2.6**.

### Hard gate protocol
| Item | Value |
|------|-------|
| Reference | Prior trust strip with plain-text AMVARA CONSULTING S.L. |
| KM0 URL | http://127.0.0.1:9180/ and http://127.0.0.1:9180/en/ |
| Decisive viewport | `#trust` fact strip directly under the hero |

**Parity claims:**
1. **Clickable operator:** AMVARA CONSULTING S.L. is a link to `https://amvara.de`.
2. **External safety:** `target="_blank"` and `rel` include noopener noreferrer.
3. **Security still linked:** Detalle/Security item still reaches `/security/` (locale-aware).

**Anti-slop claims:**
1. Remains a quiet text link in the fact strip (not a primary button).
2. No purple / pill / new icon row.
3. No invented metrics or louder trust redesign.

## References
- Issue: https://github.com/AMVARA-CONSULTING/km0-web/issues/113
- `src/components/TrustSignals.astro`
- `src/i18n/types.ts` (`trust.items`)
- docs/runbook.md

## Test report

1. **Date/time (UTC) and log window:** Start `2026-07-19T00:15:45Z`, end `2026-07-19T00:15:51Z`. `docker logs --since 2026-07-19T00:15:45Z km0-web`.
2. **Environment:** Branch `main`, `http://127.0.0.1:9180` (footer **1.2.6**). Playwright → `autoagents/.runtime/tester-113/`. Production previously **200** / Versión 1.2.6.
3. **What was tested:** Trust operator external link on four locales; blank+noopener; security locale links; footer poweredBy normalize; hard gate on `#trust`; em-dash/mailto.
4. **Results:**
   - Operator `<a href="https://amvara.de">`: **PASS** - present on `/` `/ca/` `/en/` `/de/` with text AMVARA CONSULTING S.L.
   - External safety: **PASS** - `target="_blank"` `rel="noopener noreferrer"`.
   - Security still linked: **PASS** - `/security/` and `/en/security/` (HTTP 200); trust markup `trust__value--link`.
   - Quiet text link (anti-slop): **PASS** - classes `trust__value trust__value--link` (not `btn-primary`); screenshots `01-trust-es.png`, `02-trust-en.png`.
   - Footer poweredBy → `https://amvara.de` (no hash): **PASS**.
   - Version / checks: **PASS** - Versión 1.2.6; em-dash/mailto OK; `/doc/` 200.
   - Hard gate parity (3) + anti-slop (3): **PASS**.
5. **Overall: PASS**
6. **URLs:** `http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/` `/security/` `/en/security/`.
7. **Logs:** Locale + Playwright GETs **200** in window.

