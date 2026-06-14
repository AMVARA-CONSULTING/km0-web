---
title: "Dia 9 - Preus públics, confiança i registre obert"
description: "Pàgina de preus amb comparativa de mercat, legal i seguretat en quatre idiomes, registre públic a cloud.km0digital.com, avís per email a l'equip quan arriba una idea i poliment de conversió a la landing i el blog."
pubDate: 2026-06-10
locale: ca
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introducció</p>
  <p class="doc-lead">El <a href="/ca/doc/day-8/">dia 8</a> va fixar estratègia i xifres; el dia 9 les converteix en producte publicable. Entre el 9 i el 10 de juny de 2026 vam desplegar la pàgina de <a href="/ca/pricing/">preus</a>, les seccions de <a href="/ca/legal/">legal</a> i <a href="/ca/security/">seguretat</a>, l'auto-registre a <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a> i millores de conversió a la home i el blog.</p>
  <p class="doc-lead">KM0 deixa de ser només «alguna cosa que funciona si t'ho expliquem» i passa a ser un servei que qualsevol pot descobrir, comparar, registrar i usar sense intermediari.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Resum</p>
  <h2 class="doc-block-heading">Fites del dia</h2>
  <ul class="doc-list">
    <li><strong>Preus:</strong> <a href="/ca/pricing/">/pricing/</a> amb hero 500 GB / 1,99 €, taula comparativa indicativa, explicació del model i CTA al cloud (#24, #25).</li>
    <li><strong>Confiança:</strong> pàgines <a href="/ca/legal/">legal</a> (avís, privacitat RGPD, cookies) i <a href="/ca/security/">seguretat</a> (ISO 27001 AMVARA, divulgació responsable) en quatre idiomes (#21).</li>
    <li><strong>Registre:</strong> auto-registre email/contrasenya via <code>register-api</code> a OpenCloud; login Dex amb <code>dex-auth.js</code> i auto sign-in després del registre.</li>
    <li><strong>Conversió:</strong> landing amb KM0 Cloud més visible (#26); tipografia del blog i tutorials refinada (#27); CTAs de serveis polits.</li>
    <li><strong>Idees:</strong> email immediat a l'equip de desenvolupament quan algú envia una idea a <a href="/ca/ideas/">/ideas/</a> (<code>f41329c</code>).</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Preus</p>
  <h2 class="doc-block-heading">Pàgina pública i comparativa</h2>
  <p class="doc-block-intro">L'oferta acordada al dia 8 arriba a la web amb copy localitzat (ES, CA, EN, DE) i disseny coherent amb la marca.</p>
  <ul class="doc-list">
    <li><strong>Hero:</strong> bloc de preu amb gradient - <strong>1,99 €/mes · 500 GB</strong> - i botó «Comença ara» a <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a>.</li>
    <li><strong>Comparativa:</strong> referències indicatives (Google Drive, OneDrive, iCloud, Dropbox, MEGA) amb preu mensual, emmagatzematge i cost aproximat per TB.</li>
    <li><strong>Claim:</strong> fins a cinc vegades més espai que plans bàsics de referència a preu similar; text de confiança operativa sota la taula.</li>
    <li><strong>Transparència:</strong> secció «Per què el nostre preu és diferent?» - infraestructura optimitzada, eficiència operativa, marge suficient per sostenir el servei.</li>
  </ul>
  <p>Commits principals: <code>7a7e9da</code> (comparativa, 9 jun), <code>9d7906c</code> (rework missatges i confiança, #25), <code>82a3ef0</code> / <code>65a32d2</code> (hero i CTA, 10 jun).</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Confiança</p>
  <h2 class="doc-block-heading">Legal i seguretat multilingües</h2>
  <p class="doc-block-intro">Abans de demanar registre i pagament, la web ha de respondre «qui opera això?» i «què passa amb les meves dades?». Les noves pàgines centralitzen la informació legal de km0digital.com i cloud.km0digital.com.</p>
  <ul class="doc-list">
    <li><strong>Legal</strong> (<code>cd5579e</code>, #21): avís legal AMVARA CONSULTING S.L., política de privacitat RGPD, cookies i secció específica de KM0 Cloud.</li>
    <li><strong>Seguretat:</strong> pràctiques operatives (TLS, capçaleres, UE/Hetzner), abast ISO/IEC 27001:2022 d'AMVARA i política de divulgació responsable.</li>
    <li><strong>FAQ:</strong> respostes existents enllacen ara a <a href="/ca/security/#iso27001">/security/</a> i <a href="/ca/legal/">/legal/</a> als quatre locales.</li>
  </ul>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">OpenCloud</p>
  <h2 class="doc-block-heading">Registre públic (km0-opencloud)</h2>
  <div class="doc-note"><pre>Usuari → /register (register.html)
        ↓
  POST /api/register → register-api (:8091, rate limit nginx)
        ↓
  Graph API (app token) crea usuari LDAP
        ↓
  dex-auth.js + auto sign-in → sessió Dex → OpenCloud</pre></div>
  <ul class="doc-list">
    <li><strong>Auto-registre</strong> (<code>67fe250</code>, 10 jun): <code>register.html</code>, API en loopback, proxy nginx <code>/api/register</code>, i18n ES/CA/EN/DE.</li>
    <li><strong>Graph auth</strong> (<code>7d52675</code>): correcció d'auth amb <code>GRAPH_SERVICE_APP_TOKEN</code> (Basic auth d'app, no contrasenya d'usuari); health <code>graph_auth_ok</code>.</li>
    <li><strong>dex-auth.js</strong> (<code>efefcd3</code>): mòdul compartit OIDC/PKCE per login, registre i contrasenya Dex; auto sign-in post-registre via session storage.</li>
    <li><strong>Operació:</strong> scripts <code>setup-register-api-graph-token.sh</code> i <code>verify-register-api.sh</code>; URL canònica <code>/register</code> (301 des de <code>/register.html</code>).</li>
  </ul>
</section>

<section class="doc-block">
  <p class="doc-block-title">Web corporativa</p>
  <h2 class="doc-block-heading">Conversió i lectura (km0-web, 10 jun)</h2>
  <ul class="doc-list">
    <li><strong>Landing</strong> (<code>5f021e4</code>, #26): KM0 Cloud més visible, accessibilitat i CTAs de conversió refinats.</li>
    <li><strong>Serveis</strong> (<code>471e407</code>): targeta KM0 Cloud amb CTAs clars cap a registre i tutorials.</li>
    <li><strong>Blog</strong> (<code>2425cc1</code>, <code>4487bef</code>, #27): tipografia d'articles, llistes tipus definició, TOC mòbil i llegibilitat general.</li>
    <li><strong>Estils</strong> (<code>e5223f4</code>): import de CSS global al layout; selectors <code>.doc-body</code> corregits.</li>
  </ul>
  <p>Versió del lloc al tancament: <strong>1.1.70</strong>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Idees</p>
  <h2 class="doc-block-heading">Avís per email a l'equip (darrera hora)</h2>
  <p class="doc-block-intro">El bucle del <a href="/ca/doc/day-7/">dia 7</a> ja encuava idees i generava tickets a GitHub, però l'equip només s'assabentava en revisar la cua o el repositori. Amb la campanya de màrqueting del dia 8, calia reaccionar abans.</p>
  <div class="doc-note"><pre>POST /hooks/ideas → receive-idea.sh
        ↓
  JSON a /var/spool/km0-ideas/incoming/
        ↓
  notify-idea-email.sh (background, fire-and-forget)
        ↓
  AutoMail API → email a l'equip (assumpte + primers 100 caràcters)
        ↓
  (sense canvis) autoissue → gh issue create</pre></div>
  <ul class="doc-list">
    <li><strong>Script:</strong> <code>scripts/notify-idea-email.sh</code> - crida AutoMail (<code>AUTOMAIL_TOKEN</code> a <code>.env</code> del repo); no usa <code>cursor-agent</code>.</li>
    <li><strong>Disparador:</strong> <code>receive-idea.sh</code> el llança en segon pla just després d'escriure el JSON a la cua.</li>
    <li><strong>Contingut:</strong> assumpte «Nueva idea km0digital» i vista prèvia del missatge (100 caràcters); destí configurable amb <code>AUTOMAIL_NOTIFY_TO</code>.</li>
    <li><strong>Receiver:</strong> el sidecar Docker del webhook passa a systemd al host (<code>km0-ideas-receiver.service</code>); secrets des de <code>.env</code> del repositori.</li>
  </ul>
  <p>El ticket automatitzat i l'etiqueta <code>waiting for human validation</code> continuen igual; l'email és només un avís primerenc perquè algú de l'equip llegeixi la idea tan aviat com arribi.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Verificació</p>
  <h2 class="doc-block-heading">Comprovar el dia 9</h2>
  <ol class="doc-steps">
    <li><strong>Preus:</strong> visitar <a href="/ca/pricing/">/pricing/</a> i comprovar hero, taula i CTA a cada idioma.</li>
    <li><strong>Legal:</strong> revisar <a href="/ca/legal/">/legal/</a> i <a href="/ca/security/">/security/</a>; enllaços des de FAQ i peu.</li>
    <li><strong>Registre:</strong> crear compte de prova a <a href="https://cloud.km0digital.com/register">cloud.km0digital.com/register</a>; verificar auto sign-in.</li>
    <li><strong>Idees:</strong> enviar prova a <a href="/ca/ideas/">/ideas/</a>; comprovar JSON al spool i email a l'equip via AutoMail.</li>
    <li><strong>Fum:</strong> bucle autoagents - issues #21, #24, #25, #26, #27 tancades; register-api health OK.</li>
  </ol>
</section>

<section class="doc-closing-block">
  <p class="doc-block-title">Següent pas</p>
  <h2 class="doc-block-heading">Dia 11</h2>
  <p class="doc-closing">No vam publicar entrada del dia 10 (desplegament intern de correu). El <a href="/ca/doc/day-11/">dia 11</a> documenta <strong>KM0 Mail</strong> en producció: <a href="https://mail.km0digital.com/">mail.km0digital.com</a>, DNS, lliurabilitat i integració parcial amb OpenCloud. Mentrestant, prova <a href="https://cloud.km0digital.com/">KM0 Cloud</a> o consulta <a href="/ca/pricing/">preus</a>.</p>
</section>
