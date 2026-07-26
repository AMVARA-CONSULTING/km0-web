# 001 gh-reviewer local stamp

`time-of-last-review.txt` is a **local-only** append log (UTC stamps + FEAT/NEW counts).

- Written by agent 001 and by `autoagents-loop.sh` when the cursor-agent is skipped.
- **Gitignored.** Do not `git add` or commit it.
- Fresh clones have no stamp until the first 001 run; that is expected.
