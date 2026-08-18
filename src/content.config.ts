import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const doc = defineCollection({
  loader: glob({ pattern: '**/[^_]*.md', base: './src/content/doc' }),
  schema: z.object({
    title: z.string(),
    description: z.string(),
    pubDate: z.coerce.date(),
    locale: z.enum(['es', 'ca', 'en', 'de']),
  }),
});

const tutorials = defineCollection({
  loader: glob({ pattern: '**/[^_]*.md', base: './src/content/tutorials' }),
  schema: z.object({
    title: z.string(),
    description: z.string(),
    locale: z.enum(['es', 'ca', 'en', 'de']),
    order: z.number(),
    platform: z.enum(['web', 'android', 'ios', 'macos']),
    /** Product family used to group the tutorials index. */
    product: z.enum(['cloud', 'mail']).default('cloud'),
  }),
});

/** Practical acquisition guides (non-technical); distinct from product /tutorials. */
const guides = defineCollection({
  loader: glob({ pattern: '**/[^_]*.md', base: './src/content/guides' }),
  schema: z.object({
    title: z.string(),
    description: z.string(),
    locale: z.enum(['es', 'ca', 'en', 'de']),
    order: z.number(),
    /** Short line for home teaser and index list */
    teaser: z.string(),
    primaryCtaLabel: z.string(),
    primaryCta: z.enum(['cloud', 'pricing', 'contact']),
    secondaryCtaLabel: z.string(),
    cloudHeading: z.string(),
    cloudBody: z.string(),
  }),
});

export const collections = { doc, tutorials, guides };
