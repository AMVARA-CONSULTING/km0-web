---
## Closing summary (TOP)

- **What happened:** GitHub issue #11 requested explicit Collabora Online implementation details in day 3 and day 4 blog posts.
- **What was done:** Added Collabora Online (WOPI) sections to day-3 and day-4 blog posts in all four locales, covering in-browser XLSX/PPT/DOCX editing and simultaneous multi-user co-editing.
- **What was tested:** Tester PASS: footer 1.1.17, HTTP smoke 200, Collabora content on day-3/day-4 all locales, WOPI summary bullet, no em dash in edited blog files.
- **Why closed:** All testing criteria passed.
- **Closed at (UTC):** 2026-06-01 12:55
---

# Add Collabora implementation details to blog

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/11
- **Number:** #11
- **Labels:** none
- **Created:** 2026-06-01T12:45:09Z

## Problem / goal
Add Collabora implementation details to blog. Review the blog entries for days 3 and 4 and verify whether the Collabora implementation is clearly explained. If it is not, we need to add a section describing it. The blog should explicitly mention that, thanks to Collabora, users can edit office files such as XLSX and PPT, and that these documents can be edited simultaneously by multiple users.

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/11
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Implementation summary
- **Day 3** (`src/content/doc/{ca,de,en,es}/day-3.md`): added OpenCloud **Collabora Online (WOPI)** section (in-browser XLSX/PPT/DOCX editing, simultaneous co-editing, stack notes); updated OpenCloud milestone bullet in summary.
- **Day 4** (`src/content/doc/{ca,de,en,es}/day-4.md`): added **Collabora** section linking unified Dex LDAP login to multi-user Office co-editing (XLSX/PPT).
- Site version bumped: **1.1.16 → 1.1.17** (`package.json`).

## Testing instructions
1. `docker compose build && docker compose up -d` from repo root.
2. Confirm footer shows **1.1.17** on `/`, `/ca/`, `/en/`, `/de/`.
3. HTTP 200 on `/`, `/ca/`, `/en/`, `/de/`, `/doc/`.
4. **Day 3** (all locales): page contains heading **Collabora Online (WOPI)** and text about editing `XLSX`, `PPT`, and simultaneous co-editing.
   - ES: `/doc/day-3/`
   - EN: `/en/doc/day-3/`
   - CA: `/ca/doc/day-3/`
   - DE: `/de/doc/day-3/`
5. **Day 4** (all locales): page contains Collabora section about co-editing after unified login and `XLSX`/`PPT` multi-user editing.
   - ES: `/doc/day-4/`
   - EN: `/en/doc/day-4/`
   - CA: `/ca/doc/day-4/`
   - DE: `/de/doc/day-4/`
6. Day 3 summary bullet for OpenCloud mentions Collabora Online via WOPI.
7. No em dash (U+2014) in edited blog files.

## Test report

1. **Date/time (UTC):** 2026-06-01T12:53:19Z – 2026-06-01T12:54:34Z. Log window: nginx startup at 12:53:55Z.
2. **Environment:** branch `main`, `docker compose build && docker compose up -d`. URLs: loopback paths below; production `https://km0digital.com/`.
3. **What was tested:** Footer 1.1.17, HTTP smoke, day-3/day-4 Collabora content (all locales), day-3 summary WOPI bullet, em dash in edited blog files.
4. **Results:**
   - Docker build/up: **PASS**
   - Footer **1.1.17** on `/`, `/ca/`, `/en/`, `/de/`: **PASS**
   - HTTP 200 on `/`, `/ca/`, `/en/`, `/de/`, `/doc/`: **PASS**
   - Day 3 **Collabora Online (WOPI)**, XLSX/PPT, simultaneous co-editing (ES/EN/CA/DE paths): **PASS** (rendered `/doc/day-3/`, `/en/doc/day-3/`, `/ca/doc/day-3/`, `/de/doc/day-3/` all `200`; headings and keywords present)
   - Day 4 Collabora section, unified login, XLSX/PPT multi-user (all locales): **PASS** (`/doc/day-4/`, `/en/doc/day-4/`, `/ca/doc/day-4/`, `/de/doc/day-4/` `200`; Collabora + XLSX + PPT in HTML)
   - Day 3 summary OpenCloud bullet mentions Collabora Online via WOPI: **PASS** (source `day-3.md` all locales)
   - No em dash in `src/content/doc/**/day-{3,4}.md`: **PASS**
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/` (+ `/ca/`, `/en/`, `/de/`, `/doc/`), day-3/4 paths per locale; `https://km0digital.com/` (`200`).
7. **Log excerpts:** nginx 1.31.1 started 12:53:55Z; Astro build in image logged `km0-web@1.1.17 build` success.
