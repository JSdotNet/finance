# Design

```meta
index: root
related: [.devbook/arc42/02-constraints.md#technical-constraints, .devbook/arc42/04-solution-strategy.md#local-first-desktop-application]
```

> `.devbook/design/` holds the UX and visual design guidelines for Finance: how the product
> looks and behaves for the one person who uses it. It complements `.devbook/arc42/`, which
> says how Finance is built, and `.devbook/domain/`, which says what Finance is about. This
> folder holds guidelines only. Wireframes, user flows, and prototypes live outside it.

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
| 1 | **Dark mode only** | There is no light theme and no theme toggle, as in Backlog. Every palette, contrast, and elevation rule is written for dark surfaces only. | `design-principles.md#dark-mode-only`, `color-scheme.md` |
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
| [`design-principles.md`](design-principles.md) | Product-level UX principles: dark mode only, local-first UX, no save buttons, keyboard-first, low chrome, exact amounts. |
| [`color-scheme.md`](color-scheme.md) | The money-green primary ramp, the dark palette, amount tokens, badge tones, chart roles, measured contrast, elevation, the token mapping, and the app icon. |
| [`typography-and-layout.md`](typography-and-layout.md) | Fonts, type scale, spacing, density, layout, radius, shadows, z-index, iconography, metadata lines, and how amounts are set. |
| [`interaction-guidelines.md`](interaction-guidelines.md) | Auto-save, undo, reordering with keyboard equivalents, entering amounts, feedback, motion, focus and selection, and empty, loading, and error states. |
| [`accessibility.md`](accessibility.md) | The WCAG 2.2 AA target, keyboard navigation, announcements, focus visibility, Windows contrast themes, reduced motion, and target sizes. |
| [`component-libraries.md`](component-libraries.md) | The component-library recommendation for the desktop app, with a comparison and the known gaps. |

The app icon's source files sit in [`assets/`](assets/): `app-icon-background.svg` and
`app-icon-foreground.svg` are the two layers the app builds from, and `app-icon.svg` is the
two composed into one picture.

## Provenance

```meta
status: draft
```

This design system is adapted from the design folder of Backlog, the sibling desktop app by
the same author, on 2026-10-06. Backlog's own tokens came from the JSdotNet design style
guide. The user's brief was that Finance looks the same as Backlog, with three changes:

- The primary colour is a money green instead of Backlog's gold.
- The other colours are adjusted to sit with that green.
- The app icon is the euro sign.

Everything else is Backlog's system, with what Finance does not have taken out. Finance has
one channel, so the mobile, IDE, and cloud guidance went. Backlog's Markdown editing,
entries, tasks, roadmaps, AI surfaces, repository colours, sync states, and code theme are
specific to Backlog, so they went too. Backlog's `content-editing.md` had nothing left once
its Markdown editor was removed, so Finance has no such file.

Finance is dark mode only, like Backlog. The user decided this on 2026-10-06, after a draft
with a light theme as well.

One change goes beyond the brief. Backlog's `color-border` measures 2.49:1 and misses the
3:1 a control boundary needs. Finance's border tokens pass, and a separate `color-divider`
token carries the decorative lines that need no contrast. See
`color-scheme.md#why-these-values`.

There is no sync back to Backlog. A change here is a change to Finance's design language
alone.

## Status Vocabulary

```meta
```

Files and chapters here use `status: draft | active | deprecated`. `draft` means written but
not yet agreed. `active` means current and binding. `deprecated` means superseded and kept
for history. Metadata follows `.agents/rules/devbook-chapter-metadata.md` and
`.agents/rules/devbook-design.md`.

`active` is the resting value, so an agreed chapter leaves the `status` field out. The rules
carried over from Backlog are written that way. Everything new to Finance carries
`status: draft` until the user has reviewed it: the palette, the amount rules, and the app
icon. The dark-mode rule is Backlog's and the user's decision, so it is not a draft. The empty `meta` fence under a heading stays, because it is what
makes the heading an addressable chapter.
