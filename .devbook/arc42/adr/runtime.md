# Runtime

```meta
status: proposed
date: 2026-10-08
related: [.devbook/arc42/02-constraints.md#technical-constraints, .devbook/arc42/adr/desktop-stack.md, .devbook/arc42/adr/package-management.md]
```

Every Finance project targets .NET 10 and is written in C# 14. The root `Directory.Build.props`
sets `net10.0` once, and the MAUI head `Finance.Desktop` targets the matching `net10.0-windows`
framework. The solution file is `Finance.slnx`.

## Why

```meta
```

- .NET 10 is a long-term support release with three years of support. A personal project that
  one person maintains should move its runtime as seldom as it can.
- C# 14 is the language that ships with .NET 10, so the code can use its features without a
  preview flag.
- Setting the framework once in `Directory.Build.props` keeps every project on the same
  baseline. The Windows framework of the MAUI head is the same baseline for one platform, not
  an exception to it.
- `.slnx` is the XML solution format. It is short, readable in a diff, and merges cleanly,
  which the older `.sln` format does not.
- The sibling Backlog repository runs on the same baseline, so its experience and its tooling
  carry over.

Finance reassesses the runtime when the next long-term support release ships. That reassessment
changes this record and adds a row to its history.

## Rejected

```meta
```

| Alternative | Why it lost |
| --- | --- |
| .NET 8 LTS | Its support ends sooner than .NET 10's, and it lacks the C# 14 features and the MAUI improvements a new codebase would want. |
| A standard-term release such as .NET 11 | Its short support window forces an upgrade within about eighteen months, which a one-person project should avoid. |
| A target framework per project file | The baseline would drift project by project, and an upgrade would touch every file instead of one. |
| The classic `.sln` file | Its format is verbose and conflicts easily in a merge. Finance starts with no existing tooling that needs it. |

## History

```meta
```

| Date | Change |
| --- | --- |
| 2026-10-08 | Proposed: .NET 10 with C# 14, set once in `Directory.Build.props`, in a `.slnx` solution, adopted from the organization's [ADR 0001](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/adrs/0001-adopt-dotnet-10.md), as Backlog applies it. |
