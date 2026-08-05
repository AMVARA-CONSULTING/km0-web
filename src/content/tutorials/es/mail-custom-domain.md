---
title: "Cómo usar tu propio dominio con KM0 Mail"
description: "Añade tu dominio, publica los registros DNS, verifícalo y crea direcciones de correo propias, paso a paso."
locale: es
order: 3
platform: web
product: mail
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducción</p>
  <p class="doc-lead">Con KM0 Mail puedes recibir y enviar correo desde tu propio dominio, por ejemplo <code>nombre@tudominio.com</code>. Todo se gestiona desde el correo web, sin instalar nada.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Antes de empezar</p>
  <h2 class="doc-block-heading">Qué necesitas</h2>
  <ul class="doc-list">
    <li><strong>Una cuenta KM0 Mail:</strong> si aún no la tienes, sigue el tutorial de <a href="/tutorials/mail-register/">crear cuenta</a>.</li>
    <li><strong>Un dominio propio:</strong> el que ya tengas registrado (por ejemplo en tu proveedor de dominios).</li>
    <li><strong>Acceso a los registros DNS:</strong> el panel de tu proveedor donde se editan MX y TXT.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Paso 1</p>
  <h2 class="doc-block-heading">Abre Ajustes, Mis dominios</h2>
  <ol class="doc-list">
    <li>Inicia sesión en <a href="https://mail.km0digital.com/">https://mail.km0digital.com/</a>.</li>
    <li>Abre <strong>Ajustes</strong> y entra en la sección <strong>Mis dominios</strong>.</li>
  </ol>
  <figure class="doc-figure">
    <img src="/tutorials/mail/settings-my-domains.png" alt="Sección Mis dominios en los ajustes del correo web con el campo para añadir un dominio" />
    <figcaption>Ajustes, Mis dominios, en el correo web de KM0 Mail.</figcaption>
  </figure>
</section>

<section class="doc-block">
  <p class="doc-block-title">Paso 2</p>
  <h2 class="doc-block-heading">Añade tu dominio</h2>
  <ol class="doc-list">
    <li>Escribe tu dominio (por ejemplo <code>tudominio.com</code>).</li>
    <li>Pulsa <strong>Añadir</strong>.</li>
    <li>Aparecerá en la lista como <em>pendiente</em>, con sus registros DNS.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Paso 3</p>
  <h2 class="doc-block-heading">Publica los registros DNS</h2>
  <p class="doc-block-intro">Abre el panel de tu proveedor de dominios y copia cada registro que muestra KM0 Mail. Usa el botón <strong>Copiar</strong> para no equivocarte.</p>
  <ul class="doc-list">
    <li><strong>TXT (propiedad):</strong> confirma que el dominio es tuyo. Copia el host y el valor exactos del panel.</li>
    <li><strong>MX:</strong> dirige el correo entrante a <code>mail.km0digital.com</code> con prioridad <code>10</code>.</li>
    <li><strong>TXT (SPF):</strong> autoriza el envío: <code>v=spf1 mx a:mail.km0digital.com ~all</code>.</li>
    <li><strong>TXT (DKIM):</strong> en el host <code>mail._domainkey</code>, con la clave que muestra el panel.</li>
  </ul>
  <figure class="doc-figure">
    <img src="/tutorials/mail/dns-records.png" alt="Tabla de registros DNS TXT, MX, SPF y DKIM con su estado pendiente o correcto" />
    <figcaption>Los registros DNS y su estado en Mis dominios.</figcaption>
  </figure>
</section>

<section class="doc-block">
  <p class="doc-block-title">Paso 4</p>
  <h2 class="doc-block-heading">Verifica el dominio</h2>
  <ol class="doc-list">
    <li>Vuelve a Mis dominios y pulsa <strong>Verificar</strong>.</li>
    <li>Cada registro pasa de <em>pendiente</em> a <em>correcto</em> cuando se detecta.</li>
  </ol>
  <p class="doc-block-intro">Los cambios de DNS pueden tardar de unos minutos a 48 horas en propagarse. Si aún no aparecen, espera un poco y pulsa Verificar de nuevo.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Paso 5</p>
  <h2 class="doc-block-heading">Crea direcciones en tu dominio</h2>
  <p class="doc-block-intro">Cuando el dominio esté <em>activo</em>, ya puedes crear direcciones de correo.</p>
  <ol class="doc-list">
    <li>En tu dominio, pulsa <strong>Direcciones</strong> y luego <strong>Añadir dirección</strong>.</li>
    <li>Escribe el nombre de usuario (por ejemplo <code>hola</code>) para crear <code>hola@tudominio.com</code>.</li>
    <li>Define una contraseña para esa dirección y guarda.</li>
  </ol>
  <figure class="doc-figure">
    <img src="/tutorials/mail/add-address.png" alt="Formulario para añadir una dirección con los campos de usuario y contraseña" />
    <figcaption>Crear una dirección en el dominio verificado.</figcaption>
  </figure>
</section>

<section class="doc-block">
  <p class="doc-block-title">Paso 6</p>
  <h2 class="doc-block-heading">Inicia sesión con la nueva dirección</h2>
  <ol class="doc-list">
    <li>Ve a <a href="https://mail.km0digital.com/">https://mail.km0digital.com/</a>.</li>
    <li>Introduce la dirección completa (por ejemplo <code>hola@tudominio.com</code>) y su contraseña.</li>
    <li>Pulsa <strong>Iniciar sesión</strong>.</li>
  </ol>
  <p class="doc-block-intro">¿Necesitas ayuda para entrar? Consulta el tutorial de <a href="/tutorials/mail-sign-in/">iniciar sesión</a>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Problemas frecuentes</p>
  <h2 class="doc-block-heading">Solución de problemas</h2>
  <ul class="doc-list">
    <li><strong>La verificación no pasa:</strong> revisa que host y valor coincidan con el panel y espera a que el DNS se propague.</li>
    <li><strong>No puedo añadir direcciones:</strong> primero verifica el dominio; solo se pueden crear direcciones cuando está activo.</li>
    <li><strong>El dominio ya está en uso:</strong> otro usuario lo registró; usa un dominio del que seas propietario.</li>
  </ul>
</section>
