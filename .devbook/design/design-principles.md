# Design Principles

```meta
related: [.devbook/arc42/04-solution-strategy.md#local-first-desktop-application, .devbook/design/interaction-guidelines.md, .devbook/design/accessibility.md]
```

> These are the high-level rules every screen honors. The other files in `.devbook/design/`
> turn them into tokens and interaction specifications. They are adapted from Backlog's
> design principles, which in turn drew on the JSdotNet design style guide.

Each principle lists testable rules. Treat every MUST and MUST NOT as a design review
acceptance criterion.

## One Light Theme

```meta
related: [.devbook/design/color-scheme.md#palette, .devbook/design/color-scheme.md#per-stack-token-mapping, .devbook/design/README.md#provenance]
```

| Rule | Requirement |
|---|---|
| Single theme | Finance MUST render only the light palette defined in `color-scheme.md`, the Finance App Design's. |
| No toggle | There MUST NOT be a light or dark switch anywhere in settings or chrome. Finance does not follow the Windows app mode. |
| Dark sidebar | The navigation sidebar is the one dark surface. It MUST use the `color-nav-*` tokens and no others. |
| No literals | Components MUST NOT hard-code a colour. They MUST reference palette token names. |
| Media | Images and charts MUST be authored for the light ground and white cards. A chart takes its colours from `color-scheme.md#chart-roles`. |
| Flat cards | A card is a white surface with a `color-divider` edge and no shadow. Only a surface floating above the page carries one. See `color-scheme.md#elevation-by-color`. |

Rationale: the Finance App Design is drawn light, and on 2026-10-22 the user made the design
leading over this folder, replacing the dark theme carried over from Backlog. A single theme
still removes a whole class of theming bugs. Windows contrast themes still apply, because they
are an accessibility setting rather than a theme choice. See
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
| No sync state | Finance MUST NOT show a sync or online status of its own. |
| Optimistic UI | An edit MUST show in the UI at once and be written to the local file straight after. |
| No silent loss | A write that fails MUST be shown to the user and MUST NOT be dropped quietly. See `interaction-guidelines.md#optimistic-ui`. |

- **No sync state:** Finance does not replicate data, and OneDrive's own client does. A sync status would describe work Finance does not do.

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
| Minimal persistent chrome | Toolbars and rails MUST be minimal. |
| Contextual affordances | Prefer contextual and on-demand affordances over always-visible rows of buttons. |
| No redundant controls | Because there are no save buttons, toolbars MUST NOT bring back a save or commit affordance. |
| Content contrast first | The highest-contrast text token, `color-text-primary`, is for content. Chrome uses `color-text-secondary`. |
| Progressive disclosure | Advanced actions SHOULD appear on focus or through the command surface rather than permanently. |
| Density | Default to a comfortable but compact density. See `typography-and-layout.md#density`. |

## Exact Amounts

```meta
related: [.devbook/design/typography-and-layout.md#amounts, .devbook/design/color-scheme.md#amount-tokens, .devbook/design/interaction-guidelines.md#entering-amounts]
```

Finance shows money. A reader must be able to trust a figure at a glance and compare it with
the figures around it.

| Rule | Requirement |
|---|---|
| Exact by default | An amount MUST be shown to the cent wherever it is the subject. |
| Rounded figure | A rounded figure, such as "€ 1.2k", MAY appear only where the exact one is one step away. |
| Sign in text | Whether an amount is money in or money out MUST be readable from its sign alone. |
| Colour | Colour adds to the sign and never replaces it. |
| Comparable | Amounts in a column MUST line up digit under digit. See `typography-and-layout.md#amounts`. |
| One format | Every amount in the product MUST use the one format in `typography-and-layout.md#amounts`. |
| Own formatting | A component MUST NOT format money its own way. |
