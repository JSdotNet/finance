# 08. Cross-cutting Concepts

```meta
status: draft
```

These concepts apply across every building block and are handled the same way everywhere.

## Persistence

```meta
status: draft
related: [.devbook/arc42/adr/storage.md, .devbook/arc42/06-runtime-view.md#save-a-change]
```

[The storage record](adr/storage.md) holds the choice and its reasons. This section holds
the conventions every file in the data folder follows.

- Every file is UTF-8 JSON, indented so a person can read and diff it.
- Every file carries a `schemaVersion` number. `Finance.Storage` migrates an older file in
  memory on load and writes the current version on the next save.
- A write goes to a temporary file in the same folder, which then replaces the original.
- `Finance.Storage` is the only code that touches the data folder.
- The data folder holds records only. Settings, caches, and logs stay on the local machine.

How the records split across files is not decided yet. The rule for choosing is that a typical
edit rewrites one small file, so OneDrive uploads little and two PCs seldom touch the same file.
[11. Risks and Technical Debt](11-risks-and-technical-debt.md#open-questions) tracks the choice.

## Configuration

```meta
status: draft
related: [.devbook/arc42/06-runtime-view.md#start-and-load]
```

The path of the data folder is a per-machine setting, stored in the user's local application
data rather than in the data folder itself, because Finance needs it to find that folder. On
first start Finance asks for the folder and suggests one under the user's OneDrive. The AppHost
overrides the path for development and test runs.

## Domain Model

```meta
status: draft
related: [.devbook/domain/finance/context.md, .devbook/domain/finance/domain.md]
```

`Finance.Domain` implements the one bounded context, `finance`. Its aggregates, rules, and
ubiquitous language are the authority of
[`.devbook/domain/finance/domain.md`](../domain/finance/domain.md). Code, UI text, and these
chapters use that language and do not define terms of their own.

## Testability

```meta
status: draft
related: [.devbook/arc42/adr/desktop-stack.md, .devbook/arc42/06-runtime-view.md#development-run-with-playwright]
```

Tests run at three levels:

| Level | What it covers | How |
| --- | --- | --- |
| Unit | The rules in `Finance.Domain` | In memory, with no files or UI. |
| Integration | `Finance.Storage` against real files | A temporary folder per test. |
| End to end | The application as the user drives it | Playwright over CDP into WebView2, or against `Finance.Web` if it is built. |

Every interactive element in `Finance.UI` carries a stable `data-testid` attribute, so a test
never depends on layout or wording.

## Observability

```meta
status: draft
related: [.devbook/arc42/07-deployment-view.md]
```

`Finance.ServiceDefaults` wires OpenTelemetry logs, traces, and metrics. Under the AppHost they
go to the Aspire dashboard. In production no collector exists, and Finance sends nothing off
the machine. Whether production errors go to a local log file is still open.

## Privacy and Security

```meta
status: draft
related: [.devbook/arc42/11-risks-and-technical-debt.md#risks]
```

Finance has no login, because the Windows account and the OneDrive account already guard the
data. The files are not encrypted by Finance, and OneDrive's own encryption at rest and in
transit is the protection. A future credential, such as an API key, never goes into the data
folder, because that folder is replicated.

## External Integration

```meta
status: draft
related: [.devbook/arc42/05-building-block-view.md#integration-seam]
```

Any external API reaches the model only through an adapter that translates its data into the
`finance` model's terms. An outage or a slow response of that API must never block a local
workflow. These two rules are all that is fixed now; the rest waits for a concrete API.
