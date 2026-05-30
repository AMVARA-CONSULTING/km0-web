---
title: "Dia 3 — Repos Git, dominis km0digital.com i bucle autoagents"
description: "Repositori Git d'OpenCloud, migració a km0digital.com, FAQ multilingüe, navegació mòbil, switchLocaleHref i bucle autoagents en ambdós repos."
pubDate: 2026-05-26
locale: ca
---

<div class="doc-lead-block">
  <p class="doc-block-title">Introducció</p>
  <p class="doc-lead">El dia 3 (finestra operativa del 26 al 27 de maig de 2026, ~12 h al VPS Debian) consolida dos fronts que conviuen al mateix host: OpenCloud passa a tenir un repositori Git propi amb desplegament versionat i pla de tall a <code>cloud.km0digital.com</code>, i la web corporativa migra de <code>km0.amvara.de</code> a <a href="https://km0digital.com/">km0digital.com</a> amb millores de producte.</p>
  <p class="doc-lead">En ambdós repos s'introdueix el mateix bucle autoagents (GitHub Issues → tasques → <code>cursor-agent</code>) i, a OpenCloud, notes de tancament automàtiques a Redmine en arxivar tasques.</p>
</div>

<div class="doc-block">
  <p class="doc-block-title">Resum</p>
  <h2 class="doc-block-heading">Fites del dia</h2>
  <ul class="doc-list">
    <li><strong>OpenCloud:</strong> primer commit Git d'actius KM0 (<code>km0-opencloud</code>); alineació de plantilles a <code>cloud.km0digital.com</code>; bucle autoagents; <code>redmine_sync.py</code> en arxivar <code>CLOSED-*</code>.</li>
    <li><strong>Web corporativa:</strong> migració a km0digital.com; slugs de blog <code>day-*</code>; FAQ multilingüe; peu amb semver; modal email «properament»; menú hamburguesa mòbil; <code>switchLocaleHref</code>; versió 1.1.4.</li>
    <li><strong>Compartit:</strong> regles Cursor, <code>autoagents/SKILL.md</code>, <code>scripts/git-sync-main.sh</code>, <code>docs/agent-loop.md</code>.</li>
  </ul>
</div>

<div class="doc-block doc-block-alt">
  <p class="doc-block-title">Arquitectura</p>
  <h2 class="doc-block-heading">Coexistència en un sol host</h2>
  <div class="doc-note"><pre>Internet :443
    ├── km0digital.com          → nginx km0       → 127.0.0.1:9180  (km0-web Docker)
    └── cloud.km0digital.com    → nginx opencloud → 127.0.0.1:9200  (OpenCloud external-proxy)
                                      └── /dex/*  → 127.0.0.1:5556  (Dex OIDC)</pre></div>
  <ul class="doc-list">
    <li><strong>Marketing:</strong> <a href="https://km0digital.com/">km0digital.com</a> — <code>/opt/km0-web</code>.</li>
    <li><strong>OpenCloud:</strong> <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a> — <code>/opt/opencloud</code>.</li>
    <li><strong>Llegat:</strong> <code>km0.amvara.de</code> → redirecció 301 a l'apex.</li>
  </ul>
</div>

<div class="doc-block">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Repositori Git (km0-opencloud)</h2>
  <p class="doc-block-intro">Commit inicial (<code>f454889</code>, 26-maig 21:13 CEST) a <code>git@github.com:AMVARA-CONSULTING/km0-opencloud.git</code>, branca <code>main</code>. Va quedar versionat (63 fitxers), entre d'altres:</p>
  <ul class="doc-list">
    <li><code>overrides/opencloud-compose/</code> — CSP, overlay external-proxy, pedaç OIDC.</li>
    <li><code>dex/</code> — compose Dex, tema KM0, plantilles de login.</li>
    <li><code>nginx/</code> — plantilla vhost per a <code>cloud.km0digital.com</code>.</li>
    <li><code>host-www/opencloud-auth/</code> — login híbrid (<code>login.html</code>, JSON d'auth).</li>
    <li><code>scripts/</code> — còpies de seguretat, <code>apply-opencloud-compose-overrides.sh</code>.</li>
    <li><code>docs/</code> — runbook, resum Redmine.</li>
  </ul>
  <div class="doc-note">Fora de Git (només al servidor): clon upstream <code>opencloud-compose/</code>, <code>.env</code> vius, secrets OAuth, volums Docker i <code>/etc/letsencrypt/</code>.</div>
</div>

<div class="doc-block doc-block-alt">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Migració de domini i autoagents</h2>
  <p class="doc-block-intro">Commit <code>0b27952</code> (27-maig 00:06 CEST): alineació de <code>OC_DOMAIN</code>, emissor Dex, <code>server_name</code> nginx i plantilles a <code>cloud.km0digital.com</code>. Nou script <code>scripts/issue-cloud-km0digital-cert.sh</code> (comprovació DNS + Certbot webroot).</p>
  <p>S'afegeix el bucle autoagents (versió <code>1.0.2</code>): orquestrador <code>autoagents-loop.sh</code>, agents coder/tester/closer/committer, <code>gh_issue_sync.py</code> i <code>move-agent-task-to-done.sh</code>. Commit <code>7203b6f</code> (00:37 CEST): <code>redmine_sync.py</code> publica a Redmine un resum Textile en arxivar tasques <code>CLOSED-*</code>.</p>
</div>

<div class="doc-block">
  <p class="doc-block-title">Web corporativa</p>
  <h2 class="doc-block-heading">Contingut, hostname i producte</h2>
  <ul class="doc-list">
    <li><strong>Slugs de blog:</strong> <code>dia-*</code> → <code>day-*</code> en tots els locales (<code>src/content/doc/{ca,de,en,es}/</code>).</li>
    <li><strong>Migració hostname</strong> (<code>bdc9e2c</code>, 23:42 CEST): URLs principals <code>https://km0digital.com</code> (CA a <code>/ca/</code>), blog a <code>/doc/</code>; redirecció 301 des de <code>km0.amvara.de</code>.</li>
    <li><strong>FAQ</strong> (<code>23ec0bf</code>): secció multilingüe amb àncora <code>#faq</code>; peu amb semver des de <code>package.json</code>; modal «properament» per al servei d'email.</li>
    <li><strong>Navegació</strong> (<code>e5cfa57</code>, 1.1.3): menú hamburguesa a <code>Header.astro</code>; <code>switchLocaleHref</code> / <code>stripLocalePrefix</code> a <code>src/i18n/paths.ts</code> per canviar idioma sense perdre entrada de blog ni hash.</li>
    <li><strong>Documentació</strong> (<code>67b62cc</code>, 1.1.4): README simplificat; tasca de fum <code>CLOSED-4</code> va validar el pipeline (loopback + producció HTTP 200).</li>
  </ul>
</div>

<div class="doc-block doc-block-alt">
  <p class="doc-block-title">Autoagents</p>
  <h2 class="doc-block-heading">Tasques tancades (km0-web)</h2>
  <ul class="doc-list">
    <li><strong>FAQ</strong> (GitHub #1): secció FAQ, 4 locales.</li>
    <li><strong>Idioma</strong> (GitHub #2): <code>switchLocaleHref</code>.</li>
    <li><strong>Menú mòbil</strong> (GitHub #3): navegació hamburguesa.</li>
    <li><strong>Fum</strong> (test): bucle autoagents — PASS a :9180 i producció.</li>
  </ul>
  <p>Progressió de versió del lloc: baseline Astro 5 a :9180 → 1.1.3 (FAQ, peu semver, modal, nav mòbil, locale) → 1.1.4 (README/docs).</p>
</div>

<div class="doc-block">
  <p class="doc-block-title">Verificació</p>
  <h2 class="doc-block-heading">Comprovacions de referència</h2>
  <div class="doc-note"><pre>cd /opt/km0-web
docker compose build && docker compose up -d
curl -sI https://km0digital.com/
curl -sI http://127.0.0.1:9180/ca/doc/day-0/

cd /opt/opencloud
docker compose -f opencloud-compose/docker-compose.yml ps
curl -sI https://cloud.km0digital.com/login.html</pre></div>
  <div class="doc-note">Els secrets (<code>.env</code>, claus Redmine/GitHub, OAuth) no formen part d'aquesta entrada; viuen només al servidor i a la documentació operativa privada de l'equip.</div>
</div>

<div class="doc-closing-block">
  <p class="doc-block-title">Següent pas</p>
  <h2 class="doc-block-heading">Dia 4</h2>
  <p class="doc-closing">El <strong>dia 4</strong> substitueix l'emmagatzematge estàtic de contrasenyes de Dex per un connector LDAP contra l'IDM d'OpenCloud, de manera que qualsevol usuari del directori pugui iniciar sessió amb les mateixes credencials que a Configuració. Mentrestant, explora els <a href="/ca/#services">serveis</a> o el <a href="/ca/doc/day-4/">relat del dia 4</a>.</p>
</div>
