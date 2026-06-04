---
title: "Día 7 - De la petición del usuario al issue en GitHub, automatizado"
description: "Automatización de punta a punta: formularios /ideas/ y Admin Help encolan JSON, cursor-agent redacta issues estructurados, puerta de validación humana y autoagents implementan."
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
  <p class="doc-block-title">km0-web</p>
  <h2 class="doc-block-heading">Ideas públicas (<code>/ideas/</code>)</h2>
  <p class="doc-block-intro"><strong>Host:</strong> VPS producción · <strong>Repo:</strong> <a href="https://github.com/AMVARA-CONSULTING/km0-web">AMVARA-CONSULTING/km0-web</a></p>
  <p>La issue <a href="https://github.com/AMVARA-CONSULTING/km0-web/issues/14">#14</a> entregó solo el Script 1 (formulario + webhook + encolado). El Script 2, las unidades systemd, el spool en host <code>/var/spool/km0-ideas/</code> y el bind mount Docker nunca se desplegaron. JSON se acumulaba en <code>incoming/</code> sin consumidor.</p>
  <h3 class="doc-block-heading">Qué desplegamos</h3>
  <ul class="doc-list">
    <li><strong>Script 2:</strong> <code>scripts/process-idea.sh</code>, <code>scripts/setup-ideas-processor.sh</code>, <code>scripts/autoissue.sh</code>.</li>
    <li><strong>systemd:</strong> <code>deploy/systemd/km0-idea-processor.{path,service,timer}</code> (path al aparecer JSON; timer fallback 24 h).</li>
    <li><strong>Docker:</strong> bind mount <code>/var/spool/km0-ideas/incoming</code> en <code>docker-compose.yml</code>.</li>
    <li><strong>Autoissue:</strong> prompt <code>autoissue/autoissue-agent.md</code>; <code>cursor-agent</code> escribe borrador en <code>autoissue/drafts/</code>; parse frontmatter; <code>gh issue create --body-file</code>.</li>
    <li><strong>Puerta:</strong> etiqueta <code>waiting for human validation</code>; <code>issue_checker_agent.py</code> y <code>001-gh-reviewer.md</code> omiten issues etiquetados.</li>
  </ul>
  <div class="doc-note"><pre>Browser POST /hooks/ideas
  → receive-idea.sh → JSON en incoming/
  → systemd path trigger
  → autoissue.sh → cursor-agent → borrador .md
  → gh issue create → archiva JSON + borrador en processed/</pre></div>
  <p>Verificación: 10/10 PASS (formulario → cola, ~15 s E2E, Markdown limpio en <a href="https://github.com/AMVARA-CONSULTING/km0-web/issues/17">issue #17</a>, etiqueta aplicada, autoagents ignoran hasta quitarla).</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">laravel-ecommerce</p>
  <h2 class="doc-block-heading">Admin Help (staging)</h2>
  <p class="doc-block-intro"><strong>Staging:</strong> <a href="https://stage-serra.ldeluipy.es">stage-serra.ldeluipy.es</a> · <strong>Rama:</strong> <code>autoagents</code> · <strong>Repo:</strong> <a href="https://github.com/Luipy56/laravel-ecommerce">Luipy56/laravel-ecommerce</a></p>
  <p>Tres bloqueos resueltos el mismo día: CI en verde pero <code>STAGE_DEPLOY_ENABLED=false</code> (contenedor viejo, API 404); SSH de deploy roto (<code>PROD_PORT=60022</code>); Admin Help retrasado respecto a km0 (scheduler 5 min, prompt JSON, sin puerta humana).</p>
  <ul class="doc-list">
    <li><strong>CI/CD:</strong> deploy staging activado vía GitHub Actions (<code>stage.yml</code>); secrets SSH corregidos; contenedor en <code>0.1.340+</code>.</li>
    <li><strong>Autoissue alineado con km0:</strong> <code>autoissue/admin-help-agent.md</code>, <code>AdminHelpIssueProcessor</code>, <code>ProcessAdminHelpIssueJob</code> al POST; fallback diario <code>admin-help:process</code> a las 03:00 UTC.</li>
    <li><strong>Runtime:</strong> <code>docker-compose.stage.yml</code> monta <code>cursor-agent</code> y auth desde host; <code>GH_TOKEN</code> en <code>.env</code>.</li>
  </ul>
  <p>Verificado: test E2E autoissue en <a href="https://github.com/Luipy56/laravel-ecommerce/issues/27">issue #27</a> en staging, confirmado por operador. Admin Help en vivo en <code>/admin/help</code> (<a href="https://github.com/Luipy56/laravel-ecommerce/issues/26">#26</a>).</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Comparativa</p>
  <h2 class="doc-block-heading">Dos audiencias, un pipeline</h2>
  <ul class="doc-list">
    <li><strong>km0-web:</strong> usuario público → <code>/ideas/</code> → spool en host → systemd path (+ timer 24 h) → ejemplo <a href="https://github.com/AMVARA-CONSULTING/km0-web/issues/17">#17</a>.</li>
    <li><strong>laravel-ecommerce:</strong> admin interno → <code>/admin/help</code> → cola Laravel storage → queue job (+ cron diario) → ejemplo <a href="https://github.com/Luipy56/laravel-ecommerce/issues/27">#27</a>.</li>
    <li><strong>Compartido:</strong> borrador cursor-agent, <code>waiting for human validation</code>, autoagents tras quitar la etiqueta.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Resultado</p>
  <h2 class="doc-block-heading">Qué logró el día 7</h2>
  <p class="doc-block-intro">El paso manual entre «alguien pide algo» y «hay un issue en GitHub que un desarrollador o agente puede implementar» desaparece en producción (ideas públicas km0) y staging (admin help ecommerce).</p>
  <p>Push a <code>autoagents</code> en ecommerce actualiza staging en unos dos o tres minutos. Ambos stacks comparten la misma puerta: redactar el ticket automáticamente, retener validación humana, dejar que autoagents implementen cuando se aprueba.</p>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Serie</p>
  <h2 class="doc-block-heading">Días 1–6</h2>
  <p class="doc-closing">Las entradas anteriores cubren el stack (OpenCloud, Dex, LDAP, clientes nativos, tutoriales, visión). El día 7 añade el bucle de feedback: prueba el <a href="/ideas/">formulario de ideas</a> o revisa el <a href="/doc/day-6/">día 6</a> para onboarding en dispositivos. Dudas: <a href="/#contact">contacto</a>.</p>
</section>
