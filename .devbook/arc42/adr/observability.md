# Observability

```meta
status: proposed
date: 2026-10-08
related: [.devbook/arc42/08-crosscutting-concepts.md#observability, .devbook/arc42/adr/orchestration.md, .devbook/arc42/07-deployment-view.md#development]
```

Finance uses OpenTelemetry for logs, traces, and metrics, wired once in
`Finance.ServiceDefaults`. It exports over OTLP only when `OTEL_EXPORTER_OTLP_ENDPOINT` is set,
which only the AppHost does, so the installed application sends nothing off the machine.

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
