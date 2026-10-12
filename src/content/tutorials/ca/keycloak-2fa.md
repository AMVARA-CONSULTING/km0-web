---
title: "Activar 2FA al teu compte KM0"
description: "Activa l'autenticació en dos factors a la consola de compte KM0 del login compartit de Cloud web, escriptori i mòbil."
locale: ca
order: 10
platform: web
product: cloud
featured: true
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducció</p>
  <p class="doc-lead">L'autenticació en dos factors (2FA) demana un codi d'una app autenticadora després de la contrasenya. Protegeix el mateix login KM0 de Cloud al navegador, escriptori i mòbil. Es configura a la consola de compte KM0. Necessites un telèfon amb una app autenticadora (per exemple Google Authenticator, FreeOTP o Microsoft Authenticator).</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Pas 1</p>
  <h2 class="doc-block-heading">Obre la consola de compte KM0</h2>
  <ol class="doc-list">
    <li>Ves a <a href="https://sso.km0digital.com/realms/km0digital/account">https://sso.km0digital.com/realms/km0digital/account</a>.</li>
    <li>Si no has iniciat sessió, completa el login KM0 compartit (correu o usuari i contrasenya).</li>
    <li>Arribes a la consola de compte del teu usuari KM0.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Pas 2</p>
  <h2 class="doc-block-heading">Obre l'autenticació de dos factors</h2>
  <ol class="doc-list">
    <li>Al menú lateral, obre <strong>Seguretat del compte</strong> (Seguridad de la cuenta).</li>
    <li>Obre <strong>Iniciant sessió</strong> (Iniciando sesión).</li>
    <li>A <strong>Autenticació de dos factors</strong>, prem <strong>Configurar Aplicació autenticadora</strong>.</li>
  </ol>
  <figure class="doc-figure">
  <img src="/tutorials/keycloak/kc-2fa-01.png" alt="Pàgina Iniciando sesión amb la secció d'autenticació de dos factors" loading="lazy" />
  <figcaption>Seguretat del compte → Iniciando sesión: configurar l'aplicació autenticadora.</figcaption>
</figure>
</section>

<section class="doc-block">
  <p class="doc-block-title">Pas 3</p>
  <h2 class="doc-block-heading">Vincula l'app autenticadora</h2>
  <ol class="doc-list">
    <li>Instal·la una app autenticadora al telèfon si encara no en tens.</li>
    <li>Escaneja el codi QR de <strong>Mobile Authenticator Setup</strong> (a la captura pública el QR va difuminat a propòsit).</li>
    <li>Introdueix el codi d'un sol ús, posa un nom de dispositiu si vols i prem <strong>Submit</strong>.</li>
    <li>Si el flux ofereix codis de recuperació, desa'ls fora de línia en un lloc segur.</li>
  </ol>
  <figure class="doc-figure">
  <img src="/tutorials/keycloak/kc-2fa-02.png" alt="Pantalla Mobile Authenticator Setup amb l'àrea del QR difuminada" loading="lazy" />
  <figcaption>Mobile Authenticator Setup: escaneja el QR, introdueix el codi i Submit.</figcaption>
</figure>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Pas 4</p>
  <h2 class="doc-block-heading">Comprova un accés nou</h2>
  <ol class="doc-list">
    <li>Tanca la sessió a Cloud (o a la consola de compte).</li>
    <li>Torna a entrar a <a href="https://cloud.km0digital.com/">https://cloud.km0digital.com/</a> amb contrasenya i després el codi de l'autenticadora.</li>
    <li>Confirma que arribes als fitxers.</li>
  </ol>
  <p class="doc-block-intro">Escriptori i mòbil demanaran el mateix segon factor quan obrin el login compartit.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Notes</p>
  <h2 class="doc-block-heading">Si perds el telèfon</h2>
  <p class="doc-block-intro">Usa un codi de recuperació si el vas desar. Si no tens via de recuperació, contacta amb el suport KM0 pel formulari de <a href="/ca/#contact">contacte</a> del lloc i demostra la titularitat del compte. No comparteixis contrasenyes al xat.</p>
</section>
