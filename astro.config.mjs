import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

export default defineConfig({
  site: 'https://docs.daisy.cat',
  integrations: [
    starlight({
      title: 'Daisy',
      description: 'Shared docs for DaisyCore, DaisySeries, and DaisyConfig: the Kotlin-first Paper platform, parser toolkit, and typed config layer.',
      social: [
        { icon: 'github', label: 'DaisyCore on GitHub', href: 'https://github.com/DaisyCatTs/DaisyCore' },
        { icon: 'github', label: 'DaisySeries on GitHub', href: 'https://github.com/DaisyCatTs/DaisySeries' },
        { icon: 'github', label: 'DaisyConfig on GitHub', href: 'https://github.com/DaisyCatTs/DaisyConfig' },
      ],
      head: [
        { tag: 'link', attrs: { rel: 'icon', type: 'image/svg+xml', href: '/favicon.svg' } },
        { tag: 'link', attrs: { rel: 'icon', sizes: 'any', href: '/favicon.ico' } },
        { tag: 'link', attrs: { rel: 'apple-touch-icon', sizes: '180x180', href: '/apple-touch-icon.png' } },
        { tag: 'link', attrs: { rel: 'manifest', href: '/site.webmanifest' } },
        { tag: 'meta', attrs: { name: 'theme-color', content: '#130913' } },
      ],
      components: {
        Header: './src/components/overrides/Header.astro',
        Sidebar: './src/components/overrides/Sidebar.astro',
        PageTitle: './src/components/overrides/PageTitle.astro',
        Hero: './src/components/overrides/Hero.astro',
        TableOfContents: './src/components/overrides/TableOfContents.astro',
        Footer: './src/components/overrides/Footer.astro',
        MarkdownContent: './src/components/overrides/MarkdownContent.astro',
      },
      sidebar: [
        {
          label: 'Overview',
          items: [
            { label: 'Getting Started', slug: 'index' },
            { label: 'Which product do I need?', slug: 'overview/choose-a-product' },
            { label: 'Ecosystem Example', slug: 'overview/full-ecosystem-example' },
            { label: 'Roadmap', slug: 'overview/roadmap' },
          ],
        },
        {
          label: 'DaisyCore',
          items: [
            {
              label: 'Start Here',
              items: [
                { label: 'Install DaisyCore', slug: 'daisycore/getting-started/install' },
                { label: 'First Plugin', slug: 'daisycore/getting-started/first-plugin' },
                { label: 'First Command', slug: 'daisycore/getting-started/first-command' },
                { label: 'First Menu', slug: 'daisycore/getting-started/first-menu' },
                { label: 'First Scoreboard', slug: 'daisycore/getting-started/first-scoreboard' },
                { label: 'First Tablist', slug: 'daisycore/getting-started/first-tablist' },
                { label: 'Build a Plugin Flow', slug: 'daisycore/guides/build-a-plugin-flow' },
              ],
            },
            {
              label: 'Commands',
              items: [
                { label: 'Overview', slug: 'daisycore/commands/overview' },
                { label: 'Registration', slug: 'daisycore/commands/registration' },
                { label: 'Arguments', slug: 'daisycore/commands/arguments' },
                { label: 'Permissions', slug: 'daisycore/commands/permissions' },
              ],
            },
            {
              label: 'Text & UI',
              items: [
                { label: 'MiniMessage Overview', slug: 'daisycore/text/overview' },
                { label: 'Menus', slug: 'daisycore/menus/overview' },
                { label: 'Sidebars', slug: 'daisycore/scoreboards/overview' },
                { label: 'Tablists', slug: 'daisycore/tablists/overview' },
              ],
            },
            {
              label: 'Reference',
              items: [
                { label: 'Bootstrap API', slug: 'daisycore/reference/bootstrap-api' },
                { label: 'Command DSL', slug: 'daisycore/reference/command-dsl' },
                { label: 'Menu DSL', slug: 'daisycore/reference/menu-dsl' },
                { label: 'Sidebar DSL', slug: 'daisycore/reference/sidebar-dsl' },
                { label: 'Tablist DSL', slug: 'daisycore/reference/tablist-dsl' },
                { label: 'Placeholder API', slug: 'daisycore/reference/placeholder-api' },
                { label: 'Item Builder API', slug: 'daisycore/reference/item-builder-api' },
              ],
            },
            {
              label: 'Migration',
              items: [
                { label: 'Migration Overview', slug: 'daisycore/migration/overview' },
                { label: 'Migrate from DaisyCommand', slug: 'daisycore/migration/daisycommand' },
                { label: 'Migrate from DaisyMenu', slug: 'daisycore/migration/daisymenu' },
              ],
            },
          ],
        },
        {
          label: 'DaisySeries',
          items: [
            {
              label: 'Start Here',
              items: [
                { label: 'Install DaisySeries', slug: 'daisyseries/getting-started/install' },
                { label: 'First Parse', slug: 'daisyseries/getting-started/first-parse' },
              ],
            },
            {
              label: 'Modules',
              items: [
                { label: 'Materials', slug: 'daisyseries/modules/materials' },
                { label: 'Sounds', slug: 'daisyseries/modules/sounds' },
                { label: 'Item Flags', slug: 'daisyseries/modules/item-flags' },
                { label: 'Enchantments', slug: 'daisyseries/modules/enchantments' },
                { label: 'Potions', slug: 'daisyseries/modules/potions' },
              ],
            },
            {
              label: 'Dictionary',
              items: [
                { label: 'Materials', slug: 'daisyseries/dictionary/materials' },
                { label: 'Sounds', slug: 'daisyseries/dictionary/sounds' },
                { label: 'Enchantments', slug: 'daisyseries/dictionary/enchantments' },
                { label: 'Item Flags', slug: 'daisyseries/dictionary/item-flags' },
                { label: 'Potions', slug: 'daisyseries/dictionary/potions' },
                { label: 'Canonical Keys', slug: 'daisyseries/dictionary/canonical-keys' },
              ],
            },
            {
              label: 'Reference',
              items: [
                { label: 'Material API', slug: 'daisyseries/reference/material-api' },
                { label: 'Sound API', slug: 'daisyseries/reference/sound-api' },
                { label: 'Item Flag API', slug: 'daisyseries/reference/item-flag-api' },
                { label: 'Enchantment API', slug: 'daisyseries/reference/enchantment-api' },
                { label: 'Potion API', slug: 'daisyseries/reference/potion-api' },
              ],
            },
            {
              label: 'Migration',
              items: [
                { label: 'Why DaisySeries Is Separate', slug: 'daisyseries/explanation/why-daisyseries-is-separate' },
                { label: 'Migration', slug: 'daisyseries/migration/from-plugin-local-enum-helpers' },
              ],
            },
          ],
        },
        {
          label: 'DaisyConfig',
          items: [
            {
              label: 'Start Here',
              items: [
                { label: 'Install DaisyConfig', slug: 'daisyconfig/getting-started/install' },
                { label: 'First Config', slug: 'daisyconfig/getting-started/first-config' },
                { label: 'Managed YAML Files', slug: 'daisyconfig/guides/managed-yaml-files' },
              ],
            },
            {
              label: 'Guides',
              items: [
                { label: 'Reload-Safe Configs', slug: 'daisyconfig/guides/reload-safe-configs' },
                { label: 'Module Bundles', slug: 'daisyconfig/guides/module-bundles' },
                { label: 'Example Plugin Walkthrough', slug: 'daisyconfig/guides/example-plugin-walkthrough' },
                { label: 'Use DaisyConfig with DaisyCore', slug: 'daisyconfig/guides/use-daisyconfig-with-daisycore' },
                { label: 'Use DaisyConfig with DaisySeries', slug: 'daisyconfig/guides/use-daisyconfig-with-daisyseries' },
                { label: 'Config Text vs Direct MiniMessage', slug: 'daisyconfig/guides/when-to-use-config-text-vs-direct-minimessage' },
                { label: 'Safe Placeholder-Aware Text', slug: 'daisyconfig/guides/safe-placeholder-aware-text' },
              ],
            },
            {
              label: 'Reference',
              items: [
                { label: 'Config Codecs', slug: 'daisyconfig/reference/config-codecs' },
                { label: 'YAML Loading', slug: 'daisyconfig/reference/yaml-loading' },
                { label: 'Managed YAML', slug: 'daisyconfig/reference/managed-yaml' },
                { label: 'YAML Migrations', slug: 'daisyconfig/reference/yaml-migrations' },
                { label: 'Reload Handles', slug: 'daisyconfig/reference/reload-handles' },
                { label: 'Module Registry', slug: 'daisyconfig/reference/module-registry' },
                { label: 'Text Bridge', slug: 'daisyconfig/reference/text-bridge' },
              ],
            },
            {
              label: 'Migration',
              items: [
                { label: 'Why DaisyConfig Is Separate', slug: 'daisyconfig/explanation/why-daisyconfig-is-separate' },
                { label: 'From Plugin-Local Config Loaders', slug: 'daisyconfig/migration/from-plugin-local-config-loaders' },
              ],
            },
          ],
        },
      ],
      customCss: ['./src/styles/custom.css'],
    }),
  ],
});
