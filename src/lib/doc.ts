import type { CollectionEntry } from 'astro:content';

/** URL slug from collection id (e.g. es/dia-0 -> dia-0) */
export function docSlug(entry: CollectionEntry<'doc'>): string {
  const parts = entry.id.split('/');
  const last = parts[parts.length - 1] ?? entry.id;
  return last.replace(/\.md$/i, '');
}

const DATE_LOCALE: Record<'es' | 'ca' | 'en' | 'de', string> = {
  es: 'es-ES',
  ca: 'ca-ES',
  en: 'en-GB',
  de: 'de-DE',
};

export function formatDocDate(date: Date, locale: 'es' | 'ca' | 'en' | 'de'): string {
  return new Intl.DateTimeFormat(DATE_LOCALE[locale], { dateStyle: 'long' }).format(date);
}
