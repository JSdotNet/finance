# Architecture Decisions

```meta
index: root
related: [.devbook/arc42/09-architecture-decisions.md]
```

One record per concern. A new decision on a concern changes its record and adds a row to the
record's history.

| Concern | Standing choice | Status |
| --- | --- | --- |
| [Desktop stack](desktop-stack.md) | One .NET MAUI Blazor Hybrid application on .NET 11, Windows only, started by Aspire in development. | proposed |
| [Storage](storage.md) | JSON files in a folder under the user's OneDrive, replicated by the OneDrive client, with no database and no sync service. | proposed |
| [Runtime](runtime.md) | .NET 11 and C# 15 in every project, SDK pinned in `global.json`, set once in `Directory.Build.props`, in a `.slnx` solution. | proposed |
| [Package management](package-management.md) | Central Package Management, with every version in `Directory.Packages.props` and transitive pinning off. | proposed |
| [Orchestration](orchestration.md) | Aspire 17 in development only, through a `Microsoft.NET.Sdk` `Finance.AppHost` that adds projects with `AddDotnetProject`, and `Finance.ServiceDefaults`; nothing from Aspire ships to the user. | proposed |
| [Observability](observability.md) | OpenTelemetry through `Finance.ServiceDefaults`, exported only under the AppHost, with no financial values in telemetry. | proposed |
| [Modularity](modularity.md) | One project per responsibility around the `finance` context, with the store port in `Finance.Domain`, checked by architecture tests. | proposed |
| [Error handling](error-handling.md) | Expected outcomes cross the application boundary as `Result` or `Result<T>`, and technical faults stay exceptions. | proposed |
| [Scripting](scripting.md) | Repository automation as .NET 11 file-based apps under `scripts/`, run with `dotnet run`. | proposed |
| [Styling](styling.md) | Every colour, font, size, and spacing value is a CSS custom property declared once in `Finance.UI`, with values owned by `.devbook/design/`. | proposed |
| [Test stack](test-stack.md) | xUnit, Moq, Bogus, AwesomeAssertions, NetArchTest, and Playwright under Aspire for every test project. | proposed |
