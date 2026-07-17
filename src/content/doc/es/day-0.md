---
title: "Día 0 - Fundaciones del servidor"
description: "Debian, particiones, Docker, Nginx y base reproducible: el día dedicado a que el stack KM0 sea auditable y operable."
pubDate: 2026-05-21
locale: es
---

El día 0 deja las **fundaciones**: Debian reproducible, disco claro, herramientas listas para Docker y una consola documentada. Sin esa base, cualquier stack posterior queda frágil y difícil de auditar.

Objetivo del día: un VPS que cualquier compañero pueda auditar y reconstruir desde wiki y runbooks, no de memoria.

## Plan de arranque

KM0 busca infraestructura operable por el equipo, sin paneles propietarios opacos:

- **Sistema:** VPS con Debian actualizado; particiones que separan sistema y datos cuando hacen falta backups claros.
- **Colaboración:** [OpenCloud](https://cloud.km0digital.com) en imagen oficial de [OpenCloud.eu](https://opencloud.eu), con volúmenes estables (`COMPOSE_PROJECT_NAME`) independientes del directorio de Compose.
- **Perímetro:** Nginx como único frontal HTTPS; Docker publica HTTP solo en `127.0.0.1`.
- **Web:** Astro dockerizado en otro puerto loopback; vhosts separados para `km0digital.com` y `cloud.km0digital.com`.
- **Operación:** logs rotados (`json-file`), runbooks con `docker compose ps`, `logs`, `pull`, y backups de volúmenes comprimidos.
- **Siguiente endurecimiento:** TLS de producción, copias automatizadas y Fail2ban por jails concretos.

## Disco y Debian

Se eligió **Debian** por predictibilidad de paquetes y documentación para administración manual, sin paneles obligatorios. El primer paso fue revisar el layout del disco:

- Separar datos del proyecto del sistema de ficheros raíz cuando haga falta respaldar por volumen.
- Definir montajes con criterio: `/var/lib/docker` puede concentrar el I/O de OpenCloud según el tamaño del VPS.
- Documentar qué montajes son persistentes frente al sistema operativo.

> El mapa exacto de particiones depende del proveedor y del tamaño contratado. Debe quedar en la wiki o runbook del proyecto, no solo en este blog.

## Software base

Se instaló el mínimo razonable para administración remota segura y Docker:

- Utilidades habituales: `curl`, editores, red y diagnóstico
- **Docker Engine** con logs rotativos en `/etc/docker/daemon.json`
- **Nginx** desde paquetes del sistema como frontal
- **Certbot** y TLS según fase (HTTP-01 o certificado autofirmado en laboratorio)

Cada pieza tiene un rol comprobable: `systemctl status`, `nginx -t`, `docker compose ps`.

## Consola

Para sesiones SSH consistentes se aplicó la guía [initialConfiguration](https://wiki.ldeluipy.es/initialConfiguration.html) del wiki:

- Prompt de Bash legible (ruta, estado del comando, pistas visuales)
- Historial y opciones seguras que reducen errores repetidos
- Aliases y `PATH` orientados a Compose y Git bajo `/opt/...`

Esta base, documentada fuera del servidor, permite repetir el mismo molde en otros VPS.

## cursor-agent

Se instaló **cursor-agent** para acercar el trabajo diario al flujo asistido: revisiones, scripts auxiliares y documentación incremental desde la consola.

No sustituye la revisión humana. Reduce fricción en tareas repetibles (overlays de Compose, validar Nginx antes de recargar).

## Cierre del día 0

Al terminar, el servidor debería ser:

1. **Auditable:** layout de disco y paquetes conocidos
2. **Repetible:** pasos principales enlazados con wiki y runbooks
3. **Listo** para Docker sin exponer servicios al público antes de tiempo

El **día 1** materializa OpenCloud, el virtual host del proxy y la web KM0 con TLS. Siguiente paso para quien lea: [servicios](/#services) o [contacto](/#contact).
