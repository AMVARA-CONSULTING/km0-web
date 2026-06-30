---
title: "Com instal·lar KM0 Cloud a macOS (aplicació web)"
description: "Instal·la KM0 Cloud com a aplicació web al Mac amb Safari (Afegir al Dock) o amb l'avís d'instal·lació d'un navegador Chromium."
locale: ca
order: 4
platform: macos
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducció</p>
  <p class="doc-lead">Aquesta guia explica com instal·lar <strong>KM0 Cloud</strong> com a aplicació web a macOS per obrir-la des del Dock o la carpeta Aplicacions, com un programa d'escriptori. No cal descarregar res de l'App Store.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Pas 1</p>
  <h2 class="doc-block-heading">Instal·lar des de Safari (Afegir al Dock)</h2>
  <ol class="doc-list">
    <li>Obre <strong>Safari</strong> al teu Mac.</li>
    <li>Ves a <a href="https://cloud.km0digital.com/">https://cloud.km0digital.com/</a> i inicia sessió si cal.</li>
    <li>A la barra de menú, tria <strong>Arxiu → Afegir al Dock…</strong> (macOS Sonoma o posterior) o <strong>Arxiu → Afegir al Dock</strong>.</li>
    <li>Confirma el nom (per exemple <strong>KM0 Cloud</strong>) i prem <strong>Afegir</strong>.</li>
  </ol>
  <p class="doc-block-intro">Documentació d'Apple: <a href="https://support.apple.com/guide/safari/add-to-dock-ibrw9e991864/mac" target="_blank" rel="noopener noreferrer">Afegir un lloc web al Dock a Safari</a> i <a href="https://support.apple.com/en-us/104996" target="_blank" rel="noopener noreferrer">Utilitzar aplicacions web de Safari al Mac</a>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Pas 2</p>
  <h2 class="doc-block-heading">Instal·lar des de Chrome, Edge o Brave (PWA)</h2>
  <ol class="doc-list">
    <li>Obre un navegador basat en Chromium (Chrome, Microsoft Edge, Brave o similar).</li>
    <li>Ves a <a href="https://cloud.km0digital.com/">https://cloud.km0digital.com/</a>.</li>
    <li>Cerca la icona d'instal·lació a la barra d'adreces (sovint un monitor amb fletxa) o obre el menú del navegador i tria <strong>Instal·lar KM0 Cloud</strong> o <strong>Instal·lar aplicació</strong>.</li>
    <li>Confirma la instal·lació quan se t'ho demanin.</li>
  </ol>
  <p class="doc-block-intro">Guies PWA: <a href="https://developer.mozilla.org/en-US/docs/Web/Progressive_web_apps/Guides/Making_PWAs_installable" target="_blank" rel="noopener noreferrer">MDN: Making PWAs installable</a> i <a href="https://web.dev/learn/pwa/installation/" target="_blank" rel="noopener noreferrer">web.dev PWA installation</a>.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Pas 3</p>
  <h2 class="doc-block-heading">On apareix l'aplicació</h2>
  <ul class="doc-list">
    <li><strong>App web de Safari:</strong> una icona nova al <strong>Dock</strong>. També la trobaràs a <strong>Aplicacions</strong> al Finder o amb Spotlight.</li>
    <li><strong>PWA de Chromium:</strong> normalment a la carpeta <strong>Aplicacions</strong> i opcionalment fixada al Dock.</li>
    <li>En obrir-la, KM0 Cloud s'executa en una finestra pròpia, separada de les pestanyes del navegador.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Pas 4</p>
  <h2 class="doc-block-heading">Eliminar o gestionar l'app instal·lada</h2>
  <ul class="doc-list">
    <li><strong>App web de Safari:</strong> clic dret a la icona del Dock → <strong>Opcions → Eliminar del Dock</strong>. Per esborrar l'arxiu, obre <strong>Aplicacions</strong> al Finder, localitza l'app web i mou-la a la Paperera.</li>
    <li><strong>PWA de Chromium:</strong> a Chrome ves a <code>chrome://apps</code>, clic dret a l'app → <strong>Eliminar de Chrome</strong>, o esborra-la des d'Aplicacions al Finder.</li>
    <li>Eliminar l'app web no suprimeix el teu compte ni els fitxers a KM0 Cloud.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Problemes freqüents</p>
  <h2 class="doc-block-heading">No apareix l'opció d'instal·lar</h2>
  <ul class="doc-list">
    <li><strong>Safari:</strong> necessites macOS Ventura 14 o posterior per a apps web. Actualitza macOS i Safari i recarrega <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a>.</li>
    <li><strong>Chromium:</strong> l'avís pot aparèixer després de visitar el lloc diverses vegades o iniciar sessió. Prova el menú del navegador → <strong>Enviar, desar i compartir</strong> → <strong>Instal·lar pàgina com a aplicació</strong> (el text varia segons el navegador).</li>
    <li><strong>Navegació privada:</strong> la instal·lació sol estar desactivada en finestres privades. Fes servir una finestra normal.</li>
    <li><strong>Mac corporatiu:</strong> la teva organització pot restringir apps web. Consulta amb IT o fes servir el navegador.</li>
  </ul>
  <p class="doc-block-intro">Sempre pots fer servir KM0 Cloud en una pestanya normal. Consulta el tutorial <a href="/ca/tutorials/getting-started-web/">Primers passos al navegador</a>.</p>
</section>
