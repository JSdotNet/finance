# Finance

A personal finance application for one person: a local-first Windows desktop app that keeps
its records as plain JSON files in a folder under the user's OneDrive. OneDrive's own client
copies those files between PCs, so Finance has no server, cloud API, or sync service.

## Current state

Design first, no code yet. The architecture, the `finance` domain, and the design system are
drafted in [`.devbook/`](.devbook/); the first feature slices come next.

## Architecture at a glance

| Decision | Why | Record |
| --- | --- | --- |
| One .NET MAUI Blazor Hybrid desktop app | Works fully offline; nothing to host | [Desktop stack](.devbook/arc42/adr/desktop-stack.md) |
| JSON files in a OneDrive folder, written whole and atomically | The user owns and can read their data | [Storage](.devbook/arc42/adr/storage.md) |
| A UI-free model and store behind the desktop shell | Testable in memory and end to end | [Building block view](.devbook/arc42/05-building-block-view.md) |
| Aspire and Playwright for development | One command to start, one path to test | [Deployment view](.devbook/arc42/07-deployment-view.md#development) |

Start reading at [01. Introduction and Goals](.devbook/arc42/01-introduction-and-goals.md) and
the [`finance` context](.devbook/domain/finance/context.md).

## Repository layout

```text
.devbook/
  arc42/    architecture chapters and decision records
  domain/   the finance bounded context and its language
  design/   design principles, tokens, and component guidelines
  tech/     the technology graph
  ai/       how this repository is built with AI
.agents/    path-scoped rules and procedure skills, wrapped per host in .claude/ and .github/
AGENTS.md   standing rules for AI agents; CLAUDE.md imports it
```

## Working on it

Changes run through the delivery flows of [devbook](https://github.com/JSdotNet/devbook).
Before committing, run the devbook check:

```bash
node .devbook/_tools/devbook-meta/build.mjs --check
```

## License

[MIT](LICENSE)
