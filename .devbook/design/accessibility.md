# Accessibility

```meta
related: [.devbook/design/color-scheme.md#contrast-rules, .devbook/design/interaction-guidelines.md, .devbook/design/design-principles.md#keyboard-first]
```

> Finance targets **WCAG 2.2 Level AA** as a minimum. It is dark mode only, keyboard-first,
> and has no save buttons, so this file concentrates on keyboard operation, save-state and
> amount announcements, focus visibility, Windows contrast themes, and reduced motion. Adapted from Backlog's `accessibility.md`.

## Target and Scope

```meta
```

| Rule | Requirement |
|---|---|
| Conformance | Finance MUST meet **WCAG 2.2 AA**. Primary body text targets AAA contrast. See `color-scheme.md#contrast-rules`. |
| Platform semantics | The UI is Razor in WebView2, so the content uses ARIA. The native MAUI window and title bar use UI Automation through `AutomationProperties`. |
| Parity | Anything a mouse can do, the keyboard and a screen reader MUST be able to do. |
| Testable | Each rule below is a review acceptance criterion. |

## Contrast

```meta
related: [.devbook/design/color-scheme.md#contrast-rules, .devbook/design/color-scheme.md#measured-pairs]
```

The pairings and their measured ratios are in `color-scheme.md#measured-pairs`. The binding
minimums are these:

| Content | Minimum |
|---|---|
| Primary body text (`color-text-primary` on `color-background`) | 7:1 (AAA target) |
| Secondary text, status text, links, amounts | 4.5:1 |
| Text on a semantic surface | 4.5:1 |
| Large text (24 px and up, or 18.66 px bold and up) | 3:1 |
| Focus ring, control borders, icons, chart marks | 3:1 (non-text) |

- `color-text-disabled` and `color-divider` are exempt.
- Colour MUST NOT be the only way information is conveyed. Pair it with text, an icon, a
  sign, or shape. An amount's direction is carried by its `+` or `−` sign.

## Keyboard Navigation

```meta
related: [.devbook/design/design-principles.md#keyboard-first, .devbook/design/interaction-guidelines.md#keyboard-accessible-reordering]
```

| Rule | Requirement |
|---|---|
| Full operability | Every interactive element and command MUST work from the keyboard alone, with no keyboard traps. A modal's focus trap releases when it closes. |
| Logical order | Tab order MUST follow visual reading order. |
| Standard keys | Enter and Space activate. Escape closes menus and dialogs and cancels a reorder in progress. Arrow keys move within composite widgets such as menus, tabs, lists, and grids. |
| Reorder | Reordering MUST be possible from the keyboard. See `interaction-guidelines.md#keyboard-accessible-reordering`. |
| Tables | In a data table, arrow keys SHOULD move between cells, and a row's actions MUST be reachable without a pointer. |
| Shortcuts | Shortcuts MUST be discoverable through the command palette, and MUST NOT override Windows or assistive-technology shortcuts. |
| Custom controls | An element that is not natively focusable but becomes interactive MUST get `tabindex="0"` and a visible focus style. |

## Screen Reader Announcements

```meta
related: [.devbook/design/interaction-guidelines.md#save-state-indicator-vocabulary]
```

| Rule | Requirement |
|---|---|
| Names and roles | Every control MUST expose an accessible name, role, and state. An icon-only control MUST have an explicit label. See `#iconography-accessibility`. |
| Live regions | A transient status MUST be announced through a live region, without moving focus. |

### Save-State Announcements

```meta
```

The save-state indicator is not a button, so its state is announced.

| State | Announcement | Politeness |
|---|---|---|
| Saving | "Saving", debounced so continuous typing does not repeat it | polite (`role="status"`) |
| Saved | "All changes saved" | polite |
| Failed | "Couldn't save your last change." and a focusable Retry control | assertive (`role="alert"`) |

Routine Saving and Saved transitions MUST be throttled so a screen reader is not flooded
while the user types.

### Reorder Announcements

```meta
```

| Event | Announcement |
|---|---|
| Pick up | "Grabbed [item name]. Use arrow keys to move, Space to drop, Escape to cancel." |
| Move | "Moved to position 3 of 8." |
| Drop | "Dropped [item name] at position 3 of 8." |
| Cancel | "Move cancelled. [item name] returned to position 5." |

Reorder announcements use an assertive live region while an item is picked up.

### Amount Announcements

```meta
status: draft
related: [.devbook/design/typography-and-layout.md#amounts]
```

| Rule | Requirement |
|---|---|
| Sign is spoken | An amount with a direction MUST spell that direction as a word in its accessible text, "plus" or "minus", with the visible sign hidden from assistive technology. A screen reader's punctuation setting can drop a symbol, but not a word. |
| Currency is spoken | Where the visible `€` moved to a column header, the cell's accessible text MUST still include the currency, or the header MUST be associated with the cell. |
| Colour is not spoken | A flagged amount MUST say why in text, such as "below zero", because its red colour reaches no screen reader. |
| Charts | A chart MUST have a text alternative that gives the same figures, such as a table next to it or behind a toggle. |

## Focus Visibility

```meta
related: [.devbook/design/interaction-guidelines.md#focus-and-selection]
```

| Rule | Requirement |
|---|---|
| Always visible | Keyboard focus MUST always be visible. `outline: none` without a compliant replacement is prohibited. |
| Style | Focus uses a `color-border-focus` outline at `border-width-2` with a 2 px offset. Use `outline`, not a shadow alone, so it survives Windows contrast themes. |
| Contrast | The focus indicator MUST reach 3:1 against the surface beside it. |
| Not obscured | A focused element MUST NOT be hidden behind a sticky header, a toast, or a drawer, per WCAG 2.2 criterion 2.4.11. |
| Restore | Closing a modal or drawer MUST return focus to its trigger. After a keyboard reorder, focus MUST stay on the moved item. |
| Distinct states | Focus, hover, and selection MUST look different from each other. |

## Windows Contrast Themes

```meta
status: draft
related: [.devbook/design/design-principles.md#dark-mode-only]
```

Windows contrast themes replace Finance's dark palette with the user's system colours, and
WebView2 reports them through `forced-colors: active`. This is the one case where Finance
does not render its own palette, and `design-principles.md#dark-mode-only` allows it: a
contrast theme is an accessibility setting, not a theme choice.

| Rule | Requirement |
|---|---|
| Stays usable | Every screen MUST stay usable with a contrast theme on. |
| Let the system colour | Finance MUST NOT fight forced colours with `forced-color-adjust: none`, except on the app icon and on a chart, which MUST then draw with system colour keywords. |
| Boundaries stay visible | Controls that rely on a background fill for their shape MUST also have a border, so they keep a boundary when the fill is replaced. |
| Meaning survives | Amount direction, status, and selection already have text, signs, or shape beside their colour, so they survive. A new component MUST keep that property. |

## Reduced Motion

```meta
related: [.devbook/design/interaction-guidelines.md#motion-and-reduced-motion]
```

| Rule | Requirement |
|---|---|
| Honor the setting | Finance MUST honor `prefers-reduced-motion`. WebView2 reports it from the Windows setting "Animation effects". |
| Degrade gracefully | Under reduced motion there is no translate, scale, rotate, or slide. Use instant changes or opacity-only fades. Spinners show a static state and skeletons stop pulsing. |
| Function stays | Reduced motion MUST NOT remove a function. Autoscroll, reorder, and save feedback still work, without decorative motion. |

## Target Sizes and Text

```meta
related: [.devbook/design/typography-and-layout.md#iconography]
```

| Rule | Requirement |
|---|---|
| Targets | Interactive targets MUST be at least 44 × 44 px, including icon-only buttons and drag handles. WCAG 2.2 criterion 2.5.8 asks for 24 × 24 px at AA. Finance keeps Backlog's stricter 44 px. |
| Spacing | Adjacent targets MUST be far enough apart to prevent mis-activation. Use the spacing scale. |
| Minimum text | Readable text MUST NOT be smaller than `font-size-sm` (14 px). |
| Respect scaling | Use `rem` so Windows text scaling and zoom are respected. Layouts MUST reflow without loss of content up to 200% zoom. |
| Not by style alone | Do not convey meaning by weight, italic, or colour alone. Pair it with text or an icon. |

## Iconography Accessibility

```meta
related: [.devbook/design/typography-and-layout.md#iconography]
```

| Element | Requirement |
|---|---|
| Icon-only button or link | MUST have an accessible name, through `aria-label`, or `AutomationProperties.Name` in the native shell. |
| Meaningful standalone icon | Provide a text alternative, such as `role="img"` with a title. |
| Decorative icon | MUST be hidden from assistive technology with `aria-hidden="true"` and `focusable="false"`. |
| Icon with a visible label | Hide the icon from assistive technology, so the label is not read twice. |
| Colour | Icon colour MUST meet 3:1 and MUST NOT be the only carrier of meaning. |

## Verification

```meta
```

| Check | How |
|---|---|
| Automated | Run an axe-core scan in the Playwright end-to-end suite. |
| Manual | Check with Accessibility Insights for Windows, with Narrator, and with a Windows contrast theme on. |
| Native shell | Check the MAUI window and title bar with Accessibility Insights, since axe does not reach them. |

`[TODO: clarify]` Which screen readers are in the test matrix. Narrator is the default,
because it ships with Windows.
