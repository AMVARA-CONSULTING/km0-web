---
title: "Tag 24 - Maestro: die Flotte von Discord aus betreiben"
description: "Wie wir KM0 mit Maestro betreiben: Projektkatalog, persistente Threads, OpenCloud als Hangar und Spuren in Redmine."
pubDate: 2026-09-04
locale: de
image: /brand/maestro-og.png
portrait: /brand/maestro.png
imageAlt: "Porträt von Maestro, dem Discord-Orchestrierer von KM0"
---

KM0 zu betreiben heißt mehr als Cloud und Mail auszuliefern. Es gibt Websites, Mail, Auth, OpenCloud, Monitore und einen Haufen Hosts. **Maestro** ist der Discord-Orchestrierer, mit dem wir den Faden zwischen Servern und Projekten nicht verlieren.

## Das Problem, das er löste

Früher begann jeder Fix gleich: Terminal öffnen, richtigen Server betreten, Repo-Pfad erinnern, Kontext aus dem Gedächtnis neu aufbauen und einen Wegwerf-Agenten mit Prompt von null starten. Am Ende der Session war der Kontext weg.

Mit ~10 Hosts und Dutzenden Projekten (km0-web, OpenCloud, Mail, Auth und dem Rest des Amvara-Perimeters) skaliert das nicht. Die echten Kosten waren nicht Tippen: es war **jedes Mal die Karte wiederfinden**.

## Was Maestro ist

Ein Discord-Bot an einen Projektkatalog gebunden. Er nimmt die Order (Slash-Befehl oder natürliche Sprache), lädt den Fallkontext, öffnet eine fokussierte Session im richtigen Baum und erreicht den Host per SSH. Der Discord-Thread bleibt an diese Session gebunden.

Solange der Thread offen ist, kannst du die Arbeit am Montag liegen lassen, am Donnerstag ein Log anhängen und weitermachen, ohne die Umgebung neu zu erklären. Beim Schließen bleibt eine Zusammenfassung; wenn der Fall es braucht, auch eine Redmine-Notiz.

## Was er KM0 gibt

Kein Shop-Produkt: so betreiben wir das Haus. Drei konkrete Teile:

1. **Katalog und Kontext:** jedes Projekt (zum Beispiel diese Site unter `/opt/km0-web`) hat ein Pack aus Pfaden, Runbooks und Regeln. Maestro erfindet keine Hosts; er arbeitet nur Registriertes.
2. **OpenCloud-Hangar:** Space `maestro@km0digital.com` über WebDAV (`human_input/`, `maestro_input/`). Für Dateien, die Discord nicht behalten soll (lange Logs, Screenshots, Deliverables), ohne Chat-TTL zu bekämpfen.
3. **Nachverfolgbarkeit:** Redmine-Notizen in technischem Englisch (Textile), an das Projektticket gebunden. Der Chat ist nicht mehr das einzige Gedächtnisarchiv.

Er kann auch Anhänge lesen (Bilder, PDF, Logs), schon deployed Tools in der Flotte aufrufen (Headless-Browser usw.) und Captures im selben Thread zurückgeben. Was nicht im Katalog steht, existiert für ihn nicht: Sicherheitsregel, kein Marketing-Limit.

## Warum wir es hier schreiben

Der KM0-Blog dokumentiert, wie die Infra gebaut und gehalten wird, nicht nur den Verkaufspitch. Maestro passt dazu: **hörbare Operation**, mit Session, Zusammenfassung und Ticket, statt „jemand hat es in einer vergessenen Shell gefixt“.

Der Ablauf ist klar: Discord → Kern (Katalog + Session) → SSH zum Host; bei Bedarf eine Backup-Brücke mit eigenen Regeln.

## Abschluss

Cloud und Mail bleiben in der [EU](/de/#services). Wenn du sehen willst, wie wir arbeiten, oder das Produkt testen willst, [schreib uns](/de/#contact) oder komm zu einem [Treffen](/de/meeting/). Der Flottenalltag, wenn es drauf ankommt, beginnt mit einer Discord-Nachricht: das ist Maestro.
