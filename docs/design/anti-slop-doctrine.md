# KM0 anti-slop design doctrine

**Goal:** Stop agents (and humans) from shipping the statistical average of Tailwind SaaS templates. Every surface must feel intentional, local, and readable - never “another AI landing page.”

## Why this exists

LLMs converge on the same frontend because training data is saturated with Tailwind demos, shadcn starters, and “modern SaaS” boilerplates. That median look has a name: **AI slop**.

KM0’s **legacy** attractor was `Inter` + multi-stop orange→pink→purple→blue gradient + centered dark hero. Phase 1 exited that look (tokens, IA, landing, copy, blog chrome). Phase 2 locked rhythm, mark, hero proof, argument bands, and atmosphere so agents do not regress to zebra stripes or a generic map-pin favicon. The **paint phase** (#91–#95) locked Stirling-inspired surface utilities, scroll reveals, sticky chrome, and secondary page shells so zebra and motion spam do not return.

## Primary references (read before implementing)

### Design / anti-slop

| Source | Why it matters |
|--------|----------------|
| [Hallmark](https://www.usehallmark.com/) | Negative constraints + positive rules (type pair, bias layout, one accent, nav as genre signal). Study live examples such as [Wayfare](https://www.usehallmark.com/examples/wayfare/), [Mend Assembly](https://www.usehallmark.com/examples/custom-04/). |
| [Why AI design looks generic (Superdesign)](https://www.superdesign.dev/blog/why-ai-design-looks-generic) | “Distributional convergence”: models pick the statistical center unless constrained. |
| [Why your AI keeps building the same purple gradient website](https://prg.sh/ramblings/Why-Your-AI-Keeps-Building-the-Same-Purple-Gradient-Website) | Tailwind `indigo-500` history; Anthropic-style aesthetics prompt; constraint > vague taste. |
| [AI design slop: 16 patterns](https://www.developersdigest.tech/blog/ai-design-slop-and-how-to-spot-it) | Detection checklist (Inter-everywhere, badge-above-H1, icon-tile cards, stat strips, glow, etc.). |
| [anti-slop-templates](https://github.com/JasonColapietro/anti-slop-templates) | Committed systems beat “good taste” abstracts: pick one direction and apply everywhere. |
| [MindStudio: design system for Claude](https://www.mindstudio.ai/blog/claude-design-avoid-ai-slop-design-system) | A markdown design system (fonts, hex roles, spacing, anti-examples) beats better one-off prompts. |

### Phase-2 structure study (mandatory for landing / chrome)

| Source | Why it matters |
|--------|----------------|
| **`docs/design/reference-study-stirling-satisfecho-nous.md`** | Steal structure from Stirling (scale bands, continuous canvas), Satisfecho (live product proof), Nous (memorable mark + no zebra). Not pixels or fonts. |
| **`docs/design/remodel-epic.md`** | Phase 1 + phase 2 + paint phase issue map (#73–#95). Locked product decisions. |
| **`docs/design/stirling-paint-phase.md`** | Paint-phase craft: surface utilities, sticky/reveal motion vocabulary, secondary page chrome. Steal scroll behavior from [Stirling](https://stirling.com/), not Framer pixels. |

### Writing / psychology of reading

| Source | Why it matters |
|--------|----------------|
| [How users read on the web (NN/g)](https://www.nngroup.com/articles/how-users-read-on-the-web/) | Users scan; scannable + concise + objective writing raised usability up to **124%** combined. |
| [Concise, scannable, objective (NN/g)](https://www.nngroup.com/articles/concise-scannable-and-objective-how-to-write-for-the-web/) | Kill marketese; one idea per paragraph; inverted pyramid. |
| [F-shaped pattern (NN/g)](https://www.nngroup.com/articles/f-shaped-pattern-reading-web-content-discovered/) | Front-load meaning in first paragraphs and left-edge words of lines. |
| [Be succinct (NN/g)](https://www.nngroup.com/articles/be-succinct-writing-for-the-web/) | Aim for ≤50% of print-style word count; meaningful (not cute) headings. |

## Hard ban list (auto-fail)

If any of these ship, the task fails review:

1. **Inter / Roboto / Open Sans / Arial / system-ui alone** as the only typeface for display + body.
2. **Purple / indigo / violet gradients** on heroes, buttons, or `bg-clip-text` headlines (including KM0’s old `#E040A0 → #7B3FE4 → #007BFF` chain).
3. **Centered everything** hero (logo + eyebrow + H1 + dual CTAs + scroll chevron as the whole first viewport recipe).
4. **Icon-in-rounded-square feature cards** in equal 3-column grids.
5. **Eyebrow pill / badge** stacked above every H1.
6. **Stat strip** of round fake numbers (“10K+”, “99.9%”) unless numbers are real and sourced.
7. **Glow / bloom / multi-layer shadow** decoration as the main atmosphere (including soft radial “orbs” as brand motif). Use **Origin field** instead (`docs/brand-tokens.md`: `.km0-motif`).
8. **`rounded-full` pill CTAs everywhere** as the only button shape.
9. **Glassmorphic sticky AI-nav** (wordmark left, links center, CTA right, hairline border) without a genre-specific alternative.
10. **Emoji as UI icons** or sparkle badges.
11. **Secondary AI attractors** also banned by project rules: warm-cream + terracotta + default serif stack; broadsheet hairline zero-radius newspaper pastiche; default dark-mode-first marketing pages.
12. **Zebra section rhythm** - automatic alternating Paper/Snow (or white/gray) bands via `nth-child` or equivalent (`main:has(#home) > section…` patterns). Default is continuous Paper; surfaces opt in explicitly (e.g. Contact `bg-snow`). Stirling / Nous pattern.
13. **Generic map-pin as sole brand mark** (especially identical logo + favicon with huge empty padding, or purple-era gradient pins). Do not revert to a pin stem clone.

## Phase-2 locks (do not regress)

Shipped under remodel epic #80–#84. Study: `docs/design/reference-study-stirling-satisfecho-nous.md`.

### Kill zebra (#80)

- Landing sections inherit body **Paper** unless a section opts into a surface class.
- No mechanical odd/even banding in CSS. Intentional full-bleed bands only.
- Proof/Ink moments stay earned (e.g. Cloud user counter), not striped decoration.

### Mark / favicon / OG (#81)

Locked **Origin stamp** (see `docs/brand-tokens.md` Assets):

- Motif: Signal field + Paper rectangular digit **0** (lettermark plaque). Not a map pin, not a webcam/lens.
- Paths: `public/brand/logo.svg` (+ PNG), `public/favicon.svg` (**full-bleed**, minimal padding so 16×16 reads), `public/apple-touch-icon.png`, `public/brand/og-preview.png` (Paper + stamp + wordmark).
- Colors: Signal `#0F766E` + Paper `#EEF0F2`. No purple/magenta→blue gradient exports.
- Brand test: mark must read without nav chrome; tabs must stay legible.

### Hero product proof (#82)

- First viewport dominant visual is **usable product proof** (Cloud panel / real offer), not logo-only theater.
- Primary CTA opens the product; secondary stays quieter (Pricing).

### Audience / scale bands (#83)

- Argue by audience scale (person / family-coop / org) where Offer/Why need structure - Stirling-style bands, not equal icon-tile grids.
- Keep the Cloud user counter sacred; never invent fake stats.

### Signature atmosphere (#84)

- **Origin field** only: `.km0-motif` / `.km0-motif--origin` (quiet grid + grain + optional biased kilometer-zero geometry).
- Apply sparingly: hero + ≤2 bands. Never glow orbs, never purple bloom as brand atmosphere.

## Paint-phase locks (do not regress)

Shipped under remodel epic #91–#94; encoded by #95. Spec: `docs/design/stirling-paint-phase.md`. Tokens: `docs/brand-tokens.md` Surfaces + Motion.

### Surfaces (#91)

- Default canvas is continuous **Paper** (body / `.page-shell`). Elevations opt in: `.surface-snow`, `.surface-ink`, `.surface-band`.
- Never reintroduce `nth-child` (or equivalent) Paper/Snow zebra. Intentional full-bleed bands only.
- Section rhythm uses `--space-section-*` / `.section-pad`, not alternating backgrounds for decoration.

### Motion (#92)

- One orchestrated system: `src/styles/tokens.css` + `src/scripts/scroll-reveal.ts`.
- Allowed sitewide moments (cap): (1) `[data-reveal]` / `.reveal` entrances once with expo ease, (2) masthead compact on scroll (solid Snow + hairline, no glass blur), (3) home Offer sticky pin (`offer__pin`) on `lg+`. Reading TOC sticky is chrome, not a vanity animation.
- Do not add bounce, parallax spam, progress bars, or extra scroll toys unless a later FEAT asks.
- Always honor `prefers-reduced-motion`: reveals visible immediately; chrome transitions off.

### Landing + secondary chrome (#93 / #94)

- Landing keeps product proof + scale/argument energy; no centered SaaS hero recipe, no icon-tile grids.
- Secondary pages share `.page-shell`, `.page-masthead`, `.page-closer` (+ `__actions`); light `data-reveal` on mastheads/bands only.
- Snow only where earned (Pricing/Presentation compare + closer; Ideas form). Presentation hero uses Origin motif, not a one-off grid.

## Positive rules (must do)

1. **Commit a direction** before pixels: one sentence of vibe + one layout archetype + one type pair + one anchor hue + one accent (accent ≤ ~5% of surface). Cool civic editorial is locked in `docs/brand-tokens.md`.
2. **Brand first in the first viewport:** product name is hero-level, not nav chrome. One headline, one supporting sentence, one CTA group, one dominant visual plane (prefer product proof over abstract art).
3. **Bias the layout:** asymmetry once is enough to signal intent.
4. **Type pairing:** display face ≠ body face (Bricolage + Source Serif 4). Extreme weight contrast beats timid 400/600.
5. **One job per section:** one purpose, one headline, usually one short support line. No cards in the hero. Cards only when they contain an interaction.
6. **Atmosphere without slop:** Origin field motif only; continuous Paper elsewhere. Gradients/patterns/imagery must show place, product, or community - not abstract purple blobs or glow orbs.
7. **Motion with purpose:** paint-phase vocabulary only (reveals + masthead compact + Offer pin); expo ease-out; always respect `prefers-reduced-motion`. No animation spam.
8. **Voice:** concrete, local, honest. Prefer facts over slogans. LLMs must rewrite toward clarity, not toward more adjectives.
9. **Mark system:** reuse the Origin stamp assets; do not invent a second logo language per page.
10. **Surfaces:** continuous Paper; opt into `.surface-*` / intentional Snow-Ink bands. Never zebra.

## KM0-specific reading of the brand

KM0 is a **community digital-sovereignty movement** with real EU-hosted services (Cloud, Email), not a generic SaaS. Design and copy should feel:

- **Local and civic** (near people, not venture-scale hype)
- **Technical but human** (ops transparency without marketese)
- **Trustworthy** (ISO context, EU hosting - stated once, not repeated in every block)

Avoid sounding like a YC landing page or a Big Tech privacy whitepaper.

## Blog / longform

New and migrated `/doc/` posts follow **`docs/design/blog-post-template.md`** (Markdown-first, inverted pyramid, pilot `day-0`). Do not reintroduce nested HTML section kits or manifesto intros.

## Agent enforcement

- Skill: `.cursor/skills/km0-anti-slop-design/SKILL.md` (must open the phase-2 study and paint-phase spec on UI work)
- Skill: `.cursor/skills/km0-web-copy/SKILL.md`
- Rules: `.cursor/rules/anti-slop-frontend.mdc`, `.cursor/rules/web-copy.mdc`
- Tokens: `docs/brand-tokens.md` + `src/styles/tokens.css`
- Study: `docs/design/reference-study-stirling-satisfecho-nous.md`
- Paint phase: `docs/design/stirling-paint-phase.md`
- Epic: `docs/design/remodel-epic.md`
- Blog prose contract: `docs/design/blog-post-template.md`
- Autoagents: `010-feature-coder.md`, `002-coder/CODER.md`, `030-closing-reviewer.md` must refuse slop regressions (including zebra, pin-favicon rollbacks, and motion spam)
