---
title: "Dia 12 - Xerrada amb client: experiència d'usuari"
description: "Conversa amb una usuària real sobre tutorials, accessos directes als serveis, indexació fora d'Europa, login unificat i posicionament de privacitat KM0."
pubDate: 2026-06-22
locale: ca
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducció</p>
  <p class="doc-lead">Després d'activar el <a href="/ca/doc/day-11/">KM0 Mail en producció</a>, vam mantenir una <strong>xerrada amb una clienta</strong> (Luzma) centrada en com es sent usar KM0 des de fora: on és el login, què falta explicar i quines millores petites farien la diferència sense redissenyar tot el producte.</p>
  <p class="doc-lead">Aquesta entrada no transcriu la reunió paraula per paraula; resumeix els temes accionables que van sortir i com encaixen en el roadmap immediat de km0-web i serveis relacionats.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Resum</p>
  <h2 class="doc-block-heading">Punts clau de la xerrada</h2>
  <ul class="doc-list">
    <li><strong>Experiència d'usuari:</strong> tutorials simples i visibles, no manuals llargs ni jerga tècnica.</li>
    <li><strong>Accessos directes:</strong> widget tipus «9 punts» a la web amb enllaços a cloud, mail, registre i documentació.</li>
    <li><strong>Tutorials nous:</strong> instal·lació a macOS, com compartir fitxers i vídeo curt de primers passos.</li>
    <li><strong>Indexació:</strong> millorar visibilitat en cercadors fora de la UE (navegadors com Brave amb filtres regionals).</li>
    <li><strong>Login i pagaments:</strong> un sol flux d'accés, explicació clara del pagament a la pantalla principal i retirar pàgines confuses de logout.</li>
    <li><strong>Privacitat:</strong> reforçar el missatge que KM0 no és una megaempresa ni monetitza les teves dades.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Tutorials</p>
  <h2 class="doc-block-heading">Aprendre en minuts, no en hores</h2>
  <p class="doc-block-intro">L'usuària no demanava més funcions; demanava <strong>saber per on començar</strong>. Les preguntes recurrents: «on inicio sessió?», «com instal·lo això al meu Mac?» i «com comparteixo una carpeta?».</p>
  <ul class="doc-list">
    <li><strong>Tutorial macOS:</strong> guia pas a pas per instal·lar i connectar l'app d'escriptori (issue separat a km0-web).</li>
    <li><strong>Compartir:</strong> captures o vídeo curt del flux d'invitació i permisos a OpenCloud.</li>
    <li><strong>Primers passos:</strong> vídeo d'uns minuts que recorri registre, login, pujada de fitxer i accés al webmail.</li>
    <li><strong>Ubicació del login:</strong> enllaços visibles des de la home i des del widget de serveis, no només des de subdominis.</li>
    <li><strong>Idioma:</strong> materials en castellà i català com a mínim; la web ja ofereix quatre locales.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Widget de serveis</p>
  <h2 class="doc-block-heading">Accessos directes a la pàgina principal</h2>
  <p class="doc-block-intro">Proposta concreta de la xerrada: un botó al estil de la graella de Google (nou punts) a la landing que desplegui els serveis KM0 sense memoritzar URLs.</p>
  <ul class="doc-list">
    <li><strong>Cloud:</strong> enllaç a <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a> amb registre i login.</li>
    <li><strong>Mail:</strong> accés a <a href="https://mail.km0digital.com/">mail.km0digital.com</a> per a qui ja té bústia.</li>
    <li><strong>Documentació:</strong> enllaç al <a href="/ca/doc/">blog / doc</a> i a <a href="/ca/presentation/">presentació</a> descarregable.</li>
    <li><strong>Idees i contacte:</strong> accés ràpid a <a href="/ca/ideas/">idees</a> i <a href="/ca/#contact">contacte</a>.</li>
    <li><strong>Implementació:</strong> component lleuger a km0-web; no substitueix la navegació actual, la complementa.</li>
  </ul>
  <div class="doc-callout">
    <span class="doc-callout-title">Objectiu</span>
    <p>Que algú nou trobi cloud, mail i ajuda en un clic des de la home, sense buscar al peu de pàgina ni endevinar subdominis.</p>
  </div>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Login i pagaments</p>
  <h2 class="doc-block-heading">Un sol accés, menys fricció</h2>
  <p class="doc-block-intro">Avui conviuen diversos punts d'entrada (web, app d'escriptori, Roundcube). La xerrada va deixar clar que <strong>dos logins diferents confonen</strong> i que la pantalla de pagament necessita una frase honesta abans del formulari.</p>
  <ul class="doc-list">
    <li><strong>Login unificat:</strong> mateix destí des de l'app d'escriptori i des de la web pública (treball en curs al producte).</li>
    <li><strong>Explicació de pagament:</strong> text breu a la pantalla principal de registre: què inclou el pla, quan es cobra i com cancel·lar.</li>
    <li><strong>Logout:</strong> simplificar o retirar pàgines intermèdies que deixen l'usuari en carreró sense sortida.</li>
    <li><strong>Desktop:</strong> l'app ha d'obrir el mateix SSO que el navegador, no un formulari paral·lel.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Indexació i privacitat</p>
  <h2 class="doc-block-heading">Trobar-nos fora d'Europa i dir qui som</h2>
  <p class="doc-block-intro">Part de la conversa va girar entorn de cercadors amb filtres regionals (per exemple Brave) i de la necessitat que km0digital aparegui quan algú busca alternatives privades al cloud gran.</p>
  <ul class="doc-list">
    <li><strong>SEO internacional:</strong> hreflang, sitemap i metadades ja a km0-web; seguir millorant títols i descripcions per locale (veure issue #58).</li>
    <li><strong>Contingut útil:</strong> entrades del blog com aquesta ajuden a indexació orgànica sense campanyes de pagament.</li>
    <li><strong>Missatge de privacitat:</strong> KM0 no és una ultraempresa; no venem perfils ni entrenem models amb els teus fitxers.</li>
    <li><strong>Transparència:</strong> pàgines <a href="/ca/legal/">legal</a> i <a href="/ca/security/">seguretat</a> enllaçades des de tutorials i widget.</li>
    <li><strong>Radar:</strong> preferim créixer per recomanació i associacions (tema del <a href="/ca/doc/day-13/">dia 13</a>) que per soroll publicitari.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Roadmap</p>
  <h2 class="doc-block-heading">Què ve després d'aquesta xerrada</h2>
  <ol class="doc-steps">
    <li><strong>Widget de serveis</strong> a la landing de km0-web.</li>
    <li><strong>Tutorial macOS</strong> i guia de compartir a doc o vídeo incrustat.</li>
    <li><strong>Millores SEO</strong> i indexació fora de la UE (issue #58).</li>
    <li><strong>Login unificat</strong> i copy de pagament al registre OpenCloud.</li>
    <li><strong>Vídeo de primers passos</strong> enllaçat des de la home i el blog.</li>
  </ol>
  <p>La majoria són canvis petits acumulats; junts redueixen la fricció que una usuària real va descriure a la xerrada.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Verificació</p>
  <h2 class="doc-block-heading">Provar el que ja existeix</h2>
  <ol class="doc-steps">
    <li><strong>Home:</strong> obrir <a href="/ca/">km0digital.com</a> i localitzar enllaços a cloud, mail i doc.</li>
    <li><strong>Cloud:</strong> registre de prova a <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a>.</li>
    <li><strong>Mail:</strong> webmail a <a href="https://mail.km0digital.com/">mail.km0digital.com</a> si tens bústia.</li>
    <li><strong>Doc:</strong> llegir <a href="/ca/doc/day-11/">dia 11</a> (mail) i <a href="/ca/doc/day-13/">dia 13</a> (meet 6).</li>
    <li><strong>Feedback:</strong> enviar millores per <a href="/ca/ideas/">idees</a> o <a href="/ca/#contact">contacte</a>.</li>
  </ol>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Sèrie</p>
  <h2 class="doc-block-heading">Entrades relacionades</h2>
  <p class="doc-closing">El <a href="/ca/doc/day-11/">dia 11</a> va documentar KM0 Mail; aquesta xerrada (dia 12) recull UX i accessibilitat; el <a href="/ca/doc/day-13/">dia 13</a> resumeix el meet 6 sobre visibilitat i associacions. Prova el <a href="https://mail.km0digital.com/">webmail</a>, consulta <a href="/ca/pricing/">preus</a> i explica'ns quin tutorial et faria falta.</p>
</section>
