# Changelog

## [Unreleased]

## [1.3.1] - 2026-08-21

### Changed

- Open Graph / WhatsApp share card: regenerated `og-preview.png` with readable brand + UE offer, hardened social meta (`secure_url`, type, Facebook-form locales, versioned cache-bust, localized `og:image:alt`).

## [1.3.0] - 2026-08-18

### Changed

- Astro `5.18.2` → `7.2.3` and Tailwind `3.4.19` → `4.3.3`: removed `@astrojs/tailwind`, added `@tailwindcss/vite`, moved theme tokens into `@theme` in `src/styles/global.css`, deleted `tailwind.config.mjs`. Content collections migrated to Content Layer (`glob` loaders + `render()`). `compressHTML: true` keeps Astro 5 whitespace. npm install used `--ignore-scripts` with Shai-Hulud artifact scan (no hits); registry integrity matched for direct deps.
