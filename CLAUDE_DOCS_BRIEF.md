# Daisy Docs Brief

## Product architecture

- `DaisyCore`: runtime/platform product for commands, menus, sidebars, tablists, shared text, placeholders, items, and lifecycle ownership.
- `DaisySeries`: parser/reference product for materials, sounds, item flags, enchantments, potions, canonical keys, display names, and curated aliases.
- `DaisyConfig`: typed YAML/config product for codecs, reload-safe handles, DaisySeries-backed parsing, and DaisyCore-compatible text bridging.

## Route structure

- `/`
- `/overview/choose-a-product/`
- `/overview/full-ecosystem-example/`
- `/overview/roadmap/`
- `/daisycore/...`
- `/daisyseries/...`
- `/daisyconfig/...`

## Current sidebar model

- `Overview`
  - ecosystem home
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
  - migration
- `DaisyConfig`
  - start here
  - guides
  - reference
  - migration

## Content strategy

- MiniMessage is the default mental model across DaisyCore-facing string APIs.
- Docs should teach:
  1. direct MiniMessage strings
  2. Components when explicit Adventure control is needed
  3. config-backed text when shared/reloadable/localized wording is needed
- DaisyConfig stores and loads text.
- DaisyCore renders text.
- DaisySeries dictionary pages provide canonical values and aliases.
- Docs should be example-led, not abstraction-led.

## Important user pain points that were being fixed

- docs felt clunky
- sections were not clear enough
- key-based text examples appeared too early
- users felt like config keys were required for ordinary messages
- not enough full-flow examples existed
- not enough “what values can I use?” reference material existed
- internal/deployment concerns should not dominate user-facing docs

## New or important docs surfaces

- `overview/full-ecosystem-example.mdx`
- DaisyCore getting-started pages rewritten around MiniMessage-first usage
- DaisyConfig guides rewritten around the “stores text, DaisyCore renders it” boundary
- DaisySeries dictionary section:
  - materials
  - sounds
  - item flags
  - enchantments
  - potions

## UX goals for a future design pass

- make section boundaries much clearer
- make product landing pages feel stronger and more premium
- make onboarding paths more visually obvious
- improve scanability of long technical pages
- make reference/dictionary tables easier to search and skim
- make “use this when…” guidance more obvious
- make cross-product navigation feel deliberate rather than bolted together

## Constraints for the design pass

- do not break the current route structure
- keep docs readable and search-friendly
- do not bury technical content under marketing-style layout
- preserve fast scanning for reference pages
- preserve the multi-product docs model
- keep the docs premium and clean, not ornamental or overdesigned
