# Package Management

```meta
status: proposed
date: 2026-10-08
related: [.devbook/arc42/adr/runtime.md, .devbook/arc42/02-constraints.md#technical-constraints]
```

Finance uses NuGet Central Package Management. Every package version is declared once, in the
root `Directory.Packages.props`, and a project file references a package by name only.
Transitive pinning stays off.

## Why

```meta
```

- One version per package across the solution means an upgrade happens in one place. The
  build and the tests then validate it against every project at once.
- A project file without versions cannot drift from the others, so two projects never pull
  different versions of the same library.
- A new package gets its central `PackageVersion` entry in the same change that first
  references it.
- A project-local version override is a rare exception. It carries a comment in the project
  file that says why.
- Transitive pinning stays off because Backlog found that it changes which versions resolve,
  not only where they are declared. With pinning on, every transitive dependency whose name
  also appears in `Directory.Packages.props` is lifted to that version. Central Package
  Management is meant to move the declarations, not to change the resolved graph.
- Shared build defaults such as the target framework live in `Directory.Build.props`, beside
  the package catalog, as [the runtime record](runtime.md) sets out.

## Rejected

```meta
```

| Alternative | Why it lost |
| --- | --- |
| A version in each project file | Versions drift between projects, and an upgrade means editing every file that references the package. |
| A lock file (`packages.lock.json`) without Central Package Management | It makes a restore repeatable but still leaves the declared versions scattered across project files. |
| Central Package Management with transitive pinning on | It rewrote versions the solution never asked for when Backlog tried it, so the resolved graph changed with every package bump. |
| A shared `Directory.Build.props` with package references and versions | It mixes build defaults with the version catalog, and every project inherits every package whether it needs it or not. |

## History

```meta
```

| Date | Change |
| --- | --- |
| 2026-10-08 | Proposed: Central Package Management with versions only in `Directory.Packages.props` and transitive pinning off, adopted from the organization's [ADR 0002](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/adrs/0002-central-package-management.md), as Backlog applies it. |
