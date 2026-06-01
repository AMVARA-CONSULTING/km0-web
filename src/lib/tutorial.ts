import type { CollectionEntry } from 'astro:content';

/** URL slug from collection id (e.g. es/getting-started-web -> getting-started-web) */
export function tutorialSlug(entry: CollectionEntry<'tutorials'>): string {
  const parts = entry.id.split('/');
  const last = parts[parts.length - 1] ?? entry.id;
  return last.replace(/\.md$/i, '');
}

/** Ascending by order field */
export function compareTutorials(
  a: CollectionEntry<'tutorials'>,
  b: CollectionEntry<'tutorials'>,
): number {
  return a.data.order - b.data.order;
}
