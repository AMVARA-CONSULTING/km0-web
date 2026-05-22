import type { CollectionEntry } from 'astro:content';

/** URL slug from collection id (e.g. es/dia-0 -> dia-0) */
export function docSlug(entry: CollectionEntry<'doc'>): string {
  const parts = entry.id.split('/');
  const last = parts[parts.length - 1] ?? entry.id;
  return last.replace(/\.md$/i, '');
}

export function formatDocDate(date: Date, locale: 'es' | 'ca' | 'en'): string {
  const tag = locale === 'ca' ? 'ca-ES' : locale === 'en' ? 'en-GB' : 'es-ES';
  return new Intl.DateTimeFormat(tag, { dateStyle: 'long' }).format(date);
}
