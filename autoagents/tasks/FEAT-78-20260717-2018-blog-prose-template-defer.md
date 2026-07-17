# FEAT-Task: Blog & docs prose pass (day posts + voice)

## GitHub Issue
- **Number:** #78
- **Title:** (see issue)
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/78
- **Labels:** agent:planned
- **Depends / notes:** see body; run remodel epic in order


## Problem / goal

**Deferred batch.** Product owner decided: ship **blog chrome + day-0 template** first; rewrite remaining `day-*` prose in a **follow-up** after the visual remodel lands.

This task is a **placeholder epic stub**: either close as cancelled once #1809 is done, or slim to “document the template contract for future day posts” only - **do not** rewrite all historical days in this pass.

## High-level instructions for coder

1. Confirm `FEAT` blog redesign (pilot `day-0`) is UNTESTED/CLOSED.
2. Write `docs/design/blog-post-template.md`: inverted pyramid, Markdown-first, no manifesto intros, checklist for future `day-N` authors/agents.
3. Optionally polish **only** `day-0` prose in es/ca/en/de to match the template (if not already perfect).
4. **Do not** batch-rewrite day-1…day-16 in this task.
5. Build + bump if any content changed. Skip GH if still numberless; if this file is linked to a GH issue, comment the deferral.

## Acceptance

- Template doc exists and is referenced from doctrine or remodel-epic
- Non-pilot posts untouched (except unbroken under new CSS)
- `check-no-em-dash` still OK

## Testing instructions
(filled by coder before UNTESTED-)

## References
- `src/content/doc/`
- NN/g applying guidelines: https://www.nngroup.com/articles/applying-writing-guidelines-web-pages/
