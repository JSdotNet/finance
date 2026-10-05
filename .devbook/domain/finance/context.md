# Finance

```meta
status: draft
index: root
type: context
```

```annotation
kind: question
author: claude/domain-architect
date: 2026-10-06
body: Two of the out-of-scope lines are proposals, not stated facts: no business bookkeeping or tax reports, and never moving money (no payments, transfers, or trades). Confirm both, or say which belongs inside the boundary.
```

Finance keeps the record of one person's own money and lets that person work with it. The
model is not designed yet: which concepts it holds is an open question, listed on
[domain.md](domain.md).

Inside the boundary: the personal finances of one person, as that person records and reviews
them in the desktop app.

Outside it: several things are deliberately left out, and no other context answers them.

- Finance serves one person, so it knows nothing of a second user or a shared household.
- Finance does not synchronise data. The files sit in the person's OneDrive folder, and
  OneDrive itself moves them between machines.
- Finance is not bookkeeping for a business. It keeps no ledger for a company and produces
  no tax or statutory reports.
- Finance does not move money. It records what happened and never pays, transfers, or
  trades on the person's behalf.

## User

```meta
status: draft
type: user
```

```annotation
kind: question
author: claude/domain-architect
date: 2026-10-06
body: Does the app need any protection on open, such as a password or encryption of the OneDrive files, or is the operating system login enough?
```

The one person whose finances the app records. That person installs the desktop app, owns
the files in their own OneDrive folder, and is the only one who reads or changes them.

Because there is only ever one user, the model does not record who made a change.

## Dependencies

```annotation
kind: question
author: claude/domain-architect
date: 2026-10-06
body: Which external API is anticipated (a bank through PSD2 or open banking, a market-price feed, exchange rates, something else), and what would Finance take from it?
```

### Outbound dependencies

| Depends on (context/module) | DDD pattern | Integration mechanism | Contract | Why |
|---|---|---|---|---|
| External API (anticipated, not designed) | ACL | Not designed | None yet | The app is expected to call an external API at some point. Which API, and what Finance needs from it, is open. |

### Inbound dependents (known)

None. Nothing outside the app reads Finance's data.
