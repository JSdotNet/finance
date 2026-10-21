# Runtime

```meta
status: proposed
date: 2026-10-08
related: [.devbook/arc42/02-constraints.md#technical-constraints, .devbook/arc42/adr/desktop-stack.md, .devbook/arc42/adr/package-management.md]
```

Every Finance project targets .NET 10 and is written in C# 14. The root `Directory.Build.props`
sets `net10.0` once, and the MAUI head `Finance.Desktop` targets the matching `net10.0-windows`
framework. The solution file is `Finance.slnx`.

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "targets the matching `net10.0-windows`"
body: |
  [minor] A MAUI Windows head targets a versioned platform framework, such as net10.0-windows10.0.19041.0, not bare net10.0-windows, and it overrides the TargetFramework Directory.Build.props sets, so it is an override in the build even if it is the same baseline. Any test project that loads Finance.Desktop (architecture tests over compiled assemblies) needs the same Windows framework. Name the exact framework and the override mechanism.
```

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

```annotation
kind: question
author: "claude/chapter-review"
date: 2026-10-21
quote: "`.slnx` is the XML solution format."
body: |
  [minor] Scope: the solution file format is not decided together with the runtime, and reversing it is a single dotnet sln migrate, which by devbook-arc42.md's test (a reversal costing a migration) is not a record at all. Should .slnx move to a sentence in a convention or 02 Constraints, leaving this record to the framework baseline?
```

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

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "forces an upgrade within about eighteen months"
body: |
  [minor] Stale: since .NET 9, Microsoft supports standard-term releases for 24 months, not 18. The rejection still stands (two years against three, and an earlier forced move), but correct the figure.
```

## History

```meta
```

| Date | Change |
| --- | --- |
| 2026-10-08 | Proposed: .NET 10 with C# 14, set once in `Directory.Build.props`, in a `.slnx` solution, adopted from the organization's [ADR 0001](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/adrs/0001-adopt-dotnet-10.md), as Backlog applies it. |

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "| Date | Change |"
body: |
  [minor] The History table is headed Date | Change, but devbook-arc42.md fixes the header as Date | Change | Why, and build.mjs --check warns on it. Split the row's reason into its own Why column (here: adopted from the organization's ADR 0001 as Backlog applies it is the why).
```
