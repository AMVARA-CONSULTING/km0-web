---
title: "Día 15 - Registro OpenCloud: token Graph caducado y renovación automática"
description: "Un token Graph caducado bloqueó el registro por email en KM0 Cloud; documentamos la causa, la rotación segura del token register-api y los fallos que encontramos al automatizar la renovación."
pubDate: 2026-07-04
locale: es
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducción</p>
  <p class="doc-lead">El <strong>día 15</strong> volvemos a infraestructura operativa en el proyecto hermano <a href="https://github.com/AMVARA-CONSULTING/km0-opencloud">km0-opencloud</a>. El 4 de julio de 2026 un usuario intentó registrarse con email y contraseña en <a href="https://cloud.km0digital.com/register.html">KM0 Cloud</a> y vio un error genérico. Google OAuth seguía funcionando. La causa: el <strong>token Graph de register-api había caducado</strong>.</p>
  <p class="doc-lead">En el <a href="https://github.com/AMVARA-CONSULTING/km0-opencloud/issues/17">issue #17</a> implementamos rotación manual, renovación automática segura y corregimos dos defectos que el tester encontró al validar el script. Este artículo explica qué pasó, por qué importa y qué quedó automatizado.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Incidente</p>
  <h2 class="doc-block-heading">Qué vio el usuario</h2>
  <p class="doc-block-intro">El formulario mostró el mensaje genérico «No se pudo crear la cuenta. Inténtalo de nuevo más tarde.» sin indicar que el servicio estaba temporalmente caído. Más tarde el mismo usuario entró con <strong>Google OAuth</strong> sin problema.</p>
  <ul class="doc-list">
    <li><strong>Causa raíz:</strong> <code>GRAPH_SERVICE_APP_TOKEN</code> de register-api caducado o inválido; Graph rechazaba las credenciales.</li>
    <li><strong>Evidencia:</strong> <code>GET /health</code> devolvía <code>graph_auth_ok: false</code>; <code>POST /api/register</code> respondía HTTP 503.</li>
    <li><strong>OAuth intacto:</strong> el login con Google usa Dex + OIDC, no register-api; por eso un camino funcionaba y el otro no.</li>
    <li><strong>Contexto previo:</strong> el <a href="https://github.com/AMVARA-CONSULTING/km0-opencloud/issues/16">issue #16</a> ya había mejorado los mensajes de error del formulario; este día atacamos la causa operativa del 503.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Motivo</p>
  <h2 class="doc-block-heading">Por qué register-api necesita un token</h2>
  <p class="doc-block-intro">El registro email/contraseña en <a href="https://cloud.km0digital.com/">KM0 Cloud</a> pasa por un sidecar, <strong>register-api</strong>, que crea usuarios vía OpenCloud Graph (<code>POST /graph/v1.0/users</code>). En producción Graph no acepta Basic auth con contraseña; register-api debe autenticarse con un <strong>Graph App Token</strong> dedicado.</p>
  <div class="doc-callout">
    <span class="doc-callout-title">Secreto operativo</span>
    <p>Ese token es un secreto con fecha de caducidad. Si expira y nadie lo renueva, el registro manual se cae en silencio mientras OAuth sigue vivo. Hay que tratarlo como credencial de infraestructura, no como configuración «poner una vez y olvidar».</p>
  </div>
</section>

<section class="doc-block">
  <p class="doc-block-title">Implementación</p>
  <h2 class="doc-block-heading">Rotación y auto-renovación (issue #17)</h2>
  <ul class="doc-list">
    <li><strong>Política:</strong> token dedicado solo para register-api, caducidad de <strong>3 meses</strong>, renovación automática cuando queden menos de <strong>14 días</strong>.</li>
    <li><strong><code>setup-register-api-graph-token.sh</code>:</strong> crea el token con <code>--expires-in 90d</code>, escribe <code>GRAPH_SERVICE_APP_TOKEN</code> y <code>GRAPH_SERVICE_APP_TOKEN_EXPIRES_AT</code> en <code>register-api/.env</code>.</li>
    <li><strong><code>renew-register-api-graph-token.sh</code>:</strong> comprueba salud y fecha; renueva si <code>graph_auth_ok</code> es false o falta margen; reinicia <strong>solo register-api</strong>; verifica <code>/health</code>.</li>
    <li><strong>Cron:</strong> plantilla semanal (lunes 03:00 UTC) en <code>register-api-token-renewal.cron</code>.</li>
    <li><strong>Seguridad:</strong> el proceso nunca toca usuarios, volúmenes, Dex/OIDC, bases de datos ni el resto del <code>.env</code> de OpenCloud.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Errores encontrados</p>
  <h2 class="doc-block-heading">Lo que falló al probar la automatización</h2>
  <p class="doc-block-intro">La primera versión del script de renovación pasó las pruebas manuales básicas, pero el tester encontró dos defectos al ejecutar escenarios reales de cron y renovación forzada.</p>
  <ul class="doc-list">
    <li><strong>Usuario Graph incorrecto:</strong> el script de renovación no propagaba <code>GRAPH_SERVICE_USER</code> desde <code>register-api/.env</code>. El setup generaba el token para el usuario por defecto (<code>admin</code>) en lugar del operador configurado. <strong>Fix:</strong> leer <code>GRAPH_SERVICE_USER</code> del <code>.env</code> y pasarlo con <code>--user</code> al setup.</li>
    <li><strong>Carrera tras el reinicio:</strong> <code>verify-register-api.sh</code> se ejecutaba inmediatamente después de <code>docker compose up</code> y fallaba porque register-api aún no había arrancado del todo. <strong>Fix:</strong> espera activa hasta 30 s (<code>REGISTER_API_HEALTH_WAIT_SEC</code>) comprobando <code>graph_auth_ok: true</code> antes de verificar.</li>
  </ul>
  <p>Tras estos cambios, los escenarios de «skip», renovación forzada y umbral de 7 días salieron con exit code 0 y <code>graph_auth_ok: true</code>.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Límites</p>
  <h2 class="doc-block-heading">Qué nunca debe hacer la renovación</h2>
  <p class="doc-block-intro">Documentamos límites explícitos en el runbook de km0-opencloud para que un script automatizado no pueda dañar producción.</p>
  <ul class="doc-list">
    <li>No ejecutar <code>docker compose down -v</code>, <code>docker volume rm</code> ni comandos de reset de usuarios OpenCloud.</li>
    <li>No modificar Dex, OIDC, almacenamiento, bases de datos ni grupos existentes.</li>
    <li>Solo actualizar el token de register-api, reiniciar ese contenedor y comprobar salud.</li>
    <li>Si la renovación falla, Google OAuth y los datos de usuarios existentes quedan intactos.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">KM0</p>
  <h2 class="doc-block-heading">Por qué lo contamos en el blog</h2>
  <p class="doc-block-intro">KM0 promete servicios cercanos y operables: cloud, mail y web bajo tu control. Un token caducado es un recordatorio de que <strong>la operación importa tanto como el despliegue</strong>.</p>
  <ul class="doc-list">
    <li><strong>Transparencia:</strong> si el registro email falla, ahora hay mensajes tipados (issue #16) y procedimiento de rotación documentado.</li>
    <li><strong>Automatización segura:</strong> renovación semanal con alcance mínimo, no «scripts heroicos» que reinician todo el stack.</li>
    <li><strong>Serie:</strong> el <a href="/doc/day-14/">día 14</a> hablaba de IA y burocracia; aquí la burocracia es un token con fecha de caducidad y un cron que la renueva antes de que el usuario lo note.</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Verificación</p>
  <h2 class="doc-block-heading">Comprobar el registro</h2>
  <ol class="doc-steps">
    <li><strong>Salud:</strong> operadores pueden ejecutar <code>./scripts/verify-register-api.sh</code> en km0-opencloud y confirmar <code>graph_auth_ok: true</code>.</li>
    <li><strong>Registro:</strong> probar <a href="https://cloud.km0digital.com/register.html">registro email/contraseña</a> o entrar con Google si ya tienes cuenta.</li>
    <li><strong>Serie:</strong> leer el <a href="/doc/day-14/">día 14</a> (Harari e IA) y el <a href="/doc/day-11/">día 11</a> (KM0 Mail).</li>
    <li><strong>Ideas:</strong> cuéntanos por <a href="/ideas/">formulario de ideas</a> o <a href="/#contact">contacto</a> si quieres más entradas sobre operación de KM0 Cloud.</li>
  </ol>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Serie</p>
  <h2 class="doc-block-heading">Días anteriores</h2>
  <p class="doc-closing">El <a href="/doc/day-14/">día 14</a> resumió el vídeo de Harari sobre IA y civilización; el <a href="/doc/day-13/">día 13</a> el meet 6 sobre visibilidad; el <a href="/doc/day-11/">día 11</a> documentó KM0 Mail. Sigue la serie y prueba <a href="https://cloud.km0digital.com/">KM0 Cloud</a> cuando quieras.</p>
</section>
