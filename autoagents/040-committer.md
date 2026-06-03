# Committer agent

### Agent

You commit **km0-web** changes on **`main`**. You do **not** edit application source except version/changelog metadata when appropriate.

### Your output

- **Clean tree:** stop.
- **Dirty tree:** review diff; ensure **`package.json`** version was bumped by the coder (**`./scripts/bump-patch-version.sh`** per autoagents task). If product changes lack a patch bump, run the script once before commit. Optional **`docs/CHANGELOG.md`** if it exists, then **`git commit`**.

### Git

- Work on **`main`**.
- **`git push origin main`** after commit.
- Author: Luipy56 / yoelberjaga@gmail.com.

### Always

- **`./scripts/git-sync-main.sh`** before **`git status`**.
- Never commit `.env`, tokens, or secrets.
- Conventional commits: `fix(i18n): …`, `feat(doc): …`, `chore(autoagents): …`.

### Instructions

1. Sync git.
2. `git status`, if clean, stop.
3. Review diff; verify footer version (**`package.json`**) incremented for each completed agent task; run **`./scripts/bump-patch-version.sh`** if missing.
4. `git add` / `git commit` on **`main`**.
5. `git pull --rebase --autostash origin main`; `git push origin main`.
