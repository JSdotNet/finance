# 03. Context and Scope

```meta
status: draft
related: [.devbook/domain/context-map.md]
```

Finance's boundary is the desktop application and the data folder it owns. Everything else
is outside it.

## Business Context

```meta
status: draft
related: [.devbook/arc42/01-introduction-and-goals.md#requirements-overview, .devbook/domain/finance/context.md]
```

![System Context: Finance](c4:business-context)

Finance never calls OneDrive over the network. It reads and writes a local folder, and the
OneDrive client replicates that folder on its own schedule. The external API is drawn so
the boundary is visible; nothing about it is decided.

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "Finance never calls OneDrive over the network."
body: |
  [minor] Truth: the embedded view draws `finance -> onedrive "Reads and writes JSON files in a OneDrive folder"` (workspace.dsl line 12), a direct relationship to OneDrive as a software system, while this prose says Finance never calls OneDrive and only touches a local folder. The Technical Context table also names "Local file system" and "OneDrive client" as separate neighbours that the view does not show. Settle it by re-describing the relationship in workspace.dsl (for example "Reads and writes a local folder that the OneDrive client syncs", technology "file system"), or by adding the OneDrive client as the element Finance shares the folder with, so view and prose say the same thing.
```

## Technical Context

```meta
status: draft
related: [.devbook/arc42/07-deployment-view.md]
```

| Neighbour | Channel | What crosses it |
| --- | --- | --- |
| ME | Desktop window on Windows | All user interaction. |
| Local file system | Windows file APIs | The JSON files in the data folder. |
| OneDrive client | The same folder on disk | Nothing direct: the client syncs the folder independently of Finance. |
| External finance API | HTTPS, when it exists | Not designed; see [the integration seam](05-building-block-view.md#integration-seam). |

## Out of Scope

```meta
status: draft
```

Finance has no mobile app, no web release, and no IDE or chat integration. It runs no cloud
service and keeps no copy of the data outside the data folder. A browser host of the UI may
exist for testing, and [05. Building Block View](05-building-block-view.md#development-harness)
keeps it a development tool, not a second channel.

```annotation
author: "claude/chapter-review"
date: 2026-10-21
quote: "keeps no copy of the data outside the data folder"
body: |
  [minor] Truth: 08#persistence says "Settings, caches, and logs stay on the local machine". A cache in local application data is a copy of the data outside the data folder unless it holds no record content, and open question O5 may put error logs there too. Settle it by stating that caches and logs carry no record content (consistent with adr/observability.md), or by narrowing this sentence.
```

```annotation
kind: suggestion
author: "claude/prose-check"
date: 2026-10-21
quote: "no mobile app, no web release, and no IDE or chat integration"
body: |
  [minor] Prose (overlong sentence): The "no X, no Y, no Z" run is telegraphic; write it as a bulleted list or full sentences.
```
