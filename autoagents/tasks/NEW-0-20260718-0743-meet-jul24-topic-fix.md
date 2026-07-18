# NEW-Task: Fix 24 July meetup title and topic

## Origin
- **Source:** Direct operator request (skip GitHub).
- **No GitHub issue** (`NEW-0`).
- **Event id (keep):** `cursor-masnou-jul24-2026` in `src/lib/meetings.ts` (do **not** rename the id; only change i18n copy).

## Problem / goal
The **24 July 2026** Casino meetup is wrong in the calendar:

1. Title typo: **`MEet` → `Meet`** (ES/CA).
2. Topic is still “how Cursor works” with Cursor links. Replace with the real agenda: **new style**, **future outlook for services**, and **how an AI integrated into a system works**.

Date, time, venue, maps, and audience stay unchanged.

## Locked schedule (do not change)

| Field | Value |
|-------|--------|
| Event id | `cursor-masnou-jul24-2026` |
| Date | `2026-07-24` |
| Time | `18:30` |
| Venue | Casino del Masnou, Carrer de Barcelona, 1, El Masnou, Barcelona |
| `meetings.ts` maps / website | leave as-is |

## Locked copy (all four locales)

Replace `meeting.events.cursor-masnou-jul24-2026` `title` + `topic` only. Keep `location` and `audience` unless they still say something false (they are fine today).

### Spanish (`es.json`)
- **title:** `Meet KM0: Nuevo estilo, servicios y IA integrada`
- **topic:** `Nuevo estilo de marca; previsión de futuro de los servicios KM0; cómo funciona una IA integrada en un sistema.`

### Catalan (`ca.json`)
- **title:** `Meet KM0: Nou estil, serveis i IA integrada`
- **topic:** `Nou estil de marca; previsió de futur dels serveis KM0; com funciona una IA integrada en un sistema.`

### English (`en.json`)
- **title:** `KM0 Meet: New style, services outlook, and integrated AI`
- **topic:** `New brand style; future outlook for KM0 services; how an AI integrated into a system works.`

### German (`de.json`)
- **title:** `KM0-Meet: Neuer Stil, Service-Ausblick und integrierte KI`
- **topic:** `Neuer Markenstil; Ausblick auf die KM0-Dienste; wie eine in ein System integrierte KI funktioniert.`

## Explicit bans
- Do **not** keep Cursor product links as the topic body (remove `cursor.com` / docs / blog anchors from this event’s `topic`).
- Do **not** invent a second 24 July event or delete the July 10 event.
- Do **not** rename the TypeScript event id (breaks nothing useful; copy is enough).
- No em dash; no `mailto:`.

## In scope
1. `src/i18n/es.json`, `ca.json`, `en.json`, `de.json` → keys under `meeting.events.cursor-masnou-jul24-2026`
2. Grep the repo for remaining `MEet` in meeting/marketing copy and fix if any other live string remains
3. `./scripts/bump-patch-version.sh` once; `npm run build`; runbook deploy smoke

## Out of scope
- Blog day posts about this meetup
- Changing brand tokens / logo for “nuevo estilo” (calendar copy only)
- Auth/Cloud product UI

## Acceptance (hard)
- [ ] No `MEet` substring in `src/i18n/*.json` meeting titles
- [ ] 24 July event topic states the three axes (style, services future, integrated AI) in es/ca/en/de
- [ ] Topic no longer points at Cursor as the session subject
- [ ] `/meeting/` (all locales) shows Meet + new topic; date still 24 July, Casino
- [ ] July 10 event unchanged by this task
- [ ] Build green; version bumped

## Testing instructions
(filled by coder before UNTESTED-)

```bash
grep -n 'MEet' src/i18n/*.json && exit 1 || true
grep -n 'cursor-masnou-jul24-2026' -A6 src/i18n/es.json src/i18n/en.json
curl -sI http://127.0.0.1:9180/meeting/ http://127.0.0.1:9180/en/meeting/ http://127.0.0.1:9180/ca/meeting/ http://127.0.0.1:9180/de/meeting/
curl -s http://127.0.0.1:9180/meeting/ | grep -E 'Meet KM0|Nuevo estilo|IA integrada'
curl -s http://127.0.0.1:9180/meeting/ | grep -E 'Funcionamiento de Cursor|cursor.com' && exit 1 || true
```

### Browser
- [ ] Open meeting calendar, select 24 July: title uses **Meet**, topic lists style + services outlook + integrated AI
- [ ] 10 July still Palantir/Harari event

## References
- src/lib/meetings.ts (`cursor-masnou-jul24-2026`)
- src/i18n/{es,ca,en,de}.json → `meeting.events.cursor-masnou-jul24-2026`
- docs/runbook.md
