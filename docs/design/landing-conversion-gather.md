# Landing conversion craft - gather users without slop

**Status:** brief for NEW task (2026-07-18).  
**Skills used:** `km0-anti-slop-design`, `km0-web-copy`, Hallmark anti-slop disciplines (honest proof, one job, no invented metrics, structural clarity).  
**Surface:** home landing (`Landing.astro` + related sections). Not a full brand remodel.

## Audit snapshot (why users slip away)

Live order today (`Landing.astro`):

1. Hero (Cloud CTA + proof)  
2. TrustSignals (4-column fact strip)  
3. Services / Offer  
4. Why  
5. Cloud users Ink band  
6. FAQ  
7. Community (meetings only)  
8. Contact (email + WhatsApp QR)  
9. **Purpose** (Mission/Vision including “10,000,000 people by 2030”)

Canonical IA (`docs/design/ia-map.md`) already removed Purpose from home and put Community before FAQ. The live page **regressed** that funnel.

Conversion / gather gaps vs best practice (POS lessons + Hallmark honest-proof + KM0 CTA canon):

| Gap | Why it hurts signups / joins |
|-----|------------------------------|
| **Purpose still on home** | Mission/vision + vanity million goal dilutes the product path; Hallmark forbids invented-metric energy; IA map already said remove |
| **FAQ before Community** | Objections before the human join path; meetings/WhatsApp/Ideas arrive late |
| **Gather paths late / thin** | WhatsApp lives only in Contact; Ideas is nav-only; Community CTA is meetings text-link only |
| **Register not obvious on marketing** | Primary CTA is “Open KM0 Cloud” (correct) but the **create-account** door is easy to miss if Cloud landing is opaque |
| **Trust 4-up under hero** | Useful facts, but risks reading as a generic proof bar that delays Offer |

## Goal

Make the landing a clearer **user-gathering funnel** while staying civic / anti-slop:

1. **Product join:** Open Cloud → register/sign-in path remains primary.  
2. **Community join:** Meetings + WhatsApp (+ Ideas as feedback) visible without fake urgency.  
3. **Style:** louder hierarchy on those join moments; cut dilution sections.

## Locked product rules
- Primary CTA remains **Open KM0 Cloud** (not dual equal pills).  
- **Open Cloud primary cadence:** once early (hero CTA row) + at most **one** mid-page reaffirm as `btn-primary`. Do not repeat the same Open Cloud / Abrir Cloud label as a loud primary in Offer pin, Offer Cloud row, every Why band, and Cloud users. Later sections use quieter text links or section-job CTAs (pricing, community, register).  
- Sacred live user counter stays; no fake “10K users” / conversion % invented.  
- Remove or relocate **Purpose** off the home main flow (prefer delete from `Landing.astro`; content can live on `/presentation/` if needed).  
- Restore IA order closer to the map: Hero → (tight trust) → Offer/Services → Why → **Cloud users** → **Community** → FAQ → Contact.  
- No purple, no Inter-only, no icon-tile feature grids, no guilt CTAs.

## Recommended craft package (one FEAT)

1. **IA fix:** Drop `Purpose` from home; swap FAQ/Community order to match `ia-map.md`.  
2. **Gather strip in Community:** Keep meetings CTA; add quiet secondary text links to WhatsApp (`#contact` or direct group URL already in Contact) and Ideas (`/ideas/`). Not three equal buttons.  
3. **Register affordance:** In hero proof live strip and/or Cloud users band, ensure a visible path to **create account** (auth hub register or Cloud register) as secondary text under the primary Open Cloud CTA. Use existing auth URLs; do not invent a new product.  
4. **Trust:** Keep facts, but visually quieter / tighter so Offer remains the first real section after hero (no competing four-card energy).  
5. **Copy:** Shorten Community + Contact intros (km0-web-copy); kill or rewrite the “10,000,000 by 2030” line if Purpose moves to presentation.

## Hard gate
Side-by-side with prior home: a new visitor can name **three join actions** within one scroll past Offer (Cloud open/register, meetings or WhatsApp, Ideas or contact) without reading Purpose manifesto. Soft class-only = fail.
