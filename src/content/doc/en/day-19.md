---
title: "Day 19 - KM0 Mail: native sign-in, self-service registration, and your own domains"
description: "KM0 Mail no longer relies on external redirects: native login, one-minute registration, and self-managed custom domains from webmail."
pubDate: 2026-08-05
locale: en
---

Since we launched KM0 Email (see [day 11](/en/doc/day-11/)), the mail stack has matured. The latest round of changes in km0-mail follows a simple idea: anyone should be able to have their own mailbox without depending on Gmail, without opaque panels, and without paid APIs.

## Native sign-in, no detours

Signing in used to bounce through a separate authentication service. Now [mail.km0digital.com](https://mail.km0digital.com/) asks for your **email and password** directly. OpenCloud / LDAP sign-in still exists, but as a secondary option for people who already have a cloud account.

We also improved the **error messages**: if credentials fail or the server does not respond, it now says so clearly and in your language (ES, CA, EN, DE), instead of a generic "Login failed".

## Registration in a minute

The `/register` page was stripped down: pick a **username and password** and get `username@km0digital.com` instantly. You verify the account from your own inbox. You can receive and read mail right away; to **send**, you first confirm the verification link. It is a simple defense against abuse, with no friction for the legitimate user.

## Your own domain, self-managed

The big addition: **custom domains without going through support**. Inside webmail, under **Settings > My domains**, any user can:

1. Add their domain (for example `yourdomain.com`).
2. Publish the DNS records we show: ownership (TXT), MX, SPF, and DKIM.
3. Click **Verify** and wait for propagation.
4. Create `name@yourdomain.com` addresses with their own password.

Each domain signs its mail with **its own DKIM**, so deliverability does not hang on a single shared domain. The whole flow is self-service, in the style of the large providers, but on infrastructure we control.

## No paid dependencies

None of this uses Google Workspace APIs, paid relays, or external verification services. It is self-hosted mail, on the same server Kilometer 0 already operates.

## Closing

Mail went from "internal mailboxes" to a **service anyone can use and extend with their own domain**. To put it into practice, we wrote step-by-step guides: see the [KM0 Mail tutorials](/en/tutorials/) or go straight to [mail.km0digital.com](https://mail.km0digital.com/). In [day 20](/en/doc/day-20/) we cover how those tutorials turned out.
