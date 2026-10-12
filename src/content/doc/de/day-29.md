---
title: "Tag 29 - Ein KM0-Login: Keycloak für Cloud Web, Desktop und Mobil"
description: "Cloud im Browser, OpenCloud-Desktop-Client und Mobile-Apps teilen dieselbe KM0-Anmeldung. Warum, was tun, Links zu den neuen Tutorials."
pubDate: 2026-10-06
locale: de
image: /brand/day29-hero.png
imageAlt: "Gemeinsamer KM0-Anmeldebildschirm in Keycloak"
---

**Cloud im Browser, der Desktop-Sync-Client und die Handy-Apps nutzen jetzt dieselbe KM0-Anmeldung.** Ein Konto, ein Passwort, ein Anmeldebildschirm. Darum geht es bei diesem Upgrade.

Wir haben die Live-Cloud-Identität auf **Keycloak** unter [sso.km0digital.com](https://sso.km0digital.com/) umgestellt (Realm für Kilometer 0 Digital). Der alte separate Login-Weg ist für den Cloud-Alltag aus dem Weg.

## Warum wir das getan haben

Getrennte Logins pro Oberfläche bedeuteten mehr Passwörter und einen schlechteren Ort, um Sicherheit zu härten. Ein Anmeldedienst lässt uns Kontoschutz an einer Stelle verbessern, einschließlich **Zwei-Faktor-Authentifizierung (2FA)**, wenn ihr sie einschaltet.

Bestehende Adresse und Passwort gelten weiter, wo wir das Konto migriert haben. Trotzdem müsst ihr euch auf jeder App **einmal neu anmelden**, damit der Client den neuen Login übernimmt.

## Was ihr tun solltet

1. Cloud im Browser öffnen und die neue Anmeldung abschließen, wenn gefragt. Schritt für Schritt: [Mit dem gemeinsamen Login bei KM0 Cloud anmelden](/de/tutorials/keycloak-sign-in-cloud/).
2. 2FA einschalten, wenn das Konto es anbietet: [2FA für euer KM0-Konto aktivieren](/de/tutorials/keycloak-2fa/).
3. Im OpenCloud-Desktop-Client das Konto neu verbinden (Erweiterte Einstellungen / Konto), wenn Sync nach dem Wechsel stand: [Erneute Anmeldung in OpenCloud Desktop](/de/tutorials/opencloud-desktop-relogin/).
4. Unter Android oder iOS die App einmal öffnen und die Anmeldung beenden, wenn die Sitzung abgelaufen ist. Serveradresse bleibt `https://cloud.km0digital.com/`.


## Derselbe Login, mehrere Oberflächen

| Oberfläche | Nutzt den gemeinsamen KM0-Login |
|------------|----------------------------------|
| Cloud im Browser | Ja |
| OpenCloud Desktop (Windows, macOS, Linux) | Ja |
| OpenCloud-Apps unter Android und iOS | Ja |

Ihr solltet dieselbe Anmelde-Erfahrung sehen, wenn eine dieser Oberflächen euch authentisieren lässt. Das ist Absicht.

## Wenn etwas schiefgeht

- Anmelde-Schleifen im Browser: Cookies für die Cloud-Site löschen und einmal neu versuchen, oder ein privates Fenster nutzen.
- Desktop hat einen **zweiten** Sync-Ordner erzeugt: stoppen und [kontaktieren](/de/#contact), bevor lokale Dateien gelöscht werden. Wir reparieren lieber die Kontoverknüpfung als eine Kopie zu verlieren.
- Passwort vergessen: Wiederherstellung auf dem Anmeldebildschirm.

Das technische Tagebuch geht weiter. Für den Alltag ist die nützliche Änderung einfach: **ein KM0-Login für Cloud Web, Desktop und Mobil**, mit Tutorials wenn ihr die Klicks braucht.
