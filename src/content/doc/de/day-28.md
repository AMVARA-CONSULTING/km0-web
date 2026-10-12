---
title: "Tag 28 - Sauberere Haustür für öffentliches HTTPS"
description: "Reverse-Proxy vor der öffentlichen Kante: TLS und Routing an einer Stelle, Wartungsseite bereit, Cloud-URLs unverändert."
pubDate: 2026-10-05
locale: de
---

Am 5. Oktober haben wir geändert, wie öffentliches HTTPS den KM0-Host erreicht. Ein Reverse-Proxy sitzt jetzt an der Tür für Port 80 und 443. Nginx macht weiter, was es gut kann; die Kante ist einfacher zu verstehen.

## Was das für euch heißt

- Dieselben öffentlichen URLs. Cloud, Marketingseite und der Rest behalten die bekannten Namen.
- TLS-Terminierung und Routing liegen an einer Stelle an der Kante.
- Eine Wartungsseite lässt sich einschalten, ohne jede Site von Hand umzuschreiben.

## Warum der Aufwand

Weniger Überraschungen bei Identity-Cutover oder neuen Diensten. Leser brauchen die Rohre nicht; Betrieb braucht eine Tür, die jedes Mal gleich öffnet.

## Status

Wenn Lesezeichen noch öffnen: fertig. HTTPS-Probleme an dem Tag: [Kontakt](/de/#contact).
