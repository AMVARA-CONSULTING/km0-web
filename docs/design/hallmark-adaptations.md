# Hallmark → KM0 agent adaptations

**Status:** Encoded for agents (issue #108).  
**Source studied (no packages installed):** [Nutlope/hallmark](https://github.com/Nutlope/hallmark) skill + `skills/hallmark/references/` (especially `SKILL.md`, `anti-patterns.md`, `slop-test.md`, `structure.md`, `motion.md`, `copy.md`).  
**Live examples (structure only):** [usehallmark.com](https://www.usehallmark.com/).

## What we adopt vs refuse

Hallmark is a **greenfield** skill: theme catalogs, macrostructure rotation, `.hallmark/log.json` diversification. KM0 already has a **locked** civic system (`docs/brand-tokens.md`, Origin stamp, paint + craft-parity phases).

| Adopt into KM0 agents | Do **not** adopt |
|-----------------------|------------------|
| Pre-emit self-critique (six axes) | 20-theme catalog / custom OKLCH theme picker |
| Extra anti-pattern names (italic headers, fake chrome, token drift, microinteraction tells) | Forcing every page to a different macrostructure for variety’s sake |
| Honest copy / no invented metrics (strengthen) | Shipping Hallmark stamps into production CSS |
| Token discipline (named vars only) | Full 58-gate checklist as a mandatory every-edit ritual |
| Structural fingerprint ban (generic AI rhythm) | Installing hallmark CLI or npm packages |
| Quiet motion language (one orchestrated system) | Component 8-state demo wrappers for every small Astro tweak |

Canon still wins: **`docs/design/anti-slop-doctrine.md`**, craft Hard gate, paint-phase locks. This file is the **bridge** from Hallmark’s published skill into those agents.

## Pre-emit self-critique (mandatory on UI work)

Before handing UI / chrome / landing / blog-chrome work as done, score the planned output **1-5** on each axis. Any axis below **3** → revise before Testing instructions.

| Axis | Score | KM0 reading |
|------|-------|-------------|
| **P** Philosophy | 1-5 | Clear civic / product position, not empty layout |
| **H** Hierarchy | 1-5 | Primary / secondary / tertiary obvious in ~2s |
| **E** Execution | 1-5 | Tokens, focus, contrast, spacing on-system |
| **S** Specificity | 1-5 | Could only be KM0 after removing the nav |
| **R** Restraint | 1-5 | Nothing that does not earn its place |
| **V** Variety | 1-5 | Not the generic AI fingerprint (hero → 3 icon cards → CTA → footer). **Within** KM0 tokens/surfaces - do not invent a second brand to chase "variety" |

Record scores in the task **Implementation summary** (one line), e.g. `Pre-emit: P5 H4 E5 S4 R5 V4`. Do not stamp Hallmark comments into shipped site CSS.

## Disciplines adapted from Hallmark

### 1. Honest proof - no invented metrics

If the brief did not supply a number, do not invent one for a proof bar, comparison row, or “trusted by” strip. Prefer: omit the slot, use a labelled placeholder, or ask. Live Cloud counter and declared goals framed as goals (not live KPIs) stay as product locks.

### 2. Locked tokens - no mid-render improvisation

New colours and `font-family` values must come from `docs/brand-tokens.md` / `src/styles/tokens.css` (or Tailwind theme mapped from those). No one-off hex / OKLCH / Google font in a single hover or focus rule. Need a new value → add a named token first, then consume it.

### 3. Typography purity - no italic headers

Display and section headings stay `font-style: normal`. Emphasis via weight, Signal accent, or a drawn underline - not italic display. Italic remains OK inside running body copy only.

### 4. Re-drawn UI chrome forbidden

No fake browser bars (traffic-light dots + URL pill), fake phone notches, fake IDE tabs, or fake code-window chrome around screenshots. Prefer real screenshots in a quiet `<figure>` (hairline at most) or typographic frames for code.

### 5. Structural fingerprint ban

Refuse the median template: full-viewport centred hero → equal 3-column icon features → dual pill CTAs → generic footer. Secondary pages must not clone home’s section stack; they share **tokens and surface vocabulary**, not SaaS rhythm. Prefer page-genre structure (pricing masthead, doc reading column, ideas form) already in remodel docs.

### 6. Microinteraction tells

Avoid: `transition: all` / `transition-all`; universal `hover:scale-105`; bounce / overshoot easings on ordinary UI; stacking translate + scale + shadow on one hover. Stay inside paint-phase motion (`docs/design/stirling-paint-phase.md`).

### 7. Card discipline

No card-in-card. No thick coloured side-stripe “accent cards” as decoration. Cards only when they contain a real interaction (form, compare control).

### 8. Clickable labels stay one line

Primary nav links, footer links, breadcrumbs, and CTA labels must not wrap to two lines at common mobile widths (spot-check ~375–414 px). Shorten copy or stack the layout; do not shrink type into unreadability.

## Lightweight audit (optional verb)

When a human or tester asks to **audit** a page for slop (read-only):

1. Open the page (loopback or production as specified).
2. Score against doctrine Hard ban list + this file’s disciplines.
3. Return a **ranked punch list** (critical → major → nice). **Do not edit** unless asked to redesign.

## Agent wiring

| Path | Role |
|------|------|
| `docs/design/anti-slop-doctrine.md` | Hallmark source row + Hallmark-adapted locks |
| `.cursor/skills/km0-anti-slop-design/SKILL.md` | Pre-emit + adapted disciplines |
| `.cursor/skills/km0-web-copy/SKILL.md` | Invented-metrics / honest proof |
| `.cursor/rules/anti-slop-frontend.mdc` | Auto-fail tells |
| `autoagents/010-feature-coder.md`, `002-coder/CODER.md`, `020-test.md` | Enforce on UI FEATs |

## Upstream pointers (study only)

- Skill: https://github.com/Nutlope/hallmark/blob/main/skills/hallmark/SKILL.md  
- References tree: https://github.com/Nutlope/hallmark/tree/main/skills/hallmark/references  
- Especially: `anti-patterns.md`, `slop-test.md` (pre-emit + honest copy / chrome / token gates), `structure.md`, `motion.md`
