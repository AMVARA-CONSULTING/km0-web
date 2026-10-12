---
title: "Día 29 - Un solo login KM0: Keycloak para Cloud web, escritorio y móvil"
description: "Cloud en el navegador, el cliente de escritorio OpenCloud y las apps móviles comparten el mismo inicio de sesión KM0. Por qué, qué hacer y enlaces a los tutoriales."
pubDate: 2026-10-06
locale: es
image: /brand/day29-hero.png
imageAlt: "Pantalla de acceso KM0 compartida en Keycloak"
---

**Cloud en el navegador, el cliente de sync de escritorio y las apps del teléfono usan ya el mismo login KM0.** Una cuenta, una contraseña, una pantalla de acceso. Ese es el sentido de esta mejora.

Hemos pasado la identidad viva de Cloud a **Keycloak** en [sso.km0digital.com](https://sso.km0digital.com/) (reino de Kilómetro 0 Digital). El camino de login antiguo queda fuera del uso diario de Cloud.

## Por qué lo hicimos

Logins distintos en cada superficie significaban más contraseñas y un sitio peor para endurecer la seguridad. Un solo servicio de acceso nos deja mejorar la protección de la cuenta en un sitio, incluida la **autenticación en dos factores (2FA)** cuando la actives.

Tu dirección y contraseña siguen valiendo donde migraron la cuenta. Aun así puede que tengas que **volver a iniciar sesión** una vez en cada app para que el cliente tome el login nuevo.

## Qué debes hacer

1. Abre Cloud en el navegador y completa el acceso nuevo si te lo pide. Paso a paso: [Iniciar sesión en KM0 Cloud con el login compartido](/tutorials/keycloak-sign-in-cloud/).
2. Activa 2FA cuando la cuenta lo ofrezca: [Activar 2FA en tu cuenta KM0](/tutorials/keycloak-2fa/).
3. En el cliente OpenCloud de escritorio, vuelve a conectar la cuenta (Ajustes avanzados / cuenta) si el sync se paró tras el cambio: [Volver a iniciar sesión en OpenCloud Desktop](/tutorials/opencloud-desktop-relogin/).
4. En Android o iOS, abre la app una vez y termina el acceso si la sesión caducó. La dirección del servidor sigue siendo `https://cloud.km0digital.com/`.


## Mismo login, varias superficies

| Superficie | Usa el login KM0 compartido |
|------------|-----------------------------|
| Cloud en el navegador | Sí |
| OpenCloud Desktop (Windows, macOS, Linux) | Sí |
| Apps OpenCloud en Android e iOS | Sí |

Deberías ver la misma experiencia de acceso cuando cualquiera de ellas pida autenticarte. Es a propósito.

## Si algo falla

- Bucles de acceso en el navegador: borra las cookies del sitio de Cloud y prueba otra vez, o usa una ventana privada.
- El escritorio creó una **segunda** carpeta de sync: para y [contáctanos](/#contact) antes de borrar archivos locales. Preferimos arreglar el enlace de la cuenta a perder una copia.
- Contraseña olvidada: usa la recuperación en la pantalla de acceso.

El diario técnico seguirá. Para el día a día, el cambio útil es simple: **un solo login KM0 en Cloud web, escritorio y móvil**, con tutoriales cuando necesites los clics.
