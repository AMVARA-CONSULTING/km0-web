---
title: "Dia 21 - Trobada: dades i conducció autònoma"
description: "Al Casino del Masnou vam repassar nivells d'autonomia, sensors i per què les dades d'entrenament manen al cotxe autònom."
pubDate: 2026-08-07
locale: ca
---

A la [trobada del 7 d'agost](/ca/meeting/) al Casino del Masnou vam parlar de **conducció autònoma i dades**. No va ser un pitch de producte: va ser una taula per entendre en quin nivell som de debò i per què entrenar aquests sistemes consumeix quantitats absurdes d'informació.

## Quins nivells hi ha (i on som)

L'escala SAE va del **0 al 5**. Resum útil:

- **Nivell 0:** l'humà ho fa tot.
- **Nivell 1 i 2:** assistència (manteniment de carril, control de velocitat adaptatiu). El conductor continua sent responsable. Aquí viuen la majoria de cotxes de carrer, inclòs l'Autopilot / Full Self-Driving de Tesla en ús quotidià: no pots deixar el volant gaire estona o el cotxe avisa i acaba frenant.
- **Nivell 3:** el cotxe pot portar la conducció en condicions acotades (per exemple autopista i fins a certa velocitat). Mercedes hi va arribar amb Drive Pilot a la Classe S; la responsabilitat en aquest mode és del fabricant. El paquet és car (sensors duplicats per seguretat) i l'adopció comercial s'ha frenat.
- **Nivell 4:** automatització alta en un domini concret. Els robotaxis tipus **Waymo** en algunes ciutats dels EUA operen sense conductor a bord.
- **Nivell 5:** qualsevol lloc, qualsevol condició. Encara no és el producte de consum.

Avui, per al comprador mitjà, el sostre realista segueix sent el **nivell 2**. Qui apunta al 4 necessita una altra escala de sensors i de computació.

## Dues filosofies de sensors

Hi ha dos enfocaments clars:

1. **Sobretot càmeres** (filosofia Tesla): més barat, però fràgil amb boira, pluja forta, sol baix o nit.
2. **Fusió de sensors** (càmeres + lidar + radar, com Waymo): més robust i molt més car de fabricar i de sincronitzar.

Un lidar "mira" cents de metres; diversos lidars, radars i una dotzena de càmeres generen **terabytes al dia per cotxe**. Sincronitzar aquestes senyals en temps real és una màquina amb rodes, no un accessori.

## Dades, regles i IA

Les flotes ja en circulació (sobretot Tesla) acumulen quilòmetres cada dia; això alimenta l'entrenament. Qui no guarda aquesta telemetria a escala no pot competir en models de conducció.

Mercedes va construir molt del nivell 3 amb **regles escrites a mà** (cents de milers de línies en C) abans que la IA generativa fos quotidiana. Part del sector està pausant el 3, quedant-se al 2 i mirant al 4 amb xarxes neuronals: llençar codi de regles i entrenar de nou. Entrenar costa energia de data center a escala de ciutat; desplegar el model al cotxe continua sent el coll d'ampolla.

## Tancament

Si t'interessa la conversa (dades, IA, o com operem KM0), vine a la propera [trobada](/ca/meeting/). Entremig, Cloud i Mail segueixen a la [UE](/ca/#services).
