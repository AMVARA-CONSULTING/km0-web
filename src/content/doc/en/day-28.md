---
title: "Day 28 - A cleaner front door for public HTTPS"
description: "We put a reverse proxy in front of the public edge so TLS and routing sit in one place, with a maintenance path ready, while Cloud URLs stayed the same."
pubDate: 2026-10-05
locale: en
---

On 5 October we changed how public HTTPS hits the KM0 host. A reverse proxy now sits at the front door for ports 80 and 443. Nginx still does the work it is good at; the edge is easier to reason about.

## What that means for you

- Same public URLs. Cloud, the marketing site, and the rest keep the names you already use.
- TLS termination and routing live in one place at the edge.
- We can flip a maintenance page without rewriting every site by hand.

## Why bother

Fewer surprises when we cut over identity or add a service. The reader never needs the plumbing; operators need a door that opens the same way every time.

## Status

If your bookmarks still open, you are done. Problems with HTTPS that day: [contact](/en/#contact).
