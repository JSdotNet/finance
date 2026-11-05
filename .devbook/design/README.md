# Design

```meta
index: root
related: [.devbook/arc42/02-constraints.md#technical-constraints, .devbook/arc42/04-solution-strategy.md#local-first-desktop-application]
```

> `.devbook/design/` holds the UX and visual design guidelines for Finance: how the product
> looks and behaves for the one person who uses it. It complements `.devbook/arc42/`, which
> says how Finance is built, and `.devbook/domain/`, which says what Finance is about. This
> folder holds guidelines, the demo template, and one product demo. Wireframes, user flows,
> and other prototypes live outside it.

## Purpose

```meta
```

Finance is one Windows desktop application. It is .NET MAUI Blazor Hybrid: a native MAUI
window that renders its whole UI as Razor components inside WebView2, Microsoft's embedded
Chromium browser control. The stack itself is recorded in
[the desktop stack record](../arc42/adr/desktop-stack.md). These files set the binding,
testable rules that keep every screen of it consistent:

- one set of **design tokens**, declared in `color-scheme.md` and `typography-and-layout.md`,
- consistent **typography, spacing, and layout**, including how amounts of money are set,
- consistent **interaction behavior**: auto-save, keyboard alternatives, feedback, and motion,
- one **accessibility** target, WCAG 2.2 Level AA,
- a **component-library** recommendation with its rationale,
- the **app icon**, specified in `color-scheme.md#app-icon` and drawn in `assets/`.

The domain is not modelled yet, so no chapter here describes a Finance screen. The rules
are written for the components every screen will be built from.

## Headline Principles

```meta
```

Two product-level decisions override defaults everywhere. Every screen and component honors
them.

| # | Principle | What it means | Detailed in |
|---|---|---|---|
| 1 | **One light theme** | The Finance App Design's light theme, with a dark navigation sidebar. There is no dark theme and no theme toggle. | `design-principles.md#one-light-theme`, `color-scheme.md` |
| 2 | **No save buttons** | Every edit saves automatically. There is no Save affordance anywhere. A save-state indicator says what has been written. | `interaction-guidelines.md#auto-save` |

## How to Use This Folder

```meta
```

- Treat every rule marked **MUST** or **MUST NOT** as an acceptance criterion for design
  review. **SHOULD** marks a default that needs a reason to break.
- Before building a screen or component, read `color-scheme.md`,
  `typography-and-layout.md`, and `interaction-guidelines.md`. They settle most decisions.
- Token names are canonical. Product code references a token by name, such as
  `color-primary`, and never by its hex value. Only `color-scheme.md` and
  `typography-and-layout.md` declare token values. Every other file names tokens.
- A decision these files have not settled is marked `[TODO: clarify]`. Resolve it before the
  area it governs ships.

## Index

```meta
```

| File | Scope |
|---|---|
| [`design-principles.md`](design-principles.md) | Product-level UX principles: one light theme, local-first UX, no save buttons, keyboard-first, low chrome, exact amounts. |
| [`color-scheme.md`](color-scheme.md) | The Finance App Design's light palette and sidebar tokens, amount and change tokens, badge pills, chart roles, measured contrast and its known gaps, elevation, the token mapping, the board-to-token mapping, the icon's brand ramp, and the app icon. |
| [`typography-and-layout.md`](typography-and-layout.md) | Fonts, type scale, spacing, density, layout, radius, shadows, z-index, iconography, metadata lines, how amounts are set, and the Finance App Design's type and spacing. |
| [`interaction-guidelines.md`](interaction-guidelines.md) | Auto-save, undo, reordering with keyboard equivalents, entering amounts, feedback, motion, focus and selection, and empty, loading, and error states. |
| [`accessibility.md`](accessibility.md) | The WCAG 2.2 AA target, keyboard navigation, announcements, focus visibility, Windows contrast themes, reduced motion, and target sizes. |
| [`component-libraries.md`](component-libraries.md) | The component-library recommendation for the desktop app, with a comparison and the known gaps. |

[`demo-template.html`](demo-template.html) is the template every demo of a Finance screen is
built on, styled by the tokens above. It is not a chapter and has no reading position.

[`finance-app.demo.html`](finance-app.demo.html) is the Finance App Design as a click demo on
that template: Kasboek's eleven screens in the tokens above, with a flat and a grouped
navigation variant. Its names, dates, quantities, and figures are made up at a real ledger's
density, so its totals do not add up. It is not a chapter either; the Provenance chapter names
it.

The app icon's source files sit in [`assets/`](assets/): `app-icon-background.svg` and
`app-icon-foreground.svg` are the two layers the app builds from, and `app-icon.svg` is the
two composed into one picture.

## Provenance

```meta
demo: [.devbook/design/finance-app.demo.html]
```

This design system is adapted from the design folder of Backlog, the sibling desktop app by
the same author, on 2026-10-06. Backlog's own tokens came from the JSdotNet design style
guide. The user's brief was that Finance looks the same as Backlog, with three changes:

- The primary colour is a money green instead of Backlog's gold.
- The other colours are adjusted to sit with that green.
- The app icon is the euro sign.

Everything else is Backlog's system, with what Finance does not have taken out. Finance has
one channel, so the mobile, IDE, and cloud guidance went. These features are specific to
Backlog, so they went too:

- Markdown editing.
- Entries.
- Tasks.
- Roadmaps.
- AI surfaces.
- Repository colours.
- Sync states.
- The code theme.

Backlog's `content-editing.md` had nothing left once its Markdown editor was removed, so
Finance has no such file.

Finance started dark mode only, like Backlog, by the user's decision of 2026-10-06. On
2026-10-22 the user made the Finance App Design leading, and its light theme replaced the dark
one. Backlog's token names and rules stayed; the values are the design's.

There is no sync back to Backlog. A change here is a change to Finance's design language
alone.

**The Finance App Design.** The second source is the Finance App Design artifact,
<https://claude.ai/artifact/S2W8WmGhUZxLkAq2Yhg8WQ>, dated 2026-10-08. It holds eleven screen
boards of the product:

- Overview.
- Income and expenses.
- Inflation.
- Subscriptions.
- Debts and loans.
- Pension.
- Savings goals.
- Investments.
- Crypto.
- Bruto to netto.
- Energy and EV charging.

Each board carries its own inline CSS and no token set. On 2026-10-21 that CSS was compared
with the tokens here, and every value the boards use was given a token:

- **Type** follows the artifact: Hanken Grotesk and IBM Plex Mono replace Backlog's fonts,
  and the heading ramp is the artifact's compact one.
- **Spacing and radius** map onto the existing scales, with one added step, `spacing-ms`.
- **Colour** is the boards' own. Since 2026-10-22 every token holds the board value it maps
  to, the dark navigation sidebar has tokens of its own, and the pills keep their fills and
  inks.

Each value and the token it lands on is listed in `color-scheme.md#finance-app-design-mapping`
and `typography-and-layout.md#finance-app-design-mapping`. The artifact leads: where it and a
rule here disagree, the rule changes. Where the artifact misses an accessibility threshold,
`color-scheme.md#contrast-rules` records the gap for the user to settle.

## Metadata

```meta
```

Metadata follows `.agents/rules/devbook-chapter-metadata.md` and
`.agents/rules/devbook-design.md`. A merged chapter is in force and carries no `status`. A
guideline still being written is an open change under `openspec/changes/`, not a chapter here.
A guideline that no longer applies is removed by a change's `REMOVED` delta.

The user agreed the light palette, the amount rules, and the app icon on 2026-11-05.

The empty `meta` fence under a heading stays, because it makes the heading an addressable
chapter.
