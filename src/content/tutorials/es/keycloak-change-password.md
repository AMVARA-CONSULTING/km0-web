---
title: "Cambiar la contraseña de tu cuenta KM0"
description: "Cambia la contraseña del login compartido KM0 (Cloud web, escritorio y móvil) desde la consola de cuenta en Keycloak."
locale: es
order: 12
platform: web
product: cloud
featured: true
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducción</p>
  <p class="doc-lead">La contraseña de KM0 Cloud (navegador, escritorio OpenCloud y apps móviles) se cambia en la consola de cuenta del login compartido, no dentro de OpenCloud. La nueva contraseña vale para Cloud web, OpenCloud Desktop y las apps móviles. Necesitas la contraseña actual. El correo KM0 (mail.km0digital.com) puede seguir usando su propia contraseña de buzón si aún no está unificada.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Paso 1</p>
  <h2 class="doc-block-heading">Abre la consola de cuenta KM0</h2>
  <ol class="doc-list">
    <li>Ve a <a href="https://sso.km0digital.com/realms/km0digital/account/">https://sso.km0digital.com/realms/km0digital/account/</a>.</li>
    <li>Si te lo pide, inicia sesión con tu correo o usuario y la <strong>contraseña actual</strong>.</li>
    <li>Llegas a la consola de cuenta de tu usuario KM0.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Paso 2</p>
  <h2 class="doc-block-heading">Abre la sección de inicio de sesión</h2>
  <ol class="doc-list">
    <li>En el panel izquierdo, abre <strong>Seguridad de la cuenta</strong> (Account security).</li>
    <li>Abre <strong>Iniciando sesión</strong> (Signing in).</li>
  </ol>
  <figure class="doc-figure">
  <img src="/tutorials/keycloak/kc-2fa-01.png" alt="Consola de cuenta: Seguridad de la cuenta, Iniciando sesión, sección Contraseña" loading="lazy" />
  <figcaption>Seguridad de la cuenta → Iniciando sesión: aquí está la fila de contraseña.</figcaption>
</figure>
</section>

<section class="doc-block">
  <p class="doc-block-title">Paso 3</p>
  <h2 class="doc-block-heading">Actualiza tu contraseña</h2>
  <ol class="doc-list">
    <li>En la fila <strong>Mi contraseña</strong> (My password / Contraseña), pulsa <strong>Update</strong> (Actualizar).</li>
    <li>Escribe la contraseña actual cuando te la pida.</li>
    <li>Escribe la contraseña nueva, confírmala y guarda los cambios.</li>
  </ol>
  <p class="doc-block-intro">Si la cuenta aún no tenía contraseña configurada, el botón puede decir <strong>Configurar Contraseña</strong> en lugar de Update.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Paso 4</p>
  <h2 class="doc-block-heading">Comprueba el acceso</h2>
  <ol class="doc-list">
    <li>Cierra sesión en Cloud o en la consola de cuenta.</li>
    <li>Vuelve a entrar en <a href="https://cloud.km0digital.com/">https://cloud.km0digital.com/</a> con la contraseña nueva.</li>
    <li>Confirma que llegas a tus archivos. Escritorio y móvil usarán la misma contraseña en el próximo login compartido.</li>
  </ol>
</section>

<section class="doc-block">
  <p class="doc-block-title">Notas</p>
  <h2 class="doc-block-heading">Si olvidaste la contraseña</h2>
  <p class="doc-block-intro">Usa <strong>Forgot Password?</strong> en la pantalla de acceso del login compartido. Para activar 2FA, sigue <a href="/tutorials/keycloak-2fa/">Activar 2FA en tu cuenta KM0</a>. No compartas contraseñas en el chat.</p>
</section>
