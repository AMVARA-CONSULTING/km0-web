---
title: "Día 0 — Fundaciones del servidor"
description: "Debian, particiones, Docker, Nginx y base reproducible: el día dedicado a que el stack KM0 sea auditable y operable."
pubDate: 2026-05-21
locale: es
---

<p class="doc-lead">El día 0 está dedicado a <strong>fundaciones</strong>: sin una base reproducible del sistema operativo y del entorno de trabajo, cualquier stack posterior sería frágil y difícil de auditar. El objetivo es salir del día con Debian estable, disco ordenado, herramientas mínimas pero suficientes y una consola que invite a documentar cada cambio.</p>

## Plan técnico del arranque (visión completa)

<p>KM0 persigue una infraestructura que pueda ser operada por personas del equipo sin depender de paneles propietarios opacos:</p>

<ul class="doc-list">
  <li><strong>Sistema:</strong> VPS con Debian actualizado, esquema de particiones que separa sistema de datos cuando tiene sentido en el proyecto (facilita snapshots y políticas de backup).</li>
  <li><strong>Colaboración:</strong> <a href="https://cloud.km0.amvara.de">OpenCloud</a> desplegado como conjunto de microservicios coordinados dentro de una imagen oficial mantenida por la comunidad <a href="https://opencloud.eu">OpenCloud.eu</a>, con volúmenes nombrados de forma estable (<code>COMPOSE_PROJECT_NAME</code>) para que los backups no dependan del directorio desde el que se ejecuta Compose.</li>
  <li><strong>Perímetro:</strong> Nginx como único frontal HTTPS; overlays Docker que publican HTTP solo en <code>127.0.0.1</code>.</li>
  <li><strong>Comunicación:</strong> Sitio Astro dockerizado sirviendo estáticos en otro puerto loopback; virtual hosts independientes para marketing (<code>km0.amvara.de</code>) y cloud (<code>cloud.km0.amvara.de</code>).</li>
  <li><strong>Observabilidad:</strong> logs de contenedor rotados (<code>json-file</code> con tamaño máximo), comandos habituales documentados en runbooks (<code>docker compose ps</code>, <code>logs</code>, <code>pull</code>), backups de volúmenes como artefactos comprimidos.</li>
  <li><strong>Evolución:</strong> endurecer TLS entre microservicios internos cuando los certificados sean totalmente confiables en cadena, automatizar copias de seguridad y endurecer políticas Fail2ban por jails específicos.</li>
</ul>

## Provisionamiento del VPS y particiones

<p>Se eligió un servidor con <strong>Debian</strong> por predictibilidad del ciclo de paquetes y amplia documentación para administración manual (sin paneles obligatorios). Lo primero fue revisar el layout del disco y crear particiones coherentes con el uso previsto:</p>

<ul class="doc-list">
  <li>Separación que permita crecer datos del proyecto sin mezclarlos con el sistema de ficheros raíz cuando sea necesario respaldar por volumen.</li>
  <li>Criterios claros para montajes: <code>/var/lib/docker</code> puede concentrar el I/O de OpenCloud según tamaño del VPS.</li>
  <li>Convenciones documentadas para que cualquier persona del equipo reconozca qué montaje corresponde a datos persistentes frente al sistema.</li>
</ul>

<div class="doc-note">Los detalles exactos del mapa de particiones son específicos del proveedor y del tamaño contratado; lo importante es que queden documentados fuera del blog en la wiki o runbook del proyecto para recuperación ante fallos.</div>

## Software base

<p>Se instaló el conjunto mínimo razonable para administración segura remota y para construir encima Docker sin “peso muerto” innecesario:</p>

<ul class="doc-list">
  <li>Herramientas de sistema habituales: <code>curl</code>, editores, utilidades de red y diagnóstico.</li>
  <li><strong>Docker Engine</strong> con política de logs rotativos (<code>/etc/docker/daemon.json</code>) para que los registros no ocupen todo el disco.</li>
  <li><strong>Nginx</strong> desde paquetes del sistema como frontal estable.</li>
  <li><strong>Certbot</strong> y estrategia TLS según fase del proyecto (emisión HTTP-01 o certificado autofirmado para laboratorio).</li>
</ul>

<p>La filosofía es que cada componente tiene un rol único y observable en el árbol de dependencias del sistema: <code>systemctl status</code>, <code>nginx -t</code>, <code>docker compose ps</code>.</p>

<hr />

## Ergonómica del shell y configuración reproducible

<p>Para que las sesiones SSH posteriores sean consistentes se aplicaron mejoras guiadas por la documentación interna <a href="https://wiki.ldeluipy.es/initialConfiguration.html">initialConfiguration</a> del wiki:</p>

<ul class="doc-list">
  <li>Prompt de Bash más legible (directorio actual, estado de comando, hints visuales).</li>
  <li>Ajustes que reducen errores repetidos (historial útil, opciones seguras por defecto donde aplique).</li>
  <li>Convenciones para aliases y <code>PATH</code> que anticipan el trabajo con Docker Compose y Git desde <code>/opt/...</code>.</li>
</ul>

<p>Tener esta base escrita fuera del servidor permite repetir el mismo molde en otros VPS del proyecto sin improvisar cada vez.</p>

## cursor-agent

<div class="doc-callout">
  <span class="doc-callout-title">Asistencia en la línea de comandos</span>
  <p>Se instaló <strong>cursor-agent</strong> para acercar el flujo de trabajo del día a día al del entorno de desarrollo asistido: revisiones automatizadas, generación de scripts auxiliares y documentación incremental sin abandonar la consola del servidor.</p>
  <p>No sustituye la revisión humana ni los controles de cambio del equipo, pero reduce fricción cuando hay que repetir tareas verificables (actualizar overlays de Compose, validar sintaxis de Nginx antes de recargar, etc.).</p>
</div>

## Estado al cierre del día 0

<p>Al terminar el día el servidor cumple tres propiedades:</p>

<ol class="doc-steps">
  <li><strong>Es auditable:</strong> layout de disco y paquetes conocidos.</li>
  <li><strong>Es repetible:</strong> pasos principales enlazan con wiki y runbooks.</li>
  <li><strong>Está listo</strong> para cargas Docker sin exponer servicios prematuramente al público.</li>
</ol>

<div class="doc-closing">
  El <strong>día 1</strong> aprovecha esa base para materializar OpenCloud, el virtual host del proxy y la web KM0 ya enlazadas por TLS. Mientras tanto, puedes explorar los <a href="/#servicios">servicios</a> publicados o <a href="/#contacto">escribirnos</a> si quieres colaborar.
</div>
