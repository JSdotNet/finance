# 04. Solution Strategy

```meta
status: draft
related: [.devbook/arc42/09-architecture-decisions.md, .devbook/arc42/01-introduction-and-goals.md#quality-goals]
```

Four moves turn the goals and constraints into an architecture. Each one names the quality
goal it serves and links the record that carries its reasons.

| Move | Serves | Record or chapter |
| --- | --- | --- |
| One local-first desktop application | Availability, privacy, low cost | [Desktop stack](adr/desktop-stack.md) |
| JSON files in a OneDrive folder, replicated by OneDrive | Ownership, durability, low cost | [Storage](adr/storage.md) |
| A UI-free model and store behind the desktop shell | Testability, durability | [05. Building Block View](05-building-block-view.md) |
| Aspire and Playwright for development | Testability | [07. Deployment View](07-deployment-view.md#development) |

## Local-first Desktop Application

```meta
status: draft
related: [.devbook/arc42/adr/desktop-stack.md]
```

Finance is one .NET MAUI Blazor Hybrid application on Windows. MAUI supplies the native
window and full file-system access, and Blazor renders the UI as Razor components inside
WebView2, Microsoft's embedded Chromium browser control. The application needs no network
for any workflow.

## Files as the Store

```meta
status: draft
related: [.devbook/arc42/adr/storage.md, .devbook/arc42/08-crosscutting-concepts.md#persistence]
```

The records live as JSON files in the data folder, under the user's OneDrive. Finance writes
each file whole and atomically, and OneDrive copies the folder to the user's other PCs. A
second PC is therefore a second copy of the same files, not a client of a shared service.

## Model and Store Independent of the UI

```meta
status: draft
related: [.devbook/arc42/05-building-block-view.md#level-1, .devbook/domain/finance/context.md]
```

The `finance` model and the file store are plain .NET libraries with no UI dependency. The
desktop shell composes them. That keeps the rules testable in memory, lets a browser host
render the same UI for tests, and leaves a stable place to add an adapter for an external
API later.

## Development Orchestration

```meta
status: draft
related: [.devbook/arc42/07-deployment-view.md#development, .devbook/arc42/08-crosscutting-concepts.md#testability]
```

An Aspire AppHost starts the desktop application and shows its logs and traces in the Aspire
dashboard. Playwright drives the UI by attaching to WebView2's debugging port. Neither
Aspire nor Playwright ships to the user.
