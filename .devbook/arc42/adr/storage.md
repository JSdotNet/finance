# Storage

```meta
status: proposed
date: 2026-10-06
related: [.devbook/arc42/04-solution-strategy.md#files-as-the-store, .devbook/arc42/08-crosscutting-concepts.md#persistence, .devbook/arc42/07-deployment-view.md#production]
```

Finance stores its records as JSON files in a folder the user picks under their OneDrive. The
OneDrive client replicates that folder between the user's PCs. Finance runs no database and no
sync service, and never calls a cloud API.

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "and never calls a cloud API."
body: |
  [minor] Over-broad: 05 Integration Seam and 01 anticipate an external finance API, which is a cloud API Finance will call. The sentence means Finance never calls OneDrive's or any storage API, as 02 Technical Constraints puts it. Scope it to storage so it does not contradict the integration seam.
```

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

```annotation
kind: question
author: "claude/chapter-review"
date: 2026-10-21
quote: "Plain files keep the data the user's own."
body: |
  [major] This reason, and R4 (unencrypted data in OneDrive, accepted for now), rest on an open question in domain/finance/context.md#user: does the app need protection on open, such as encryption of the OneDrive files? If the answer is yes, plain readable JSON stops being a reason and the choice needs revisiting. Answer that question, or state here that the storage choice assumes no encryption and revisits if the answer changes.
```

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

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "A file-sync client copying a live database file can corrupt it"
body: |
  [minor] Consequences are missing: JSON files under OneDrive also produce conflict copies that Finance cannot merge (R1), online-only placeholders that fail offline (R2), and readable unencrypted data (R4). The record links none of 11. Risks and Technical Debt. Add 11#risks to related and name R1, R2, R4 as the costs of this choice, so the SQLite rejection is weighed against them.
```

## History

```meta
```

| Date | Change |
| --- | --- |
| 2026-10-06 | Proposed: JSON files in a OneDrive folder, replicated by the OneDrive client, with no database and no sync service. |

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "| Date | Change |"
body: |
  [minor] The History table is headed Date | Change, but devbook-arc42.md fixes the header as Date | Change | Why, and build.mjs --check warns on it. Split the row's reason into a Why column (here: why JSON files in OneDrive won over SQLite and a sync service, in a clause).
```
