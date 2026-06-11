# KM0 email templates

HTML templates for KM0 Cloud marketing and transactional email. Aligned with [brand tokens](../docs/brand-tokens.md) and the OpenCloud login aesthetic.

## Layout

```
email-templates/
  webstyle/      # Light theme  -  acquisition / KM0 Cloud launch
    es.html ca.html en.html de.html
  cloudstyle/    # Dark theme  -  security alerts, account notices
    es.html ca.html en.html de.html
  welcome/       # Cloudstyle theme  -  post-registration onboarding
    es.html
```

Logo for sends: `https://km0digital.com/brand/logo-icon.png` (source in `public/brand/logo-icon.png`).

## Placeholders

Replace before send:

| Variable | Used in |
|----------|---------|
| `{{ASSET_BASE_URL}}` | Both (default: `https://km0digital.com/brand`) |
| `{{USER_NAME}}` | Cloudstyle, Welcome |
| `{{DEVICE_NAME}}`, `{{LOCATION}}`, `{{DATE_TIME}}`, `{{IP_ADDRESS}}` | Cloudstyle |
| `{{ACTION_URL}}` | Cloudstyle |
| `{{CLOUD_URL}}`, `{{HELP_EMAIL}}` | Welcome |

## Test send

Dev notifications use AutoMail (`scripts/notify-idea-email.sh`, `AUTOMAIL_TOKEN` in repo `.env`). For HTML tests, POST JSON to the same API:

```bash
html=$(sed 's|{{ASSET_BASE_URL}}|https://km0digital.com/brand|g' email-templates/webstyle/es.html)
curl -sS -X POST "${AUTOMAIL_API_URL:-https://automail.lu-zero.ldeluipy.es/api/send.php}" \
  -H "Authorization: Bearer ${AUTOMAIL_TOKEN}" \
  -H 'Content-Type: application/json' \
  -d "$(jq -n --arg to "you@example.com" --arg subject "KM0 test" --arg html "$html" '{to:$to,subject:$subject,html:$html}')"
```

## Locales

| Code | Webstyle h1 | Cloudstyle CTA |
|------|-------------|----------------|
| es | Recupera el control | Revisar actividad de cuenta |
| ca | Recupera el control | Revisar l'activitat del compte |
| en | Reclaim your control | Review account activity |
| de | Kontrolle zurück | Kontoaktivität prüfen |

Public offer copy: **500 GB / 1,99 €/month** (see `src/i18n/*/json` pricing section).
