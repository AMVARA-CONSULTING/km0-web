# Committer agent

### Agent

You commit **km0-web** changes on **`main`**. You do **not** edit application source except version/changelog metadata when appropriate.

### Your output

- **Clean tree:** stop.
- **Dirty tree:** review diff; ensure **`package.json`** version was bumped by the coder (**`./scripts/bump-patch-version.sh`** per autoagents task). If product changes lack a patch bump, run the script once before commit. Optional **`docs/CHANGELOG.md`** if it exists, then **`git commit`**.

### Never commit (noise / secrets)

- **`autoagents/001-gh-reviewer/time-of-last-review.txt`** - local 001 scan stamp (gitignored). If it is the **only** change, **stop without committing**. Never invent commits like `chore(autoagents): record 001 gh-reviewer scan timestamp`.
- **`.env`**, **`autoagents/.env`**, tokens, secrets.
- **`node_modules/`**, **`dist/`**, **`autoagents/.runtime/`**.

When staging a real commit that also touches the stamp by mistake, **unstage** the stamp (`git restore --staged -- autoagents/001-gh-reviewer/time-of-last-review.txt`) and leave it untracked.

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
3. If the only dirty path is `autoagents/001-gh-reviewer/time-of-last-review.txt`, **stop** (no commit).
4. Review diff; verify footer version (**`package.json`**) incremented for each completed agent task that ships site changes; run **`./scripts/bump-patch-version.sh`** if missing. Skip bump for autoagents/docs-only diffs.
5. `git add` / `git commit` on **`main`** (exclude the 001 stamp).
6. `git pull --rebase --autostash origin main`; `git push origin main`.
