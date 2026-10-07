# Scripting

```meta
status: proposed
date: 2026-10-08
related: [.devbook/arc42/adr/runtime.md, .devbook/arc42/adr/package-management.md]
```

Finance writes its repository automation as .NET 10 file-based apps. Each script is one `.cs`
file under `scripts/`, declares its packages with `#:` directives, has no `.csproj`, and runs
with `dotnet run scripts/<name>.cs`.

## Why

```meta
```

- A developer needs only the .NET 10 SDK the application already requires, as
  [the runtime record](runtime.md) sets out. No Python, Bash, or Node.js runtime has to be
  installed.
- A script is written in the same C# as the application, with typing, NuGet packages, and the
  same editor support.
- A `#:package` directive without a version takes the version from `Directory.Packages.props`,
  so scripts stay in step with [the package catalog](package-management.md).
- A single file needs no project, no solution entry, and no restore lock file, so a short
  script costs no more than the code in it.
- Scripts are tooling only. They never reference `Finance.Domain`, `Finance.Storage`, or any
  other application project.

## Rejected

```meta
```

| Alternative | Why it lost |
| --- | --- |
| PowerShell or Bash | Neither is typed, neither uses NuGet, and each behaves differently across shells and platforms. |
| Python | It adds a second runtime to install and keep current, outside the .NET toolchain. |
| A console project per tool | It needs a `.csproj` and a solution entry for what is usually one short, single-purpose file. |

## History

```meta
```

| Date | Change |
| --- | --- |
| 2026-10-08 | Proposed: .NET 10 file-based apps under `scripts/`, run with `dotnet run`, adopted from the organization's [ADR 0019](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/adrs/0019-csharp-script-files.md). |
