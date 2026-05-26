import type { CollectionEntry } from 'astro:content';

/** URL slug from collection id (e.g. es/day-0 -> day-0) */
export function docSlug(entry: CollectionEntry<'doc'>): string {
  const parts = entry.id.split('/');
  const last = parts[parts.length - 1] ?? entry.id;
  return last.replace(/\.md$/i, '');
}

/** Day index from slug (e.g. day-2 -> 2); 0 when pattern does not match */
export function docDayNumber(entry: CollectionEntry<'doc'>): number {
  const match = docSlug(entry).match(/^day-(\d+)$/);
  return match ? Number(match[1]) : 0;
}

/** Newest first: pubDate desc, then day number desc for same-day entries */
export function compareDocPosts(
  a: CollectionEntry<'doc'>,
  b: CollectionEntry<'doc'>,
): number {
  const dateDiff = b.data.pubDate.valueOf() - a.data.pubDate.valueOf();
  if (dateDiff !== 0) return dateDiff;
  return docDayNumber(b) - docDayNumber(a);
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
