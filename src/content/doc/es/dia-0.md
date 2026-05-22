---
title: "Día 0 — Fundaciones del servidor"
description: "Debian, particiones, Docker, Nginx y base reproducible: el día dedicado a que el stack KM0 sea auditable y operable."
pubDate: 2026-05-21
locale: es
---

El día 0 está dedicado a **fundaciones**: sin una base reproducible del sistema operativo y del entorno de trabajo, cualquier stack posterior sería frágil y difícil de auditar. El objetivo es salir del día con Debian estable, disco ordenado, herramientas mínimas pero suficientes y una consola que invite a documentar cada cambio.

## Plan técnico del arranque (visión completa)

KM0 persigue una infraestructura que pueda ser operada por personas del equipo sin depender de paneles propietarios opacos:

- **Sistema:** VPS con Debian actualizado, esquema de particiones que separa sistema de datos cuando tiene sentido en el proyecto (facilita snapshots y políticas de backup).
- **Colaboración:** [OpenCloud](https://cloud.km0.amvara.de) desplegado como conjunto de microservicios coordinados dentro de una imagen oficial mantenida por la comunidad [OpenCloud.eu](https://opencloud.eu), con volúmenes nombrados de forma estable (`COMPOSE_PROJECT_NAME`) para que los backups no dependan del directorio desde el que se ejecuta Compose.
- **Perímetro:** Nginx como único frontal HTTPS; overlays Docker que publican HTTP solo en `127.0.0.1`.
- **Comunicación:** Sitio Astro dockerizado sirviendo estáticos en otro puerto loopback; virtual hosts independientes para marketing (`km0.amvara.de`) y cloud (`cloud.km0.amvara.de`).
- **Observabilidad y mantenimiento:** logs de contenedor rotados (`json-file` con tamaño máximo), comandos habituales documentados en runbooks (`docker compose ps` / `logs` / `pull`), backups de volúmenes como artefactos comprimidos.
- **Evolución:** espacio para endurecer TLS entre microservicios internos cuando los certificados sean totalmente confiables en cadena (pasar de modo prueba a producción), automatizar copias de seguridad y endurecer políticas Fail2ban por jails específicos.

## Provisionamiento del VPS y particiones

Se eligió un servidor con **Debian** por predictibilidad del ciclo de paquetes y amplia documentación para administración manual (sin paneles obligatorios). Lo primero fue revisar el layout del disco y crear particiones coherentes con el uso previsto:

- Separación que permita crecer datos del proyecto sin mezclarlos con el sistema de ficheros raíz cuando sea necesario respaldar por volumen.
- Criterios claros para montajes (`/var/lib/docker` puede concentrar el I/O de OpenCloud según tamaño del VPS).
- Convenciones documentadas para que cualquier persona del equipo reconozca qué montaje corresponde a datos persistentes frente al sistema.

Los detalles exactos del mapa de particiones son específicos del proveedor y del tamaño contratado; lo importante es que queden documentados fuera del blog en la wiki o runbook del proyecto para recuperación ante fallos.

## Software base

Se instaló el conjunto mínimo razonable para administración segura remota y para construir encima Docker sin “peso muerto” innecesario:

- Herramientas de sistema habituales (`curl`, editores, utilidades de red y diagnóstico).
- **Docker Engine** con política de logs rotativos (`/etc/docker/daemon.json`) para que los registros no ocupen todo el disco.
- **Nginx** desde paquetes del sistema como frontal estable.
- **Certbot** / estrategia TLS según fase del proyecto (emisión inicial HTTP-01 frente a certificado provisional autofirmado para laboratorio).

La filosofía es que cada componente tiene un rol único y observable en el árbol de dependencias del sistema (`systemctl status`, `nginx -t`, `docker compose ps`).

## Ergonómica del shell y configuración inicial reproducible

Para que las sesiones SSH posteriores sean consistentes se aplicaron mejoras guiadas por la documentación interna [initialConfiguration](https://wiki.ldeluipy.es/initialConfiguration.html) del wiki:

- Prompt de Bash más legible (directorio actual, estado de comando, hints visuales).
- Ajustes que reducen errores repetidos (historial útil, opciones seguras por defecto donde aplique).
- Convenciones para aliases y `PATH` que anticipan el trabajo con Docker Compose y Git desde `/opt/...`.

Tener esta base escrita fuera del servidor permite repetir el mismo “molde” en otros VPS del proyecto sin improvisar cada vez.

## cursor-agent

Se instaló **cursor-agent** para acercar el flujo de trabajo del día a día al del entorno de desarrollo asistido: revisiones automatizadas, generación de scripts auxiliares y documentación incremental sin abandonar la línea de comandos del servidor.

No sustituye la revisión humana ni los controles de cambio del equipo, pero reduce fricción cuando hay que repetir tareas verificables (actualizar overlays de Compose, validar sintaxis de Nginx antes de recargar, etc.).

## Estado al cierre del día 0

Al terminar el día el servidor cumple tres propiedades:

1. **Es auditable:** layout de disco y paquetes conocidos.
2. **Es repetible:** pasos principales enlazan con wiki y runbooks.
3. **Está listo** para cargas Docker sin exponer servicios prematuramente al público.

El **día 1** aprovecha esa base para materializar OpenCloud, el virtual host del proxy y la web KM0 ya enlazadas por TLS. Mientras tanto, puedes explorar los [servicios](/#servicios) publicados o [escribirnos](/#contacto) si quieres colaborar.
