# Lessons from `/Repos/pos` (agents2 + front) for km0-web

Reference checkout: **`/Repos/pos`** (agents symlink → `agents2/`).

## What to steal (discipline + composition)

1. **CSS variables as the contract** - `:root` tokens for color, type, radius, space; components consume variables, not one-off hex. Reskin = edit tokens once (`front/src/styles.scss`).
2. **SCSS by concern** - `buttons`, `forms`, `layout`, `cards` partials instead of infinite Tailwind utility archaeology.
3. **Split hero** - copy left + product proof right (phone/menu mock), not a centered SaaS stack. See `front/src/app/landing/landing.component.ts`.
4. **One primary product CTA** - e.g. “Create QR menu” / register; secondary is ghost or in-page demo. Matches 2026 conversion research (one confident CTA).
5. **Real proof over fake stats** - demo tenant, live QR, real flows. For KM0: the **registered Cloud user counter stays sacred**; restyle it, never invent vanity metrics.
6. **Agent loop hardness** - FEAT → WIP → UNTESTED with **Testing instructions**, Docker log smoke (`pos-front` / `km0-web`), `gh` labels. Mirror that seriousness in km0-web autoagents.
7. **Tenant/public branding idea** - pages can take a real visual (header image + bg). KM0 marketing should use **real place/community/product imagery**, not gradient orbs.

## What NOT to copy from POS landing

The POS marketing landing still carries several **AI-median tells**: Inter-only, floating orbs, badge-above-H1, three equal icon feature cards, dual pill CTAs, warm-cream + terracotta cluster. KM0 must **learn the structure** (split, tokens, product CTA, real proof) and **reject the slop tells**.

## Mapped decisions for KM0

| Topic | Decision |
|-------|----------|
| Direction | Cool civic editorial (stone paper, ink, teal signal) - not purple SaaS, not cream+terracotta Folio/POS twin |
| Hero | Split-bias; brand + one line; product proof / atmosphere right |
| Primary CTA | **Open KM0 Cloud** (product-led, self-serve) |
| Secondary | Text link to Pricing (or Contact) - not a second equal button |
| User counter | Keep; embed in Offer / proof band; distinctive typography, not stat-strip slop |
| Blog | New chrome + **day-0 pilot** template; remaining days later |

See also: `docs/design/anti-slop-doctrine.md`, `docs/brand-tokens.md`.
