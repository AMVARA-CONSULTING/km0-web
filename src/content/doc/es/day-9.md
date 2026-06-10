---
title: "Día 9 - Precios públicos, confianza y registro abierto"
description: "Página de precios con comparativa de mercado, legal y seguridad en cuatro idiomas, registro público en cloud.km0digital.com, aviso por email al equipo cuando llega una idea y pulido de conversión en la landing y el blog."
pubDate: 2026-06-10
locale: es
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducción</p>
  <p class="doc-lead">El <a href="/doc/day-8/">día 8</a> fijó estrategia y cifras; el día 9 las convierte en producto publicable. Entre el 9 y el 10 de junio de 2026 desplegamos la página de <a href="/pricing/">precios</a>, las secciones de <a href="/legal/">legal</a> y <a href="/security/">seguridad</a>, el auto-registro en <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a> y mejoras de conversión en la home y el blog.</p>
  <p class="doc-lead">KM0 deja de ser solo «algo que funciona si te lo explicamos» y pasa a ser un servicio que cualquiera puede descubrir, comparar, registrar y usar sin intermediario.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Resumen</p>
  <h2 class="doc-block-heading">Hitos del día</h2>
  <ul class="doc-list">
    <li><strong>Precios:</strong> <a href="/pricing/">/pricing/</a> con hero 500 GB / 1,99 €, tabla comparativa indicativa, explicación del modelo y CTA a cloud (#24, #25).</li>
    <li><strong>Confianza:</strong> páginas <a href="/legal/">legal</a> (aviso, privacidad RGPD, cookies) y <a href="/security/">seguridad</a> (ISO 27001 AMVARA, divulgación responsable) en cuatro idiomas (#21).</li>
    <li><strong>Registro:</strong> auto-registro email/contraseña vía <code>register-api</code> en OpenCloud; login Dex con <code>dex-auth.js</code> y auto sign-in tras registro.</li>
    <li><strong>Conversión:</strong> landing con KM0 Cloud más visible (#26); tipografía del blog y tutoriales refinada (#27); CTAs de servicios pulidos.</li>
    <li><strong>Ideas:</strong> email inmediato al equipo de desarrollo cuando alguien envía una idea en <a href="/ideas/">/ideas/</a> (<code>f41329c</code>).</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Precios</p>
  <h2 class="doc-block-heading">Página pública y comparativa</h2>
  <p class="doc-block-intro">La oferta acordada en el día 8 llega a la web con copy localizado (ES, CA, EN, DE) y diseño coherente con la marca.</p>
  <ul class="doc-list">
    <li><strong>Hero:</strong> bloque de precio con gradiente - <strong>1,99 €/mes · 500 GB</strong> - y botón «Empezar ahora» a <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a>.</li>
    <li><strong>Comparativa:</strong> referencias indicativas (Google Drive, OneDrive, iCloud, Dropbox, MEGA) con precio mensual, almacenamiento y coste aproximado por TB.</li>
    <li><strong>Claim:</strong> hasta cinco veces más espacio que planes básicos de referencia a precio similar; texto de confianza operativa debajo de la tabla.</li>
    <li><strong>Transparencia:</strong> sección «¿Por qué nuestro precio es distinto?» - infraestructura optimizada, eficiencia operativa, margen suficiente para sostener el servicio.</li>
  </ul>
  <p>Commits principales: <code>7a7e9da</code> (comparativa, 9 jun), <code>9d7906c</code> (rework mensajes y confianza, #25), <code>82a3ef0</code> / <code>65a32d2</code> (hero y CTA, 10 jun).</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Confianza</p>
  <h2 class="doc-block-heading">Legal y seguridad multilingües</h2>
  <p class="doc-block-intro">Antes de pedir registro y pago, la web debe responder «¿quién opera esto?» y «¿qué pasa con mis datos?». Las nuevas páginas centralizan la información legal de km0digital.com y cloud.km0digital.com.</p>
  <ul class="doc-list">
    <li><strong>Legal</strong> (<code>cd5579e</code>, #21): aviso legal AMVARA CONSULTING S.L., política de privacidad RGPD, cookies y sección específica de KM0 Cloud.</li>
    <li><strong>Seguridad:</strong> prácticas operativas (TLS, cabeceras, UE/Hetzner), alcance ISO/IEC 27001:2022 de AMVARA y política de divulgación responsable.</li>
    <li><strong>FAQ:</strong> respuestas existentes enlazan ahora a <a href="/security/#iso27001">/security/</a> y <a href="/legal/">/legal/</a> en los cuatro locales.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Registro público (km0-opencloud)</h2>
  <div class="doc-note"><pre>Usuario → /register (register.html)
        ↓
  POST /api/register → register-api (:8091, rate limit nginx)
        ↓
  Graph API (app token) crea usuario LDAP
        ↓
  dex-auth.js + auto sign-in → sesión Dex → OpenCloud</pre></div>
  <ul class="doc-list">
    <li><strong>Auto-registro</strong> (<code>67fe250</code>, 10 jun): <code>register.html</code>, API en loopback, proxy nginx <code>/api/register</code>, i18n ES/CA/EN/DE.</li>
    <li><strong>Graph auth</strong> (<code>7d52675</code>): corrección de auth con <code>GRAPH_SERVICE_APP_TOKEN</code> (Basic auth de app, no contraseña de usuario); health <code>graph_auth_ok</code>.</li>
    <li><strong>dex-auth.js</strong> (<code>efefcd3</code>): módulo compartido OIDC/PKCE para login, registro y contraseña Dex; auto sign-in post-registro vía session storage.</li>
    <li><strong>Operación:</strong> scripts <code>setup-register-api-graph-token.sh</code> y <code>verify-register-api.sh</code>; URL canónica <code>/register</code> (301 desde <code>/register.html</code>).</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Web corporativa</p>
  <h2 class="doc-block-heading">Conversión y lectura (km0-web, 10 jun)</h2>
  <ul class="doc-list">
    <li><strong>Landing</strong> (<code>5f021e4</code>, #26): KM0 Cloud más visible, accesibilidad y CTAs de conversión refinados.</li>
    <li><strong>Servicios</strong> (<code>471e407</code>): tarjeta KM0 Cloud con CTAs claros hacia registro y tutoriales.</li>
    <li><strong>Blog</strong> (<code>2425cc1</code>, <code>4487bef</code>, #27): tipografía de artículos, listas tipo definición, TOC móvil y legibilidad general.</li>
    <li><strong>Estilos</strong> (<code>e5223f4</code>): import de CSS global en layout; selectores <code>.doc-body</code> corregidos.</li>
  </ul>
  <p>Versión del sitio al cierre: <strong>1.1.70</strong>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Ideas</p>
  <h2 class="doc-block-heading">Aviso por email al equipo (última hora)</h2>
  <p class="doc-block-intro">El bucle del <a href="/doc/day-7/">día 7</a> ya encolaba ideas y generaba tickets en GitHub, pero el equipo solo se enteraba al revisar la cola o el repositorio. Con la campaña de marketing del día 8, hacía falta reaccionar antes.</p>
  <div class="doc-note"><pre>POST /hooks/ideas → receive-idea.sh
        ↓
  JSON en /var/spool/km0-ideas/incoming/
        ↓
  notify-idea-email.sh (background, fire-and-forget)
        ↓
  AutoMail API → email al equipo (asunto + primeros 100 caracteres)
        ↓
  (sin cambios) autoissue → gh issue create</pre></div>
  <ul class="doc-list">
    <li><strong>Script:</strong> <code>scripts/notify-idea-email.sh</code> - llama a AutoMail (<code>AUTOMAIL_TOKEN</code> en <code>.env</code> del repo); no usa <code>cursor-agent</code>.</li>
    <li><strong>Disparo:</strong> <code>receive-idea.sh</code> lo lanza en segundo plano justo después de escribir el JSON en la cola.</li>
    <li><strong>Contenido:</strong> asunto «Nueva idea km0digital» y vista previa del mensaje (100 caracteres); destino configurable con <code>AUTOMAIL_NOTIFY_TO</code>.</li>
    <li><strong>Receiver:</strong> el sidecar Docker del webhook pasa a systemd en el host (<code>km0-ideas-receiver.service</code>); secretos desde <code>.env</code> del repositorio.</li>
  </ul>
  <p>El ticket automatizado y la etiqueta <code>waiting for human validation</code> siguen igual; el email es solo un aviso temprano para que alguien del equipo lea la idea en cuanto llegue.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Verificación</p>
  <h2 class="doc-block-heading">Comprobar el día 9</h2>
  <ol class="doc-steps">
    <li><strong>Precios:</strong> visitar <a href="/pricing/">/pricing/</a> y comprobar hero, tabla y CTA en cada idioma.</li>
    <li><strong>Legal:</strong> revisar <a href="/legal/">/legal/</a> y <a href="/security/">/security/</a>; enlaces desde FAQ y pie.</li>
    <li><strong>Registro:</strong> crear cuenta de prueba en <a href="https://cloud.km0digital.com/register">cloud.km0digital.com/register</a>; verificar auto sign-in.</li>
    <li><strong>Ideas:</strong> enviar prueba en <a href="/ideas/">/ideas/</a>; comprobar JSON en spool y email al equipo vía AutoMail.</li>
    <li><strong>Humo:</strong> bucle autoagents - issues #21, #24, #25, #26, #27 cerradas; register-api health OK.</li>
  </ol>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Serie</p>
  <h2 class="doc-block-heading">Días 1–8</h2>
  <p class="doc-closing">El <a href="/doc/day-8/">día 8</a> explica la estrategia y el precio acordado; los días anteriores cubren el stack técnico. Prueba <a href="https://cloud.km0digital.com/">KM0 Cloud</a>, consulta <a href="/pricing/">precios</a> o envía una idea en <a href="/ideas/">/ideas/</a>. Dudas: <a href="/#contact">contacto</a>.</p>
</section>
