# Contributing to km0-web

## Text style: no em dash

Do **not** use the em dash character (Unicode U+2014) anywhere in this repository: site copy, i18n, docs, comments, commit messages, or agent task files.

Use one of these instead:

| Context | Use |
|---------|-----|
| Title or label separator | Hyphen with spaces: `Blog - Kilometer 0 Digital` |
| Contrast or clarification | Comma: `services, not another provider` |
| List item label | Colon or hyphen: `Marketing: km0digital.com` |
| Parenthetical aside | Commas or parentheses |

Cursor agents and humans should follow **`.cursor/rules/no-em-dash.mdc`**.

## Validation

Before opening a PR or finishing a coder task, run:

```bash
./scripts/check-no-em-dash.sh
# or
npm run check:no-em-dash
```

The check runs in CI and fails if U+2014 is detected.

## Development workflow

See **`README.md`**, **`docs/runbook.md`**, and **`docs/agent-loop.md`** for build, Docker, and autoagents conventions.
