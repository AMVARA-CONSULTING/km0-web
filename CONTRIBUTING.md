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

## Contact links: no mailto:

Do **not** use the `mailto:` URI scheme in shipped content (`src/`, `public/`, `email-templates/`). Show email addresses as plain visible text, or link to an on-site contact section. For `security.txt`, use an `https:` Contact URI.

Follow **`.cursor/rules/no-mailto.mdc`**.

## Validation

Checks run in CI, before `npm run dev`, before `npm run build`, and in the **pre-commit** git hook (install with `./scripts/install-git-hooks.sh`; `npm install` runs this automatically when `.git/hooks` exists).

```bash
./scripts/install-git-hooks.sh
./scripts/check-no-em-dash.sh
./scripts/check-no-mailto.sh
# or
npm run check:no-em-dash
npm run check:no-mailto
```

## Development workflow

See **`README.md`**, **`docs/runbook.md`**, and **`docs/agent-loop.md`** for build, Docker, and autoagents conventions.
