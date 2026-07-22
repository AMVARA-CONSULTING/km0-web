---
title: "Tag 11 - KM0 Email in Produktion"
description: "@km0digital.com-Mail mit Postfix, Dovecot, Rspamd und Roundcube auf mail.km0digital.com; MX/SPF/DKIM/DMARC-DNS, OpenCloud-Relay und Phase-1b-Pläne."
pubDate: 2026-06-14
locale: de
---

<section class="doc-lead-block">
  <p class="doc-block-title">Einleitung</p>
  <p class="doc-lead">Am <a href="/de/doc/day-9/">Tag 9</a> wurden Preise, Rechtliches, OpenCloud-Registrierung und Conversion-Polish ausgeliefert. <strong>Es gibt keinen Tag-10-Artikel</strong> (internes Mail-Deployment ohne Beitrag). Am 14. Juni 2026 haben wir <strong>KM0 Email</strong> aktiviert: <code>@km0digital.com</code>-Postfächer, Webmail unter <a href="https://mail.km0digital.com/">mail.km0digital.com</a> und SMTP-Relay für OpenCloud-Benachrichtigungen.</p>
  <p class="doc-lead">KM0 ist nicht mehr auf Gmail oder externe APIs für operativen Domain-Mail angewiesen und öffnet den Weg zu Registrierungsverifikation, Ideen-Alerts und Marketing auf derselben Infrastruktur.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Zusammenfassung</p>
  <h2 class="doc-block-heading">Meilensteine des Tages</h2>
  <ul class="doc-list">
    <li><strong>Stack:</strong> Repo <a href="https://github.com/AMVARA-CONSULTING/km0-mail">AMVARA-CONSULTING/km0-mail</a> mit Postfix, Dovecot, Rspamd, Roundcube und PostgreSQL (Docker Compose).</li>
    <li><strong>Hostname:</strong> <code>mail.km0digital.com</code> auf demselben VPS wie OpenCloud (<code>116.202.10.106</code>).</li>
    <li><strong>Webmail:</strong> Nginx + Let's Encrypt zu Roundcube auf Loopback <code>:8080</code>.</li>
    <li><strong>Betrieb:</strong> Postfächer <code>postmaster@</code> und <code>noreply@</code>; CLI <code>./scripts/km0-mail-admin</code>.</li>
    <li><strong>Sicherheit:</strong> Rspamd + DKIM-Signatur; fail2ban-Jail <code>km0-mail</code>; UFW 25, 587, 993.</li>
    <li><strong>OpenCloud:</strong> lokales Postfix-Relay (<code>host.docker.internal:587</code>, ohne Auth) mit Absender <code>noreply@km0digital.com</code>.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">KM0 Email</p>
  <h2 class="doc-block-heading">Architektur und Ablauf</h2>
  <div class="doc-note"><pre>Internet (MX @ → mail.km0digital.com)
        ↓
  Postfix (:25 / :587 submission)
        ↓
  Rspamd (Anti-Spam, DKIM signing)
        ↓
  Dovecot (:993 IMAPS) → Maildir
        ↓
  Roundcube (Webmail, Loopback :8080 → Nginx TLS)</pre></div>
  <ul class="doc-list">
    <li><strong>Eingang:</strong> Postfix nimmt Mail für <code>@km0digital.com</code> an und liefert über Dovecot LMTP an Maildir.</li>
    <li><strong>Ausgang:</strong> authentifizierte Clients (587) und internes Relay von OpenCloud ohne Docker-Netzwerk-Credentials.</li>
    <li><strong>Webmail:</strong> Roundcube spricht mit Dovecot; öffentlicher Zugriff nur per HTTPS auf der Mail-Subdomain.</li>
    <li><strong>Admin:</strong> <code>km0-mail-admin create-mailbox</code>, <code>alias</code>, <code>set-password</code> im <a href="https://github.com/AMVARA-CONSULTING/km0-mail/blob/main/docs/runbook.md">km0-mail-Runbook</a> dokumentiert.</li>
    <li><strong>Referenz-Issue:</strong> <a href="https://github.com/AMVARA-CONSULTING/km0-mail/issues/1">km0-mail #1</a> (Redmine #7605).</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">DNS</p>
  <h2 class="doc-block-heading">Zustellbarkeit</h2>
  <p class="doc-block-intro">Ohne korrekte Records landet Mail im Spam oder springt zurück. Die vollständige Checkliste steht in <a href="https://github.com/AMVARA-CONSULTING/km0-mail/blob/main/docs/joker-dns-checklist.md">docs/joker-dns-checklist.md</a> im km0-mail-Repo.</p>
  <ul class="doc-list">
    <li><strong>MX:</strong> <code>@</code> → <code>mail.km0digital.com</code>.</li>
    <li><strong>SPF:</strong> TXT-Record, der den KM0-Ausgangsserver autorisiert.</li>
    <li><strong>DKIM:</strong> Selektor <code>mail._domainkey</code> mit öffentlichem Schlüssel im DNS.</li>
    <li><strong>DMARC:</strong> Richtlinie <code>p=none</code> mit Berichten an <code>postmaster@km0digital.com</code>.</li>
    <li><strong>PTR:</strong> Hetzner zeigt auf <code>mail.km0digital.com</code> (konsistent mit HELO/EHLO).</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Phase-1-Integration (teilweise)</h2>
  <div class="doc-note"><pre>OpenCloud (Benachrichtigungen)
        ↓
  host.docker.internal:587 (Postfix relay, ohne Auth)
        ↓
  Postfix → Rspamd → Internet-Ausgang
  Absender: noreply@km0digital.com</pre></div>
  <ul class="doc-list">
    <li><strong>km0-opencloud:</strong> <code>SMTP_*</code>-Variablen in <code>.env</code> und <code>extra_hosts</code> in Compose, um Host-Postfix zu erreichen.</li>
    <li><strong>Umfang:</strong> Cloud-Benachrichtigungen gehen bereits über KM0 Email; E-Mail-Verifikation bei Registrierung bleibt ausstehend (Phase 1b).</li>
    <li><strong>LDAP:</strong> keine Vereinheitlichung in Phase 1; Spalte <code>mail_accounts.opencloud_uuid</code> für später reserviert.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Produkt</p>
  <h2 class="doc-block-heading">Entscheidungen heute</h2>
  <ul class="doc-list">
    <li><strong>Preis:</strong> Mail de facto in KM0-Angebot enthalten; Preisentscheidung später.</li>
    <li><strong>Skalierung:</strong> Ziel &gt;1000 Postfächer vor Jahresende.</li>
    <li><strong>Rechtliches:</strong> Seiten <a href="/de/legal/">/legal/</a> und <a href="/de/security/">/security/</a> decken <code>mail.km0digital.com</code> noch nicht ab (separates Issue).</li>
    <li><strong>Services:</strong> E-Mail-Karte auf der Startseite bleibt bis Phase 1b deaktiviert (separates Issue).</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Roadmap</p>
  <h2 class="doc-block-heading">Phase 1b ausstehend</h2>
  <p class="doc-block-intro">Folgendes ist geplant, aber in diesem Release <strong>noch nicht umgesetzt</strong>:</p>
  <ol class="doc-steps">
    <li><strong>register-api:</strong> E-Mail-Verifikation über lokales Postfix (Gmail/extern ersetzen).</li>
    <li><strong>km0-web</strong> <code>scripts/notify-idea-email.sh</code>: lokales Relay (heute AutoMail API).</li>
    <li><strong>Marketing / tmp:</strong> lokales SMTP für Kampagnen und temporäre Umgebungen.</li>
    <li><strong>Rechtliches und Sicherheit</strong> auf km0-web: <code>mail.km0digital.com</code> abdecken.</li>
    <li><strong>E-Mail-Block</strong> in Services: aktive Karte auf der Landing aktivieren.</li>
    <li><strong>Backup:</strong> Maildir-Cron im Runbook dokumentieren.</li>
    <li><strong>Phase 2:</strong> ClamAV, LDAP-Vereinheitlichung, automatisiertes Provisioning.</li>
  </ol>
</section>

<section class="doc-block">
  <p class="doc-block-title">Verifikation</p>
  <h2 class="doc-block-heading">Tag 11 prüfen</h2>
  <ol class="doc-steps">
    <li><strong>Webmail:</strong> <a href="https://mail.km0digital.com/">mail.km0digital.com</a> öffnen und TLS-Zertifikat prüfen.</li>
    <li><strong>MX:</strong> <code>dig +short MX km0digital.com</code> sollte <code>mail.km0digital.com</code> auflösen.</li>
    <li><strong>SPF:</strong> <code>dig +short TXT km0digital.com</code> enthält SPF-Record.</li>
    <li><strong>DKIM:</strong> <code>dig +short TXT mail._domainkey.km0digital.com</code> liefert öffentlichen Schlüssel.</li>
    <li><strong>DMARC:</strong> <code>dig +short TXT _dmarc.km0digital.com</code> zeigt Richtlinie und Reporting.</li>
    <li><strong>PTR:</strong> <code>dig +short -x 116.202.10.106</code> entspricht dem Mail-Server-Hostname.</li>
    <li><strong>Checkliste:</strong> <a href="https://github.com/AMVARA-CONSULTING/km0-mail/blob/main/docs/joker-dns-checklist.md">joker-dns-checklist.md</a> Schritt für Schritt abarbeiten.</li>
    <li><strong>OpenCloud:</strong> Testbenachrichtigung auslösen und Absender <code>noreply@km0digital.com</code> prüfen.</li>
  </ol>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Serie</p>
  <h2 class="doc-block-heading">Nächster Eintrag</h2>
  <p class="doc-closing">Am <a href="/de/doc/day-12/">Tag 12</a> steht das Kundengespräch zur UX; am <a href="/de/doc/day-13/">Tag 13</a> Meet 6: Sichtbarkeit, Vereine (AMPAs, Nachbarn) und kommerzielle nächste Schritte. Testen Sie unterdessen das <a href="https://mail.km0digital.com/">Webmail</a> oder sehen Sie <a href="/de/pricing/">Preise</a>. Fragen: <a href="/de/#contact">Kontakt</a>.</p>
</section>
