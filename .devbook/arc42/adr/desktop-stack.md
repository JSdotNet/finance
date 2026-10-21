# Desktop Stack

```meta
status: proposed
date: 2026-10-06
related: [.devbook/arc42/04-solution-strategy.md#local-first-desktop-application, .devbook/arc42/05-building-block-view.md#level-1, .devbook/arc42/02-constraints.md#technical-constraints]
```

Finance is one .NET MAUI Blazor Hybrid application that targets Windows only. MAUI's WinUI 3
head provides the native window and file access, and the UI is Razor components rendered in
WebView2. In development an Aspire AppHost launches it.

```annotation
kind: question
author: "claude/chapter-review"
date: 2026-10-21
quote: "In development an Aspire AppHost launches it."
body: |
  [major] Windows is the only target, so MAUI's cross-platform value is nil, and R5 in 11. Risks and Technical Debt names MAUI's tooling weight as a risk. Blazor Hybrid hosted in WPF or WinForms (BlazorWebView) gives the same Razor UI in WebView2, the same CDP route for Playwright, and the same Razor class library split, on a lighter, unpackaged-by-default head. Was it weighed? Settle by adding it to Rejected with the reason it lost, or reconsidering the choice.
```

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

```annotation
kind: flag
author: "claude/chapter-review"
date: 2026-10-21
quote: "WebView2 is Chromium and exposes a CDP debugging port"
body: |
  [major] WebView2 exposes no CDP port by default; it opens one only when started with --remote-debugging-port (WEBVIEW2_ADDITIONAL_BROWSER_ARGUMENTS or CoreWebView2EnvironmentOptions). That port lets any local process read and drive the UI, which shows the user's financial records, so it must never be open in the installed application. State that the port is enabled only under the AppHost (as observability does for the OTLP endpoint) and record it as a consequence; 08 Privacy and Security should link it.
```

```annotation
kind: question
author: "claude/chapter-review"
date: 2026-10-21
quote: "The sibling Backlog repository made the same choice for the same reasons"
body: |
  [minor] History says the choice follows "Backlog's early desktop choice", and storage.md says later Backlog built a sync service. Did Backlog later move off MAUI Blazor Hybrid, and if so why? If it did, that reason is the one a reader most needs here: answer it in Why or Rejected, or drop the word early.
```

## Rejected

```meta
```

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
body: |
  [minor] The record states no consequences of the choice: the WebView2 Evergreen runtime becomes an install dependency, the MAUI Windows head forces the packaging question (11 O3), and CDP brittleness is R5. Link R5 and O3 from Why or a closing paragraph, so the cost of the choice sits next to its reasons.
```

| Alternative | Why it lost |
| --- | --- |
| Plain WinUI 3 | Native and fully local-first, but Playwright cannot drive it. UI tests would need WinAppDriver or UI Automation, and Aspire can only add it as a bare executable. |
| WPF | The same test-tooling gap as WinUI 3, on an older UI stack. |
| Blazor WebAssembly as an installable web app | Browser storage cannot write plain files in a OneDrive folder reliably, so it breaks the storage choice. |
| Electron or another web shell | Leaves the .NET stack the rest of Finance uses, and adds a Node runtime to ship. |
| A web application with a server | Needs hosting, which the no-server constraint rules out. |

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "Browser storage cannot write plain files in a OneDrive folder reliably"
body: |
  [minor] As stated the reason is weaker than the real one: Chromium and Edge expose the File System Access API, which can write plain files into a user-picked folder. What actually breaks the storage choice is that permission must be re-granted per session, there is no access without an open tab, and the API is Chromium-only. Name those limits so the rejection survives someone pointing at the API.
```

## History

```meta
```

| Date | Change |
| --- | --- |
| 2026-10-06 | Proposed: .NET MAUI Blazor Hybrid on Windows, started by Aspire, following Backlog's early desktop choice. |

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "| Date | Change |"
body: |
  [minor] The History table is headed Date | Change, but devbook-arc42.md fixes the header as Date | Change | Why, and build.mjs --check warns on it. Split the row's reason into its own Why column (here: why MAUI Blazor Hybrid won, in a clause, moved out of the Change cell).
```
