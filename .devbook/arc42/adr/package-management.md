# Package Management

```meta
date: 2026-11-25
related: [.devbook/arc42/adr/runtime.md, .devbook/arc42/02-constraints.md#technical-constraints]
```

Finance uses NuGet Central Package Management with transitive pinning on and a committed
`packages.lock.json` per project, as the organization's
[ADR 0001: Platform and Build](https://github.com/JSdotNet/app-defaults/blob/main/defaults/arc42/adr/0001-platform-and-build.md)
sets out. Every version is declared once, in the root `Directory.Packages.props`, and a project
file references a package by name only.

## Why

```meta
```

- One version per package across the solution means an upgrade happens in one place. The
  build and the tests then validate it against every project at once.
- With transitive pinning on, a version in `Directory.Packages.props` also governs the
  packages Finance pulls in indirectly. A vulnerable transitive dependency is then lifted in
  the same one place.
- Pinning can change which versions resolve. The lock files make that change visible: a
  package bump shows its whole effect on the resolved graph in the diff of its pull request.
- A restore in locked mode fails when a lock file does not match. A developer's PC and CI
  then build from the same graph.
- A new package gets its central `PackageVersion` entry in the same change that first
  references it.
- A project-local version override is a rare exception. It carries a comment in the project
  file that says why.
- Shared build defaults such as the target framework live in `Directory.Build.props`, beside
  the package catalog, as [the runtime record](runtime.md) sets out.

## Rejected

```meta
```

| Alternative | Why it lost |
| --- | --- |
| A version in each project file | Versions drift between projects, and an upgrade means editing every file that references the package. |
| A lock file without Central Package Management | It makes a restore repeatable but still leaves the declared versions scattered across project files. |
| Central Package Management with transitive pinning off | Indirect dependencies would escape the catalog, so a vulnerable one could not be lifted centrally. |
| Pinning without lock files | Pinning would change the resolved graph with no diff that shows it. |
| A shared `Directory.Build.props` with package references and versions | It mixes build defaults with the version catalog, and every project inherits every package whether it needs it or not. |

## History

```meta
```

| Date | Change | Why |
| --- | --- | --- |
| 2026-11-25 | Proposed: transitive pinning on, with a committed `packages.lock.json` per project restored in locked mode. | The organization's [ADR 0001](https://github.com/JSdotNet/app-defaults/blob/main/defaults/arc42/adr/0001-platform-and-build.md) turns pinning on and adds lock files; Finance has no code to migrate. |
| 2026-10-08 | Proposed: Central Package Management with versions only in `Directory.Packages.props` and transitive pinning off. | Adopted from the organization's former [ADR 0002](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/adrs/0002-central-package-management.md), as Backlog applies it. |
