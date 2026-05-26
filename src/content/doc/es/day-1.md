---
title: "Día 1 — OpenCloud, proxy y web del proyecto"
description: "OpenCloud en Docker Compose, Nginx con TLS en loopback, Fail2ban, subdominio cloud y la landing Astro KM0 publicada como segundo backend."
pubDate: 2026-05-21
locale: es
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducción</p>
  <p class="doc-lead">El día 1 convierte la base Debian en una plataforma completa: <strong>OpenCloud</strong> sobre Docker Compose con overlays oficiales, Nginx terminando TLS y encaminando solo al loopback, políticas de firewall coherentes y la landing Astro del proyecto publicada como segundo backend detrás del mismo frontal.</p>
  <p class="doc-lead">También se introducen mejoras posteriores al primer corte — Fail2ban y el subdominio dedicado del cloud — porque forman parte del relato operativo real del despliegue.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Core sin Collabora/WOPI</h2>
  <p class="doc-block-intro">El modo elegido arranca OpenCloud como servicio único desde la composición oficial (<code>opencloud-eu/opencloud-compose</code>), usando una imagen rodante etiquetada (<code>opencloud-rolling</code> con tag fijado en despliegue) para poder actualizar de forma deliberada (<code>docker compose pull</code> + ventana de mantenimiento).</p>
  <ul class="doc-list">
    <li><strong>Overlay external-proxy:</strong> adapta variables como <code>PROXY_HTTP_ADDR</code> para escuchar dentro del contenedor y publicar el puerto HTTP del proxy solo como <code>127.0.0.1:&lt;puerto&gt;</code> en el host.</li>
    <li><strong>COMPOSE_PROJECT_NAME=opencloud:</strong> ancla los nombres de volumen Docker sin depender del cwd.</li>
    <li><strong>Fichero .env:</strong> fuente única de variables de despliegue; permisos estrictos en disco y fuera del control de versiones.</li>
    <li><strong>COMPOSE_FILE:</strong> lista los overlays necesarios (base más overlay de proxy externo).</li>
  </ul>
  <p>Dentro del contenedor coexisten microservicios que conversan por gRPC/HTTP en localhost interno; ese rango no se expone directamente al host salvo por los endpoints previstos por el chart upstream.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Arquitectura</p>
  <h2 class="doc-block-heading">OpenCloud tras el proxy</h2>
  <div class="doc-note"><pre>Browser
   │  HTTPS :443
   ▼
Nginx (Debian, site dedicado OpenCloud)
   │  HTTP http://127.0.0.1:9200  (solo loopback)
   ▼
Contenedor OpenCloud (UID/GID fijo)
   │  microservicios internos ~9140–9300
   ▼
Volúmenes Docker:
   • opencloud-data   → ficheros, índices, NATS, IDM...
   • opencloud-config → opencloud.yaml, CSP, políticas...</pre></div>
  <p><code>PROXY_TLS=false</code> indica que la terminación TLS ocurre fuera del contenedor (en Nginx). OpenCloud genera URLs coherentes cuando recibe cabeceras <code>X-Forwarded-*</code> correctas.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Puertos</p>
  <h2 class="doc-block-heading">Mapa de superficie expuesta</h2>
  <ul class="doc-list">
    <li><strong>22 (sshd):</strong> administración SSH — Internet según política.</li>
    <li><strong>80/443 (Nginx):</strong> HTTP/S público — redirección ACME y virtual hosts KM0 + OpenCloud.</li>
    <li><strong>9200 (Docker → OpenCloud):</strong> solo <code>127.0.0.1</code> — backend HTTP que ve Nginx.</li>
    <li><strong>9140–9300:</strong> microservicios internos del contenedor — no publicados en el host.</li>
  </ul>
  <div class="doc-note">UFW refuerza la política permitiendo desde Internet solo lo necesario. Si no debe conocerlo el navegador externo, no escucha en todas las interfaces.</div>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Nginx</p>
  <h2 class="doc-block-heading">Directivas clave hacia OpenCloud</h2>
  <ul class="doc-list">
    <li><strong>proxy_buffering off:</strong> SSE para actualizaciones en tiempo real del cliente web.</li>
    <li><strong>proxy_request_buffering off:</strong> subidas resumibles TUS sin bufferizar todo el cuerpo.</li>
    <li><strong>proxy_pass http://127.0.0.1:9200:</strong> TLS ya resuelto en el borde.</li>
    <li><strong>X-Forwarded-Proto $scheme:</strong> redirects y cookies coherentes para HTTPS.</li>
    <li><strong>Upgrade/Connection passthrough:</strong> WebSockets para el UI interactivo.</li>
    <li><strong>Timeouts 3600s y client_max_body_size 10G:</strong> sesiones largas y ficheros grandes.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Despliegue</p>
  <h2 class="doc-block-heading">Árbol en /opt/opencloud</h2>
  <div class="doc-note"><pre>/opt/opencloud/
├── opencloud-compose/     # clon upstream + overlays
│   ├── docker-compose.yml
│   ├── external-proxy/opencloud.yml
│   └── .env                 # activo — fuera de git, chmod 600
├── nginx/                   # plantillas TLS + proxy
├── scripts/backup-volumes.sh
└── docs/runbook.md</pre></div>
  <p>Los snippets en repo sirven como referencia; los ficheros activos bajo <code>/etc/nginx/sites-available/</code> deben revisarse siempre con <code>nginx -t</code> antes de <code>systemctl reload nginx</code>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Datos</p>
  <h2 class="doc-block-heading">Volúmenes Docker y persistencia</h2>
  <p class="doc-block-intro">OpenCloud centraliza persistencia en dos volúmenes nombrados. El contenido relevante incluye:</p>
  <ul class="doc-list">
    <li><strong>idm/ e idp/:</strong> directorio LDAP interno y estado del proveedor OIDC.</li>
    <li><strong>nats/:</strong> bus de eventos JetStream entre microservicios.</li>
    <li><strong>search/:</strong> índice full-text (Bleve).</li>
    <li><strong>storage/:</strong> metadatos CS3 y nodos del driver decomposed.</li>
    <li><strong>web/:</strong> activos estáticos del frontal integrado.</li>
  </ul>
  <p>Cifrado en reposo: blobs ordinarios dentro del volumen; opciones de endurecimiento incluyen LUKS, SSE en backend objeto o cifrado E2E en clientes. Cifrado en tránsito: TLS cliente↔Nginx.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Web KM0</p>
  <h2 class="doc-block-heading">Flujo HTTPS del sitio corporativo</h2>
  <div class="doc-note"><pre>Internet :443 ─► Nginx host (TLS, km0.amvara.de)
                     └──► http://127.0.0.1:9180  (km0-web — solo loopback)
                            Astro estático + nginx Alpine</pre></div>
  <ul class="doc-list">
    <li><strong>Stack:</strong> Astro 5 + Tailwind 3, salida estática.</li>
    <li><strong>i18n:</strong> JSON en <code>src/i18n/</code> + rutas <code>/ca/</code>, <code>/en/</code>, <code>/de/</code>; español por defecto en raíz.</li>
    <li><strong>Build:</strong> Node 22 Alpine multi-stage; repo en <code>/opt/km0-web</code>.</li>
    <li><strong>SEO:</strong> <code>@astrojs/sitemap</code> con alternativas hreflang.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Perímetro</p>
  <h2 class="doc-block-heading">Fail2ban y subdominio del cloud</h2>
  <p class="doc-block-intro">Tras el primer corte estable se añadió Fail2ban como red complementaria al firewall. El cloud quedó publicado en <code>cloud.km0.amvara.de</code>, separado de la marca de marketing en <code>km0.amvara.de</code>:</p>
  <ul class="doc-list">
    <li>Certificados y políticas CSP pueden divergir.</li>
    <li>Los usuarios entienden qué URL usar para trabajo vs comunicación.</li>
    <li>Los equipos pueden delegar DNS/TLS sin mezclar configuraciones del Astro estático.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Operación</p>
  <h2 class="doc-block-heading">Comandos rutinarios</h2>
  <div class="doc-note"><pre>cd /opt/opencloud/opencloud-compose
docker compose ps
docker compose logs -f opencloud
docker compose pull && docker compose up -d
git -C /opt/opencloud/opencloud-compose pull

ss -tulpn | grep -E ':22|:80|:443|:9200'
ufw status verbose
bash /opt/opencloud/scripts/backup-volumes.sh</pre></div>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Laboratorio vs producción</p>
  <h2 class="doc-block-heading">Fases del despliegue</h2>
  <ul class="doc-list">
    <li><strong>TLS provisional:</strong> certificado autofirmado útil para validar proxy — alertas en navegador hasta Let's Encrypt con DNS estable.</li>
    <li><strong>Dominio:</strong> pasar de IP cruda a FQDN mejora enlaces internos y cookies.</li>
    <li><strong>INSECURE relajado:</strong> solo coherente mientras los certificados internos no forman PKI confiable.</li>
    <li><strong>Backups:</strong> script manual hasta cron supervisado; vigilar <code>certbot.timer</code> en producción.</li>
  </ul>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Siguiente paso</p>
  <h2 class="doc-block-heading">Día 2</h2>
  <p class="doc-closing">El <strong>día 2</strong> madura autenticación OIDC con Dex, actualiza OpenCloud 7.x y establece el primer backup integral. Mientras tanto, explora los <a href="/#services">servicios</a> o el <a href="/doc/day-2/">relato del día 2</a>.</p>
</section>
