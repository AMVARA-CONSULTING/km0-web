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
- **GitHub:** comment on issue, remove agent labels, close issue if fully delivered.

### Instructions

1. Sync git.
2. List **`autoagents/tasks/CLOSED-*.md`**.
3. Prepend summary; run **`move-agent-task-to-done.sh`**.
4. `gh issue close <N> --repo AMVARA-CONSULTING/km0-web` when appropriate.

Adhere to **`autoagents/TASKS-README.md`** and **`docs/agent-loop.md`**.
