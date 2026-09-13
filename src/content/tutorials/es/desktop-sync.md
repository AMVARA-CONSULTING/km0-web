---
title: "Cómo funciona la sincronización de escritorio en KM0 Cloud"
description: "Sincronización selectiva, archivos en línea en Windows, qué pasa al desincronizar o desvincular, y por qué no hay Known Folder Move."
locale: es
order: 7
platform: desktop
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducción</p>
  <p class="doc-lead">KM0 Cloud usa el <strong>cliente de escritorio OpenCloud</strong> en Windows, macOS y Linux. La sincronización mantiene una carpeta local al día con tu cuenta en la UE. El plan público de autoservicio es de <strong>150 GB</strong>. Si tu biblioteca es mayor, pide capacidad antes de una migración grande.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Antes de empezar</p>
  <h2 class="doc-block-heading">Instala el cliente de escritorio</h2>
  <ol class="doc-list">
    <li>Descarga el cliente oficial OpenCloud Desktop para tu sistema en <a href="https://github.com/opencloud-eu/desktop/releases" target="_blank" rel="noopener noreferrer">versiones de OpenCloud Desktop</a>.</li>
    <li>Instálalo, ábrelo e introduce la URL del servidor: <code>https://cloud.km0digital.com/</code>.</li>
    <li>Inicia sesión con el mismo método que en el navegador.</li>
  </ol>
  <p class="doc-block-intro">Documentación del fabricante: <a href="https://docs.opencloud.eu/docs/user/desktop-client/" target="_blank" rel="noopener noreferrer">OpenCloud Desktop Client</a>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Sincronización selectiva</p>
  <h2 class="doc-block-heading">Elige qué sincronizar (macOS y Linux)</h2>
  <ol class="doc-list">
    <li>Abre el cliente de escritorio y ve a la vista de la cuenta.</li>
    <li>Abre el menú de tres puntos (<strong>…</strong>) junto al Space que te interesa.</li>
    <li>Elige <strong>Choose What to Sync</strong> (Elegir qué sincronizar) y marca solo las carpetas que necesitas en este ordenador.</li>
  </ol>
  <p class="doc-block-intro">Las carpetas que dejas sin marcar no se mantienen como copia local sincronizada. Así ahorras disco. Siguen en el servidor y en la web.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Windows</p>
  <h2 class="doc-block-heading">Archivos en línea (sistema de archivos virtual)</h2>
  <p class="doc-block-intro">En Windows el cliente usa marcadores en el Explorador para que los archivos en la nube aparezcan sin descargarse del todo.</p>
  <ul class="doc-list">
    <li><strong>Always keep on this device</strong>: copia local completa, disponible sin red.</li>
    <li><strong>Available when online</strong>: marcador; se descarga al abrirlo.</li>
    <li><strong>Free up space</strong>: quita el contenido local y deja el archivo en la nube como solo en línea.</li>
  </ul>
  <p class="doc-block-intro">Documentación: <a href="https://docs.opencloud.eu/docs/user/desktop-client/windows/sync-settings-win/" target="_blank" rel="noopener noreferrer">ajustes de sincronización en Windows</a>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Límites</p>
  <h2 class="doc-block-heading">No hay Known Folder Move</h2>
  <p class="doc-block-intro">OpenCloud Desktop <strong>no</strong> redirige <strong>Escritorio</strong>, <strong>Documentos</strong> ni <strong>Imágenes</strong> de Windows como hace Known Folder Move de OneDrive. Los archivos se sincronizan dentro de la carpeta de OpenCloud (y los Spaces que conectes). Trabaja desde esa carpeta o copia ahí de forma deliberada.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Desincronizar y desvincular</p>
  <h2 class="doc-block-heading">Qué pasa con los archivos locales</h2>
  <ul class="doc-list">
    <li><strong>Remove Sync Folder Connection</strong> (menú de cuenta en macOS/Linux): deja de sincronizar ese Space. La documentación oficial de OpenCloud indica que <strong>no</strong> borra los archivos locales. El Space sigue en el servidor.</li>
    <li><strong>Choose What to Sync</strong>: desmarcar una carpeta deja de mantenerla como copia local sincronizada. Prefiere <strong>Remove Sync Folder Connection</strong> si quieres desconectar sin tratar la acción como limpieza del árbol de sync.</li>
    <li><strong>Sincronización bidireccional</strong>: si el sync está activo y borras un archivo dentro de la carpeta sincronizada, el cliente puede borrarlo también en el servidor. El sync no es una copia de seguridad solo de subida.</li>
    <li><strong>Free up space</strong> en Windows: libera el contenido local de ese elemento; el archivo sigue en KM0 Cloud.</li>
  </ul>
  <p class="doc-block-intro">En claro: desvincular o quitar la conexión de sync no es un borrado de tus copias locales. Borrar archivos tú mismo con el sync activo es otra cosa. Más detalle: <a href="/tutorials/photo-backup/">copia de fotos y restauración</a>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Almacenamiento</p>
  <h2 class="doc-block-heading">150 GB en autoservicio</h2>
  <p class="doc-block-intro">El plan publicado es <strong>150 GB por 1,99 €/mes</strong>. Una biblioteca de varios años puede pasarse. Comprueba el tamaño antes de prometerte un volcado completo. Cuotas mayores se tratan bajo petición (ver <a href="/pricing/">precios</a> y contacto).</p>
</section>
