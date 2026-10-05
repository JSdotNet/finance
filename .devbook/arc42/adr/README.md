# Architecture Decisions

```meta
status: draft
index: root
related: [.devbook/arc42/09-architecture-decisions.md]
```

One record per concern. A new decision on a concern changes its record and adds a row to the
record's history.

| Concern | Standing choice | Status |
| --- | --- | --- |
| [Desktop stack](desktop-stack.md) | One .NET MAUI Blazor Hybrid application, Windows only, started by Aspire in development. | proposed |
| [Storage](storage.md) | JSON files in a folder under the user's OneDrive, replicated by the OneDrive client, with no database and no sync service. | proposed |
