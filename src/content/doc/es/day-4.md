---
title: "Día 4 — Login local Dex LDAP contra IDM OpenCloud"
description: "Conector LDAP de Dex hacia el IDM integrado de OpenCloud, corrección TLS del certificado LDAPS y cierre de la issue #1 con pruebas automatizadas."
pubDate: 2026-05-27
locale: es
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducción</p>
  <p class="doc-lead">El día 4 (ventana de las últimas cuatro horas del 27 de mayo de 2026, ~11:40–15:40 CEST en el VPS Debian de producción) se centra en un único objetivo de autenticación: que el login local acepte cualquier usuario del IDM integrado de OpenCloud (mismo <code>uid</code> y contraseña que en Ajustes) y siga emitiendo tokens OIDC de Dex para el proxy.</p>
  <p class="doc-lead">Se sustituye el almacén estático de contraseñas de Dex por un conector LDAP hacia LDAPS del IDM, se corrige el certificado TLS del servicio LDAP interno y el bucle autoagents cierra la issue #1 de GitHub con pruebas automatizadas en PASS.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Resumen</p>
  <h2 class="doc-block-heading">Resultado del día</h2>
  <ul class="doc-list">
    <li><strong>Dex ↔ IDM:</strong> conector <code>ldap</code> → <code>ldaps://opencloud:9235</code>, base <code>ou=users,o=libregraph-idm</code>; Dex en red Docker <code>opencloud_opencloud-net</code> con volúmenes de config/datos para CA <code>idm/ldap.crt</code>.</li>
    <li><strong>OpenCloud:</strong> <code>IDM_LDAPS_ADDR=0.0.0.0:9235</code> en overlay external-proxy; <code>login.html</code> usa <code>connector_id=ldap</code>; nginx y JSON de auth alineados con <code>cloud.km0digital.com</code>.</li>
    <li><strong>TLS IDM:</strong> certificado regenerado con SAN <code>DNS:opencloud</code> (antes sólo <code>localhost</code>); script <code>regenerate-opencloud-idm-ldap-cert.sh</code>.</li>
    <li><strong>Autoagents:</strong> tarea cerrada PASS; versión del paquete 1.0.18; login manual con dos usuarios distintos pendiente de operador.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Problema</p>
  <h2 class="doc-block-heading">GitHub #1</h2>
  <p class="doc-block-intro">El flujo híbrido ya enrutaba Google/Apple y login local por Dex, pero el conector local dependía de un password store estático en Dex: sólo funcionaba para credenciales predefinidas, no para todos los usuarios <code>inetOrgPerson</code> creados en el IDM de OpenCloud.</p>
  <p>El requisito era unificar credenciales con Ajustes de OpenCloud y mantener el emisor OIDC (<code>OC_OIDC_ISSUER</code>) que consume el proxy.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Solución</p>
  <h2 class="doc-block-heading">Integración Dex LDAP + IDM</h2>
  <ul class="doc-list">
    <li><strong>Dex:</strong> conector <code>type: ldap</code> en <code>dex/config.yaml</code>; eliminado el password DB para usuarios locales.</li>
    <li><strong>Compose Dex:</strong> unión a <code>opencloud_opencloud-net</code>; montaje de volúmenes <code>opencloud-config</code> y <code>opencloud-data</code> para leer CA y <code>idm_password</code> del config montado.</li>
    <li><strong>Overlay OpenCloud:</strong> <code>IDM_LDAPS_ADDR=0.0.0.0:9235</code> para que Dex alcance LDAPS por hostname <code>opencloud</code>.</li>
    <li><strong>UI:</strong> <code>login.html</code> con botón «local» y <code>connector_id=ldap</code>; rutas nginx <code>/dex/auth</code> sin conector → selector de login.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Flujo</p>
  <h2 class="doc-block-heading">Login tras los cambios</h2>
  <div class="doc-note"><pre>login.html
  ├── Google  → Dex connector google  → token OIDC → proxy OpenCloud
  ├── Apple   → Dex connector apple   → (cuando esté configurado)
  └── Local   → Dex connector ldap    → IDM LDAPS opencloud:9235
                                         (cualquier uid inetOrgPerson + contraseña)</pre></div>
  <p>Los conectores sociales siguen el mismo patrón OIDC; el local deja de ser una lista fija en Dex y pasa a ser un bind LDAP contra el directorio embebido del stack.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">TLS</p>
  <h2 class="doc-block-heading">Fix certificado IDM LDAPS</h2>
  <p class="doc-block-intro">Durante las pruebas, Dex alcanzaba <code>opencloud:9235</code> pero el <code>ldap.crt</code> autogenerado sólo incluía <code>localhost</code> en el SAN → error <em>TLS certificate is valid for localhost, not opencloud</em>.</p>
  <p>Corrección (<code>0a042db</code>): script <code>scripts/regenerate-opencloud-idm-ldap-cert.sh</code> que regenera el certificado con <code>DNS:localhost,DNS:opencloud,IP:127.0.0.1</code> y opción <code>--restart</code>; documentado en runbook y README de Dex.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Commits</p>
  <h2 class="doc-block-heading">Ventana del día (CEST)</h2>
  <ul class="doc-list">
    <li><code>cf5a561</code> (15:27) — <code>feat(auth): Dex LDAP login against OpenCloud IDM for all users</code>.</li>
    <li><code>0a042db</code> (15:39) — <code>fix(dex): regenerate IDM LDAP cert with opencloud SAN for Dex TLS</code>.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Autoagents</p>
  <h2 class="doc-block-heading">Comprobaciones de cierre</h2>
  <ul class="doc-list">
    <li>SAN del cert IDM incluye <code>opencloud</code> — PASS.</li>
    <li>Dex LDAP <code>host: opencloud:9235</code> — PASS.</li>
    <li><code>curl</code> con <code>connector_id=ldap</code> → <code>/dex/auth/ldap</code> — PASS.</li>
    <li>Contraseña incorrecta → HTTP 401, bind LDAP, sin x509 en logs — PASS.</li>
    <li>Humo conector Google — PASS.</li>
    <li>Login manual dos usuarios distintos → <code>/files</code> — NO VERIFICADO (operador).</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Despliegue</p>
  <h2 class="doc-block-heading">Verificación (operador)</h2>
  <div class="doc-note"><pre>cd /opt/opencloud
./scripts/git-sync-main.sh
./scripts/apply-opencloud-compose-overrides.sh
./scripts/regenerate-opencloud-idm-ldap-cert.sh --restart
rsync -a /opt/opencloud/host-www/opencloud-auth/ /var/www/opencloud-auth/
cd dex && docker compose up -d

curl -sI https://cloud.km0digital.com/login.html</pre></div>
  <p>Manual: ventana privada → <code>login.html</code> → login local con dos <code>uid</code> distintos de OpenCloud; se espera <code>/oidc-callback.html</code> y luego <code>/files</code> sin errores JWKS ni <code>/graph/v1.0/me</code> 500.</p>
  <div class="doc-note">Las contraseñas de usuarios y secretos de bind IDM no forman parte de esta entrada; el happy-path con dos cuentas reales queda como verificación humana en producción.</div>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Siguiente paso</p>
  <h2 class="doc-block-heading">Día 5</h2>
  <p class="doc-closing">El <strong>día 5</strong> no documenta despliegues: recoge una reunión de visión en Masnou sobre por qué creemos que hoy ya se puede ofrecer tecnología útil sin pasar por las grandes corporaciones digitales. Mientras tanto, explora los <a href="/#services">servicios</a> o el <a href="/doc/day-5/">relato del día 5</a>.</p>
</section>
