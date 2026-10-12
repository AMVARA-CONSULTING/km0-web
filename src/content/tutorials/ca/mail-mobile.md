---
title: "Com usar KM0 Mail al mòbil (Gmail i altres apps)"
description: "Afegeix el teu correu KM0 Mail a Gmail com a compte Other o a qualsevol app mòbil amb IMAP."
locale: ca
order: 5
platform: mobile
product: mail
featured: true
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducció</p>
  <p class="doc-lead">Pots llegir i enviar el correu de KM0 Mail des del mòbil. A Gmail tria un compte <strong>Other</strong> (altra) amb IMAP. El mateix mètode serveix a Mail d'Apple, Outlook mòbil, FairEmail, K-9 i altres apps.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Abans de començar</p>
  <h2 class="doc-block-heading">Què necessites</h2>
  <ul class="doc-list">
    <li><strong>Un compte KM0 Mail:</strong> si encara no en tens, segueix el tutorial de <a href="/ca/tutorials/mail-register/">crear compte</a>.</li>
    <li><strong>L'adreça i la contrasenya:</strong> les mateixes que fas servir a <a href="https://mail.km0digital.com/">mail.km0digital.com</a>.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Dades del servidor</p>
  <h2 class="doc-block-heading">IMAP i SMTP</h2>
  <p class="doc-block-intro">Fes servir aquests valors a qualsevol app. L'usuari és sempre l'adreça completa.</p>
  <ul class="doc-list">
    <li>Servidor d'entrada (IMAP): <code>mail.km0digital.com</code></li>
    <li>Port d'entrada: <code>993</code></li>
    <li>Xifrat d'entrada: SSL/TLS</li>
    <li>Servidor de sortida (SMTP): <code>mail.km0digital.com</code></li>
    <li>Port de sortida: <code>587</code></li>
    <li>Xifrat de sortida: STARTTLS</li>
    <li>Usuari: l'adreça completa, per exemple <code>usuari@km0digital.com</code></li>
    <li>Contrasenya: la de la bústia</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Pas 1</p>
  <h2 class="doc-block-heading">Gmail a Android</h2>
  <ol class="doc-list">
    <li>Obre l'app <strong>Gmail</strong>.</li>
    <li>Toca la foto o la inicial (a dalt a la dreta) i tria <strong>Afegeix un altre compte</strong>.</li>
    <li>Tria <strong>Other</strong> (Altra).</li>
    <li>Escriu l'adreça completa, per exemple <code>usuari@km0digital.com</code>, i continua.</li>
    <li>Quan pregunti el tipus de compte, tria <strong>Personal (IMAP)</strong>.</li>
    <li>Escriu la contrasenya de la bústia.</li>
    <li>Omple el servidor d'entrada i el de sortida amb les dades de dalt (ports 993 i 587).</li>
    <li>Acaba l'assistent. El compte KM0 Mail apareix al costat dels altres comptes de Gmail.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Pas 2</p>
  <h2 class="doc-block-heading">Gmail a iPhone o iPad</h2>
  <ol class="doc-list">
    <li>Obre l'app <strong>Gmail</strong>.</li>
    <li>Toca la foto o la inicial i tria <strong>Afegeix un altre compte</strong>.</li>
    <li>Tria <strong>Other</strong> (Altra).</li>
    <li>Escriu l'adreça completa i la contrasenya.</li>
    <li>Tria <strong>IMAP</strong> i completa servidors, ports i xifrat com a la taula de dalt.</li>
    <li>Desa el compte.</li>
  </ol>
  <p class="doc-block-intro">També pots fer servir l'app <strong>Mail</strong> d'Apple: Ajustos → Mail → Comptes → Afegeix un compte → Un altre → Afegeix un compte de correu, amb les mateixes dades IMAP/SMTP.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Pas 3</p>
  <h2 class="doc-block-heading">Altres apps mòbils</h2>
  <p class="doc-block-intro">A Outlook mòbil, FairEmail, K-9 Mail o una altra app IMAP:</p>
  <ol class="doc-list">
    <li>Afegeix un compte nou i tria configuració manual o IMAP.</li>
    <li>Introdueix l'adreça completa i la contrasenya.</li>
    <li>Fes servir els mateixos servidors, ports i xifrat de la secció <strong>Dades del servidor</strong>.</li>
    <li>Activa les notificacions de l'app als ajustos del sistema si vols avisos de correu nou.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Pas 4</p>
  <h2 class="doc-block-heading">Comprova el correu i les notificacions</h2>
  <ol class="doc-list">
    <li>Obre la safata d'entrada del compte KM0 Mail a l'app.</li>
    <li>Envia un missatge de prova a una altra adreça.</li>
    <li>Demana que et escriguin un correu de prova i confirma que arriba una notificació.</li>
  </ol>
  <p class="doc-block-intro">A Gmail, les notificacions de comptes IMAP poden trigar una mica més que a apps dedicades. Si vols avisos més ràpids, prova FairEmail, K-9 o Mail d'Apple amb les mateixes dades.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Problemes freqüents</p>
  <h2 class="doc-block-heading">Solució de problemes</h2>
  <ul class="doc-list">
    <li><strong>No entra:</strong> l'usuari ha de ser l'adreça completa i la contrasenya la de la bústia (no la de Google).</li>
    <li><strong>No surt el correu:</strong> servidor de sortida <code>mail.km0digital.com</code>, port 587, STARTTLS. Si el compte és nou, verifica la bústia primer.</li>
    <li><strong>Gmail suggereix Google:</strong> torna enrere i tria <strong>Other</strong> / <strong>Personal (IMAP)</strong>, no un compte Google.</li>
    <li><strong>Sense notificacions:</strong> comprova que les notificacions de Gmail (o de l'app) estiguin actives per a aquest compte als ajustos del telèfon.</li>
  </ul>
</section>
