---
title: "Tag 24 - Maestro: die Flotte von Discord aus betreiben"
description: "Wie wir KM0 mit Maestro betreiben: Projektkatalog, persistente Threads, OpenCloud als Hangar und Spuren in Redmine."
pubDate: 2026-09-04
locale: de
image: /brand/maestro-og.png
portrait: /brand/maestro.png
imageAlt: "Porträt von Maestro, dem Discord-Orchestrierer von KM0"
---

KM0 umfasst Websites, Mail, Auth, OpenCloud, Monitore und etwa zehn Hosts. Maestro ist der Discord-Bot, mit dem wir die Arbeit zwischen Servern und Projekten weiterführen.

## Vorher

Jeder Fix begann gleich: Terminal öffnen, den richtigen Server betreten, den Repo-Pfad erinnern, den Kontext aus dem Gedächtnis neu aufbauen und einen neuen Agenten mit Prompt von null starten. Am Ende der Session war der Kontext weg.

Bei Dutzenden Projekten (km0-web, OpenCloud, Mail, Auth und dem Rest des Amvara-Perimeters) ging die Zeit dafür drauf, die Karte wiederzufinden.

## Was er tut

Maestro hängt an einem Projektkatalog. Er nimmt die Anweisung (Slash-Befehl oder natürliche Sprache), lädt den Fallkontext, öffnet eine Session im richtigen Baum und erreicht den Host per SSH. Der Discord-Thread bleibt an diese Session gebunden.

Solange der Thread offen ist, kannst du die Arbeit am Montag liegen lassen, am Donnerstag ein Log anhängen und weitermachen, ohne die Umgebung neu zu erklären. Beim Schließen bleibt eine Zusammenfassung. Wenn der Fall es braucht, auch eine Redmine-Notiz.

## Wie wir ihn nutzen

So betreiben wir das Haus.

1. Katalog und Kontext. Jedes Projekt (diese Site liegt unter `/opt/km0-web`) hat Pfade, Runbooks und Regeln. Maestro arbeitet nur Registriertes und erfindet keine Hosts.
2. OpenCloud-Hangar. Der Space `maestro@km0digital.com` über WebDAV (`human_input/`, `maestro_input/`) schiebt lange Logs, Screenshots und Deliverables, die Discord nicht behalten soll, ohne gegen die Chat-TTL zu kämpfen.
3. Nachverfolgbarkeit. Redmine-Notizen in technischem Englisch (Textile), an das Projektticket gebunden. Der Chat ist nicht mehr das einzige Archiv.

Er liest auch Anhänge (Bilder, PDF, Logs), ruft schon deployte Werkzeuge in der Flotte auf (Headless-Browser und andere) und gibt Captures im selben Thread zurück. Steht etwas nicht im Katalog, fasst Maestro es nicht an. Das ist eine Sicherheitsregel.

## Warum es im Blog steht

Dieses Blog beschreibt, wie die Infra hinter Cloud und Mail gebaut und gehalten wird. Maestro gehört dazu: Session, Zusammenfassung und Ticket, statt eines Fixes in einer Shell, die niemand wieder öffnet.

Der Weg ist Discord, dann der Kern (Katalog und Session), dann SSH zum Host. Bei Bedarf gibt es eine Backup-Brücke mit eigenen Regeln.

Cloud und Mail bleiben in der [EU](/de/#services). Wenn du sehen willst, wie wir arbeiten, oder das Produkt testen willst, [schreib uns](/de/#contact) oder komm zu einem [Treffen](/de/meeting/). Der Flottenalltag beginnt, wenn es drauf ankommt, mit einer Discord-Nachricht.
