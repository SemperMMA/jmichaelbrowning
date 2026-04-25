// @ts-check
import { defineConfig } from 'astro/config';
import cloudflare from '@astrojs/cloudflare';
import emdash from 'emdash/astro';
import { d1, r2 } from '@emdash-cms/cloudflare';

export default defineConfig({
  output: 'server',

  adapter: cloudflare(),

  integrations: [
    emdash({
      database: d1(),
      storage: r2(),
      databaseBinding: 'DB',
      storageBinding: 'MEDIA'
    })
  ]
});
