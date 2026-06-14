---
title: "Dia 11 - KM0 Mail en producció"
description: "Correu @km0digital.com amb Postfix, Dovecot, Rspamd i Roundcube a mail.km0digital.com; DNS MX/SPF/DKIM/DMARC, relay OpenCloud i plans de fase 1b."
pubDate: 2026-06-14
locale: ca
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducció</p>
  <p class="doc-lead">El <a href="/ca/doc/day-9/">dia 9</a> va tancar preus, legal, registre OpenCloud i conversió. <strong>No vam publicar entrada del dia 10</strong> (desplegament intern de correu sense article). El 14 de juny de 2026 vam activar <strong>KM0 Mail</strong>: bústies <code>@km0digital.com</code>, webmail a <a href="https://mail.km0digital.com/">mail.km0digital.com</a> i relay SMTP per a notificacions d'OpenCloud.</p>
  <p class="doc-lead">KM0 deixa de dependre de Gmail o APIs externes per al correu operatiu del domini i obre la porta a verificació de registre, avisos d'idees i màrqueting sobre la mateixa infraestructura.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Resum</p>
  <h2 class="doc-block-heading">Fites del dia</h2>
  <ul class="doc-list">
    <li><strong>Stack:</strong> repo <a href="https://github.com/AMVARA-CONSULTING/km0-mail">AMVARA-CONSULTING/km0-mail</a> amb Postfix, Dovecot, Rspamd, Roundcube i PostgreSQL (Docker Compose).</li>
    <li><strong>Hostname:</strong> <code>mail.km0digital.com</code> al mateix VPS que OpenCloud (<code>116.202.10.106</code>).</li>
    <li><strong>Webmail:</strong> Nginx + Let's Encrypt cap a Roundcube en loopback <code>:8080</code>.</li>
    <li><strong>Operació:</strong> bústies <code>postmaster@</code> i <code>noreply@</code>; CLI <code>./scripts/km0-mail-admin</code>.</li>
    <li><strong>Seguretat:</strong> Rspamd + signatura DKIM; fail2ban jail <code>km0-mail</code>; UFW 25, 587, 993.</li>
    <li><strong>OpenCloud:</strong> relay local Postfix (<code>host.docker.internal:587</code>, sense auth) amb remitent <code>noreply@km0digital.com</code>.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">KM0 Mail</p>
  <h2 class="doc-block-heading">Arquitectura i flux</h2>
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
    <li><strong>Recepció:</strong> Postfix accepta correu entrant per a <code>@km0digital.com</code> i el lliura a Maildir via Dovecot LMTP.</li>
    <li><strong>Enviament:</strong> clients autenticats (587) i relay intern des d'OpenCloud sense credencials a la xarxa Docker.</li>
    <li><strong>Webmail:</strong> Roundcube consulta Dovecot; accés públic només per HTTPS al subdomini mail.</li>
    <li><strong>Admin:</strong> <code>km0-mail-admin create-mailbox</code>, <code>alias</code>, <code>set-password</code> documentats al <a href="https://github.com/AMVARA-CONSULTING/km0-mail/blob/main/docs/runbook.md">runbook de km0-mail</a>.</li>
    <li><strong>Issue de referència:</strong> <a href="https://github.com/AMVARA-CONSULTING/km0-mail/issues/1">km0-mail #1</a> (Redmine #7605).</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">DNS</p>
  <h2 class="doc-block-heading">Lliurabilitat</h2>
  <p class="doc-block-intro">Sense registres correctes el correu acaba a spam o rebota. La checklist completa està a <a href="https://github.com/AMVARA-CONSULTING/km0-mail/blob/main/docs/joker-dns-checklist.md">docs/joker-dns-checklist.md</a> del repo km0-mail.</p>
  <ul class="doc-list">
    <li><strong>MX:</strong> <code>@</code> → <code>mail.km0digital.com</code>.</li>
    <li><strong>SPF:</strong> registre TXT que autoritza el servidor d'enviament KM0.</li>
    <li><strong>DKIM:</strong> selector <code>mail._domainkey</code> amb clau pública al DNS.</li>
    <li><strong>DMARC:</strong> política <code>p=none</code> amb informes a <code>postmaster@km0digital.com</code>.</li>
    <li><strong>PTR:</strong> Hetzner apunta a <code>mail.km0digital.com</code> (coherent amb HELO/EHLO).</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Integració fase 1 (parcial)</h2>
  <div class="doc-note"><pre>OpenCloud (notificacions)
        ↓
  host.docker.internal:587 (Postfix relay, sense auth)
        ↓
  Postfix → Rspamd → sortida Internet
  Remitent: noreply@km0digital.com</pre></div>
  <ul class="doc-list">
    <li><strong>km0-opencloud:</strong> variables <code>SMTP_*</code> a <code>.env</code> i <code>extra_hosts</code> al compose per arribar a Postfix de l'host.</li>
    <li><strong>Abast:</strong> les notificacions del cloud ja surten per KM0 Mail; el registre amb verificació per email segueix pendent (fase 1b).</li>
    <li><strong>LDAP:</strong> sense unificació a la fase 1; columna <code>mail_accounts.opencloud_uuid</code> reservada per al futur.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Producte</p>
  <h2 class="doc-block-heading">Decisions del dia</h2>
  <ul class="doc-list">
    <li><strong>Preu:</strong> correu inclòs de fet a l'oferta KM0; decisió executiva de tarifa després.</li>
    <li><strong>Escala:</strong> objectiu &gt;1000 bústies abans de final d'any.</li>
    <li><strong>Legal:</strong> pàgines <a href="/ca/legal/">/legal/</a> i <a href="/ca/security/">/security/</a> encara no cobreixen <code>mail.km0digital.com</code> (issue separat).</li>
    <li><strong>Serveis:</strong> targeta Email a la home segueix deshabilitada fins a fase 1b (issue separat).</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Roadmap</p>
  <h2 class="doc-block-heading">Pendent fase 1b</h2>
  <p class="doc-block-intro">El següent està planificat però <strong>encara no implementat</strong> en aquesta entrega:</p>
  <ol class="doc-steps">
    <li><strong>register-api:</strong> verificació d'email via Postfix local (substituir Gmail/extern).</li>
    <li><strong>km0-web</strong> <code>scripts/notify-idea-email.sh</code>: relay local (avui AutoMail API).</li>
    <li><strong>Marketing / tmp:</strong> SMTP local per a campanyes i entorns temporals.</li>
    <li><strong>Legal i seguretat</strong> a km0-web: cobrir <code>mail.km0digital.com</code>.</li>
    <li><strong>Bloc Email</strong> a serveis: habilitar targeta activa a la landing.</li>
    <li><strong>Còpia de seguretat:</strong> cron maildir documentat al runbook.</li>
    <li><strong>Fase 2:</strong> ClamAV, unificació LDAP, provisioning automatitzat.</li>
  </ol>
</section>

<section class="doc-block">
  <p class="doc-block-title">Verificació</p>
  <h2 class="doc-block-heading">Comprovar el dia 11</h2>
  <ol class="doc-steps">
    <li><strong>Webmail:</strong> obrir <a href="https://mail.km0digital.com/">mail.km0digital.com</a> i comprovar certificat TLS.</li>
    <li><strong>MX:</strong> <code>dig +short MX km0digital.com</code> ha de resoldre a <code>mail.km0digital.com</code>.</li>
    <li><strong>SPF:</strong> <code>dig +short TXT km0digital.com</code> inclou registre SPF.</li>
    <li><strong>DKIM:</strong> <code>dig +short TXT mail._domainkey.km0digital.com</code> retorna clau pública.</li>
    <li><strong>DMARC:</strong> <code>dig +short TXT _dmarc.km0digital.com</code> mostra política i informes.</li>
    <li><strong>PTR:</strong> <code>dig +short -x 116.202.10.106</code> coincideix amb el hostname del servidor mail.</li>
    <li><strong>Checklist:</strong> seguir <a href="https://github.com/AMVARA-CONSULTING/km0-mail/blob/main/docs/joker-dns-checklist.md">joker-dns-checklist.md</a> punt per punt.</li>
    <li><strong>OpenCloud:</strong> disparar notificació de prova i verificar remitent <code>noreply@km0digital.com</code>.</li>
  </ol>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Sèrie</p>
  <h2 class="doc-block-heading">Dies 1–9</h2>
  <p class="doc-closing">El <a href="/ca/doc/day-9/">dia 9</a> va publicar preus, legal i registre; els dies anteriors cobreixen el stack cloud. Prova el <a href="https://mail.km0digital.com/">webmail</a>, llegeix el <a href="https://github.com/AMVARA-CONSULTING/km0-mail/blob/main/docs/runbook.md">runbook de km0-mail</a> i segueix amb legal/serveis en properes entregues. Dubtes: <a href="/ca/#contact">contacte</a>.</p>
</section>
