---
title: "Día 11 - KM0 Mail en producción"
description: "Correo @km0digital.com con Postfix, Dovecot, Rspamd y Roundcube en mail.km0digital.com; DNS MX/SPF/DKIM/DMARC, relay OpenCloud y planes de fase 1b."
pubDate: 2026-06-14
locale: es
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducción</p>
  <p class="doc-lead">El <a href="/doc/day-9/">día 9</a> cerró precios, legal, registro OpenCloud y conversión. <strong>No publicamos entrada del día 10</strong> (despliegue interno de correo sin artículo). El 14 de junio de 2026 activamos <strong>KM0 Mail</strong>: buzones <code>@km0digital.com</code>, webmail en <a href="https://mail.km0digital.com/">mail.km0digital.com</a> y relay SMTP para notificaciones de OpenCloud.</p>
  <p class="doc-lead">KM0 deja de depender de Gmail o APIs externas para el correo operativo del dominio y abre la puerta a verificación de registro, avisos de ideas y marketing sobre la misma infraestructura.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Resumen</p>
  <h2 class="doc-block-heading">Hitos del día</h2>
  <ul class="doc-list">
    <li><strong>Stack:</strong> repo <a href="https://github.com/AMVARA-CONSULTING/km0-mail">AMVARA-CONSULTING/km0-mail</a> con Postfix, Dovecot, Rspamd, Roundcube y PostgreSQL (Docker Compose).</li>
    <li><strong>Hostname:</strong> <code>mail.km0digital.com</code> en el mismo VPS que OpenCloud (<code>116.202.10.106</code>).</li>
    <li><strong>Webmail:</strong> Nginx + Let's Encrypt hacia Roundcube en loopback <code>:8080</code>.</li>
    <li><strong>Operación:</strong> buzones <code>postmaster@</code> y <code>noreply@</code>; CLI <code>./scripts/km0-mail-admin</code>.</li>
    <li><strong>Seguridad:</strong> Rspamd + firma DKIM; fail2ban jail <code>km0-mail</code>; UFW 25, 587, 993.</li>
    <li><strong>OpenCloud:</strong> relay local Postfix (<code>host.docker.internal:587</code>, sin auth) con remitente <code>noreply@km0digital.com</code>.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">KM0 Mail</p>
  <h2 class="doc-block-heading">Arquitectura y flujo</h2>
  <div class="doc-note"><pre>Internet (MX @ → mail.km0digital.com)
        ↓
  Postfix (:25 / :587 submission)
        ↓
  Rspamd (anti-spam, DKIM signing)
        ↓
  Dovecot (:993 IMAPS) → Maildir
        ↓
  Roundcube (webmail, loopback :8080 → Nginx TLS)</pre></div>
  <ul class="doc-list">
    <li><strong>Recepción:</strong> Postfix acepta correo entrante para <code>@km0digital.com</code> y lo entrega en Maildir vía Dovecot LMTP.</li>
    <li><strong>Envío:</strong> clientes autenticados (587) y relay interno desde OpenCloud sin credenciales en la red Docker.</li>
    <li><strong>Webmail:</strong> Roundcube consulta Dovecot; acceso público solo por HTTPS en el subdominio mail.</li>
    <li><strong>Admin:</strong> <code>km0-mail-admin create-mailbox</code>, <code>alias</code>, <code>set-password</code> documentados en el <a href="https://github.com/AMVARA-CONSULTING/km0-mail/blob/main/docs/runbook.md">runbook de km0-mail</a>.</li>
    <li><strong>Issue de referencia:</strong> <a href="https://github.com/AMVARA-CONSULTING/km0-mail/issues/1">km0-mail #1</a> (Redmine #7605).</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">DNS</p>
  <h2 class="doc-block-heading">Entregabilidad</h2>
  <p class="doc-block-intro">Sin registros correctos el correo llega a spam o rebota. La checklist completa está en <a href="https://github.com/AMVARA-CONSULTING/km0-mail/blob/main/docs/joker-dns-checklist.md">docs/joker-dns-checklist.md</a> del repo km0-mail.</p>
  <ul class="doc-list">
    <li><strong>MX:</strong> <code>@</code> → <code>mail.km0digital.com</code>.</li>
    <li><strong>SPF:</strong> registro TXT autorizando el servidor de envío KM0.</li>
    <li><strong>DKIM:</strong> selector <code>mail._domainkey</code> con clave pública en DNS.</li>
    <li><strong>DMARC:</strong> política <code>p=none</code> con informes a <code>postmaster@km0digital.com</code>.</li>
    <li><strong>PTR:</strong> Hetzner apunta a <code>mail.km0digital.com</code> (coherente con HELO/EHLO).</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Integración fase 1 (parcial)</h2>
  <div class="doc-note"><pre>OpenCloud (notificaciones)
        ↓
  host.docker.internal:587 (Postfix relay, sin auth)
        ↓
  Postfix → Rspamd → salida Internet
  Remitente: noreply@km0digital.com</pre></div>
  <ul class="doc-list">
    <li><strong>km0-opencloud:</strong> variables <code>SMTP_*</code> en <code>.env</code> y <code>extra_hosts</code> en compose para alcanzar Postfix del host.</li>
    <li><strong>Alcance:</strong> notificaciones del cloud ya salen por KM0 Mail; registro con verificación por email sigue pendiente (fase 1b).</li>
    <li><strong>LDAP:</strong> sin unificación en fase 1; columna <code>mail_accounts.opencloud_uuid</code> reservada para futuro.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Producto</p>
  <h2 class="doc-block-heading">Decisiones del día</h2>
  <ul class="doc-list">
    <li><strong>Precio:</strong> correo incluido de facto en la oferta KM0; decisión ejecutiva de tarifa después.</li>
    <li><strong>Escala:</strong> objetivo &gt;1000 buzones antes de fin de año.</li>
    <li><strong>Legal:</strong> páginas <a href="/legal/">/legal/</a> y <a href="/security/">/security/</a> aún no cubren <code>mail.km0digital.com</code> (issue separado).</li>
    <li><strong>Servicios:</strong> tarjeta Email en la home sigue deshabilitada hasta fase 1b (issue separado).</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Roadmap</p>
  <h2 class="doc-block-heading">Pendiente fase 1b</h2>
  <p class="doc-block-intro">Lo siguiente está planificado pero <strong>no implementado aún</strong> en esta entrega:</p>
  <ol class="doc-steps">
    <li><strong>register-api:</strong> verificación de email vía Postfix local (sustituir Gmail/externo).</li>
    <li><strong>km0-web</strong> <code>scripts/notify-idea-email.sh</code>: relay local (hoy AutoMail API).</li>
    <li><strong>Marketing / tmp:</strong> SMTP local para campañas y entornos temporales.</li>
    <li><strong>Legal y seguridad</strong> en km0-web: cubrir <code>mail.km0digital.com</code>.</li>
    <li><strong>Bloque Email</strong> en servicios: habilitar tarjeta activa en la landing.</li>
    <li><strong>Backup:</strong> cron maildir documentado en runbook.</li>
    <li><strong>Fase 2:</strong> ClamAV, unificación LDAP, provisioning automatizado.</li>
  </ol>
</section>

<section class="doc-block">
  <p class="doc-block-title">Verificación</p>
  <h2 class="doc-block-heading">Comprobar el día 11</h2>
  <ol class="doc-steps">
    <li><strong>Webmail:</strong> abrir <a href="https://mail.km0digital.com/">mail.km0digital.com</a> y comprobar certificado TLS.</li>
    <li><strong>MX:</strong> <code>dig +short MX km0digital.com</code> debe resolver a <code>mail.km0digital.com</code>.</li>
    <li><strong>SPF:</strong> <code>dig +short TXT km0digital.com</code> incluye registro SPF.</li>
    <li><strong>DKIM:</strong> <code>dig +short TXT mail._domainkey.km0digital.com</code> devuelve clave pública.</li>
    <li><strong>DMARC:</strong> <code>dig +short TXT _dmarc.km0digital.com</code> muestra política y informes.</li>
    <li><strong>PTR:</strong> <code>dig +short -x 116.202.10.106</code> coincide con el hostname del servidor mail.</li>
    <li><strong>Checklist:</strong> seguir <a href="https://github.com/AMVARA-CONSULTING/km0-mail/blob/main/docs/joker-dns-checklist.md">joker-dns-checklist.md</a> punto por punto.</li>
    <li><strong>OpenCloud:</strong> disparar notificación de prueba y verificar remitente <code>noreply@km0digital.com</code>.</li>
  </ol>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Serie</p>
  <h2 class="doc-block-heading">Siguiente entrada</h2>
  <p class="doc-closing">El <a href="/doc/day-12/">día 12</a> recoge la charla con cliente sobre UX; el <a href="/doc/day-13/">día 13</a> el meet 6: visibilidad, asociaciones (AMPAs, vecinos) y próximos pasos comerciales. Mientras tanto, prueba el <a href="https://mail.km0digital.com/">webmail</a> o consulta <a href="/pricing/">precios</a>. Dudas: <a href="/#contact">contacto</a>.</p>
</section>
