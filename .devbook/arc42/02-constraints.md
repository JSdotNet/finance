# 02. Constraints

```meta
status: draft
related: [.devbook/arc42/04-solution-strategy.md]
```

These are the boundaries the architecture works inside. They are not open for
reconsideration per feature.

## Technical Constraints

```meta
status: draft
related: [.devbook/arc42/adr/desktop-stack.md, .devbook/arc42/adr/storage.md]
```

| Constraint | Implication |
| --- | --- |
| Windows only | The application targets Windows desktops. No macOS, Linux, mobile, or browser release is planned. |
| .NET stack | The application, its libraries, and its tests are .NET. The desktop stack is recorded in [the desktop stack record](adr/desktop-stack.md). |
| Aspire starts the repository | In development an Aspire AppHost starts the application, and the shared ServiceDefaults project wires its telemetry. |
| No server side | Finance hosts nothing. There is no web API, no database server, and no sync service. |
| Files are the store | The records are JSON files in a folder under the user's OneDrive, as [the storage record](adr/storage.md) sets out. |
| OneDrive does replication | Copying files between devices is the OneDrive client's job. Finance never talks to OneDrive's API. |

## Organizational Constraints

```meta
status: draft
```

| Constraint | Implication |
| --- | --- |
| Single user | Finance serves one person. It has no accounts, roles, sharing, or multi-user conflict handling. |
| Personal project | One person builds and runs Finance, so the architecture favours few moving parts over scale. |
| GitHub hosts the repository | Issues, pull requests, and CI run on GitHub. |
