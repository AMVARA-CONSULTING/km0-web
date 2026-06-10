---
title: "Día 8 - Estrategia, precios y primeros materiales de marketing"
description: "Reunión de varias horas sobre el futuro de KM0: captación de clientes, campaña de marketing, folletos DIN A6 y modelo de precios 500 GB / 1,99 €. La web empieza a reflejarlo."
pubDate: 2026-06-08
locale: es
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducción</p>
  <p class="doc-lead">Tras cerrar el bucle de feedback del <a href="/doc/day-7/">día 7</a>, el equipo dedicó la primera semana de junio a una conversación distinta: no sobre commits ni despliegues, sino sobre <strong>cómo llegar a quien aún no conoce KM0</strong>. El responsable del proyecto y el equipo de desarrollo hablaron durante varias horas, en varias sesiones, sobre el futuro de la aplicación, la captación de clientes y la necesidad de una campaña de marketing concreta.</p>
  <p class="doc-lead">De esa mesa salieron decisiones que ya empiezan a verse en km0digital.com: un precio público honesto, materiales para repartir en formato DIN A6 y una página de presentación descargable que resume la propuesta sin jerga técnica.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Resumen</p>
  <h2 class="doc-block-heading">Qué decidimos</h2>
  <ul class="doc-list">
    <li><strong>Captación:</strong> combinar presencia local (boca a boca, asociaciones, comercio de proximidad) con canales digitales (web, WhatsApp, formulario de ideas).</li>
    <li><strong>Marketing:</strong> preparar una campaña ligera pero constante; pieza central: folletos impresos en <strong>DIN A6</strong> (postal de mano, barato de imprimir y fácil de dejar en mostradores).</li>
    <li><strong>Precio:</strong> <strong>500 GB por 1,99 €/mes</strong> - suficiente para sostener la infraestructura, claramente por debajo de planes básicos de la competencia.</li>
    <li><strong>Web:</strong> página de <a href="/presentation/">presentación</a> con PDF, contador de usuarios en <a href="/cloud/">/cloud/</a>, acceso rápido al grupo de WhatsApp y navegación más clara.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Estrategia</p>
  <h2 class="doc-block-heading">Varias horas sobre el futuro</h2>
  <p class="doc-block-intro">La pregunta de fondo no era «¿qué feature falta?» sino «¿cómo encontramos a las primeras personas que confíen en nosotros?». KM0 ya funciona técnicamente; lo que falta es visibilidad y una oferta que se entienda en treinta segundos.</p>
  <ul class="doc-list">
    <li><strong>Público objetivo:</strong> familias, asociaciones, cooperativas, comercios locales y pequeñas organizaciones que hoy pagan de más por almacenamiento en la nube sin saber alternativas.</li>
    <li><strong>Mensaje:</strong> proximidad, transparencia y precio justo - la misma narrativa del <a href="/doc/day-5/">día 5</a>, ahora con cifras concretas.</li>
    <li><strong>Campaña:</strong> no un gran despliegue publicitario, sino acciones repetibles: folletos, charlas breves, QR a la web y seguimiento por WhatsApp.</li>
    <li><strong>Medición:</strong> registrar cuántas visitas y registros vienen de cada canal antes de escalar lo que funcione.</li>
  </ul>
  <div class="doc-callout">
    <span class="doc-callout-title">Frase de la mesa</span>
    <p>«No necesitamos ser los más baratos del mercado entero; necesitamos ser lo bastante baratos para que la gente pruebe, y lo bastante sostenibles para seguir operando.»</p>
  </div>
</section>

<section class="doc-block">
  <p class="doc-block-title">Precios</p>
  <h2 class="doc-block-heading">500 GB por 1,99 € al mes</h2>
  <p class="doc-block-intro">Hicimos números con el coste real de infraestructura (almacenamiento, copias, operación en la UE). El objetivo: un plan único, legible y sostenible - no maximizar margen por cliente, sino cubrir costes y crecer con volumen.</p>
  <ul class="doc-list">
    <li><strong>Oferta pública:</strong> 500 GB por 1,99 €/mes - hasta cinco veces más espacio que planes básicos de referencia (~100 GB por ~2 €).</li>
    <li><strong>Lógica interna:</strong> con coste de infraestructura del orden de ~2 €/TB/mes, el plan deja margen operativo incluso si un cliente usa todo el cupo; con uso medio más bajo (escenario de overselling prudente), el modelo aguanta mejor.</li>
    <li><strong>Principio:</strong> cobrar lo que cuesta mantener el servicio de forma limpia, no replicar márgenes de las grandes plataformas.</li>
    <li><strong>Próximo paso:</strong> publicar la comparativa y la explicación del precio en <a href="/pricing/">/pricing/</a> (día 9).</li>
  </ul>
  <div class="doc-note">Los detalle económicos completos viven en documentación interna del repositorio (<code>docs/pricing-economics.md</code>); la web publica solo la oferta y referencias indicativas de mercado.</div>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Marketing</p>
  <h2 class="doc-block-heading">Folletos DIN A6 y presentación web</h2>
  <p class="doc-block-intro">El folleto DIN A6 encaja con la estrategia de proximidad: cabe en el bolsillo, se imprime barato en tiradas pequeñas y lleva QR a km0digital.com y al cloud. El contenido reutiliza el mensaje de la presentación corporativa - valores, comparativa con las grandes plataformas, precio y contacto.</p>
  <ul class="doc-list">
    <li><strong>Formato:</strong> DIN A6 (105 × 148 mm), doble cara, QR a <a href="/presentation/">/presentation/</a> y a <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a>.</li>
    <li><strong>Web:</strong> nueva página <a href="/presentation/">Presentación</a> con descarga del PDF original (~618 KB) en cuatro idiomas.</li>
    <li><strong>WhatsApp:</strong> hint visible en la sección de contacto para unirse al grupo comunitario.</li>
    <li><strong>Distribución prevista:</strong> comercios de barrio, asociaciones vecinales y eventos locales del entorno Masnou / Maresme.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Web corporativa</p>
  <h2 class="doc-block-heading">Entregas técnicas (5–6 junio, km0-web)</h2>
  <ul class="doc-list">
    <li><strong>Presentación</strong> (<code>2d90880</code>): página localizada <code>/presentation/</code> con PDF descargable; logo de marca compartido y caché de assets.</li>
    <li><strong>Cloud</strong> (<code>4a5442b</code>): contador de usuarios OpenCloud en páginas <a href="/cloud/">/cloud/</a> por locale.</li>
    <li><strong>Contacto</strong> (<code>cafd20f</code>): hint de WhatsApp y créditos «Powered by» en el pie.</li>
    <li><strong>Navegación</strong> (<code>e8df837</code>): menú simplificado y scroll móvil mejorado en <code>Header.astro</code>.</li>
    <li><strong>Pie</strong> (<code>6bb66d4</code>, <code>974f303</code>, <code>abc725b</code>): fecha de creación del repo GitHub, crédito «Powered by AMVARA» y logo GitHub junto al enlace.</li>
    <li><strong>Rutas</strong> (<code>a5b7c4a</code>): path unificado <code>/presentation/</code> (antes <code>presentacion</code>).</li>
  </ul>
  <p>Versión del sitio al cierre del día 8: <strong>1.1.x</strong> (commits del 5–6 de junio; la página de precios llega en el día 9).</p>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Siguiente paso</p>
  <h2 class="doc-block-heading">Día 9</h2>
  <p class="doc-closing">El <a href="/doc/day-9/">día 9</a> publica la página de <a href="/pricing/">precios</a>, las páginas de <a href="/legal/">legal</a> y <a href="/security/">seguridad</a>, el registro público en el cloud y el pulido de conversión en la landing. Mientras tanto, descarga la <a href="/presentation/">presentación</a> o prueba el <a href="/ideas/">formulario de ideas</a>.</p>
</section>
