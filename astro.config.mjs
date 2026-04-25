// @ts-check
import { defineConfig } from 'astro/config';
import cloudflare from '@astrojs/cloudflare';
import emdash from 'emdash/astro';
import { d1, r2 } from '@emdash-cms/cloudflare';

export default defineConfig({
  site: 'https://jmichaelbrowning.com',
  output: 'server',

  image: {
    service: {
      entrypoint: 'astro/assets/services/noop'
    }
  },

  adapter: cloudflare(),

  integrations: [
    emdash({
      database: d1({ binding: 'DB' }),
      storage: r2({ binding: 'MEDIA' })
    })
  ]
});
