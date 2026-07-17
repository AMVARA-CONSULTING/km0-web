---
title: "Day 0 - Server foundations"
description: "Debian, partitioning, Docker, Nginx, and a reproducible base so the KM0 stack stays auditable and operable."
pubDate: 2026-05-21
locale: en
---

Day 0 ships the **foundations**: reproducible Debian, a clear disk layout, Docker-ready tooling, and a documented shell. Without that base, later stacks stay fragile and hard to audit.

Goal for the day: a VPS any teammate can audit and rebuild from wiki and runbooks, not from memory.

## Bootstrap plan

KM0 aims for infrastructure the team can operate without opaque proprietary panels:

- **System:** VPS on up-to-date Debian; partitions that separate system from data when backups need clarity.
- **Collaboration:** [OpenCloud](https://cloud.km0digital.com) on the official [OpenCloud.eu](https://opencloud.eu) image, with stable volumes (`COMPOSE_PROJECT_NAME`) independent of the Compose working directory.
- **Perimeter:** Nginx as the sole HTTPS front; Docker publishes HTTP only on `127.0.0.1`.
- **Site:** Dockerized Astro on another loopback port; separate vhosts for `km0digital.com` and `cloud.km0digital.com`.
- **Ops:** rotated `json-file` logs, runbooks (`docker compose ps`, `logs`, `pull`), compressed volume backups.
- **Next hardening:** production TLS, automated backups, Fail2ban per specific jails.

## Disk and Debian

**Debian** was chosen for predictable packages and hands-on documentation, without mandatory control panels. First step: review disk layout.

- Separate project data from the root filesystem when volume-level backup is needed.
- Mount deliberately: `/var/lib/docker` can concentrate OpenCloud I/O depending on VPS size.
- Document which mounts are persistent versus the operating system.

> Exact partition maps depend on provider and contracted size. They belong in the project wiki or runbook, not only in this post.

## Base software

A reasonable minimum was installed for secure remote administration and Docker:

- Common utilities: `curl`, editors, network and diagnostics
- **Docker Engine** with rotated logs in `/etc/docker/daemon.json`
- **Nginx** from system packages as the front
- **Certbot** and TLS by phase (HTTP-01 or self-signed certificate in the lab)

Each piece should be checkable: `systemctl status`, `nginx -t`, `docker compose ps`.

## Shell ergonomics

For consistent SSH sessions, the wiki [initialConfiguration](https://wiki.ldeluipy.es/initialConfiguration.html) guide was applied:

- Readable Bash prompt (path, command status, visual hints)
- History and safe defaults that reduce repeated mistakes
- Aliases and `PATH` geared toward Compose and Git under `/opt/...`

Document the template off-server so other VPS instances can reuse it.

## cursor-agent

**cursor-agent** was installed for assisted CLI work: reviews, helper scripts, and incremental documentation from the console.

It does not replace human review. It lowers friction on repeatable tasks (Compose overlays, validating Nginx before reload).

## End of day 0

By the end of the day, the server should be:

1. **Auditable:** known disk layout and packages
2. **Repeatable:** main steps linked to wiki and runbooks
3. **Ready** for Docker without exposing services publicly too early

**Day 1** brings up OpenCloud, the proxy virtual host, and the KM0 site over TLS. Next step for readers: [services](/en/#services) or [contact](/en/#contact).
