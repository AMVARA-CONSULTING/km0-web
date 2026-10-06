# KM0 identity (Keycloak) - sibling map

This repository is the **marketing site** only. Identity lives on other hosts. This page is the operator map after the 5-6 Oct 2026 Keycloak work. It is not a Keycloak runbook.

## Live issuer

| Field | Value |
|-------|--------|
| Host | amvara3 |
| Public | https://sso.km0digital.com |
| KM0 realm | `km0digital` |
| Issuer | `https://sso.km0digital.com/realms/km0digital` |
| Catalog | `km0-sso` (`/data/keycloak/app`) |
| Ticket | [#8249](https://redmine.amvara.de/issues/8249) `[KM0] IAM` |

Do not send KM0 Cloud or Mail OIDC to realm `amvara`. That realm still exists for Amvara Git/Redmine.

## What changed (5-6 Oct 2026)

**5 Oct**

- Keycloak compose `amvara-sso` on amvara3 behind HAProxy (`sso.km0digital.com` → `127.0.0.1:18443`).
- TLS name `sso.km0digital.com`.
- OpenCloud on amvara10: `OC_OIDC_ISSUER` → realm `km0digital`. Account lookup stays email (`preferred_username`).
- Mail discovery/introspect URLs already point at Keycloak (env keys may still be named `DEX_*`).

**6 Oct**

- Custom Keycloak image: bcrypt verifier (imported mailbox hashes) plus event listener `km0-mail-access` (role `km0MailUser` for `@km0digital.com`).
- KM0 theme not on Keycloak yet.
- Cloud and Mail login still separate. Logout is not symmetric (Mail logout does not end Cloud; Cloud logout can end Mail session without kicking the Mail UI).
- Git (`git.amvara.de`) and Redmine (`redmine-gateway`) OIDC stay on realm `amvara`. Usual KM0 users have no Git/Redmine access until that is pointed at the right realm.

Dex on amvara10 may still run. It is not the live Cloud issuer.

## Product map

| Product | URL | Catalog | OIDC now |
|---------|-----|---------|----------|
| Marketing (this repo) | https://km0digital.com | `km0-web` on amvara10 `/opt/km0-web` | none |
| Auth hub | https://auth.km0digital.com | `km0-auth` | Keycloak `km0digital` (`hub-auth.js`) |
| Cloud | https://cloud.km0digital.com | `opencloud` | Keycloak `km0digital` (`opencloud-web` + desktop/mobile clients) |
| Mail | https://mail.km0digital.com | `km0-mail` | Keycloak client `km0-mail-web`; login UI still separate |
| SSO | https://sso.km0digital.com | `km0-sso` | Keycloak 26.7.3 |
| Redmine | https://redmine.amvara.de | `redmine` | gateway on realm `amvara` (broken for KM0 users) |
| Git | git.amvara.de | `gitlab` on amvara2 | client on realm `amvara` (same gap) |

Desktop still uses server URL `https://cloud.km0digital.com`. Local `~/.config/OpenCloud/opencloud.cfg` binds the sync folder with `spaceId` (`storageId$openCloudUUID`). That id is OpenCloud IDM, not the Keycloak user id and not the local account UUID in the cfg.

## Where to change what

| Change | Go here |
|--------|---------|
| Marketing pages | this repo `/opt/km0-web` |
| Login/register UX | `/opt/km0-auth` |
| Cloud issuer env | `/opt/opencloud/opencloud-compose/.env` |
| Keycloak / HAProxy SSO | amvara3 `/data/keycloak/app`, `/data/haproxy/amvara3.cfg` |
| Mail OIDC env | `/opt/km0-mail` |

Never put Keycloak, Google, or `.env` secrets in this repo or in Discord.
