import type { Locale } from './types';

const LOCALE_PREFIX: Record<Locale, '' | '/ca' | '/en' | '/de'> = {
  es: '',
  ca: '/ca',
  en: '/en',
  de: '/de',
};

/** Path prefix without trailing slash; empty when `es` is the default locale (unprefixed URLs) */
export function localePath(locale: Locale): '' | '/ca' | '/en' | '/de' {
  return LOCALE_PREFIX[locale];
}

/** Link to anchor on current locale page */
export function withHash(locale: Locale, fragment: string): string {
  const base = localePath(locale);
  if (base === '') return `/#${fragment}`;
  return `${base}/#${fragment}`;
}

/** Locale-prefixed path (e.g. /doc/, /ca/doc/) */
export function localeHref(locale: Locale, path: string): string {
  const base = localePath(locale);
  const normalized = path.startsWith('/') ? path : `/${path}`;
  if (base === '') return normalized.endsWith('/') ? normalized : `${normalized}/`;
  const joined = `${base}${normalized}`;
  return joined.endsWith('/') ? joined : `${joined}/`;
}

/** Doc post URL from slug (e.g. day-0) */
export function docPostHref(locale: Locale, slug: string): string {
  return `${localeHref(locale, '/doc')}${slug}/`;
}

/** Tutorial post URL from slug (e.g. getting-started-web) */
export function tutorialPostHref(locale: Locale, slug: string): string {
  return `${localeHref(locale, '/tutorials')}${slug}/`;
}

/** Strip locale prefix from a pathname, leaving the locale-neutral path (e.g. /ca/doc/foo/ → /doc/foo/) */
export function stripLocalePrefix(pathname: string, locale: Locale): string {
  const prefix = localePath(locale);
  if (!prefix) return pathname || '/';
  if (pathname === prefix || pathname === `${prefix}/`) return '/';
  if (pathname.startsWith(`${prefix}/`)) return pathname.slice(prefix.length) || '/';
  return pathname;
}

/** Same page in another locale (preserves /doc/ paths and slugs) */
export function switchLocaleHref(
  pathname: string,
  fromLocale: Locale,
  toLocale: Locale,
): string {
  const logicalPath = stripLocalePrefix(pathname, fromLocale);
  return localeHref(toLocale, logicalPath);
}
