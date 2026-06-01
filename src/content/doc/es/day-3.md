---
title: "Día 3 - Repos Git, dominios km0digital.com y bucle autoagents"
description: "Repositorio Git de OpenCloud, migración a km0digital.com, FAQ multidioma, navegación móvil, switchLocaleHref y bucle autoagents en ambos repos."
pubDate: 2026-05-26
locale: es
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducción</p>
  <p class="doc-lead">El día 3 (ventana operativa del 26 al 27 de mayo de 2026, ~12 h en el VPS Debian) consolida dos frentes que conviven en el mismo host: OpenCloud pasa a tener un repositorio Git propio con despliegue versionado y plan de corte a <code>cloud.km0digital.com</code>, y la web corporativa migra de <code>km0.amvara.de</code> a <a href="https://km0digital.com/">km0digital.com</a> con mejoras de producto.</p>
  <p class="doc-lead">En ambos repos se introduce el mismo bucle autoagents (GitHub Issues → tareas → <code>cursor-agent</code>) y, en OpenCloud, notas de cierre automáticas en Redmine al archivar tareas.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Resumen</p>
  <h2 class="doc-block-heading">Hitos del día</h2>
  <ul class="doc-list">
    <li><strong>OpenCloud:</strong> primer commit Git de activos KM0 (<code>km0-opencloud</code>); alineación de plantillas a <code>cloud.km0digital.com</code>; Collabora Online vía WOPI; bucle autoagents; <code>redmine_sync.py</code> al archivar <code>CLOSED-*</code>.</li>
    <li><strong>Web corporativa:</strong> migración a km0digital.com; slugs de blog <code>day-*</code>; FAQ multidioma; pie con semver; modal email «próximamente»; menú hamburguesa móvil; <code>switchLocaleHref</code>; versión 1.1.4.</li>
    <li><strong>Compartido:</strong> reglas Cursor, <code>autoagents/SKILL.md</code>, <code>scripts/git-sync-main.sh</code>, <code>docs/agent-loop.md</code>.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Arquitectura</p>
  <h2 class="doc-block-heading">Coexistencia en un solo host</h2>
  <div class="doc-note"><pre>Internet :443
    ├── km0digital.com          → nginx km0       → 127.0.0.1:9180  (km0-web Docker)
    └── cloud.km0digital.com    → nginx opencloud → 127.0.0.1:9200  (OpenCloud external-proxy)
                                      └── /dex/*  → 127.0.0.1:5556  (Dex OIDC)</pre></div>
  <ul class="doc-list">
    <li><strong>Marketing:</strong> <a href="https://km0digital.com/">km0digital.com</a>, <code>/opt/km0-web</code>.</li>
    <li><strong>OpenCloud:</strong> <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a>, <code>/opt/opencloud</code>.</li>
    <li><strong>Legado:</strong> <code>km0.amvara.de</code> → redirección 301 al apex.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Repositorio Git (km0-opencloud)</h2>
  <p class="doc-block-intro">Commit inicial (<code>f454889</code>, 26-may 21:13 CEST) en <code>git@github.com:AMVARA-CONSULTING/km0-opencloud.git</code>, rama <code>main</code>. Quedó versionado (63 ficheros), entre otros:</p>
  <ul class="doc-list">
    <li><code>overrides/opencloud-compose/</code> - CSP, overlay external-proxy, parche OIDC.</li>
    <li><code>dex/</code> - compose Dex, tema KM0, plantillas de login.</li>
    <li><code>nginx/</code> - plantilla vhost para <code>cloud.km0digital.com</code>.</li>
    <li><code>host-www/opencloud-auth/</code> - login híbrido (<code>login.html</code>, JSON de auth).</li>
    <li><code>scripts/</code> - backups, <code>apply-opencloud-compose-overrides.sh</code>.</li>
    <li><code>docs/</code> - runbook, resumen Redmine.</li>
  </ul>
  <div class="doc-note">Fuera de Git (solo en servidor): clon upstream <code>opencloud-compose/</code>, <code>.env</code> vivos, secretos OAuth, volúmenes Docker y <code>/etc/letsencrypt/</code>.</div>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Migración de dominio y autoagents</h2>
  <p class="doc-block-intro">Commit <code>0b27952</code> (27-may 00:06 CEST): alineación de <code>OC_DOMAIN</code>, emisor Dex, <code>server_name</code> nginx y plantillas a <code>cloud.km0digital.com</code>. Nuevo script <code>scripts/issue-cloud-km0digital-cert.sh</code> (comprobación DNS + Certbot webroot).</p>
  <p>Se añade el bucle autoagents (versión <code>1.0.2</code>): orquestador <code>autoagents-loop.sh</code>, agentes coder/tester/closer/committer, <code>gh_issue_sync.py</code> y <code>move-agent-task-to-done.sh</code>. Commit <code>7203b6f</code> (00:37 CEST): <code>redmine_sync.py</code> publica en Redmine un resumen Textile al archivar tareas <code>CLOSED-*</code>.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Collabora Online (WOPI)</h2>
  <p class="doc-block-intro">El día 2 mantuvo el stack solo con core; durante el día 3 se conectó <strong>Collabora Online</strong> a OpenCloud mediante WOPI para abrir y editar documentos Office en el navegador en <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a>.</p>
  <ul class="doc-list">
    <li><strong>Edición en navegador:</strong> gracias a Collabora, los usuarios pueden editar ficheros Office como <code>XLSX</code>, <code>PPT</code> y <code>DOCX</code> sin aplicaciones de escritorio.</li>
    <li><strong>Coedición simultánea:</strong> varios usuarios pueden trabajar en el mismo documento a la vez; los cambios se sincronizan en tiempo real a través del puente WOPI.</li>
    <li><strong>Stack:</strong> contenedor Collabora en la red Compose de OpenCloud; descubrimiento WOPI y actualizaciones CSP en el overlay external-proxy; Nginx enruta el editor bajo el vhost cloud.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Web corporativa</p>
  <h2 class="doc-block-heading">Contenido, hostname y producto</h2>
  <ul class="doc-list">
    <li><strong>Slugs de blog:</strong> <code>dia-*</code> → <code>day-*</code> en todos los locales (<code>src/content/doc/{ca,de,en,es}/</code>).</li>
    <li><strong>Migración hostname</strong> (<code>bdc9e2c</code>, 23:42 CEST): URLs principales <code>https://km0digital.com</code> (ES en <code>/</code>), <code>/ca/</code>, <code>/en/</code>, <code>/de/</code>, blog en <code>/doc/</code>; redirección 301 desde <code>km0.amvara.de</code>.</li>
    <li><strong>FAQ</strong> (<code>23ec0bf</code>): sección multidioma con ancla <code>#faq</code>; pie con semver desde <code>package.json</code>; modal «próximamente» para el servicio de email.</li>
    <li><strong>Navegación</strong> (<code>e5cfa57</code>, 1.1.3): menú hamburguesa en <code>Header.astro</code>; <code>switchLocaleHref</code> / <code>stripLocalePrefix</code> en <code>src/i18n/paths.ts</code> para cambiar idioma sin perder entrada de blog ni hash.</li>
    <li><strong>Documentación</strong> (<code>67b62cc</code>, 1.1.4): README simplificado; tarea de humo <code>CLOSED-4</code> validó el pipeline (loopback + producción HTTP 200).</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Autoagents</p>
  <h2 class="doc-block-heading">Tareas cerradas (km0-web)</h2>
  <ul class="doc-list">
    <li><strong>FAQ</strong> (GitHub #1): sección FAQ, 4 locales.</li>
    <li><strong>Idioma</strong> (GitHub #2): <code>switchLocaleHref</code>.</li>
    <li><strong>Menú móvil</strong> (GitHub #3): navegación hamburguesa.</li>
    <li><strong>Humo</strong> (test): bucle autoagents - PASS en :9180 y producción.</li>
  </ul>
  <p>Progresión de versión del sitio: baseline Astro 5 en :9180 → 1.1.3 (FAQ, pie semver, modal, nav móvil, locale) → 1.1.4 (README/docs).</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Verificación</p>
  <h2 class="doc-block-heading">Comprobaciones de referencia</h2>
  <div class="doc-note"><pre>cd /opt/km0-web
docker compose build && docker compose up -d
curl -sI https://km0digital.com/
curl -sI http://127.0.0.1:9180/en/doc/day-0/

cd /opt/opencloud
docker compose -f opencloud-compose/docker-compose.yml ps
curl -sI https://cloud.km0digital.com/login.html</pre></div>
  <div class="doc-note">Los secretos (<code>.env</code>, claves Redmine/GitHub, OAuth) no forman parte de esta entrada; viven solo en el servidor y en la documentación operativa privada del equipo.</div>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Siguiente paso</p>
  <h2 class="doc-block-heading">Día 4</h2>
  <p class="doc-closing">El <strong>día 4</strong> sustituye el almacén estático de contraseñas de Dex por un conector LDAP contra el IDM de OpenCloud, de modo que cualquier usuario del directorio pueda iniciar sesión con las mismas credenciales que en Ajustes. Mientras tanto, explora los <a href="/#services">servicios</a> o el <a href="/doc/day-4/">relato del día 4</a>.</p>
</section>
