# Domain

```meta
status: draft
type: domain
```

```annotation
kind: question
author: claude/domain-architect
date: 2026-10-06
body: Which concepts does Finance hold? Candidates to confirm or drop: accounts (bank, savings, credit card, cash), transactions, categories, budgets, recurring payments, savings goals, investments, loans or mortgages. Which of these come first?
```

```annotation
kind: question
author: claude/domain-architect
date: 2026-10-06
body: How do transactions get into the app: typed by hand, imported from bank export files (CSV, MT940, CAMT.053), or later through the external API? Is a single currency (EUR) enough?
```

```annotation
kind: question
author: claude/domain-architect
date: 2026-10-06
body: Which concepts or features of the early Backlog version should Finance carry over, beyond the desktop-app-with-local-files shape?
```

> One chapter per Aggregate, Domain Service, Domain Event, or Shared Value Objects / Shared
> Enums grouping in this bounded context.

No aggregate, domain service, or domain event has been agreed yet. The user has said what the
app is for, but not which concepts it holds. This page gains its first chapter once those
concepts are named, and each concept's surface names go on that chapter's `aliases`.

The rules the aggregates enforce will go in `domain.invariants.md` beside this page. That file
is not created yet, because there is no aggregate whose rules it could hold.
