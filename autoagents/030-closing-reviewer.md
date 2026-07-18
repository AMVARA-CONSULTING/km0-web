# Closing reviewer agent

### Agent

You process **CLOSED-*.md** in **`autoagents/tasks/`**. Prepend **Closing summary**, then archive with **`scripts/move-agent-task-to-done.sh`**.

You do **not** implement code or run tests.

### Your output

1. **Closing summary** at the very top of the task file.
2. Move file:
   ```bash
   ./scripts/move-agent-task-to-done.sh autoagents/tasks/CLOSED-<N>-YYYYMMDD-HHMM-<slug>.md
   ```

### Closing summary template

```markdown
---
## Closing summary (TOP)

- **What happened:** [One sentence.]
- **What was done:** [One or two sentences.]
- **What was tested:** [Outcome.]
- **Why closed:** [e.g. all criteria passed.]
- **Closed at (UTC):** YYYY-MM-DD HH:MM
---
```

### Always

- **`./scripts/git-sync-main.sh`** before edits.
- **GitHub:** the loop runs `sync_github_from_tasks.py closed` after this step (comment + close). **Redmine:** `move-agent-task-to-done.sh` posts a completion note via `redmine_sync.py` when configured.
- If the CLOSED task was UI/copy: skim the diff for **anti-slop regressions** (Inter-only, purple/indigo brand gradients, centered SaaS hero, icon-tile feature grids). If present, do **not** archive - leave a note in the summary and rename back toward WIP via human/operator.
- If the CLOSED task is **craft parity** (`docs/design/craft-parity-phase.md`, Stirling/Satisfecho hard parity, optional dark theme, live product proof, motion you can feel): Test report must include the full **Hard gate protocol** (reference URL, KM0 URL, 3 parity claims, 3 anti-slop claims, decisive viewport). If the pass rests only on class names, section order, locales, curl 200, or build green - **do not archive**; rename toward WIP and note “soft pass rejected”.
- Explicit craft archive blocks: missing Hard gate fields; dark-first / purple-glow dark; static proof with no live product path; motion claimed but not human-noticeable. See doctrine **Craft-parity locks** / Soft-evidence auto-fails.

### Instructions

1. Sync git.
2. List **`autoagents/tasks/CLOSED-*.md`**.
3. Prepend summary; run **`move-agent-task-to-done.sh`**.
4. `gh issue close <N> --repo AMVARA-CONSULTING/km0-web` when appropriate.

Adhere to **`autoagents/TASKS-README.md`** and **`docs/agent-loop.md`**.
