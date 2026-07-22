---
title: "Día 12 - Charla con cliente: experiencia de usuario"
description: "Conversación con una usuaria real sobre tutoriales, accesos directos a servicios, indexado fuera de Europa, login unificado y posicionamiento de privacidad KM0."
pubDate: 2026-06-22
locale: es
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducción</p>
  <p class="doc-lead">Tras activar <a href="/doc/day-11/">KM0 Email en producción</a>, mantuvimos una <strong>charla con una clienta</strong> (Luzma) centrada en cómo se siente usar KM0 desde fuera: dónde está el login, qué falta explicar y qué mejoras pequeñas harían la diferencia sin rediseñar todo el producto.</p>
  <p class="doc-lead">Esta entrada no transcribe la reunión palabra por palabra; resume los temas accionables que salieron y cómo encajan en el roadmap inmediato de km0-web y servicios relacionados.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Resumen</p>
  <h2 class="doc-block-heading">Puntos clave de la charla</h2>
  <ul class="doc-list">
    <li><strong>Experiencia de usuario:</strong> tutoriales simples y visibles, no manuales largos ni jerga técnica.</li>
    <li><strong>Accesos directos:</strong> widget tipo «9 puntos» en la web con enlaces a cloud, mail, registro y documentación.</li>
    <li><strong>Tutoriales nuevos:</strong> instalación en macOS, cómo compartir archivos y vídeo corto de primeros pasos.</li>
    <li><strong>Indexado:</strong> mejorar visibilidad en buscadores fuera de la UE (navegadores como Brave con filtros regionales).</li>
    <li><strong>Login y pagos:</strong> un solo flujo de acceso, explicación clara del pago en la pantalla principal y retirar páginas confusas de logout.</li>
    <li><strong>Privacidad:</strong> reforzar el mensaje de que KM0 no es una megaempresa ni monetiza tus datos.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Tutoriales</p>
  <h2 class="doc-block-heading">Aprender en minutos, no en horas</h2>
  <p class="doc-block-intro">La usuaria no pedía más funciones; pedía <strong>saber por dónde empezar</strong>. Las preguntas recurrentes: «¿dónde inicio sesión?», «¿cómo instalo esto en mi Mac?» y «¿cómo comparto una carpeta?».</p>
  <ul class="doc-list">
    <li><strong>Tutorial macOS:</strong> guía paso a paso para instalar y conectar la app de escritorio (issue separado en km0-web).</li>
    <li><strong>Compartir:</strong> capturas o vídeo corto del flujo de invitación y permisos en OpenCloud.</li>
    <li><strong>Primeros pasos:</strong> vídeo de unos minutos que recorra registro, login, subida de archivo y acceso al webmail.</li>
    <li><strong>Ubicación del login:</strong> enlaces visibles desde la home y desde el widget de servicios, no solo desde subdominios.</li>
    <li><strong>Idioma:</strong> materiales en castellano y catalán como mínimo; la web ya ofrece cuatro locales.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Widget de servicios</p>
  <h2 class="doc-block-heading">Accesos directos en la página principal</h2>
  <p class="doc-block-intro">Propuesta concreta de la charla: un botón al estilo de la cuadrícula de Google (nueve puntos) en la landing que despliegue los servicios KM0 sin memorizar URLs.</p>
  <ul class="doc-list">
    <li><strong>Cloud:</strong> enlace a <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a> con registro y login.</li>
    <li><strong>Mail:</strong> acceso a <a href="https://mail.km0digital.com/">mail.km0digital.com</a> para quien ya tiene buzón.</li>
    <li><strong>Documentación:</strong> enlace al <a href="/doc/">blog / doc</a> y a <a href="/presentation/">presentación</a> descargable.</li>
    <li><strong>Ideas y contacto:</strong> acceso rápido a <a href="/ideas/">ideas</a> y <a href="/#contact">contacto</a>.</li>
    <li><strong>Implementación:</strong> componente ligero en km0-web; no sustituye la navegación actual, la complementa.</li>
  </ul>
  <div class="doc-callout">
    <span class="doc-callout-title">Objetivo</span>
    <p>Que alguien nuevo encuentre cloud, mail y ayuda en un clic desde la home, sin buscar en el pie de página ni adivinar subdominios.</p>
  </div>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Login y pagos</p>
  <h2 class="doc-block-heading">Un solo acceso, menos fricción</h2>
  <p class="doc-block-intro">Hoy conviven varios puntos de entrada (web, app de escritorio, Roundcube). La charla dejó claro que <strong>dos logins distintos confunden</strong> y que la pantalla de pago necesita una frase honesta antes del formulario.</p>
  <ul class="doc-list">
    <li><strong>Login unificado:</strong> mismo destino desde la app de escritorio y desde la web pública (trabajo en curso en producto).</li>
    <li><strong>Explicación de pago:</strong> texto breve en la pantalla principal de registro: qué incluye el plan, cuándo se cobra y cómo cancelar.</li>
    <li><strong>Logout:</strong> simplificar o retirar páginas intermedias que dejan al usuario en callejón sin salida.</li>
    <li><strong>Desktop:</strong> la app debe abrir el mismo SSO que el navegador, no un formulario paralelo.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Indexado y privacidad</p>
  <h2 class="doc-block-heading">Encontrarnos fuera de Europa y decir quiénes somos</h2>
  <p class="doc-block-intro">Parte de la conversación giró en torno a buscadores con filtros regionales (por ejemplo Brave) y a la necesidad de que km0digital aparezca cuando alguien busca alternativas privadas al cloud grande.</p>
  <ul class="doc-list">
    <li><strong>SEO internacional:</strong> hreflang, sitemap y metadatos ya en km0-web; seguir mejorando títulos y descripciones por locale (ver issue #58).</li>
    <li><strong>Contenido útil:</strong> entradas del blog como esta ayudan a indexación orgánica sin campañas de pago.</li>
    <li><strong>Mensaje de privacidad:</strong> KM0 no es una ultraempresa; no vendemos perfiles ni entrenamos modelos con tus archivos.</li>
    <li><strong>Transparencia:</strong> páginas <a href="/legal/">legal</a> y <a href="/security/">seguridad</a> enlazadas desde tutoriales y widget.</li>
    <li><strong>Radar:</strong> preferimos crecer por recomendación y asociaciones (tema del <a href="/doc/day-13/">día 13</a>) que por ruido publicitario.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Roadmap</p>
  <h2 class="doc-block-heading">Qué viene después de esta charla</h2>
  <ol class="doc-steps">
    <li><strong>Widget de servicios</strong> en la landing de km0-web.</li>
    <li><strong>Tutorial macOS</strong> y guía de compartir en doc o vídeo embebido.</li>
    <li><strong>Mejoras SEO</strong> e indexado fuera de la UE (issue #58).</li>
    <li><strong>Login unificado</strong> y copy de pago en registro OpenCloud.</li>
    <li><strong>Vídeo de primeros pasos</strong> enlazado desde la home y el blog.</li>
  </ol>
  <p>La mayoría son cambios pequeños acumulados; juntos reducen la fricción que una usuaria real describió en la charla.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Verificación</p>
  <h2 class="doc-block-heading">Probar lo que ya existe</h2>
  <ol class="doc-steps">
    <li><strong>Home:</strong> abrir <a href="/">km0digital.com</a> y localizar enlaces a cloud, mail y doc.</li>
    <li><strong>Cloud:</strong> registro de prueba en <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a>.</li>
    <li><strong>Mail:</strong> webmail en <a href="https://mail.km0digital.com/">mail.km0digital.com</a> si tienes buzón.</li>
    <li><strong>Doc:</strong> leer <a href="/doc/day-11/">día 11</a> (mail) y <a href="/doc/day-13/">día 13</a> (meet 6).</li>
    <li><strong>Feedback:</strong> enviar mejoras por <a href="/ideas/">ideas</a> o <a href="/#contact">contacto</a>.</li>
  </ol>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Serie</p>
  <h2 class="doc-block-heading">Entradas relacionadas</h2>
  <p class="doc-closing">El <a href="/doc/day-11/">día 11</a> documentó KM0 Email; esta charla (día 12) recoge UX y accesibilidad; el <a href="/doc/day-13/">día 13</a> resume el meet 6 sobre visibilidad y asociaciones. Prueba el <a href="https://mail.km0digital.com/">webmail</a>, consulta <a href="/pricing/">precios</a> y cuéntanos qué tutorial echarías de menos.</p>
</section>
