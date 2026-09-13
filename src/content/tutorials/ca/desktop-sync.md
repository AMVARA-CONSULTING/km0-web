---
title: "Com funciona la sincronització d'escriptori a KM0 Cloud"
description: "Sincronització selectiva, fitxers en línia a Windows, què passa en desincronitzar o desvincular, i per què no hi ha Known Folder Move."
locale: ca
order: 7
platform: desktop
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducció</p>
  <p class="doc-lead">KM0 Cloud fa servir el <strong>client d'escriptori OpenCloud</strong> a Windows, macOS i Linux. La sincronització manté una carpeta local al dia amb el teu compte a la UE. El pla públic d'autoservei és de <strong>150 GB</strong>. Si la biblioteca és més gran, demana capacitat abans d'una migració grossa.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Abans de començar</p>
  <h2 class="doc-block-heading">Instal·la el client d'escriptori</h2>
  <ol class="doc-list">
    <li>Descarrega el client oficial OpenCloud Desktop per al teu sistema a <a href="https://github.com/opencloud-eu/desktop/releases" target="_blank" rel="noopener noreferrer">versions d'OpenCloud Desktop</a>.</li>
    <li>Instal·la'l, obre'l i introdueix l'URL del servidor: <code>https://cloud.km0digital.com/</code>.</li>
    <li>Inicia sessió amb el mateix mètode que al navegador.</li>
  </ol>
  <p class="doc-block-intro">Documentació del fabricant: <a href="https://docs.opencloud.eu/docs/user/desktop-client/" target="_blank" rel="noopener noreferrer">OpenCloud Desktop Client</a>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Sincronització selectiva</p>
  <h2 class="doc-block-heading">Tria què sincronitzar (macOS i Linux)</h2>
  <ol class="doc-list">
    <li>Obre el client d'escriptori i ves a la vista del compte.</li>
    <li>Obre el menú de tres punts (<strong>…</strong>) al costat del Space que et interessa.</li>
    <li>Tria <strong>Choose What to Sync</strong> i marca només les carpetes que necessites en aquest ordinador.</li>
  </ol>
  <p class="doc-block-intro">Les carpetes que deixes sense marcar no es mantenen com a còpia local sincronitzada. Així estalvies disc. Continuen al servidor i a la web.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Windows</p>
  <h2 class="doc-block-heading">Fitxers en línia (sistema de fitxers virtual)</h2>
  <p class="doc-block-intro">A Windows el client fa servir marcadors a l'Explorador perquè els fitxers al núvol apareguin sense descarregar-se del tot.</p>
  <ul class="doc-list">
    <li><strong>Always keep on this device</strong>: còpia local completa, disponible sense xarxa.</li>
    <li><strong>Available when online</strong>: marcador; es descarrega en obrir-lo.</li>
    <li><strong>Free up space</strong>: treu el contingut local i deixa el fitxer al núvol com a només en línia.</li>
  </ul>
  <p class="doc-block-intro">Documentació: <a href="https://docs.opencloud.eu/docs/user/desktop-client/windows/sync-settings-win/" target="_blank" rel="noopener noreferrer">ajustaments de sincronització a Windows</a>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Límits</p>
  <h2 class="doc-block-heading">No hi ha Known Folder Move</h2>
  <p class="doc-block-intro">OpenCloud Desktop <strong>no</strong> redirigeix <strong>Escriptori</strong>, <strong>Documents</strong> ni <strong>Imatges</strong> de Windows com fa Known Folder Move d'OneDrive. Els fitxers es sincronitzen dins de la carpeta d'OpenCloud (i els Spaces que connectis). Treballa des d'aquesta carpeta o copia-hi de forma deliberada.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Desincronitzar i desvincular</p>
  <h2 class="doc-block-heading">Què passa amb els fitxers locals</h2>
  <ul class="doc-list">
    <li><strong>Remove Sync Folder Connection</strong> (menú de compte a macOS/Linux): deixa de sincronitzar aquest Space. La documentació oficial d'OpenCloud indica que <strong>no</strong> esborra els fitxers locals. El Space continua al servidor.</li>
    <li><strong>Choose What to Sync</strong>: desmarcar una carpeta deixa de mantenir-la com a còpia local sincronitzada. Prefereix <strong>Remove Sync Folder Connection</strong> si vols desconnectar sense tractar l'acció com a neteja de l'arbre de sync.</li>
    <li><strong>Sincronització bidireccional</strong>: si el sync està actiu i esborres un fitxer dins de la carpeta sincronitzada, el client pot esborrar-lo també al servidor. El sync no és una còpia de seguretat només de pujada.</li>
    <li><strong>Free up space</strong> a Windows: allibera el contingut local d'aquest element; el fitxer continua a KM0 Cloud.</li>
  </ul>
  <p class="doc-block-intro">En clar: desvincular o treure la connexió de sync no és un esborrat de les teves còpies locals. Esborrar fitxers tu mateix amb el sync actiu és una altra cosa. Més detall: <a href="/ca/tutorials/photo-backup/">còpia de fotos i restauració</a>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Emmagatzematge</p>
  <h2 class="doc-block-heading">150 GB en autoservei</h2>
  <p class="doc-block-intro">El pla publicat és <strong>150 GB per 1,99 €/mes</strong>. Una biblioteca de diversos anys pot superar-ho. Comprova la mida abans de prometre't un bolcat complet. Quotes més grans es tracten sota petició (vegeu <a href="/ca/pricing/">preus</a> i contacte).</p>
</section>
