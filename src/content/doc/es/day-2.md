---
title: "Día 2 — OpenCloud 7, Dex OIDC y backup integral"
description: "Actualización a OpenCloud 7.0.0, broker OIDC Dex con Google y Apple, ajustes Nginx, primer backup integral y documentación operativa."
pubDate: 2026-05-22
locale: es
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducción</p>
  <p class="doc-lead">El día 2 (22 de mayo de 2026) se centra en el <strong>perímetro de autenticación</strong> y en madurar el stack OpenCloud ya desplegado el día anterior: actualización de versión, broker OIDC con Dex (Google y Apple), ajustes de Nginx, primer backup integral y documentación operativa.</p>
  <p class="doc-lead">El despliegue inicial (Debian, Docker, TLS, hostnames separados) quedó cerrado el 21; hoy se trabaja sobre esa base en producción en <a href="https://cloud.km0.amvara.de">cloud.km0.amvara.de</a>.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Estado</p>
  <h2 class="doc-block-heading">Componentes verificados al cierre</h2>
  <ul class="doc-list">
    <li><strong>OpenCloud:</strong> <code>opencloudeu/opencloud-rolling:7.0.0</code> en <code>127.0.0.1:9200</code>.</li>
    <li><strong>Dex (OIDC):</strong> <code>ghcr.io/dexidp/dex:v2.41.1</code> en <code>127.0.0.1:5556</code>.</li>
    <li><strong>Nginx vhost:</strong> <code>/etc/nginx/sites-available/opencloud</code> — TLS → <code>/dex/</code> + <code>/</code>.</li>
    <li><strong>OC_DOMAIN:</strong> <code>cloud.km0.amvara.de</code> con <code>INSECURE=false</code>.</li>
    <li><strong>Emisor Dex:</strong> <code>https://cloud.km0.amvara.de/dex</code> — conectores Google + Apple.</li>
  </ul>
  <p>Comprobaciones habituales: <code>docker compose ps</code>, <code>nginx -t</code> y cabeceras HTTP contra la URL pública del cloud.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Arquitectura</p>
  <h2 class="doc-block-heading">Autenticación + aplicación</h2>
  <div class="doc-note"><pre>Browser ── HTTPS :443 cloud.km0.amvara.de ── Nginx
              ├─ /dex/         → Dex        127.0.0.1:5556
              ├─ /login.html   → /var/www/opencloud-auth/
              └─ /             → OpenCloud  127.0.0.1:9200
                                    └─ volúmenes opencloud_* + dex_dex-data</pre></div>
  <p>La web corporativa en el mismo host sigue en otro virtual host: <a href="https://km0.amvara.de/">km0.amvara.de</a> → contenedor estático en loopback.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Upgrade</p>
  <h2 class="doc-block-heading">OpenCloud 6.2.0 → 7.0.0</h2>
  <ul class="doc-list">
    <li>Se solicitó acercarse a la rama 7.0.1; la imagen <strong>7.0.0</strong> fue la etiqueta aplicada y validada (7.0.1 no se desplegó al no estar disponible o validada).</li>
    <li>Variable <code>OC_DOCKER_TAG=7.0.0</code> en <code>/opt/opencloud/opencloud-compose/.env</code>.</li>
    <li>Corrección en <code>opencloud.yaml</code> runtime: entrada <code>sharing.service_account</code> requerida en OpenCloud 7.x.</li>
    <li>Reinicio controlado: <code>docker compose pull && docker compose up -d</code>.</li>
    <li>Revisión de logs en niveles <code>fatal</code>/<code>error</code>; servicio dejado en marcha.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">OIDC</p>
  <h2 class="doc-block-heading">Multi-proveedor con Dex (Google + Apple)</h2>
  <p class="doc-block-intro">Se descartó el experimento ad hoc con Keycloak (plantillas nginx bajo <code>keycloak*.conf</code> no habilitadas) en favor de un broker Dex ligero en <code>/opt/opencloud/dex/</code>:</p>
  <ul class="doc-list">
    <li><strong>docker-compose.yml:</strong> servicio Dex, volumen <code>dex_dex-data</code>, publicación solo en loopback :5556.</li>
    <li><strong>config.yaml:</strong> emisor, SQLite, clientes OAuth2, conectores.</li>
    <li><strong>web/themes/km0/:</strong> UI de login con marca KM0 (logo, CSS, i18n CA/ES/EN).</li>
    <li><strong>setup-apple.sh:</strong> genera JWT de cliente Apple (~180 días).</li>
  </ul>
  <p>OpenCloud queda con emisor externo (<code>OC_OIDC_ISSUER</code> → <code>/dex</code>, cliente <code>opencloud-web</code>). <code>alwaysShowLoginScreen: true</code> fuerza el selector Google vs Apple.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Entradas públicas</p>
  <h2 class="doc-block-heading">URLs de acceso</h2>
  <ul class="doc-list">
    <li><strong><a href="https://cloud.km0.amvara.de/">cloud.km0.amvara.de/</a>:</strong> interfaz web OpenCloud.</li>
    <li><strong><a href="https://cloud.km0.amvara.de/dex/">/dex/</a>:</strong> emisor OIDC / login Dex.</li>
    <li><strong><a href="https://cloud.km0.amvara.de/login.html">/login.html</a>:</strong> selector estático Google / Apple.</li>
  </ul>
  <div class="doc-note">Redirect URI en Google Cloud Console: <code>https://cloud.km0.amvara.de/dex/callback</code>. Credenciales Apple bajo <code>/opt/</code> — sin detallar secretos aquí.</div>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Nginx</p>
  <h2 class="doc-block-heading">Integración en el vhost OpenCloud</h2>
  <ul class="doc-list">
    <li><strong>location /dex/:</strong> → <code>http://127.0.0.1:5556/dex/</code> con cabeceras reenviadas para OIDC.</li>
    <li><strong>location = /login.html:</strong> fichero estático en <code>/var/www/opencloud-auth/login.html</code>.</li>
    <li><strong>location /:</strong> OpenCloud en :9200 manteniendo SSE, TUS y WebSockets del día 1.</li>
  </ul>
  <p>Con <code>INSECURE=false</code> y FQDN estable, el stack abandona el modo laboratorio relajado.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Compose</p>
  <h2 class="doc-block-heading">Resolución DNS en contenedor</h2>
  <p class="doc-block-intro">En <code>external-proxy/opencloud.yml</code> se añadió <code>extra_hosts: ${OC_DOMAIN}:host-gateway</code> para que el contenedor resuelva el hostname público como el host. Sin ello pueden aparecer fallos de login tras OAuth de Google (<code>access-denied</code> o sesiones incoherentes).</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Backup</p>
  <h2 class="doc-block-heading">Primera copia integral de la instalación</h2>
  <p class="doc-block-intro">Script: <code>/opt/opencloud/scripts/backup-opencloud-installation.sh</code>. Primera ejecución: 2026-05-22 19:51 → <code>/opt/backup_opencloud_installation/20260522-195106/</code> con enlace <code>latest</code>.</p>
  <ul class="doc-list">
    <li><strong>opt-opencloud/:</strong> árbol completo <code>/opt/opencloud/</code>.</li>
    <li><strong>host-nginx/:</strong> vhost activo + plantillas del repo.</li>
    <li><strong>letsencrypt/:</strong> TLS del hostname del cloud.</li>
    <li><strong>docker-volumes/:</strong> tarballs <code>opencloud-data</code>, <code>opencloud-config</code>, <code>dex-data</code>.</li>
    <li><strong>manifest/:</strong> snapshot de runtime y log del backup.</li>
  </ul>
  <div class="doc-note">No incluye el vhost de la web corporativa km0 ni otros stacks ajenos a OpenCloud.</div>
</section>

<section class="doc-block">
  <p class="doc-block-title">Incidencias</p>
  <h2 class="doc-block-heading">Síntomas y remedios documentados</h2>
  <ul class="doc-list">
    <li><strong>GET .../photo/$value 404:</strong> sin avatar subido — ruido benigno en consola.</li>
    <li><strong>502 en URLs antiguas /signin/:</strong> sesión obsoleta antes del corte Dex — limpiar datos del sitio o ventana privada.</li>
    <li><strong>access-denied tras login Google:</strong> lista blanca en <code>role_assignment</code> o DNS — usar <code>driver: default</code> o <code>extra_hosts</code>.</li>
    <li><strong>Dex en bucle de reinicio:</strong> revisar <code>docker logs</code>; validar JSON de proveedores en <code>/opt/</code>.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Investigación</p>
  <h2 class="doc-block-heading">Sin despliegue hoy</h2>
  <ul class="doc-list">
    <li><strong>Collabora / WOPI:</strong> revisión de edición Office en navegador — mantener solo core; posible addon futuro.</li>
    <li><strong>Apache HTTP Server:</strong> confirmado que no se usa (solo Nginx). Apache Tika en docs upstream no desplegado.</li>
    <li><strong>Branding OpenCloud Web:</strong> overlay KM0 revertido el 21 de mayo; branding KM0 en login Dex se mantiene.</li>
  </ul>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Pendientes</p>
  <h2 class="doc-block-heading">Siguientes pasos</h2>
  <p class="doc-closing">Valorar OpenCloud 7.0.1 cuando la imagen esté validada, completar Apple Sign In si falta, instalar cron para el backup integral y revisar rotación del acceso administrativo. Explora los <a href="/#servicios">servicios</a> o <a href="/#contacto">escríbenos</a> para colaborar.</p>
</section>
