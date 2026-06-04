---
title: "Dia 6 - Clients natius, tutorials i una web alineada amb la visió"
description: "KM0 Cloud a tots els dispositius: clients OIDC Dex per a sync mòbil i escriptori, correcció loopback, previews d'enllaç amb marca, tutorials multilingües i home renovada a km0digital.com."
pubDate: 2026-06-03
locale: ca
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducció</p>
  <p class="doc-lead">El dia 6 continua després de la <a href="/ca/doc/day-5/">reunió de visió</a>: el stack ja funcionava al navegador (dies 1–4), però els usuaris reals també necessiten apps natives, onboarding clar i una web pública que expliqui la mateixa història. Aquesta entrada recull aquest treball sense detallar dies concrets del calendari.</p>
  <p class="doc-lead">Dos fronts avancen en paral·lel: <strong>km0digital.com</strong> rep copy orientat al moviment, FAQs de seguretat i guies pas a pas del cloud; <strong>cloud.km0digital.com</strong> corregeix OIDC per a sync a escriptori i mòbil, aplica branding KM0 i enriqueix les previews en compartir enllaços.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Resum</p>
  <h2 class="doc-block-heading">Què ha canviat</h2>
  <ul class="doc-list">
    <li><strong>Web:</strong> seccions Visió i Comunitat a la home; FAQ en acordió; respostes de seguretat (ISO 27001 a AMVARA, allotjament UE); <a href="/ca/tutorials/">tutorials KM0 Cloud</a> web, Android i iOS en quatre idiomes; presentacions CA/ES/EN en PPT i PDF.</li>
    <li><strong>Auth nativa:</strong> clients OIDC estàtics a Dex per a <code>OpenCloudDesktop</code>, <code>OpenCloudAndroid</code> i <code>OpenCloudIOS</code>; nginx envia només el client web a <code>/login.html</code>.</li>
    <li><strong>Loopback escriptori:</strong> Dex actualitzat a <code>v2.42.0</code> per a URIs OAuth <code>http://127.0.0.1:&lt;port&gt;</code> (RFC 8252).</li>
    <li><strong>Marca i sharing:</strong> favicon KM0 a login, Dex i SPA autenticada; targetes Open Graph / Twitter i <code>/brand/og-preview.png</code> per a crawlers socials.</li>
    <li><strong>Horitzó:</strong> login Facebook investigat via OAuth a Dex; documentat i condicionat per env, encara no actiu a producció.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Web corporativa</p>
  <h2 class="doc-block-heading">De la visió a l'onboarding</h2>
  <p class="doc-block-intro">Després del dia 5, la home havia de reflectir la narrativa comunitària, no només el stack tècnic. Noves seccions de <strong>Visió</strong> i <strong>Comunitat</strong>, copy renovat en tots els idiomes i un footer més simple (GitHub + AMVARA) ancora la història en persones i territori.</p>
  <p>El FAQ es va reconstruir com a acordió mesurat (un panell obert a la vegada) i s'amplià amb respostes honestes de seguretat: AMVARA CONSULTING S.L. disposa d'ISO 27001; la certificació de l'àmbit KM0 Cloud està prevista; les dades romanen a la UE; no hi ha entrenament de models de tercers amb fitxers de clients.</p>
  <p>Les guies d'onboarding viuen a <a href="/ca/tutorials/">/ca/tutorials/</a>: primers passos a web, Android i iOS, cadascuna localitzada. El bloc Serveis enllaça directament a la guia web perquè ningú es quedi a mitges després de llegir sobre el cloud.</p>
  <p>Tres presentacions (<em>Origen Local</em> en català, <em>Impacto Digital</em> en castellà, <em>Sovereign Tech</em> en anglès) es van generar a partir del contingut del lloc i del stack per a l'outreach comunitari després de la reunió de Masnou.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Clients natius de sync i OIDC</h2>
  <p class="doc-block-intro">El login web per Dex LDAP (dia 4) funcionava; les apps Android, iOS i escriptori fallaven amb <code>invalid client_id</code>. Dex no tenia clients estàtics per als IDs natius i nginx redirigia <em>tota</em> petició <code>/dex/auth</code> a l'híbrid <code>login.html</code>, que les apps no poden renderitzar.</p>
  <ul class="doc-list">
    <li><strong>Dex:</strong> registrar <code>opencloud-web</code>, <code>OpenCloudDesktop</code>, <code>OpenCloudAndroid</code> i <code>OpenCloudIOS</code> amb les URIs de redirect que exigeix cada plataforma.</li>
    <li><strong>nginx:</strong> redirigir a <code>/login.html</code> només quan <code>client_id=opencloud-web</code>; clients mòbil i escriptori mantenen l'endpoint d'autorització Dex.</li>
  </ul>
  <p>Les comprovacions automàtiques al servidor passen (WebFinger, codis de l'endpoint d'auth). La sync real en dispositiu físic queda com a verificació d'operador.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Per què l'escriptori necessitava Dex v2.42.0</h2>
  <p class="doc-block-intro">Fins i tot amb el client registrat, l'app d'escriptori seguia fallant: usa OAuth loopback (<code>http://127.0.0.1:&lt;port-aleatori&gt;</code> a cada login). Dex <code>v2.41.1</code> exigia coincidència exacta de redirect URI; una entrada fixa <code>http://127.0.0.1</code> no cobreix un port nou cada vegada.</p>
  <p>Actualització a <code>ghcr.io/dexidp/dex:v2.42.0</code> i <code>OpenCloudDesktop</code> amb <code>redirectURIs</code> buit perquè Dex accepti qualsevol port loopback a <code>127.0.0.1</code> o <code>localhost</code>. Web i mòbil ja usaven URIs HTTPS fixes o esquemes custom i no necessitaven aquest canvi.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Favicon KM0 i previews d'enllaç</h2>
  <p class="doc-block-intro">Els enllaços compartits del cloud mostraven metadades genèriques d'OpenCloud. nginx injecta tags Open Graph i Twitter per a crawlers; Dex i <code>login.html</code> comparteixen títol KM0 i imatge de preview (<code>/brand/og-preview.png</code>).</p>
  <p>El favicon pin gradient KM0 substitueix la icona OpenCloud per defecte a login, pantalles LDAP de Dex i la ruta de tema de la SPA autenticada, perquè pestanyes i marcadors coincideixin amb <a href="https://km0digital.com/">km0digital.com</a>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Horitzó</p>
  <h2 class="doc-block-heading">Login Facebook (només investigació)</h2>
  <p class="doc-block-intro">El login Meta s'acotà per a Dex com a connector OAuth upstream (Dex segueix sent l'únic emissor OIDC d'OpenCloud). La investigació està completa: config d'exemple, hook a l'entrypoint condicionat per env i runbook sobre App Review i claims d'email.</p>
  <p>L'activació a producció espera la revisió de Meta i una decisió de producte sobre comptes sense email verificat. Google, Apple i LDAP local no es veuen afectats.</p>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Següent pas</p>
  <h2 class="doc-block-heading">Dia 7</h2>
  <p class="doc-closing">El dia 6 tanca el cercle entre visió i ús diari: apps de sync, tutorials i una web que explica ambdós. Una <strong>entrada especial del dia 7</strong> arribarà a part. Mentrestant, prova les <a href="/ca/tutorials/">guies del cloud</a> o entra a <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a>.</p>
</section>
