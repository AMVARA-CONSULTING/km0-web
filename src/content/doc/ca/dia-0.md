---
title: "Dia 0 — Fonaments del servidor"
description: "Debian, particions, Docker, Nginx i base reproducible: el dia dedicat a fer l'stack KM0 auditable i operable."
pubDate: 2026-05-21
locale: ca
---

El dia 0 està dedicat als **fonaments**: sense una base reproducible del sistema operatiu i de l'entorn de treball, qualsevol stack posterior seria fràgil i difícil d'auditar. L'objectiu és sortir del dia amb Debian estable, disc ordenat, eines mínimes però suficients i una consola que convidi a documentar cada canvi.

## Pla tècnic de l'arrencada (visió completa)

KM0 persegueix una infraestructura que pugui ser operada per persones de l'equip sense dependre de panells propietaris opacs:

- **Sistema:** VPS amb Debian actualitzat, esquema de particions que separa sistema de dades quan té sentit al projecte (facilita snapshots i polítiques de còpia de seguretat).
- **Col·laboració:** [OpenCloud](https://cloud.km0.amvara.de) desplegat com a conjunt de microserveis coordinats dins d'una imatge oficial mantinguda per la comunitat [OpenCloud.eu](https://opencloud.eu), amb volums nomenats de forma estable (`COMPOSE_PROJECT_NAME`) perquè les còpies no depenguin del directori des del qual s'executa Compose.
- **Perímetre:** Nginx com a únic frontal HTTPS; overlays Docker que publiquen HTTP només a `127.0.0.1`.
- **Comunicació:** Lloc Astro dockeritzat servint estàtics en un altre port loopback; virtual hosts independents per a màrqueting (`km0.amvara.de`) i cloud (`cloud.km0.amvara.de`).
- **Observabilitat i manteniment:** logs de contenidor rotats (`json-file` amb mida màxima), ordres habituals documentades en runbooks (`docker compose ps` / `logs` / `pull`), còpies de volums com a artefactes comprimits.
- **Evolució:** espai per endureir TLS entre microserveis interns quan els certificats siguin totalment fiables en cadena (passar de mode prova a producció), automatitzar còpies de seguretat i endureir polítiques Fail2ban per jails específics.

## Provisionament del VPS i particions

Es va triar un servidor amb **Debian** per la predictibilitat del cicle de paquets i l'amplia documentació per a administració manual (sense panells obligatoris). El primer pas va ser revisar el layout del disc i crear particions coherents amb l'ús previst:

- Separació que permeti créixer dades del projecte sense barrejar-les amb el sistema de fitxers arrel quan calgui fer còpia per volum.
- Criteris clars per a muntatges (`/var/lib/docker` pot concentrar l'I/O d'OpenCloud segons la mida del VPS).
- Convencions documentades perquè qualsevol persona de l'equip reconegui quin muntatge correspon a dades persistents o al sistema.

Els detalls exactes del mapa de particions són específics del proveïdor i de la mida contractada; el que importa és que quedin documentats fora del blog a la wiki o runbook del projecte per a recuperació davant fallades.

## Programari base

Es va instal·lar el conjunt mínim raonable per a administració segura remota i per construir sobre Docker sense “pes mort” innecessari:

- Eines de sistema habituals (`curl`, editors, utilitats de xarxa i diagnòstic).
- **Docker Engine** amb política de logs rotatius (`/etc/docker/daemon.json`) perquè els registres no ocupin tot el disc.
- **Nginx** des de paquets del sistema com a frontal estable.
- **Certbot** / estratègia TLS segons la fase del projecte (emissió inicial HTTP-01 o certificat provisional autofirmat per a laboratori).

La filosofia és que cada component té un rol únic i observable a l'arbre de dependències del sistema (`systemctl status`, `nginx -t`, `docker compose ps`).

## Ergonòmica del shell i configuració inicial reproducible

Perquè les sessions SSH posteriors siguin consistents es van aplicar millores guiades per la documentació interna [initialConfiguration](https://wiki.ldeluipy.es/initialConfiguration.html) del wiki:

- Prompt de Bash més llegible (directori actual, estat de l'ordre, pistes visuals).
- Ajustos que redueixen errors repetits (historial útil, opcions segures per defecte on calgui).
- Convencions per a àlies i `PATH` que anticipen el treball amb Docker Compose i Git des de `/opt/...`.

Tenir aquesta base escrita fora del servidor permet repetir el mateix motlle en altres VPS del projecte sense improvisar cada vegada.

## cursor-agent

Es va instal·lar **cursor-agent** per acostar el flux de treball del dia a dia al de l'entorn de desenvolupament assistit: revisions automatitzades, generació de scripts auxiliars i documentació incremental sense abandonar la línia d'ordres del servidor.

No substitueix la revisió humana ni els controls de canvi de l'equip, però redueix fricció quan cal repetir tasques verificables (actualitzar overlays de Compose, validar sintaxi de Nginx abans de recarregar, etc.).

## Estat al tancament del dia 0

En acabar el dia el servidor compleix tres propietats:

1. **És auditable:** layout de disc i paquets coneguts.
2. **És repetible:** els passos principals enllacen amb wiki i runbooks.
3. **Està llest** per a càrregues Docker sense exposar serveis prematurament al públic.

El **dia 1** aprofita aquesta base per materialitzar OpenCloud, el virtual host del proxy i la web KM0 ja enllaçades per TLS. Mentrestant, pots explorar els [serveis](/ca/#servicios) publicats o [escriure'ns](/ca/#contacto) si vols col·laborar.
