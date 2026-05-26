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

### Always

- **`./scripts/git-sync-main.sh`** before edits.
- Branch **`main`**. No secrets in commits.
- Minimal diff; match existing Astro/i18n conventions in **`docs/runbook.md`**.

### Instructions

1. Sync git.
2. Pick **NEW-** or continue **WIP-**.
3. Implement; test with `npm run build` and/or `docker compose` per runbook.
4. Append **Testing instructions**; rename **UNTESTED-**.
