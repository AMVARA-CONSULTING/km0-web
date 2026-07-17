# Information architecture map

Canonical map after **FEAT-74** (IA restructure). Visual remodel and full copy rewrite are separate tasks.

## Landing (`/`, `/ca/`, `/en/`, `/de/`)

| Order | Block | Anchor / role |
|------:|-------|----------------|
| 1 | Header | Primary nav only |
| 2 | Hero | Brand + promise; primary CTA → KM0 Cloud; secondary → Pricing |
| 3 | Offer (`Services`) | Cloud + Email, price hook, tutorials/pricing links; **live user counter** as editorial proof band (`#cloud-users`) |
| 4 | Why KM0 | Single contrast block (`#why`); presentation link for depth |
| 5 | Community / Encuentros | Short teaser (`#community`) → `/meeting/` |
| 6 | FAQ | Deduped: movement, participate, hosting, one ISO, one privacy (`#faq`) |
| 7 | Contact | Single next step (`#contact`) |
| 8 | Footer | Secondary routes + legal |

### Removed from home

| Former section | Disposition |
|----------------|-------------|
| Vision / Mission / Values / PrivacyTrust | Merged into **Why KM0** |
| Meaning (logo symbolism) | Off home; use `/presentation/` |
| MerchShowcase / Horizonte | Removed (no product URL) |
| Standalone CloudUserStats section | Kept data source; embedded in Offer |

## Primary nav (desktop + mobile)

Home · Services · Pricing · Blog · Tutorials · Encuentros · Contact

## Secondary (footer / overflow)

Ideas · Presentation · FAQ · Legal · Security · product deep links (Cloud, Email)

## Stable routes (do not 404)

`/doc/`, `/tutorials/`, `/pricing/`, `/ideas/`, `/meeting/`, `/security/`, `/legal/`, `/presentation/`

## Anchor redirects note

Old hashes `#vision`, `#mission`, `#values`, `#meaning`, `#privacy-trust` no longer exist on home. Prefer `#why`, `#services`, `#community`, `#faq`, `#contact`.
