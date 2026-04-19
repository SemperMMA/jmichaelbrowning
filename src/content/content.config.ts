import { defineCollection, z } from 'astro:content';

const work = defineCollection({
  type: 'content',
  schema: ({ image }) => z.object({
    title: z.string(),
    summary: z.string(),
    category: z.string(),
    role: z.string(),
    stack: z.array(z.string()).default([]),
    year: z.string(),
    duration: z.string().optional(),
    cover: image().optional(),
    coverAlt: z.string().default(''),
    outcomes: z.array(z.object({
      stat: z.string(),
      label: z.string()
    })).default([]),
    relatedLinks: z.array(z.object({
      label: z.string(),
      href: z.string().url()
    })).default([]),
    featured: z.boolean().default(false),
    order: z.number().default(99),
    draft: z.boolean().default(false)
  })
});

const writing = defineCollection({
  type: 'content',
  schema: ({ image }) => z.object({
    title: z.string(),
    summary: z.string(),
    category: z.enum(['Essay', 'Field note', 'Notes']).default('Essay'),
    tags: z.array(z.string()).default([]),
    publishedAt: z.coerce.date(),
    updatedAt: z.coerce.date().optional(),
    readingTime: z.number().optional(),
    cover: image().optional(),
    coverAlt: z.string().default(''),
    featured: z.boolean().default(false),
    draft: z.boolean().default(false)
  })
});

const notes = defineCollection({
  type: 'content',
  schema: z.object({
    number: z.number(),
    title: z.string(),
    publishedAt: z.coerce.date(),
    draft: z.boolean().default(false)
  })
});

const speaking = defineCollection({
  type: 'data',
  schema: z.object({
    title: z.string(),
    venue: z.string(),
    format: z.enum(['Keynote', 'Panel', 'Lecture', 'Workshop', 'Podcast']),
    date: z.coerce.date(),
    href: z.string().url().optional(),
    summary: z.string().optional()
  })
});

export const collections = { work, writing, notes, speaking };
