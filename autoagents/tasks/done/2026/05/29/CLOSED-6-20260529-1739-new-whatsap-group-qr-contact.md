---
## Closing summary (TOP)

- **What happened:** GitHub issue #6 requested a clickable WhatsApp group QR in the Contact section.
- **What was done:** Added a WhatsApp QR block in `Contact.astro` with i18n labels (es/ca/en/de), asset `public/contact/whatsapp-group-qr.png`, and invite link to the group; footer version bumped to 1.1.5.
- **What was tested:** Docker build, contact section on all locales, PNG asset (HTTP 200), invite link behavior, footer version, loopback and production spot checks, all PASS.
- **Why closed:** All testing criteria passed.
- **Closed at (UTC):** 2026-05-29 17:46
---

# New whatsap group qr contact

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/6
- **Number:** #6
- **Labels:** none
- **Created:** 2026-05-29T17:36:46Z

## Problem / goal
Añadir al apartado de Contacto, este QR con el link al clickar para que quien quiera pueda conectarse al grupo de whatsap   Link grupo de WhatsApp: https://chat.whatsapp.com/DtU6nBk2KxXJhmZbW94nFs?s=sh&p=a&mlu=1  Extracto QR (tendrás hacer un png más...

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/6
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary
- Added clickable WhatsApp group QR to `src/components/Contact.astro` (links to `https://chat.whatsapp.com/DtU6nBk2KxXJhmZbW94nFs`).
- New asset: `public/contact/whatsapp-group-qr.png`.
- i18n strings (`whatsappLabel`, `whatsappQrAlt`, `whatsappAria`) in es/ca/en/de.
- Footer version bumped to 1.1.5.

## Testing instructions
1. `docker compose build && docker compose up -d`
2. Open `http://127.0.0.1:9180/#contact` (and `/ca/`, `/en/`, `/de/#contact`) - confirm WhatsApp label and QR appear below the email button.
3. Click the QR, should open the WhatsApp group invite in a new tab (`chat.whatsapp.com/DtU6nBk2KxXJhmZbW94nFs`).
4. `curl -sI http://127.0.0.1:9180/contact/whatsapp-group-qr.png`, expect `200` and `Content-Type: image/png`.
5. Footer shows version **1.1.5**.

## Test report

1. **Date/time (UTC):** 2026-05-29T17:43:44Z – 2026-05-29T17:44:53Z. Log window: `docker logs --since 2026-05-29T17:43:44Z km0-web`.
2. **Environment:** branch `main` (commit `67b62cc`, uncommitted coder changes present); `docker compose build && docker compose up -d` (npm unavailable on host); loopback `http://127.0.0.1:9180/`; production `https://km0digital.com/`.
3. **What was tested:** Docker build with version 1.1.5; WhatsApp QR block in contact section on es/ca/en/de; QR PNG asset; WhatsApp invite link (`target="_blank"`, `rel="noopener noreferrer"`); footer version; standard HTTP 200 paths; production spot check.
4. **Results:**
   - `docker compose build` succeeded; build log shows `km0-web@1.1.5 build`: **PASS**
   - Contact section on `/`, `/ca/`, `/en/`, `/de/` shows localized `whatsappLabel`, QR image `/contact/whatsapp-group-qr.png`, and link `https://chat.whatsapp.com/DtU6nBk2KxXJhmZbW94nFs` with `target="_blank"`: **PASS**
   - `curl -sI http://127.0.0.1:9180/contact/whatsapp-group-qr.png` → HTTP 200, `Content-Type: image/png`, 2918 bytes: **PASS**
   - Footer version **1.1.5** on all four locale pages: **PASS**
   - HTTP 200 loopback: `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`: **PASS**
   - Production `https://km0digital.com/` HTTP 200 (first poll, no sleep): **PASS**
   - Production WhatsApp QR present (`whatsapp-group-qr` in HTML), PNG asset HTTP 200, invite URL matches: **PASS**
   - GitHub label `agent:testing` on issue #6: **PASS** (applied at test start)
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/en/doc/day-0/`, `/contact/whatsapp-group-qr.png`; `https://km0digital.com/`, `https://km0digital.com/contact/whatsapp-group-qr.png`
7. **Log excerpts:**
   ```
   > km0-web@1.1.5 build
   2026/05/29 17:44:26 [notice] 1#1: Configuration complete; ready for start up
   172.19.0.1 - - [29/May/2026:17:44:36 +0000] "HEAD /contact/whatsapp-group-qr.png HTTP/1.1" 200 0 "-" "curl/8.14.1"
   172.19.0.1 - - [29/May/2026:17:44:40 +0000] "GET /en/ HTTP/1.1" 200 27233 "-" "curl/8.14.1"
   ```
