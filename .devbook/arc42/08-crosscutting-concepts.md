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
overrides the path for development and test runs. Finance reads the path through a typed options
object that it validates at start, as the organization's
[ADR 0018](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/adrs/0018-configuration-and-options-binding.md)
sets out. A missing path opens the first-start prompt rather than failing the start; an invalid
one fails it.

## Domain Model

```meta
status: draft
related: [.devbook/domain/finance/context.md, .devbook/domain/finance/domain.md]
```

`Finance.Domain` implements the one bounded context, `finance`. Its aggregates, rules, and
ubiquitous language are the authority of
[`.devbook/domain/finance/domain.md`](../domain/finance/domain.md). Code, UI text, and these
chapters use that language and do not define terms of their own.

## User Interface

```meta
status: draft
related: [.devbook/arc42/adr/desktop-stack.md, .devbook/arc42/adr/styling.md, .devbook/arc42/05-building-block-view.md#level-1, .devbook/design/README.md]
```

Finance's UI is Razor components in `Finance.UI`, rendered by Blazor Hybrid inside WebView2, as
[the desktop stack record](adr/desktop-stack.md) sets out. These conventions follow the
organization's
[Blazor guidance](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/recommendations/blazor-frontend-framework-guidance.md),
less everything about web APIs, server hosting, authentication, and HTTP caching.

- **Structure by feature.** `Finance.UI` groups its files per feature, not per technical type.
  A page is the composition root of its feature, and reusable visual parts sit in that
  feature's components. A part every feature uses sits in a shared folder.
- **Rules stay out of markup.** A component renders and passes on what the user did. Every
  business decision lives in `Finance.Domain`, so a validation message in the UI is an aid and
  the model checks the rule again.
- **In-process calls only.** A component reaches the model through a small UI service per
  feature, in the same process. Finance has no HTTP API, so nothing loops back over a network.
- **The least state that works.** The model is in memory from the start, per
  [Start and Load](06-runtime-view.md#start-and-load). Navigation identifiers go in the URL, and
  a feature's shared screen state goes in one state container service. Blazor Hybrid has one
  WebView, so a scoped service lives as long as the window. Finance keeps nothing in browser
  storage, because records live in the data folder and settings in local application data.
- **Binding and events.** A form binds a small edit model shaped for that form, with
  Blazor's validation components. An edit saves itself, per
  [auto-save](../design/interaction-guidelines.md#auto-save), so no form has a submit button.
  Handlers that touch files are async, guard against a second trigger while they run, and show
  a failure as [the error handling record](adr/error-handling.md) describes.
- **Styling.** Components use the design tokens only, as [the styling record](adr/styling.md)
  sets out.
- **What still applies from web security.** Finance never renders untrusted HTML without
  sanitizing it first, such as text that a future import brings in. No secret goes into
  `Finance.UI` or its static assets. The UI logs no amount or other personal financial data,
  per [the observability record](adr/observability.md).

End-to-end tests cover only the journeys that matter most, through `data-testid` selectors and
never through styling. [Testability](#testability) sets out the levels.

## Testability

```meta
status: draft
related: [.devbook/arc42/adr/test-stack.md, .devbook/arc42/adr/modularity.md, .devbook/arc42/adr/desktop-stack.md, .devbook/arc42/06-runtime-view.md#development-run-with-playwright]
```

Tests run at four levels, each with its own project under `tests/`. The tools are set in
[the test stack record](adr/test-stack.md).

| Level | What it covers | How |
| --- | --- | --- |
| Unit | The rules in `Finance.Domain` | In memory, with no files or UI. |
| Integration | `Finance.Storage` against real files | A temporary folder per test. |
| End to end | The application as the user drives it | Playwright over CDP into WebView2, or against `Finance.Web` if it is built. |
| Architecture | The project boundaries of [the modularity record](adr/modularity.md) | NetArchTest over the compiled assemblies. |

Every interactive element in `Finance.UI` carries a stable `data-testid` attribute, so a test
never depends on layout or wording.

These conventions follow the organization's
[shared testing guidance](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/recommendations/testing-shared.md):

- **Layout.** Production projects sit under `src/` and tests under `tests/`:
  `Finance.UnitTests`, `Finance.IntegrationTests`, `Finance.E2ETests`, and
  `Finance.ArchitectureTests`. CI runs them in that order of cost: unit, integration,
  architecture, then end to end.
- **Shape.** Every test marks its `// Arrange`, `// Act`, and `// Assert` sections, and acts
  once. A unit test is named `Should_ExpectedBehavior_When_StateUnderTest`, an integration
  test `Scenario_ShouldOutcome_WhenCondition`, and an architecture test
  `Layer_Should_EnforcePolicy`.
- **Test data.** Builders and test data factories create every model object, so a test states
  only what matters to it. A test never constructs an aggregate directly when a builder exists.
- **One scenario, one level.** A higher level repeats a scenario only when it adds a risk the
  lower level cannot see.

Each level has its own conventions:

- **Unit**, per [the unit testing guidance](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/recommendations/testing-unit.md).
  A behavior gets at least a happy path, a failure, and an edge case. Variations are a
  `[Theory]`. The model is tested with real objects, and a mock appears only for a port.
- **Integration**, per [the integration testing guidance](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/recommendations/testing-integration.md).
  `Finance.Storage` writes to a real temporary folder, and nothing mocks the file system. A
  test asserts what lands on disk and what loads back, not how the adapter got there.
- **End to end**, per [the end-to-end testing guidance](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/recommendations/testing-end-to-end.md).
  The AppHost starts the application against a throwaway data folder, and Playwright drives it
  as a black box. A run also checks the Aspire logs for errors the screen did not show. On a
  failure it keeps screenshots, browser console output, and logs.
- **Architecture**, per [the architecture testing guidance](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/recommendations/testing-architecture.md).
  Each test states one policy, such as `Finance.Domain` depending on no UI, file, or network
  library. Every assembly under test carries an `AssemblyReference` marker type, so a test
  finds it without a string lookup. A failure blocks the pull request.

## Observability

```meta
status: draft
related: [.devbook/arc42/07-deployment-view.md, .devbook/arc42/adr/observability.md]
```

[The observability record](adr/observability.md) holds the choice and its reasons: how
`Finance.ServiceDefaults` wires the signals, when they are exported, and what they must never
carry. Whether production errors go to a local log file is still open.

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
workflow. These two rules are all that is fixed now; the rest waits for a concrete API. The
adapter keeps its timeouts and retries inside itself, as the organization's
[ADR 0015](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/adrs/0015-resilience-strategy-for-outbound-dependencies.md)
sets out.
