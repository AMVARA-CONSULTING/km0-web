---
title: "Dia 0 - Fonaments del servidor"
description: "Debian, particions, Docker, Nginx i base reproducible: el dia dedicat a fer l'stack KM0 auditable i operable."
pubDate: 2026-05-21
locale: ca
---

El dia 0 és de **fonaments**. Sense un sistema operatiu i un entorn de treball reproducibles, qualsevol stack posterior queda fràgil i difícil d'auditar.

Objectiu del dia: Debian estable, disc ordenat, eines mínimes però suficients, i una consola que convidi a documentar cada canvi.

## Pla d'arrencada

KM0 busca infraestructura operable per l'equip, sense panells propietaris opacs:

- **Sistema:** VPS amb Debian actualitzat; particions que separen sistema i dades quan calen còpies clares.
- **Col·laboració:** [OpenCloud](https://cloud.km0digital.com) en imatge oficial d'[OpenCloud.eu](https://opencloud.eu), amb volums estables (`COMPOSE_PROJECT_NAME`) independents del directori de Compose.
- **Perímetre:** Nginx com a únic frontal HTTPS; Docker publica HTTP només a `127.0.0.1`.
- **Web:** Astro dockeritzat en un altre port loopback; vhosts separats per a `km0digital.com` i `cloud.km0digital.com`.
- **Operació:** logs rotats (`json-file`), runbooks amb `docker compose ps`, `logs`, `pull`, i còpies de volums comprimides.
- **Següent enduriment:** TLS de producció, còpies automatitzades i Fail2ban per jails concrets.

## Disc i Debian

Es va triar **Debian** per predictibilitat de paquets i documentació per a administració manual, sense panells obligatoris. El primer pas va ser revisar el layout del disc:

- Separar dades del projecte del sistema de fitxers arrel quan calgui fer backup per volum.
- Definir muntatges amb criteri: `/var/lib/docker` pot concentrar l'I/O d'OpenCloud segons la mida del VPS.
- Documentar quins muntatges són persistents davant del sistema operatiu.

> El mapa exacte de particions depèn del proveïdor i de la mida contractada. Ha de quedar a la wiki o runbook del projecte, no només en aquest blog.

## Programari base

Es va instal·lar el mínim raonable per a administració remota segura i Docker:

- Utilitats habituals: `curl`, editors, xarxa i diagnòstic
- **Docker Engine** amb logs rotatius a `/etc/docker/daemon.json`
- **Nginx** des de paquets del sistema com a frontal
- **Certbot** i TLS segons fase (HTTP-01 o certificat autofirmat al laboratori)

Cada peça té un rol comprovable: `systemctl status`, `nginx -t`, `docker compose ps`.

## Consola

Per a sessions SSH consistents es va aplicar la guia [initialConfiguration](https://wiki.ldeluipy.es/initialConfiguration.html) del wiki:

- Prompt de Bash llegible (ruta, estat de l'ordre, pistes visuals)
- Historial i opcions segures que redueixen errors repetits
- Aliases i `PATH` orientats a Compose i Git sota `/opt/...`

Aquesta base, documentada fora del servidor, permet repetir el mateix motlle en altres VPS.

## cursor-agent

Es va instal·lar **cursor-agent** per apropar el treball diari al flux assistit: revisions, scripts auxiliars i documentació incremental des de la consola.

No substitueix la revisió humana. Redueix fricció en tasques repetibles (overlays de Compose, validar Nginx abans de recarregar).

## Tancament del dia 0

En acabar, el servidor hauria de ser:

1. **Auditable:** layout de disc i paquets coneguts
2. **Repetible:** passos principals enllaçats amb wiki i runbooks
3. **Llest** per a Docker sense exposar serveis al públic abans d'hora

El **dia 1** materialitza OpenCloud, el virtual host del proxy i la web KM0 amb TLS. Mentrestant, explora els [serveis](/ca/#services) o [escriu-nos](/ca/#contact) si vols col·laborar.
