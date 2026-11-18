---
title: "Canviar la contrasenya del teu compte KM0"
description: "Canvia la contrasenya del login compartit KM0 (Cloud web, escriptori i mòbil) des de la consola de compte a Keycloak."
locale: ca
order: 12
platform: web
product: cloud
featured: true
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducció</p>
  <p class="doc-lead">La contrasenya de KM0 Cloud (navegador, escriptori OpenCloud i apps mòbils) es canvia a la consola de compte del login compartit, no dins d'OpenCloud. La contrasenya nova val per a Cloud web, OpenCloud Desktop i les apps mòbils. Necessites la contrasenya actual. El correu KM0 (mail.km0digital.com) pot continuar usant la seva pròpia contrasenya de bústia si encara no està unificada.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Pas 1</p>
  <h2 class="doc-block-heading">Obre la consola de compte KM0</h2>
  <ol class="doc-list">
    <li>Ves a <a href="https://sso.km0digital.com/realms/km0digital/account/">https://sso.km0digital.com/realms/km0digital/account/</a>.</li>
    <li>Si et demana, inicia sessió amb el correu o usuari i la <strong>contrasenya actual</strong>.</li>
    <li>Arribes a la consola de compte del teu usuari KM0.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Pas 2</p>
  <h2 class="doc-block-heading">Obre la secció d'inici de sessió</h2>
  <ol class="doc-list">
    <li>Al panell esquerre, obre <strong>Seguretat del compte</strong> (Seguridad de la cuenta / Account security).</li>
    <li>Obre <strong>Iniciant sessió</strong> (Iniciando sesión / Signing in).</li>
  </ol>
  <figure class="doc-figure">
  <img src="/tutorials/keycloak/kc-2fa-01.png" alt="Consola de compte: Seguretat del compte, Iniciando sesión, secció Contraseña" loading="lazy" />
  <figcaption>Seguretat del compte → Iniciando sesión: aquí hi ha la fila de contrasenya.</figcaption>
</figure>
</section>

<section class="doc-block">
  <p class="doc-block-title">Pas 3</p>
  <h2 class="doc-block-heading">Actualitza la contrasenya</h2>
  <ol class="doc-list">
    <li>A la fila <strong>Mi contraseña</strong> (My password), prem <strong>Update</strong> (Actualizar).</li>
    <li>Escriu la contrasenya actual quan te la demani.</li>
    <li>Escriu la contrasenya nova, confirma-la i desa els canvis.</li>
  </ol>
  <p class="doc-block-intro">Si el compte encara no tenia contrasenya configurada, el botó pot dir <strong>Configurar Contraseña</strong> en lloc d'Update.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Pas 4</p>
  <h2 class="doc-block-heading">Comprova l'accés</h2>
  <ol class="doc-list">
    <li>Tanca la sessió a Cloud o a la consola de compte.</li>
    <li>Torna a entrar a <a href="https://cloud.km0digital.com/">https://cloud.km0digital.com/</a> amb la contrasenya nova.</li>
    <li>Confirma que arribes als fitxers. Escriptori i mòbil usaran la mateixa contrasenya al proper login compartit.</li>
  </ol>
</section>

<section class="doc-block">
  <p class="doc-block-title">Notes</p>
  <h2 class="doc-block-heading">Si has oblidat la contrasenya</h2>
  <p class="doc-block-intro">Usa <strong>Forgot Password?</strong> a la pantalla d'accés del login compartit. Per activar 2FA, segueix <a href="/ca/tutorials/keycloak-2fa/">Activar 2FA al teu compte KM0</a>. No comparteixis contrasenyes al xat.</p>
</section>
