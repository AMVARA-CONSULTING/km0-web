---
title: "Tag 21 - Treffen: Daten und autonomes Fahren"
description: "Im Casino del Masnou haben wir Autonomiestufen, Sensoren und den Datenhunger des autonomen Fahrens durchgesprochen."
pubDate: 2026-08-07
locale: de
---

Beim [Treffen am 7. August](/de/meeting/) im Casino del Masnou ging es um **autonomes Fahren und Daten**. Kein Produktpitch: ein Tischgespräch darüber, auf welcher Stufe wir wirklich stehen und warum das Training dieser Systeme absurde Mengen an Information frisst.

## Welche Stufen es gibt (und wo wir stehen)

Die SAE-Skala läuft von **0 bis 5**. Kurzer Überblick:

- **Stufe 0:** der Mensch macht alles.
- **Stufe 1 und 2:** Assistenz (Spurhalten, adaptiver Tempomat). Der Fahrer bleibt verantwortlich. Dort leben die meisten Straßenautos, inklusive Tesla Autopilot / Full Self-Driving im Alltag: das Lenkrad lange loslassen führt zu Warnungen und am Ende zum Abbremsen.
- **Stufe 3:** das Auto kann unter begrenzten Bedingungen fahren (zum Beispiel Autobahn, bis zu einer Geschwindigkeit). Mercedes kam dort mit Drive Pilot in der S-Klasse an; die Haftung in diesem Modus liegt beim Hersteller. Das Paket ist teuer (doppelte Sensoren aus Sicherheitsgründen) und die kommerzielle Aufnahme stockt.
- **Stufe 4:** hohe Automatisierung in einem definierten Bereich. **Waymo**-artige Robotaxis in manchen US-Städten fahren ohne Fahrer an Bord.
- **Stufe 5:** überall, jede Bedingung. Noch kein Konsumprodukt.

Für den durchschnittlichen Käufer bleibt die realistische Decke heute **Stufe 2**. Wer Stufe 4 anstrebt, braucht eine andere Größenordnung an Sensoren und Rechenleistung.

## Zwei Sensor-Philosophien

Zwei klare Ansätze:

1. **Vor allem Kameras** (Tesla-Stil): günstiger, aber anfällig bei Nebel, Starkregen, tiefstehender Sonne oder Nacht.
2. **Sensorfusion** (Kameras + Lidar + Radar, wie Waymo): robuster und deutlich teurer in Bau und Synchronisation.

Ein Lidar „sieht“ hunderte Meter; mehrere Lidars, Radare und ein Dutzend Kameras erzeugen **Terabyte pro Tag und Auto**. Diese Signale in Echtzeit zu synchronisieren ist ein Computer auf Rädern, kein Zubehör.

## Daten, Regeln und KI

Flotten auf der Straße (vor allem Tesla) sammeln jeden Tag Kilometer; das speist das Training. Wer diese Telemetrie nicht in großem Maßstab behält, kann bei Fahrmodellen nicht mithalten.

Mercedes hat viel von Stufe 3 mit **handgeschriebenen Regeln** gebaut (hunderttausende Zeilen C), bevor generative KI Alltag war. Teile der Branche pausieren Stufe 3, bleiben bei 2 und zielen mit neuronalen Netzen auf 4: Regelcode verwerfen und neu trainieren. Training kostet Rechenzentrumsenergie in Stadtgröße; das Modell ins Auto zu bringen bleibt der Engpass.

## Abschluss

Wenn dich das Gespräch interessiert (Daten, KI oder wie wir KM0 betreiben), komm zum nächsten [Treffen](/de/meeting/). Dazwischen bleiben Cloud und Mail in der [EU](/de/#services).
