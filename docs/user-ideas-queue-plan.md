# User ideas intake - queue and secret processor plan

Plan for collecting public comments from the static site without exposing the downstream secret script. The web only talks to a public receiver; the secret logic runs on the host with no HTTP endpoint.

**Status:** receiver, public form, and Script 2 processor implemented; host setup via `scripts/setup-ideas-processor.sh`.
**Related:** [runbook.md](./runbook.md) (deploy and nginx).

---

## Goal

```text
Browser form (Astro)
  → POST /hooks/ideas (nginx, rate limited)
  → Public receiver (Script 1, in repo / Docker)
  → Atomic write to queue file (JSON)
  → systemd path unit triggers secret processor (Script 2, host only)
  → Script 2 consumes payload, runs business logic, removes or archives file
```

**Public cannot:** read Script 2, call it over HTTP, or see its path in responses or frontend assets.  
**Limit:** root and server admins can always read host files; this design hides the secret from the internet and from the Git repo.

---

## Directory layout

### On the host (not in Git)

| Path | Purpose | Owner | Mode |
|------|---------|-------|------|
| `/var/spool/km0-ideas/incoming/` | New submissions (Script 1 writes) | `km0-queue:km0-queue` | `750` |
| `/var/spool/km0-ideas/processing/` | Claimed jobs (Script 2 moves here first) | `km0-queue:km0-queue` | `750` |
| `/var/spool/km0-ideas/processed/` | Successful runs (optional audit) | `km0-processor:km0-processor` | `750` |
| `/var/spool/km0-ideas/failed/` | Validation or runtime errors | `km0-processor:km0-processor` | `750` |
| `/opt/km0-web/scripts/process-idea.sh` | **Script 2 (processor)** | `root` | `755` |
| `/opt/km0-web/autoagents/.env` | `GH_TOKEN` for `gh issue create` (host only, not in Git) | `root` | `600` |
| `/var/log/km0-ideas/` | Receiver and processor logs | `root:adm` | `750` |

Install Script 2 and systemd units on the host:

```bash
sudo ./scripts/setup-ideas-processor.sh
```

**Never commit** `autoagents/.env` or tokens to `km0-web`.

### In this repo (public side)

| Path | Purpose |
|------|---------|
| `scripts/receive-idea.sh` | Validates payload, atomic enqueue (Script 1 logic) |
| `hooks/hooks.json` | [webhook](https://github.com/adnanh/webhook) config (if used) |
| `docker-compose.yml` | Add `km0-ideas-receiver` service (no secret mounts) |
| `nginx/` | Snippet for `/hooks/ideas` proxy and `limit_req` |
| `src/components/` or `src/views/` | Public form UI (later implementation) |

Mount only `/var/spool/km0-ideas/incoming` into the receiver container (write-only from the container’s perspective).

---

## Queue file format (JSON)

Use **one file per submission**, not a shared append-only `.txt`. Append races are harder to handle safely than isolated files.

**Filename:** `{iso8601utc}-{uuid}.json`  
Example: `20260604T153012Z-a1b2c3d4-e5f6-7890-abcd-ef1234567890.json`

**Body:**

```json
{
  "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "receivedAt": "2026-06-04T15:30:12Z",
  "locale": "es",
  "email": "user@example.com",
  "idea": "Plain text comment from the user.",
  "meta": {
    "userAgent": "Mozilla/5.0 ...",
    "remoteAddr": "203.0.113.42"
  }
}
```

| Field | Rules |
|-------|--------|
| `idea` | Required, max 4000 chars, no NUL bytes, trim whitespace |
| `email` | Optional, max 254 chars, basic format check |
| `locale` | Optional, one of `es`, `ca`, `en`, `de` |
| `meta` | Set by receiver only, never trusted from client |

Script 1 generates `id` and `receivedAt`. Do not trust client-supplied IDs.

---

## Script 1 - public receiver

**Responsibilities:**

1. Accept `POST` with JSON body (or form fields mapped to JSON).
2. Reject spam: honeypot field, nginx rate limit, optional [Cloudflare Turnstile](https://developers.cloudflare.com/turnstile/).
3. Validate and normalize fields (length, charset).
4. Write queue file **atomically** (see below).
5. Return generic JSON: `{"ok": true}` or `{"ok": false, "error": "invalid_input"}` with no internal paths.

**Must not:** invoke Script 2, mention `/opt/km0-private`, or log full payloads at info level in production.

**Atomic write (Script 1):**

```bash
tmp="$(mktemp "/var/spool/km0-ideas/incoming/.tmp.XXXXXX")"
printf '%s' "$json" > "$tmp"
chmod 640 "$tmp"
mv "$tmp" "/var/spool/km0-ideas/incoming/${name}.json"
```

`mv` on the same filesystem is atomic. Concurrent users get distinct filenames (`uuid`), so no write collision.

**Recommended implementation:** [adnanh/webhook](https://github.com/adnanh/webhook) container calling `scripts/receive-idea.sh`, or a minimal sidecar. HMAC secret in env file on host (`/opt/km0-web/.env.receiver`, not in Git).

---

## Script 2 - secret processor

**Responsibilities:**

1. Triggered by systemd when a new file appears (no HTTP).
2. **Claim** one or more jobs atomically, then process.
3. Run secret workflow (write internal txt, `gh issue create`, notify, etc.).
4. **Remove or archive** the queue file when done.
5. On failure, move to `failed/` with a sidecar `.err` log.

**Must not:** listen on a port or appear in Astro/nginx config. Lives in `scripts/process-idea.sh`; `GH_TOKEN` stays in host `.env` only.

### Concurrency-safe claim (recommended)

Multiple submissions at once must not double-process the same file. Two systemd triggers may overlap.

**Pattern: move-to-claim**

```bash
#!/usr/bin/env bash
set -euo pipefail

QUEUE="/var/spool/km0-ideas"
shopt -s nullglob

# Single-instance lock for the whole batch
exec 9>/var/run/km0-idea-processor.lock
flock -n 9 || exit 0

for f in "$QUEUE/incoming"/*.json; do
  base="$(basename "$f")"
  claimed="$QUEUE/processing/$base"
  if mv "$f" "$claimed" 2>/dev/null; then
    if process_one "$claimed"; then
      mv "$claimed" "$QUEUE/processed/$base"
    else
      mv "$claimed" "$QUEUE/failed/$base"
    fi
  fi
done
```

- **`mv incoming → processing`:** only one processor wins per file.
- **`flock`:** if systemd starts two instances, the second exits immediately or waits (use `-n` for fire-and-forget path units).
- **Instant handling:** path unit fires on create; typical latency is sub-second on a quiet VPS.

### After success

Prefer **delete** from `processed/` after N days (logrotate-style cron) if audit is not required. If audit is required, keep `processed/` and rotate with `find ... -mtime +30 -delete`.

### After failure

Move to `failed/` and write `failed/{same-name}.err` with timestamp and exit code. Alert ops (mail or monitoring). Do not requeue automatically without review (avoids infinite loops on bad payloads).

---

## systemd units (host)

Install under `/etc/systemd/system/` (templates in private ops repo, not `km0-web`).

**Path unit** (trigger on new files):

```ini
# km0-idea-processor.path
[Unit]
Description=Watch KM0 user idea queue

[Path]
PathModified=/var/spool/km0-ideas/incoming
PathExistsGlob=/var/spool/km0-ideas/incoming/*.json
MakeDirectory=no

[Install]
WantedBy=multi-user.target
```

**Service unit** (oneshot batch):

```ini
# km0-idea-processor.service
[Unit]
Description=Process KM0 user idea queue

[Service]
Type=oneshot
User=km0-processor
Group=km0-processor
ExecStart=/opt/km0-web/scripts/process-idea.sh
```

Enable both:

```bash
systemctl enable --now km0-idea-processor.path
```

**Fallback:** cron every minute running the same script if path units are unavailable.

---

## Docker and nginx

### docker-compose (receiver only)

- Service `km0-ideas-receiver`: image with webhook or minimal HTTP handler.
- Publish `127.0.0.1:9181:8080` (internal only).
- Volume: `/var/spool/km0-ideas/incoming:/var/spool/km0-ideas/incoming`.
- No mount of `/opt/km0-private`.
- Env: `WEBHOOK_SECRET`, max body size.

### Host nginx

- Location `/hooks/ideas` → `proxy_pass http://127.0.0.1:9181`.
- `limit_req zone=ideas burst=5 nodelay` (define zone in `http` context).
- `client_max_body_size 16k`.
- Generic `502/504` pages (no stack traces to clients).

---

## Security best practices

| Topic | Practice |
|-------|----------|
| Secret script | Host-only, `700`, dedicated Unix user |
| Receiver | Separate user; write-only on `incoming/` |
| User input | Never `eval`, never `bash -c "$idea"`; pass via file or quoted vars |
| HTTP | TLS only; no GET on hook URL; reject wrong methods |
| Auth | HMAC signature on webhook (header), secret only on server |
| Spam | Rate limit + honeypot + Turnstile if abuse appears |
| Responses | Generic errors; no paths, no stderr |
| Logs | Redact or truncate `idea` in receiver logs |
| Backups | Include `/var/spool/km0-ideas` if audit matters; exclude secret keys from backups to shared storage |
| ISO narrative | Document what is stored, retention, and who can read queue files |

---

## Edge cases

| Case | Handling |
|------|----------|
| Two users submit at once | Unique filenames + atomic `mv`; processor loop claims each file |
| Overlapping systemd runs | `flock` on `/var/run/km0-idea-processor.lock` |
| Partial write before crash | Write to `.tmp.*` then `mv`; processor only reads `*.json` in `incoming/` |
| Invalid JSON in queue | Move to `failed/`, log reason, do not crash daemon |
| Processor slower than intake | Queue depth grows in `incoming/`; batch script drains all on each trigger |
| Disk full | Receiver returns `503`; monitor spool directory size |
| Huge payload | Reject in Script 1 before write (`client_max_body_size` + validation) |

---

## Implementation phases

1. **Ops:** Create users, spool dirs, systemd units; deploy Script 2 to `/opt/km0-private/` (manual test with `echo '{}' > incoming/test.json`).
2. **Receiver:** Add webhook container, `receive-idea.sh`, compose port `9181`, nginx location.
3. **Frontend:** Astro form, i18n strings, POST to `/hooks/ideas`, thank-you state.
4. **Hardening:** Turnstile, monitoring on `failed/` count, log rotation.
5. **Docs:** Add runbook section (enqueue verify, replay failed job, disable intake).

---

## Verification checklist

```bash
# Receiver up (after implementation)
curl -sI http://127.0.0.1:9181/health

# Enqueue test (signed POST per webhook docs)
# Expect new file in incoming/, then empty after processor runs

ls -la /var/spool/km0-ideas/incoming/
ls -la /var/spool/km0-ideas/processed/

# Public must not reach secret paths
curl -sI https://km0digital.com/opt/km0-private/bin/process-idea.sh   # expect 404
```

---

## References

- [adnanh/webhook](https://github.com/adnanh/webhook) - HTTP hooks that run scripts (Script 1)
- [systemd.path](https://www.freedesktop.org/software/systemd/man/latest/systemd.path.html) - instant trigger on new queue files
- [Cloudflare Turnstile](https://developers.cloudflare.com/turnstile/) - optional bot protection
- [Atomic rename pattern](https://docwiki.gensparks.org/AtomicWrites) - safe spool writes
- Project [runbook.md](./runbook.md) - nginx, Docker, deploy on `116.202.10.106`

---

## Out of scope (this plan)

- Content of Script 2 (issues, email, internal APIs): define in private ops docs.
- Blog CMS or event calendar: separate design; same queue pattern can be reused later if needed.
