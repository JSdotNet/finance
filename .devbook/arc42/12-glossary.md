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
