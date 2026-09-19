---
title: "Day 24 - Maestro: running the fleet from Discord"
description: "How we operate KM0 with Maestro: project catalog, persistent threads, OpenCloud as a hangar, and Redmine trails."
pubDate: 2026-09-04
locale: en
image: /brand/maestro-og.png
portrait: /brand/maestro.png
imageAlt: "Portrait of Maestro, KM0's Discord orchestrator"
---

KM0 includes sites, mail, auth, OpenCloud, monitors, and about ten hosts. Maestro is the Discord bot we use to keep work moving across servers and projects.

## Before

Every fix started the same way: open a terminal, enter the right server, remember the repo path, rebuild context from memory, and start a new agent with a prompt from scratch. When the session ended, that context was gone.

With dozens of projects (km0-web, OpenCloud, mail, auth, and the rest of the Amvara perimeter), the time went into finding the map again.

## What it does

Maestro is bound to a project catalog. It takes the order (slash command or natural language), loads the case context, opens a session on the right tree, and reaches the host over SSH. The Discord thread stays tied to that session.

While the thread is open you can leave work on Monday, paste a log on Thursday, and continue without explaining the environment again. Closing the thread leaves a summary of what changed. If the case needs it, a Redmine note too.

## How we use it

This is how we run the house.

1. Catalog and context. Each project (this site lives under `/opt/km0-web`) has paths, runbooks, and rules. Maestro works what is registered and does not invent hosts.
2. OpenCloud hangar. The space `maestro@km0digital.com` over WebDAV (`human_input/`, `maestro_input/`) moves long logs, screenshots, and deliverables that Discord should not keep, without fighting chat TTL.
3. Traceability. Redmine notes in technical English (Textile), tied to the project ticket. Chat is no longer the only archive.

It also reads attachments (images, PDF, logs), calls tools already deployed in the fleet (a headless browser, among others), and returns captures in the same thread. If something is not in the catalog, Maestro does not touch it. That is a safety rule.

## Why it is on the blog

This blog records how the infra behind Cloud and Mail is built and kept. Maestro belongs there: a session, a summary, and a ticket, instead of a fix in a shell nobody opens again.

The path is Discord, then the core (catalog and session), then SSH to the host. If needed, a backup bridge with its own rules.

Cloud and Mail stay in the [EU](/en/#services). If you want to see how we work or try the product, [contact us](/en/#contact) or come to a [meetup](/en/meeting/). Day-to-day fleet work, when it matters, starts with a Discord message.
