// @ts-check
import { defineConfig } from 'astro/config';
import cloudflare from '@astrojs/cloudflare';
import emdash from 'emdash/astro';
import { d1 } from 'emdash/db';

export default defineConfig({
  site: 'https://jmichaelbrowning.com',
  output: 'server',

  adapter: cloudflare(),

  integrations: [
    emdash({
      database: d1()
    })
  ]
});
