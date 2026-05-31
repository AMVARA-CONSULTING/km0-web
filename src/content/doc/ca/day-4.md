---
title: "Dia 4 - Login local Dex LDAP contra IDM OpenCloud"
description: "Connector LDAP de Dex cap a l'IDM integrat d'OpenCloud, correcció TLS del certificat LDAPS i tancament de la issue #1 amb proves automatitzades."
pubDate: 2026-05-27
locale: ca
---

<div class="doc-lead-block">
  <p class="doc-block-title">Introducció</p>
  <p class="doc-lead">El dia 4 (finestra de les últimes quatre hores del 27 de maig de 2026, ~11:40–15:40 CEST al VPS Debian de producció) se centra en un únic objectiu d'autenticació: que el login local accepti qualsevol usuari de l'IDM integrat d'OpenCloud (mateix <code>uid</code> i contrasenya que a Configuració) i segueixi emetent tokens OIDC de Dex per al proxy.</p>
  <p class="doc-lead">Es substitueix l'emmagatzematge estàtic de contrasenyes de Dex per un connector LDAP cap a LDAPS de l'IDM, es corregeix el certificat TLS del servei LDAP intern i el bucle autoagents tanca la issue #1 de GitHub amb proves automatitzades en PASS.</p>
</div>

<div class="doc-block">
  <p class="doc-block-title">Resum</p>
  <h2 class="doc-block-heading">Resultat del dia</h2>
  <ul class="doc-list">
    <li><strong>Dex ↔ IDM:</strong> connector <code>ldap</code> → <code>ldaps://opencloud:9235</code>, base <code>ou=users,o=libregraph-idm</code>; Dex a la xarxa Docker <code>opencloud_opencloud-net</code> amb volums de config/dades per a CA <code>idm/ldap.crt</code>.</li>
    <li><strong>OpenCloud:</strong> <code>IDM_LDAPS_ADDR=0.0.0.0:9235</code> a l'overlay external-proxy; <code>login.html</code> usa <code>connector_id=ldap</code>; nginx i JSON d'auth alineats amb <code>cloud.km0digital.com</code>.</li>
    <li><strong>TLS IDM:</strong> certificat regenerat amb SAN <code>DNS:opencloud</code> (abans només <code>localhost</code>); script <code>regenerate-opencloud-idm-ldap-cert.sh</code>.</li>
    <li><strong>Autoagents:</strong> tasca tancada PASS; versió del paquet 1.0.18; login manual amb dos usuaris diferents pendent d'operador.</li>
  </ul>
</div>

<div class="doc-block doc-block-alt">
  <p class="doc-block-title">Problema</p>
  <h2 class="doc-block-heading">GitHub #1</h2>
  <p class="doc-block-intro">El flux híbrid ja enrutava Google/Apple i login local per Dex, però el connector local depenia d'un password store estàtic a Dex: només funcionava per a credencials predefinides, no per a tots els usuaris <code>inetOrgPerson</code> creats a l'IDM d'OpenCloud.</p>
  <p>El requisit era unificar credencials amb Configuració d'OpenCloud i mantenir l'emissor OIDC (<code>OC_OIDC_ISSUER</code>) que consumeix el proxy.</p>
</div>

<div class="doc-block">
  <p class="doc-block-title">Solució</p>
  <h2 class="doc-block-heading">Integració Dex LDAP + IDM</h2>
  <ul class="doc-list">
    <li><strong>Dex:</strong> connector <code>type: ldap</code> a <code>dex/config.yaml</code>; eliminat el password DB per a usuaris locals.</li>
    <li><strong>Compose Dex:</strong> unió a <code>opencloud_opencloud-net</code>; muntatge de volums <code>opencloud-config</code> i <code>opencloud-data</code> per llegir CA i <code>idm_password</code> del config muntat.</li>
    <li><strong>Overlay OpenCloud:</strong> <code>IDM_LDAPS_ADDR=0.0.0.0:9235</code> perquè Dex arribi a LDAPS per hostname <code>opencloud</code>.</li>
    <li><strong>UI:</strong> <code>login.html</code> amb botó «local» i <code>connector_id=ldap</code>; rutes nginx <code>/dex/auth</code> sense connector → selector de login.</li>
  </ul>
</div>

<div class="doc-block doc-block-alt">
  <p class="doc-block-title">Flux</p>
  <h2 class="doc-block-heading">Login després dels canvis</h2>
  <div class="doc-note"><pre>login.html
  ├── Google  → Dex connector google  → token OIDC → proxy OpenCloud
  ├── Apple   → Dex connector apple   → (quan estigui configurat)
  └── Local   → Dex connector ldap    → IDM LDAPS opencloud:9235
                                         (qualsevol uid inetOrgPerson + contrasenya)</pre></div>
  <p>Els connectors socials segueixen el mateix patró OIDC; el local deixa de ser una llista fixa a Dex i passa a ser un bind LDAP contra el directori embarcat de l'stack.</p>
</div>

<div class="doc-block">
  <p class="doc-block-title">TLS</p>
  <h2 class="doc-block-heading">Fix certificat IDM LDAPS</h2>
  <p class="doc-block-intro">Durant les proves, Dex arribava a <code>opencloud:9235</code> però el <code>ldap.crt</code> autogenerat només incloïa <code>localhost</code> al SAN → error <em>TLS certificate is valid for localhost, not opencloud</em>.</p>
  <p>Correcció (<code>0a042db</code>): script <code>scripts/regenerate-opencloud-idm-ldap-cert.sh</code> que regenera el certificat amb <code>DNS:localhost,DNS:opencloud,IP:127.0.0.1</code> i opció <code>--restart</code>; documentat al runbook i README de Dex.</p>
</div>

<div class="doc-block doc-block-alt">
  <p class="doc-block-title">Commits</p>
  <h2 class="doc-block-heading">Finestra del dia (CEST)</h2>
  <ul class="doc-list">
    <li><code>cf5a561</code> (15:27) - <code>feat(auth): Dex LDAP login against OpenCloud IDM for all users</code>.</li>
    <li><code>0a042db</code> (15:39) - <code>fix(dex): regenerate IDM LDAP cert with opencloud SAN for Dex TLS</code>.</li>
  </ul>
</div>

<div class="doc-block">
  <p class="doc-block-title">Autoagents</p>
  <h2 class="doc-block-heading">Comprovacions de tancament</h2>
  <ul class="doc-list">
    <li>SAN del cert IDM inclou <code>opencloud</code> - PASS.</li>
    <li>Dex LDAP <code>host: opencloud:9235</code> - PASS.</li>
    <li><code>curl</code> amb <code>connector_id=ldap</code> → <code>/dex/auth/ldap</code> - PASS.</li>
    <li>Contrasenya incorrecta → HTTP 401, bind LDAP, sense x509 als logs - PASS.</li>
    <li>Fum connector Google - PASS.</li>
    <li>Login manual dos usuaris diferents → <code>/files</code> - NO VERIFICAT (operador).</li>
  </ul>
</div>

<div class="doc-block doc-block-alt">
  <p class="doc-block-title">Desplegament</p>
  <h2 class="doc-block-heading">Verificació (operador)</h2>
  <div class="doc-note"><pre>cd /opt/opencloud
./scripts/git-sync-main.sh
./scripts/apply-opencloud-compose-overrides.sh
./scripts/regenerate-opencloud-idm-ldap-cert.sh --restart
rsync -a /opt/opencloud/host-www/opencloud-auth/ /var/www/opencloud-auth/
cd dex && docker compose up -d

curl -sI https://cloud.km0digital.com/login.html</pre></div>
  <p>Manual: finestra privada → <code>login.html</code> → login local amb dos <code>uid</code> diferents d'OpenCloud; s'espera <code>/oidc-callback.html</code> i després <code>/files</code> sense errors JWKS ni <code>/graph/v1.0/me</code> 500.</p>
  <div class="doc-note">Les contrasenyes d'usuaris i secrets de bind IDM no formen part d'aquesta entrada; el happy-path amb dos comptes reals queda com a verificació humana a producció.</div>
</div>

<div class="doc-closing-block">
  <p class="doc-block-title">Següent pas</p>
  <h2 class="doc-block-heading">Dia 5</h2>
  <p class="doc-closing">El <strong>dia 5</strong> no documenta desplegaments: recull una reunió de visió a Masnou sobre per què creiem que avui ja es pot oferir tecnologia útil sense passar per les grans corporacions digitals. Mentrestant, explora els <a href="/ca/#services">serveis</a> o el <a href="/ca/doc/day-5/">relat del dia 5</a>.</p>
</div>
