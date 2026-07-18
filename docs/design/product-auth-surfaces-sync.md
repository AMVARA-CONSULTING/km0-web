# Product auth surfaces sync (Cloud / Mail / Auth hub)

**Status:** brief for sibling NEW tasks (2026-07-18).  
**Source of truth:** this repo’s live civic dark system after the remodel epic (#73–#105).

Sibling products still ship the **legacy** Inter + orange→pink→purple→blue gradient auth chrome. Marketing site (`km0-web`) already uses cool civic editorial tokens and the **K0 lettermark**. Sync **only** custom auth HTML/CSS skins and favicons/logos used there. Do **not** restyle OpenCloud / Roundcube app shells after login.

## In scope

| Surface | Examples |
|---------|----------|
| Login / register HTML | Auth hub pages; Cloud `opencloud-auth/*`; Mail `mail-auth/*` |
| Shared auth chrome | Logout, SSO continue, OIDC start, domain/verify landings that reuse the same CSS |
| Dex KM0 theme | Password / connector templates already branded (`dex/web/themes/km0/`) |
| Roundcube **login** skin only | `skins/km0` login template + `km0-login.css` + skin images |
| Favicon + logo on those pages | SVG/PNG referenced by auth HTML and Dex/Roundcube login |

## Out of scope

- OpenCloud web UI after authentication
- Roundcube mailbox UI (folders, compose, settings) beyond the login screen
- Backend, Dex connectors, nginx routing, register-api behaviour
- Cloning Stirling Framer pixels or inventing a second brand

## Tokens (copy these hexes)

From `docs/brand-tokens.md` (dark only):

| Role | Hex | Use on auth |
|------|-----|-------------|
| Paper | `#0B1220` | Page canvas |
| Snow | `#141B28` | Card / elevated panel |
| Mist | `#2A3344` | Borders, quiet rules |
| Ink | `#E6E9ED` | Primary text |
| Ink muted | Ink @ ~65% | Secondary / hints |
| Signal | `#2DD4BF` | Accent, focus rings, primary text links |
| Signal hover | `#5EEAD4` | Hover |
| Stamp field (favicon/logo) | `#0F766E` | K0 plaque / full-bleed favicon |
| Figure on stamp | `#EEF0F2` | K0 glyph |

**Forbidden:** `#FF5F2E` / `#E040A0` / `#7B3FE4` / `#007BFF` gradient chain; purple glow orbs; `background-clip: text` rainbow headlines; Inter as sole UI font.

## Typography (auth UI)

Auth forms are UI, not long-form marketing:

- **UI / labels / buttons:** IBM Plex Sans (load via Google Fonts or self-host consistently)
- **Optional display for H1:** Bricolage Grotesque
- Do **not** use Inter / Roboto / Open Sans alone

## Mark assets (copy from km0-web)

Canonical files on disk:

| Asset | Path in km0-web |
|-------|-----------------|
| Favicon (full-bleed K0) | `/opt/km0-web/public/favicon.svg` |
| Logo plaque | `/opt/km0-web/public/brand/logo.svg` (+ `logo.png` if needed) |
| Mono | `/opt/km0-web/public/brand/logo-mono.svg` |
| OG (optional) | `/opt/km0-web/public/brand/og-preview.png` |
| 16/32 proof | `/opt/km0-web/docs/design/logo-k0-favicon-16.png` etc. |

Brief: `docs/design/logo-brief-it-services.md`. Replace every purple-gradient map-pin / old logo SVG under auth paths. Regenerate Dex `favicon.png` / `logo.png` from the new SVG if themes still serve PNG.

## Layout / craft bar (auth cards)

Auth pages stay **one job**: brand, short title, form or SSO choices, secondary text link. Not a marketing landing remodel.

| Do | Do not |
|----|--------|
| Paper canvas + Snow card; Signal accent | Purple radial glow behind the card |
| Solid primary button (Ink on Signal or Signal fill with dark text - pick one and keep contrast) | Gradient-fill primary buttons |
| Quiet secondary / text links | Dual equal pill CTAs |
| Full-bleed K0 favicon | Padded gradient pin |
| Side-by-side: auth URL vs `https://km0digital.com/` for token/mark match | Soft “CSS variables renamed” pass |

Hard gate for each product task: open marketing home + the product login; write 3 parity + 3 anti-slop claims. Soft class-only / curl-200 = fail.

## Deploy hints (per product)

- **Auth hub:** `/opt/km0-auth/scripts/deploy-auth-hub.sh` + verify script in README
- **OpenCloud:** host-www sync + Dex theme volume/restart per `docs/runbook.md`
- **Mail:** mail-auth static deploy + Roundcube skin path per `docs/runbook.md`

## Related tasks

| Repo | Task slug |
|------|-----------|
| `/opt/km0-auth` | `NEW-0-…-civic-dark-auth-hub-surfaces` |
| `/opt/opencloud` | `NEW-0-…-civic-dark-cloud-auth-surfaces` |
| `/opt/km0-mail` | `NEW-0-…-civic-dark-mail-auth-surfaces` |
