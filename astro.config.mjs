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
      sidebar: [
        {
          label: 'Overview',
          items: [
            { label: 'Overview', slug: 'index' },
            { label: 'Choose a Product', slug: 'overview/choose-a-product' },
            { label: 'Full Ecosystem Example', slug: 'overview/full-ecosystem-example' },
            { label: 'Roadmap', slug: 'overview/roadmap' },
          ],
        },
        {
          label: 'DaisyCore',
          items: [
            { label: 'Overview', slug: 'daisycore' },
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
                { label: 'Commands Overview', slug: 'daisycore/commands/overview' },
                { label: 'Command DSL', slug: 'daisycore/reference/command-dsl' },
              ],
            },
            {
              label: 'Text and UI',
              items: [
                { label: 'Core Overview', slug: 'daisycore/core/overview' },
                { label: 'Text', slug: 'daisycore/text/overview' },
                { label: 'Placeholders', slug: 'daisycore/placeholders/overview' },
                { label: 'Items', slug: 'daisycore/items/overview' },
                { label: 'Menus', slug: 'daisycore/menus/overview' },
                { label: 'Scoreboards', slug: 'daisycore/scoreboards/overview' },
                { label: 'Tablists', slug: 'daisycore/tablists/overview' },
                { label: 'Auto-Loaded Commands', slug: 'daisycore/guides/auto-loaded-commands' },
                { label: 'Config and Lang Text', slug: 'daisycore/guides/use-config-and-lang-text-with-daisycore' },
                { label: 'Menu DSL', slug: 'daisycore/reference/menu-dsl' },
                { label: 'Sidebar DSL', slug: 'daisycore/reference/sidebar-dsl' },
                { label: 'Tablist DSL', slug: 'daisycore/reference/tablist-dsl' },
                { label: 'Placeholder API', slug: 'daisycore/reference/placeholder-api' },
                { label: 'Item Builder API', slug: 'daisycore/reference/item-builder-api' },
                { label: 'Performance', slug: 'daisycore/guides/performance' },
              ],
            },
            {
              label: 'Reference and Explanation',
              items: [
                { label: 'Bootstrap API', slug: 'daisycore/reference/bootstrap-api' },
                { label: 'Why DaisyCore Is One Library', slug: 'daisycore/explanation/why-daisycore-is-one-library' },
                { label: 'Architecture', slug: 'daisycore/explanation/architecture' },
                { label: 'Why Commands Auto-Load', slug: 'daisycore/explanation/command-auto-loading' },
                { label: 'Runtime and Shutdown', slug: 'daisycore/explanation/runtime-and-shutdown' },
                { label: 'Menu Sessions', slug: 'daisycore/explanation/menu-sessions' },
                { label: 'Sidebar Refresh and Diffing', slug: 'daisycore/explanation/sidebar-refresh-and-diffing' },
                { label: 'Tablist Rendering Model', slug: 'daisycore/explanation/tablist-rendering-model' },
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
            { label: 'Overview', slug: 'daisyseries' },
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
                { label: 'Dictionary Overview', slug: 'daisyseries/dictionary' },
                { label: 'Materials Dictionary', slug: 'daisyseries/dictionary/materials' },
                { label: 'Sounds Dictionary', slug: 'daisyseries/dictionary/sounds' },
                { label: 'Item Flags Dictionary', slug: 'daisyseries/dictionary/item-flags' },
                { label: 'Enchantments Dictionary', slug: 'daisyseries/dictionary/enchantments' },
                { label: 'Potions Dictionary', slug: 'daisyseries/dictionary/potions' },
              ],
            },
            {
              label: 'Guides',
              items: [
                { label: 'Use DaisySeries with DaisyCore', slug: 'daisyseries/guides/use-daisyseries-with-daisycore' },
                { label: 'Config-Driven Plugins', slug: 'daisyseries/guides/use-daisyseries-in-config-driven-plugins' },
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
              label: 'Explanation and Migration',
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
            { label: 'Overview', slug: 'daisyconfig' },
            {
              label: 'Start Here',
              items: [
                { label: 'Install DaisyConfig', slug: 'daisyconfig/getting-started/install' },
                { label: 'First Config', slug: 'daisyconfig/getting-started/first-config' },
              ],
            },
            {
              label: 'Guides',
              items: [
                { label: 'Reload-Safe Configs', slug: 'daisyconfig/guides/reload-safe-configs' },
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
                { label: 'Reload Handles', slug: 'daisyconfig/reference/reload-handles' },
                { label: 'Text Bridge', slug: 'daisyconfig/reference/text-bridge' },
              ],
            },
            {
              label: 'Explanation and Migration',
              items: [
                { label: 'Why DaisyConfig Is Separate', slug: 'daisyconfig/explanation/why-daisyconfig-is-separate' },
                { label: 'Migration', slug: 'daisyconfig/migration/from-plugin-local-config-loaders' },
              ],
            },
          ],
        },
      ],
      customCss: ['./src/styles/custom.css'],
    }),
  ],
});
