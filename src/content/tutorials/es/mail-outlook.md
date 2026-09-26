---
title: "Cómo usar KM0 Mail en Outlook"
description: "Añade tu correo de KM0 Mail a Outlook: servidores, puertos y contraseña."
locale: es
order: 4
platform: desktop
product: mail
featured: true
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducción</p>
  <p class="doc-lead">Puedes leer y enviar tu correo de KM0 Mail desde Outlook. Usa la misma dirección y la misma contraseña que en la web.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Paso 1</p>
  <h2 class="doc-block-heading">Abre Agregar cuenta</h2>
  <p class="doc-block-intro">La primera vez, abre Outlook y ve a <strong>Archivo</strong>, <strong>Cuenta</strong>, <strong>Agregar cuenta</strong>.</p>
  <p class="doc-block-intro">Si Outlook ya está abierto, elige <strong>Agregar cuenta</strong>. A partir de ahí los pasos son los mismos.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Paso 2</p>
  <h2 class="doc-block-heading">Elige IMAP</h2>
  <ol class="doc-list">
    <li>Escribe tu dirección completa, por ejemplo <code>usuario@km0digital.com</code>.</li>
    <li>Abre las opciones avanzadas.</li>
    <li>Elige <strong>IMAP</strong>.</li>
  </ol>
</section>

<section class="doc-block">
  <p class="doc-block-title">Paso 3</p>
  <h2 class="doc-block-heading">Rellena los servidores</h2>
  <ul class="doc-list">
    <li>Servidor de entrada: <code>mail.km0digital.com</code></li>
    <li>Puerto de entrada: <code>993</code></li>
    <li>Cifrado de entrada: SSL/TLS</li>
    <li>Servidor de salida: <code>mail.km0digital.com</code></li>
    <li>Puerto de salida: <code>587</code></li>
    <li>Cifrado de salida: STARTTLS</li>
    <li>Usuario, en entrada y en salida: tu dirección completa</li>
    <li>Contraseña: la de tu buzón</li>
  </ul>
  <p class="doc-block-intro">Si Outlook escribe <code>smtp.km0digital.com</code> como servidor de salida, cámbialo a <code>mail.km0digital.com</code>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Paso 4</p>
  <h2 class="doc-block-heading">Comprueba el correo</h2>
  <ol class="doc-list">
    <li>Termina el asistente.</li>
    <li>Abre la bandeja de entrada.</li>
    <li>Envía un mensaje de prueba a otra dirección.</li>
  </ol>
  <p class="doc-block-intro">Para enviar, la cuenta tiene que estar verificada. Si acabas de crearla, sigue el tutorial de <a href="/tutorials/mail-register/">crear cuenta</a>.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Problemas frecuentes</p>
  <h2 class="doc-block-heading">Solución de problemas</h2>
  <ul class="doc-list">
    <li><strong>No entra:</strong> revisa que el usuario sea la dirección completa y que la contraseña sea la del buzón.</li>
    <li><strong>No sale el correo:</strong> el servidor de salida tiene que ser <code>mail.km0digital.com</code>, puerto 587, con STARTTLS. Si la cuenta es nueva, verifica el buzón.</li>
  </ul>
</section>
