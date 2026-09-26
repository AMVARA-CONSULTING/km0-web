---
title: "Com usar KM0 Mail a l'Outlook"
description: "Afegeix el teu correu de KM0 Mail a l'Outlook: servidors, ports i contrasenya."
locale: ca
order: 4
platform: desktop
product: mail
featured: true
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducció</p>
  <p class="doc-lead">Pots llegir i enviar el correu de KM0 Mail des de l'Outlook. Fes servir la mateixa adreça i la mateixa contrasenya que al web.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Pas 1</p>
  <h2 class="doc-block-heading">Obre Afegeix un compte</h2>
  <p class="doc-block-intro">La primera vegada, obre l'Outlook i ves a <strong>Fitxer</strong>, <strong>Compte</strong>, <strong>Afegeix un compte</strong>.</p>
  <p class="doc-block-intro">Si l'Outlook ja és obert, tria <strong>Afegeix un compte</strong>. A partir d'aquí els passos són els mateixos.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Pas 2</p>
  <h2 class="doc-block-heading">Tria IMAP</h2>
  <ol class="doc-list">
    <li>Escriu l'adreça completa, per exemple <code>usuari@km0digital.com</code>.</li>
    <li>Obre les opcions avançades.</li>
    <li>Tria <strong>IMAP</strong>.</li>
  </ol>
</section>

<section class="doc-block">
  <p class="doc-block-title">Pas 3</p>
  <h2 class="doc-block-heading">Omple els servidors</h2>
  <ul class="doc-list">
    <li>Servidor d'entrada: <code>mail.km0digital.com</code></li>
    <li>Port d'entrada: <code>993</code></li>
    <li>Xifrat d'entrada: SSL/TLS</li>
    <li>Servidor de sortida: <code>mail.km0digital.com</code></li>
    <li>Port de sortida: <code>587</code></li>
    <li>Xifrat de sortida: STARTTLS</li>
    <li>Usuari, a l'entrada i a la sortida: l'adreça completa</li>
    <li>Contrasenya: la de la bústia</li>
  </ul>
  <p class="doc-block-intro">Si l'Outlook escriu <code>smtp.km0digital.com</code> com a servidor de sortida, canvia'l per <code>mail.km0digital.com</code>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Pas 4</p>
  <h2 class="doc-block-heading">Comprova el correu</h2>
  <ol class="doc-list">
    <li>Acaba l'assistent.</li>
    <li>Obre la safata d'entrada.</li>
    <li>Envia un missatge de prova a una altra adreça.</li>
  </ol>
  <p class="doc-block-intro">Per poder enviar, el compte ha d'estar verificat. Si l'acabes de crear, segueix el tutorial de <a href="/ca/tutorials/mail-register/">crear compte</a>.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Problemes freqüents</p>
  <h2 class="doc-block-heading">Solució de problemes</h2>
  <ul class="doc-list">
    <li><strong>No entra:</strong> comprova que l'usuari sigui l'adreça completa i que la contrasenya sigui la de la bústia.</li>
    <li><strong>No surt el correu:</strong> el servidor de sortida ha de ser <code>mail.km0digital.com</code>, port 587, amb STARTTLS. Si el compte és nou, verifica la bústia.</li>
  </ul>
</section>
