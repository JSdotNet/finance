# 02. Constraints

```meta
related: [.devbook/arc42/04-solution-strategy.md]
```

No feature reopens the boundaries below.

## Technical Constraints

```meta
related: [.devbook/arc42/adr/desktop-stack.md, .devbook/arc42/adr/storage.md, .devbook/arc42/adr/runtime.md, .devbook/arc42/adr/orchestration.md]
```

| Constraint | Implication |
| --- | --- |
| Windows only | The application targets Windows desktops. No macOS, Linux, mobile, or browser release is planned. |
| .NET stack | The application, its libraries, and its tests are .NET. See [desktop stack](adr/desktop-stack.md) and [runtime](adr/runtime.md). |
| Aspire starts the repository | In development an AppHost starts the application and ServiceDefaults wires its telemetry. See [orchestration](adr/orchestration.md). |
| No server side | Finance hosts nothing. There is no web API, no database server, and no sync service. |
| Files are the store | The records are JSON files in a folder under the user's OneDrive, as [the storage record](adr/storage.md) sets out. |
| OneDrive does replication | Copying files between devices is the OneDrive client's job. Finance never talks to OneDrive's API. |

## Organizational Constraints

```meta
```

| Constraint | Implication |
| --- | --- |
| Single user | Finance serves one person. It has no accounts, roles, sharing, or multi-user conflict handling. |
| Personal project | One person builds and runs Finance, so the architecture favours few moving parts over scale. |
| GitHub hosts the repository | Issues, pull requests, and CI run on GitHub. |
