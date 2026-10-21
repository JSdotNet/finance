# Scripting

```meta
status: proposed
date: 2026-10-08
related: [.devbook/arc42/adr/runtime.md, .devbook/arc42/adr/package-management.md]
```

```annotation
kind: question
author: "claude/chapter-review"
date: 2026-10-21
body: |
  [minor] Scope: devbook-arc42.md keeps a record for a choice whose reversal costs a migration of code, data, or the model's language, and says process rules and tooling conventions carry their reason in a sentence instead. Repository automation never ships and rewriting a script touches no application code or data. Does this concern meet the record test, or should it move to a contributor convention?
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

```annotation
kind: flag
author: "claude/chapter-review"
date: 2026-10-21
quote: "No Python, Bash, or Node.js runtime has to be"
body: |
  [major] Untrue for this repository: AGENTS.md requires node .devbook/_tools/devbook-meta/build.mjs --check before every commit, and the OpenSpec change lane is a Node CLI, so Node.js is already a required developer runtime. Restate the reason (one language with the application, typed, NuGet) without the claim, or say why the devbook tooling is exempt.
```

## Rejected

```meta
```

| Alternative | Why it lost |
| --- | --- |
| PowerShell or Bash | Neither is typed, neither uses NuGet, and each behaves differently across shells and platforms. |
| Python | It adds a second runtime to install and keep current, outside the .NET toolchain. |
| A console project per tool | It needs a `.csproj` and a solution entry for what is usually one short, single-purpose file. |

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "Neither is typed, neither uses NuGet, and each behaves differently across shells and platforms."
body: |
  [minor] Partly inaccurate: PowerShell works on typed .NET objects and installs modules from the NuGet-based PowerShell Gallery, and Finance is Windows-only with a Windows CI runner (07), so cross-platform drift weighs little. The stronger reasons are a second language beside C# and no access to the package catalog. Reword the rejection to the reasons that hold.
```

## History

```meta
```

| Date | Change |
| --- | --- |
| 2026-10-08 | Proposed: .NET 10 file-based apps under `scripts/`, run with `dotnet run`, adopted from the organization's [ADR 0019](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/adrs/0019-csharp-script-files.md). |

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "| Date | Change |"
body: |
  [minor] The History table is headed Date | Change, but devbook-arc42.md fixes the header as Date | Change | Why, and build.mjs --check warns on it. Split the row's reason into its own Why column (here: adopted from the organization's ADR 0019 is the why).
```
