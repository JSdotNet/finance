# Architecture Decisions

```meta
status: draft
index: root
related: [.devbook/arc42/09-architecture-decisions.md]
```

```annotation
author: "claude/chapter-review"
date: 2026-10-21
body: |
  [minor] Gap: 11. Risks and Technical Debt O3 (packaging and installation: MSIX, unpackaged, other) is a hosting/deployment-model choice whose reversal costs a migration, which devbook-arc42.md names as record-worthy, and MAUI on Windows forces it early (WindowsPackageType, WebView2 runtime delivery). The index has no row for it. When O3 is answered, open a packaging record and list it here; until then nothing here needs to change.
```

One record per concern. A new decision on a concern changes its record and adds a row to the
record's history.

| Concern | Standing choice | Status |
| --- | --- | --- |
| [Desktop stack](desktop-stack.md) | One .NET MAUI Blazor Hybrid application, Windows only, started by Aspire in development. | proposed |
| [Storage](storage.md) | JSON files in a folder under the user's OneDrive, replicated by the OneDrive client, with no database and no sync service. | proposed |
| [Runtime](runtime.md) | .NET 10 and C# 14 in every project, set once in `Directory.Build.props`, in a `.slnx` solution. | proposed |
| [Package management](package-management.md) | Central Package Management, with every version in `Directory.Packages.props` and transitive pinning off. | proposed |
| [Orchestration](orchestration.md) | Aspire in development only, through `Finance.AppHost` and `Finance.ServiceDefaults`; nothing from Aspire ships to the user. | proposed |
| [Observability](observability.md) | OpenTelemetry through `Finance.ServiceDefaults`, exported only under the AppHost, with no financial values in telemetry. | proposed |
| [Modularity](modularity.md) | One project per responsibility around the `finance` context, with the store port in `Finance.Domain`, checked by architecture tests. | proposed |
| [Error handling](error-handling.md) | Expected outcomes cross the application boundary as `Result` or `Result<T>`, and technical faults stay exceptions. | proposed |
| [Scripting](scripting.md) | Repository automation as .NET 10 file-based apps under `scripts/`, run with `dotnet run`. | proposed |
| [Styling](styling.md) | Every colour, font, size, and spacing value is a CSS custom property declared once in `Finance.UI`, with values owned by `.devbook/design/`. | proposed |
| [Test stack](test-stack.md) | xUnit, Moq, Bogus, AwesomeAssertions, NetArchTest, and Playwright under Aspire for every test project. | proposed |

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "| Concern | Standing choice | Status |"
body: |
  [minor] The Status column restates each record's meta status, a second copy no check keeps in step: when one record moves off proposed, the index will silently disagree. devbook-arc42.md asks the index for the concern and its standing choice in one line only. Drop the column, or have the derived index carry the status.
```
