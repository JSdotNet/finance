# Technology Graph

```meta
rating: candidate
index: root
```

This file is the map of everything this repository builds with, and the layer files hold one
chapter per technology. The stack is .NET 11 with Aspire 17 orchestration, per
[the runtime record](../arc42/adr/runtime.md) and [the orchestration record](../arc42/adr/orchestration.md). Nothing is registered until
the first project exists and `.devbook/_tools/devbook-tech/dotnet-packages.mjs` has an
inventory to read.

## Layers

| File | Covers |
| --- | --- |
| `shared.md` | Cross-layer formats, protocols, and contracts |
| `backend.md` | The .NET services and their packages |
| `tooling.md` | Development, AI, build, CI/CD, and governance tooling |

Layer files are created when they have a chapter to hold; none exists yet.

## Graph

```mermaid
graph LR
  empty["no technology registered yet"]
```

## Status ladder

`candidate` → `trial` → `adopted` → `hold` → `retired`, per `devbook-tech.md`. The
file-level rating above is the stack's own: nothing here is past `candidate` until a
chapter says so.
