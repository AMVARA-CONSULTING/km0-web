---
title: "Día 6 - Clientes nativos, tutoriales y una web alineada con la visión"
description: "KM0 Cloud en todos los dispositivos: clientes OIDC Dex para sync móvil y escritorio, corrección loopback, previews de enlace con marca, tutoriales multilingües y home renovada en km0digital.com."
pubDate: 2026-06-03
locale: es
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducción</p>
  <p class="doc-lead">El día 6 continúa después de la <a href="/doc/day-5/">reunión de visión</a>: el stack ya funcionaba en el navegador (días 1–4), pero los usuarios reales también necesitan apps nativas, onboarding claro y una web pública que cuente la misma historia. Esta entrada recoge ese trabajo sin detallar días concretos del calendario.</p>
  <p class="doc-lead">Dos frentes avanzan en paralelo: <strong>km0digital.com</strong> recibe copy orientado al movimiento, FAQs de seguridad y guías paso a paso del cloud; <strong>cloud.km0digital.com</strong> corrige OIDC para sync en escritorio y móvil, aplica branding KM0 y enriquece las previews al compartir enlaces.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Resumen</p>
  <h2 class="doc-block-heading">Qué cambió</h2>
  <ul class="doc-list">
    <li><strong>Web:</strong> secciones Visión y Comunidad en la home; FAQ en acordeón; respuestas de seguridad (ISO 27001 en AMVARA, alojamiento UE); <a href="/tutorials/">tutoriales KM0 Cloud</a> web, Android e iOS en cuatro idiomas; presentaciones CA/ES/EN en PPT y PDF.</li>
    <li><strong>Auth nativa:</strong> clientes OIDC estáticos en Dex para <code>OpenCloudDesktop</code>, <code>OpenCloudAndroid</code> y <code>OpenCloudIOS</code>; nginx envía solo el cliente web a <code>/login.html</code>.</li>
    <li><strong>Loopback escritorio:</strong> Dex actualizado a <code>v2.42.0</code> para URIs OAuth <code>http://127.0.0.1:&lt;puerto&gt;</code> (RFC 8252).</li>
    <li><strong>Marca y sharing:</strong> favicon KM0 en login, Dex y SPA autenticada; tarjetas Open Graph / Twitter y <code>/brand/og-preview.png</code> para crawlers sociales.</li>
    <li><strong>Horizonte:</strong> login Facebook investigado vía OAuth en Dex; documentado y condicionado por env, aún no activo en producción.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Web corporativa</p>
  <h2 class="doc-block-heading">De la visión al onboarding</h2>
  <p class="doc-block-intro">Tras el día 5, la home debía reflejar la narrativa comunitaria, no solo el stack técnico. Nuevas secciones de <strong>Visión</strong> y <strong>Comunidad</strong>, copy renovado en todos los idiomas y un footer más simple (GitHub + AMVARA) anclan la historia en personas y territorio.</p>
  <p>El FAQ se reconstruyó como acordeón medido (un panel abierto a la vez) y se amplió con respuestas honestas de seguridad: AMVARA CONSULTING S.L. dispone de ISO 27001; la certificación del ámbito KM0 Cloud está prevista; los datos permanecen en la UE; no hay entrenamiento de modelos de terceros con ficheros de clientes.</p>
  <p>Las guías de onboarding viven en <a href="/tutorials/">/tutorials/</a>: primeros pasos en web, Android e iOS, cada una localizada. El bloque Servicios enlaza directamente a la guía web para que nadie se quede a medias tras leer sobre el cloud.</p>
  <p>Tres presentaciones (<em>Origen Local</em> en catalán, <em>Impacto Digital</em> en castellano, <em>Sovereign Tech</em> en inglés) se generaron a partir del contenido del sitio y del stack para el outreach comunitario tras la reunión de Masnou.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Clientes nativos de sync y OIDC</h2>
  <p class="doc-block-intro">El login web por Dex LDAP (día 4) funcionaba; las apps Android, iOS y escritorio fallaban con <code>invalid client_id</code>. Dex no tenía clientes estáticos para los IDs nativos y nginx redirigía <em>toda</em> petición <code>/dex/auth</code> al híbrido <code>login.html</code>, que las apps no pueden renderizar.</p>
  <ul class="doc-list">
    <li><strong>Dex:</strong> registrar <code>opencloud-web</code>, <code>OpenCloudDesktop</code>, <code>OpenCloudAndroid</code> y <code>OpenCloudIOS</code> con las URIs de redirect que exige cada plataforma.</li>
    <li><strong>nginx:</strong> redirigir a <code>/login.html</code> solo cuando <code>client_id=opencloud-web</code>; clientes móvil y escritorio mantienen el endpoint de autorización Dex.</li>
  </ul>
  <p>Las comprobaciones automáticas en servidor pasan (WebFinger, códigos del endpoint de auth). La sync real en dispositivo físico queda como verificación de operador.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Por qué el escritorio necesitaba Dex v2.42.0</h2>
  <p class="doc-block-intro">Incluso con el cliente registrado, la app de escritorio seguía fallando: usa OAuth loopback (<code>http://127.0.0.1:&lt;puerto-aleatorio&gt;</code> en cada login). Dex <code>v2.41.1</code> exigía coincidencia exacta de redirect URI; una entrada fija <code>http://127.0.0.1</code> no cubre un puerto nuevo cada vez.</p>
  <p>Actualización a <code>ghcr.io/dexidp/dex:v2.42.0</code> y <code>OpenCloudDesktop</code> con <code>redirectURIs</code> vacío para que Dex acepte cualquier puerto loopback en <code>127.0.0.1</code> o <code>localhost</code>. Web y móvil ya usaban URIs HTTPS fijas o esquemas custom y no necesitaban este cambio.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Favicon KM0 y previews de enlace</h2>
  <p class="doc-block-intro">Los enlaces compartidos del cloud mostraban metadatos genéricos de OpenCloud. nginx inyecta tags Open Graph y Twitter para crawlers; Dex y <code>login.html</code> comparten título KM0 e imagen de preview (<code>/brand/og-preview.png</code>).</p>
  <p>El favicon pin gradiente KM0 sustituye el icono OpenCloud por defecto en login, pantallas LDAP de Dex y la ruta de tema de la SPA autenticada, para que pestañas y marcadores coincidan con <a href="https://km0digital.com/">km0digital.com</a>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Horizonte</p>
  <h2 class="doc-block-heading">Login Facebook (solo investigación)</h2>
  <p class="doc-block-intro">El login Meta se acotó para Dex como conector OAuth upstream (Dex sigue siendo el único emisor OIDC de OpenCloud). La investigación está completa: config de ejemplo, hook en entrypoint condicionado por env y runbook sobre App Review y claims de email.</p>
  <p>La activación en producción espera la revisión de Meta y una decisión de producto sobre cuentas sin email verificado. Google, Apple y LDAP local no se ven afectados.</p>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Siguiente paso</p>
  <h2 class="doc-block-heading">Día 7</h2>
  <p class="doc-closing">El día 6 cierra el círculo entre visión y uso diario: apps de sync, tutoriales y una web que explica ambos. Una <strong>entrada especial del día 7</strong> llegará aparte. Mientras tanto, prueba las <a href="/tutorials/">guías del cloud</a> o entra en <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a>.</p>
</section>
