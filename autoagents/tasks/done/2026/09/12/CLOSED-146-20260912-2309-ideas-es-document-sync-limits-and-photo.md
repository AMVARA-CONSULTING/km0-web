---
## Closing summary (TOP)

- **What happened:** Issue #146 asked for clear public docs on desktop sync, phone photo backup, and unlink-vs-delete before photo-loss outreach.
- **What was done:** Shipped `desktop-sync` and `photo-backup` tutorials in es/ca/en/de, FAQ items (150 GB honesty, sync, photos, unlink), cross-links from getting-started and protect-family-photos; honest OpenCloud wording (no Known Folder Move; HEIC conversion opt-in; unlink does not delete local files).
- **What was tested:** Tester PASS: HTTP 200 on homes/doc and eight tutorial URLs; trust string greps; tutorials index; footer 1.3.17; em-dash/mailto clean; no 5xx. Craft hard gate N/A (docs/FAQ).
- **Why closed:** All testing criteria passed; anti-slop skim OK (content/FAQ, no hero/slop remodel).
- **Closed at (UTC):** 2026-09-12 23:45
---

# [ideas/es] Document sync limits and photo backup before outreach

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/146
- **Number:** #146
- **Labels:** agent:planned, agent:wip
- **Created:** 2026-09-12T06:29:45Z

## Problem / goal
## Summary  Ralf asks km0digital to publish clear product documentation before scaling outreach to people who lost photo libraries. He flags the 150 GB plan as a likely bottleneck and wants that said up front. He wants three written explanations on the site: how desktop sync works (including selective sync and unsync behavior), the photo backup path on Android/iOS (original size, no silent recompress, restore if the phone dies), and a policy that unlinking the client does not delete local files.

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/146
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md
- Fact sources: OpenCloud docs (desktop sync settings Linux/macOS/Windows; iOS Auto Upload; Android settings)

## Implementation summary
- Published two Cloud tutorials in es/ca/en/de: `desktop-sync` (selective sync, Windows VFS, no Known Folder Move, unlink vs delete-while-syncing, 150 GB honesty) and `photo-backup` (Android/iOS Auto Upload, optional HEIC/MP4 conversion left off for originals, restore path, 150 GB honesty).
- Extended tutorial `platform` enum with `desktop` and `mobile` in `src/content.config.ts`.
- Added four FAQ items on all locales: `storage-150gb`, `desktop-sync`, `photo-backup`, `unlink-local-files`, linking to the tutorials.
- Cross-linked from getting-started Android/iOS tutorials and `protect-family-photos` guides.
- Honest claims only: did **not** ship absolute "no silent recompress" (iOS conversion is opt-in); official OpenCloud wording for Remove Sync Folder Connection; two-way sync delete risk stated.
- Pricing TB-on-request pitch left to #147/#148; capacity honesty line only here.
- Site version bumped `1.3.15` → `1.3.16` via `./scripts/bump-patch-version.sh`.
- Pre-emit (docs/FAQ, existing reading chrome): P4 H4 E4 S5 R4 V4 - factual trust docs, no hero remodel, no invented metrics.

## Testing instructions

1. **HTTP smoke**
   ```bash
   curl -sI http://127.0.0.1:9180/ http://127.0.0.1:9180/ca/ http://127.0.0.1:9180/en/ http://127.0.0.1:9180/de/ http://127.0.0.1:9180/doc/
   ```
   Expect `200` on each.

2. **New tutorials (all locales)**
   ```bash
   for p in \
     /tutorials/desktop-sync/ /tutorials/photo-backup/ \
     /ca/tutorials/desktop-sync/ /ca/tutorials/photo-backup/ \
     /en/tutorials/desktop-sync/ /en/tutorials/photo-backup/ \
     /de/tutorials/desktop-sync/ /de/tutorials/photo-backup/
   do curl -sI -o /dev/null -w "%{http_code} $p\n" "http://127.0.0.1:9180$p"; done
   ```
   Expect `200` on all eight.

3. **Three trust answers on the public site**
   ```bash
   curl -s http://127.0.0.1:9180/en/tutorials/desktop-sync/ | grep -F 'Known Folder Move'
   curl -s http://127.0.0.1:9180/en/tutorials/desktop-sync/ | grep -F 'Remove Sync Folder Connection'
   curl -s http://127.0.0.1:9180/en/tutorials/photo-backup/ | grep -F 'Convert HEIC to JPEG'
   curl -s http://127.0.0.1:9180/en/tutorials/photo-backup/ | grep -F 'If the phone dies'
   curl -s http://127.0.0.1:9180/en/ | grep -F 'Do you delete my local files when I unlink the client?'
   curl -s http://127.0.0.1:9180/ | grep -F '¿Bastan 150 GB para toda una vida de fotos?'
   ```
   Each must match. Desktop tutorial must state there is **no** Known Folder Move. Photo tutorial must mention optional conversion (not silent default recompress). FAQ must include unlink and 150 GB honesty.

4. **Tutorials index lists both**
   ```bash
   curl -s http://127.0.0.1:9180/en/tutorials/ | grep -E 'desktop-sync|photo-backup'
   curl -s http://127.0.0.1:9180/tutorials/ | grep -E 'desktop-sync|photo-backup'
   ```

5. **Footer version**
   ```bash
   curl -s http://127.0.0.1:9180/en/ | grep -oE 'Version [0-9.]+'
   ```
   Expect `Version 1.3.16` (or the patch after this task's bump).

6. **Em dash / mailto**
   ```bash
   ./scripts/check-no-em-dash.sh
   ./scripts/check-no-mailto.sh
   ```

Coder evidence (2026-09-12): `docker compose build && docker compose up -d` PASS; steps 1-5 PASS; footer `Version 1.3.16`; tutorials and FAQ strings present on ES/EN sample paths.

## Test report

1. **Date/time (UTC):** 2026-09-12T23:43:52Z start → 2026-09-12T23:45:00Z end. Log window: `docker logs --since 2026-09-12T23:43:52Z km0-web`.
2. **Environment:** branch `main` (synced, up to date with origin). Build: `docker compose build && docker compose up -d` (image layers cached; serving current tree). Loopback `http://127.0.0.1:9180`. Footer package version on disk/serve: **1.3.17** (stacked after #147 bump; criterion allows patch after 1.3.16).
3. **What was tested:** HTTP smoke (home locales + `/doc/`); all eight desktop-sync / photo-backup tutorial URLs; trust string greps; tutorials index listing; footer version; `./scripts/check-no-em-dash.sh` and `./scripts/check-no-mailto.sh`; docker access log review for 5xx.
4. **Results:**
   - HTTP smoke `/`, `/ca/`, `/en/`, `/de/`, `/doc/`: **PASS** (all 200).
   - Tutorials eight paths: **PASS** (all 200).
   - Desktop trust: **PASS** (`No Known Folder Move` heading; `Remove Sync Folder Connection` + official “does not delete the local files”).
   - Photo trust: **PASS** (`Convert HEIC to JPEG` as opt-in; `If the phone dies or is lost`).
   - FAQ: **PASS** (EN unlink question on `/en/`; ES `¿Bastan 150 GB para toda una vida de fotos?` on `/`).
   - Tutorials index lists both: **PASS** (`desktop-sync` + `photo-backup` on `/en/tutorials/` and `/tutorials/`).
   - Footer version: **PASS** (`Version 1.3.17` / `Versión 1.3.17`; meets “1.3.16 or later”).
   - Em dash / mailto: **PASS** (both scripts OK).
   - Hallmark/craft hard gate: **N/A** (docs/FAQ content; pre-emit scores present in Implementation summary).
5. **Overall: PASS**
6. **URLs tested:** `http://127.0.0.1:9180/` `{,/ca/,/en/,/de/,/doc/}`; eight tutorial paths; `/en/tutorials/`, `/tutorials/`; `https://km0digital.com/` HEAD 200 (site up; production content may lag until committer deploy).
7. **Log excerpts:** nginx start `23:44:03Z`; sample `GET /en/tutorials/desktop-sync/ 200`, `GET /en/tutorials/photo-backup/ 200`, `GET /en/ 200`; **0** `5xx` lines in `--since 10m` window.
