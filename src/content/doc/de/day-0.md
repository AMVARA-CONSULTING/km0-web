---
title: "Tag 0 - Server-Grundlagen"
description: "Debian, Partitionierung, Docker, Nginx und eine reproduzierbare Basis, damit der KM0-Stack auditierbar und betriebsfähig bleibt."
pubDate: 2026-05-21
locale: de
---

Tag 0 liefert die **Grundlagen**: reproduzierbares Debian, klares Disk-Layout, Docker-bereite Werkzeuge und eine dokumentierte Shell. Ohne diese Basis bleibt jeder spätere Stack fragil und schwer auditierbar.

Ziel des Tages: ein VPS, den jedes Teammitglied aus Wiki und Runbooks auditieren und neu aufbauen kann, nicht aus dem Gedächtnis.

## Bootstrap-Plan

KM0 zielt auf Infrastruktur, die das Team ohne undurchsichtige proprietäre Panels betreiben kann:

- **System:** VPS mit aktuellem Debian; Partitionen, die System und Daten trennen, wenn Backups Klarheit brauchen.
- **Zusammenarbeit:** [OpenCloud](https://cloud.km0digital.com) auf dem offiziellen [OpenCloud.eu](https://opencloud.eu)-Image, mit stabilen Volumes (`COMPOSE_PROJECT_NAME`) unabhängig vom Compose-Arbeitsverzeichnis.
- **Perimeter:** Nginx als alleiniges HTTPS-Frontend; Docker veröffentlicht HTTP nur auf `127.0.0.1`.
- **Website:** Dockerisiertes Astro auf einem weiteren Loopback-Port; getrennte VHosts für `km0digital.com` und `cloud.km0digital.com`.
- **Betrieb:** rotierte `json-file`-Logs, Runbooks (`docker compose ps`, `logs`, `pull`), komprimierte Volume-Backups.
- **Nächste Härtung:** Produktions-TLS, automatisierte Backups, Fail2ban pro konkretem Jail.

## Festplatte und Debian

**Debian** wurde wegen vorhersehbarer Pakete und dokumentierbarer Handarbeit gewählt, ohne Pflicht-Panels. Erster Schritt: Disk-Layout prüfen.

- Projektdaten vom Root-Dateisystem trennen, wenn Backups auf Volume-Ebene nötig sind.
- Mounts bewusst setzen: `/var/lib/docker` kann OpenCloud-I/O je nach VPS-Größe dominieren.
- Dokumentieren, welche Mounts persistent sind und was zum Betriebssystem gehört.

> Exakte Partitionskarten hängen von Anbieter und gebuchter Größe ab. Sie gehören in Wiki oder Runbook des Projekts, nicht nur in diesen Beitrag.

## Basissoftware

Ein vernünftiges Minimum für sichere Fernverwaltung und Docker:

- Übliche Utilities: `curl`, Editoren, Netz und Diagnose
- **Docker Engine** mit Log-Rotation in `/etc/docker/daemon.json`
- **Nginx** aus Systempaketen als Frontend
- **Certbot** und TLS je nach Phase (HTTP-01 oder selbstsigniert im Labor)

Jedes Stück sollte prüfbar sein: `systemctl status`, `nginx -t`, `docker compose ps`.

## Shell-Ergonomie

Für konsistente SSH-Sitzungen wurde die Wiki-Anleitung [initialConfiguration](https://wiki.ldeluipy.es/initialConfiguration.html) angewendet:

- Lesbarer Bash-Prompt (Pfad, Exit-Status, visuelle Hinweise)
- History und sichere Defaults, die wiederholte Fehler reduzieren
- Aliase und `PATH` für Compose und Git unter `/opt/...`

Die Vorlage außerhalb des Servers dokumentieren, damit andere VPS sie wiederverwenden können.

## cursor-agent

**cursor-agent** wurde für assistierte CLI-Arbeit installiert: Reviews, Hilfsskripte und inkrementelle Dokumentation aus der Konsole.

Es ersetzt keine menschliche Prüfung. Es senkt Reibung bei wiederholbaren Aufgaben (Compose-Overlays, Nginx vor dem Reload prüfen).

## Abschluss Tag 0

Am Ende des Tages sollte der Server sein:

1. **Auditierbar:** bekanntes Disk-Layout und Pakete
2. **Wiederholbar:** Hauptschritte mit Wiki und Runbooks verknüpft
3. **Bereit** für Docker, ohne Dienste zu früh öffentlich zu machen

**Tag 1** bringt OpenCloud, den Proxy-VHost und die KM0-Website mit TLS. Nächster Schritt für Leser: [Dienste](/de/#services) oder [Kontakt](/de/#contact).
