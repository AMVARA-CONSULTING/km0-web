---
title: "Dia 24 - Maestro: operar la flota des de Discord"
description: "Com operem KM0 amb Maestro: catàleg de projectes, fils persistents, OpenCloud com a hangar i traces a Redmine."
pubDate: 2026-09-04
locale: ca
image: /brand/maestro-og.png
portrait: /brand/maestro.png
imageAlt: "Retrat de Maestro, l'orquestrador Discord de KM0"
---

Operar KM0 no és només publicar Cloud i Mail. Hi ha webs, correu, auth, OpenCloud, monitors i un munt d'hosts. **Maestro** és l'orquestrador que fem servir a Discord per no perdre el fil entre servidors i projectes.

## El problema que resolia

Abans, cada arranjament començava igual: obrir terminal, entrar al servidor correcte, recordar on era el repo, reconstruir el context de memòria i engegar un agent efímer amb el prompt des de zero. En tancar la sessió, aquell context s'evaporava.

Amb ~10 hosts i desenes de projectes (km0-web, OpenCloud, mail, auth i la resta del perímetre Amvara), això no escala. El cost real no era teclejar ordres: era **reencontrar el mapa** cada vegada.

## Què és Maestro

Un bot a Discord lligat a un catàleg de projectes. Rep l'ordre (comanda o llenguatge natural), carrega el context del cas, obre una sessió enfocada a l'arbre correcte i arriba a l'host per SSH. El fil de Discord queda unit a aquesta sessió.

Mentre el fil estigui obert, pots deixar la feina el dilluns, enganxar un log el dijous i continuar sense reexplicar l'entorn. En tancar el fil, queda un resum del fet; si el cas ho demana, també una nota a Redmine.

## Què aporta a KM0

No és un producte de la botiga: és la manera com operem la casa. Tres peces concretes:

1. **Catàleg i context:** cada projecte (per exemple aquest lloc a `/opt/km0-web`) té pack de rutes, runbooks i regles. Maestro no inventa hosts; només treballa el que està registrat.
2. **Hangar OpenCloud:** espai `maestro@km0digital.com` via WebDAV (`human_input/`, `maestro_input/`). Serveix per passar fitxers que Discord no ha de retenir (logs llargs, captures, lliurables) sense barallar-se amb el TTL del xat.
3. **Traçabilitat:** notes a Redmine en anglès tècnic (Textile), lligades al tiquet del projecte. El xat deixa de ser l'únic arxiu de memòria.

També pot llegir adjunts (imatges, PDF, logs), invocar eines ja desplegades a la flota (navegador headless, etc.) i tornar captures al mateix fil. El que no és al catàleg no existeix per a ell: és una regla de seguretat, no un límit de màrqueting.

## Per què ho expliquem aquí

El blog de KM0 documenta com es construeix i es manté la infra, no només el pitch comercial. Maestro encaixa amb aquesta línia: **operació audible**, amb sessió, resum i tiquet, en lloc de “algú ho va arreglar en una shell oblidada”.

El flux és clar: Discord → nucli (catàleg + sessió) → SSH a l'host; si cal, un pont de reserva amb les seves pròpies normes.

## Tancament

Cloud i Mail segueixen a la [UE](/ca/#services). Si vols veure com treballem o provar el producte, [contacta](/ca/#contact) o vine a una [trobada](/ca/meeting/). El dia a dia de la flota, quan cal, passa per un missatge a Discord: això és Maestro.
