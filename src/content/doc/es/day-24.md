---
title: "Día 24 - Maestro: operar la flota desde Discord"
description: "Cómo operamos KM0 con Maestro: catálogo de proyectos, hilos persistentes, OpenCloud como hangar y trazas en Redmine."
pubDate: 2026-09-04
locale: es
image: /brand/maestro-og.png
portrait: /brand/maestro.png
imageAlt: "Retrato de Maestro, el orquestador Discord de KM0"
---

KM0 incluye webs, correo, auth, OpenCloud, monitores y unos diez hosts. Maestro es el bot de Discord con el que seguimos el trabajo entre servidores y proyectos.

## Cómo era antes

Cada arreglo empezaba igual: abrir terminal, entrar al servidor correcto, recordar la ruta del repo, reconstruir el contexto de memoria y arrancar un agente nuevo con el prompt desde cero. Al cerrar la sesión, ese contexto desaparecía.

Con decenas de proyectos (km0-web, OpenCloud, mail, auth y el resto del perímetro Amvara), el tiempo se iba en volver a encontrar el mapa.

## Qué hace

Maestro está ligado a un catálogo de proyectos. Recibe la orden (comando o lenguaje natural), carga el contexto del caso, abre una sesión en el árbol correcto y entra al host por SSH. El hilo de Discord queda unido a esa sesión.

Con el hilo abierto puedes dejar el trabajo el lunes, pegar un log el jueves y seguir sin explicar otra vez el entorno. Al cerrar queda un resumen de lo hecho. Si el caso lo pide, también una nota en Redmine.

## Cómo lo usamos

Así operamos la casa.

1. Catálogo y contexto. Cada proyecto (este sitio está en `/opt/km0-web`) tiene rutas, runbooks y reglas. Maestro trabaja lo registrado y no inventa hosts.
2. Hangar OpenCloud. El espacio `maestro@km0digital.com` por WebDAV (`human_input/`, `maestro_input/`) mueve logs largos, capturas y entregables que Discord no debe guardar, sin pelear con el TTL del chat.
3. Trazabilidad. Notas en Redmine en inglés técnico (Textile), ligadas al ticket del proyecto. El chat ya no es el único archivo.

También lee adjuntos (imágenes, PDF, logs), llama herramientas ya desplegadas en la flota (navegador headless, entre otras) y devuelve capturas en el mismo hilo. Si algo no está en el catálogo, Maestro no lo toca. Es una regla de seguridad.

## Por qué está en el blog

Este blog cuenta cómo se construye y se mantiene la infra detrás de Cloud y Mail. Maestro entra ahí: sesión, resumen y ticket, en lugar de un arreglo en una shell que nadie vuelve a abrir.

El camino es Discord, luego el núcleo (catálogo y sesión), luego SSH al host. Si hace falta, hay un puente de respaldo con sus propias normas.

Cloud y Mail siguen en la [UE](/#services). Si quieres ver cómo trabajamos o probar el producto, [contacta](/#contact) o ven a un [encuentro](/meeting/). El día a día de la flota, cuando hace falta, empieza con un mensaje en Discord.
