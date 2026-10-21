# Observability

```meta
status: proposed
date: 2026-10-08
related: [.devbook/arc42/08-crosscutting-concepts.md#observability, .devbook/arc42/adr/orchestration.md, .devbook/arc42/07-deployment-view.md#development]
```

Finance uses OpenTelemetry for logs, traces, and metrics, wired once in
`Finance.ServiceDefaults`. It exports over OTLP only when `OTEL_EXPORTER_OTLP_ENDPOINT` is set,
which only the AppHost does, so the installed application sends nothing off the machine.

```annotation
kind: flag
author: "claude/chapter-review"
date: 2026-10-21
quote: "which only the AppHost does, so the installed application sends nothing off the machine"
body: |
  [major] The privacy guarantee rests on an environment variable being absent, but OTEL_EXPORTER_OTLP_ENDPOINT is a standard, process-inherited variable: any other tool that sets it user- or machine-wide (a collector, another instrumented app, a developer machine that is also the user's PC) silently turns export on, with operation traces of the user's finances. The rejected row says a code-set endpoint could export by accident; this can too. Add a Finance-specific opt-in the AppHost sets (or check for the AppHost's own variables) before the exporter is registered.
```

## Why

```meta
```

- OpenTelemetry is one vendor-neutral standard for all three signals, so Finance needs no
  separate library per signal.
- Under the AppHost the signals go to the Aspire dashboard, which is all the visibility
  development needs.
- The exporter endpoint comes from an environment variable and never from code. In production
  that variable is not set, so no telemetry leaves the user's PC. That keeps the privacy goal
  without a second configuration path.
- Finance starts an activity for an operation with several steps, such as loading the data
  folder or saving a change. It starts none for a trivial getter, an inner loop, or a pure
  function.
- Custom attributes carry the `finance.` prefix, so they never collide with the semantic
  conventions the libraries use.
- No span, metric, or log line carries an amount or any other financial value. Telemetry
  describes what Finance did, never the user's money.

```annotation
author: "claude/chapter-review"
date: 2026-10-21
quote: "so no telemetry leaves the user's PC"
body: |
  [minor] Gap: with no exporter in production, logs and the technical-fault exceptions error-handling.md keeps as exceptions go nowhere. 08 Observability and 11 O5 hold that open; this record should say so and link O5, so a reader does not assume production has a log.
```

## Rejected

```meta
```

| Alternative | Why it lost |
| --- | --- |
| Serilog as the only logging library | It covers logs but not traces or metrics, and the Aspire dashboard reads OpenTelemetry natively. |
| Application Insights | It sends telemetry to a cloud service, which breaks both the no-cloud constraint and the privacy goal. |
| An exporter endpoint set in code | Production could then export by accident. An environment variable keeps export off unless the AppHost turns it on. |

## History

```meta
```

| Date | Change |
| --- | --- |
| 2026-10-08 | Proposed: OpenTelemetry through `Finance.ServiceDefaults`, exported over OTLP only under the AppHost, with no financial values in telemetry, adopted from the organization's [ADR 0010](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/adrs/0010-adopt-opentelemetry-for-observability.md), as Backlog applies it. |

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "| Date | Change |"
body: |
  [minor] The History table is headed Date | Change, but devbook-arc42.md fixes the header as Date | Change | Why, and build.mjs --check warns on it. Split the row's reason into its own Why column (here: adopted from the organization's ADR 0010 as Backlog applies it is the why).
```
