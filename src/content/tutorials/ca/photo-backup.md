---
title: "Còpia de seguretat de fotos a Android i iOS"
description: "Pujada automàtica de fotos del mòbil a KM0 Cloud, originals davant conversió opcional, i com restaurar si el telèfon es mor."
locale: ca
order: 8
platform: mobile
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducció</p>
  <p class="doc-lead">Les apps OpenCloud per a <strong>Android</strong> i <strong>iOS</strong> poden pujar fotos i vídeos nous al teu compte KM0 Cloud. Els fitxers viuen en servidors de la UE a <code>cloud.km0digital.com</code>. El pla públic és de <strong>150 GB</strong>: digues-ho d'entrada si l'objectiu és una biblioteca de tota la vida.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Abans de començar</p>
  <h2 class="doc-block-heading">Inicia sessió al mòbil</h2>
  <ol class="doc-list">
    <li>Instal·la OpenCloud des de la botiga (vegeu <a href="/ca/tutorials/getting-started-android/">Android</a> o <a href="/ca/tutorials/getting-started-ios/">iOS</a>).</li>
    <li>URL del servidor: <code>https://cloud.km0digital.com/</code>.</li>
    <li>Concedeix permís a la biblioteca de fotos quan l'app ho demani.</li>
    <li>Tria una carpeta de destinació a KM0 Cloud abans d'esperar pujades automàtiques.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Android</p>
  <h2 class="doc-block-heading">Pujada automàtica de fotos i vídeos</h2>
  <ol class="doc-list">
    <li>Obre OpenCloud → <strong>Settings</strong>.</li>
    <li>Configura <strong>Automatic picture uploads</strong> i <strong>Automatic video uploads</strong> (carpeta de destinació i comportament).</li>
    <li>Deixa el mòbil amb Wi-Fi per a lots grans quan puguis. El moment el decideix Android; la pujada pot esperar uns minuts.</li>
  </ol>
  <p class="doc-block-intro">Resum del fabricant: <a href="https://docs.opencloud.eu/docs/user/android-app/general/settings/" target="_blank" rel="noopener noreferrer">ajustaments d'Android</a>.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">iOS</p>
  <h2 class="doc-block-heading">Auto Upload de fotos i vídeos</h2>
  <ol class="doc-list">
    <li>Obre OpenCloud → <strong>Settings</strong> → <strong>Media Upload</strong>.</li>
    <li>Defineix <strong>Photo upload path</strong> a una carpeta del teu compte.</li>
    <li>Activa <strong>Auto Upload Photos</strong> i/o <strong>Auto Upload Videos</strong>.</li>
  </ol>
  <p class="doc-block-intro">Comportament actual a iOS (docs OpenCloud): Auto Upload funciona amb l'app oberta en primer pla. Si l'app està tancada, el medi nou espera que l'obris. En obrir-la, detecta el creat des de l'última pujada correcta.</p>
  <p class="doc-block-intro">Documentació: <a href="https://docs.opencloud.eu/docs/user/ios-app/general/settings/auto-upload-photos-and-videos/" target="_blank" rel="noopener noreferrer">Auto Upload Photos and Videos</a>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Qualitat</p>
  <h2 class="doc-block-heading">Originals davant conversió opcional</h2>
  <p class="doc-block-intro">A iOS la conversió és un ajustament explícit, no un valor ocult per defecte:</p>
  <ul class="doc-list">
    <li><strong>Convert HEIC to JPEG</strong> i <strong>Convert videos to MP4</strong> només s'apliquen si els actives.</li>
    <li>Deixa'ls apagats si vols pujar els formats originals del telèfon.</li>
    <li><strong>Preserve original media file names</strong> conserva el nom de la càmera si està actiu.</li>
  </ul>
  <p class="doc-block-intro">KM0 no aplica una capa extra de recomprensió damunt de l'app OpenCloud. El que configuris a l'app és el que compta contra els teus 150 GB.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Restaurar</p>
  <h2 class="doc-block-heading">Si el telèfon es trenca o es perd</h2>
  <ol class="doc-list">
    <li>En un altre mòbil o ordinador, obre <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a> o l'app OpenCloud.</li>
    <li>Inicia sessió al mateix compte.</li>
    <li>Obre la carpeta de pujada i descarrega les fotos, o activa Auto Upload al telèfon nou apuntant a la mateixa carpeta (o a una de nova).</li>
  </ol>
  <p class="doc-block-intro">Treure l'app o tancar sessió no esborra els fitxers ja guardats a KM0 Cloud. L'opció d'esborrar còpies locals no usades només neteja memòries cau del dispositiu; al servidor continuen.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Emmagatzematge</p>
  <h2 class="doc-block-heading">N'hi ha prou amb 150 GB?</h2>
  <p class="doc-block-intro">Moltes càmeres generen originals grans. Milers de fotos modernes poden omplir 150 GB. Mira l'emmagatzematge del telèfon o puja un mes de mostra i extrapola. Necessites més? Contacta abans de fiar-te d'una còpia a mitges. Relacionat: <a href="/ca/tutorials/desktop-sync/">sincronització d'escriptori</a>, <a href="/ca/guides/protect-family-photos/">protegir fotos familiars</a>.</p>
</section>
