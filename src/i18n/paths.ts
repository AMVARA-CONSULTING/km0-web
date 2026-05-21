import type { Locale } from './types';

/** Path prefix without trailing slash, empty for default locale Spanish */
export function localePath(locale: Locale): '' | '/ca' | '/en' {
  if (locale === 'es') return '';
  return locale === 'ca' ? '/ca' : '/en';
}

/** Link to anchor on current locale page */
export function withHash(locale: Locale, fragment: string): string {
  const base = localePath(locale);
  if (base === '') return `/#${fragment}`;
  return `${base}/#${fragment}`;
}
