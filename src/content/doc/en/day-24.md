---
title: "Day 24 - Maestro: running the fleet from Discord"
description: "How we operate KM0 with Maestro: project catalog, persistent threads, OpenCloud as a hangar, and Redmine trails."
pubDate: 2026-09-04
locale: en
image: /brand/maestro-og.png
portrait: /brand/maestro.png
imageAlt: "Portrait of Maestro, KM0's Discord orchestrator"
---

Running KM0 is more than shipping Cloud and Mail. There are sites, mail, auth, OpenCloud, monitors, and a pile of hosts. **Maestro** is the Discord orchestrator we use so we do not lose the thread across servers and projects.

## The problem it solved

Before, every fix started the same way: open a terminal, enter the right server, remember where the repo lived, rebuild context from memory, and spin up a throwaway agent with a prompt from scratch. When the session ended, that context vanished.

With ~10 hosts and dozens of projects (km0-web, OpenCloud, mail, auth, and the rest of the Amvara perimeter), that does not scale. The real cost was not typing commands: it was **finding the map again** every time.

## What Maestro is

A Discord bot bound to a project catalog. It takes the order (slash command or natural language), loads case context, opens a focused session on the right tree, and reaches the host over SSH. The Discord thread stays tied to that session.

While the thread is open, you can leave work on Monday, paste a log on Thursday, and continue without re-explaining the environment. When you close the thread, a summary of what changed remains; if the case needs it, a Redmine note too.

## What it gives KM0

It is not a storefront product: it is how we run the house. Three concrete pieces:

1. **Catalog and context:** each project (for example this site under `/opt/km0-web`) has a pack of paths, runbooks, and rules. Maestro does not invent hosts; it only works what is registered.
2. **OpenCloud hangar:** space `maestro@km0digital.com` over WebDAV (`human_input/`, `maestro_input/`). Used to move files Discord should not keep (long logs, screenshots, deliverables) without fighting chat TTL.
3. **Traceability:** Redmine notes in technical English (Textile), tied to the project ticket. Chat stops being the only memory archive.

It can also read attachments (images, PDF, logs), call tools already deployed in the fleet (headless browser, and so on), and return captures in the same thread. What is not in the catalog does not exist for it: that is a safety rule, not a marketing limit.

## Why we write it here

The KM0 blog documents how the infra is built and kept, not only the commercial pitch. Maestro fits that line: **audible operations**, with session, summary, and ticket, instead of “someone fixed it in a forgotten shell”.

The flow is plain: Discord → core (catalog + session) → SSH to the host; if needed, a backup bridge with its own rules.

## Close

Cloud and Mail stay in the [EU](/en/#services). If you want to see how we work or try the product, [contact us](/en/#contact) or come to a [meetup](/en/meeting/). Day-to-day fleet work, when it matters, starts with a Discord message: that is Maestro.
