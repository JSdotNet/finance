# Storage

```meta
status: proposed
date: 2026-10-06
related: [.devbook/arc42/04-solution-strategy.md#files-as-the-store, .devbook/arc42/08-crosscutting-concepts.md#persistence, .devbook/arc42/07-deployment-view.md#production]
```

Finance stores its records as JSON files in a folder the user picks under their OneDrive. The
OneDrive client replicates that folder between the user's PCs. Finance runs no database and no
sync service, and never calls a cloud API.

## Why

```meta
```

- Plain files keep the data the user's own. They can open, back up, or move it without Finance.
- OneDrive already gives the user an off-machine copy, version history, and replication to
  their other PCs, at no extra cost and with nothing to host.
- One user's finance records are small, so loading them all into memory at start is fast and
  needs no query engine.
- JSON matches records with numbers, dates, and amounts, and .NET reads and writes it with no
  extra dependency.
- A whole-file atomic replace suits a file-sync client well: OneDrive only ever sees a complete
  file.

## Rejected

```meta
```

| Alternative | Why it lost |
| --- | --- |
| SQLite in the OneDrive folder | A file-sync client copying a live database file can corrupt it or produce conflict copies that cannot be merged. The binary file also hides changes from a person. |
| SQLite locally with a JSON export to OneDrive | Two stores to keep consistent, for a data size that needs no database. |
| A cloud API with a database | Needs a server, hosting, authentication, and a network for every workflow. It contradicts both the no-server constraint and local-first. |
| A sync service beside a local store, as later Backlog built | Solves multi-device, multi-channel sync that a single user with one desktop application does not have. OneDrive covers the need. |
| Markdown files, as early Backlog used | Finance's records are structured data, not prose, and JSON parses them without a custom format. |

## History

```meta
```

| Date | Change |
| --- | --- |
| 2026-10-06 | Proposed: JSON files in a OneDrive folder, replicated by the OneDrive client, with no database and no sync service. |
