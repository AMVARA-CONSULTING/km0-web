---
title: "Día 0 — Fundaciones del servidor"
description: "Debian, particiones, Docker, Nginx y base reproducible: el día dedicado a que el stack KM0 sea auditable y operable."
pubDate: 2026-05-21
locale: es
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducción</p>
  <p class="doc-lead">El día 0 está dedicado a <strong>fundaciones</strong>: sin una base reproducible del sistema operativo y del entorno de trabajo, cualquier stack posterior sería frágil y difícil de auditar.</p>
  <p class="doc-lead">El objetivo es salir del día con Debian estable, disco ordenado, herramientas mínimas pero suficientes y una consola que invite a documentar cada cambio.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Infraestructura</p>
  <h2 class="doc-block-heading">Plan técnico del arranque</h2>
  <p class="doc-block-intro">KM0 persigue una infraestructura operable por el equipo, sin paneles propietarios opacos. La visión completa del arranque incluye:</p>
  <ul class="doc-list">
    <li><strong>Sistema:</strong> VPS con Debian actualizado y particiones que separan sistema de datos cuando el proyecto lo requiere (snapshots y backups más claros).</li>
    <li><strong>Colaboración:</strong> <a href="https://cloud.km0digital.com">OpenCloud</a> como microservicios en imagen oficial de <a href="https://opencloud.eu">OpenCloud.eu</a>, con volúmenes estables (<code>COMPOSE_PROJECT_NAME</code>) independientes del directorio de ejecución de Compose.</li>
    <li><strong>Perímetro:</strong> Nginx como único frontal HTTPS; Docker publicando HTTP solo en <code>127.0.0.1</code>.</li>
    <li><strong>Comunicación:</strong> Astro dockerizado en otro puerto loopback; vhosts separados para <code>km0digital.com</code> y <code>cloud.km0digital.com</code>.</li>
    <li><strong>Observabilidad:</strong> logs rotados (<code>json-file</code>), runbooks con <code>docker compose ps</code>, <code>logs</code>, <code>pull</code>, y backups de volúmenes comprimidos.</li>
    <li><strong>Evolución:</strong> TLS interno en producción, copias automatizadas y Fail2ban por jails concretos.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Disco y sistema</p>
  <h2 class="doc-block-heading">Provisionamiento del VPS y particiones</h2>
  <p class="doc-block-intro">Se eligió <strong>Debian</strong> por predictibilidad de paquetes y documentación para administración manual, sin paneles obligatorios. El primer paso fue revisar el layout del disco:</p>
  <ul class="doc-list">
    <li>Separar datos del proyecto del sistema de ficheros raíz cuando haga falta respaldar por volumen.</li>
    <li>Definir montajes con criterio: <code>/var/lib/docker</code> puede concentrar el I/O de OpenCloud según el tamaño del VPS.</li>
    <li>Documentar convenciones para distinguir montajes persistentes frente al sistema operativo.</li>
  </ul>
  <div class="doc-note">El mapa exacto de particiones depende del proveedor y del tamaño contratado. Debe quedar en la wiki o runbook del proyecto, no solo en este blog, para recuperación ante fallos.</div>
</section>

<section class="doc-block">
  <p class="doc-block-title">Paquetes base</p>
  <h2 class="doc-block-heading">Software base</h2>
  <p class="doc-block-intro">Se instaló el mínimo razonable para administración remota segura y Docker, sin peso muerto:</p>
  <ul class="doc-list">
    <li>Utilidades habituales: <code>curl</code>, editores, red y diagnóstico.</li>
    <li><strong>Docker Engine</strong> con logs rotativos en <code>/etc/docker/daemon.json</code>.</li>
    <li><strong>Nginx</strong> desde paquetes del sistema como frontal estable.</li>
    <li><strong>Certbot</strong> y TLS según fase (HTTP-01 o certificado autofirmado en laboratorio).</li>
  </ul>
  <p>Cada pieza tiene un rol observable: <code>systemctl status</code>, <code>nginx -t</code>, <code>docker compose ps</code>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Consola</p>
  <h2 class="doc-block-heading">Ergonómica del shell</h2>
  <p class="doc-block-intro">Para sesiones SSH consistentes se aplicó la guía <a href="https://wiki.ldeluipy.es/initialConfiguration.html">initialConfiguration</a> del wiki:</p>
  <ul class="doc-list">
    <li>Prompt de Bash legible (ruta, estado del comando, pistas visuales).</li>
    <li>Historial y opciones seguras que reducen errores repetidos.</li>
    <li>Aliases y <code>PATH</code> orientados a Compose y Git bajo <code>/opt/...</code>.</li>
  </ul>
  <p>Esta base, documentada fuera del servidor, permite repetir el mismo molde en otros VPS sin improvisar.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Herramientas</p>
  <h2 class="doc-block-heading">cursor-agent</h2>
  <div class="doc-callout">
    <span class="doc-callout-title">Asistencia en la línea de comandos</span>
    <p>Se instaló <strong>cursor-agent</strong> para acercar el trabajo diario al flujo de desarrollo asistido: revisiones, scripts auxiliares y documentación incremental desde la consola.</p>
    <p>No sustituye la revisión humana ni los controles del equipo, pero reduce fricción en tareas repetibles (overlays de Compose, validar Nginx antes de recargar, etc.).</p>
  </div>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Cierre del día</p>
  <h2 class="doc-block-heading">Estado al terminar el día 0</h2>
  <p class="doc-block-intro">Al cerrar el día, el servidor cumple tres propiedades:</p>
  <ol class="doc-steps">
    <li><strong>Es auditable:</strong> layout de disco y paquetes conocidos.</li>
    <li><strong>Es repetible:</strong> pasos principales enlazados con wiki y runbooks.</li>
    <li><strong>Está listo</strong> para Docker sin exponer servicios al público antes de tiempo.</li>
  </ol>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Siguiente paso</p>
  <h2 class="doc-block-heading">Día 1</h2>
  <p class="doc-closing">El <strong>día 1</strong> materializa OpenCloud, el virtual host del proxy y la web KM0 con TLS. Mientras tanto, explora los <a href="/#services">servicios</a> o <a href="/#contact">escríbenos</a> si quieres colaborar.</p>
</section>
