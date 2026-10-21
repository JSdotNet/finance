# Orchestration

```meta
status: proposed
date: 2026-10-08
related: [.devbook/arc42/05-building-block-view.md#development-harness, .devbook/arc42/07-deployment-view.md#development, .devbook/arc42/adr/desktop-stack.md, .devbook/arc42/adr/observability.md]
```

Finance uses .NET Aspire in development only. `Finance.AppHost` starts the application and the
Aspire dashboard, and `Finance.ServiceDefaults` carries the shared wiring. Nothing from Aspire
ships to the user.

```annotation
kind: flag
author: "claude/chapter-review"
date: 2026-10-21
quote: "Nothing from Aspire"
body: |
  [major] Contradiction: the Why section has Finance.ServiceDefaults reach the MAUI head through an IMauiInitializeService, and 05 Development Harness draws Finance.Desktop referencing Finance.ServiceDefaults, so ServiceDefaults and its OpenTelemetry and Aspire service-default packages compile into the installed application. Yet this sentence and 05 say these projects never ship. Either state that ServiceDefaults ships (with export off, per observability.md) and fix 05, or keep it out of the release build and say how.
```

## Why

```meta
```

- One command starts the application, its dashboard, and any test harness beside it, against
  a test data folder outside OneDrive.
- `Finance.ServiceDefaults` reaches the MAUI head through an `IMauiInitializeService`. The
  desktop application therefore gets its telemetry the same way a service would, without code
  of its own.
- Every port is assigned per run, and no project hard-codes one. A developer reads the ports
  from the dashboard or the AppHost output, so parallel runs and worktrees never collide.
- Secrets never go into an Aspire project. They live in user secrets or environment variables.
- The installed application runs without the AppHost. Finance has no services, so production
  needs nothing to orchestrate.

The organization guideline also asks for service discovery, health checks per service, and
resilience defaults on outbound calls. Finance has no services and no outbound calls, so those
parts do not apply. They come back to this record when an external API is integrated.

```annotation
kind: flag
author: "claude/chapter-review"
date: 2026-10-21
quote: "The organization guideline also asks for service discovery, health checks per service"
body: |
  [minor] Contradiction: this says health checks do not apply, while 05 Development Harness says Finance.ServiceDefaults adds OpenTelemetry and health checks to every project that references it, and 12 Glossary defines ServiceDefaults the same way. One side is wrong; settle which and align the other.
```

## Rejected

```meta
```

| Alternative | Why it lost |
| --- | --- |
| No orchestration, with `launchSettings.json` only | It starts the application but not the dashboard or a test harness, and it gives no telemetry view during development. |
| Aspire in production as well | Finance hosts nothing, so there is nothing to orchestrate on the user's PC. Shipping Aspire would only add weight. |
| A strongly typed resource extensions project for the AppHost | It pays off when infrastructure resources are shared across many projects. Finance's AppHost wires two project resources directly. |

## History

```meta
```

| Date | Change |
| --- | --- |
| 2026-10-08 | Proposed: Aspire in development only, with `Finance.AppHost` and `Finance.ServiceDefaults` and no hard-coded ports, adopted from the organization's [ADR 0003](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/adrs/0003-recommend-aspire-for-aspnet-projects.md), as Backlog applies it. |

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "| Date | Change |"
body: |
  [minor] The History table is headed Date | Change, but devbook-arc42.md fixes the header as Date | Change | Why, and build.mjs --check warns on it. Split the row's reason into its own Why column (here: adopted from the organization's ADR 0003 as Backlog applies it is the why).
```
