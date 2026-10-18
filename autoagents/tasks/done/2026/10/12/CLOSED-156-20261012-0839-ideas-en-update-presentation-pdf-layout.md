---
## Closing summary (TOP)

- **What happened:** Issue #156 asked to regenerate the public presentation PDF to civic-dark layout and replace `hello.yoel@amvara.de` with `info@km0digital.com`.
- **What was done:** Added `presentations/generate_public_pdf.py`, shipped a 9-slide civic-dark PDF, updated `presentation.cta.email` / download hints in all locales, bumped site version to 1.3.30.
- **What was tested:** Tester PASS: HTTP/PDF smoke, email text and visual civic-dark checks, presentation pages (es/en/ca/de), footer 1.3.30, no-mailto, logs, production parity; Hallmark skim clean (no Inter/purple/centered SaaS).
- **Why closed:** All testing criteria passed; anti-slop skim OK; not a craft-parity Hard gate task.
- **Closed at (UTC):** 2026-10-12 08:47
---

# [ideas/en] Update presentation PDF layout and contact email

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/156
- **Number:** #156
- **Labels:** agent:wip
- **Created:** 2026-10-12T08:19:28Z

## Problem / goal
Regenerate the public presentation PDF at `/presentations/km0-digital-tecnologica-kilometro-cero.pdf` to match the civic-dark site layout, and replace the old contact address `hello.yoel@amvara.de` with `info@km0digital.com`.

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/156
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary

- Added `presentations/generate_public_pdf.py` (reportlab) to rebuild the public deck in civic dark tokens (Paper/Ink/Signal/Snow/Mist), split-bias title/CTA with K0 logo, content aligned to `presentation.*` ES copy from the site page.
- Regenerated `public/presentations/km0-digital-tecnologica-kilometro-cero.pdf` (9 slides; CTA contact `info@km0digital.com`; no `hello.yoel@amvara.de`).
- Updated `presentation.cta.email` to `info@km0digital.com` and refresh `downloadHint` in `es`/`ca`/`en`/`de` i18n.
- Site version bump: **1.3.29 → 1.3.30**.
- Pre-emit (PDF visual): P4 H4 E4 S4 R4 V3. Vibe: cool civic editorial. Layout: split-bias. Type: Liberation Sans stand-in for IBM Plex (no Inter). Anchor: Signal teal on Paper. Refused: purple chip rainbow, centered SaaS, light cream deck.
- Mailbox note for submitter (ops, not product code): `@km0digital.com` is KM0 Email on `mail.km0digital.com` (AMVARA-operated). Public landing contact remains `hello@km0digital.com`; presentation/PDF now show `info@km0digital.com` as requested. Confirm `info@` mailbox routing with ops if needed.

## Testing instructions

1. `docker compose build && docker compose up -d` (already done on coder host; footer **Version 1.3.30**).
2. HTTP smoke: `curl -sI http://127.0.0.1:9180/` `/ca/` `/en/` `/de/` `/doc/` `/en/presentation/` `/presentations/km0-digital-tecnologica-kilometro-cero.pdf` → 200 or expected 302 for locale roots.
3. PDF content: download `/presentations/km0-digital-tecnologica-kilometro-cero.pdf`; `pdftotext` last page shows `info@km0digital.com`; zero `hello.yoel@amvara.de`.
4. Visual: open PDF; confirm dark navy Paper, Signal teal kickers/left edge, K0 logo fully visible on title and CTA (not purple/light Google Slides look).
5. Presentation pages `/presentation/` (follow redirect) and `/en/presentation/` show plain text `info@km0digital.com` (no mailto).
6. Footer shows **1.3.30** on `/en/`.
7. `docker logs --since 10m km0-web` - no 5xx on tested paths.
8. Optional regenerate: `python3 presentations/generate_public_pdf.py` (needs reportlab + Liberation Sans + PIL).

## Test report

1. **Date/time (UTC) and log window:** Start 2026-10-12T08:44:23Z; end 2026-10-12T08:46:26Z. Log window: `docker logs --since 2026-10-12T08:44:23Z km0-web`.
2. **Environment:** Branch `main` (synced, ahead of remote with uncommitted coder diff). Build: `docker compose build && docker compose up -d` (image layers cached from coder rebuild; container healthy). Loopback `http://127.0.0.1:9180/`; production `https://km0digital.com/` polled until 302/200.
3. **What was tested:** HTTP smoke (locales, presentation, PDF), PDF text/email, civic-dark visual (pdftoppm PNG + pixel samples), presentation page contact (es/en/ca/de), footer version, no-mailto/no-em-dash scripts, docker logs for 5xx, production PDF + `/en/presentation/` email, Hallmark skim on ship diff.
4. **Results:**
   - **1 Build/deploy** - **PASS.** `docker compose ps`: healthy on `127.0.0.1:9180->80`. `package.json` version `1.3.30`.
   - **2 HTTP smoke** - **PASS.** `/` 302→`/en/`; `/ca/` `/en/` `/de/` 200; `/doc/` 302→`/en/doc/`; `/en/presentation/` 200; `/presentation/` 302 (Accept-Language) / 200 with `Accept-Language: es`; PDF 200 `application/pdf` (59291 bytes, 9 pages).
   - **3 PDF content** - **PASS.** `pdftotext` page 9: `Contacto` / `info@km0digital.com`. Binary/text: zero `hello.yoel@amvara.de`. ReportLab producer; title metadata matches deck.
   - **4 Visual civic-dark** - **PASS.** Title + CTA PNGs: Paper bg RGB~(11,18,32); left Signal edge ~(45,212,191) / logo teal ~(15,118,110); K0 mark on slides 1 and 9; zero purple samples; not light Google Slides aesthetics. Pre-emit scores present in Implementation summary.
   - **5 Presentation contact** - **PASS.** `/presentation/` (es via Accept-Language), `/en/presentation/`, `/ca/presentation/`, `/de/presentation/`: plain `info@km0digital.com`, zero `mailto:`, zero old email. `./scripts/check-no-mailto.sh` OK.
   - **6 Footer version** - **PASS.** `/en/` shows `Version 1.3.30` (loopback and production).
   - **7 Logs** - **PASS.** No 5xx in window on tested paths. Only 404s were intentional `/es/presentation/` → `/en/es/presentation/` probes (default locale is unprefixed `es`).
   - **8 Optional regenerate** - **N/A** (not required; shipped PDF verified).
   - **Hallmark skim** - **PASS.** Diff is PDF + i18n email/downloadHint + version bump only; no italic display headers, fake chrome, metric strips, `transition-all`, or `scale-105`.
   - **Production** - **PASS.** Ready when `https://km0digital.com/` returned 302 and PDF 200 (same 59291 bytes); `/en/presentation/` shows `info@km0digital.com`; footer `Version 1.3.30`.
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/presentation/`, `/en/presentation/`, `/ca/presentation/`, `/de/presentation/`, `/presentations/km0-digital-tecnologica-kilometro-cero.pdf`; `https://km0digital.com/`, `/en/`, `/en/presentation/`, `/presentations/km0-digital-tecnologica-kilometro-cero.pdf`.
7. **Log excerpts:**
   ```
   GET /en/presentation/ HTTP/1.1" 200
   GET /presentations/km0-digital-tecnologica-kilometro-cero.pdf HTTP/1.1" 200 59291
   GET /ca/presentation/ HTTP/1.1" 200
   GET /de/presentation/ HTTP/1.1" 200
   (no " 5xx " lines in window)
   ```
