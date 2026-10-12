---
title: "Activar 2FA en tu cuenta KM0"
description: "Activa la autenticación en dos factores en la consola de cuenta KM0 del login compartido de Cloud web, escritorio y móvil."
locale: es
order: 10
platform: web
product: cloud
featured: true
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducción</p>
  <p class="doc-lead">La autenticación en dos factores (2FA) pide un código de una app autenticadora después de la contraseña. Protege el mismo login KM0 de Cloud en el navegador, escritorio y móvil. Se configura en la consola de cuenta KM0. Necesitas un teléfono con una app autenticadora (por ejemplo Google Authenticator, FreeOTP o Microsoft Authenticator).</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Paso 1</p>
  <h2 class="doc-block-heading">Abre la consola de cuenta KM0</h2>
  <ol class="doc-list">
    <li>Ve a <a href="https://sso.km0digital.com/realms/km0digital/account">https://sso.km0digital.com/realms/km0digital/account</a>.</li>
    <li>Si no has iniciado sesión, completa el login KM0 compartido (correo o usuario y contraseña).</li>
    <li>Llegas a la consola de cuenta de tu usuario KM0.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Paso 2</p>
  <h2 class="doc-block-heading">Abre la autenticación de dos factores</h2>
  <ol class="doc-list">
    <li>En el menú lateral, abre <strong>Seguridad de la cuenta</strong>.</li>
    <li>Abre <strong>Iniciando sesión</strong>.</li>
    <li>En <strong>Autenticación de dos factores</strong>, pulsa <strong>Configurar Aplicación autenticadora</strong>.</li>
  </ol>
  <figure class="doc-figure">
  <img src="/tutorials/keycloak/kc-2fa-01.png" alt="Página Iniciando sesión con la sección de autenticación de dos factores" loading="lazy" />
  <figcaption>Seguridad de la cuenta → Iniciando sesión: configurar la aplicación autenticadora.</figcaption>
</figure>
</section>

<section class="doc-block">
  <p class="doc-block-title">Paso 3</p>
  <h2 class="doc-block-heading">Vincula tu app autenticadora</h2>
  <ol class="doc-list">
    <li>Instala una app autenticadora en el teléfono si aún no tienes una.</li>
    <li>Escanea el código QR de <strong>Mobile Authenticator Setup</strong> (en la captura pública el QR va difuminado a propósito).</li>
    <li>Introduce el código de un solo uso, pon un nombre de dispositivo si quieres y pulsa <strong>Submit</strong>.</li>
    <li>Si el flujo ofrece códigos de recuperación, guárdalos sin conexión en un sitio seguro.</li>
  </ol>
  <figure class="doc-figure">
  <img src="/tutorials/keycloak/kc-2fa-02.png" alt="Pantalla Mobile Authenticator Setup con el área del QR difuminada" loading="lazy" />
  <figcaption>Mobile Authenticator Setup: escanea el QR, introduce el código y Submit.</figcaption>
</figure>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Paso 4</p>
  <h2 class="doc-block-heading">Comprueba un acceso nuevo</h2>
  <ol class="doc-list">
    <li>Cierra sesión en Cloud (o en la consola de cuenta).</li>
    <li>Vuelve a entrar en <a href="https://cloud.km0digital.com/">https://cloud.km0digital.com/</a> con contraseña y luego el código de la autenticadora.</li>
    <li>Confirma que llegas a tus archivos.</li>
  </ol>
  <p class="doc-block-intro">Escritorio y móvil pedirán el mismo segundo factor cuando abran el login compartido.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Notas</p>
  <h2 class="doc-block-heading">Si pierdes el teléfono</h2>
  <p class="doc-block-intro">Usa un código de recuperación si lo guardaste. Si no tienes vía de recuperación, contacta con soporte KM0 por el formulario de <a href="/#contact">contacto</a> del sitio y demuestra la titularidad de la cuenta. No compartas contraseñas en el chat.</p>
</section>
