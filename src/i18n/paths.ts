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
