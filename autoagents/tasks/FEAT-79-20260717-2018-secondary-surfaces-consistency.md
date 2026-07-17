# FEAT-Task: Secondary surfaces consistency (pricing, tutorials, meeting, ideas, legal/security)

## GitHub Issue
- **Number:** #79
- **Title:** (see issue)
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/79
- **Labels:** agent:planned
- **Depends / notes:** see body; run remodel epic in order


## Problem / goal

After home and blog, secondary pages often keep old gray Apple-surface + Inter + gradient CTA DNA. Remodel must feel like **one site**, not a new home glued to old subpages.

## High-level instructions for coder

1. Apply tokens + anti-slop skill to:
   - `/pricing/`, `/tutorials/` (+ post chrome if not done), `/meeting/`, `/ideas/`, `/presentation/`, `/security/`, `/legal/`, error pages
2. Reuse Header/Footer/button/type from landing - no one-off purple.
3. Light copy cleanup on page-level i18n keys (pricing tables stay factual; cut duplicated trust paragraphs).
4. Meeting/ideas: prioritize clarity of action (pick a date / submit idea) over decoration.
5. Build + bump. Use GitHub issue #79.

## Acceptance

- Spot-check each route in es + en: same type/color language as home
- No ban-list hits
- Forms and calendars still work

## Testing instructions
(filled by coder before UNTESTED-)

## References
- `docs/brand-tokens.md`
- `docs/design/ia-map.md` (from IA FEAT)
