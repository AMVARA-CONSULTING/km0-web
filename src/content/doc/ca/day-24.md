---
title: "Dia 24 - Maestro: operar la flota des de Discord"
description: "Com operem KM0 amb Maestro: catàleg de projectes, fils persistents, OpenCloud com a hangar i traces a Redmine."
pubDate: 2026-09-04
locale: ca
image: /brand/maestro-og.png
portrait: /brand/maestro.png
imageAlt: "Retrat de Maestro, l'orquestrador Discord de KM0"
---

KM0 inclou webs, correu, auth, OpenCloud, monitors i una desena d'hosts. Maestro és el bot de Discord amb què seguim la feina entre servidors i projectes.

## Com era abans

Cada arranjament començava igual: obrir el terminal, entrar al servidor correcte, recordar la ruta del repo, reconstruir el context de memòria i engegar un agent nou amb el prompt des de zero. En tancar la sessió, aquell context desapareixia.

Amb desenes de projectes (km0-web, OpenCloud, mail, auth i la resta del perímetre Amvara), el temps se n'anava a tornar a trobar el mapa.

## Què fa

Maestro va lligat a un catàleg de projectes. Rep l'ordre (comanda o llenguatge natural), carrega el context del cas, obre una sessió a l'arbre correcte i entra a l'host per SSH. El fil de Discord queda unit a aquesta sessió.

Amb el fil obert pots deixar la feina el dilluns, enganxar un log el dijous i continuar sense tornar a explicar l'entorn. En tancar queda un resum del que s'ha fet. Si el cas ho demana, també una nota a Redmine.

## Com l'usem

Així operem la casa.

1. Catàleg i context. Cada projecte (aquest lloc és a `/opt/km0-web`) té rutes, runbooks i regles. Maestro treballa el que està registrat i no inventa hosts.
2. Hangar OpenCloud. L'espai `maestro@km0digital.com` per WebDAV (`human_input/`, `maestro_input/`) mou logs llargs, captures i lliurables que Discord no ha de guardar, sense barallar-se amb el TTL del xat.
3. Traçabilitat. Notes a Redmine en anglès tècnic (Textile), lligades al tiquet del projecte. El xat ja no és l'únic arxiu.

També llegeix adjunts (imatges, PDF, logs), crida eines ja desplegades a la flota (navegador headless, entre d'altres) i torna captures al mateix fil. Si una cosa no és al catàleg, Maestro no la toca. És una regla de seguretat.

## Per què és al blog

Aquest blog explica com es construeix i es manté la infra darrere de Cloud i Mail. Maestro hi entra: sessió, resum i tiquet, en lloc d'un arranjament en una shell que ningú no torna a obrir.

El camí és Discord, després el nucli (catàleg i sessió), després SSH a l'host. Si cal, hi ha un pont de reserva amb les seves normes.

Cloud i Mail segueixen a la [UE](/ca/#services). Si vols veure com treballem o provar el producte, [contacta](/ca/#contact) o vine a una [trobada](/ca/meeting/). El dia a dia de la flota, quan cal, comença amb un missatge a Discord.
