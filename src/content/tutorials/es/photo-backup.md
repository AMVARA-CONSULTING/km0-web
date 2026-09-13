---
title: "Copia de seguridad de fotos en Android e iOS"
description: "Subida automática de fotos del móvil a KM0 Cloud, originales frente a conversión opcional, y cómo restaurar si el teléfono muere."
locale: es
order: 8
platform: mobile
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducción</p>
  <p class="doc-lead">Las apps OpenCloud para <strong>Android</strong> e <strong>iOS</strong> pueden subir fotos y vídeos nuevos a tu cuenta KM0 Cloud. Los archivos viven en servidores de la UE en <code>cloud.km0digital.com</code>. El plan público es de <strong>150 GB</strong>: dilo de entrada si el objetivo es una biblioteca de toda la vida.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Antes de empezar</p>
  <h2 class="doc-block-heading">Inicia sesión en el móvil</h2>
  <ol class="doc-list">
    <li>Instala OpenCloud desde la tienda (ver <a href="/tutorials/getting-started-android/">Android</a> o <a href="/tutorials/getting-started-ios/">iOS</a>).</li>
    <li>URL del servidor: <code>https://cloud.km0digital.com/</code>.</li>
    <li>Concede permiso a la biblioteca de fotos cuando la app lo pida.</li>
    <li>Elige una carpeta de destino en KM0 Cloud antes de esperar subidas automáticas.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Android</p>
  <h2 class="doc-block-heading">Subida automática de fotos y vídeos</h2>
  <ol class="doc-list">
    <li>Abre OpenCloud → <strong>Settings</strong> (Ajustes).</li>
    <li>Configura <strong>Automatic picture uploads</strong> y <strong>Automatic video uploads</strong> (carpeta de destino y comportamiento).</li>
    <li>Deja el móvil en Wi-Fi para lotes grandes cuando puedas. El momento lo decide Android; la subida puede esperar unos minutos.</li>
  </ol>
  <p class="doc-block-intro">Resumen del fabricante: <a href="https://docs.opencloud.eu/docs/user/android-app/general/settings/" target="_blank" rel="noopener noreferrer">ajustes de Android</a>.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">iOS</p>
  <h2 class="doc-block-heading">Auto Upload de fotos y vídeos</h2>
  <ol class="doc-list">
    <li>Abre OpenCloud → <strong>Settings</strong> → <strong>Media Upload</strong>.</li>
    <li>Define <strong>Photo upload path</strong> a una carpeta de tu cuenta.</li>
    <li>Activa <strong>Auto Upload Photos</strong> y/o <strong>Auto Upload Videos</strong>.</li>
  </ol>
  <p class="doc-block-intro">Comportamiento actual en iOS (docs OpenCloud): Auto Upload funciona con la app abierta en primer plano. Si la app está cerrada, el medio nuevo espera a que la abras. Al abrirla, detecta lo creado desde la última subida correcta.</p>
  <p class="doc-block-intro">Documentación: <a href="https://docs.opencloud.eu/docs/user/ios-app/general/settings/auto-upload-photos-and-videos/" target="_blank" rel="noopener noreferrer">Auto Upload Photos and Videos</a>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Calidad</p>
  <h2 class="doc-block-heading">Originales frente a conversión opcional</h2>
  <p class="doc-block-intro">En iOS la conversión es un ajuste explícito, no un valor oculto por defecto:</p>
  <ul class="doc-list">
    <li><strong>Convert HEIC to JPEG</strong> y <strong>Convert videos to MP4</strong> solo se aplican si los activas.</li>
    <li>Déjalos apagados si quieres subir los formatos originales del teléfono.</li>
    <li><strong>Preserve original media file names</strong> conserva el nombre de la cámara si está activo.</li>
  </ul>
  <p class="doc-block-intro">KM0 no aplica una capa extra de recompresión encima de la app OpenCloud. Lo que configures en la app es lo que cuenta contra tus 150 GB.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Restaurar</p>
  <h2 class="doc-block-heading">Si el teléfono se rompe o se pierde</h2>
  <ol class="doc-list">
    <li>En otro móvil u ordenador, abre <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a> o la app OpenCloud.</li>
    <li>Inicia sesión en la misma cuenta.</li>
    <li>Abre la carpeta de subida y descarga las fotos, o activa Auto Upload en el teléfono nuevo apuntando a la misma carpeta (o a una nueva).</li>
  </ol>
  <p class="doc-block-intro">Quitar la app o cerrar sesión no borra los archivos ya guardados en KM0 Cloud. La opción de borrar copias locales no usadas solo limpia cachés del dispositivo; en el servidor siguen.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Almacenamiento</p>
  <h2 class="doc-block-heading">¿Bastan 150 GB?</h2>
  <p class="doc-block-intro">Muchas cámaras generan originales grandes. Miles de fotos modernas pueden llenar 150 GB. Mira el almacenamiento del teléfono o sube un mes de muestra y extrapola. ¿Necesitas más? Contacta antes de fiarte de una copia a medias. Relacionado: <a href="/tutorials/desktop-sync/">sincronización de escritorio</a>, <a href="/guides/protect-family-photos/">proteger fotos familiares</a>.</p>
</section>
