---
title: "Día 28 - Una puerta de entrada más limpia para el HTTPS público"
description: "Pusimos un reverse proxy delante del borde público para unificar TLS y el enrutado, con página de mantenimiento lista, sin cambiar las URLs de Cloud."
pubDate: 2026-10-05
locale: es
---

El 5 de octubre cambiamos cómo llega el HTTPS público al host de KM0. Un reverse proxy queda en la puerta de los puertos 80 y 443. Nginx sigue haciendo lo que mejor sabe; el borde se entiende mejor.

## Qué significa para ti

- Las mismas URLs públicas. Cloud, el sitio de marketing y el resto mantienen los nombres que ya usas.
- La terminación TLS y el enrutado viven en un solo sitio en el borde.
- Podemos activar una página de mantenimiento sin reescribir cada sitio a mano.

## Por qué molestarse

Menos sorpresas al cortar identidad o añadir un servicio. Quien lee no necesita la fontanería; quien opera necesita una puerta que abra igual cada vez.

## Estado

Si tus marcadores siguen abriendo, listo. Problemas de HTTPS ese día: [contacto](/#contact).
