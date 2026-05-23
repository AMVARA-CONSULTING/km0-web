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

export const collections = { doc };
