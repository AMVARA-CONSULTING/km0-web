import type { CollectionEntry } from 'astro:content';

/** URL slug from collection id (e.g. es/liberar-espacio-movil -> liberar-espacio-movil) */
export function guideSlug(entry: CollectionEntry<'guides'>): string {
  const parts = entry.id.split('/');
  const last = parts[parts.length - 1] ?? entry.id;
  return last.replace(/\.md$/i, '');
}

/** Ascending by order field */
export function compareGuides(
  a: CollectionEntry<'guides'>,
  b: CollectionEntry<'guides'>,
): number {
  return a.data.order - b.data.order;
}
