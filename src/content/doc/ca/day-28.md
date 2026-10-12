---
title: "Dia 28 - Una porta d’entrada més neta per a l’HTTPS públic"
description: "Hem posat un reverse proxy davant de la vora pública per unificar TLS i l’encaminament, amb pàgina de manteniment a punt, sense canviar les URL de Cloud."
pubDate: 2026-10-05
locale: ca
---

El 5 d’octubre vam canviar com arriba l’HTTPS públic a l’host de KM0. Un reverse proxy queda a la porta dels ports 80 i 443. Nginx continua fent el que sap fer; la vora s’entén millor.

## Què vol dir per a tu

- Les mateixes URL públiques. Cloud, el lloc de màrqueting i la resta mantenen els noms que ja uses.
- La terminació TLS i l’encaminament viuen en un sol lloc a la vora.
- Podem activar una pàgina de manteniment sense reescriure cada lloc a mà.

## Per què molestar-se

Menys sorpreses en tallar identitat o afegir un servei. Qui llegeix no necessita la fontaneria; qui opera necessita una porta que obri igual cada vegada.

## Estat

Si les adreces d’interès continuen obrint, fet. Problemes d’HTTPS aquell dia: [contacte](/ca/#contact).
