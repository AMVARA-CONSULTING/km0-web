---
title: "Tag 19 - KM0 Mail: native Anmeldung, Selbstregistrierung und eigene Domains"
description: "KM0 Mail kommt ohne externe Weiterleitungen aus: native Anmeldung, Registrierung in einer Minute und selbstverwaltete eigene Domains im Webmail."
pubDate: 2026-08-05
locale: de
---

Seit dem Start von KM0 Email (siehe [Tag 11](/de/doc/day-11/)) ist der Mail-Stack gereift. Die jüngsten Änderungen in km0-mail folgen einer einfachen Idee: Jede Person soll ein eigenes Postfach haben können, ohne von Gmail abhängig zu sein, ohne undurchsichtige Panels und ohne kostenpflichtige APIs.

## Native Anmeldung, ohne Umwege

Die Anmeldung lief früher über einen separaten Authentifizierungsdienst. Jetzt fragt [mail.km0digital.com](https://mail.km0digital.com/) direkt nach **E-Mail und Passwort**. Die Anmeldung über OpenCloud / LDAP gibt es weiterhin, aber als sekundäre Option für Personen mit Cloud-Konto.

Wir haben auch die **Fehlermeldungen** verbessert: Wenn die Zugangsdaten falsch sind oder der Server nicht antwortet, steht das jetzt klar und in Ihrer Sprache (ES, CA, EN, DE), statt eines generischen "Login failed".

## Registrierung in einer Minute

Die Seite `/register` wurde radikal vereinfacht: Sie wählen **Benutzername und Passwort** und erhalten sofort `benutzer@km0digital.com`. Sie bestätigen das Konto aus Ihrem eigenen Posteingang. E-Mails empfangen und lesen geht sofort; zum **Senden** bestätigen Sie zuerst den Verifizierungslink. Das ist ein einfacher Schutz gegen Missbrauch, ohne Reibung für die berechtigte Nutzerin.

## Ihre eigene Domain, selbst verwaltet

Die große Neuerung: **eigene Domains ohne Support-Umweg**. Im Webmail können alle unter **Einstellungen > Meine Domains**:

1. Ihre Domain hinzufügen (zum Beispiel `ihredomain.com`).
2. Die angezeigten DNS-Einträge veröffentlichen: Eigentum (TXT), MX, SPF und DKIM.
3. Auf **Bestätigen** klicken und die Verbreitung abwarten.
4. Adressen `name@ihredomain.com` mit eigenem Passwort anlegen.

Jede Domain signiert ihre Mail mit **eigenem DKIM**, sodass die Zustellbarkeit nicht an einer einzigen gemeinsamen Domain hängt. Der gesamte Ablauf ist Self-Service, im Stil der großen Anbieter, aber auf Infrastruktur, die wir kontrollieren.

## Keine kostenpflichtigen Abhängigkeiten

Nichts davon nutzt Google-Workspace-APIs, kostenpflichtige Relays oder externe Verifizierungsdienste. Es ist selbst gehostete Mail, auf demselben Server, den Kilometer 0 bereits betreibt.

## Abschluss

Mail wurde von "internen Postfächern" zu einem **Dienst, den alle nutzen und mit ihrer eigenen Domain erweitern können**. Zur praktischen Umsetzung haben wir Schritt-für-Schritt-Anleitungen geschrieben: siehe die [KM0-Mail-Tutorials](/de/tutorials/) oder gehen Sie direkt zu [mail.km0digital.com](https://mail.km0digital.com/). In [Tag 20](/de/doc/day-20/) beschreiben wir, wie diese Tutorials geworden sind.
