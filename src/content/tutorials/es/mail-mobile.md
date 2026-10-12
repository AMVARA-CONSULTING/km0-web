---
title: "Cómo usar KM0 Mail en el móvil (Gmail y otras apps)"
description: "Añade tu correo KM0 Mail en Gmail como cuenta Other o en cualquier app móvil con IMAP."
locale: es
order: 5
platform: mobile
product: mail
featured: true
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducción</p>
  <p class="doc-lead">Puedes leer y enviar tu correo de KM0 Mail desde el móvil. En Gmail elige una cuenta <strong>Other</strong> (otra) con IMAP. El mismo método sirve en Mail de Apple, Outlook móvil, FairEmail, K-9 y otras apps.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Antes de empezar</p>
  <h2 class="doc-block-heading">Qué necesitas</h2>
  <ul class="doc-list">
    <li><strong>Una cuenta KM0 Mail:</strong> si aún no la tienes, sigue el tutorial de <a href="/tutorials/mail-register/">crear cuenta</a>.</li>
    <li><strong>Tu dirección y contraseña:</strong> la misma que usas en <a href="https://mail.km0digital.com/">mail.km0digital.com</a>.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Datos del servidor</p>
  <h2 class="doc-block-heading">IMAP y SMTP</h2>
  <p class="doc-block-intro">Usa estos valores en cualquier app. El usuario es siempre la dirección completa.</p>
  <ul class="doc-list">
    <li>Servidor de entrada (IMAP): <code>mail.km0digital.com</code></li>
    <li>Puerto de entrada: <code>993</code></li>
    <li>Cifrado de entrada: SSL/TLS</li>
    <li>Servidor de salida (SMTP): <code>mail.km0digital.com</code></li>
    <li>Puerto de salida: <code>587</code></li>
    <li>Cifrado de salida: STARTTLS</li>
    <li>Usuario: tu dirección completa, por ejemplo <code>usuario@km0digital.com</code></li>
    <li>Contraseña: la de tu buzón</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Paso 1</p>
  <h2 class="doc-block-heading">Gmail en Android</h2>
  <ol class="doc-list">
    <li>Abre la app <strong>Gmail</strong>.</li>
    <li>Pulsa tu foto o inicial (arriba a la derecha) y elige <strong>Añadir otra cuenta</strong>.</li>
    <li>Elige <strong>Other</strong> (Otra).</li>
    <li>Escribe tu dirección completa, por ejemplo <code>usuario@km0digital.com</code>, y continúa.</li>
    <li>Cuando pregunte el tipo de cuenta, elige <strong>Personal (IMAP)</strong>.</li>
    <li>Escribe la contraseña del buzón.</li>
    <li>Rellena el servidor de entrada y el de salida con los datos de arriba (puertos 993 y 587).</li>
    <li>Termina el asistente. Tu cuenta KM0 Mail aparece junto a tus otras cuentas de Gmail.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Paso 2</p>
  <h2 class="doc-block-heading">Gmail en iPhone o iPad</h2>
  <ol class="doc-list">
    <li>Abre la app <strong>Gmail</strong>.</li>
    <li>Pulsa tu foto o inicial y elige <strong>Añadir otra cuenta</strong>.</li>
    <li>Elige <strong>Other</strong> (Otra).</li>
    <li>Escribe la dirección completa y la contraseña.</li>
    <li>Elige <strong>IMAP</strong> y completa servidores, puertos y cifrado como en la tabla de arriba.</li>
    <li>Guarda la cuenta.</li>
  </ol>
  <p class="doc-block-intro">También puedes usar la app <strong>Mail</strong> de Apple: Ajustes → Mail → Cuentas → Añadir cuenta → Otro → Añadir cuenta de correo, y los mismos datos IMAP/SMTP.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Paso 3</p>
  <h2 class="doc-block-heading">Otras apps móviles</h2>
  <p class="doc-block-intro">En Outlook móvil, FairEmail, K-9 Mail u otra app IMAP:</p>
  <ol class="doc-list">
    <li>Añade una cuenta nueva y elige configuración manual o IMAP.</li>
    <li>Introduce la dirección completa y la contraseña.</li>
    <li>Usa los mismos servidores, puertos y cifrado de la sección <strong>Datos del servidor</strong>.</li>
    <li>Activa las notificaciones de la app en los ajustes del sistema si quieres avisos de correo nuevo.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Paso 4</p>
  <h2 class="doc-block-heading">Comprueba el correo y las notificaciones</h2>
  <ol class="doc-list">
    <li>Abre la bandeja de entrada de la cuenta KM0 Mail en la app.</li>
    <li>Envía un mensaje de prueba a otra dirección.</li>
    <li>Pide que te escriban un correo de prueba y confirma que llega una notificación.</li>
  </ol>
  <p class="doc-block-intro">En Gmail, las notificaciones de cuentas IMAP pueden tardar un poco más que en apps dedicadas. Si quieres avisos más rápidos, prueba FairEmail, K-9 o Mail de Apple con los mismos datos.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Problemas frecuentes</p>
  <h2 class="doc-block-heading">Solución de problemas</h2>
  <ul class="doc-list">
    <li><strong>No entra:</strong> el usuario debe ser la dirección completa y la contraseña la del buzón (no la de Google).</li>
    <li><strong>No sale el correo:</strong> servidor de salida <code>mail.km0digital.com</code>, puerto 587, STARTTLS. Si la cuenta es nueva, verifica el buzón primero.</li>
    <li><strong>Gmail sugiere Google:</strong> vuelve atrás y elige <strong>Other</strong> / <strong>Personal (IMAP)</strong>, no una cuenta Google.</li>
    <li><strong>Sin notificaciones:</strong> revisa que las notificaciones de Gmail (o de la app) estén activas para esa cuenta en los ajustes del teléfono.</li>
  </ul>
</section>
