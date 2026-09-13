---
title: "How desktop sync works on KM0 Cloud"
description: "Selective sync, Windows online files, what happens when you unsync or unlink, and why there is no Known Folder Move."
locale: en
order: 7
platform: desktop
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introduction</p>
  <p class="doc-lead">KM0 Cloud uses the <strong>OpenCloud Desktop Client</strong> on Windows, macOS, and Linux. Sync keeps a local folder in step with your EU account. The public plan is <strong>150 GB</strong>. If your library is larger, ask for capacity before you start a big migration.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Before you start</p>
  <h2 class="doc-block-heading">Install the desktop client</h2>
  <ol class="doc-list">
    <li>Download the official OpenCloud Desktop Client for your OS from <a href="https://github.com/opencloud-eu/desktop/releases" target="_blank" rel="noopener noreferrer">OpenCloud Desktop releases</a>.</li>
    <li>Install it, open the client, and enter the server URL: <code>https://cloud.km0digital.com/</code>.</li>
    <li>Sign in with the same method you use in the browser.</li>
  </ol>
  <p class="doc-block-intro">Vendor docs: <a href="https://docs.opencloud.eu/docs/user/desktop-client/" target="_blank" rel="noopener noreferrer">OpenCloud Desktop Client</a>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Selective sync</p>
  <h2 class="doc-block-heading">Choose what to sync (macOS and Linux)</h2>
  <ol class="doc-list">
    <li>Open the Desktop Client and go to the account view.</li>
    <li>Open the three-dot menu (<strong>…</strong>) next to the Space you care about.</li>
    <li>Choose <strong>Choose What to Sync</strong> and tick only the folders you need on this computer.</li>
  </ol>
  <p class="doc-block-intro">Folders you leave unchecked are not kept as local sync copies. That saves disk space. They remain on the server and in the web UI.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Windows</p>
  <h2 class="doc-block-heading">Online files (Virtual File System)</h2>
  <p class="doc-block-intro">On Windows the client uses placeholders in File Explorer so cloud files can appear without a full download.</p>
  <ul class="doc-list">
    <li><strong>Always keep on this device</strong>: full local copy, offline-ready.</li>
    <li><strong>Available when online</strong>: placeholder; downloads when you open the file.</li>
    <li><strong>Free up space</strong>: removes the local content and keeps the cloud file visible as online-only.</li>
  </ul>
  <p class="doc-block-intro">Vendor docs: <a href="https://docs.opencloud.eu/docs/user/desktop-client/windows/sync-settings-win/" target="_blank" rel="noopener noreferrer">Windows synchronisation settings</a>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Limits</p>
  <h2 class="doc-block-heading">No Known Folder Move</h2>
  <p class="doc-block-intro">OpenCloud Desktop does <strong>not</strong> redirect Windows <strong>Desktop</strong>, <strong>Documents</strong>, or <strong>Pictures</strong> the way Microsoft OneDrive Known Folder Move does. Files sync inside the OpenCloud sync folder (and Spaces you connect). Keep working from that folder, or copy into it deliberately.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Unsync and unlink</p>
  <h2 class="doc-block-heading">What happens to local files</h2>
  <ul class="doc-list">
    <li><strong>Remove Sync Folder Connection</strong> (macOS/Linux account menu): stops sync for that Space. Official OpenCloud docs state this does <strong>not</strong> delete the local files. The Space stays on the server.</li>
    <li><strong>Choose What to Sync</strong>: turning a folder off means it is no longer maintained as a local sync copy. Prefer <strong>Remove Sync Folder Connection</strong> when you want to disconnect without treating the action as a cleanup of the sync tree.</li>
    <li><strong>Two-way sync</strong>: if sync is active and you delete a file inside the sync folder, the client can remove it on the server too. Sync is not a one-way backup.</li>
    <li><strong>Windows Free up space</strong>: clears local content for that item; the file remains in KM0 Cloud.</li>
  </ul>
  <p class="doc-block-intro">Policy in plain words: unlinking or removing the sync connection is not a wipe of your local copies. Deleting files yourself while sync is running is different. Details: <a href="/en/tutorials/photo-backup/">photo backup and restore</a>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Storage</p>
  <h2 class="doc-block-heading">150 GB public plan</h2>
  <p class="doc-block-intro">The published plan is <strong>150 GB for €1.99/month</strong>. A multi-year phone library can exceed that. Check size before you promise yourself a full dump. Larger quotas are handled on request (see <a href="/en/pricing/">pricing</a> and contact).</p>
</section>
