---
title: "Dia 29 - Un sol login KM0: Keycloak per a Cloud web, escriptori i mòbil"
description: "Cloud al navegador, el client d’escriptori OpenCloud i les apps mòbils comparteixen el mateix inici de sessió KM0. Per què, què fer i enllaços als tutorials."
pubDate: 2026-10-06
locale: ca
image: /brand/day29-hero.png
imageAlt: "Pantalla d'accés KM0 compartida a Keycloak"
---

**Cloud al navegador, el client de sync d’escriptori i les apps del telèfon ja usen el mateix login KM0.** Un compte, una contrasenya, una pantalla d’accés. Aquest és el sentit d’aquesta millora.

Hem passat la identitat viva de Cloud a **Keycloak** a [sso.km0digital.com](https://sso.km0digital.com/) (regne de Quilòmetre 0 Digital). El camí de login antic queda fora de l’ús diari de Cloud.

## Per què ho hem fet

Logins diferents a cada superfície volien dir més contrasenyes i un lloc pitjor per endurir la seguretat. Un sol servei d’accés ens deixa millorar la protecció del compte en un lloc, inclosa l’**autenticació en dos factors (2FA)** quan l’activis.

La teva adreça i contrasenya continuen valent on s’ha migrat el compte. Tot i així potser cal **tornar a iniciar sessió** un cop a cada app perquè el client agafi el login nou.

## Què has de fer

1. Obre Cloud al navegador i completa l’accés nou si et demana. Pas a pas: [Iniciar sessió a KM0 Cloud amb el login compartit](/ca/tutorials/keycloak-sign-in-cloud/).
2. Activa 2FA quan el compte ho ofereixi: [Activar 2FA al teu compte KM0](/ca/tutorials/keycloak-2fa/).
3. Al client OpenCloud d’escriptori, torna a connectar el compte (Paràmetres avançats / compte) si el sync s’ha parat després del canvi: [Tornar a iniciar sessió a OpenCloud Desktop](/ca/tutorials/opencloud-desktop-relogin/).
4. A Android o iOS, obre l’app un cop i acaba l’accés si la sessió ha caducat. L’adreça del servidor continua sent `https://cloud.km0digital.com/`.

Les captures d’aquests tutorials arribaran aviat; els passos ja hi són.

## Mateix login, diverses superfícies

| Superfície | Usa el login KM0 compartit |
|------------|----------------------------|
| Cloud al navegador | Sí |
| OpenCloud Desktop (Windows, macOS, Linux) | Sí |
| Apps OpenCloud a Android i iOS | Sí |

Hauries de veure la mateixa experiència d’accés quan qualsevol d’elles et demani autenticar-te. És a propòsit.

## Si alguna cosa falla

- Bucles d’accés al navegador: esborra les galetes del lloc de Cloud i prova una altra vegada, o usa una finestra privada.
- L’escriptori ha creat una **segona** carpeta de sync: para i [contacta’ns](/ca/#contact) abans d’esborrar fitxers locals. Preferim arreglar l’enllaç del compte a perdre una còpia.
- Contrasenya oblidada: usa la recuperació a la pantalla d’accés.

El diari tècnic continuarà. Per al dia a dia, el canvi útil és simple: **un sol login KM0 a Cloud web, escriptori i mòbil**, amb tutorials quan necessitis els clics.
