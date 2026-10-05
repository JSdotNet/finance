# Design Principles

```meta
related: [.devbook/arc42/04-solution-strategy.md#local-first-desktop-application, .devbook/design/interaction-guidelines.md, .devbook/design/accessibility.md]
```

> These are the high-level rules every screen honors. The other files in `.devbook/design/`
> turn them into tokens and interaction specifications. They are adapted from Backlog's
> design principles, which in turn drew on the JSdotNet design style guide.

Each principle lists testable rules. Treat every MUST and MUST NOT as a design review
acceptance criterion.

## Dark Mode Only

```meta
related: [.devbook/design/color-scheme.md#dark-palette, .devbook/design/color-scheme.md#per-stack-token-mapping]
```

Finance ships a single dark theme, as Backlog does. There is no light theme and no theme
toggle.

| Rule | Requirement |
|---|---|
| Single theme | Finance MUST render only the dark palette defined in `color-scheme.md`. |
| No toggle | There MUST NOT be a light or dark switch anywhere in settings or chrome. Finance does not follow the Windows app mode. |
| No light assumptions | Components MUST NOT hard-code white fills, black text, or any other light-theme colour. They MUST reference palette token names. |
| Media | Images and charts MUST be authored for dark surfaces, with no glaring white blocks. A chart takes its colours from `color-scheme.md#chart-roles`. |
| Elevation by colour | Elevation MUST be shown mainly by raised surface tokens, not heavy shadows. See `color-scheme.md#elevation-by-color`. |

Rationale: one dark surface is easy on the eyes in long sessions, and a single theme removes
a whole class of theming bugs. It also keeps Finance's design language identical to
Backlog's, which was the user's brief. Windows contrast themes still apply, because they are
an accessibility setting rather than a theme choice. See
`accessibility.md#windows-contrast-themes`.

## Local-First UX

```meta
related: [.devbook/arc42/04-solution-strategy.md#local-first-desktop-application, .devbook/arc42/08-crosscutting-concepts.md#persistence]
```

Finance is local-first. Its records are JSON files in the user's own data folder, and no
workflow needs a network.

| Rule | Requirement |
|---|---|
| Never gate on network | Every workflow MUST work with no network connection. |
| No sync state | Finance does not replicate data. OneDrive's own client does. Finance MUST NOT show a sync or online status of its own, because it would describe work Finance does not do. |
| Optimistic UI | An edit MUST show in the UI at once and be written to the local file straight after. |
| No silent loss | A write that fails MUST be shown to the user and MUST NOT be dropped quietly. See `interaction-guidelines.md#optimistic-ui`. |

## No Save Buttons

```meta
related: [.devbook/design/interaction-guidelines.md#auto-save]
```

Every change is saved automatically. There is no manual save.

| Rule | Requirement |
|---|---|
| No save affordance | There MUST NOT be a Save button, menu item, or save-only keyboard gesture anywhere in the product. |
| Continuous persistence | Every edit MUST save automatically. Timing, the indicator, and failure handling are in `interaction-guidelines.md#auto-save`. |
| Visible save state | The current save state (saving, saved, failed) MUST be visible without the user doing anything. |

## Keyboard-First

```meta
related: [.devbook/design/accessibility.md#keyboard-navigation, .devbook/design/interaction-guidelines.md#keyboard-accessible-reordering]
```

Finance is built to be driven from the keyboard. The pointer is an accelerator, not a
requirement.

| Rule | Requirement |
|---|---|
| Everything reachable | Every interactive element and every command MUST be operable from the keyboard alone. |
| Drag has a keyboard path | Every drag-and-drop action MUST have a documented keyboard equivalent. See `interaction-guidelines.md#keyboard-accessible-reordering`. |
| Command surface | Primary actions SHOULD be reachable through a command palette rather than only through buttons in the chrome. |
| Visible focus | Keyboard focus MUST always be visible, using `color-border-focus` at `border-width-2`. See `accessibility.md#focus-visibility`. |
| Logical order | Tab order MUST follow reading order. Only modals and drawers trap focus. |

## Low-Chrome, Content-First

```meta
```

The chrome recedes so the user's own figures are the main surface.

| Rule | Requirement |
|---|---|
| Minimal persistent chrome | Toolbars and rails MUST be minimal. Prefer contextual and on-demand affordances over rows of buttons that are always visible. |
| No redundant controls | Because there are no save buttons, toolbars MUST NOT bring back a save or commit affordance. |
| Content contrast first | The highest-contrast text token, `color-text-primary`, is for content. Chrome uses `color-text-secondary`. |
| Progressive disclosure | Advanced actions SHOULD appear on focus or through the command surface rather than permanently. |
| Density | Default to a comfortable but compact density. See `typography-and-layout.md#density`. |

## Exact Amounts

```meta
status: draft
related: [.devbook/design/typography-and-layout.md#amounts, .devbook/design/color-scheme.md#amount-tokens, .devbook/design/interaction-guidelines.md#entering-amounts]
```

Finance shows money. A reader must be able to trust a figure at a glance and compare it with
the figures around it.

| Rule | Requirement |
|---|---|
| Exact by default | An amount MUST be shown to the cent wherever it is the subject. A rounded figure, such as "€ 1.2k", MAY appear only where the exact one is one step away. |
| Sign in text | Whether an amount is money in or money out MUST be readable from its sign alone. Colour adds to the sign and never replaces it. |
| Comparable | Amounts in a column MUST line up digit under digit. See `typography-and-layout.md#amounts`. |
| One format | Every amount in the product MUST use the one format in `typography-and-layout.md#amounts`. A component MUST NOT format money its own way. |
