/// <reference path="../.astro/types.d.ts" />

interface ImportMetaEnv {
  readonly CLOUD_ADMIN_USER?: string;
  readonly CLOUD_APP_TOKEN?: string;
}

interface ImportMeta {
  readonly env: ImportMetaEnv;
}
