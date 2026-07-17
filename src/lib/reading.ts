import type { Locale } from '../i18n/types';

export interface TocEntry {
  id: string;
  text: string;
  level: 2 | 3;
}

export function slugifyHeading(text: string): string {
  return text
    .trim()
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-|-$/g, '');
}

/**
 * Build a TOC from legacy HTML doc kits and/or Markdown ATX headings.
 * Prefer HTML kit titles when present so older day-* posts stay wired.
 */
export function extractDocToc(body: string): TocEntry[] {
  const entries: TocEntry[] = [];
  const usedIds = new Set<string>();

  const addEntry = (text: string, level: 2 | 3) => {
    const trimmed = text.trim();
    if (!trimmed) return;
    let id = slugifyHeading(trimmed);
    let suffix = 2;
    while (usedIds.has(id)) {
      id = `${slugifyHeading(trimmed)}-${suffix++}`;
    }
    usedIds.add(id);
    entries.push({ id, text: trimmed, level });
  };

  const titleRe = /<p class="doc-block-title">([^<]+)<\/p>/g;
  let match: RegExpExecArray | null;
  while ((match = titleRe.exec(body)) !== null) {
    addEntry(match[1], 2);
  }

  const headingRe = /<h2 class="doc-block-heading">([^<]+)<\/h2>/g;
  while ((match = headingRe.exec(body)) !== null) {
    addEntry(match[1], 3);
  }

  if (entries.length > 0) return entries;

  const mdRe = /^(#{2,3})\s+(.+?)\s*$/gm;
  while ((match = mdRe.exec(body)) !== null) {
    const level = match[1].length === 2 ? 2 : 3;
    addEntry(match[2].replace(/\s+#+\s*$/, ''), level);
  }

  return entries;
}

/** Map Astro MarkdownHeading[] into TOC entries (depth 2–3 only). */
export function tocFromMarkdownHeadings(
  headings: ReadonlyArray<{ depth: number; slug: string; text: string }>,
): TocEntry[] {
  return headings
    .filter((h) => h.depth === 2 || h.depth === 3)
    .map((h) => ({
      id: h.slug,
      text: h.text,
      level: h.depth as 2 | 3,
    }));
}

export function estimateReadingMinutes(body: string, locale: Locale): number {
  const text = body
    .replace(/<[^>]+>/g, ' ')
    .replace(/\s+/g, ' ')
    .trim();
  const words = text.split(/\s+/).filter(Boolean).length;
  const wpm = locale === 'de' ? 180 : 200;
  return Math.max(1, Math.ceil(words / wpm));
}

export function formatReadingTime(template: string, minutes: number): string {
  return template.replace('{minutes}', String(minutes));
}
