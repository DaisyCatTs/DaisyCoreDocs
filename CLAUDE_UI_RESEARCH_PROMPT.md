# Claude UI Research Prompt For Daisy Docs

```text
You are redesigning the UI/UX/information architecture of an existing docs site. Before proposing changes, do your own research on:

1. modern high-quality technical documentation UX patterns
2. premium documentation design systems that still prioritize scanability
3. Astro Starlight customization patterns and limitations
4. best practices for multi-product docs platforms
5. best practices for reference-heavy and dictionary/table-heavy docs pages

Use that research to inform your recommendations. Do not give generic "make it cleaner" advice. Ground everything in the actual repo shape and tell me what should change structurally, visually, and in implementation terms.

Project context:

- Repo folder: `DaisyCoreDocs`
- Stack: Astro + Starlight + MDX + TypeScript + Cloudflare Pages
- This is one shared docs site for three products:
  - DaisyCore: runtime/platform library for commands, menus, sidebars, tablists, placeholders, items, text, and lifecycle ownership
  - DaisySeries: parser/reference toolkit for materials, sounds, item flags, enchantments, potions, canonical keys, and aliases
  - DaisyConfig: typed YAML/config layer for codecs, reload-safe handles, DaisySeries-backed parsing, and DaisyCore-compatible text bridging
- Route model must remain intact:
  - `/`
  - `/overview/...`
  - `/daisycore/...`
  - `/daisyseries/...`
  - `/daisyconfig/...`
- Preserve the multi-product model and existing slugs
- Do not turn the site into a marketing page
- Do not reduce scanability for technical and reference pages
- Keep docs readable, searchable, and honest
- The site should feel premium, direct, technically serious, and easier to navigate

Current implementation shape:

- `astro.config.mjs` defines the Starlight setup, metadata, and a large hard-coded sidebar tree
- `src/content.config.ts` uses Starlight `docsLoader()` and `docsSchema()`
- `src/styles/custom.css` is the main visual customization layer
- Most bespoke layouts are currently authored directly inside MDX pages rather than in reusable UI components
- There do not appear to be meaningful custom Astro/React UI components yet
- Deployment is static Astro output to Cloudflare Pages via `wrangler.jsonc`

Current design language:

- already uses a premium dark-leaning palette
- custom CSS variables for accents and surfaces
- radial gradient page backgrounds
- glassmorphism / blur / elevated panels
- custom hero sections
- custom cards, callouts, reference panels, and path grids
- improved table/code/sidebar styling
- responsive and reduced-motion support

Current page patterns/classes:

- `home-hero`
- `value-strip` / `value-pill`
- `doc-shell` / `doc-lead` / `doc-rail`
- `feature-matrix` / `feature-card`
- `doc-journey` / `step-card`
- `premium-callout`
- `reference-grid` / `reference-panel`

Where those patterns are used most:

- `src/content/docs/index.mdx`
- `src/content/docs/daisycore/index.mdx`
- `src/content/docs/daisyseries/index.mdx`
- `src/content/docs/daisyconfig/index.mdx`

Important content/UX truths:

- DaisyCore-facing string APIs are MiniMessage-first
- DaisyConfig stores text, DaisyCore renders it
- DaisySeries owns canonical values and aliases
- docs should be example-led, not abstraction-led
- config keys should not appear mandatory for ordinary messages
- long technical pages need better visual chunking
- cross-product navigation and "use this when" guidance need to be more obvious
- dictionary/reference pages should be easier to skim and search
- premium styling should stay clean and intentional, not ornamental

Current IA:

- Overview
  - overview
  - choose a product
  - full ecosystem example
  - roadmap
- DaisyCore
  - start here
  - commands
  - text and UI
  - reference and explanation
  - migration
- DaisySeries
  - start here
  - modules
  - dictionary
  - guides
  - reference
  - explanation and migration
- DaisyConfig
  - start here
  - guides
  - reference
  - explanation and migration

Representative pages that show the intended docs direction:

- `src/content/docs/overview/full-ecosystem-example.mdx`
- `src/content/docs/daisycore/guides/build-a-plugin-flow.mdx`
- `src/content/docs/daisyconfig/guides/use-daisyconfig-with-daisycore.mdx`
- `src/content/docs/daisyseries/dictionary/*.mdx`

What I want from you:

1. First, summarize what the current docs UI/system is doing well and badly.
2. Then propose a redesigned docs UX system for this exact repo.
3. Be concrete about:
   - homepage changes
   - product landing page changes
   - sidebar/navigation changes
   - page-template changes for guides, reference pages, and dictionary pages
   - visual system changes
   - reusable component or partial system I should introduce instead of repeating MDX div patterns everywhere
   - what should stay MDX-authored vs what should become reusable Astro/Starlight components
4. Tell me what external references or patterns influenced your thinking from your own research.
5. Give me an implementation plan that fits Astro + Starlight rather than a made-up stack.
6. If you suggest new components, name them and describe their responsibilities.
7. If you suggest moving pieces out of raw MDX into reusable primitives, show the target component architecture.
8. Explicitly call out tradeoffs, risks, and what not to overdesign.

Optimize for UI + UX + IA, not just color tweaks.
Preserve route structure.
Keep the docs technically serious.
```
