import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';
import sitemap from '@astrojs/sitemap';

export default defineConfig({
  site: 'https://km0.amvara.de',
  output: 'static',
  build: {
    format: 'directory',
  },
  integrations: [tailwind(), sitemap()],
});
