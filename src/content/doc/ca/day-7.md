---
title: "Dia 7 - De la petició de l'usuari a l'issue de GitHub, automatitzat"
description: "Automatització de punta a punta: formularis /ideas/ i Admin Help encolen JSON, cursor-agent redacta issues estructurats, porta de validació humana i autoagents implementen."
pubDate: 2026-06-04
locale: ca
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducció</p>
  <p class="doc-lead">El dia 7 és una entrada especial: documenta l'automatització que tanca un buit que els dies anteriors deixaven obert. Algú enviava una idea o incidència; un desenvolupador llegia el text cru, el reescrivia com a issue de GitHub i només llavors començava la implementació. Aquest traspàs era el coll d'ampolla.</p>
  <p class="doc-lead">El 4 de juny de 2026 vam cablejar el cicle complet en dos canals: feedback públic a <a href="https://km0digital.com/ca/ideas/">km0digital.com</a> (producció) i Admin Help intern en un stack Laravel ecommerce en staging. Mateix model mental: cua, esborrany autoissue, etiqueta humana, recollida per autoagents.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Resum</p>
  <h2 class="doc-block-heading">Abans i després</h2>
  <ul class="doc-list">
    <li><strong>Petició:</strong> missatge solt o email → JSON estructurat en cua.</li>
    <li><strong>Comprensió:</strong> el dev interpreta text cru → <code>cursor-agent</code> escriu esborrany <code>.md</code> estructurat.</li>
    <li><strong>Ticket:</strong> <code>gh issue create</code> manual → issue automatitzat amb cos Markdown net.</li>
    <li><strong>Control humà:</strong> implícit → etiqueta <code>waiting for human validation</code>.</li>
    <li><strong>Implementació:</strong> el dev assigna feina → humà treu l'etiqueta → autoagents (001 / FEAT) recullen l'issue.</li>
  </ul>
  <p>El desenvolupador ja no obre la petició crua i redacta el ticket des de zero. El sistema encua, redacta i publica a GitHub en segons. Un humà valida o corregeix traient l'etiqueta; a partir d'aquí el pipeline d'agents pot implementar.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Arquitectura</p>
  <h2 class="doc-block-heading">Dues entrades, un patró</h2>
  <div class="doc-note"><pre>ENTRADA
  km0-web:     POST /hooks/ideas        (públic /ideas/)
  ecommerce:   POST /api/v1/admin/help  (/admin/help autenticat)
        ↓
  Cua JSON (spool / storage)
        ↓
  Dispar immediat (systemd path / queue job)
        ↓
  cursor-agent (--yolo) + prompt autoissue → esborrany .md
        ↓
  gh issue create --body-file + etiqueta waiting for human validation
        ↓
  Humà revisa → treu etiqueta → autoagents 001 → FEAT → codi</pre></div>
</section>

<section class="doc-block">
  <p class="doc-block-title">km0-web</p>
  <h2 class="doc-block-heading">Idees públiques (<code>/ideas/</code>)</h2>
  <p class="doc-block-intro"><strong>Host:</strong> VPS producció · <strong>Repo:</strong> <a href="https://github.com/AMVARA-CONSULTING/km0-web">AMVARA-CONSULTING/km0-web</a></p>
  <p>La issue <a href="https://github.com/AMVARA-CONSULTING/km0-web/issues/14">#14</a> va lliurar només el Script 1 (formulari + webhook + encuat). El Script 2, les unitats systemd, el spool en host <code>/var/spool/km0-ideas/</code> i el bind mount Docker mai es van desplegar. JSON s'acumulava a <code>incoming/</code> sense consumidor.</p>
  <h3 class="doc-block-heading">Què vam desplegar</h3>
  <ul class="doc-list">
    <li><strong>Script 2:</strong> <code>scripts/process-idea.sh</code>, <code>scripts/setup-ideas-processor.sh</code>, <code>scripts/autoissue.sh</code>.</li>
    <li><strong>systemd:</strong> <code>deploy/systemd/km0-idea-processor.{path,service,timer}</code> (path en aparèixer JSON; timer fallback 24 h).</li>
    <li><strong>Docker:</strong> bind mount <code>/var/spool/km0-ideas/incoming</code> a <code>docker-compose.yml</code>.</li>
    <li><strong>Autoissue:</strong> prompt <code>autoissue/autoissue-agent.md</code>; <code>cursor-agent</code> escriu esborrany a <code>autoissue/drafts/</code>; parse frontmatter; <code>gh issue create --body-file</code>.</li>
    <li><strong>Porta:</strong> etiqueta <code>waiting for human validation</code>; <code>issue_checker_agent.py</code> i <code>001-gh-reviewer.md</code> ometen issues etiquetats.</li>
  </ul>
  <div class="doc-note"><pre>Browser POST /hooks/ideas
  → receive-idea.sh → JSON a incoming/
  → systemd path trigger
  → autoissue.sh → cursor-agent → esborrany .md
  → gh issue create → arxiva JSON + esborrany a processed/</pre></div>
  <p>Verificació: 10/10 PASS (formulari → cua, ~15 s E2E, Markdown net a <a href="https://github.com/AMVARA-CONSULTING/km0-web/issues/17">issue #17</a>, etiqueta aplicada, autoagents ignoren fins treure-la).</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">laravel-ecommerce</p>
  <h2 class="doc-block-heading">Admin Help (staging)</h2>
  <p class="doc-block-intro"><strong>Staging:</strong> <a href="https://stage-serra.ldeluipy.es">stage-serra.ldeluipy.es</a> · <strong>Branca:</strong> <code>autoagents</code> · <strong>Repo:</strong> <a href="https://github.com/Luipy56/laravel-ecommerce">Luipy56/laravel-ecommerce</a></p>
  <p>Tres bloquejos resolts el mateix dia: CI en verd però <code>STAGE_DEPLOY_ENABLED=false</code> (contenidor vell, API 404); SSH de deploy trencat (<code>PROD_PORT=60022</code>); Admin Help endarrerit respecte km0 (scheduler 5 min, prompt JSON, sense porta humana).</p>
  <ul class="doc-list">
    <li><strong>CI/CD:</strong> deploy staging activat via GitHub Actions (<code>stage.yml</code>); secrets SSH corregits; contenidor a <code>0.1.340+</code>.</li>
    <li><strong>Autoissue alineat amb km0:</strong> <code>autoissue/admin-help-agent.md</code>, <code>AdminHelpIssueProcessor</code>, <code>ProcessAdminHelpIssueJob</code> al POST; fallback diari <code>admin-help:process</code> a les 03:00 UTC.</li>
    <li><strong>Runtime:</strong> <code>docker-compose.stage.yml</code> munta <code>cursor-agent</code> i auth des de host; <code>GH_TOKEN</code> a <code>.env</code>.</li>
  </ul>
  <p>Verificat: test E2E autoissue a <a href="https://github.com/Luipy56/laravel-ecommerce/issues/27">issue #27</a> en staging, confirmat per operador. Admin Help en viu a <code>/admin/help</code> (<a href="https://github.com/Luipy56/laravel-ecommerce/issues/26">#26</a>).</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Comparativa</p>
  <h2 class="doc-block-heading">Dues audiències, un pipeline</h2>
  <ul class="doc-list">
    <li><strong>km0-web:</strong> usuari públic → <code>/ideas/</code> → spool en host → systemd path (+ timer 24 h) → exemple <a href="https://github.com/AMVARA-CONSULTING/km0-web/issues/17">#17</a>.</li>
    <li><strong>laravel-ecommerce:</strong> admin intern → <code>/admin/help</code> → cua Laravel storage → queue job (+ cron diari) → exemple <a href="https://github.com/Luipy56/laravel-ecommerce/issues/27">#27</a>.</li>
    <li><strong>Compartit:</strong> esborrany cursor-agent, <code>waiting for human validation</code>, autoagents després de treure l'etiqueta.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Resultat</p>
  <h2 class="doc-block-heading">Què va aconseguir el dia 7</h2>
  <p class="doc-block-intro">El pas manual entre «algú demana alguna cosa» i «hi ha un issue a GitHub que un desenvolupador o agent pot implementar» desapareix en producció (idees públiques km0) i staging (admin help ecommerce).</p>
  <p>Push a <code>autoagents</code> a ecommerce actualitza staging en uns dos o tres minuts. Ambdós stacks comparteixen la mateixa porta: redactar el ticket automàticament, retenir validació humana, deixar que autoagents implementin quan s'aprova.</p>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Sèrie</p>
  <h2 class="doc-block-heading">Dies 1–6</h2>
  <p class="doc-closing">Les entrades anteriors cobreixen el stack (OpenCloud, Dex, LDAP, clients natius, tutorials, visió). El dia 7 afegeix el bucle de feedback: prova el <a href="/ca/ideas/">formulari d'idees</a> o revisa el <a href="/ca/doc/day-6/">dia 6</a> per a onboarding en dispositius. Dubtes: <a href="/ca/#contact">contacte</a>.</p>
</section>
