# Self-host brand fonts (fix Google Fonts MIME / PageSpeed)

## GitHub Issue
- **Number:** #117
- **Title:** Self-host brand fonts (fix Google Fonts MIME / PageSpeed)
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/117
- **Labels:** (set agent:planned on plan)

## Problem / goal

PageSpeed Insights refuses the Google Fonts stylesheet on `https://km0digital.com/` because the response MIME type is `text/html` (not CSS), so brand fonts fail to apply under strict MIME checking.

**Goal:** self-host Bricolage Grotesque, IBM Plex Sans, and Source Serif 4 locally; remove Google Fonts CDN links from the public site. Keep brand pairing from `docs/brand-tokens.md`. Do not replace with Inter or system-only as the design fix.

## High-level instructions for coder

- Read full issue: https://github.com/AMVARA-CONSULTING/km0-web/issues/117
- Current remote load: `src/layouts/Layout.astro` (`fonts.googleapis.com` / `fonts.gstatic.com` preconnect + CSS link for the three brand families).
- Prefer **vendored woff2** under something like `public/fonts/` or `src/assets/fonts/` plus `@font-face` in CSS (`src/styles/` / tokens), wired to existing Tailwind `fontFamily.display` / `body` / `sans` names. Avoid new host OS packages. Prefer no new npm font packages unless clearly simpler than vendoring; if you add npm deps, keep them minimal and justified.
- Remove all Google Fonts `<link>` and preconnect from marketing layouts. Confirm built HTML / network has zero `fonts.googleapis.com` / `fonts.gstatic.com` on home and locale pages.
- Keep weights already used (400/500/600/700; variable/optical axes only if already relied on). License: OFL faces are fine to self-host; keep attribution if required by the font license files.
- Do **not** change brand faces to Inter / Roboto / generic stacks. Email templates (`email-templates/**`) are out of scope unless a one-line note is useful.
- Follow anti-slop / brand tokens: `docs/brand-tokens.md`, `docs/design/anti-slop-doctrine.md`.
- Run `./scripts/bump-patch-version.sh` once before UNTESTED-.
- Verify: `npm run build`, `docker compose build && docker compose up -d`, curl locales on `127.0.0.1:9180`, check footer version, spot-check computed `font-family` still Bricolage / Source Serif / IBM Plex.

## Testing instructions

(filled by coder before UNTESTED-)

## References
- Runbook: docs/runbook.md
- Brand tokens: docs/brand-tokens.md
- Anti-slop: docs/design/anti-slop-doctrine.md
- Layout: src/layouts/Layout.astro
- Site: https://km0digital.com
