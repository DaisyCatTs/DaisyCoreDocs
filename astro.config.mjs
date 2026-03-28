import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

export default defineConfig({
  site: 'https://docs.daisycore.dev',
  integrations: [
    starlight({
      title: 'DaisyCore',
      description: 'Kotlin-first Paper platform for commands, menus, scoreboards, tablists, text, placeholders, and items.',
      social: [
        { icon: 'github', label: 'GitHub', href: 'https://github.com/your-org/DaisyCore' },
      ],
      sidebar: [
        {
          label: 'Start Here',
          items: [
            { label: 'Overview', slug: 'index' },
            { label: 'Install DaisyCore', slug: 'getting-started/install' },
            { label: 'First Plugin', slug: 'getting-started/first-plugin' },
          ],
        },
        {
          label: 'Foundation',
          items: [
            { label: 'Core', slug: 'core/overview' },
            { label: 'Text', slug: 'text/overview' },
            { label: 'Placeholders', slug: 'placeholders/overview' },
            { label: 'Items', slug: 'items/overview' },
          ],
        },
        {
          label: 'Runtime APIs',
          items: [
            { label: 'Commands', slug: 'commands/overview' },
            { label: 'Menus', slug: 'menus/overview' },
            { label: 'Scoreboards', slug: 'scoreboards/overview' },
            { label: 'Tablists', slug: 'tablists/overview' },
          ],
        },
        {
          label: 'Guides',
          items: [
            { label: 'Architecture', slug: 'explanation/architecture' },
            { label: 'Performance', slug: 'guides/performance' },
            { label: 'Cloudflare Deploy', slug: 'guides/cloudflare-deploy' },
            { label: 'Migration', slug: 'migration/overview' },
          ],
        },
        {
          label: 'Reference',
          items: [
            { label: 'Bootstrap API', slug: 'reference/bootstrap-api' },
            { label: 'Placeholder API', slug: 'reference/placeholder-api' },
          ],
        },
      ],
      customCss: ['./src/styles/custom.css'],
    }),
  ],
});
