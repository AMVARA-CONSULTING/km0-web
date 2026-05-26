
h1. Kilometer 0 Digital — executive summary (Redmine)

h2. Purpose

Document the public marketing site for *Kilometer 0 Digital* (localised as *Kilòmetre* / *Kilómetro*, depending on language), deployed on the production server: architecture, technology stack, i18n, coexistence with OpenCloud on the same host, Git access and delivery history.

---

h2. URLs

|_.Service|_.URL|_.Site path|
| Spanish production (default) | "https://km0digital.com":https://km0digital.com | Root @/@ |
| Catalan | "https://km0digital.com/ca/":https://km0digital.com/ca/ | @/ca/@ |
| English | "https://km0digital.com/en/":https://km0digital.com/en/ | @/en/@ |
| OpenCloud (same host, separate stack) | "https://cloud.km0digital.com":https://cloud.km0digital.com | Not part of the @km0-web@ repo |

> Marketing uses @km0digital.com@; OpenCloud is served under @cloud.km0digital.com@ once DNS/TLS are in place—the host vhost should proxy to @127.0.0.1:9200@.

---

h2. HTTPS traffic flow

<pre><code>
Internet  --443-->  Host nginx (TLS, km0digital.com)
                           |
                           +--9180-->  Docker km0-web (nginx Alpine, Astro /dist static)
Internet  --443-->  Other vhosts OpenCloud localhost:9200
</code></pre>

* @km0-web@ listens on *_localhost only_* @127.0.0.1:9180@—not exposed on @0.0.0.0@.
* Typical firewall policy: SSH @22@, HTTP @80@/HTTPS @443@.

---

h2. km0-web stack

|_.Layer|_.Technology|_.Notes|
| UI | Astro 5 + Tailwind 3 | Static output; @build.format@ @directory@
| i18n | JSON under @src/i18n/@ + Astro built-in routing | Default @_es_@; @_ca_@, @_en_@
| Runtime serving | nginx (container) | gzip, asset cache hints, Dockerfile healthcheck
| Build stage | Node 22 Alpine multi-stage | @npm ci@ + @astro build@
| Container name | @km0-web@ | @restart:@ @unless-stopped@
| SEO sitemap | @astrojs/sitemap@ npm package | hreflang alternates (@es@, @ca@, @en@) in @astro.config.mjs@
| Typography | Google Fonts Inter | Loaded from @src/layouts/Layout.astro@

---

h2. Project layout on the server

*h3. Base path*

<pre><code class="shell">
/opt/km0-web
</code></pre>

*h3. Important directories*

* @src/pages/@ — Locale entry pages (@/@ , @/ca/@ , @/en/@ wrappers)
* @src/views/Landing.astro@ — Single shared landing implementation
* @src/components/@ — Section partials (Hero, Values, etc.)
* @src/layouts/@ — Wrapper: @lang@, canonical, og:*, alternates hreflang
* @src/i18n/@ — @es.json@, @ca.json@, @en.json@, helpers (@paths.ts@, types)
* @nginx/container.conf@ — nginx inside Docker image
* @nginx/sites-available/km0@ — Example host reverse-proxy snippet (tracked in repo)
* @docs/runbook.md@ — Operations and troubleshooting guide
* @docker-compose.yml@ — Publishes @127.0.0.1:9180->80@

*h3. Git*

|_.Field|_.Value|
| Remote | git@github.com:AMVARA-CONSULTING/km0-web.git |
| Default branch | @main@ (tracks @origin/main@) |
| Clone (SSH) | See block below |

<pre><code class="shell">
git clone git@github.com:AMVARA-CONSULTING/km0-web.git
</code></pre>

"GitHub repo (browser)":"https://github.com/AMVARA-CONSULTING/km0-web"

*h3. Common commands*

<pre><code class="shell">
cd /opt/km0-web
git status
git fetch origin && git merge origin/main
docker compose build && docker compose up -d
</code></pre>

---

h2. Delivery summary (high level)

* Astro + Tailwind static marketing landing; brand gradients, light scroll-motion via IntersectionObserver.
* Dockerised build with Alpine nginx runtime behind host nginx/TLS.
* Split hostnames so marketing stays on @km0digital.com@ while OpenCloud uses @cloud.km0digital.com@.
* Logo assets iterated (including transparent PNG workflow for the web UI).
* Full i18n: Catalan / Spanish (default at @/@) / English; header locale switch CA | ES | EN.
* Repo documentation updated (@README.md@, @docs/runbook.md@, @docs/brand-tokens.md@) and this *.red* export for Redmine/Textile.

---

h2. Content and translation workflow

# Edit @src/i18n/es.json@, @ca.json@, and @en.json@ keeping the same key schema
# Optionally edit Astro components or @Landing.astro@
# Rebuild/restart: @docker compose build && docker compose up -d@
# Sanity-check via curl:

<pre><code class="shell">
curl -sI http://127.0.0.1:9180/ http://127.0.0.1:9180/ca/ http://127.0.0.1:9180/en/
</code></pre>

---

h2. Dependencies and security (2026-05-26)

* Direct dependencies in @package.json@ are *pinned* to exact versions (no @^@, @~@, or @>@ ranges).
* @package-lock.json@ is versioned in Git; the Docker build stage runs @npm ci@ for reproducible installs.
* Audit date: *26 May 2026* (@npm audit@ in Node 22 Alpine).

|_.Package|_.Pinned version|_.Notes|
| @astrojs/sitemap@ | 3.7.3 | hreflang sitemap integration |
| @astrojs/tailwind@ | 6.0.2 | Tailwind integration |
| @astro@ | 5.18.2 | Latest 5.x line; includes fix for CVE-2026-33769 (remotePatterns allowlist bypass, relevant to SSR/image endpoints) |
| @tailwindcss@ | 3.4.19 | CSS framework |

*npm audit* reported *2 advisories* on @astro@ still open in the npm advisory DB for the 5.x line (fix tagged for Astro @>=6.1.6@ / @>=6.1.10@):
** *Moderate* — XSS in @define:vars@ via incomplete @</script>@ sanitization (GHSA-j687-52p2-xcff).
** *Low* — Server island encrypted parameters replay (GHSA-xr5h-phrj-8vxv).
* This site uses @output: 'static'@ only; it does not use @define:vars@ or server islands. Production exposure for those two items is assessed as *low*. Resolving them without a major bump would require migrating to Astro 6 when the team accepts that upgrade.
* CVE-2025-64757 (dev-server local file read via image endpoint) is patched from Astro 5.14.3 onward — covered by @5.18.2@; affects @astro dev@ only, not the nginx static container.

---

h2. Risks / follow-ups

* Keep @certbot.timer@ renewal healthy on the host for @km0digital.com@.
* Re-run @npm audit@ periodically; bump pinned versions deliberately (edit @package.json@, regenerate lockfile, rebuild image).
* Regression on Spanish default landing: verify Astro @i18n.defaultLocale@ and @prefixDefaultLocale@.
* Host nginx lives outside Git—always @nginx -t@ then @systemctl reload nginx@ after edits under @/etc/nginx/sites-available/@.

---

h2. Related documents in repo

* "README":"README.md"
* "Operational runbook":"docs/runbook.md"

---

This file — @docs/km0-web-resumen-proyecto.red@ — uses *Textile* syntax suitable for Redmine wikis (no Markdown triple-backtick fences). Copy/paste into a wiki page or attach as OPS documentation.
