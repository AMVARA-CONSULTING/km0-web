# Craft parity phase (hard)

**Status:** implementation FEATs #96–#100 shipped to tester queue; encode #101 locks doctrine/skills/agents.  
**Why:** Paint FEATs closed on class-name / section-order checks. The live site must read as peer craft to [Stirling](https://stirling.com/) or [Satisfecho](https://satisfecho.de/). This phase forbids soft passes.

Epic table: `docs/design/remodel-epic.md` (Craft parity).  
Doctrine: `docs/design/anti-slop-doctrine.md` (Craft-parity locks).  
Skill: `.cursor/skills/km0-anti-slop-design/SKILL.md` (Craft-parity locks table).  
References: `docs/design/reference-study-stirling-satisfecho-nous.md`, `docs/design/stirling-paint-phase.md`, `docs/design/lessons-from-pos.md`.

## Problem statement

Agents (and prior FEATs) treated “Stirling energy” as:

- add `surface-*` / `data-reveal`
- keep CTA hierarchy
- curl 200 + no purple

That is **infrastructure**, not craft. A visitor opening KM0 next to Stirling or Satisfecho must feel the same **professional confidence**, not a quieter cousin with the right CSS classes.

## Non-negotiable bar

| Bar | Fail if… |
|-----|----------|
| **Side-by-side** | Tester cannot open reference + KM0 and list 3 structural matches that a non-dev would notice |
| **First viewport** | Brand + one promise + one support line + one CTA group + one dominant product proof - and the proof looks like the product, not a logo card |
| **Argument bands** | Offer/Why still feel like equal feature strips instead of scale/job stories with one CTA each |
| **Live proof** | Hero/proof is only a static mock with no path into a real product surface |
| **Optional dark** | No user-controlled theme; or dark is purple-glow AI lab / pure Nous clone |
| **Motion** | Reveals exist in HTML but a human with motion enabled cannot notice sticky chrome or pin behavior |
| **Soft evidence** | Pass rests only on “class present”, “four locales”, “build green” |

## Hard gate protocol (every craft FEAT)

Coder **and** tester must document:

1. **Reference URL(s)** opened in the same session (Stirling and/or Satisfecho page named).
2. **KM0 URL(s)** compared (`127.0.0.1:9180` after rebuild).
3. **Three parity claims** - concrete (“sticky nav gains solid fill within ~1 scroll”, “volume-style band with repeated primary CTA”, “QR/link opens live product”).
4. **Three anti-slop claims** - what was refused (no icon tiles, no zebra, no purple, no dark-first default).
5. **Screenshot or HTML evidence** for the decisive viewport (path + what to look at). Class lists alone = **FAIL**.

Closing reviewer: if Test report lacks side-by-side claims, **do not archive** - send back to WIP.

## Phase FEATs (run in order)

| Order | Theme | Intent |
|------:|-------|--------|
| 1 | Optional dark theme | Semantic light/dark tokens; `prefers-color-scheme`; header toggle; persist; reading pages included. Default stays Paper light. Ban: dark-mode-first marketing, purple glow. |
| 2 | Landing Stirling hard parity | Home must win a side-by-side with stirling.com structure (promise loudness, scale bands, CTA rhythm, continuous canvas). Not a class rename. |
| 3 | Satisfecho live product proof | First viewport proof must *do* something (QR and/or deep link into real Cloud / public product surface). Static panel = fail. |
| 4 | Pricing + secondary hard chrome | `/pricing/` and key secondary pages must feel product-priced and editorial-calm like Stirling pricing/about energy under KM0 tokens. |
| 5 | Motion you can feel | Sticky masthead + Offer pin + reveals must be obvious on `lg+` with motion on; reduced-motion still respected. Cap spam. |
| 6 | Encode craft gates | Doctrine + skill + tester/closing prompts: soft class-only passes are auto-fail for craft FEATs. |

## KM0 constraints (still)

- Tokens: Ink / Paper / Signal (plus dark semantic remap - not a second brand).
- No `mailto:`; sacred Cloud user counter; no zebra; Origin motif only.
- Do not clone Stirling Framer pixels, Satisfecho Inter/cream/orbs, or Nous underground as the default theme.
- i18n: any new UI chrome strings in es/ca/en/de.

## Out of scope

- Rewriting all historical blog day prose
- Fake Fortune-500 claims
- Product UI inside Cloud/Email apps
- Making dark the default

## Agent training note

Paint-phase locks remain. Craft-parity **adds** the Hard gate protocol (encoded in doctrine + skill + `010-feature-coder.md` / `020-test.md` / `030-closing-reviewer.md`).

Auto-fail for craft FEATs:

- Soft class-only / section-order / curl-200 / “no purple” / four-locales / build-green passes
- Missing Hard gate fields (reference URL, KM0 URL, 3 parity claims, 3 anti-slop claims, decisive viewport)
- Optional dark as default, or purple-glow / neon-orb dark
- Hero/proof with no live path into a real product surface
- Motion that exists only as HTML attributes a human cannot notice

“Looks professional” without side-by-side evidence is not enough to close.
