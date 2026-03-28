import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

export default defineConfig({
  site: 'https://docs.daisy.cat',
  integrations: [
    starlight({
      title: 'DaisyCore',
      description: 'One Kotlin-first Paper library for commands, menus, scoreboards, tablists, placeholders, items, and platform runtime.',
      social: [
        { icon: 'github', label: 'GitHub', href: 'https://github.com/DaisyCatTs/DaisyCore' },
      ],
      head: [
        { tag: 'link', attrs: { rel: 'icon', type: 'image/svg+xml', href: '/favicon.svg' } },
        { tag: 'link', attrs: { rel: 'icon', sizes: 'any', href: '/favicon.ico' } },
        { tag: 'link', attrs: { rel: 'apple-touch-icon', sizes: '180x180', href: '/apple-touch-icon.png' } },
        { tag: 'link', attrs: { rel: 'manifest', href: '/site.webmanifest' } },
        { tag: 'meta', attrs: { name: 'theme-color', content: '#130913' } },
      ],
      sidebar: [
        {
          label: 'Start Here',
          items: [
            { label: 'Overview', slug: 'index' },
            { label: 'Install DaisyCore', slug: 'getting-started/install' },
            { label: 'First Plugin', slug: 'getting-started/first-plugin' },
            { label: 'First Command', slug: 'getting-started/first-command' },
            { label: 'First Menu', slug: 'getting-started/first-menu' },
            { label: 'First Scoreboard', slug: 'getting-started/first-scoreboard' },
            { label: 'First Tablist', slug: 'getting-started/first-tablist' },
            { label: 'Build a Plugin Flow', slug: 'guides/build-a-plugin-flow' },
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
          label: 'Core Systems',
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
            { label: 'Auto-Loaded Commands', slug: 'guides/auto-loaded-commands' },
            { label: 'Config and Lang Text', slug: 'guides/use-config-and-lang-text-with-daisycore' },
            { label: 'Build a Plugin Flow', slug: 'guides/build-a-plugin-flow' },
            { label: 'Why Commands Auto-Load', slug: 'explanation/command-auto-loading' },
            { label: 'Architecture', slug: 'explanation/architecture' },
            { label: 'Migrate from DaisyCommand', slug: 'migration/daisycommand' },
            { label: 'Migrate from DaisyMenu', slug: 'migration/daisymenu' },
            { label: 'Performance', slug: 'guides/performance' },
            { label: 'Cloudflare Deploy', slug: 'guides/cloudflare-deploy' },
            { label: 'Migration', slug: 'migration/overview' },
          ],
        },
        {
          label: 'Explanation',
          items: [
            { label: 'Why DaisyCore Is One Library', slug: 'explanation/why-daisycore-is-one-library' },
            { label: 'Architecture', slug: 'explanation/architecture' },
            { label: 'Why Commands Auto-Load', slug: 'explanation/command-auto-loading' },
            { label: 'Runtime and Shutdown', slug: 'explanation/runtime-and-shutdown' },
            { label: 'Menu Sessions', slug: 'explanation/menu-sessions' },
            { label: 'Sidebar Refresh and Diffing', slug: 'explanation/sidebar-refresh-and-diffing' },
            { label: 'Tablist Rendering Model', slug: 'explanation/tablist-rendering-model' },
          ],
        },
        {
          label: 'Reference',
          items: [
            { label: 'Bootstrap API', slug: 'reference/bootstrap-api' },
            { label: 'Command DSL', slug: 'reference/command-dsl' },
            { label: 'Menu DSL', slug: 'reference/menu-dsl' },
            { label: 'Sidebar DSL', slug: 'reference/sidebar-dsl' },
            { label: 'Tablist DSL', slug: 'reference/tablist-dsl' },
            { label: 'Placeholder API', slug: 'reference/placeholder-api' },
            { label: 'Item Builder API', slug: 'reference/item-builder-api' },
          ],
        },
      ],
      customCss: ['./src/styles/custom.css'],
    }),
  ],
});
