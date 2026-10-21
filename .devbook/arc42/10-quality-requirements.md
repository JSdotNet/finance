# 10. Quality Requirements

```meta
status: draft
related: [.devbook/arc42/01-introduction-and-goals.md#quality-goals]
```

These scenarios make the quality goals from chapter 1 testable. The targets are first guesses
and get revisited once real data exists.

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "These scenarios make the quality goals from chapter 1 testable."
body: |
  [minor] The Goal column does not map onto the five goals in 01#quality-goals. Responsiveness and Isolation are not chapter 1 goals. Goal 5, Low operating cost, has no scenario. The two risks most likely to break goals 1 and 2, 11 R1 (conflict copy or stale data from a second PC) and R2 (online-only placeholder), have no scenario either. Settle: key each row to a chapter 1 goal number, add a row for goal 5 and for R1 and R2 (for example, a conflict copy present on load is reported and nothing is overwritten), or add Responsiveness to chapter 1.
```

## Quality Scenarios

```meta
status: draft
```

| # | Goal | Scenario | Target |
| --- | --- | --- | --- |
| Q1 | Availability | The PC has no network. ME starts Finance and edits records. | Every workflow succeeds, and no network call is made. |
| Q2 | Durability | The process is killed in the middle of a save. | On restart every file is either the old or the new version, and each one parses. |
| Q3 | Durability | A file has a newer `schemaVersion` than the running build knows. | Finance refuses to load and overwrites nothing. |
| Q4 | Ownership | ME opens a file from the data folder in a text editor. | The content is readable, indented JSON. |
| Q5 | Privacy | All network traffic of Finance is inspected during normal use. | Finance itself sends nothing. Only the OneDrive client moves the files. |
| Q6 | Responsiveness | Finance starts with several years of personal records. | The main view is usable within about two seconds. |
| Q7 | Responsiveness | ME saves a change. | The UI confirms the save within about 200 ms, whatever OneDrive's state. |
| Q8 | Testability | A developer runs the end-to-end suite. | The AppHost starts Finance against a test data folder, and Playwright drives it with no manual step. |
| Q9 | Isolation | Tests and development runs execute. | The real data folder is never read or written. |

```annotation
kind: flag
author: "claude/chapter-review"
date: 2026-10-21
quote: "The UI confirms the save within about 200 ms"
body: |
  [major] Q7 conflicts with design/interaction-guidelines.md#auto-save. Finance has no manual save ("There MUST NOT be a Save button"). A text edit saves 500 to 1000 ms after the last keystroke (750 ms by default), and the UI shows the change before the write ("Order" and "Optimistic UI"). So "ME saves a change" never happens, and a 200 ms confirmation has no start event that fits the debounce. Settle: rewrite Q7 against the auto-save states. For example, the UI shows the edit at once, and once the edit settles the indicator reaches Saved within N ms whatever OneDrive is doing, or Failed within about 5 s.
```

```annotation
author: "claude/chapter-review"
date: 2026-10-21
quote: "On restart every file is either the old or the new version, and each one parses."
body: |
  [minor] The target is per file, so it passes even when a change that spans two files is half written: each file parses, but the records disagree (see the question on 08#persistence). Settle: add "and the records load as one consistent state", or record that a change never spans files.
```
