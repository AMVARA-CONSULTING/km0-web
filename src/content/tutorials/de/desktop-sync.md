---
title: "So funktioniert Desktop-Sync bei KM0 Cloud"
description: "Selektive Sync, Online-Dateien unter Windows, was beim Unsync oder Unlink passiert, und warum es kein Known Folder Move gibt."
locale: de
order: 7
platform: desktop
---

<section class="doc-lead-block">
  <p class="doc-block-title">Einführung</p>
  <p class="doc-lead">KM0 Cloud nutzt den <strong>OpenCloud Desktop Client</strong> unter Windows, macOS und Linux. Sync hält einen lokalen Ordner mit Ihrem EU-Konto auf dem gleichen Stand. Der öffentliche Tarif umfasst <strong>150 GB</strong>. Ist Ihre Bibliothek größer, klären Sie Kapazität vor einer großen Migration.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Voraussetzungen</p>
  <h2 class="doc-block-heading">Desktop-Client installieren</h2>
  <ol class="doc-list">
    <li>Laden Sie den offiziellen OpenCloud Desktop Client für Ihr System von den <a href="https://github.com/opencloud-eu/desktop/releases" target="_blank" rel="noopener noreferrer">OpenCloud-Desktop-Releases</a> herunter.</li>
    <li>Installieren Sie ihn, öffnen Sie den Client und geben Sie die Server-URL ein: <code>https://cloud.km0digital.com/</code>.</li>
    <li>Melden Sie sich mit derselben Methode wie im Browser an.</li>
  </ol>
  <p class="doc-block-intro">Herstellerdokumentation: <a href="https://docs.opencloud.eu/docs/user/desktop-client/" target="_blank" rel="noopener noreferrer">OpenCloud Desktop Client</a>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Selektive Sync</p>
  <h2 class="doc-block-heading">Choose What to Sync (macOS und Linux)</h2>
  <ol class="doc-list">
    <li>Öffnen Sie den Desktop Client und gehen Sie zur Kontoansicht.</li>
    <li>Öffnen Sie das Drei-Punkte-Menü (<strong>…</strong>) neben dem gewünschten Space.</li>
    <li>Wählen Sie <strong>Choose What to Sync</strong> und markieren Sie nur die Ordner, die Sie auf diesem Rechner brauchen.</li>
  </ol>
  <p class="doc-block-intro">Nicht markierte Ordner werden nicht als lokale Sync-Kopie gehalten. Das spart Speicherplatz. Sie bleiben auf dem Server und in der Web-Oberfläche.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Windows</p>
  <h2 class="doc-block-heading">Online-Dateien (Virtual File System)</h2>
  <p class="doc-block-intro">Unter Windows nutzt der Client Platzhalter im Explorer, damit Cloud-Dateien ohne vollständigen Download sichtbar sein können.</p>
  <ul class="doc-list">
    <li><strong>Always keep on this device</strong>: vollständige lokale Kopie, offline verfügbar.</li>
    <li><strong>Available when online</strong>: Platzhalter; Download beim Öffnen.</li>
    <li><strong>Free up space</strong>: entfernt den lokalen Inhalt und lässt die Datei in der Cloud als nur online sichtbar.</li>
  </ul>
  <p class="doc-block-intro">Dokumentation: <a href="https://docs.opencloud.eu/docs/user/desktop-client/windows/sync-settings-win/" target="_blank" rel="noopener noreferrer">Windows-Synchronisationseinstellungen</a>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Grenzen</p>
  <h2 class="doc-block-heading">Kein Known Folder Move</h2>
  <p class="doc-block-intro">OpenCloud Desktop leitet Windows-<strong>Desktop</strong>, <strong>Dokumente</strong> oder <strong>Bilder</strong> <strong>nicht</strong> um wie OneDrive Known Folder Move. Dateien synchronisieren im OpenCloud-Sync-Ordner (und in verbundenen Spaces). Arbeiten Sie aus diesem Ordner oder kopieren Sie bewusst hinein.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Unsync und Unlink</p>
  <h2 class="doc-block-heading">Was mit lokalen Dateien passiert</h2>
  <ul class="doc-list">
    <li><strong>Remove Sync Folder Connection</strong> (Kontomenü unter macOS/Linux): beendet die Sync für diesen Space. Laut offizieller OpenCloud-Dokumentation werden lokale Dateien <strong>nicht</strong> gelöscht. Der Space bleibt auf dem Server.</li>
    <li><strong>Choose What to Sync</strong>: ein abgewählter Ordner wird nicht mehr als lokale Sync-Kopie geführt. Nutzen Sie <strong>Remove Sync Folder Connection</strong>, wenn Sie trennen wollen, ohne die Aktion als Aufräumen des Sync-Baums zu verstehen.</li>
    <li><strong>Zwei-Wege-Sync</strong>: bei aktiver Sync kann das Löschen einer Datei im Sync-Ordner sie auch auf dem Server entfernen. Sync ist kein reines Upload-Backup.</li>
    <li><strong>Free up space</strong> unter Windows: entfernt den lokalen Inhalt dieses Elements; die Datei bleibt in KM0 Cloud.</li>
  </ul>
  <p class="doc-block-intro">Kurz: Unlink oder Entfernen der Sync-Verbindung ist kein Löschen Ihrer lokalen Kopien. Selbst löschen bei aktiver Sync ist etwas anderes. Details: <a href="/de/tutorials/photo-backup/">Foto-Backup und Wiederherstellung</a>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Speicher</p>
  <h2 class="doc-block-heading">150 GB öffentlicher Tarif</h2>
  <p class="doc-block-intro">Der veröffentlichte Tarif ist <strong>150 GB für 1,99 €/Monat</strong>. Eine mehrjährige Fotobibliothek kann das übersteigen. Prüfen Sie die Größe, bevor Sie einen Komplett-Dump planen. Größere Kontingente auf Anfrage (siehe <a href="/de/pricing/">Preise</a> und Kontakt).</p>
</section>
