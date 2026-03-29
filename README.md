# Daisy Docs

Documentation site for the Daisy ecosystem.

## Stack

- Astro
- Starlight
- MDX
- Cloudflare Pages

## Local Development

```bash
npm install
npm run dev
```

## Build

```bash
npm run build
```

## IntelliJ Workflow

- Open the repo as a normal Node project in IntelliJ IDEA.
- Run `npm install` once.
- Use `npm run dev` for local docs work.
- Use `npm run build` before pushing docs changes.
- IntelliJ's built-in terminal is enough for normal docs work.

## Deployment

Docs deployment is a maintainer workflow, not part of the normal reader-facing docs experience.

```bash
npm run build
npx wrangler pages deploy dist
```

## Product Planning

- Daisy docs platform direction: [DAISY_DOCS_PLATFORM_PLAN.md](./DAISY_DOCS_PLATFORM_PLAN.md)
- Claude docs redesign brief: [CLAUDE_DOCS_BRIEF.md](./CLAUDE_DOCS_BRIEF.md)
- Copy-paste prompt for Claude research/design pass: [CLAUDE_UI_RESEARCH_PROMPT.md](./CLAUDE_UI_RESEARCH_PROMPT.md)
