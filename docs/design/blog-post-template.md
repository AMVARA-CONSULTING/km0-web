# Blog post template (KM0 `/doc/`)

Contract for new and migrated `day-N` posts under `src/content/doc/{es,ca,en,de}/`.
Pilot reference: **`day-0`** (all locales). Historical `day-1`…`day-16` stay on legacy HTML kits until a dedicated prose epic.

## Goals

- Readers finish the post: calm chrome, ~60–70ch measure, quiet meta, TOC only when useful.
- Agents and authors ship **Markdown prose**, not nested `doc-block` / section-kit theater.
- Voice matches NN/g + `km0-web-copy`: inverted pyramid, scannable, objective.

## File and frontmatter

```text
src/content/doc/<locale>/day-N.md
```

Required YAML:

| Field | Rule |
|-------|------|
| `title` | Specific; lead with the day/topic. No cute slogans. |
| `description` | One sentence: what changed + why it matters. ≤160 chars when possible. |
| `pubDate` | ISO date (`YYYY-MM-DD`). |
| `locale` | `es` \| `ca` \| `en` \| `de` matching the folder. |

Keep slugs stable: `/doc/day-N/` (and locale prefixes). Do not invent parallel routes.

## Structure (inverted pyramid)

1. **Lead (2 short paragraphs max):** conclusion first. What this day delivered and why an operator/reader cares. No manifesto intro (“in a world where…”).
2. **Plan or outcome list:** bullets with bold labels; facts over adjectives.
3. **Sections (`##`):** one idea each; meaningful headings (name the topic, not a teaser).
4. **Details:** commands, decisions, tradeoffs, links to wiki/runbook. Prefer lists for alternatives.
5. **Close:** checklist of “done when…” plus one concrete next step (next day, services, contact). Soft CTA only; no guilt or fake urgency.

Optional: one blockquote for a caveat that belongs in wiki/runbook, not the main narrative.

## Markdown-first rules

- Prefer `#` / `##` / lists / bold / links / fenced code over raw HTML kits.
- Do **not** introduce `doc-lead-block`, numbered pill steps, or card shells inside the body.
- Callouts: rare. One `>` blockquote is enough for a warning; do not stack alert boxes.
- Code: show the decision, the tradeoff, then the command. No wall of unexplained snippets.
- Internal links: use locale-correct paths (`/en/#services`, `/#contact`, etc.).

## Voice checklist (before merge)

- [ ] First screen answers “what happened / why care?” without scrolling past fluff.
- [ ] First 3–5 words of each paragraph carry meaning (F-pattern).
- [ ] No repeated privacy / ISO / “we don’t sell data” paragraphs already on the landing.
- [ ] No Inter-only / purple / badge-above-H1 thinking in the **copy** either (no hype badges in prose).
- [ ] No em dash (U+2014); use hyphen, comma, or colon per project rule.
- [ ] Same facts across `es` / `ca` / `en` / `de`; mirror meaning, do not calque awkward syntax.
- [ ] Would a busy reader understand the post in ~15 seconds of scanning?

## What not to do in this contract

- Batch-rewrite historical days without a FEAT scoped to those posts.
- Rebuild blog chrome here (done in remodel FEAT-77 / `#77`).
- Invent metrics, testimonials, or urgency.
- Turn every post into a landing-page clone (eyebrow + dual CTAs + icon tiles).

## Author / agent workflow

1. Read this file + `docs/design/anti-slop-doctrine.md` (writing section) + `.cursor/skills/km0-web-copy/SKILL.md`.
2. Draft **Spanish** first when the post is marketing-adjacent; for ops diaries, English or Spanish may lead, then mirror locales.
3. Compare shape to `day-0` (prose pilot), not to legacy `day-1` HTML.
4. Build locally; check `/doc/day-N/` in at least `es` and `en`.
5. Run `./scripts/check-no-em-dash.sh` (also runs on `npm run build`).

## References

- Pilot: `src/content/doc/*/day-0.md`
- Chrome: `src/views/DocPost.astro`, `src/components/DocArticleChrome.astro`
- Epic notes: `docs/design/remodel-epic.md` (blog prose history deferred)
- NN/g: [Applying writing guidelines](https://www.nngroup.com/articles/applying-writing-guidelines-web-pages/), [F-shaped pattern](https://www.nngroup.com/articles/f-shaped-pattern-reading-web-content-discovered/)
