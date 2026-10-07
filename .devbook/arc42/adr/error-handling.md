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
