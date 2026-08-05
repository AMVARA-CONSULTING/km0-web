---
title: "Com fer servir el teu propi domini amb KM0 Mail"
description: "Afegeix el teu domini, publica els registres DNS, verifica'l i crea adreces de correu pròpies, pas a pas."
locale: ca
order: 3
platform: web
product: mail
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducció</p>
  <p class="doc-lead">Amb KM0 Mail pots rebre i enviar correu des del teu propi domini, per exemple <code>nom@elteudomini.com</code>. Tot es gestiona des del correu web, sense instal·lar res.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Abans de començar</p>
  <h2 class="doc-block-heading">Què necessites</h2>
  <ul class="doc-list">
    <li><strong>Un compte KM0 Mail:</strong> si encara no en tens, segueix el tutorial de <a href="/ca/tutorials/mail-register/">crear compte</a>.</li>
    <li><strong>Un domini propi:</strong> el que ja tinguis registrat (per exemple al teu proveïdor de dominis).</li>
    <li><strong>Accés als registres DNS:</strong> el panell del teu proveïdor on s'editen MX i TXT.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Pas 1</p>
  <h2 class="doc-block-heading">Obre Configuració, Els meus dominis</h2>
  <ol class="doc-list">
    <li>Inicia sessió a <a href="https://mail.km0digital.com/">https://mail.km0digital.com/</a>.</li>
    <li>Obre <strong>Configuració</strong> i entra a la secció <strong>Els meus dominis</strong>.</li>
  </ol>
</section>

<section class="doc-block">
  <p class="doc-block-title">Pas 2</p>
  <h2 class="doc-block-heading">Afegeix el teu domini</h2>
  <ol class="doc-list">
    <li>Escriu el teu domini (per exemple <code>elteudomini.com</code>).</li>
    <li>Prem <strong>Afegeix</strong>.</li>
    <li>Apareixerà a la llista com a <em>pendent</em>, amb els seus registres DNS.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Pas 3</p>
  <h2 class="doc-block-heading">Publica els registres DNS</h2>
  <p class="doc-block-intro">Obre el panell del teu proveïdor de dominis i copia cada registre que mostra KM0 Mail. Fes servir el botó <strong>Copia</strong> per no equivocar-te.</p>
  <ul class="doc-list">
    <li><strong>TXT (propietat):</strong> confirma que el domini és teu. Copia el host i el valor exactes del panell.</li>
    <li><strong>MX:</strong> dirigeix el correu entrant a <code>mail.km0digital.com</code> amb prioritat <code>10</code>.</li>
    <li><strong>TXT (SPF):</strong> autoritza l'enviament: <code>v=spf1 mx a:mail.km0digital.com ~all</code>.</li>
    <li><strong>TXT (DKIM):</strong> al host <code>mail._domainkey</code>, amb la clau que mostra el panell.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Pas 4</p>
  <h2 class="doc-block-heading">Verifica el domini</h2>
  <ol class="doc-list">
    <li>Torna a Els meus dominis i prem <strong>Verifica</strong>.</li>
    <li>Cada registre passa de <em>pendent</em> a <em>correcte</em> quan es detecta.</li>
  </ol>
  <p class="doc-block-intro">Els canvis de DNS poden trigar d'uns minuts a 48 hores a propagar-se. Si encara no apareixen, espera una mica i torna a prémer Verifica.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Pas 5</p>
  <h2 class="doc-block-heading">Crea adreces al teu domini</h2>
  <p class="doc-block-intro">Quan el domini estigui <em>actiu</em>, ja pots crear adreces de correu.</p>
  <ol class="doc-list">
    <li>Al teu domini, prem <strong>Adreces</strong> i després <strong>Afegeix adreça</strong>.</li>
    <li>Escriu el nom d'usuari (per exemple <code>hola</code>) per crear <code>hola@elteudomini.com</code>.</li>
    <li>Defineix una contrasenya per a aquella adreça i desa.</li>
  </ol>
</section>

<section class="doc-block">
  <p class="doc-block-title">Pas 6</p>
  <h2 class="doc-block-heading">Inicia sessió amb la nova adreça</h2>
  <ol class="doc-list">
    <li>Ves a <a href="https://mail.km0digital.com/">https://mail.km0digital.com/</a>.</li>
    <li>Introdueix l'adreça completa (per exemple <code>hola@elteudomini.com</code>) i la seva contrasenya.</li>
    <li>Prem <strong>Inicia sessió</strong>.</li>
  </ol>
  <p class="doc-block-intro">Necessites ajuda per entrar? Consulta el tutorial d'<a href="/ca/tutorials/mail-sign-in/">iniciar sessió</a>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Problemes freqüents</p>
  <h2 class="doc-block-heading">Solució de problemes</h2>
  <ul class="doc-list">
    <li><strong>La verificació no passa:</strong> revisa que host i valor coincideixin amb el panell i espera que el DNS es propagui.</li>
    <li><strong>No puc afegir adreces:</strong> primer verifica el domini; només es poden crear adreces quan està actiu.</li>
    <li><strong>El domini ja està en ús:</strong> un altre usuari el va registrar; fes servir un domini del qual siguis propietari.</li>
  </ul>
</section>
