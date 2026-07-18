# Information architecture map

Canonical map after **FEAT-74** (IA restructure), updated **2026-07-18** (landing conversion gather: Purpose off home; Community before FAQ).

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
| 10 | Footer | Secondary routes + legal |

### Removed from home

| Former section | Disposition |
|----------------|-------------|
| Vision / Mission / Values / PrivacyTrust | Merged into **Why KM0** |
| Meaning (logo symbolism) | Off home; use `/presentation/` |
| MerchShowcase / Horizonte | Removed (no product URL) |
| Purpose (mission/vision + vanity goal) | Off home; do not restore invented “10M by 2030” without a sourced metric |
| Standalone CloudUserStats section | Kept as intentional Ink band after Why |

## Primary nav (desktop + mobile)

Home · Services · Pricing · Blog · Ideas · Encuentros · Contact

## Secondary (footer / overflow)

Tutorials · Presentation · FAQ · Legal · Security · product deep links (Cloud, Email)

## Stable routes (do not 404)

`/doc/`, `/tutorials/`, `/pricing/`, `/ideas/`, `/meeting/`, `/security/`, `/legal/`, `/presentation/`

## Anchor redirects note

Old hashes `#vision`, `#mission`, `#values`, `#meaning`, `#privacy-trust`, `#purpose` no longer exist on home. Prefer `#why`, `#services`, `#community`, `#faq`, `#contact`, `#cloud-users`.
