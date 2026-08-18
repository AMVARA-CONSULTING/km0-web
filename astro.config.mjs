import { defineConfig } from 'astro/config';
import sitemap from '@astrojs/sitemap';
import tailwindcss from '@tailwindcss/vite';

const site = 'https://km0digital.com';

export default defineConfig({
  site,
  output: 'static',
  // Keep Astro 5 HTML whitespace (inline spaces) after Astro 7 default 'jsx'.
  compressHTML: true,
  build: {
    format: 'directory',
  },
  i18n: {
    defaultLocale: 'es',
    locales: ['es', 'ca', 'en', 'de'],
    routing: {
      prefixDefaultLocale: false,
    },
  },
  vite: {
    plugins: [tailwindcss()],
  },
  integrations: [
    sitemap({
      i18n: {
        defaultLocale: 'es',
        locales: {
          es: 'es',
          ca: 'ca',
          en: 'en',
          de: 'de',
        },
      },
    }),
  ],
});
