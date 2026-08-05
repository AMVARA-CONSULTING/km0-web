# Tutorial screenshots manifest

The KM0 Mail tutorials reference screenshots that are not yet in the repo. Drop the
real PNGs at the exact paths below and they will render in place (they are served
from `public/`, so a file at `public/tutorials/mail/register-form.png` is reached at
`/tutorials/mail/register-form.png`). Until a file exists, the tutorial shows the
image alt text instead of a broken layout.

Capture from the live product at `https://mail.km0digital.com`. Do not redraw or mock
browser or app chrome (see `.cursor/rules/anti-slop-frontend.mdc`); use genuine
screenshots. Crop tightly to the relevant UI, avoid personal data, and prefer a width
around 1200 px.

## Required files

| File (place under `public/tutorials/mail/`) | Used in | What it should show |
|---|---|---|
| `register-form.png` | mail-register | The registration page at `/register`: username field with `@km0digital.com` hint, password, confirm password, Create account button. |
| `sign-in-form.png` | mail-sign-in | The sign-in screen at `/`: email + password fields and the primary sign-in button (the secondary OpenCloud / LDAP option can be visible). |
| `settings-my-domains.png` | mail-custom-domain | Webmail Settings, My domains section: the "Add a domain" input and the list of your domains. |
| `dns-records.png` | mail-custom-domain | The DNS records table for a pending domain: TXT (ownership), MX, TXT (SPF), TXT (DKIM) rows with their host/value and pending/OK status badges. |
| `add-address.png` | mail-custom-domain | The Add address form on a verified domain: username and password fields. |

## Notes

- All five images are shared across the four locales (es, ca, en, de); one file per name is enough.
- If you localize any screenshot, keep the same file name and overwrite it; the tutorials do not switch image paths per language.
- After adding the files, rebuild the site (`docker compose build && docker compose up -d`) and check `/tutorials/mail-register/`, `/tutorials/mail-sign-in/`, and `/tutorials/mail-custom-domain/`.
