# Scripting

```meta
date: 2026-11-24
related: [.devbook/arc42/adr/runtime.md, .devbook/arc42/adr/package-management.md]
```

Finance writes its repository automation as .NET 11 file-based apps. Each script is one `.cs`
file under `scripts/`, declares its packages with `#:` directives, has no `.csproj`, and runs
with `dotnet run scripts/<name>.cs`, as the organization's
[ADR 0001: Platform and Build](https://github.com/JSdotNet/app-defaults/blob/main/defaults/arc42/adr/0001-platform-and-build.md)
prescribes.

## Why

```meta
```

- A developer needs only the .NET 11 SDK the application already requires, as
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

| Date | Change | Why |
| --- | --- | --- |
| 2026-11-24 | Proposed: the scripts run on the .NET 11 SDK. | The runtime moved to .NET 11. |
| 2026-10-08 | Proposed: .NET 10 file-based apps under `scripts/`, run with `dotnet run`. | Adopted from the organization's former ADR 0019 (C# standalone script files). |
