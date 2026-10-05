# 10. Quality Requirements

```meta
status: draft
related: [.devbook/arc42/01-introduction-and-goals.md#quality-goals]
```

These scenarios make the quality goals from chapter 1 testable. The targets are first guesses
and get revisited once real data exists.

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
