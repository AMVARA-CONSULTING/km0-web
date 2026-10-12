---
title: "Volver a iniciar sesión en OpenCloud Desktop tras el login compartido"
description: "Reconecta el cliente de escritorio OpenCloud a KM0 Cloud con el login compartido: URL del servidor, acceso en el navegador y carpeta de sync."
locale: es
order: 11
platform: desktop
product: cloud
featured: true
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducción</p>
  <p class="doc-lead">Tras el login KM0 compartido, el cliente de escritorio OpenCloud puede necesitar una conexión de cuenta nueva. Esta guía sigue el asistente Añadir cuenta: dirección del servidor, login en el navegador y carpeta de sync. Prefiere reconectar la carpeta local que ya usas. La dirección del servidor sigue siendo <code>https://cloud.km0digital.com/</code>.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Paso 1</p>
  <h2 class="doc-block-heading">Introduce la dirección del servidor Cloud</h2>
  <ol class="doc-list">
    <li>Abre OpenCloud Desktop.</li>
    <li>Si añades o reconectas una cuenta, verás <strong>Welcome</strong> y <strong>What is your server's address?</strong>.</li>
    <li>Escribe exactamente <code>https://cloud.km0digital.com/</code> (con <code>https://</code>, sin espacios de más).</li>
    <li>Pulsa <strong>Next</strong>.</li>
  </ol>
  <figure class="doc-figure">
  <img src="/tutorials/desktop/oc-desktop-01.png" alt="OpenCloud Desktop Welcome con la dirección del servidor Cloud" loading="lazy" />
  <figcaption>Welcome: dirección del servidor https://cloud.km0digital.com/</figcaption>
</figure>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Paso 2</p>
  <h2 class="doc-block-heading">Inicia sesión con el navegador</h2>
  <ol class="doc-list">
    <li>En <strong>Log in with your web browser</strong>, pulsa <strong>Open web browser</strong>.</li>
    <li>Completa el login KM0 compartido (contraseña y 2FA si está activa).</li>
    <li>Vuelve al cliente de escritorio cuando pase a las opciones de sync.</li>
  </ol>
  <figure class="doc-figure">
  <img src="/tutorials/desktop/oc-desktop-01-browser.png" alt="OpenCloud Desktop pidiendo abrir el navegador para el login" loading="lazy" />
  <figcaption>Paso Login: Open web browser para el acceso KM0 compartido.</figcaption>
</figure>
</section>

<section class="doc-block">
  <p class="doc-block-title">Paso 3</p>
  <h2 class="doc-block-heading">Elige la carpeta de sync</h2>
  <ol class="doc-list">
    <li>Cuando veas <strong>You're all set!</strong>, abre <strong>Advanced configuration</strong> si necesitas elegir la carpeta.</li>
    <li>Confirma que el directorio local es el que ya usabas (evita crear una segunda copia por error).</li>
    <li>Elige cómo sincronizar los spaces y pulsa <strong>Finish</strong>.</li>
  </ol>
  <p class="doc-block-intro">Si el cliente ofrece una carpeta vacía nueva y ya tienes una llena, para y <a href="/#contact">contáctanos</a> antes de aceptar.</p>
  <figure class="doc-figure">
  <img src="/tutorials/desktop/oc-desktop-02.png" alt="OpenCloud Desktop opciones de sync eligiendo el directorio local" loading="lazy" />
  <figcaption>Sync Options: elige la carpeta local y Finish.</figcaption>
</figure>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Relacionado</p>
  <h2 class="doc-block-heading">Más ayuda</h2>
  <ul class="doc-list">
    <li><a href="/tutorials/keycloak-sign-in-cloud/">Iniciar sesión en KM0 Cloud con el login compartido</a> (navegador).</li>
    <li><a href="/tutorials/desktop-sync/">Cómo funciona el sync de escritorio en KM0 Cloud</a>.</li>
  </ul>
</section>
