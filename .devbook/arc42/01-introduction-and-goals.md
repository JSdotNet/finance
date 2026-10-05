# 01. Introduction and Goals

```meta
status: draft
related: [.devbook/domain/finance/context.md, .devbook/arc42/10-quality-requirements.md]
```

Finance is a personal finance application for one person. It runs as a single Windows
desktop application and keeps its data as JSON files in a folder under that person's
OneDrive. OneDrive's own client copies those files between devices, so Finance itself has no
server, cloud API, or sync service.

The overriding architectural driver is local-first, as
[12. Glossary](12-glossary.md#terms) defines it: the desktop application works fully offline
and owns its data.

## Requirements Overview

```meta
status: draft
related: [.devbook/domain/context-map.md, .devbook/domain/finance/context.md]
```

Finance models one bounded context, `finance`. What that context covers, and the language
it uses, is the authority of [`.devbook/domain/finance/context.md`](../domain/finance/context.md);
this chapter does not restate it.

The architecture has to deliver three things:

| Need | What it means for the architecture |
| --- | --- |
| Keep personal finance records | One desktop application reads and writes the records of the `finance` context. |
| Own the data locally | The records are plain JSON files the user can see, back up, and keep without Finance. |
| Have the data on every PC the user signs in to | OneDrive replicates the data folder; Finance adds no replication of its own. |

Reaching an external API, such as a bank or a market-data feed, is anticipated but not
designed. [05. Building Block View](05-building-block-view.md#integration-seam) reserves the
place where it would attach.

## Quality Goals

```meta
status: draft
related: [.devbook/arc42/10-quality-requirements.md]
```

The top quality goals, in priority order:

| # | Quality goal | Motivation |
| --- | --- | --- |
| 1 | Local-first availability | Every workflow works offline. No network call stands between the user and their records. |
| 2 | Data ownership and durability | The records are readable JSON in a folder the user controls. A crash or a failed write never corrupts them. |
| 3 | Privacy | Financial data goes nowhere but the user's own disk and their own OneDrive. |
| 4 | Testability | The whole application starts from one Aspire command and can be driven end to end by Playwright. |
| 5 | Low operating cost | There is nothing to host, pay for, or keep running besides the desktop application. |

[10. Quality Requirements](10-quality-requirements.md) turns these into testable scenarios.

## Stakeholders

```meta
status: draft
```

| Name | Concern |
| --- | --- |
| ME | The single user and owner of Finance. Wants a reliable, private overview of their own finances on their own PCs. |
| Developer | The same person, working on Finance. Wants one command to start it and an end-to-end test path. |
