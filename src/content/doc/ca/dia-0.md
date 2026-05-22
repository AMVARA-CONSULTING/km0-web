---
title: "Dia 0 — Fonaments del servidor"
description: "Debian, particions, Docker, Nginx i base reproducible: el dia dedicat a fer l'stack KM0 auditable i operable."
pubDate: 2026-05-21
locale: ca
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducció</p>
  <p class="doc-lead">El dia 0 està dedicat als <strong>fonaments</strong>: sense una base reproducible del sistema operatiu i de l'entorn de treball, qualsevol stack posterior seria fràgil i difícil d'auditar.</p>
  <p class="doc-lead">L'objectiu és sortir del dia amb Debian estable, disc ordenat, eines mínimes però suficients i una consola que convidi a documentar cada canvi.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Infraestructura</p>
  <h2 class="doc-block-heading">Pla tècnic de l'arrencada</h2>
  <p class="doc-block-intro">KM0 persegueix una infraestructura operable per l'equip, sense panells propietaris opacs. La visió completa de l'arrencada inclou:</p>
  <ul class="doc-list">
    <li><strong>Sistema:</strong> VPS amb Debian actualitzat i particions que separen sistema de dades quan el projecte ho requereix (snapshots i còpies més clares).</li>
    <li><strong>Col·laboració:</strong> <a href="https://cloud.km0.amvara.de">OpenCloud</a> com a microserveis en imatge oficial d'<a href="https://opencloud.eu">OpenCloud.eu</a>, amb volums estables (<code>COMPOSE_PROJECT_NAME</code>) independents del directori d'execució de Compose.</li>
    <li><strong>Perímetre:</strong> Nginx com a únic frontal HTTPS; Docker publicant HTTP només a <code>127.0.0.1</code>.</li>
    <li><strong>Comunicació:</strong> Astro dockeritzat en un altre port loopback; vhosts separats per a <code>km0.amvara.de</code> i <code>cloud.km0.amvara.de</code>.</li>
    <li><strong>Observabilitat:</strong> logs rotats (<code>json-file</code>), runbooks amb <code>docker compose ps</code>, <code>logs</code>, <code>pull</code>, i còpies de volums comprimits.</li>
    <li><strong>Evolució:</strong> TLS intern en producció, còpies automatitzades i Fail2ban per jails concrets.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Disc i sistema</p>
  <h2 class="doc-block-heading">Provisionament del VPS i particions</h2>
  <p class="doc-block-intro">Es va triar <strong>Debian</strong> per predictibilitat de paquets i documentació per a administració manual, sense panells obligatoris. El primer pas va ser revisar el layout del disc:</p>
  <ul class="doc-list">
    <li>Separar dades del projecte del sistema de fitxers arrel quan calgui fer còpia per volum.</li>
    <li>Definir muntatges amb criteri: <code>/var/lib/docker</code> pot concentrar l'I/O d'OpenCloud segons la mida del VPS.</li>
    <li>Documentar convencions per distingir muntatges persistents del sistema operatiu.</li>
  </ul>
  <div class="doc-note">El mapa exacte de particions depèn del proveïdor i de la mida contractada. Ha de quedar a la wiki o runbook del projecte, no només en aquest blog, per a recuperació davant fallades.</div>
</section>

<section class="doc-block">
  <p class="doc-block-title">Paquets base</p>
  <h2 class="doc-block-heading">Programari base</h2>
  <p class="doc-block-intro">Es va instal·lar el mínim raonable per a administració remota segura i Docker, sense pes mort:</p>
  <ul class="doc-list">
    <li>Utilitats habituals: <code>curl</code>, editors, xarxa i diagnòstic.</li>
    <li><strong>Docker Engine</strong> amb logs rotatius a <code>/etc/docker/daemon.json</code>.</li>
    <li><strong>Nginx</strong> des de paquets del sistema com a frontal estable.</li>
    <li><strong>Certbot</strong> i TLS segons fase (HTTP-01 o certificat autofirmat en laboratori).</li>
  </ul>
  <p>Cada peça té un rol observable: <code>systemctl status</code>, <code>nginx -t</code>, <code>docker compose ps</code>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Consola</p>
  <h2 class="doc-block-heading">Ergonòmica del shell</h2>
  <p class="doc-block-intro">Per a sessions SSH consistents es va aplicar la guia <a href="https://wiki.ldeluipy.es/initialConfiguration.html">initialConfiguration</a> del wiki:</p>
  <ul class="doc-list">
    <li>Prompt de Bash llegible (ruta, estat de l'ordre, pistes visuals).</li>
    <li>Historial i opcions segures que redueixen errors repetits.</li>
    <li>Àlies i <code>PATH</code> orientats a Compose i Git sota <code>/opt/...</code>.</li>
  </ul>
  <p>Aquesta base, documentada fora del servidor, permet repetir el mateix motlle en altres VPS sense improvisar.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Eines</p>
  <h2 class="doc-block-heading">cursor-agent</h2>
  <div class="doc-callout">
    <span class="doc-callout-title">Assistència a la línia d'ordres</span>
    <p>Es va instal·lar <strong>cursor-agent</strong> per acostar el treball diari al flux de desenvolupament assistit: revisions, scripts auxiliars i documentació incremental des de la consola.</p>
    <p>No substitueix la revisió humana ni els controls de l'equip, però redueix fricció en tasques repetibles (overlays de Compose, validar Nginx abans de recarregar, etc.).</p>
  </div>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Tancament del dia</p>
  <h2 class="doc-block-heading">Estat en acabar el dia 0</h2>
  <p class="doc-block-intro">En tancar el dia, el servidor compleix tres propietats:</p>
  <ol class="doc-steps">
    <li><strong>És auditable:</strong> layout de disc i paquets coneguts.</li>
    <li><strong>És repetible:</strong> passos principals enllaçats amb wiki i runbooks.</li>
    <li><strong>Està llest</strong> per a Docker sense exposar serveis al públic abans d'hora.</li>
  </ol>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Següent pas</p>
  <h2 class="doc-block-heading">Dia 1</h2>
  <p class="doc-closing">El <strong>dia 1</strong> materialitza OpenCloud, el virtual host del proxy i la web KM0 amb TLS. Mentrestant, explora els <a href="/ca/#servicios">serveis</a> o <a href="/ca/#contacto">escriu-nos</a> si vols col·laborar.</p>
</section>
