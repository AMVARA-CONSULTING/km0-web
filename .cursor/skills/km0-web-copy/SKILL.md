---
name: km0-web-copy
description: >-
  Rewrite km0-web marketing and blog copy for scanability, honesty, and reader
  relief. Use when editing i18n JSON, landing sections, FAQ, blog markdown,
  tutorials, or any user-facing prose that feels repetitive or marketese.
---

# KM0 web copy

Readers **scan**. They punish repetition and hype. LLMs must write **clearer and shorter** than a tired human marketer - not louder.

## Canon

1. **`docs/design/anti-slop-doctrine.md`** (writing section)
2. NN/g: concise + scannable + objective → up to **124%** usability gain when combined
3. Existing strings live in `src/i18n/{es,ca,en,de}.json` and `src/content/**`

## Rules

### Structure

- Inverted pyramid: conclusion first, detail later.
- One idea per paragraph; first 3–5 words carry the meaning (F-pattern).
- Meaningful subheads (say what the section is), never cute slogans as H2s.
- Cut toward **≤50%** of previous word count when remodeling fluff.
- Prefer lists when comparing alternatives; prefer one vivid example over three abstract claims.

### Voice

- **Objective > promotional.** State facts: EU hosting, prices, what the community is. Drop “revolucionario”, “única alternativa real” loops unless the claim is concrete and new.
- **Say it once.** Privacy / ISO / “no vendemos datos” must not reappear in Vision + Mission + PrivacyTrust + FAQ + Services with the same sentence shape.
- **Respect the reader.** No guilt trips, no fake urgency, no empty “únete al movimiento” without a next action.
- **Local and specific.** Names, places, numbers that exist beat universal fluff.
- Follow project **`no-em-dash`** rule (no U+2014).

### Psychology (use lightly, never manipulatively)

- **Clarity reduces cognitive load** → trust.
- **Specificity beats adjectives** → credibility.
- **Progressive disclosure** → landing states the offer; blog/docs hold depth.
- **Recognition over recall** → reuse the same plain names for Cloud / Email / Blog.

### Blog / longform

- Lead with what changed and why it matters to the reader.
- Kill nested “doc-block” theater if it slows reading; prefer clean prose + rare callouts.
- Technical posts: show the decision, the tradeoff, the command - not a manifesto intro every time.

## Workflow for i18n

1. Rewrite **Spanish (`es.json`)** as source of truth (or as the task specifies).
2. Mirror meaning in `ca` / `en` / `de` - do not machine-calque awkward syntax.
3. Keep keys stable unless an IA task removes sections; delete dead keys when sections die.
4. Never leave two sections that answer the same question with different adjectives.

## Done check

- Would a busy person understand the page in **15 seconds**?
- Can you delete a whole section without losing a unique fact? If yes, delete it.
- Any sentence that only reassures without adding information? Cut it.
