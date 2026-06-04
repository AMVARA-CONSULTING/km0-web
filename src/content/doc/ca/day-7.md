---
title: "Dia 7 - De la petició al ticket, automatitzat"
description: "Automatització de punta a punta: el formulari d'idees i Admin Help converteixen peticions en tickets clars, amb revisió humana abans d'implementar."
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
  <p class="doc-block-title">Per què encaixa</p>
  <h2 class="doc-block-heading">Una solució pràctica per a equips petits</h2>
  <p class="doc-block-intro">No buscàvem automatitzar per moda. Volíem que una petició útil no es perdés entre un xat, un correu i el cap de qui la rebia. El sistema converteix cada enviament en un ticket llegible, amb context i abast, en pocs segons.</p>
  <ul class="doc-list">
    <li><strong>Rapidesa:</strong> qui escriu no espera que algú trobi un forat per redactar la incidència.</li>
    <li><strong>Qualitat:</strong> l'esborrany segueix sempre la mateixa estructura (què passa, per a qui, què s'espera).</li>
    <li><strong>Control:</strong> res entra en desenvolupament sense passar per una persona de l'equip.</li>
    <li><strong>Reutilitzable:</strong> el mateix patró serveix per a feedback públic i per a peticions internes.</li>
  </ul>
  <p>Per a KM0 encaixa especialment bé: rebem idees de gent no tècnica i les volem tractar amb el mateix rigor que un informe d'un administrador de botiga online.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">On s'aplica</p>
  <h2 class="doc-block-heading">Dues portes d'entrada, un recorregut</h2>
  <ul class="doc-list">
    <li><strong>Qui fa servir KM0:</strong> el formulari <a href="/ca/ideas/">Idees</a> a km0digital.com. Suggeriments de producte, millores de la web o coses que trobes a faltar en usar el cloud.</li>
    <li><strong>Qui opera un projecte intern:</strong> la pantalla Admin Help d'una botiga online en staging. Quan algú de l'equip veu una fallada o necessita un canvi i vol deixar-ho registrat amb traçabilitat.</li>
  </ul>
  <p>En ambdós casos el recorregut és el mateix: formulari → cua → ticket redactat → revisió humana → implementació. Canvia qui escriu i on, no la lògica.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Exemples</p>
  <h2 class="doc-block-heading">Com es veu a la pràctica</h2>
  <p class="doc-block-intro">Imagina que algú envia des de <a href="/ca/ideas/">Idees</a>: «M'agradaria un botó per compartir entrades del blog». En uns quinze segons el sistema genera un ticket titulat i ordenat: què demana la persona, en quin idioma ha escrit, quina part del lloc toca. Apareix marcat com a <em>pendent de validació humana</em>.</p>
  <p>Algú de l'equip el llegeix. Si el text està bé, treu la marca i el ticket passa a la cua d'implementació automàtica. Si cal matisar («només en mòbil», «icona de WhatsApp»), s'edita el ticket abans d'aprovar-lo. Sense tornar a copiar el missatge original a mà.</p>
  <p>Un altre cas: un administrador de la botiga en staging informa des d'Admin Help que un filtre de productes no desa bé. Mateixa mecànica: ticket clar, revisió, i només llavors entra en el flux de desenvolupament. L'objectiu és que ningú hagi d'endevinar què volia dir qui va escriure.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Persones</p>
  <h2 class="doc-block-heading">Què fa (i què no) l'automatització</h2>
  <p class="doc-block-intro">La màquina redacta i classifica. La persona decideix. Els agents de desenvolupament no recullen tickets mentre segueixin marcats com a pendents de validació: així evitem implementar a cegues un missatge ambigu o una broma.</p>
  <p>Per a qui envia una idea, el benefici és simple: escrius una vegada en llenguatge normal i l'equip rep alguna cosa accionable. Per a qui manté el servei, el benefici és deixar de ser el traductor permanent entre «missatge de WhatsApp» i «ticket ben escrit».</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Resultat</p>
  <h2 class="doc-block-heading">Què va aconseguir el dia 7</h2>
  <p class="doc-block-intro">El pas manual entre «algú demana alguna cosa» i «hi ha un ticket que es pot implementar» desapareix en producció (idees públiques de KM0) i a l'entorn de proves de l'ecommerce (Admin Help).</p>
  <p>Avui el cicle complet funciona: petició, ticket redactat, validació humana i implementació assistida per agents. És la peça que faltava per tancar el cercle entre escoltar la comunitat i lliurar canvis amb criteri.</p>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Sèrie</p>
  <h2 class="doc-block-heading">Dies 1–6</h2>
  <p class="doc-closing">Les entrades anteriors cobreixen el stack (OpenCloud, Dex, LDAP, clients natius, tutorials, visió). El dia 7 afegeix el bucle de feedback: prova el <a href="/ca/ideas/">formulari d'idees</a> o revisa el <a href="/ca/doc/day-6/">dia 6</a> per a onboarding en dispositius. Dubtes: <a href="/ca/#contact">contacte</a>.</p>
</section>
