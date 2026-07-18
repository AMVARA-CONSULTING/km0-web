# NEW-Task: Restore Mission and Vision block (boss mandate)

## Origin
- **Source:** Direct operator request (skip GitHub). Boss strictly requires the Mission and Vision block back on the home page.
- **Brief:** `docs/design/purpose-mission-vision-restore.md`
- **No GitHub issue** (`NEW-0`).
- **Skills:** `km0-anti-slop-design`, `km0-web-copy`; Hallmark honest framing (goal ≠ fake KPI).
- **Supersedes home rule in** CLOSED `landing-conversion-gather` / `ia-map` “Purpose off home” for this stakeholder exception.

## Problem / goal
Conversion FEAT removed `#purpose` from the landing. Stakeholder (boss) **requires** Mission and Vision visible again. Reimplement the block with civic craft: keep the ambition line, do not ship it as a vanity metric strip, and do not undo Community/WhatsApp/Ideas/Register gather work.

## Locked decisions
1. **Restore** Mission + Vision on home via `Purpose.astro` (recreate from git if missing).
2. **Wire** in `Landing.astro` **after Contact**, before Footer.
3. **Keep** `id="purpose"` and `purpose.*` i18n keys (es/ca/en/de).
4. **Mission number (10.000.000 / 2030):** keep; rewrite slightly if needed so it reads as a **goal** (“Goal: …” / “Objetivo: …” / etc.), not “we already connected 10M.”
5. **Do not remove** Community secondaries (Meetings / WhatsApp / Ideas) or hero Register link.
6. Update `docs/design/ia-map.md`: Purpose is back on home as closer after Contact; note boss mandate; still ban fake KPI animation.

## Scope
1. `src/components/Purpose.astro` (restore + craft polish under tokens)
2. `src/views/Landing.astro` (import + place after Contact)
3. `src/i18n/{es,ca,en,de}.json` → `purpose.*` goal framing if copy needs the honesty tweak
4. `docs/design/ia-map.md` + brief `docs/design/purpose-mission-vision-restore.md`
5. Build; bump; Hard gate Testing instructions; `UNTESTED-`

## Out of scope
- Removing Community/FAQ order from the conversion FEAT
- Turning Mission into a live counter or progress bar to 10M
- Full landing remodel; purple/glow; Inter-only
- Changing Cloud primary CTA canon

## Acceptance (hard)
- [ ] `/` and `/en/` (and ca/de) show `#purpose` with Mission and Vision
- [ ] Block sits after Contact, before Footer
- [ ] 2030 / 10M line present and framed as goal/ambition
- [ ] No fake KPI strip / count-up to 10M
- [ ] Community gather links + Register secondary still present
- [ ] No em dash; no mailto; version bumped; build green

## Testing instructions
(filled by coder before UNTESTED-)

### Hard gate
| Item | Value |
|------|-------|
| Reference | Pre-removal Purpose layout (editorial two-col) + current gather funnel |
| KM0 URL | http://127.0.0.1:9180/en/ , `/` |
| Decisive viewport | Scroll past Contact → Mission and Vision |

**3 parity claims:** boss can see Mission + Vision; funnel gather paths still work; civic editorial craft (not icon tiles).

**3 anti-slop claims:** no 10M animated vanity counter; no purple; Purpose does not replace Cloud as primary CTA.

### Smoke
```bash
curl -s http://127.0.0.1:9180/en/ | grep -E 'id="purpose"|id="community"|id="contact"'
# purpose present; contact still before purpose in HTML
curl -s http://127.0.0.1:9180/en/ | grep -iE 'Mission|Vision|2030|10'
./scripts/check-no-em-dash.sh && ./scripts/check-no-mailto.sh
```

## References
- docs/design/purpose-mission-vision-restore.md
- docs/design/landing-conversion-gather.md (funnel to preserve)
- docs/design/ia-map.md
- docs/design/anti-slop-doctrine.md
- .cursor/skills/km0-anti-slop-design/SKILL.md
- .cursor/skills/km0-web-copy/SKILL.md
- git history: Purpose.astro before conversion drop
