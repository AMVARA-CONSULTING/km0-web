---
## Closing summary (TOP)

- **What happened:** Issue #139 requested two KM0 Cloud web tutorials (file sharing and Space permissions) in four locales.
- **What was done:** Added `sharing-files` and `space-permissions` tutorials under `src/content/tutorials/{es,ca,en,de}/` with cross-links and OpenCloud 4.x-aligned steps; site version bumped to 1.3.2.
- **What was tested:** Docker build/deploy PASS; HTTP 200 on all tutorial routes and locale indexes; content sections, cross-links, footer version, and em-dash/mailto policy checks PASS.
- **Why closed:** All testing instructions and content checks passed; no UI/craft-parity scope or anti-slop regressions.
- **Closed at (UTC):** 2026-08-24 14:03
---

# [ideas/es] Tutoriales Opencloud: compartir archivos y permisos en spaces

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/139
- **Number:** #139
- **Labels:** agent:wip → agent:untested → agent:testing → CLOSED (pass)
- **Created:** 2026-08-24T13:53:51Z

## Problem / goal
Add two KM0 Cloud web tutorials requested via ideas intake:
1. Sharing files/folders inside and outside the organization (internal invite, public link, optional password).
2. Granting and revoking Space permissions for existing users.

## Implementation summary
- Added tutorial `sharing-files` (order 5, platform web, product cloud) in es/ca/en/de under `src/content/tutorials/{locale}/sharing-files.md`.
- Added tutorial `space-permissions` (order 6, platform web, product cloud) in es/ca/en/de under `src/content/tutorials/{locale}/space-permissions.md`.
- Content follows existing tutorial HTML structure (`doc-lead-block`, `doc-block`, step sections, troubleshooting).
- Cross-links between the two tutorials and to `getting-started-web`.
- Steps aligned with OpenCloud 4.x web UI (Internal sharing, Public links, Members menu, Can view/edit/manage roles).
- Site version bumped: **1.3.1 → 1.3.2** (`package.json`).

### Copy self-critique (P/H/E/S/R/V)
- **P (Purpose):** 5 - Direct answer to issue #139 (two tutorials, four locales).
- **H (Honesty):** 5 - No invented metrics; UI labels match OpenCloud docs.
- **E (Economy):** 5 - Step lists, no marketese.
- **S (Structure):** 5 - Inverted pyramid, meaningful H2s, one idea per block.
- **R (Recognition):** 5 - Reuses KM0 Cloud / Space naming from existing tutorials.
- **V (Voice):** 5 - Objective, scan-first, no em dashes.

## Testing instructions

### Build and deploy
```bash
./scripts/git-sync-main.sh
docker compose build && docker compose up -d
docker logs --since 5m km0-web
```

### HTTP smoke (expect 200)
```bash
curl -sI http://127.0.0.1:9180/tutorials/sharing-files/
curl -sI http://127.0.0.1:9180/tutorials/space-permissions/
curl -sI http://127.0.0.1:9180/en/tutorials/sharing-files/
curl -sI http://127.0.0.1:9180/ca/tutorials/space-permissions/
curl -sI http://127.0.0.1:9180/de/tutorials/sharing-files/
curl -sI http://127.0.0.1:9180/tutorials/
```

### Content checks
1. Open `/tutorials/` (ES): under **KM0 Cloud**, confirm both new entries appear after macOS tutorial:
   - "Cómo compartir archivos y carpetas en KM0 Cloud"
   - "Cómo dar y quitar permisos en un Space"
2. Repeat for `/en/tutorials/`, `/ca/tutorials/`, `/de/tutorials/` (localized titles).
3. Open `/tutorials/sharing-files/` and verify sections cover: internal share, public link (with/without password), remove access, troubleshooting.
4. Open `/tutorials/space-permissions/` and verify sections cover: roles (Can view/edit/manage), add member, change role, remove member.
5. Confirm cross-links work: sharing-files → space-permissions and back.
6. Footer shows **Versión 1.3.2** (or current patch after any later bump).

### Policy checks (run in build container or CI)
```bash
./scripts/check-no-em-dash.sh
./scripts/check-no-mailto.sh
```

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md
- OpenCloud user docs: https://docs.opencloud.eu/docs/user/sharing/internal , https://docs.opencloud.eu/docs/user/sharing/external , https://docs.opencloud.eu/docs/user/spaces/add-members/

## Test report

1. **Date/time (UTC) and log window:** Start 2026-08-24T14:02:11Z (UNTESTED → TESTING + `agent:testing`). Docker rebuild/up 14:02:17Z–14:02:22Z. Checks 14:02:24Z–14:02:32Z. Report close 14:02:32Z. Docker log window 14:02:22Z–14:02:24Z.

2. **Environment:** Branch `main` at `e6f7efd` (local uncommitted ship under test, package `1.3.2`). Build: `docker compose build && docker compose up -d` (Astro `1.3.2`, em-dash/mailto prebuild OK, 176 pages). Loopback `http://127.0.0.1:9180/`. Production verification **N/A** (not required by Testing instructions).

3. **What was tested:** Docker build/deploy; HTTP smoke on tutorial routes (ES + en/ca/de); tutorial index listings under KM0 Cloud; sharing-files and space-permissions section coverage; cross-links; footer version; em-dash/mailto policy checks; docker access logs.

4. **Results:**
   - **Build and deploy:** **PASS** - `docker compose build` completed; container `km0-web` up on `127.0.0.1:9180->80`; Astro build emitted `/tutorials/sharing-files/`, `/tutorials/space-permissions/`, and locale variants (8 new tutorial pages).
   - **HTTP smoke (200):** **PASS** - All instructed URLs returned **200**: `/tutorials/sharing-files/`, `/tutorials/space-permissions/`, `/en/tutorials/sharing-files/`, `/ca/tutorials/space-permissions/`, `/de/tutorials/sharing-files/`, `/tutorials/`. Extended: all 8 tutorial pages + `/en/tutorials/`, `/ca/tutorials/`, `/de/tutorials/` also **200**.
   - **Content check 1 (ES index):** **PASS** - `/tutorials/` lists under KM0 Cloud after macOS: "Cómo compartir archivos y carpetas en KM0 Cloud" (order 5) and "Cómo dar y quitar permisos en un Space" (order 6).
   - **Content check 2 (locale indexes):** **PASS** - `/en/tutorials/` ("How to share…", "How to grant and revoke…"), `/ca/tutorials/` ("Com compartir…", "Com donar i treure…"), `/de/tutorials/` ("Dateien und Ordner…", "Space-Berechtigungen…").
   - **Content check 3 (sharing-files sections):** **PASS** - ES page includes internal share (`Compartir internamente`), public links (`Enlaces públicos`, `Contraseña`), remove access (`Quitar o cambiar un acceso`), troubleshooting (`Solución de problemas`).
   - **Content check 4 (space-permissions sections):** **PASS** - ES page includes roles (`Puede ver`, `Puede editar`, `Puede gestionar`), add member (`Añadir un miembro`), change role (`Cambiar permisos`), remove member (`Quitar a un miembro`).
   - **Content check 5 (cross-links):** **PASS** - `sharing-files` links to `/tutorials/space-permissions/`; `space-permissions` links to `/tutorials/sharing-files/` (both targets **200**).
   - **Content check 6 (footer version):** **PASS** - Footer shows `Versión 1.3.2` (ES) and `Version 1.3.2` (EN); `package.json` `"1.3.2"`.
   - **Policy checks:** **PASS** - `./scripts/check-no-em-dash.sh` OK; `./scripts/check-no-mailto.sh` OK; same checks passed inside Docker prebuild.
   - **GitHub label:** **PASS** - `agent:testing` on #139 at start; removed on PASS → CLOSED.

5. **Overall: PASS**

6. **URLs tested:** `http://127.0.0.1:9180/tutorials/`, `/tutorials/sharing-files/`, `/tutorials/space-permissions/`, `/en/tutorials/`, `/en/tutorials/sharing-files/`, `/en/tutorials/space-permissions/`, `/ca/tutorials/`, `/ca/tutorials/sharing-files/`, `/ca/tutorials/space-permissions/`, `/de/tutorials/`, `/de/tutorials/sharing-files/`, `/de/tutorials/space-permissions/`.

7. **Log excerpts:**
   ```
   km0-web Up 127.0.0.1:9180->80/tcp (started 2026/08/24 14:02:22)
   Astro build: 176 page(s) built; sharing-files + space-permissions in es/ca/en/de
   HEAD /tutorials/sharing-files/ 200
   HEAD /tutorials/space-permissions/ 200
   check-no-em-dash: OK; check-no-mailto: OK
   ```

8. **GitHub:** label `agent:testing` on #139 at start; removed on PASS → CLOSED.
