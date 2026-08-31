# KM0 email templates

HTML templates for KM0 Cloud marketing and transactional email. Aligned with [brand tokens](../docs/brand-tokens.md) (**civic dark**: Paper `#0B1220`, Snow `#141B28`, Signal `#2DD4BF`, Ink `#E6E9ED`).

## Layout

```
email-templates/
  webstyle/      # Civic dark  -  acquisition / marketing
    es.html ca.html en.html de.html
  cloudstyle/    # Dark theme  -  security alerts, account notices
    es.html ca.html en.html de.html
  welcome/       # Cloudstyle theme  -  post-registration onboarding
    es.html
```

Logo for sends: `https://km0digital.com/brand/logo-icon.png` (source in `public/brand/logo-icon.png`).

## Design notes (webstyle)

- Dark-only canvas (matches the marketing site; no light card, no purple gradient).
- Signal teal bar + CTA (`#2DD4BF` on Paper text).
- IBM Plex Sans (UI / headlines) + Source Serif 4 (body), with Georgia / Helvetica fallbacks.
- Soft radius card (`16px`), Mist hairlines (`#2A3344`), no pill CTAs.

## Placeholders

Replace before send:

| Variable | Used in |
|----------|---------|
| `{{BODY}}` | Webstyle (main message paragraph) |
| `{{ASSET_BASE_URL}}` | Cloudstyle, Welcome (default: `https://km0digital.com/brand`) |
| `{{USER_NAME}}` | Cloudstyle, Welcome |
| `{{DEVICE_NAME}}`, `{{LOCATION}}`, `{{DATE_TIME}}`, `{{IP_ADDRESS}}` | Cloudstyle |
| `{{ACTION_URL}}` | Cloudstyle |
| `{{CLOUD_URL}}`, `{{HELP_EMAIL}}` | Welcome |

## Test send

Dev notifications use AutoMail (`scripts/notify-idea-email.sh`, `AUTOMAIL_TOKEN` in repo `.env`). For HTML tests, POST JSON to the same API:

```bash
html=$(python3 -c "
from pathlib import Path
html = Path('email-templates/webstyle/es.html').read_text()
print(html.replace('{{BODY}}', 'Lorem ipsum dolor sit amet…'))
")
curl -sS -X POST "${AUTOMAIL_API_URL:-https://automail.lu-zero.ldeluipy.es/api/send.php}" \
  -H "Authorization: Bearer ${AUTOMAIL_TOKEN}" \
  -H 'Content-Type: application/json' \
  -d "$(jq -n --arg to "you@example.com" --arg subject "KM0 test" --arg html "$html" '{to:$to,subject:$subject,html:$html}')"
```

## Locales

| Code | Webstyle h1 | Cloudstyle CTA |
|------|-------------|----------------|
| es | Cloud y Email en la UE. | Revisar actividad de cuenta |
| ca | Cloud i Email a la UE. | Revisar l'activitat del compte |
| en | Cloud and Email in the EU. | Review account activity |
| de | Cloud und E-Mail in der EU. | Kontoaktivität prüfen |

Public offer copy: **500 GB / 1,99 €/month** (see `src/i18n/*/json` pricing section).
