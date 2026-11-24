# Runtime

```meta
date: 2026-11-24
related: [.devbook/arc42/02-constraints.md#technical-constraints, .devbook/arc42/adr/desktop-stack.md, .devbook/arc42/adr/package-management.md]
```

Every Finance project targets .NET 11 and is written in C# 15, the SDK's default language
version. `global.json` pins the SDK with `"rollForward": "latestFeature"`. The root
`Directory.Build.props` sets `net11.0` once, and the MAUI head `Finance.Desktop` targets the
matching `net11.0-windows` framework. The solution file is `Finance.slnx`. Finance follows the
organization's [ADR 0001: Platform and Build](https://github.com/JSdotNet/app-defaults/blob/main/defaults/arc42/adr/0001-platform-and-build.md)
and moves to each new GA release within three months.

## Why

```meta
```

- A standard-term release now gets 24 months of support counted from the next release, so
  .NET 11 and .NET 10 both reach end of support in November 2028. Staying on .NET 10 buys no
  support time and delays C# 15 by a year.
- Finance has no code yet, so it starts on .NET 11 instead of migrating to it later.
- C# 15 is the SDK's default language version, so the code uses its features without a
  preview flag. Preview features stay off.
- Setting the framework once in `Directory.Build.props` keeps every project on the same
  baseline. The Windows framework of the MAUI head is the same baseline for one platform, not
  an exception to it.
- `.slnx` is the XML solution format. It is short, readable in a diff, and merges cleanly,
  which the older `.sln` format does not.

## Rejected

```meta
```

| Alternative | Why it lost |
| --- | --- |
| .NET 10 LTS | Its support ends in the same month as .NET 11's, and it lacks C# 15 and .NET 11's MAUI changes. |
| A target framework per project file | The baseline would drift project by project, and an upgrade would touch every file instead of one. |
| The classic `.sln` file | Its format is verbose and conflicts easily in a merge. Finance starts with no existing tooling that needs it. |

## History

```meta
```

| Date | Change | Why |
| --- | --- | --- |
| 2026-11-24 | Proposed: .NET 11 with C# 15, SDK pinned in `global.json`, following the newest GA release. | The organization's [ADR 0001](https://github.com/JSdotNet/app-defaults/blob/main/defaults/arc42/adr/0001-platform-and-build.md) moved to the newest GA release once STS support matched LTS. |
| 2026-10-08 | Proposed: .NET 10 with C# 14, set once in `Directory.Build.props`, in a `.slnx` solution. | Adopted from the organization's former ADR 0001 (Adopt .NET 10), as Backlog applies it. |
