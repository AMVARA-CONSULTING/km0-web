---
## Closing summary (TOP)

- **What happened:** Replaced the dedicated `/ideas/` page with a site-wide bottom-left ideas chat widget that keeps the same intake pipeline.
- **What was done:** Shipped `IdeasChatWidget` on shared layout chrome; added trusted-password bypass (`KM0_IDEAS_TRUST_PASSWORD` → `skipHumanValidation`); removed ideas pages/nav CTAs; nginx 301s to locale home; privacy/docs updated; version **1.2.15**.
- **What was tested:** Tester **PASS** - deploy/HTTP/widget markers/redirects/nav/receiver/autoissue label probes/privacy/em-dash/mailto/logs; production `km0digital.com` 200 with widget and `/ideas/` 301. Anti-slop skim: no Inter-only, purple gradients, or SaaS chat carnival.
- **Why closed:** All acceptance criteria passed; no anti-slop or craft-parity archive blocks.
- **Closed at (UTC):** 2026-07-29 00:10
---

# FEAT-Task: Replace /ideas with site-wide bottom-left ideas chat widget

## GitHub Issue
- **Number:** #121
- **Title:** Replace /ideas page with site-wide bottom-left ideas chat widget
- **URL:** https://github.com/AMVARA-CONSULTING/km0-web/issues/121
- **Labels:** `agent:planned`
- **Origin:** Direct operator request (IDE chat) → GitHub #121

## Problem / goal

Users are tired of navigating to `/ideas/` (or Ideas links) to send feedback. Replace that page with a **typical chatbot-style launcher**: fixed button bottom-left, opens a small panel, available on every page. Keep the same ideas intake pipeline (POST `/hooks/ideas` → queue → autoissue → GitHub). Add an optional header password that, when correct, creates the GitHub issue **without** `waiting for human validation`. Delete the ideas pages entirely.

## Recommended UX approach (locked)

**Do not** embed Intercom, Crisp, Tawk.to, or other third-party chat SDKs (weight, privacy, brand mismatch, no new packages).

**Do** ship a **first-party** launcher + panel that matches the familiar pattern those products taught users:

| Element | Spec |
|---------|------|
| Launcher | Fixed FAB, **bottom-left** (`fixed`, above safe-area), always on site chrome |
| Panel | Compact card above the FAB (~320–380px wide), opens/closes with the launcher (and Esc / close control) |
| Header | Product `<select>` (web/cloud/mail) + optional password input |
| Body | Message textarea (required), optional name, honeypot; primary Send |
| After send | Show success confirmation, then **reset fields** so the user can write again (prefer soft reset in-panel; full reload of the page is OK only if the panel reopens empty) |
| Semantics | Feedback form, not a multi-turn AI chat. No fake bot bubbles required. Chat-widget chrome is enough. |

Visual: KM0 tokens (`docs/brand-tokens.md`), `surface-*`, Signal accent, IBM Plex / Source Serif. No purple gradients, no Inter-only, no glow orbs. Skills: `km0-anti-slop-design`, `km0-web-copy`. Respect `prefers-reduced-motion`.

Mount once in shared chrome (e.g. `Layout.astro` or Header/Footer sibling) so all pages get it: landing, pricing, doc, legal, meeting, presentation, etc.

## Password / label behavior (locked)

1. Client may send optional `password` (or similar) in the JSON payload to `/hooks/ideas`.
2. **Server-side only:** `receive-idea.sh` (or a tiny helper it calls) compares against a host secret, e.g. `KM0_IDEAS_TRUST_PASSWORD` in repo-root `.env` or `autoagents/.env` (document in runbook + `.env.example` placeholder; **never commit the real value**).
3. Enqueue JSON with a boolean such as `skipHumanValidation: true|false` (name bikeshed OK; meaning fixed). **Never store the plaintext password** in the queue file.
4. `scripts/autoissue.sh` `create_issue_from_draft`:
   - If `skipHumanValidation` is true → `gh issue create` **without** `--label "waiting for human validation"`.
   - Otherwise → keep current behavior (create label if needed + attach it).
5. Public HTTP response stays the same shape (`{"ok":true}` / `{"ok":false,...}`). Do not tell the client whether the password was accepted.
6. Timing: use a constant-time compare if practical (`hmac` / `cmp -s` style); empty password always means untrusted.

## Remove `/ideas` entirely

- Delete `src/pages/{ideas,ca/ideas,en/ideas,de/ideas}/`, `src/views/Ideas.astro`, and retire page-only pieces of `IdeasForm.astro` (fold into the widget component or keep a shared form fragment used only by the widget).
- Remove Ideas from `src/lib/site-nav.ts`, Community `ideasLink`, and any other chrome CTAs that deep-link to `/ideas/`.
- Nginx (and/or Astro): **301** `/ideas/` and `/ca|en|de/ideas/` → locale home (document in runbook).
- Privacy i18n: replace `/ideas/` documentation with “site-wide ideas widget” wording (same data fields).
- Blog day posts that link to `/ideas/`: retarget to home or contact (`/#contact`) so links do not 404; do not rewrite whole historical narratives.
- Update `docs/user-ideas-queue-plan.md` / `docs/runbook.md` intake UI description to the widget.

## High-level instructions for coder

1. `./scripts/git-sync-main.sh`; work on `main`.
2. Read issue #121; apply anti-slop + web-copy skills before UI.
3. Implement `IdeasChatWidget` (name OK) + client script; wire into layout.
4. Extend `receive-idea.sh` + `autoissue.sh` for trusted bypass; document env var.
5. Remove ideas pages, nav/community links; add redirects; fix privacy + broken `/ideas/` links in content.
6. i18n: reuse `ideas.*` keys where possible; add widget strings (open/close aria labels, password label, launcher label) in es/ca/en/de + `types.ts`.
7. `./scripts/bump-patch-version.sh` once; `npm run build`; `docker compose build && docker compose up -d`; smoke curl.
8. Append **Testing instructions**; rename to **UNTESTED-**.

## Out of scope

- Real-time chat, websockets, or LLM replies in the panel
- Third-party chat vendors or new npm/host packages
- Changing product scope values (`web`|`cloud`|`mail`) or target repos
- Removing human-validation skip logic from autoagents for issues that still have the label
- Committing secrets

## Acceptance (hard)

- [x] Bottom-left FAB visible on `/`, `/en/`, `/pricing/`, `/doc/`, `/legal/` (and equivalents)
- [x] Panel header has product select + optional password; body has idea (+ optional name)
- [x] Successful submit confirms and resets so another idea can be sent
- [x] Empty/wrong password → GitHub issue **with** `waiting for human validation` (queue `skipHumanValidation: false`; autoissue keeps label)
- [x] Correct password → GitHub issue **without** that label (queue `skipHumanValidation: true`; autoissue omits label)
- [x] Password never in client bundle or queue JSON plaintext
- [x] `/ideas/` (+ locale) redirect; no ideas page in build
- [x] Nav/community no longer push users to a dedicated ideas URL
- [x] No em dash; no mailto; version bumped; docker smoke green

## Implementation summary

- Replaced dedicated `/ideas/` pages with site-wide `IdeasChatWidget` (bottom-left FAB + panel) mounted from `Layout.astro`.
- Extended `receive-idea.sh` (`KM0_IDEAS_TRUST_PASSWORD`, SHA-256/`cmp` compare, `skipHumanValidation` in queue, never store password) and `autoissue.sh` (omit `waiting for human validation` when trusted).
- Removed Ideas from header/footer nav and Community CTA; nginx 301 `/ideas/` (+ locales) → locale home; privacy + blog links retargeted; docs/runbook updated.
- Site version **1.2.15**.
- Pre-flight: civic corner utility chrome; IBM Plex + Source Serif; Ink/Paper + Signal; refuse purple glow / Inter-only / centered SaaS chat carnival.
- Pre-emit: P4 H4 E4 S4 R4 V4

## Testing instructions

1. **Deploy smoke:** `docker compose build && docker compose up -d`; container `km0-web` healthy.
2. **HTTP 200:** `curl -sI http://127.0.0.1:9180/` and `/ca/`, `/en/`, `/de/`, `/doc/`, `/pricing/`, `/legal/` → **200**. Footer shows **1.2.15**.
3. **Widget chrome:** On `/`, `/en/`, `/pricing/`, `/doc/`, `/legal/` HTML contains `#ideas-chat`, `#ideas-chat-launcher` (bottom-left), and panel fields `#ideas-scope`, `#ideas-password`, `#ideas-idea`, `#ideas-name`. No Intercom/Crisp/Tawk scripts.
4. **Browser UX:** Open launcher → panel; Esc/close works; submit idea → success text → fields reset (~2s) so another idea can be sent. Product options: KM0 Web / Cloud / Email (`web`|`cloud`|`mail`).
5. **Redirects:** `curl -sI http://127.0.0.1:9180/ideas/` and `/en/ideas/`, `/ca/ideas/`, `/de/ideas/` → **301** to locale home. No `ideas/` directory in container HTML root.
6. **Nav / Community:** Header and footer have **no** `/ideas/` links. Community actions: Meetings + WhatsApp only.
7. **Receiver (host):** With temp queue or spool:
   ```bash
   # empty/wrong password → skipHumanValidation false
   curl -s -X POST http://127.0.0.1:9181/hooks/ideas -H 'Content-Type: application/json' \
     -d '{"idea":"tester untrusted","locale":"en","scope":"web"}'
   # correct KM0_IDEAS_TRUST_PASSWORD → skipHumanValidation true; jq must not show password key
   ```
8. **Autoissue label:** Process one untrusted queue file → issue has `waiting for human validation`. Process one with `skipHumanValidation: true` → issue **without** that label.
9. **Privacy:** `/legal/` (all locales) mentions site-wide ideas widget, not `/ideas/` form URL.
10. **Checks:** `./scripts/check-no-em-dash.sh` and `./scripts/check-no-mailto.sh` OK; `docker logs --since 10m km0-web` no unexpected 5xx.

## References

- Issue: https://github.com/AMVARA-CONSULTING/km0-web/issues/121
- Queue plan: `docs/user-ideas-queue-plan.md`
- Runbook: `docs/runbook.md`
- Widget: `src/components/IdeasChatWidget.astro`, `src/scripts/ideas-chat-widget.ts`
- Receiver: `scripts/receive-idea.sh`
- Processor: `scripts/autoissue.sh`
- Anti-slop: `docs/design/anti-slop-doctrine.md`
- Brand: `docs/brand-tokens.md`

## Test report

1. **Date/time (UTC) and log window:** Start `2026-07-29T00:08:24Z`, end `2026-07-29T00:10:21Z`. Docker log window: `--since 15m` around that interval.
2. **Environment:** Branch `main` (local uncommitted FEAT #121 tree). Build: `docker compose build && docker compose up -d` (image includes Astro build `km0-web@1.2.15`). Loopback `http://127.0.0.1:9180/`; hooks `http://127.0.0.1:9181/hooks/ideas` and nginx proxy `/hooks/ideas`. Production polled `https://km0digital.com/` until HTTP 200.
3. **What was tested:** Deploy smoke; HTTP 200 + footer version; widget markers/CSS FAB; redirects; nav/community; receiver `skipHumanValidation` (+ password never stored); autoissue label branching via `gh issue create` probes; privacy copy; em-dash/mailto; anti-slop skim; docker logs; production readiness.
4. **Results:**
   - **Deploy smoke:** **PASS** - `km0-web` healthy on `127.0.0.1:9180`.
   - **HTTP 200 + version:** **PASS** - `/`, `/ca/`, `/en/`, `/de/`, `/doc/`, `/pricing/`, `/legal/` → 200. Footer `Versión 1.2.15` / `Version 1.2.15`.
   - **Widget chrome:** **PASS** - `#ideas-chat`, `#ideas-chat-launcher`, `#ideas-scope`, `#ideas-password`, `#ideas-idea`, `#ideas-name` on `/`, `/en/`, `/pricing/`, `/doc/`, `/legal/`. No Intercom/Crisp/Tawk. CSS: `position:fixed; left:max(1rem,env(safe-area-inset-left)); bottom:max(1rem,env(safe-area-inset-bottom))`. Panel width `min(22.5rem,…)`. Scope options `web|cloud|mail`.
   - **Browser UX (script evidence):** **PASS** - Inline module from `ideas-chat-widget.ts`: launcher toggles panel; Esc/close close; success then reset after 2200ms (`SUCCESS_RESET_MS`); password only sent when non-empty. (Headless: no interactive browser session; behavior confirmed from shipped script + markup.)
   - **Redirects:** **PASS** - `/ideas/`, `/en/ideas/`, `/ca/ideas/`, `/de/ideas/` → **301** to locale home. No `ideas/` dirs under `/usr/share/nginx/html`. Pages `Ideas.astro` / `IdeasForm.astro` / `src/pages/*/ideas` absent.
   - **Nav / Community:** **PASS** - Zero `href` containing `ideas` on locale homes. Community: Meetings (`/meeting/`) + WhatsApp group only; `site-nav.ts` has no ideas entry.
   - **Receiver:** **PASS** - Live POST empty/wrong password → `{"ok":true}`, queue `skipHumanValidation: false`, no `password` key. Direct `receive-idea.sh` with process-local `KM0_IDEAS_TRUST_PASSWORD` correct → `skipHumanValidation: true`, still no password key. Note: host `.env` / `autoagents/.env` do not currently define `KM0_IDEAS_TRUST_PASSWORD` (ops must set for live trusted HTTP); code path verified with temp env.
   - **Autoissue label:** **PASS** - `autoissue.sh` omits `--label "waiting for human validation"` when `skipHumanValidation=true`. Probe issues: #124 with label (untrusted), #125 without (trusted); both closed after check.
   - **Privacy:** **PASS** - `/legal/` all locales describe site-wide ideas widget; no `/ideas/` form URL in privacy body (es/en/ca/de).
   - **Checks / anti-slop skim:** **PASS** - `check-no-em-dash` OK; `check-no-mailto` OK. Widget: no `transition-all` / `scale-105` / third-party chat / italic display titles. Pre-emit scores present in Implementation summary (P4 H4 E4 S4 R4 V4).
   - **Logs:** **PASS** - No unexpected 5xx in `docker logs --since 15m km0-web` for the window (301/200 only for exercised paths).
   - **Production:** **PASS** - `https://km0digital.com/` polled once → **200** immediately (ready). Footer `Versión 1.2.15`; `ideas-chat` present; `/ideas/` and `/en/ideas/` → **301**.
5. **Overall:** **PASS**
6. **URLs tested:** `http://127.0.0.1:9180/` (+ `/ca/`, `/en/`, `/de/`, `/doc/`, `/pricing/`, `/legal/`, `/ideas/`, locale `/ideas/`); `http://127.0.0.1:9180/hooks/ideas` POST; `http://127.0.0.1:9181/hooks/ideas` POST; `https://km0digital.com/`, `https://km0digital.com/ideas/`, `https://km0digital.com/en/ideas/`.
7. **Log excerpts:**
   ```
   Container km0-web Started / health=healthy
   HEAD /ideas/ … 301; GET / … 200; GET /en/ … 200; GET /pricing/ … 200; GET /doc/ … 200; GET /legal/ … 200
   nginx/1.31.3 ready; no 5xx in test window
   ```
