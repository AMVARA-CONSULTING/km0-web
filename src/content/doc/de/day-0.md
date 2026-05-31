---
title: "Tag 0 - Server-Grundlagen"
description: "Debian, Partitionierung, Docker, Nginx und eine reproduzierbare Basis, damit der KM0-Stack auditierbar und betriebsfähig bleibt."
pubDate: 2026-05-21
locale: de
---

<section class="doc-lead-block">
  <p class="doc-block-title">Einleitung</p>
  <p class="doc-lead">Tag 0 widmet sich den <strong>Grundlagen</strong>: ohne ein reproduzierbares Betriebssystem und eine funktionierende Umgebung wäre jeder spätere Stack fragil und schwer auditierbar.</p>
  <p class="doc-lead">Das Ziel ist, den Tag mit stabilem Debian, geordnetem Speicher, minimalen aber ausreichenden Werkzeugen und einer Shell abzuschließen, die dazu einlädt, jede Änderung zu dokumentieren.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Infrastruktur</p>
  <h2 class="doc-block-heading">Technischer Bootstrap-Plan</h2>
  <p class="doc-block-intro">KM0 zielt auf Infrastruktur ab, die das Team ohne undurchsichtige proprietäre Panels betreiben kann. Das vollständige Bootstrap-Bild umfasst:</p>
  <ul class="doc-list">
    <li><strong>System:</strong> VPS mit aktuellem Debian und Partitionen, die System und Daten bei Bedarf trennen (klarere Snapshots und Backups).</li>
    <li><strong>Zusammenarbeit:</strong> <a href="https://cloud.km0digital.com">OpenCloud</a> als Microservices auf einem offiziellen <a href="https://opencloud.eu">OpenCloud.eu</a>-Image, mit stabilen Volumes (<code>COMPOSE_PROJECT_NAME</code>), unabhängig vom Compose-Arbeitsverzeichnis.</li>
    <li><strong>Perimeter:</strong> Nginx als einziger HTTPS-Front; Docker veröffentlicht HTTP nur auf <code>127.0.0.1</code>.</li>
    <li><strong>Kommunikation:</strong> Dockerisierter Astro auf einem weiteren Loopback-Port; separate Vhosts für <code>km0digital.com</code> und <code>cloud.km0digital.com</code>.</li>
    <li><strong>Beobachtbarkeit:</strong> rotierte Logs (<code>json-file</code>), Runbooks mit <code>docker compose ps</code>, <code>logs</code>, <code>pull</code> und komprimierten Volume-Backups.</li>
    <li><strong>Evolution:</strong> Produktions-TLS intern, automatisierte Backups und Fail2ban pro spezifischen Jails.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Speicher und System</p>
  <h2 class="doc-block-heading">VPS-Bereitstellung und Partitionen</h2>
  <p class="doc-block-intro"><strong>Debian</strong> wurde wegen vorhersehbarer Pakete und praxisnaher Dokumentation gewählt - ohne verpflichtende Control Panels. Der erste Schritt war die Prüfung des Speicherlayouts:</p>
  <ul class="doc-list">
    <li>Projektdaten vom Root-Dateisystem trennen, wenn Backup auf Volume-Ebene nötig ist.</li>
    <li>Mounts bewusst definieren: <code>/var/lib/docker</code> kann je nach VPS-Größe OpenCloud-I/O konzentrieren.</li>
    <li>Konventionen dokumentieren, um persistente Mounts vom Betriebssystem zu unterscheiden.</li>
  </ul>
  <div class="doc-note">Exakte Partitionierungspläne hängen vom Anbieter und der gebuchten Größe ab. Sie müssen im Projekt-Wiki oder Runbook stehen, nicht nur in diesem Blog - für die Disaster Recovery.</div>
</section>

<section class="doc-block">
  <p class="doc-block-title">Basispakete</p>
  <h2 class="doc-block-heading">Basissoftware</h2>
  <p class="doc-block-intro">Ein vernünftiges Minimum für sichere Remote-Administration und Docker wurde installiert, ohne Ballast:</p>
  <ul class="doc-list">
    <li>Gängige Utilities: <code>curl</code>, Editoren, Netzwerk und Diagnose.</li>
    <li><strong>Docker Engine</strong> mit rotierten Logs in <code>/etc/docker/daemon.json</code>.</li>
    <li><strong>Nginx</strong> aus Systempaketen als stabiler Front.</li>
    <li><strong>Certbot</strong> und TLS phasenweise (HTTP-01 oder selbstsigniertes Zertifikat im Lab).</li>
  </ul>
  <p>Jedes Stück hat eine beobachtbare Rolle: <code>systemctl status</code>, <code>nginx -t</code>, <code>docker compose ps</code>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Konsole</p>
  <h2 class="doc-block-heading">Shell-Ergonomie</h2>
  <p class="doc-block-intro">Für konsistente SSH-Sitzungen wurde der Wiki-Leitfaden <a href="https://wiki.ldeluipy.es/initialConfiguration.html">initialConfiguration</a> angewendet:</p>
  <ul class="doc-list">
    <li>Lesbarer Bash-Prompt (Pfad, Befehlsstatus, visuelle Hinweise).</li>
    <li>History und sichere Defaults, die wiederholte Fehler reduzieren.</li>
    <li>Aliases und <code>PATH</code> ausgerichtet auf Compose und Git unter <code>/opt/...</code>.</li>
  </ul>
  <p>Diese Basis, außerhalb des Servers dokumentiert, ermöglicht dasselbe Template auf anderen VPS-Instanzen ohne Improvisation.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Werkzeuge</p>
  <h2 class="doc-block-heading">cursor-agent</h2>
  <div class="doc-callout">
    <span class="doc-callout-title">Kommandozeilen-Unterstützung</span>
    <p><strong>cursor-agent</strong> wurde installiert, um die tägliche Arbeit näher an einen assistierten Entwicklungsfluss zu bringen: Reviews, Hilfsskripte und schrittweise Dokumentation von der Konsole aus.</p>
    <p>Er ersetzt weder menschliche Reviews noch Team-Kontrollen, senkt aber die Reibung bei wiederholbaren Aufgaben (Compose-Overlays, Nginx vor Reload validieren usw.).</p>
  </div>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Tagesende</p>
  <h2 class="doc-block-heading">Stand am Ende von Tag 0</h2>
  <p class="doc-block-intro">Am Ende des Tages erfüllt der Server drei Eigenschaften:</p>
  <ol class="doc-steps">
    <li><strong>Auditierbar:</strong> bekanntes Speicherlayout und Pakete.</li>
    <li><strong>Reproduzierbar:</strong> Hauptschritte verknüpft mit Wiki und Runbooks.</li>
    <li><strong>Bereit</strong> für Docker, ohne Services zu früh öffentlich freizugeben.</li>
  </ol>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Nächster Schritt</p>
  <h2 class="doc-block-heading">Tag 1</h2>
  <p class="doc-closing"><strong>Tag 1</strong> bringt OpenCloud, den Proxy-Virtual-Host und die KM0-Website über TLS hoch. In der Zwischenzeit: die veröffentlichten <a href="/de/#services">Services</a> erkunden oder <a href="/de/#contact">Kontakt aufnehmen</a>, wenn Sie mitarbeiten möchten.</p>
</section>
