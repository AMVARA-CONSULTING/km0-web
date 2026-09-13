---
title: "Fotobackup auf Android und iOS"
description: "Automatischer Handy-Upload zu KM0 Cloud, Originale versus optionale Konvertierung, und Wiederherstellung wenn das Gerät ausfällt."
locale: de
order: 8
platform: mobile
---

<section class="doc-lead-block">
  <p class="doc-block-title">Einführung</p>
  <p class="doc-lead">Die OpenCloud-Apps für <strong>Android</strong> und <strong>iOS</strong> können neue Fotos und Videos in Ihr KM0-Cloud-Konto hochladen. Die Dateien liegen auf EU-Servern unter <code>cloud.km0digital.com</code>. Der Self-Serve-Tarif umfasst <strong>150 GB</strong>: sagen Sie das klar, wenn das Ziel eine lebenslange Fotobibliothek ist.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Voraussetzungen</p>
  <h2 class="doc-block-heading">Am Handy anmelden</h2>
  <ol class="doc-list">
    <li>Installieren Sie OpenCloud aus dem Store (siehe <a href="/de/tutorials/getting-started-android/">Android</a> oder <a href="/de/tutorials/getting-started-ios/">iOS</a>).</li>
    <li>Server-URL: <code>https://cloud.km0digital.com/</code>.</li>
    <li>Erlauben Sie den Zugriff auf die Mediathek, wenn die App danach fragt.</li>
    <li>Wählen Sie einen Zielordner in KM0 Cloud, bevor Sie automatische Uploads erwarten.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Android</p>
  <h2 class="doc-block-heading">Automatische Bild- und Video-Uploads</h2>
  <ol class="doc-list">
    <li>Öffnen Sie OpenCloud → <strong>Settings</strong>.</li>
    <li>Konfigurieren Sie <strong>Automatic picture uploads</strong> und <strong>Automatic video uploads</strong> (Zielordner und Verhalten).</li>
    <li>Lassen Sie das Gerät bei großen Batches möglichst im WLAN. Den Zeitpunkt steuert Android; Uploads können einige Minuten warten.</li>
  </ol>
  <p class="doc-block-intro">Herstellerübersicht: <a href="https://docs.opencloud.eu/docs/user/android-app/general/settings/" target="_blank" rel="noopener noreferrer">Android-Einstellungen</a>.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">iOS</p>
  <h2 class="doc-block-heading">Auto Upload für Fotos und Videos</h2>
  <ol class="doc-list">
    <li>Öffnen Sie OpenCloud → <strong>Settings</strong> → <strong>Media Upload</strong>.</li>
    <li>Setzen Sie <strong>Photo upload path</strong> auf einen Ordner in Ihrem Konto.</li>
    <li>Aktivieren Sie <strong>Auto Upload Photos</strong> und/oder <strong>Auto Upload Videos</strong>.</li>
  </ol>
  <p class="doc-block-intro">Aktuelles iOS-Verhalten (OpenCloud-Docs): Auto Upload läuft, wenn die App im Vordergrund offen ist. Ist die App geschlossen, warten neue Medien bis zum nächsten Öffnen. Beim Öffnen erkennt die App Medien seit dem letzten erfolgreichen Upload.</p>
  <p class="doc-block-intro">Dokumentation: <a href="https://docs.opencloud.eu/docs/user/ios-app/general/settings/auto-upload-photos-and-videos/" target="_blank" rel="noopener noreferrer">Auto Upload Photos and Videos</a>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Qualität</p>
  <h2 class="doc-block-heading">Originale versus optionale Konvertierung</h2>
  <p class="doc-block-intro">Unter iOS ist die Konvertierung eine explizite Einstellung, kein stilles Standardverhalten:</p>
  <ul class="doc-list">
    <li><strong>Convert HEIC to JPEG</strong> und <strong>Convert videos to MP4</strong> greifen nur, wenn Sie sie einschalten.</li>
    <li>Lassen Sie beide aus, wenn Sie die Originalformate des Handys hochladen wollen.</li>
    <li><strong>Preserve original media file names</strong> behält den Kameranamen bei, wenn aktiv.</li>
  </ul>
  <p class="doc-block-intro">KM0 legt keine zusätzliche Rekompression über die OpenCloud-App. Was Sie in der App einstellen, zählt gegen Ihre 150 GB.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Wiederherstellung</p>
  <h2 class="doc-block-heading">Wenn das Handy kaputt oder verloren ist</h2>
  <ol class="doc-list">
    <li>Auf einem anderen Handy oder Computer öffnen Sie <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a> oder die OpenCloud-App.</li>
    <li>Melden Sie sich mit demselben Konto an.</li>
    <li>Öffnen Sie den Upload-Ordner und laden Sie die Fotos herunter, oder aktivieren Sie Auto Upload auf dem neuen Gerät mit demselben (oder einem neuen) Ordner.</li>
  </ol>
  <p class="doc-block-intro">App entfernen oder abmelden löscht keine bereits in KM0 Cloud gespeicherten Dateien. Optionale lokale Cache-Bereinigung betrifft nur Downloads auf dem Gerät; Serverdateien bleiben.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Speicher</p>
  <h2 class="doc-block-heading">Reichen 150 GB?</h2>
  <p class="doc-block-intro">Viele Kameras erzeugen große Originale. Tausende moderne Fotos können 150 GB füllen. Prüfen Sie den Gerätespeicher oder laden Sie einen Probenmonat hoch und rechnen Sie hoch. Mehr Bedarf? Kontaktieren Sie uns, bevor Sie sich auf ein Teilbackup verlassen. Verwandt: <a href="/de/tutorials/desktop-sync/">Desktop-Sync</a>, <a href="/de/guides/protect-family-photos/">Familienfotos schützen</a>.</p>
</section>
