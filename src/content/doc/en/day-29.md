---
title: "Day 29 - One KM0 login: Keycloak for Cloud web, desktop, and mobile"
description: "Cloud in the browser, the OpenCloud desktop client, and the mobile apps now share the same KM0 sign-in. Why we moved, what to do, and links to the new tutorials."
pubDate: 2026-10-06
locale: en
image: /brand/day29-hero.png
imageAlt: "Shared KM0 sign-in screen on Keycloak"
---

**Cloud in the browser, the desktop sync client, and the phone apps now use the same KM0 login.** One account, one password, one sign-in screen. That is the point of this upgrade.

We moved the live Cloud identity to **Keycloak** at [sso.km0digital.com](https://sso.km0digital.com/) (realm for Kilometer 0 Digital). The old separate login path is out of the way for day-to-day Cloud use.

## Why we did it

Separate logins for each surface meant more passwords to remember and a weaker place to harden security. A single sign-in service lets us improve account protection in one place, including **two-factor authentication (2FA)** when you turn it on.

Your existing address and password still apply where we migrated the account. You may still need to **sign in again** once on each app so the client picks up the new login.

## What you should do

1. Open Cloud in the browser and complete the new sign-in if asked. Step-by-step: [Sign in to KM0 Cloud with the shared login](/en/tutorials/keycloak-sign-in-cloud/).
2. Turn on 2FA when the account screen offers it: [Enable 2FA on your KM0 account](/en/tutorials/keycloak-2fa/).
3. On the OpenCloud desktop client, re-connect the account (Advanced / account settings) if sync stopped after the change: [Re-login on OpenCloud Desktop](/en/tutorials/opencloud-desktop-relogin/).
4. On Android or iOS, open the app once and finish sign-in if the session expired. Server address stays `https://cloud.km0digital.com/`.


## Same login, several surfaces

| Surface | Uses the shared KM0 login |
|---------|---------------------------|
| Cloud in the browser | Yes |
| OpenCloud Desktop (Windows, macOS, Linux) | Yes |
| OpenCloud apps on Android and iOS | Yes |

You should see the same sign-in experience when any of those asks you to authenticate. That is intentional.

## If something looks wrong

- Browser loops on sign-in: clear the site cookies for Cloud and try once more, or use a private window.
- Desktop created a **second** sync folder: stop and [contact us](/en/#contact) before you delete local files. We would rather fix the account link than lose a copy.
- Password forgotten: use the recovery flow on the sign-in screen.

The technical diary will keep going. For daily work, the useful change is simple: **one KM0 login across Cloud web, desktop, and mobile**, with tutorials when you need the clicks.
