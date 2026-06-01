---
title: "Tag 4 - Dex-Lokal-Login per LDAP gegen OpenCloud-IDM"
description: "Dex-LDAP-Connector zum integrierten OpenCloud-IDM, LDAPS-TLS-Zertifikatsfix und GitHub-Issue #1 mit automatisierten Tests in PASS geschlossen."
pubDate: 2026-05-27
locale: de
---

<section class="doc-lead-block">
  <p class="doc-block-title">Einleitung</p>
  <p class="doc-lead">Tag 4 (Fenster der letzten vier Stunden am 27. Mai 2026, ~11:40–15:40 CEST auf dem Produktions-Debian-VPS) konzentriert sich auf ein einziges Authentifizierungsziel: der lokale Login muss jeden Benutzer aus dem integrierten OpenCloud-IDM akzeptieren (gleiche <code>uid</code> und Passwort wie in den Einstellungen) und weiterhin Dex-OIDC-Tokens für den Proxy ausgeben.</p>
  <p class="doc-lead">Dex' statischer Passwort-Speicher wird durch einen LDAP-Connector zum IDM-LDAPS ersetzt, das TLS-Zertifikat des internen LDAP-Dienstes korrigiert, und die Autoagents-Schleife schließt GitHub-Issue #1 mit automatisierten Tests in PASS.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Zusammenfassung</p>
  <h2 class="doc-block-heading">Tagesergebnis</h2>
  <ul class="doc-list">
    <li><strong>Dex ↔ IDM:</strong> <code>ldap</code>-Connector → <code>ldaps://opencloud:9235</code>, Base <code>ou=users,o=libregraph-idm</code>; Dex im Docker-Netzwerk <code>opencloud_opencloud-net</code> mit Config/Daten-Volumes für CA <code>idm/ldap.crt</code>.</li>
    <li><strong>OpenCloud:</strong> <code>IDM_LDAPS_ADDR=0.0.0.0:9235</code> im External-Proxy-Overlay; <code>login.html</code> nutzt <code>connector_id=ldap</code>; nginx und Auth-JSON auf <code>cloud.km0digital.com</code> ausgerichtet.</li>
    <li><strong>IDM-TLS:</strong> Zertifikat mit SAN <code>DNS:opencloud</code> regeneriert (zuvor nur <code>localhost</code>); Skript <code>regenerate-opencloud-idm-ldap-cert.sh</code>.</li>
    <li><strong>Autoagents:</strong> Task PASS geschlossen; Paketversion 1.0.18; manueller Login mit zwei verschiedenen Benutzern ausstehend (Operator).</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Problem</p>
  <h2 class="doc-block-heading">GitHub #1</h2>
  <p class="doc-block-intro">Der hybride Flow leitete bereits Google/Apple und lokalen Login über Dex, aber der lokale Connector stützte sich auf Dex' statischen Passwort-Speicher: er funktionierte nur für vordefinierte Zugangsdaten, nicht für alle in OpenClouds IDM erstellten <code>inetOrgPerson</code>-Benutzer.</p>
  <p>Anforderung: Zugangsdaten mit OpenCloud-Einstellungen vereinheitlichen und den OIDC-Issuer (<code>OC_OIDC_ISSUER</code>) beibehalten, den der Proxy nutzt.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Lösung</p>
  <h2 class="doc-block-heading">Dex-LDAP- + IDM-Integration</h2>
  <ul class="doc-list">
    <li><strong>Dex:</strong> <code>type: ldap</code>-Connector in <code>dex/config.yaml</code>; lokale Passwort-DB entfernt.</li>
    <li><strong>Dex-Compose:</strong> Beitritt zu <code>opencloud_opencloud-net</code>; Mounts von <code>opencloud-config</code> und <code>opencloud-data</code> zum Lesen der CA und des gemounteten Config-<code>idm_password</code>.</li>
    <li><strong>OpenCloud-Overlay:</strong> <code>IDM_LDAPS_ADDR=0.0.0.0:9235</code>, damit Dex LDAPS über Hostname <code>opencloud</code> erreicht.</li>
    <li><strong>UI:</strong> <code>login.html</code> mit „lokal“-Button und <code>connector_id=ldap</code>; nginx <code>/dex/auth</code> ohne Connector → Login-Selector.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Ablauf</p>
  <h2 class="doc-block-heading">Login nach den Änderungen</h2>
  <div class="doc-note"><pre>login.html
  ├── Google  → Dex connector google  → OIDC token → OpenCloud proxy
  ├── Apple   → Dex connector apple   → (wenn konfiguriert)
  └── Local   → Dex connector ldap    → IDM LDAPS opencloud:9235
                                         (beliebige inetOrgPerson uid + Passwort)</pre></div>
  <p>Soziale Connectors folgen demselben OIDC-Muster; lokaler Login ist keine feste Liste in Dex mehr, sondern ein LDAP-Bind gegen das eingebettete Verzeichnis des Stacks.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Collabora</p>
  <h2 class="doc-block-heading">Co-Bearbeitung nach vereinheitlichtem Login</h2>
  <p class="doc-block-intro">Die in <a href="/de/doc/day-3/">Tag 3</a> dokumentierte Collabora-Integration ermöglicht Office-Bearbeitung im Browser für alle authentifizierten Nutzer. Mit dem Dex-LDAP-Connector von Tag 4 kann jeder IDM-Nutzer (gleiches <code>uid</code> und Passwort wie in den Einstellungen) sich anmelden und geteilte Tabellen oder Präsentationen öffnen; mehrere Personen können dieselbe <code>XLSX</code>- oder <code>PPT</code>-Datei gleichzeitig bearbeiten.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">TLS</p>
  <h2 class="doc-block-heading">IDM-LDAPS-Zertifikatsfix</h2>
  <p class="doc-block-intro">Beim Test erreichte Dex <code>opencloud:9235</code>, aber das autogenerierte <code>ldap.crt</code> enthielt nur <code>localhost</code> im SAN → Fehler <em>TLS certificate is valid for localhost, not opencloud</em>.</p>
  <p>Fix (<code>0a042db</code>): Skript <code>scripts/regenerate-opencloud-idm-ldap-cert.sh</code> regeneriert das Zertifikat mit <code>DNS:localhost,DNS:opencloud,IP:127.0.0.1</code> und <code>--restart</code>-Option; dokumentiert in Runbook und Dex-README.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Commits</p>
  <h2 class="doc-block-heading">Tagesfenster (CEST)</h2>
  <ul class="doc-list">
    <li><code>cf5a561</code> (15:27) - <code>feat(auth): Dex LDAP login against OpenCloud IDM for all users</code>.</li>
    <li><code>0a042db</code> (15:39) - <code>fix(dex): regenerate IDM LDAP cert with opencloud SAN for Dex TLS</code>.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Autoagents</p>
  <h2 class="doc-block-heading">Abschluss-Checks</h2>
  <ul class="doc-list">
    <li>IDM-Zert-SAN enthält <code>opencloud</code> - PASS.</li>
    <li>Dex LDAP <code>host: opencloud:9235</code> - PASS.</li>
    <li><code>curl</code> mit <code>connector_id=ldap</code> → <code>/dex/auth/ldap</code> - PASS.</li>
    <li>Falsches Passwort → HTTP 401, LDAP-Bind, kein x509 in Logs - PASS.</li>
    <li>Google-Connector-Smoke - PASS.</li>
    <li>Manueller Login zwei verschiedene Benutzer → <code>/files</code> - NICHT VERIFIZIERT (Operator).</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Deployment</p>
  <h2 class="doc-block-heading">Verifikation (Operator)</h2>
  <div class="doc-note"><pre>cd /opt/opencloud
./scripts/git-sync-main.sh
./scripts/apply-opencloud-compose-overrides.sh
./scripts/regenerate-opencloud-idm-ldap-cert.sh --restart
rsync -a /opt/opencloud/host-www/opencloud-auth/ /var/www/opencloud-auth/
cd dex && docker compose up -d

curl -sI https://cloud.km0digital.com/login.html</pre></div>
  <p>Manuell: privates Fenster → <code>login.html</code> → lokaler Login mit zwei verschiedenen OpenCloud-<code>uid</code>s; erwartet <code>/oidc-callback.html</code> dann <code>/files</code> ohne JWKS-Fehler oder <code>/graph/v1.0/me</code> 500.</p>
  <div class="doc-note">Benutzerpasswörter und IDM-Bind-Secrets sind nicht Teil dieses Eintrags; der Happy Path mit zwei echten Konten bleibt menschliche Verifikation in Produktion.</div>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Nächster Schritt</p>
  <h2 class="doc-block-heading">Tag 5</h2>
  <p class="doc-closing"><strong>Tag 5</strong> dokumentiert keine Deployments: er hält ein Visionstreffen in Masnou fest - warum wir glauben, dass nützliche Technologie heute schon ohne Big Tech angeboten werden kann. In der Zwischenzeit: die <a href="/de/#services">Services</a> erkunden oder den <a href="/de/doc/day-5/">Bericht zu Tag 5</a> lesen.</p>
</section>
