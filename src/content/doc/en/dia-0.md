---
title: "Day 0 — Server foundations"
description: "Debian, partitioning, Docker, Nginx, and a reproducible base so the KM0 stack stays auditable and operable."
pubDate: 2026-05-21
locale: en
---

Day 0 is dedicated to **foundations**: without a reproducible operating system and working environment, any later stack would be fragile and hard to audit. The goal is to end the day with stable Debian, an orderly disk layout, minimal but sufficient tooling, and a shell that encourages documenting every change.

## Bootstrap technical plan (full picture)

KM0 aims for infrastructure that the team can operate without opaque proprietary panels:

- **System:** VPS on up-to-date Debian, with a partition scheme that separates system from data where it makes sense (easier snapshots and backup policies).
- **Collaboration:** [OpenCloud](https://cloud.km0.amvara.de) deployed as coordinated microservices inside an official image maintained by the [OpenCloud.eu](https://opencloud.eu) community, with stable volume naming (`COMPOSE_PROJECT_NAME`) so backups do not depend on the directory from which Compose is run.
- **Perimeter:** Nginx as the sole HTTPS front; Docker overlays that publish HTTP only on `127.0.0.1`.
- **Communication:** Dockerized Astro site serving static files on another loopback port; separate virtual hosts for marketing (`km0.amvara.de`) and cloud (`cloud.km0.amvara.de`).
- **Observability and maintenance:** rotated container logs (`json-file` with a max size), routine commands documented in runbooks (`docker compose ps` / `logs` / `pull`), volume backups as compressed artifacts.
- **Evolution:** room to harden TLS between internal microservices once certificates are fully trusted in chain (move from test to production mode), automate backups, and tighten Fail2ban policies per specific jails.

## VPS provisioning and partitions

A **Debian** server was chosen for predictable package cycles and extensive documentation for hands-on administration (no mandatory control panels). The first step was to review disk layout and create partitions aligned with intended use:

- Separation that lets project data grow without mixing it with the root filesystem when volume-level backup is needed.
- Clear mount criteria (`/var/lib/docker` may concentrate OpenCloud I/O depending on VPS size).
- Documented conventions so anyone on the team can tell persistent data mounts from system mounts.

Exact partition maps depend on provider and contracted size; what matters is documenting them outside this blog in the project wiki or runbook for disaster recovery.

## Base software

A reasonable minimum was installed for secure remote administration and building on Docker without unnecessary bloat:

- Common system tools (`curl`, editors, network and diagnostic utilities).
- **Docker Engine** with rotated log policy (`/etc/docker/daemon.json`) so logs do not fill the disk.
- **Nginx** from system packages as a stable front.
- **Certbot** / TLS strategy by project phase (initial HTTP-01 issuance vs self-signed certificate for lab work).

The idea is that each component has a single, observable role in the dependency tree (`systemctl status`, `nginx -t`, `docker compose ps`).

## Shell ergonomics and reproducible initial setup

To keep later SSH sessions consistent, improvements followed the wiki’s internal [initialConfiguration](https://wiki.ldeluipy.es/initialConfiguration.html) guide:

- A more readable Bash prompt (current directory, command status, visual hints).
- Settings that reduce repeated mistakes (useful history, safe defaults where applicable).
- Aliases and `PATH` conventions that anticipate Docker Compose and Git work under `/opt/...`.

Having this base written down off-server lets the same “template” be repeated on other project VPS instances without improvising each time.

## cursor-agent

**cursor-agent** was installed to bring day-to-day server work closer to an assisted development flow: automated reviews, helper scripts, and incremental documentation without leaving the command line.

It does not replace human review or team change controls, but it lowers friction for verifiable repeat tasks (updating Compose overlays, validating Nginx syntax before reload, etc.).

## State at the end of day 0

By the end of the day the server satisfies three properties:

1. **Auditable:** known disk layout and packages.
2. **Repeatable:** main steps link to wiki and runbooks.
3. **Ready** for Docker workloads without prematurely exposing services to the public.

**Day 1** builds on this base to bring up OpenCloud, the proxy virtual host, and the KM0 site over TLS. In the meantime, explore the published [services](/en/#servicios) or [get in touch](/en/#contacto) if you want to collaborate.
