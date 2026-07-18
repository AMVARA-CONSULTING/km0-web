# Blog days 17–18 review (ship-ready)

**Status:** brief for NEW task (2026-07-18).  
**Coder role:** review + harden existing drafts; do not invent a third day; do not leave author scaffolding live.

## Locked facts (do not reinterpret)

### Day 17 - meetup recap

| Field | Locked value |
|-------|----------------|
| Slug | `day-17` → `/doc/day-17/` (+ `/ca/`, `/en/`, `/de/`) |
| Event date | **2026-07-10** |
| `pubDate` | **2026-07-11** |
| Venue | **Casino del Masnou**, Carrer de Barcelona, 1, 08320 El Masnou, Barcelona |
| Venue web | https://www.casinomasnou.com/ |
| Topic A | **Palantir:** infiltrates as many orgs as possible; holds/connects data on thousands+ of people; strong at **database / entity mapping** (respect the competence; critique the power concentration) |
| Topic B (same day) | **Harari / AI + bureaucracy:** models already **write better than humans**; they can “hack” bureaucratic process via **language/psychology** (find gaps, ambiguities, exceptions in procedures), not via cracking servers |
| Series link | Continues [day 16](https://km0digital.com/doc/day-16/) announcement (Harari + Palantir meetup) |
| Venue vs day 16 | Day 16 **announced Bar Pekin**. Recap **must** state the meetup happened at the **Casino**. Do **not** rewrite day-16 history unless a separate task says so. |

### Day 18 - brand session

| Field | Locked value |
|-------|----------------|
| Slug | `day-18` → `/doc/day-18/` |
| `pubDate` | **2026-07-17** (publish date of the post) |
| Session type | **Professional meetup** about KM0 **brand / styles** |
| Outcome | Brand then had **no soul** → full revision of colours, type, logo, styles (not a favicon tweak) |
| Digression | Conversation wandered; still record the brand diagnosis as the lasting decision |
| Venue / clock | **Unknown.** Do **not** invent street, hour, or attendee names. Keep “quedada profesional” without a fake address. |
| Aftermath | May note that a later public remodel shipped (tokens, K0 mark, anti-slop); this day is the **decision moment**, not a full changelog of FEATs |

## Forbidden inventions

- Fake quotes, attendance counts, photos, or “someone said…” without operator text
- Fake Palantir case studies or metrics
- Em dash (U+2014); `mailto:`
- New routes or day numbers other than 17 and 18
- Soft-shipping with `Pendiente de ampliar` / `To expand` / `Author note` scaffolding still visible to readers

## Calendar consistency (required)

Update the **10 July 2026** calendar event to match the Casino venue:

- `src/lib/meetings.ts` → `masnou-jul-2026` `mapsUrl` to Casino query (same pattern as `cursor-masnou-jul24-2026`)
- `src/i18n/{es,ca,en,de}.json` → `meeting.events.masnou-jul-2026.location` to Casino address string

Leave the **24 July Cursor** event unchanged.

## Draft sources already on disk

Review and finish these files (all four locales already exist):

- `src/content/doc/{es,ca,en,de}/day-17.md`
- `src/content/doc/{es,ca,en,de}/day-18.md`

Contract: `docs/design/blog-post-template.md` + skill `km0-web-copy`. Prose like **day-0**, not legacy `doc-block` HTML kits.
