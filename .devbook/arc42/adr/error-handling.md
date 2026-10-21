# Error Handling

```meta
status: proposed
date: 2026-10-08
related: [.devbook/arc42/05-building-block-view.md#level-1, .devbook/arc42/adr/modularity.md, .devbook/arc42/08-crosscutting-concepts.md#persistence]
```

An expected outcome crosses the application boundary as a `Result` or `Result<T>`, carrying a
success flag, an optional value, an error code, and a message. An unexpected technical fault
stays an exception. The Razor components in `Finance.UI` turn a failed `Result` into a message
for the user.

```annotation
kind: question
author: "claude/chapter-review"
date: 2026-10-21
quote: "An expected outcome crosses the application boundary"
body: |
  [major] Which project is the application boundary? 05 Level 1 has Finance.Desktop, Finance.UI, Finance.Domain, and Finance.Storage and no application layer; 08 User Interface puts a small UI service per feature in Finance.UI. Name where Result and Result<T> are defined (presumably Finance.Domain), whether the store port in Finance.Domain returns Result or throws, and which code does the domain-exception-to-Result translation the Why section mentions.
```

## Why

```meta
```

- A rule the user can break, such as an invalid amount, is a normal outcome and not a fault.
  A `Result` makes that outcome part of the method's signature, so the caller cannot overlook it.
- Tests assert on a returned value instead of catching an exception, which keeps the success
  and failure paths equally easy to test.
- `Finance.Domain` still enforces its invariants internally. Where it throws a domain exception,
  the application code translates it into a failed `Result` before it reaches the UI.
- A technical fault stays an exception because no caller can handle it as a business outcome.
  Examples are a read or write that fails, a file that does not deserialize, a data file that
  OneDrive has locked, and a conflict copy OneDrive has made.
- The error code is machine-readable, so the UI picks its message from the code and never
  parses the text.

```annotation
kind: flag
author: "claude/chapter-review"
date: 2026-10-21
quote: "a conflict copy OneDrive has made"
body: |
  [major] These two are not faults no caller can handle: 11. Risks and Technical Debt R1 and R2 plan to detect conflict copies on load and to report a clear error when a file cannot be read, which are expected, user-actionable outcomes the UI must word specifically. By this record a specific message comes only from a Result error code, so classifying them as exceptions contradicts R1/R2. Either move OneDrive lock, online-only placeholder, and conflict copy into Result with their own codes, or say how an exception reaches the user with a specific message.
```

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "The error code is machine-readable"
body: |
  [minor] Gap: the record says what a failed Result becomes, but not where a technical-fault exception is caught and what the user sees (a Blazor ErrorBoundary, a MAUI unhandled-exception handler, a restart prompt), nor where it is logged in production (open as 11 O5). 08 User Interface defers to this record for how a failure shows. Add the fault path.
```

## Rejected

```meta
```

| Alternative | Why it lost |
| --- | --- |
| Exceptions for every failure | An expected rule failure then looks like a crash, the contract is invisible in the signature, and tests must catch instead of assert. |
| A third-party library such as FluentResults, ErrorOr, or OneOf | The shape Finance needs is a pair of small records. A dependency adds an upgrade to track for no capability Finance uses. |
| Error codes only, with no value or message | The caller then needs a second channel for the value, and every screen must map every code to text on its own. |

## History

```meta
```

| Date | Change |
| --- | --- |
| 2026-10-08 | Proposed: `Result` and `Result<T>` for expected outcomes, exceptions for technical faults, and the UI mapping a failed `Result` to a message, adopted from the organization's [ADR 0004](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/adrs/0004-standardize-result-objects-for-expected-failures.md). |

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "| Date | Change |"
body: |
  [minor] The History table is headed Date | Change, but devbook-arc42.md fixes the header as Date | Change | Why, and build.mjs --check warns on it. Split the row's reason into its own Why column (here: adopted from the organization's ADR 0004 is the why).
```
