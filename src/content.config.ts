import { defineCollection, z } from 'astro:content';

const doc = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    pubDate: z.coerce.date(),
    locale: z.enum(['es', 'ca', 'en', 'de']),
  }),
});

const tutorials = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    locale: z.enum(['es', 'ca', 'en', 'de']),
    order: z.number(),
    platform: z.enum(['web', 'android', 'ios', 'macos']),
  }),
});

/** Practical acquisition guides (non-technical); distinct from product /tutorials. */
const guides = defineCollection({
  type: 'content',
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
