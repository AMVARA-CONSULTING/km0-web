---
title: "Día 24 - Maestro: operar la flota desde Discord"
description: "Cómo operamos KM0 con Maestro: catálogo de proyectos, hilos persistentes, OpenCloud como hangar y trazas en Redmine."
pubDate: 2026-09-04
locale: es
image: /brand/maestro-og.png
portrait: /brand/maestro.png
imageAlt: "Retrato de Maestro, el orquestador Discord de KM0"
---

Operar KM0 no es solo publicar Cloud y Mail. Hay webs, correo, auth, OpenCloud, monitores y un montón de hosts. **Maestro** es el orquestador que usamos en Discord para no perder el hilo entre servidores y proyectos.

## El problema que resolvía

Antes, cada arreglo empezaba igual: abrir terminal, entrar al servidor correcto, recordar dónde estaba el repo, reconstruir el contexto de memoria y arrancar un agente efímero con el prompt desde cero. Al cerrar la sesión, ese contexto se evaporaba.

Con ~10 hosts y decenas de proyectos (km0-web, OpenCloud, mail, auth y el resto del perímetro Amvara), eso no escala. El coste real no era teclear comandos: era **reencontrar el mapa** cada vez.

## Qué es Maestro

Un bot en Discord ligado a un catálogo de proyectos. Recibe la orden (comando o lenguaje natural), carga el contexto del caso, abre una sesión enfocada en el árbol correcto y llega al host por SSH. El hilo de Discord queda unido a esa sesión.

Mientras el hilo esté abierto, puedes dejar el trabajo el lunes, pegar un log el jueves y continuar sin reexplicar el entorno. Al cerrar el hilo, queda un resumen de lo hecho; si el caso lo pide, también una nota en Redmine.

## Qué aporta a KM0

No es un producto de la tienda: es la forma en que operamos la casa. Tres piezas concretas:

1. **Catálogo y contexto:** cada proyecto (por ejemplo este sitio en `/opt/km0-web`) tiene pack de rutas, runbooks y reglas. Maestro no inventa hosts; solo trabaja lo registrado.
2. **Hangar OpenCloud:** espacio `maestro@km0digital.com` vía WebDAV (`human_input/`, `maestro_input/`). Sirve para pasar ficheros que Discord no debe retener (logs largos, capturas, entregables) sin pelear con el TTL del chat.
3. **Trazabilidad:** notas en Redmine en inglés técnico (Textile), ligadas al ticket del proyecto. El chat deja de ser el único archivo de memoria.

También puede leer adjuntos (imágenes, PDF, logs), invocar herramientas ya desplegadas en la flota (navegador headless, etc.) y devolver capturas en el mismo hilo. Lo que no está en el catálogo no existe para él: eso es una regla de seguridad, no un límite de marketing.

## Por qué lo contamos aquí

El blog de KM0 documenta cómo se construye y se mantiene la infra, no solo el pitch comercial. Maestro encaja con esa línea: **operación audible**, con sesión, resumen y ticket, en lugar de “alguien lo arregló en una shell olvidada”.

El flujo es claro: Discord → núcleo (catálogo + sesión) → SSH al host; si hace falta, un puente de respaldo con sus propias normas.

## Cierre

Cloud y Mail siguen en la [UE](/#services). Si quieres ver cómo trabajamos o probar el producto, [contacta](/#contact) o ven a un [encuentro](/meeting/). El día a día de la flota, cuando hace falta, pasa por un mensaje en Discord: eso es Maestro.
