# 12. Glossary

```meta
status: draft
related: [.devbook/domain/finance/domain.md, .devbook/domain/context-map.md]
```

The ubiquitous language of the `finance` bounded context lives in
[`.devbook/domain/finance/domain.md`](../domain/finance/domain.md), and this glossary does not
repeat it. Below are only the architecture terms the arc42 chapters use.

## Terms

```meta
status: draft
```

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
body: |
  [minor] Vocabulary gaps across the arc42 chapters. "ME" names the user in 01, 10, 11, and workspace.dsl, but the domain calls that role "User" and "the person" (domain/finance/context.md#user), and the glossary defines neither. The store abstraction is "store interface" in 05 and adr/modularity.md and "store port" in the adr index and the modularity history. "OTLP" (07, 06) and "Files On-Demand" (11 R2) are used undefined. Settle: align ME with the domain term, or define it here as the persona of that User; pick one of store interface or store port; add OTLP and Files On-Demand.
```

| Term | Definition |
| --- | --- |
| Local-first | The desktop application owns the data and works fully offline. Nothing it needs sits behind a network call. |
| Data folder | The folder under the user's OneDrive that holds Finance's JSON files. The user picks it on first start. |
| Atomic write | Writing a file to a temporary file beside it, then replacing the original, so a crash never leaves half a file. |
| Schema version | The `schemaVersion` number in every data file, which tells `Finance.Storage` how to read and migrate it. |
| Conflict copy | A second copy of a file that OneDrive creates when two PCs changed it before syncing. |
| AppHost | The Aspire project that starts Finance and its dashboard in development. |
| ServiceDefaults | The shared Aspire project that adds telemetry and health checks to Finance's projects. |
| Development harness | The projects and tools that exist only to run and test Finance: the AppHost, the Aspire dashboard, `Finance.Web`, and Playwright. |
| Integration adapter | The anticipated project that translates an external API's data into the `finance` model. It acts as an anti-corruption layer. |
| WebView2 | Microsoft's embedded Chromium control, in which the Razor UI renders. |
| CDP | Chrome DevTools Protocol. Playwright uses it to drive WebView2. |

```annotation
author: "claude/chapter-review"
date: 2026-10-21
quote: "The shared Aspire project that adds telemetry and health checks to"
body: |
  [minor] adr/orchestration.md says health checks "do not apply" because Finance has no services, so ServiceDefaults adds telemetry only. Calling it an "Aspire project" also clashes with the claim that nothing from Aspire ships, although it reaches the installed app through Finance.Desktop (see the flag on 07#production). Settle: define it as the shared telemetry wiring that ships inside Finance.Desktop with export switched off, and drop health checks.
```
