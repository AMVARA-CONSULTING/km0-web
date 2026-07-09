---
title: "Tag 15 - OpenCloud-Registrierung: abgelaufenes Graph-Token und Auto-Erneuerung"
description: "Ein abgelaufenes Graph-Token blockierte die E-Mail-Registrierung bei KM0 Cloud; wir dokumentieren die Ursache, sichere register-api-Token-Rotation und Fehler bei der Automatisierung."
pubDate: 2026-07-04
locale: de
---

<section class="doc-lead-block">
  <p class="doc-block-title">Einleitung</p>
  <p class="doc-lead">Am <strong>Tag 15</strong> kehren wir zur operativen Infrastruktur im Schwesterprojekt <a href="https://github.com/AMVARA-CONSULTING/km0-opencloud">km0-opencloud</a> zurück. Am 4. Juli 2026 versuchte ein Nutzer, sich mit E-Mail und Passwort bei <a href="https://cloud.km0digital.com/register.html">KM0 Cloud</a> zu registrieren, und sah eine generische Fehlermeldung. Google OAuth funktionierte weiter. Die Ursache: das <strong>register-api Graph-Token war abgelaufen</strong>.</p>
  <p class="doc-lead">In <a href="https://github.com/AMVARA-CONSULTING/km0-opencloud/issues/17">Issue #17</a> implementierten wir manuelle Rotation, sichere Auto-Erneuerung und beheben zwei Defekte, die der Tester bei der Skript-Validierung fand. Dieser Artikel erklärt, was passierte, warum es wichtig ist und was jetzt automatisiert ist.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Vorfall</p>
  <h2 class="doc-block-heading">Was der Nutzer sah</h2>
  <p class="doc-block-intro">Das Formular zeigte die generische Meldung «Konto konnte nicht erstellt werden. Bitte später erneut versuchen.» ohne Hinweis, dass der Dienst vorübergehend ausfiel. Derselbe Nutzer meldete sich später problemlos mit <strong>Google OAuth</strong> an.</p>
  <ul class="doc-list">
    <li><strong>Ursache:</strong> abgelaufenes oder ungültiges <code>GRAPH_SERVICE_APP_TOKEN</code> für register-api; Graph lehnte die Credentials ab.</li>
    <li><strong>Beleg:</strong> <code>GET /health</code> lieferte <code>graph_auth_ok: false</code>; <code>POST /api/register</code> antwortete HTTP 503.</li>
    <li><strong>OAuth intakt:</strong> Google-Login nutzt Dex + OIDC, nicht register-api; ein Weg funktionierte, der andere nicht.</li>
    <li><strong>Vorheriger Kontext:</strong> <a href="https://github.com/AMVARA-CONSULTING/km0-opencloud/issues/16">Issue #16</a> hatte Formularfehler bereits verbessert; an diesem Tag adressieren wir die operative Ursache des 503.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Warum</p>
  <h2 class="doc-block-heading">Warum register-api ein Token braucht</h2>
  <p class="doc-block-intro">Die E-Mail/Passwort-Registrierung bei <a href="https://cloud.km0digital.com/">KM0 Cloud</a> läuft über einen Sidecar, <strong>register-api</strong>, der Nutzer via OpenCloud Graph anlegt (<code>POST /graph/v1.0/users</code>). In Produktion akzeptiert Graph kein Passwort-Basic-Auth; register-api muss sich mit einem dedizierten <strong>Graph App Token</strong> authentifizieren.</p>
  <div class="doc-callout">
    <span class="doc-callout-title">Operatives Geheimnis</span>
    <p>Dieses Token ist ein Secret mit Ablaufdatum. Läuft es ab und niemand erneuert es, fällt die manuelle Registrierung still aus, während OAuth weiterläuft. Behandeln Sie es als Infrastruktur-Credential, nicht als «einmal setzen und vergessen».</p>
  </div>
</section>

<section class="doc-block">
  <p class="doc-block-title">Implementierung</p>
  <h2 class="doc-block-heading">Rotation und Auto-Erneuerung (Issue #17)</h2>
  <ul class="doc-list">
    <li><strong>Policy:</strong> Token nur für register-api, <strong>3 Monate</strong> Laufzeit, Auto-Erneuerung wenn weniger als <strong>14 Tage</strong> verbleiben.</li>
    <li><strong><code>setup-register-api-graph-token.sh</code>:</strong> erstellt Token mit <code>--expires-in 90d</code>, schreibt <code>GRAPH_SERVICE_APP_TOKEN</code> und <code>GRAPH_SERVICE_APP_TOKEN_EXPIRES_AT</code> nach <code>register-api/.env</code>.</li>
    <li><strong><code>renew-register-api-graph-token.sh</code>:</strong> prüft Health und Ablauf; erneuert bei <code>graph_auth_ok: false</code> oder knappem Puffer; startet <strong>nur register-api</strong> neu; verifiziert <code>/health</code>.</li>
    <li><strong>Cron:</strong> wöchentliche Vorlage (Montag 03:00 UTC) in <code>register-api-token-renewal.cron</code>.</li>
    <li><strong>Sicherheit:</strong> der Prozess berührt nie Nutzer, Volumes, Dex/OIDC, Datenbanken oder restliches OpenCloud-<code>.env</code>.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Gefundene Fehler</p>
  <h2 class="doc-block-heading">Was bei der Automatisierung scheiterte</h2>
  <p class="doc-block-intro">Die erste Version des Erneuerungs-Skripts bestand grundlegende manuelle Tests, aber der Tester fand zwei Defekte bei echten Cron- und Erzwingungs-Szenarien.</p>
  <ul class="doc-list">
    <li><strong>Falscher Graph-Nutzer:</strong> das Erneuerungs-Skript propagierte <code>GRAPH_SERVICE_USER</code> nicht aus <code>register-api/.env</code>. Setup erzeugte das Token für den Standardnutzer (<code>admin</code>) statt den konfigurierten Operator. <strong>Fix:</strong> <code>GRAPH_SERVICE_USER</code> aus <code>.env</code> lesen und mit <code>--user</code> an Setup übergeben.</li>
    <li><strong>Race nach Neustart:</strong> <code>verify-register-api.sh</code> lief unmittelbar nach <code>docker compose up</code> und scheiterte, weil register-api noch nicht vollständig startete. <strong>Fix:</strong> aktives Warten bis 30 s (<code>REGISTER_API_HEALTH_WAIT_SEC</code>) mit Prüfung auf <code>graph_auth_ok: true</code> vor Verify.</li>
  </ul>
  <p>Nach diesen Änderungen endeten Skip-, Erzwingungs- und 7-Tage-Schwellen-Szenarien mit Exit 0 und <code>graph_auth_ok: true</code>.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Grenzen</p>
  <h2 class="doc-block-heading">Was Erneuerung nie tun darf</h2>
  <p class="doc-block-intro">Explizite Grenzen im km0-opencloud-Runbook verhindern, dass ein automatisiertes Skript Produktion beschädigt.</p>
  <ul class="doc-list">
    <li>Kein <code>docker compose down -v</code>, <code>docker volume rm</code> oder OpenCloud-Nutzer-Reset.</li>
    <li>Keine Änderung an Dex, OIDC, Storage, Datenbanken oder bestehenden Gruppen.</li>
    <li>Nur register-api-Token aktualisieren, diesen Container neu starten, Health prüfen.</li>
    <li>Bei fehlgeschlagener Erneuerung bleiben Google OAuth und bestehende Nutzerdaten unberührt.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">KM0</p>
  <h2 class="doc-block-heading">Warum wir das im Blog erzählen</h2>
  <p class="doc-block-intro">KM0 verspricht nahe, betreibbare Dienste: Cloud, Mail und Web unter Ihrer Kontrolle. Ein abgelaufenes Token erinnert daran, dass <strong>Betrieb genauso wichtig ist wie Deployment</strong>.</p>
  <ul class="doc-list">
    <li><strong>Transparenz:</strong> scheitert E-Mail-Registrierung, gibt es typisierte Meldungen (Issue #16) und dokumentierte Rotationsverfahren.</li>
    <li><strong>Sichere Automatisierung:</strong> wöchentliche Erneuerung mit minimalem Scope, keine «Helden-Skripte», die den ganzen Stack neu starten.</li>
    <li><strong>Serie:</strong> <a href="/de/doc/day-14/">Tag 14</a> behandelte KI und Bürokratie; hier ist die Bürokratie ein Token mit Ablaufdatum und ein Cron, der es erneuert, bevor Nutzer es merken.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Verifikation</p>
  <h2 class="doc-block-heading">Registrierung prüfen</h2>
  <ol class="doc-steps">
    <li><strong>Health:</strong> Operatoren können <code>./scripts/verify-register-api.sh</code> in km0-opencloud ausführen und <code>graph_auth_ok: true</code> bestätigen.</li>
    <li><strong>Registrierung:</strong> <a href="https://cloud.km0digital.com/register.html">E-Mail/Passwort-Registrierung</a> testen oder mit Google anmelden, wenn Sie bereits ein Konto haben.</li>
    <li><strong>Serie:</strong> <a href="/de/doc/day-14/">Tag 14</a> (Harari und KI) und <a href="/de/doc/day-11/">Tag 11</a> (KM0 Mail) lesen.</li>
    <li><strong>Ideen:</strong> schreiben Sie uns über <a href="/de/ideas/">Ideenformular</a> oder <a href="/de/#contact">Kontakt</a>, wenn Sie mehr Beiträge zum KM0-Cloud-Betrieb wünschen.</li>
  </ol>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Serie</p>
  <h2 class="doc-block-heading">Frühere Tage</h2>
  <p class="doc-closing">Am <a href="/de/doc/day-14/">Tag 14</a> fassten wir Hararis Video über KI und Zivilisation zusammen; am <a href="/de/doc/day-13/">Tag 13</a> Meet 6 zur Sichtbarkeit; am <a href="/de/doc/day-11/">Tag 11</a> wurde KM0 Mail dokumentiert. Am <a href="/de/doc/day-16/">Tag 16</a> kündigen wir das Treffen in El Masnou über KI, Bürokratie und Palantir an. Folgen Sie der Serie und testen Sie <a href="https://cloud.km0digital.com/">KM0 Cloud</a>, wann Sie möchten.</p>
</section>
