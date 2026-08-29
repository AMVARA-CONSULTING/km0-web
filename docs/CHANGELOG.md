# Changelog

## [Unreleased]

## [1.3.5] - 2026-08-29

### Changed

- Hosting copy in es/ca/en/de: Falkenstein-specific lines now say EU (Hetzner); operator trust row and footer powered-by link to the on-site legal page; community intro names El Masnou.

## [1.3.4] - 2026-08-28

### Added

- Blog days 21-23 in es/ca/en/de: meetup on autonomous driving and data, SME target-customer focus, and first company client (econsultants on OpenCloud KM0).

## [1.3.3] - 2026-08-24

### Changed

- KM0 Mail copy in es/ca/en/de: removed "free/gratuita" wording; tutorials, day-20 blog, and i18n pricing/services now reflect the **7,99 €/month** base plan (mail + cloud, extra storage as paid add-on).

## [1.3.2] - 2026-08-24

### Added

- KM0 Cloud web tutorials in es/ca/en/de: sharing files and folders (`sharing-files`) and Space permissions (`space-permissions`), with cross-links and OpenCloud 4.x-aligned steps.

## [1.3.1] - 2026-08-21

### Changed

- Open Graph / WhatsApp share card: regenerated `og-preview.png` with readable brand + UE offer, hardened social meta (`secure_url`, type, Facebook-form locales, versioned cache-bust, localized `og:image:alt`).

## [1.3.0] - 2026-08-18

### Changed

- Astro `5.18.2` → `7.2.3` and Tailwind `3.4.19` → `4.3.3`: removed `@astrojs/tailwind`, added `@tailwindcss/vite`, moved theme tokens into `@theme` in `src/styles/global.css`, deleted `tailwind.config.mjs`. Content collections migrated to Content Layer (`glob` loaders + `render()`). `compressHTML: true` keeps Astro 5 whitespace. npm install used `--ignore-scripts` with Shai-Hulud artifact scan (no hits); registry integrity matched for direct deps.
