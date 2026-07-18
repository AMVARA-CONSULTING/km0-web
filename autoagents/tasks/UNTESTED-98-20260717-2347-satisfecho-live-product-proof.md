# FEAT-Task: Satisfecho-style LIVE product proof in hero

## GitHub Issue
- **Number:** #98
- **Title:** Craft parity HARD: Satisfecho-style LIVE product proof in hero
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/98
- **Labels:** enhancement, agent:wip

## Problem / goal
Static Cloud mock is not Satisfecho parity. First viewport proof must lead into a real KM0 product surface (QR and/or deep link / interactive path).

## Depends on
#97 preferred (composition), after #96.

## Spec
`docs/design/craft-parity-phase.md`; https://satisfecho.de/; `docs/design/lessons-from-pos.md`

## High-level instructions for coder
1. Make hero proof actionable: QR and/or clickable path to real Cloud entry (`cloud.km0digital.com` or documented public URL).
2. Primary CTA stays Open KM0 Cloud; proof reinforces same action.
3. Mobile + desktop usable; i18n new strings; KM0 tokens (no POS Inter/cream/orbs).
4. Tester must follow the path and record destination - static theater = fail.
5. Build; bump; Hard gate protocol in Testing instructions.

## Acceptance (hard)
- Proof path opens a real product surface (documented in test report)
- Logo-only / dead mock = FAIL

## Implementation notes (coder)
- Hero proof panel is no longer `aria-hidden` theater: product crop (`hero__proof-surface`) links to `https://cloud.km0digital.com`.
- Live strip (`hero__proof-live`): QR PNG at `/brand/cloud-qr.png` (encodes `https://cloud.km0digital.com`) + copy + text CTA + visible host; QR and CTA share the same Cloud URL as the primary hero button.
- i18n (`es`/`ca`/`en`/`de`): `proof.liveLabel`, `liveHint`, `liveCta`, `liveAria`, `qrAlt`, `host`.
- Destination check: `cloud.km0digital.com` → 302 → `https://auth.km0digital.com/login?service=cloud` (real product login).
- Site version bumped to **1.1.126**. Docker rebuild healthy; locales `/` `/en/` `/ca/` `/de/` `/doc/` 200.

## Testing instructions

### Hard gate protocol

1. **Reference URL(s)** (same session):
   - https://satisfecho.de/ (home: “Open Restaurant Demo” / “Scan with your phone” + “Your menu, one scan away” QR that opens a live demo menu)

2. **KM0 URL(s)** (after `docker compose build && docker compose up -d`):
   - http://127.0.0.1:9180/en/ (decisive)
   - http://127.0.0.1:9180/ (ES) and `/ca/`, `/de/` for i18n live strings
   - Follow-through: https://cloud.km0digital.com/ (expect auth login redirect)

3. **Three parity claims** (non-dev visible; open Satisfecho beside KM0):
   - **Live QR door:** First viewport proof includes a scannable QR (`/brand/cloud-qr.png`) that encodes the real Cloud entry URL, same energy as Satisfecho’s table QR → live menu (not a decorative sticker).
   - **Clickable product path:** Tapping the proof crop, the QR, or the live “Open KM0 Cloud” link leaves the marketing site and opens the real Cloud login (`auth.km0digital.com/login?service=cloud`). Static logo-only mock = fail.
   - **Same primary action:** Hero primary button and proof live CTA both say Open KM0 Cloud and share `cloud.km0digital.com`; host text `cloud.km0digital.com` is visible in the live strip so the destination is honest before click.

4. **Three anti-slop claims** (what was refused):
   - No POS Inter/cream/glow-orb Satisfecho pixel clone; KM0 Ink/Paper/Signal + Origin motif only.
   - No dead hero theater (`aria-hidden` mock with no exit); no fake demo URL or vanity “try demo” that 404s.
   - No purple/indigo gradients, centered SaaS hero recipe, or icon-tile feature cards added for this FEAT.

5. **Decisive viewport evidence**:
   - Path: `/en/` first viewport, right column proof.
   - Look for: “Live Cloud” label; QR image; “Scan with your phone, or open in this browser.”; live CTA “Open KM0 Cloud”; host `cloud.km0digital.com`; footer Version **1.1.126**.
   - Tester must click QR or live CTA and record final URL after redirects (must be Cloud auth/product, not `#` or a marketing page). Class-list-only evidence = **FAIL**.

### Smoke checks
```bash
curl -sI http://127.0.0.1:9180/ http://127.0.0.1:9180/en/ http://127.0.0.1:9180/ca/ http://127.0.0.1:9180/de/ http://127.0.0.1:9180/doc/
curl -sI http://127.0.0.1:9180/brand/cloud-qr.png
curl -s http://127.0.0.1:9180/en/ | grep -E 'Live Cloud|cloud-qr\.png|cloud\.km0digital\.com|1\.1\.126'
curl -sI https://cloud.km0digital.com/ | head -5
docker logs --since 10m km0-web
```

### Browser checklist
- [ ] Satisfecho home open beside `/en/` - three parity claims written by tester
- [ ] Scan QR (phone) or click QR/live CTA - lands on Cloud auth/product; record URL
- [ ] Primary hero CTA still Open KM0 Cloud; same destination as proof
- [ ] Mobile (<380px): live strip stacks; QR still tappable
- [ ] Light + Dark (#96) keep live strip readable
- [ ] No mailto; no em dash; anti-slop holds

## References
- https://satisfecho.de/
- docs/design/craft-parity-phase.md
- docs/design/lessons-from-pos.md
