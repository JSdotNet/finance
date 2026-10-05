# Desktop Stack

```meta
status: proposed
date: 2026-10-06
related: [.devbook/arc42/04-solution-strategy.md#local-first-desktop-application, .devbook/arc42/05-building-block-view.md#level-1, .devbook/arc42/02-constraints.md#technical-constraints]
```

Finance is one .NET MAUI Blazor Hybrid application that targets Windows only. MAUI's WinUI 3
head provides the native window and file access, and the UI is Razor components rendered in
WebView2. In development an Aspire AppHost launches it.

## Why

```meta
```

- It runs as a full native process, so it reads and writes the data folder directly and works
  offline, as the local-first goal requires.
- WebView2 is Chromium and exposes a CDP debugging port, so Playwright can drive the real
  application end to end with the same tooling used for web projects.
- Aspire can launch it as a project resource, so one command starts the application, its
  dashboard, and any harness beside it.
- The UI lives in a Razor class library with no file access, so a plain browser host can render
  the same components for tests if that ever pays off.
- Windows is the only platform the user needs, which removes MAUI's cross-platform testing cost.
- The sibling Backlog repository made the same choice for the same reasons, so its experience
  carries over.

## Rejected

```meta
```

| Alternative | Why it lost |
| --- | --- |
| Plain WinUI 3 | Native and fully local-first, but Playwright cannot drive it. UI tests would need WinAppDriver or UI Automation, and Aspire can only add it as a bare executable. |
| WPF | The same test-tooling gap as WinUI 3, on an older UI stack. |
| Blazor WebAssembly as an installable web app | Browser storage cannot write plain files in a OneDrive folder reliably, so it breaks the storage choice. |
| Electron or another web shell | Leaves the .NET stack the rest of Finance uses, and adds a Node runtime to ship. |
| A web application with a server | Needs hosting, which the no-server constraint rules out. |

## History

```meta
```

| Date | Change |
| --- | --- |
| 2026-10-06 | Proposed: .NET MAUI Blazor Hybrid on Windows, started by Aspire, following Backlog's early desktop choice. |
