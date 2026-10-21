# 02. Constraints

```meta
status: draft
related: [.devbook/arc42/04-solution-strategy.md]
```

These are the boundaries the architecture works inside. They are not open for
reconsideration per feature.

```annotation
kind: question
author: "claude/chapter-review"
date: 2026-10-21
quote: "They are not open for"
body: |
  [major] Truth/Status: the chapter calls these boundaries closed, but most technical rows are the solution itself, resting on records that are all `status: proposed` (desktop-stack, storage, runtime, orchestration). The reasoning is also circular: adr/desktop-stack.md and adr/storage.md reject alternatives because of "the no-server constraint", while "No server side" here exists only because of those records. Which rows are imposed from outside (the user needs only Windows; single user; one person runs it) and which are decisions? Settle it by keeping only imposed constraints here, each with its source, and moving the decided ones (.NET MAUI, Aspire, files as the store, OneDrive replication) to 04 with their records; or by stating who imposed each row.
```

## Technical Constraints

```meta
status: draft
related: [.devbook/arc42/adr/desktop-stack.md, .devbook/arc42/adr/storage.md, .devbook/arc42/adr/runtime.md, .devbook/arc42/adr/orchestration.md]
```

| Constraint | Implication |
| --- | --- |
| Windows only | The application targets Windows desktops. No macOS, Linux, mobile, or browser release is planned. |
| .NET stack | The application, its libraries, and its tests are .NET. The desktop stack is recorded in [the desktop stack record](adr/desktop-stack.md), and the framework baseline in [the runtime record](adr/runtime.md). |
| Aspire starts the repository | In development an Aspire AppHost starts the application, and the shared ServiceDefaults project wires its telemetry, as [the orchestration record](adr/orchestration.md) sets out. |
| No server side | Finance hosts nothing. There is no web API, no database server, and no sync service. |
| Files are the store | The records are JSON files in a folder under the user's OneDrive, as [the storage record](adr/storage.md) sets out. |
| OneDrive does replication | Copying files between devices is the OneDrive client's job. Finance never talks to OneDrive's API. |

```annotation
kind: question
author: "claude/chapter-review"
date: 2026-10-21
quote: "The application, its libraries, and its tests are .NET."
body: |
  [minor] Truth: the devbook journey tooling installed in .devbook/_tools/scenarios/ (setup.ts, shot.ts, report.mjs) derives and runs `@playwright/test` specs in TypeScript under Node, while this row says the tests are .NET and adr/test-stack.md names Playwright for .NET. Will devbook journeys (scenario-derive, scenario-run) be used in this repository? If yes, this row needs an exception for a Node/TypeScript end-to-end suite and test-stack a matching row; if no, say journeys are not run here.
```

## Organizational Constraints

```meta
status: draft
```

| Constraint | Implication |
| --- | --- |
| Single user | Finance serves one person. It has no accounts, roles, sharing, or multi-user conflict handling. |
| Personal project | One person builds and runs Finance, so the architecture favours few moving parts over scale. |
| GitHub hosts the repository | Issues, pull requests, and CI run on GitHub. |

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "GitHub hosts the repository"
body: |
  [minor] Gaps: the runtime, orchestration, observability, modularity, and test-stack records, and 08 (ADR 0015, ADR 0018), are all "adopted from the organization's" JSdotNet Project-Guidelines-MCP guidance. Following that guideline set is an organizational constraint this table never states, nor does it say what a deviation costs (adr/orchestration.md already deviates on service discovery, health checks, and resilience). Settle it by adding a row naming the guideline repository and the rule for deviating from it, for example that a deviation is stated in the record that makes it.
```
