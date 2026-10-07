# Modularity

```meta
status: proposed
date: 2026-10-08
related: [.devbook/arc42/05-building-block-view.md#level-1, .devbook/arc42/08-crosscutting-concepts.md#persistence, .devbook/arc42/adr/storage.md, .devbook/domain/finance/context.md]
```

Finance has one project per responsibility around the single `finance` bounded context.
`Finance.Domain` owns the model and the store interface it needs, `Finance.Storage` implements
that interface, and architecture tests check the boundaries.

## Why

```meta
```

- `Finance.Domain` references no UI, file, or network library. The rules can then be tested in
  memory, and the file format can change without touching a rule.
- The store interface sits next to the code that uses it, in `Finance.Domain`. It is a
  persistence port inside the context, not a contract published to anyone else.
- `Finance.Storage` is the only project that touches the data folder. Persistence-only mapping
  types stay inside it and never reach the model.
- Finance has one bounded context, so there is no module that would consume an
  `.Abstractions` project or need a folder under `src/Modules/`. Both arrive when a second
  bounded context exists.
- Architecture tests check the project references, so a boundary holds even when a change is
  reviewed in a hurry.

## Rejected

```meta
```

| Alternative | Why it lost |
| --- | --- |
| A modular monolith with module folders under `src/Modules/` now | It adds a folder level and a registration pattern for modules that do not exist. One context needs neither. |
| A `Finance.Domain.Abstractions` project | Nothing outside the context consumes a contract, so a published surface would have no reader. |
| The store interface in `Finance.Storage` | The model would then depend on the storage project, and the file format would leak into the rules. |
| One project for model, storage, and UI | It leaves the boundaries to review alone, and the model could reach the file system without anyone noticing. |
| Boundaries checked by review only | Review misses a stray project reference. A test fails the build instead. |

## History

```meta
```

| Date | Change |
| --- | --- |
| 2026-10-08 | Proposed: one project per responsibility around the `finance` context, with the store port in `Finance.Domain` and no `.Abstractions` project until a second context exists, adopted from the organization's [ADR 0005](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/adrs/0005-modular-monolith-structure.md) and [ADR 0014](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/adrs/0014-persistence-strategy-and-repository-boundaries.md), as Backlog applies them. |
