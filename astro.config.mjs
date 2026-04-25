// @ts-check
import { defineConfig } from 'astro/config';
import cloudflare from '@astrojs/cloudflare';
import mdx from '@astrojs/mdx';
import sitemap from '@astrojs/sitemap';
import emdash from 'emdash/astro';
import { d1, r2 } from '@emdash-cms/cloudflare';

export default defineConfig({
  site: 'https://jmichaelbrowning.com',

  // EmDash requires SSR — content is served live from D1, not pre-rendered.
  // Pages that don't need the database can be prerendered individually
  // using: export const prerender = true; at the top of any .astro file.
  output: 'server',

  adapter: cloudflare({
    platformProxy: { enabled: true },
    imageService: 'compile'
  }),

  integrations: [
    emdash({
      database: d1(),
      storage: r2(),
      // The D1 binding name must match wrangler.jsonc [[d1_databases]] → binding
      databaseBinding: 'DB',
      // The R2 binding name must match wrangler.jsonc [[r2_buckets]] → binding
      storageBinding: 'MEDIA',
    }),
    mdx(),
    sitemap()
  ],

  prefetch: {
    prefetchAll: false,
    defaultStrategy: 'hover'
  },

  vite: {
    build: { cssMinify: 'lightningcss' },
    ssr: { external: ['node:buffer', 'node:path', 'node:fs', 'node:crypto'] }
  }
});
