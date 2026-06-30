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

export const collections = { doc, tutorials };
