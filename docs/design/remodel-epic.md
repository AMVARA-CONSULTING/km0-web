# Remodel epic - FEAT order

## Phase 1 (closed)

| Order | Issue | Intent |
|------:|-------|--------|
| 1 | [#73](https://github.com/AMVARA-CONSULTING/km0-web/issues/73) | Tokens + fonts + agent doctrine |
| 2 | [#74](https://github.com/AMVARA-CONSULTING/km0-web/issues/74) | Fewer home sections / nav; `ia-map.md` |
| 3 | [#75](https://github.com/AMVARA-CONSULTING/km0-web/issues/75) | Anti-slop landing composition |
| 4 | [#76](https://github.com/AMVARA-CONSULTING/km0-web/issues/76) | i18n 180° rewrite |
| 5 | [#77](https://github.com/AMVARA-CONSULTING/km0-web/issues/77) | Blog chrome + day-0 pilot |
| 6 | [#78](https://github.com/AMVARA-CONSULTING/km0-web/issues/78) | Blog template doc; defer other days |
| 7 | [#79](https://github.com/AMVARA-CONSULTING/km0-web/issues/79) | Secondary surfaces |

## Phase 2 (closed) - Stirling / Satisfecho / Nous inspired

Study: **`docs/design/reference-study-stirling-satisfecho-nous.md`**  
Doctrine locks: **`docs/design/anti-slop-doctrine.md`** (Hard ban #12–#13 + Phase-2 locks)  
Skill: **`.cursor/skills/km0-anti-slop-design/SKILL.md`**

| Order | Issue | FEAT | Intent | Status |
|------:|-------|------|--------|--------|
| 1 | [#80](https://github.com/AMVARA-CONSULTING/km0-web/issues/80) | `CLOSED-80-…-kill-zebra-section-rhythm` | Kill automatic Snow/Paper zebra | closed |
| 2 | [#81](https://github.com/AMVARA-CONSULTING/km0-web/issues/81) | `CLOSED-81-…-evolve-logo-favicon-og` | Logo + favicon + OG mark system (also covers idea #72) | closed |
| 3 | [#82](https://github.com/AMVARA-CONSULTING/km0-web/issues/82) | `CLOSED-82-…-hero-product-proof-2` | Hero product proof 2.0 | closed |
| 4 | [#83](https://github.com/AMVARA-CONSULTING/km0-web/issues/83) | `CLOSED-83-…-audience-scale-argument-bands` | Audience/scale argument bands | closed |
| 5 | [#84](https://github.com/AMVARA-CONSULTING/km0-web/issues/84) | `CLOSED-84-…-km0-signature-atmosphere` | Signature atmosphere (anti-orb) | closed |
| 6 | [#85](https://github.com/AMVARA-CONSULTING/km0-web/issues/85) | `CLOSED-85-…-encode-phase2-reference-study` | Encode study into doctrine/skills | closed |

**Actual run order:** 80 → 81 → 82 → 84 → 83 → 85 (encode last so doctrine matches shipped locks).

## Locked product decisions

- **Design:** cool civic editorial - `docs/brand-tokens.md`
- **CTA primary:** Open KM0 Cloud; secondary text → Pricing
- **User counter:** sacred; readapt, never remove
- **No zebra:** continuous canvas + intentional bands only (phase 2 #80; paint #91)
- **Mark:** Origin stamp; full-bleed favicon; no map-pin clone (phase 2 #81)
- **Hero proof:** product-recognizable visual (phase 2 #82)
- **Argument bands:** audience/scale, not icon tiles (phase 2 #83)
- **Atmosphere:** Origin field `.km0-motif` only; no glow orbs (phase 2 #84)
- **Agent training:** doctrine + skill point at the phase-2 study (phase 2 #85) and paint-phase spec (#95)
- **Surfaces:** `.surface-snow` / `.surface-ink` / `.surface-band` opt-in only (paint #91)
- **Motion:** reveals + masthead compact + Offer sticky pin; no animation spam (paint #92)
- **Secondary chrome:** `.page-shell` / `.page-masthead` / `.page-closer` (paint #94)
- **IA map:** `docs/design/ia-map.md`
- **POS lessons:** `docs/design/lessons-from-pos.md`
- **Blog post template:** `docs/design/blog-post-template.md`

## Not in scope (unless new FEAT)

- Cloud/Email product UIs outside km0-web
- Fake testimonials/metrics
- Full rewrite of all historical blog days
- Cloning Nous dark underground or Stirling Framer pixels

## Phase 3 - Reading surfaces

| Issue | Intent |
|-------|--------|
| [#87](https://github.com/AMVARA-CONSULTING/km0-web/issues/87) | Blog + tutorials aesthetics overhaul (`docs/design/blog-tutorials-aesthetics.md`) |

## Logo follow-up

| Issue | Intent |
|-------|--------|
| [#88](https://github.com/AMVARA-CONSULTING/km0-web/issues/88) | Logo v2 - kill webcam look (`docs/design/logo-brief-it-services.md`) |

## Reading surfaces v2 (ground-up)

| Issue | Intent |
|-------|--------|
| [#89](https://github.com/AMVARA-CONSULTING/km0-web/issues/89) | Blog + tutorials CSS/chrome from zero (`blog-tutorials-ground-up-v2.md`) |

## Paint phase (closed) - Stirling-inspired craft

Spec: **`docs/design/stirling-paint-phase.md`** - https://stirling.com/  
Doctrine locks: **`docs/design/anti-slop-doctrine.md`** (Paint-phase locks)  
Skill: **`.cursor/skills/km0-anti-slop-design/SKILL.md`** (Paint-phase locks table)

| Order | Issue | FEAT | Intent | Status |
|------:|-------|------|--------|--------|
| 1 | [#91](https://github.com/AMVARA-CONSULTING/km0-web/issues/91) | `CLOSED-91-…-stirling-surfaces-no-zebra` | Professional surfaces, no zebra | closed |
| 2 | [#92](https://github.com/AMVARA-CONSULTING/km0-web/issues/92) | `CLOSED-92-…-stirling-motion-sticky-scroll` | Motion: reveals + sticky-while-scroll | closed |
| 3 | [#93](https://github.com/AMVARA-CONSULTING/km0-web/issues/93) | `CLOSED-93-…-stirling-landing-repaint` | Landing restyle | closed |
| 4 | [#94](https://github.com/AMVARA-CONSULTING/km0-web/issues/94) | `CLOSED-94-…-stirling-secondary-pages-paint` | Secondary pages paint | closed |
| 5 | [#95](https://github.com/AMVARA-CONSULTING/km0-web/issues/95) | `…-encode-stirling-paint-doctrine` | Encode paint + motion into doctrine/skills | this task |

**Actual run order:** 91 → 92 → 93 → 94 → 95 (encode last so doctrine matches shipped locks).

## Craft parity phase (hard) - Stirling / Satisfecho must be visible

Spec: **`docs/design/craft-parity-phase.md`**  
Why: paint FEATs closed on class/order checks; live site still does not feel peer to [Stirling](https://stirling.com/) / [Satisfecho](https://satisfecho.de/). Soft “build green + no purple” passes are forbidden.

| Order | Issue | Intent | Depends |
|------:|-------|--------|---------|
| 1 | (queued) | Optional dark theme (system + toggle; light default) | - |
| 2 | (queued) | Landing Stirling **hard** visual parity | dark preferred first |
| 3 | (queued) | Satisfecho **live** product proof in first viewport | landing |
| 4 | (queued) | Pricing + secondary hard chrome | landing |
| 5 | (queued) | Motion you can feel (sticky / pin / reveals) | landing |
| 6 | (queued) | Encode craft-parity gates into doctrine + tester/closing | 1–5 |

Fill issue numbers when GitHub issues are created. Run **in sequence**. Every FEAT must use the **Hard gate protocol** in the craft-parity spec (side-by-side claims mandatory).

