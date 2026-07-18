# Information architecture map

Canonical map after **FEAT-74** (IA restructure), updated **2026-07-18** (landing conversion gather), then **NEW-0** (boss mandate: Mission and Vision restored as home closer after Contact).

## Landing (`/`, `/ca/`, `/en/`, `/de/`)

| Order | Block | Anchor / role |
|------:|-------|----------------|
| 1 | Header | Primary nav only |
| 2 | Hero | Brand + promise; primary CTA → KM0 Cloud; secondary → Pricing; live proof + **Create account** text link → auth register |
| 3 | TrustSignals | Quiet hosting / operator / ISO / security facts (`#trust`); not a competing proof band |
| 4 | Offer (`Services`) | Cloud + Email, price hook, tutorials/pricing links |
| 5 | Why KM0 | Single contrast block (`#why`); presentation link for depth |
| 6 | Cloud users | Live registered-user counter + Open Cloud CTA + register secondary (`#cloud-users`) |
| 7 | Community / Encuentros | Short teaser (`#community`) → Meetings, WhatsApp, Ideas |
| 8 | FAQ | Deduped: movement, participate, hosting, one ISO, one privacy (`#faq`) |
| 9 | Contact | Email + WhatsApp QR (`#contact`) |
| 10 | Purpose | Mission + Vision closer (`#purpose`); 10M/2030 framed as goal, not a live KPI |
| 11 | Footer | Secondary routes + legal |

### Removed from home

| Former section | Disposition |
|----------------|-------------|
| Vision / Mission / Values / PrivacyTrust (old multi-block) | Merged into **Why KM0**; Mission/Vision statements restored as single **Purpose** closer (boss mandate 2026-07-18) |
| Meaning (logo symbolism) | Off home; use `/presentation/` |
| MerchShowcase / Horizonte | Removed (no product URL) |
| Standalone CloudUserStats section | Kept as intentional Ink band after Why |

### Purpose policy

- **On home** after Contact (stakeholder exception to conversion “Purpose off home”).
- Keep `id="purpose"` and `purpose.*` i18n keys.
- Mission number (10.000.000 / 2030) stays as a **declared goal** (“Goal: …” / “Objetivo: …” / etc.).
- **Ban:** fake KPI strip, count-up animation to 10M, “Trusted by 10M” framing.

## Primary nav (desktop + mobile)

Home · Services · Pricing · Blog · Ideas · Encuentros · Contact

## Secondary (footer / overflow)

Tutorials · Presentation · FAQ · Legal · Security · product deep links (Cloud, Email)

## Stable routes (do not 404)

`/doc/`, `/tutorials/`, `/pricing/`, `/ideas/`, `/meeting/`, `/security/`, `/legal/`, `/presentation/`

## Anchor redirects note

Old hashes `#vision`, `#mission`, `#values`, `#meaning`, `#privacy-trust` no longer exist as standalone sections. Prefer `#why`, `#services`, `#community`, `#faq`, `#contact`, `#cloud-users`, `#purpose`.
