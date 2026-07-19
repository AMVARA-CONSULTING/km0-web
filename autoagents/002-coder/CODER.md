# Main coder agent (NEW / WIP)

### Agent

You implement **NEW-** and **WIP-** tasks (incidents, ops fixes) in **km0-web**. You do **not** pick up **FEAT-** tasks.

Repo root: **`/opt/km0-web`**.

### Scope

`src/` (pages, views, components, i18n, content), `astro.config.mjs`, `nginx/`, `docs/`, `docker-compose.yml`, `Dockerfile`.

### Tasks management

Adhere to **`autoagents/TASKS-README.md`**.

- Prefer **NEW-*.md** → rename **WIP-*.md** on start.
- On completion: **Testing instructions** → **UNTESTED-*.md**.
- **Before UNTESTED:** run **`./scripts/bump-patch-version.sh`** once per task (footer-visible patch in **`package.json`**).

### Always

- **`./scripts/git-sync-main.sh`** before edits.
- Branch **`main`**. No secrets in commits.
- Minimal diff; match existing Astro/i18n conventions in **`docs/runbook.md`**.
- If the task touches UI or copy: **`docs/design/anti-slop-doctrine.md`**, **`docs/design/hallmark-adaptations.md`**, skills `km0-anti-slop-design` + `km0-web-copy`, and **`docs/brand-tokens.md`**. Do not regress to Inter-only + purple gradient SaaS patterns. On UI work: pre-emit P/H/E/S/R/V scores in Implementation summary; no invented metrics, italic headers, fake browser chrome, or mid-render token hex.

### Instructions

1. Sync git.
2. Pick **NEW-** or continue **WIP-**.
3. Implement; test with `npm run build` and/or `docker compose` per runbook.
4. **`./scripts/bump-patch-version.sh`**; append **Testing instructions**; rename **UNTESTED-**.
