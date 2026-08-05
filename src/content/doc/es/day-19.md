---
title: "Día 19 - KM0 Mail: acceso nativo, registro propio y dominios a tu nombre"
description: "KM0 Mail deja de depender de redirecciones externas: login nativo, registro en un minuto y dominios propios autogestionados desde el correo web."
pubDate: 2026-08-05
locale: es
---

Desde que activamos KM0 Email (ver [día 11](/doc/day-11/)), el correo ha madurado. La última tanda de cambios en km0-mail persigue una idea simple: que cualquiera pueda tener un buzón propio sin depender de Gmail, sin paneles opacos y sin APIs de pago.

## Acceso nativo, sin saltos

Antes, entrar al correo pasaba por redirecciones a otro servicio de autenticación. Ahora [mail.km0digital.com](https://mail.km0digital.com/) te pide directamente **correo y contraseña**. El inicio de sesión con OpenCloud / LDAP sigue existiendo, pero como opción secundaria para quien ya tiene cuenta en el cloud.

También mejoramos los **mensajes de error**: si fallan las credenciales o el servidor no responde, ahora lo dice claro y en tu idioma (ES, CA, EN, DE), en lugar de un genérico "Login failed".

## Registro en un minuto

La página `/register` se simplificó al máximo: eliges **usuario y contraseña** y obtienes `usuario@km0digital.com` al instante. Verificas la cuenta desde tu propia bandeja de entrada. Puedes recibir y leer correo desde el primer momento; para **enviar**, primero confirmas el enlace de verificación. Es una defensa sencilla contra el abuso, sin fricción para el usuario legítimo.

## Tu propio dominio, autogestionado

La novedad grande: **dominios propios sin pasar por soporte**. Dentro del correo web, en **Ajustes > Mis dominios**, cualquier usuario puede:

1. Añadir su dominio (por ejemplo `tudominio.com`).
2. Publicar los registros DNS que le mostramos: propiedad (TXT), MX, SPF y DKIM.
3. Pulsar **Verificar** y esperar a que se propaguen.
4. Crear direcciones `nombre@tudominio.com` con su contraseña.

Cada dominio firma su correo con **DKIM propia**, así que la entregabilidad no depende de un único dominio compartido. Todo el flujo es autoservicio, al estilo de los grandes proveedores, pero sobre infraestructura que controlamos.

## Sin dependencias de pago

Nada de esto usa APIs de Google Workspace, relays de pago ni servicios externos de verificación. Es correo propio, sobre el mismo servidor que ya opera Kilómetro 0.

## Cierre

El correo pasó de "buzones internos" a un **servicio que cualquiera puede usar y ampliar con su dominio**. Para ponerlo en práctica, escribimos guías paso a paso: mira los [tutoriales de KM0 Mail](/tutorials/) o entra directamente en [mail.km0digital.com](https://mail.km0digital.com/). En el [día 20](/doc/day-20/) contamos cómo quedaron esos tutoriales.
