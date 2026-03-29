# Claude Prompt Package For Daisy Docs UI Overhaul

## Summary

This brief is meant to ground Claude in the real Daisy docs app before it proposes a UI, UX, and IA redesign.

The docs site is currently an `Astro + Starlight + MDX` multi-product documentation app in `DaisyCoreDocs`, deployed to Cloudflare Pages. Most of the experience today is defined by:

- `astro.config.mjs` for site metadata and sidebar information architecture
- `src/styles/custom.css` for the visual layer
- `src/content/docs/**/*.mdx` for page structure and most of the bespoke layout work

The intended scope for Claude is:

- improve the docs UI
- improve scanability and onboarding UX
- improve docs information architecture and navigation cues
- preserve route slugs and the multi-product model
- do its own research on modern technical-doc UX patterns, Astro/Starlight customization patterns, and premium docs references before recommending changes

## Important Public Interfaces And Constraints

Claude should treat these as fixed or semi-fixed:

- Stack:
  - `Astro`
  - `@astrojs/starlight`
  - `MDX`
  - `Cloudflare Pages`
- Current docs collection:
  - `src/content.config.ts` uses Starlight `docsLoader()` and `docsSchema()`
- Current route model must stay intact:
  - `/`
  - `/overview/...`
  - `/daisycore/...`
  - `/daisyseries/...`
  - `/daisyconfig/...`
- Current deployment shape:
  - static Astro build output
  - `wrangler.jsonc` points Pages at `./dist`
- Current design layer is primarily CSS + MDX, not a bespoke React app
- The redesign should not bury technical docs under marketing-style layout
- The redesign must preserve readability, searchability, and fast scanning for reference pages

## Repo Grounding

### 1. What the docs product is

This is one shared docs surface for three Kotlin/Paper ecosystem products:

- `DaisyCore`: runtime/platform library for commands, menus, sidebars, tablists, placeholders, items, text, and lifecycle ownership
- `DaisySeries`: parser/reference toolkit for materials, sounds, item flags, enchantments, potions, canonical keys, and aliases
- `DaisyConfig`: typed YAML/config layer for codecs, reload-safe handles, DaisySeries-backed parsing, and DaisyCore-compatible text bridging

### 2. What the docs app is using technically

- `package.json`
  - `astro`
  - `@astrojs/starlight`
  - `typescript`
  - `wrangler`
- `astro.config.mjs`
  - site URL: `https://docs.daisy.cat`
  - Starlight integration
  - large hard-coded sidebar tree for all products
  - GitHub social links for DaisyCore, DaisySeries, and DaisyConfig
  - custom head icons and manifest
  - one custom stylesheet: `./src/styles/custom.css`
- `src/content.config.ts`
  - default Starlight docs collection setup
- `wrangler.jsonc`
  - Cloudflare Pages output from `./dist`

### 3. What the current UI is doing

The current design is already more premium than stock Starlight. It includes:

- custom accent and surface variables in CSS
- radial-gradient page backgrounds
- glassmorphism and blur-backed panels
- elevated cards and pill sections
- custom hero blocks
- custom CTA buttons
- styled sidebar states
- improved table, code, and blockquote treatment
- responsive adjustments for mobile
- reduced-motion handling

Main CSS patterns in `src/styles/custom.css` include:

- `home-hero`
- `value-strip` / `value-pill`
- `doc-shell` / `doc-lead` / `doc-rail`
- `feature-matrix` / `feature-card`
- `doc-journey` / `step-card`
- `premium-callout`
- `reference-grid` / `reference-panel`
- sidebar hover/current-page treatment
- custom dark/light surface tokens

### 4. Where those patterns are currently used

Most of the bespoke layout work is authored directly inside MDX pages, especially:

- `src/content/docs/index.mdx`
- `src/content/docs/daisycore/index.mdx`
- `src/content/docs/daisyseries/index.mdx`
- `src/content/docs/daisyconfig/index.mdx`

Additional custom section patterns appear in:

- `src/content/docs/daisycore/text/overview.mdx`
- `src/content/docs/daisycore/reference/*.mdx`
- `src/content/docs/daisycore/guides/build-a-plugin-flow.mdx`
- `src/content/docs/daisycore/guides/use-config-and-lang-text-with-daisycore.mdx`
- `src/content/docs/daisyconfig/guides/*.mdx`
- `src/content/docs/daisyseries/getting-started/install.mdx`

This means the current docs experience is:

- partly theme-driven
- partly page-by-page hand-designed
- not yet a systematic reusable docs design system

### 5. Current information architecture

The sidebar is organized as:

- `Overview`
  - overview
  - choose a product
  - full ecosystem example
  - roadmap
- `DaisyCore`
  - start here
  - commands
  - text and UI
  - reference and explanation
  - migration
- `DaisySeries`
  - start here
  - modules
  - dictionary
  - guides
  - reference
  - explanation and migration
- `DaisyConfig`
  - start here
  - guides
  - reference
  - explanation and migration

### 6. Current content strategy and voice

The docs are trying to be:

- example-led, not abstraction-led
- premium and direct, not fluffy
- technically honest
- product-aware
- explicit about product boundaries

Important content rules already present:

- DaisyCore-facing string APIs are MiniMessage-first
- DaisyConfig stores text, DaisyCore renders it
- DaisySeries provides canonical values, aliases, and parsing
- config keys should not feel mandatory for ordinary messages
- full-flow examples are preferred over tiny disconnected snippets

### 7. Current strong pages to mention

These pages represent the intended docs direction and should influence the redesign:

- `src/content/docs/overview/full-ecosystem-example.mdx`
- `src/content/docs/daisycore/guides/build-a-plugin-flow.mdx`
- `src/content/docs/daisyconfig/guides/use-daisyconfig-with-daisycore.mdx`
- `src/content/docs/daisyseries/dictionary/*.mdx`

### 8. Current pain points already identified in the repo

From the existing docs brief and the current page structure, the main issues are:

- section boundaries still do not feel clear enough
- onboarding paths could be much more obvious
- cross-product navigation still feels bolted together
- long technical pages need better scanability
- dictionary/reference pages should be easier to skim and search
- the premium layer exists, but it is inconsistent and too manual
- the site relies heavily on MDX-authored layout fragments rather than reusable docs primitives
- `Choose a Product` is structurally useful but visually much weaker than the landing pages

## Recommended Scope

Claude should optimize for `UI + UX + IA`, not just visual polish.

That means:

- homepage changes
- product landing page changes
- sidebar and navigation changes
- guide/reference/dictionary page-template changes
- reusable component recommendations
- Astro/Starlight-native implementation direction

## Expected Response Structure

Ask Claude to return these sections, in this order:

1. Current-state critique
2. Research-informed design principles
3. Proposed docs architecture
4. Proposed visual system
5. Proposed reusable component system
6. Page-template recommendations by page type
7. Navigation and cross-product flow recommendations
8. Implementation roadmap for Astro/Starlight
9. Risks and anti-patterns to avoid

## Assumptions And Defaults Chosen

- scope is `UI + UX + IA`, not just color tweaks
- Claude is allowed to research externally before answering
- route slugs and multi-product docs structure stay fixed
- stack remains `Astro + Starlight + MDX`
- the likely best redesign path is:
  - keep Starlight
  - add a small reusable component layer
  - reduce repeated raw-MDX layout markup
  - improve onboarding and navigation cues
  - introduce better templates for guide, reference, and dictionary pages

## Exact Prompt

The exact copy-paste prompt lives in `CLAUDE_UI_RESEARCH_PROMPT.md`.
