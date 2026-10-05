# 06. Runtime View

```meta
status: draft
related: [.devbook/arc42/05-building-block-view.md]
```

Four scenarios show how the building blocks from chapter 5 work together at run time.

## Start and Load

```meta
status: draft
related: [.devbook/arc42/05-building-block-view.md#level-1, .devbook/arc42/08-crosscutting-concepts.md#configuration]
```

```mermaid
sequenceDiagram
    actor ME
    participant Desktop as Finance.Desktop
    participant Storage as Finance.Storage
    participant Folder as Data folder
    participant UI as Finance.UI

    ME->>Desktop: Start Finance
    Desktop->>Desktop: Read data folder path from local settings
    alt No data folder configured
        Desktop->>UI: Ask ME to choose a folder
        UI-->>Desktop: Chosen folder
    end
    Desktop->>Storage: Load all records
    Storage->>Folder: Read JSON files
    Folder-->>Storage: File contents
    Storage->>Storage: Check schema version, migrate in memory if older
    Storage-->>Desktop: finance model in memory
    Desktop->>UI: Render
```

Finance loads every record into memory at start. A single person's finance records stay
small enough for that, and it keeps every later read local and instant. A file with a newer
schema version than the application knows stops the load with a message, so an old build
never overwrites data written by a newer one.

## Save a Change

```meta
status: draft
related: [.devbook/arc42/adr/storage.md, .devbook/arc42/08-crosscutting-concepts.md#persistence]
```

```mermaid
sequenceDiagram
    actor ME
    participant UI as Finance.UI
    participant Domain as Finance.Domain
    participant Storage as Finance.Storage
    participant Folder as Data folder
    participant OneDrive as OneDrive client

    ME->>UI: Edit a record
    UI->>Domain: Apply the change
    Domain->>Domain: Enforce the model's rules
    Domain-->>UI: Accepted, or refused with a reason
    UI->>Storage: Save the affected file
    Storage->>Folder: Write a temporary file beside it
    Storage->>Folder: Replace the original with the temporary file
    Storage-->>UI: Saved
    OneDrive->>Folder: Notice the changed file
    OneDrive->>OneDrive: Upload in the background
```

The model refuses an invalid change before anything touches disk. The replace step is what
makes a write atomic: a crash leaves either the old file or the new one, never half of each.
Finance does not wait for OneDrive, and works the same when OneDrive is offline or paused.

## Continue on Another PC

```meta
status: draft
related: [.devbook/arc42/07-deployment-view.md#production, .devbook/arc42/11-risks-and-technical-debt.md#risks]
```

```mermaid
sequenceDiagram
    actor ME
    participant A as Finance on PC A
    participant Cloud as OneDrive
    participant B as Finance on PC B

    ME->>A: Make changes, then close Finance
    A->>Cloud: OneDrive client uploads the changed files
    Cloud->>B: OneDrive client downloads them
    ME->>B: Start Finance
    B->>B: Start and Load reads the current files
```

The hand-over works when Finance runs on one PC at a time and OneDrive has finished syncing.
Running it on two PCs at once, or starting before a download completes, can produce an
OneDrive conflict copy or stale data. [11. Risks and Technical Debt](11-risks-and-technical-debt.md#risks)
tracks that.

## Development Run with Playwright

```meta
status: draft
related: [.devbook/arc42/07-deployment-view.md#development, .devbook/arc42/adr/desktop-stack.md]
```

```mermaid
sequenceDiagram
    actor Dev as Developer
    participant AppHost as Finance.AppHost
    participant Desktop as Finance.Desktop
    participant Dash as Aspire dashboard
    participant PW as Playwright

    Dev->>AppHost: Start the AppHost
    AppHost->>Desktop: Launch with a test data folder and a WebView2 debugging port
    Desktop->>Dash: Logs and traces over OTLP
    Dev->>PW: Run the end-to-end tests
    PW->>Desktop: Connect over CDP to WebView2
    PW->>Desktop: Drive the UI through data-testid selectors
    PW-->>Dev: Results and captures
```

OTLP is the OpenTelemetry protocol, and CDP is the Chrome DevTools Protocol that WebView2
exposes. A test run points Finance at a throwaway data folder, never at the real OneDrive one.
