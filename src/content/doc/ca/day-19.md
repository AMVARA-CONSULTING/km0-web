---
title: "Dia 19 - KM0 Mail: accés natiu, registre propi i dominis al teu nom"
description: "KM0 Mail deixa de dependre de redireccions externes: login natiu, registre en un minut i dominis propis autogestionats des del correu web."
pubDate: 2026-08-05
locale: ca
---

Des que vam activar KM0 Email (vegeu el [dia 11](/ca/doc/day-11/)), el correu ha madurat. L'última tanda de canvis a km0-mail persegueix una idea senzilla: que qualsevol pugui tenir una bústia pròpia sense dependre de Gmail, sense panells opacs i sense APIs de pagament.

## Accés natiu, sense salts

Abans, entrar al correu passava per redireccions a un altre servei d'autenticació. Ara [mail.km0digital.com](https://mail.km0digital.com/) et demana directament **correu i contrasenya**. L'inici de sessió amb OpenCloud / LDAP encara existeix, però com a opció secundària per a qui ja té compte al cloud.

També vam millorar els **missatges d'error**: si fallen les credencials o el servidor no respon, ara ho diu clar i en el teu idioma (ES, CA, EN, DE), en lloc d'un genèric "Login failed".

## Registre en un minut

La pàgina `/register` es va simplificar al màxim: tries **usuari i contrasenya** i obtens `usuari@km0digital.com` a l'instant. Verifiques el compte des de la teva bústia d'entrada. Pots rebre i llegir correu des del primer moment; per **enviar**, primer confirmes l'enllaç de verificació. És una defensa senzilla contra l'abús, sense fricció per a l'usuari legítim.

## El teu propi domini, autogestionat

La novetat gran: **dominis propis sense passar per suport**. Dins del correu web, a **Configuració > Els meus dominis**, qualsevol usuari pot:

1. Afegir el seu domini (per exemple `elteudomini.com`).
2. Publicar els registres DNS que li mostrem: propietat (TXT), MX, SPF i DKIM.
3. Prémer **Verifica** i esperar que es propaguin.
4. Crear adreces `nom@elteudomini.com` amb la seva contrasenya.

Cada domini signa el seu correu amb **DKIM pròpia**, de manera que l'entregabilitat no depèn d'un únic domini compartit. Tot el flux és autoservei, a l'estil dels grans proveïdors, però sobre infraestructura que controlem.

## Sense dependències de pagament

Res d'això fa servir APIs de Google Workspace, relays de pagament ni serveis externs de verificació. És correu propi, sobre el mateix servidor que ja opera Kilòmetre 0.

## Tancament

El correu va passar de "bústies internes" a un **servei que qualsevol pot fer servir i ampliar amb el seu domini**. Per posar-ho en pràctica, vam escriure guies pas a pas: mira els [tutorials de KM0 Mail](/ca/tutorials/) o entra directament a [mail.km0digital.com](https://mail.km0digital.com/). Al [dia 20](/ca/doc/day-20/) expliquem com van quedar aquests tutorials.
