---
title: "Photo backup on Android and iOS"
description: "Automatic phone photo backup to KM0 Cloud, original vs conversion options, and how to restore if the handset dies."
locale: en
order: 8
platform: mobile
---

<section class="doc-lead-block">
  <p class="doc-block-title">Introduction</p>
  <p class="doc-lead">The OpenCloud apps for <strong>Android</strong> and <strong>iOS</strong> can upload new photos and videos to your KM0 Cloud account. Files live on EU servers at <code>cloud.km0digital.com</code>. The public plan is <strong>150 GB</strong>: say that up front if the goal is a lifetime photo library.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Before you start</p>
  <h2 class="doc-block-heading">Sign in on the phone</h2>
  <ol class="doc-list">
    <li>Install OpenCloud from the store (see <a href="/en/tutorials/getting-started-android/">Android</a> or <a href="/en/tutorials/getting-started-ios/">iOS</a>).</li>
    <li>Server URL: <code>https://cloud.km0digital.com/</code>.</li>
    <li>Grant photo library permission when the app asks.</li>
    <li>Pick a destination folder in KM0 Cloud before you expect automatic uploads.</li>
  </ol>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Android</p>
  <h2 class="doc-block-heading">Automatic picture and video uploads</h2>
  <ol class="doc-list">
    <li>Open OpenCloud → <strong>Settings</strong>.</li>
    <li>Configure <strong>Automatic picture uploads</strong> and <strong>Automatic video uploads</strong> (destination folder and behaviour).</li>
    <li>Leave the phone on Wi-Fi for large batches when you can. Background timing is controlled by Android, so uploads may wait a few minutes.</li>
  </ol>
  <p class="doc-block-intro">Vendor overview: <a href="https://docs.opencloud.eu/docs/user/android-app/general/settings/" target="_blank" rel="noopener noreferrer">Android settings</a>.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">iOS</p>
  <h2 class="doc-block-heading">Auto Upload photos and videos</h2>
  <ol class="doc-list">
    <li>Open OpenCloud → <strong>Settings</strong> → <strong>Media Upload</strong>.</li>
    <li>Set <strong>Photo upload path</strong> to a folder in your account.</li>
    <li>Enable <strong>Auto Upload Photos</strong> and/or <strong>Auto Upload Videos</strong>.</li>
  </ol>
  <p class="doc-block-intro">Current iOS behaviour (OpenCloud docs): Auto Upload runs when the app is open in the foreground. If the app is closed, new media waits until you open it again. Opening the app starts detection of media created since the last successful upload.</p>
  <p class="doc-block-intro">Vendor docs: <a href="https://docs.opencloud.eu/docs/user/ios-app/general/settings/auto-upload-photos-and-videos/" target="_blank" rel="noopener noreferrer">Auto Upload Photos and Videos</a>.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Quality</p>
  <h2 class="doc-block-heading">Originals vs optional conversion</h2>
  <p class="doc-block-intro">On iOS, conversion is an explicit setting, not a hidden default:</p>
  <ul class="doc-list">
    <li><strong>Convert HEIC to JPEG</strong> and <strong>Convert videos to MP4</strong> only apply when you turn them on.</li>
    <li>Leave both off if you want the phone’s original formats uploaded as captured.</li>
    <li><strong>Preserve original media file names</strong> keeps the camera filename when enabled.</li>
  </ul>
  <p class="doc-block-intro">We do not apply a separate KM0 recompress layer on top of the OpenCloud app. What you configure in the app is what goes to your 150 GB quota.</p>
</section>

<section class="doc-block">
  <p class="doc-block-title">Restore</p>
  <h2 class="doc-block-heading">If the phone dies or is lost</h2>
  <ol class="doc-list">
    <li>On another phone or computer, open <a href="https://cloud.km0digital.com/">cloud.km0digital.com</a> or the OpenCloud app.</li>
    <li>Sign in to the same account.</li>
    <li>Open the upload folder and download the photos you need, or enable Auto Upload on the new phone pointing at the same (or a new) folder.</li>
  </ol>
  <p class="doc-block-intro">Removing the app or signing out does not wipe files already stored in KM0 Cloud. Optional “delete unused local copies” only clears downloaded caches on the device; server files stay.</p>
</section>

<section class="doc-block doc-block-alt">
  <p class="doc-block-title">Storage</p>
  <h2 class="doc-block-heading">Will 150 GB be enough?</h2>
  <p class="doc-block-intro">Many cameras produce large originals. Count roughly: thousands of modern photos can fill 150 GB. Check Settings → storage on the phone, or upload a sample month and extrapolate. Need more? Contact us before you rely on a partial backup. Related: <a href="/en/tutorials/desktop-sync/">desktop sync</a>, <a href="/en/guides/protect-family-photos/">protect family photos</a>.</p>
</section>
