---
## Closing summary (TOP)

- **What happened:** GitHub issue #9 requested pinning transitive dependencies and documenting npm lockfile best practices.
- **What was done:** Added `.npmrc` with `save-exact=true`, updated the Dockerfile to copy it before `npm ci`, and documented the `npm ci`-only workflow in README, runbook, and project summary.
- **What was tested:** Tester PASS: `.npmrc` and Dockerfile verified, Docker build with `npm ci`, HTTP smoke 200 on all locale paths, dependency docs reviewed, double `npm ci` left lockfile unchanged.
- **Why closed:** All testing criteria passed.
- **Closed at (UTC):** 2026-06-01 12:55
---

# Pin the versions in package-lock.json

## GitHub Issue
- **Issue:** https://github.com/AMVARA-CONSULTING/km0-web/issues/9
- **Number:** #9
- **Labels:** none
- **Created:** 2026-06-01T12:27:38Z

## Problem / goal
We have already pinned the package versions in package.json to avoid libraries updating themselves automatically (WE ABSOLUTELY DO NOT WANT THIS). Now we also need to pin the libraries that are likely coming in as transitive dependencies via package-lock.json. Since these libraries and this file are usually regenerated, the most convenient approach is probably to research what the current best practices are to properly solve this problem.

## Implementation summary

- Added **`.npmrc`** with `save-exact=true` and `package-lock=true` so new direct dependencies are exact pins and the lockfile is always maintained.
- Transitive dependencies remain pinned in committed **`package-lock.json`** (resolved URLs + integrity hashes); installs use **`npm ci`** only.
- Updated **`Dockerfile`** to copy `.npmrc` into the build stage before `npm ci`.
- Documented workflow in **`README.md`**, **`docs/runbook.md`**, and **`docs/km0-web-resumen-proyecto.red`** (use `npm ci`, avoid bare `npm install`/`npm update`, deliberate bumps via `npm install --package-lock-only`).
- Site version bumped to **1.1.16**.

## High-level instructions for coder
- Read the full issue at https://github.com/AMVARA-CONSULTING/km0-web/issues/9
- Identify affected paths under src/, astro.config.mjs, docs/
- Implement minimal, on-scope changes for km0-web (Astro + i18n)
- Add **Testing instructions** before renaming to UNTESTED-

## References
- Repo: https://github.com/AMVARA-CONSULTING/km0-web
- Runbook: docs/runbook.md

## Testing instructions

1. Confirm **`.npmrc`** exists at repo root with `save-exact=true` and `package-lock=true`.
2. Confirm **`Dockerfile`** copies `.npmrc` alongside `package.json` and `package-lock.json` before `RUN npm ci`.
3. Build and deploy: `docker compose build && docker compose up -d` (expect `npm ci` in build log, no lockfile rewrite).
4. Smoke HTTP (all **200 OK**):
   - `curl -sI http://127.0.0.1:9180/`
   - `curl -sI http://127.0.0.1:9180/ca/`
   - `curl -sI http://127.0.0.1:9180/en/`
   - `curl -sI http://127.0.0.1:9180/de/`
   - `curl -sI http://127.0.0.1:9180/doc/`
5. Read **`README.md`** section **Dependencies** and **`docs/runbook.md`** section **Dependencies (npm)**; verify they describe `npm ci`, lockfile pinning, and deliberate bump workflow.
6. Optional: in a Node 22 environment, run `npm ci` twice; second run should report no changes to `package-lock.json`.

## Test report

1. **Date/time (UTC):** 2026-06-01T12:53:19Z – 2026-06-01T12:54:34Z. Log window: nginx startup at 12:53:55Z.
2. **Environment:** branch `main`, build `docker compose build && docker compose up -d` (host has no `npm`; Astro build ran inside image via `npm ci` + `npm run build` @ 1.1.17). URLs: loopback `http://127.0.0.1:9180/`, production `https://km0digital.com/`.
3. **What was tested:** `.npmrc`, `Dockerfile` copy order, Docker build log (`npm ci`), HTTP smoke, README/runbook dependency docs, optional double `npm ci` in `node:22-alpine`.
4. **Results:**
   - `.npmrc` with `save-exact=true` and `package-lock=true`: **PASS** (file present at repo root).
   - `Dockerfile` copies `.npmrc` before `RUN npm ci`: **PASS** (`COPY package.json package-lock.json .npmrc ./`).
   - Docker build uses `npm ci`, no lockfile rewrite in log: **PASS** (step `#13 [build 4/6] RUN npm ci` cached; build completed).
   - HTTP smoke `/`, `/ca/`, `/en/`, `/de/`, `/doc/`: **PASS** (all `200`).
   - README **Dependencies** + runbook **Dependencies (npm)**: **PASS** (document `npm ci`, lockfile pinning, deliberate bump workflow).
   - Optional double `npm ci`: **PASS** (`docker run node:22-alpine` twice; no lockfile change reported).
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/`, `/ca/`, `/en/`, `/de/`, `/doc/`; `https://km0digital.com/` (polled once, `200`).
7. **Log excerpts:** `2026/06/01 12:53:55 [notice] 1#1: nginx/1.31.1` … `start worker process 36` (container healthy after recreate).
