---
title: "Tornar a iniciar sessió a OpenCloud Desktop després del login compartit"
description: "Reconnecta el client d'escriptori OpenCloud a KM0 Cloud amb el login compartit: URL del servidor, accés al navegador i carpeta de sync."
locale: ca
order: 11
platform: desktop
product: cloud
featured: true
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducció</p>
  <p class="doc-lead">Després del login KM0 compartit, el client d'escriptori OpenCloud pot necessitar una connexió de compte nova. Aquesta guia segueix l'assistent Afegeix compte: adreça del servidor, login al navegador i carpeta de sync. Prefereix reconnectar la carpeta local que ja uses. L'adreça del servidor continua sent <code>https://cloud.km0digital.com/</code>.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Pas 1</p>
  <h2 class="doc-block-heading">Introdueix l'adreça del servidor Cloud</h2>
  <ol class="doc-list">
    <li>Obre OpenCloud Desktop.</li>
    <li>Si afegeixes o reconnectes un compte, veuràs <strong>Welcome</strong> i <strong>What is your server's address?</strong>.</li>
    <li>Escriu exactament <code>https://cloud.km0digital.com/</code> (amb <code>https://</code>, sense espais de més).</li>
    <li>Prem <strong>Next</strong>.</li>
  </ol>
  <figure class="doc-figure">
  <img src="/tutorials/desktop/oc-desktop-01.png" alt="OpenCloud Desktop Welcome amb l'adreça del servidor Cloud" loading="lazy" />
  <figcaption>Welcome: adreça del servidor https://cloud.km0digital.com/</figcaption>
</figure>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Pas 2</p>
  <h2 class="doc-block-heading">Inicia sessió amb el navegador</h2>
  <ol class="doc-list">
    <li>A <strong>Log in with your web browser</strong>, prem <strong>Open web browser</strong>.</li>
    <li>Completa el login KM0 compartit (contrasenya i 2FA si està activa).</li>
    <li>Torna al client d'escriptori quan passi a les opcions de sync.</li>
  </ol>
  <figure class="doc-figure">
  <img src="/tutorials/desktop/oc-desktop-01-browser.png" alt="OpenCloud Desktop demanant obrir el navegador per al login" loading="lazy" />
  <figcaption>Pas Login: Open web browser per a l'accés KM0 compartit.</figcaption>
</figure>
</section>

<section class="doc-block">
  <p class="doc-block-title">Pas 3</p>
  <h2 class="doc-block-heading">Tria la carpeta de sync</h2>
  <ol class="doc-list">
    <li>Quan vegis <strong>You're all set!</strong>, obre <strong>Advanced configuration</strong> si cal triar la carpeta.</li>
    <li>Confirma que el directori local és el que ja feies servir (evita crear una segona còpia per error).</li>
    <li>Tria com sincronitzar els spaces i prem <strong>Finish</strong>.</li>
  </ol>
  <p class="doc-block-intro">Si el client ofereix una carpeta buida nova i ja en tens una plena, para i <a href="/ca/#contact">contacta'ns</a> abans d'acceptar.</p>
  <figure class="doc-figure">
  <img src="/tutorials/desktop/oc-desktop-02.png" alt="OpenCloud Desktop opcions de sync triant el directori local" loading="lazy" />
  <figcaption>Sync Options: tria la carpeta local i Finish.</figcaption>
</figure>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Relacionat</p>
  <h2 class="doc-block-heading">Més ajuda</h2>
  <ul class="doc-list">
    <li><a href="/ca/tutorials/keycloak-sign-in-cloud/">Iniciar sessió a KM0 Cloud amb el login compartit</a> (navegador).</li>
    <li><a href="/ca/tutorials/desktop-sync/">Com funciona el sync d'escriptori a KM0 Cloud</a>.</li>
  </ul>
</section>
