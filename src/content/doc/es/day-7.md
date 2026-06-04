---
title: "Día 7 - De la petición al ticket, automatizado"
description: "Automatización de punta a punta: el formulario de ideas y Admin Help convierten peticiones en tickets claros, con revisión humana antes de implementar."
pubDate: 2026-06-04
locale: es
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducción</p>
  <p class="doc-lead">El día 7 es una entrada especial: documenta la automatización que cierra un hueco que los días anteriores dejaban abierto. Alguien enviaba una idea o incidencia; un desarrollador leía el texto crudo, lo reescribía como issue de GitHub y solo entonces empezaba la implementación. Ese traspaso era el cuello de botella.</p>
  <p class="doc-lead">El 4 de junio de 2026 cableamos el ciclo completo en dos canales: feedback público en <a href="https://km0digital.com/ideas/">km0digital.com</a> (producción) y Admin Help interno en un stack Laravel ecommerce en staging. Mismo modelo mental: cola, borrador autoissue, etiqueta humana, recogida por autoagents.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Resumen</p>
  <h2 class="doc-block-heading">Antes y después</h2>
  <ul class="doc-list">
    <li><strong>Petición:</strong> mensaje suelto o email → JSON estructurado en cola.</li>
    <li><strong>Comprensión:</strong> el dev interpreta texto crudo → <code>cursor-agent</code> escribe borrador <code>.md</code> estructurado.</li>
    <li><strong>Ticket:</strong> <code>gh issue create</code> manual → issue automatizado con cuerpo Markdown limpio.</li>
    <li><strong>Control humano:</strong> implícito → etiqueta <code>waiting for human validation</code>.</li>
    <li><strong>Implementación:</strong> el dev asigna trabajo → humano quita la etiqueta → autoagents (001 / FEAT) recogen el issue.</li>
  </ul>
  <p>El desarrollador ya no abre la petición cruda y redacta el ticket desde cero. El sistema encola, redacta y publica en GitHub en segundos. Un humano valida o corrige quitando la etiqueta; a partir de ahí el pipeline de agentes puede implementar.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Arquitectura</p>
  <h2 class="doc-block-heading">Dos entradas, un patrón</h2>
  <div class="doc-note"><pre>ENTRADA
  km0-web:     POST /hooks/ideas        (público /ideas/)
  ecommerce:   POST /api/v1/admin/help  (/admin/help autenticado)
        ↓
  Cola JSON (spool / storage)
        ↓
  Disparo inmediato (systemd path / queue job)
        ↓
  cursor-agent (--yolo) + prompt autoissue → borrador .md
        ↓
  gh issue create --body-file + etiqueta waiting for human validation
        ↓
  Humano revisa → quita etiqueta → autoagents 001 → FEAT → código</pre></div>
</section>

<section class="doc-block">
  <p class="doc-block-title">Por qué encaja</p>
  <h2 class="doc-block-heading">Una solución práctica para equipos pequeños</h2>
  <p class="doc-block-intro">No buscábamos automatizar por moda. Queríamos que una petición útil no se perdiera entre un chat, un email y la cabeza de quien la recibió. El sistema convierte cada envío en un ticket legible, con contexto y prioridad, en unos segundos.</p>
  <ul class="doc-list">
    <li><strong>Rapidez:</strong> quien escribe no espera a que alguien tenga un hueco para redactar la incidencia.</li>
    <li><strong>Calidad:</strong> el borrador sigue siempre la misma estructura (qué pasa, para quién, qué se espera).</li>
    <li><strong>Control:</strong> nada entra en desarrollo sin pasar por una persona del equipo.</li>
    <li><strong>Reutilizable:</strong> el mismo patrón sirve para feedback público y para peticiones internas.</li>
  </ul>
  <p>Para KM0 encaja especialmente bien: recibimos ideas de gente no técnica y las queremos tratar con el mismo rigor que un informe de un administrador de tienda online.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Dónde aplica</p>
  <h2 class="doc-block-heading">Dos puertas de entrada, un recorrido</h2>
  <ul class="doc-list">
    <li><strong>Quien usa KM0:</strong> el formulario <a href="/ideas/">Ideas</a> en km0digital.com. Sirve para sugerencias de producto, mejoras de la web o cosas que echas en falta al usar el cloud.</li>
    <li><strong>Quien opera un proyecto interno:</strong> la pantalla Admin Help de una tienda online en staging. Sirve cuando alguien del equipo ve un fallo o necesita un cambio y quiere dejarlo registrado con trazabilidad.</li>
  </ul>
  <p>En ambos casos el recorrido es el mismo: formulario → cola → ticket redactado → revisión humana → implementación. Cambia quién escribe y dónde, no la lógica.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Ejemplos</p>
  <h2 class="doc-block-heading">Cómo se ve en la práctica</h2>
  <p class="doc-block-intro">Imagina que alguien envía desde <a href="/ideas/">Ideas</a>: «Me gustaría un botón para compartir entradas del blog». En unos quince segundos el sistema genera un ticket titulado y ordenado: qué pide la persona, en qué idioma escribió, qué parte del sitio toca. Aparece marcado como <em>pendiente de validación humana</em>.</p>
  <p>Alguien del equipo lo lee. Si el texto está bien, quita la marca y el ticket pasa a la cola de implementación automática. Si hace falta matizar («solo en móvil», «icono de WhatsApp»), se edita el ticket antes de aprobarlo. Sin volver a copiar el mensaje original a mano.</p>
  <p>Otro caso: un administrador de la tienda en staging reporta desde Admin Help que un filtro de productos no guarda bien. Misma mecánica: ticket claro, revisión, y solo entonces entra en el flujo de desarrollo. El objetivo es que nadie tenga que adivinar qué quiso decir quien escribió.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Personas</p>
  <h2 class="doc-block-heading">Qué hace (y qué no) la automatización</h2>
  <p class="doc-block-intro">La máquina redacta y clasifica. La persona decide. Los agentes de desarrollo no recogen tickets mientras sigan marcados como pendientes de validación: así evitamos implementar a ciegas un mensaje ambiguo o una broma.</p>
  <p>Para quien envía una idea, el beneficio es simple: escribes una vez en lenguaje normal y el equipo recibe algo accionable. Para quien mantiene el servicio, el beneficio es dejar de ser el traductor permanente entre «mensaje de WhatsApp» y «ticket bien escrito».</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Resultado</p>
  <h2 class="doc-block-heading">Qué logró el día 7</h2>
  <p class="doc-block-intro">El paso manual entre «alguien pide algo» y «hay un ticket que se puede implementar» desaparece en producción (ideas públicas de KM0) y en el entorno de pruebas del ecommerce (Admin Help).</p>
  <p>Hoy el ciclo completo funciona: petición, ticket redactado, validación humana e implementación asistida por agentes. Es la pieza que faltaba para cerrar el círculo entre escuchar a la comunidad y entregar cambios con criterio.</p>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Serie</p>
  <h2 class="doc-block-heading">Días 1–6</h2>
  <p class="doc-closing">Las entradas anteriores cubren el stack (OpenCloud, Dex, LDAP, clientes nativos, tutoriales, visión). El día 7 añade el bucle de feedback: prueba el <a href="/ideas/">formulario de ideas</a> o revisa el <a href="/doc/day-6/">día 6</a> para onboarding en dispositivos. Dudas: <a href="/#contact">contacto</a>.</p>
</section>
