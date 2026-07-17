# Blog & tutorials - ground-up reading system (v2)

**Status:** #87 closed but product owner reports surfaces still look essentially the same. Incremental CSS on `.doc-*` is **forbidden** for the next pass.

## Mandate

Rebuild blog (`/doc/`) and tutorials (`/tutorials/`) **from zero**:

1. **New stylesheet** - e.g. `src/styles/reading.css` (or equivalent). Do **not** keep editing the giant `.doc-*` block in `global.css` as the primary approach. Delete or gut unused `.doc-*` rules after migration.
2. **New markup chrome** - rewrite `DocArticleChrome.astro`, `DocIndex.astro`, `TutorialIndex.astro`, and post views so class names and structure are new (`reading-*` preferred). Carrying the old hairline-row + bordered TOC box = fail.
3. **Visually alien vs today** - a blind A/B should not look like a font tweak of the current page. Different rhythm, masthead, index pattern, article shell, TOC treatment, prose styling.
4. **Same routes / content** - slugs and collections stay; day-0 Markdown looks best; legacy `doc-block` HTML gets compatibility styles under the **new** system only.

## Quality bar (unchanged research)

See `docs/design/blog-tutorials-aesthetics.md` for measure (~75ch), body 18–21px, leading ~1.65, Nous-like title energy, quiet meta, anti-slop.

## Hard fail if

- Only changing spacing/colors on existing `.doc-post-row` / `.doc-toc-mobile` borders
- Keeping SaaS cards, purple, Inter-only, zebra inside articles
- Blog and tutorials diverge into two incompatible designs

## Acceptance

- `/doc/`, `/doc/day-0/`, `/tutorials/`, one tutorial post (es+en) look unmistakably new
- Old `.doc-*` dead code removed or reduced to thin aliases that are documented as temporary
- Build + a11y (headings, TOC, focus) green
