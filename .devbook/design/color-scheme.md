# Color Scheme

```meta
related: [.devbook/design/design-principles.md#one-light-theme, .devbook/design/accessibility.md#contrast]
```

> Finance has one light theme, the Finance App Design's, so every token has exactly one value.
> This file is the single source of token values. Every other file in `.devbook/design/` and
> all product code reference token names only.

## Provenance

```meta
```

- **Source.** The Finance App Design, the artifact named in `README.md#provenance`. Its eleven
  boards are the look; on 2026-10-22 the user made the design leading over this folder.
- **What changed.** Until then this file held Backlog's dark palette, with the boards'
  colours translated onto it by role. The palette is now the boards' own values. Every
  board colour has a token, listed in `#finance-app-design-mapping`.
- **What stayed.** The token names, the amount tokens, the six badge tones, the chart roles,
  every contrast threshold, and the app icon.
- **How the ratios were measured.** Every ratio in this file is computed with the WCAG 2.2
  relative-luminance formula from the hex values below.

## Brand Ramp

```meta
related: [.devbook/design/color-scheme.md#app-icon]
```

The app icon's money green is one hue, 148°, in eleven steps. The UI primary is the boards'
deep teal-green, `#0E5E50`, not a step of this ramp; the ramp serves the icon only.

| Token | Value | HSL | vs `#FFFFFF` |
|---|---|---|---|
| `color-green-50` | `#F0F9F4` | 147°, 43%, 96% | 1.07:1 |
| `color-green-100` | `#DAF1E5` | 149°, 45%, 90% | 1.19:1 |
| `color-green-200` | `#B5E3CA` | 147°, 45%, 80% | 1.42:1 |
| `color-green-300` | `#88D3AB` | 148°, 46%, 68% | 1.76:1 |
| `color-green-400` | `#59C58B` | 148°, 48%, 56% | 2.15:1 |
| `color-green-500` | `#26975B` | 148°, 60%, 37% | 3.71:1 |
| `color-green-600` | `#197B47` | 148°, 66%, 29% | 5.30:1 |
| `color-green-700` | `#15663B` | 148°, 66%, 24% | 7.01:1 |
| `color-green-800` | `#10502E` | 148°, 67%, 19% | 9.51:1 |
| `color-green-900` | `#0C3B22` | 148°, 66%, 14% | 12.62:1 |
| `color-green-950` | `#082616` | 148°, 65%, 9% | 16.16:1 |

`color-green-600` is the icon tile, deep enough to carry a white glyph. See `#app-icon`. A
component MUST NOT reference a ramp token.

## Palette

```meta
related: [.devbook/design/design-principles.md#one-light-theme]
```

These are the only colour values the product uses.

### Brand

```meta
```

| Token | Value | Usage |
|---|---|---|
| `color-primary` | `#0E5E50` | Primary actions, links, sliders, the edge of a selected card |
| `color-primary-light` | `#0A463C` | Hover states. Darker than the primary, because hover darkens on a light page |
| `color-primary-dark` | `#083A32` | Pressed states |
| `color-primary-subtle` | `#E3F1EC` | Tinted background: the active navigation link, a highlighted step |
| `color-secondary` | `#4A544F` | Secondary labels, the ink of a grey pill |

### Navigation

```meta
```

The sidebar is the one dark surface. Its tokens are used by the navigation and nowhere else.

| Token | Value | Usage |
|---|---|---|
| `color-nav-background` | `#0F1F1A` | The navigation sidebar; a selected segment or chip |
| `color-nav-hover` | `#1B3029` | A hovered navigation link |
| `color-nav-text` | `#C9D4CE` | Navigation link text |
| `color-nav-text-strong` | `#FFFFFF` | The product name, a hovered link, text on a selected segment or chip |
| `color-nav-active` | `#E3F1EC` | The active navigation link's fill, and the focus ring inside the sidebar |
| `color-nav-text-active` | `#0F1F1A` | The active navigation link's text |

### Semantic

```meta
```

Semantic colours are **surfaces first**. A banner or panel is painted in the surface token,
and its text is `color-text-primary`. The four `-text` tokens are the foregrounds, for a
status line, a figure, an icon, or an outline with no semantic surface behind it. They are
never painted as a background.

| Token | Value | Usage |
|---|---|---|
| `color-success` | `#E3F1EC` | Success banners, confirmation panels |
| `color-success-text` | `#12784A` | A change for the better, and money coming in (see `#amount-tokens`) |
| `color-warning` | `#FDEBDD` | Warning banners, caution panels |
| `color-warning-text` | `#B4490F` | A figure over its budget, an expired contract |
| `color-error` | `#FBE4E2` | Error banners, validation summaries |
| `color-error-text` | `#B42318` | A loss, error text and icons, invalid input outlines |
| `color-info` | `#F1F5FC` | The financial-room row, a note panel |
| `color-info-text` | `#2457C5` | The financial room and other figures the product points out, not as a status |

### Neutral and Text

```meta
```

| Token | Value | Usage |
|---|---|---|
| `color-text-primary` | `#15201C` | Body text, headings, values |
| `color-text-secondary` | `#5B6660` | Muted text, labels, table headers |
| `color-text-disabled` | `#8A948E` | Disabled controls only |
| `color-text-inverse` | `#FFFFFF` | Text and icons on a `color-primary` fill |
| `color-text-link` | `#0E5E50` | Links. The same value as `color-primary` |

### Background and Surface

```meta
```

| Token | Value | Usage |
|---|---|---|
| `color-background` | `#F4F5F2` | Page background (ground), a group row in a table |
| `color-background-alt` | `#FFFFFF` | Card, input, button, and segmented-control surface |
| `color-background-raised` | `#FFFFFF` | Dialog, popover, dropdown; lifted by `shadow-xl`, not by colour |
| `color-background-hover` | `#EEF0EC` | A hovered row, button, or chip on a card |
| `color-background-step` | `#FAFBF9` | A step box set into a card |
| `color-background-overlay` | `rgba(21,32,28,0.45)` | Modal backdrop |

### Border

```meta
```

| Token | Value | Usage |
|---|---|---|
| `color-border` | `#CBD2CC` | Button, input, chip, and segmented-control edge, a dashed placeholder |
| `color-border-strong` | `#8A948E` | Emphasized borders |
| `color-border-focus` | `#0E5E50` | Keyboard focus ring. The same value as `color-primary` |
| `color-divider` | `#E2E5E0` | Card edge, table header rule, chart gridlines |
| `color-divider-subtle` | `#EEF0EC` | Table row rule |

## Why These Values

```meta
related: [.devbook/design/accessibility.md#contrast]
```

**The design leads.** Each value is the boards' own. Where a value and an accessibility
threshold disagree, `#contrast-rules` records the gap instead of changing the look.

**Neutrals lean green.** The ground, the muted text, and the edges carry a faint green, so the
page reads as one family with the primary and the sidebar.

**One dark surface.** The sidebar is the only dark area, and it has its own tokens so no
light-surface rule has to bend for it. Its focus ring is `color-nav-active`, because the
primary measures 2.22:1 on `color-nav-background`.

**Success and primary share a surface.** `color-success` and `color-primary-subtle` are the
same `#E3F1EC`, as on the boards. They stay apart by their foregrounds: `color-success-text`
is a yellower green than the primary, a success message carries the `check-circle` icon and a
word, and the primary never means "succeeded".

**Hover darkens.** On a light page a lighter hover would vanish into the card, so
`color-primary-light`, the hover token, is darker than the primary. The name is kept so
product code does not change.

## Amount Tokens

```meta
related: [.devbook/design/design-principles.md#exact-amounts, .devbook/design/typography-and-layout.md#amounts]
```

An amount's colour says which way the money moves, and a change's colour says which way it
went. Each token is a reference to a palette token, so it adds no new colour.

| Token | Value | Used for |
|---|---|---|
| `color-amount-positive` | `color-success-text` | Money coming in, written with a `+` sign |
| `color-amount-negative` | `color-text-primary` | Money going out, written with a `−` sign (U+2212) |
| `color-amount-flagged` | `color-error-text` | A figure the product flags as a problem |
| `color-change-better` | `color-success-text` | A change for the better: income up, debt down, a real raise |
| `color-change-worse` | `color-error-text` | A change for the worse: a loss, a raise below inflation |

Rules:

- **The sign carries the meaning.** Every amount that has a direction MUST print its sign.
  A change prints its own sign too: `−€ 20.385,00 since Jan 2025` is debt down, so it is
  `color-change-better` although its sign is a minus. Colour is an addition, per
  `accessibility.md#contrast`.
- **Money going out is not red.** Most rows in a personal ledger are spending, so outgoing
  amounts stay in the body text colour.
- **Red is kept for problems and losses.** `[TODO: clarify]` Which figures count as problems
  is the domain's call. List them here once `.devbook/domain/` models them.
- **No green or red surfaces.** An amount is coloured text on an ordinary surface.
- **Totals and balances** follow the same rule as single amounts.

## Badge and Chip Tones

```meta
```

A badge is a short value on a pill: a fill and an ink of its own, no edge, as on the boards.
Each family of badges maps its values onto one shared tone scale, so a reader learns the
scale once.

| Pill | Fill token | Fill | Ink token | Ink | Measured |
|---|---|---|---|---|---|
| green | `color-pill-green` | `#E3F1EC` | `color-pill-green-ink` | `#0E5E50` | 6.60:1 |
| orange | `color-pill-orange` | `#FDEBDD` | `color-pill-orange-ink` | `#8A3A0F` | 6.72:1 |
| red | `color-pill-red` | `#FBE4E2` | `color-pill-red-ink` | `#9A1C12` | 6.79:1 |
| blue | `color-pill-blue` | `#E6EDFA` | `color-pill-blue-ink` | `#1D4AA8` | 6.88:1 |
| grey | `color-pill-grey` | `#EEF0EC` | `color-pill-grey-ink` | `#4A544F` | 6.85:1 |
| purple | `color-pill-purple` | `#F1E8F7` | `color-pill-purple-ink` | `#6B2E8F` | 7.31:1 |

| Tone | Meaning | Pill |
|---|---|---|
| `quiet` | Nothing has happened to it yet: draft, unset, not linked | grey |
| `live` | In progress, and the product may act on it | blue |
| `alert` | Wants attention, but is not a fault | orange |
| `fault` | Failed, blocked, or contradicted | red |
| `settled` | Finished and correct | green |
| `archived` | Out of force: cancelled, paid off | grey |

An **area pill** names a category, not a state, and takes the pill its area owns: Energy
orange, Pension green, Subscription blue, Debt purple. A new area takes a pill no other area
on the same screen uses.

Rules:

- A state badge MUST take its tone from the scale above.
- Every pill clears 4.5:1, because its text is small.
- Colour MUST NOT be the only carrier. Every badge prints its value as text, which also tells
  `quiet` and `archived` apart.

## Chart Roles

```meta
related: [.devbook/design/component-libraries.md#recommendation]
```

A chart sits on `color-background-alt`. Every ratio below is measured against it.

| Token | Value | Measured |
|---|---|---|
| `chart-surface` | `color-background-alt` | n/a |
| `chart-series` | `color-primary` | 7.68:1 |
| `chart-ramp-7` | `#0E5E50` | 7.68:1 |
| `chart-ramp-6` | `#3A8573` | 4.39:1 |
| `chart-ramp-5` | `#6BA898` | 2.73:1 |
| `chart-ramp-4` | `#9BC6B8` | 1.88:1 |
| `chart-ramp-3` | `#BDD9CF` | 1.50:1 |
| `chart-ramp-2` | `#D3E6DF` | 1.30:1 |
| `chart-ramp-1` | `#E2EEE9` | 1.19:1 |
| `chart-highlight` | `color-info-text` | 6.47:1 |
| `chart-forecast` | `#A9BFEA` | 1.85:1 |
| `chart-money-in` | `color-info-text` | 6.47:1 |
| `chart-money-out` | `#D9661F` | 3.58:1 |
| `chart-neutral` | `color-border-strong` | 3.13:1 |
| `chart-track` | `color-divider-subtle` | 1.15:1 |
| `chart-grid` | `color-divider` | 1.27:1 |
| `chart-axis` | `color-border` | 1.54:1 |
| `chart-ink` | `color-text-primary` | 16.73:1 |
| `chart-ink-muted` | `color-text-secondary` | 5.98:1 |

Rules:

- **A part-to-whole chart is green.** It uses the ordinal ramp, the largest part on the
  darkest step, `chart-ramp-7`. One part the chart is about, such as the financial room, MAY
  take `chart-highlight` instead, with its forecast months in `chart-forecast`. Segments are
  separated by a 2px gap. A chart with more parts than steps folds the smallest into "Other".
- **Money in is blue, money out is orange.** A chart comparing income with spending draws
  them as `chart-money-in` and `chart-money-out`, each with a legend label. The orange is a
  series colour, not the warning foreground: a month over budget is still marked in
  `color-warning-text` with a sign or a word.
- **A line chart may carry several series** when each has a legend label and its own hue or
  dash: a reference line is dashed `chart-ink`, a schedule or "paid in" line dashed
  `chart-neutral`.
- **A neutral column** — a year that is not the subject, a "not updated" bar — takes
  `chart-neutral`; the one column the chart is about takes a hue.
- **Light steps are legend-backed.** Ramp steps 1 to 5 and `chart-forecast` sit below the 3:1
  a mark owes its surface. A chart using them MUST print every part's value beside its
  swatch, so the figure never depends on telling the steps apart.
- A chart MUST NOT be the only way to read its numbers. The same figures MUST be available as
  text or a table.

## Contrast Rules

```meta
related: [.devbook/design/accessibility.md#contrast]
```

WCAG 2.2 Level AA is the minimum. Primary body text targets AAA.

| Pairing | Minimum | Notes |
|---|---|---|
| `color-text-primary` on `color-background` | **7:1** (AAA target) | Content must be as legible as possible. |
| `color-text-secondary` on any surface | **4.5:1** | Supporting text and chrome. |
| Text on a semantic surface | **4.5:1** | Semantic surfaces are backgrounds. |
| The four `-text` foregrounds and `color-primary` as text, on any light surface | **4.5:1** | They appear as text on the ground, on cards, and on their own surface. |
| `color-text-inverse` on every primary state | **4.5:1** | Covers rest, hover, and pressed. |
| Navigation text on `color-nav-background` | **4.5:1** | The sidebar's own pairs. |
| Large text (24 px and up, or 18.66 px bold and up) | **3:1** | Headings only. |
| A focus ring vs its adjacent surface | **3:1** | `color-border-focus` on light surfaces, `color-nav-active` in the sidebar. |
| `color-border` vs adjacent surface | **3:1** | Non-text contrast for control boundaries. **Not met**; see below. |

Rules:

- `color-text-disabled` is exempt. It signals that a control is unavailable.
- `color-divider` and `color-divider-subtle` are exempt, because they never identify a control.
- State MUST NOT be shown by colour alone. Pair colour with text, an icon, a sign, or shape.
- On a `color-primary` fill, label text uses `color-text-inverse`.

**The control-edge gap.** The boards draw control edges in `#CBD2CC`, which measures 1.54:1
on a card and 1.41:1 on the ground, under the 3:1 WCAG 1.4.11 asks of a boundary that
identifies a control. `[TODO: clarify]` Keep the boards' edge and accept the gap, or move
`color-border` to `color-border-strong` (`#8A948E`, 3.13:1 on a card) and give up a little of
the boards' lightness. Until then a text field MUST also carry a visible label above it.

## Measured Pairs

```meta
```

Every binding pair is measured below. All pass except the control edge.

| Pairing | Required | Measured |
|---|---|---|
| `color-text-primary` on `color-background` | 7:1 | **15.29:1** |
| `color-text-primary` on `color-background-alt` | 4.5:1 | **16.73:1** |
| `color-text-primary` on `color-background-hover` | 4.5:1 | **14.59:1** |
| `color-text-secondary` on `color-background` | 4.5:1 | **5.46:1** |
| `color-text-secondary` on `color-background-alt` | 4.5:1 | **5.98:1** |
| `color-text-secondary` on `color-background-hover` | 4.5:1 | **5.21:1** |
| `color-text-secondary` on `color-primary-subtle` | 4.5:1 | **5.14:1** |
| `color-text-secondary` on `color-info` | 4.5:1 | **5.47:1** |
| `color-secondary` on `color-background-alt` | 4.5:1 | **7.86:1** |
| `color-primary` on `color-background` | 4.5:1 | **7.01:1** |
| `color-primary` on `color-background-alt` | 4.5:1 | **7.68:1** |
| `color-primary` on `color-primary-subtle` | 4.5:1 | **6.60:1** |
| `color-text-inverse` on `color-primary` | 4.5:1 | **7.68:1** |
| `color-text-inverse` on `color-primary-light` | 4.5:1 | **10.75:1** |
| `color-text-inverse` on `color-primary-dark` | 4.5:1 | **12.64:1** |
| `color-success-text` on `color-background` | 4.5:1 | **5.04:1** |
| `color-success-text` on `color-background-alt` | 4.5:1 | **5.51:1** |
| `color-success-text` on `color-success` | 4.5:1 | **4.74:1** |
| `color-success-text` on `color-info` | 4.5:1 | **5.04:1** |
| `color-warning-text` on `color-background` | 4.5:1 | **4.92:1** |
| `color-warning-text` on `color-background-alt` | 4.5:1 | **5.38:1** |
| `color-warning-text` on `color-warning` | 4.5:1 | **4.64:1** |
| `color-error-text` on `color-background` | 4.5:1 | **6.01:1** |
| `color-error-text` on `color-background-alt` | 4.5:1 | **6.57:1** |
| `color-error-text` on `color-error` | 4.5:1 | **5.42:1** |
| `color-info-text` on `color-background` | 4.5:1 | **5.91:1** |
| `color-info-text` on `color-background-alt` | 4.5:1 | **6.47:1** |
| `color-info-text` on `color-info` | 4.5:1 | **5.92:1** |
| `color-info-text` on `color-primary-subtle` | 4.5:1 | **5.57:1** |
| `color-text-primary` on `color-success` | 4.5:1 | **14.39:1** |
| `color-text-primary` on `color-warning` | 4.5:1 | **14.42:1** |
| `color-text-primary` on `color-error` | 4.5:1 | **13.78:1** |
| `color-text-primary` on `color-info` | 4.5:1 | **15.30:1** |
| `color-nav-text` on `color-nav-background` | 4.5:1 | **11.20:1** |
| `color-nav-text-strong` on `color-nav-background` | 4.5:1 | **17.06:1** |
| `color-nav-text-strong` on `color-nav-hover` | 4.5:1 | **13.99:1** |
| `color-nav-text-active` on `color-nav-active` | 4.5:1 | **14.67:1** |
| `color-border-focus` vs `color-background` | 3:1 | **7.01:1** |
| `color-border-focus` vs `color-background-alt` | 3:1 | **7.68:1** |
| `color-nav-active` (focus ring) vs `color-nav-background` | 3:1 | **14.67:1** |
| `color-border` vs `color-background-alt` | 3:1 | **1.54:1** — fails |
| `color-border` vs `color-background` | 3:1 | **1.41:1** — fails |
| `color-border-strong` vs `color-background-alt` | 3:1 | **3.13:1** |

The passing pair closest to its threshold is `color-warning-text` on `color-warning` at
4.64:1. A later change to a surface or foreground MUST re-measure it first.

## Elevation by Color

```meta
related: [.devbook/design/typography-and-layout.md#shadows-and-elevation]
```

On the light page a card is lifted by its white fill and a `color-divider` edge, with no
shadow. A shadow marks the one thing floating above the page.

| Level | Surface | Edge or shadow | Typical use |
|---|---|---|---|
| Base (0) | `color-background` | none | Page |
| Card (+1) | `color-background-alt` | `color-divider` edge, `shadow-none` | Cards, panels, tables |
| Overlay (+2) | `color-background-raised` | `shadow-xl` | Dropdown, popover, dialog |
| Scrim | `color-background-overlay` | none | Behind modals and drawers |

Rules:

- A card MUST NOT carry a shadow. Only a surface that floats over others does.
- Do not stack more than two surface steps in one view. A step box set into a card takes
  `color-background-step`.

## Per-Stack Token Mapping

```meta
related: [.devbook/design/component-libraries.md, .devbook/arc42/04-solution-strategy.md#local-first-desktop-application]
```

Finance renders its UI in WebView2, so the tokens are CSS custom properties. The MAUI shell
around it uses only the icon colour.

| Logical token | CSS custom property |
|---|---|
| `color-primary` | `--color-primary: #0E5E50;` |
| `color-background` | `--color-background: #F4F5F2;` |
| `color-text-primary` | `--color-text-primary: #15201C;` |
| `color-border-focus` | `--color-border-focus: #0E5E50;` |

Rules:

- **One declaration.** The tokens are declared once, in one `:root` block in the UI
  library's stylesheet, which every host links. Components never declare a colour.
- **Light only.** The stylesheet MUST define only the light values. There is no
  `prefers-color-scheme` block and no dark theme. `:root` also sets `color-scheme: light`,
  so the browser's own controls and scrollbars render light too.
- **Names keep their stem.** Write the CSS property as `--` plus the token name. A C# or XAML
  reference adapts the casing (`ColorPrimary`) and keeps the stem.
- **No raw literals.** A component references `var(--color-...)`, never a hex value.
- The ramp tokens (`color-green-*`) are declared too, for the icon. Components still MUST NOT
  use them directly.
- `[TODO: clarify]` Whether Finance shares Backlog's component library, and with it Backlog's
  stylesheet with these values swapped in, or keeps its own. See
  `component-libraries.md#risks-and-gaps`.

## Full Token Reference

```meta
```

Every palette token and its single value. Anything else in product code is a literal and
MUST be replaced by a token.

| Token | Value |
|---|---|
| `color-primary` | `#0E5E50` |
| `color-primary-light` | `#0A463C` |
| `color-primary-dark` | `#083A32` |
| `color-primary-subtle` | `#E3F1EC` |
| `color-secondary` | `#4A544F` |
| `color-nav-background` | `#0F1F1A` |
| `color-nav-hover` | `#1B3029` |
| `color-nav-text` | `#C9D4CE` |
| `color-nav-text-strong` | `#FFFFFF` |
| `color-nav-active` | `#E3F1EC` |
| `color-nav-text-active` | `#0F1F1A` |
| `color-success` | `#E3F1EC` |
| `color-success-text` | `#12784A` |
| `color-warning` | `#FDEBDD` |
| `color-warning-text` | `#B4490F` |
| `color-error` | `#FBE4E2` |
| `color-error-text` | `#B42318` |
| `color-info` | `#F1F5FC` |
| `color-info-text` | `#2457C5` |
| `color-text-primary` | `#15201C` |
| `color-text-secondary` | `#5B6660` |
| `color-text-disabled` | `#8A948E` |
| `color-text-inverse` | `#FFFFFF` |
| `color-text-link` | `#0E5E50` |
| `color-background` | `#F4F5F2` |
| `color-background-alt` | `#FFFFFF` |
| `color-background-raised` | `#FFFFFF` |
| `color-background-hover` | `#EEF0EC` |
| `color-background-step` | `#FAFBF9` |
| `color-background-overlay` | `rgba(21,32,28,0.45)` |
| `color-border` | `#CBD2CC` |
| `color-border-strong` | `#8A948E` |
| `color-border-focus` | `#0E5E50` |
| `color-divider` | `#E2E5E0` |
| `color-divider-subtle` | `#EEF0EC` |
| `color-pill-green` | `#E3F1EC` |
| `color-pill-green-ink` | `#0E5E50` |
| `color-pill-orange` | `#FDEBDD` |
| `color-pill-orange-ink` | `#8A3A0F` |
| `color-pill-red` | `#FBE4E2` |
| `color-pill-red-ink` | `#9A1C12` |
| `color-pill-blue` | `#E6EDFA` |
| `color-pill-blue-ink` | `#1D4AA8` |
| `color-pill-grey` | `#EEF0EC` |
| `color-pill-grey-ink` | `#4A544F` |
| `color-pill-purple` | `#F1E8F7` |
| `color-pill-purple-ink` | `#6B2E8F` |

These forty-seven palette tokens, the eleven ramp tokens in `#brand-ramp`, and the tokens in
`#amount-tokens` and `#chart-roles` are the whole colour palette. The chart ramp steps, `chart-forecast`, and `chart-money-out` are values of
their own because the boards draw them and no palette token holds them.

## Finance App Design Mapping

```meta
related: [.devbook/design/README.md#provenance, .devbook/design/design-principles.md#one-light-theme]
```

This table lists every colour the boards use and the token that now holds it. Since the design
leads, each token's value is the board value itself. A value with two jobs has a row per job.

| Board value | Its job on the boards | Token |
|---|---|---|
| `#F4F5F2` | Page background, a group row in a table | `color-background` |
| `#FAFBF9` | A step box set into a card | `color-background-step` |
| `#FFFFFF` | Card, input, button, and segmented-control surface | `color-background-alt` |
| `#FFFFFF` | Navigation brand text, hovered link text, text on a selected chip | `color-nav-text-strong` |
| `#FFFFFF` | Text on a primary button | `color-text-inverse` |
| `#0F1F1A` | Navigation sidebar, a selected segment or chip | `color-nav-background` |
| `#1B3029` | Hovered navigation link | `color-nav-hover` |
| `#E3F1EC` | Active navigation link | `color-nav-active` |
| `#E3F1EC` | A highlighted step, a tinted panel | `color-primary-subtle` |
| `#E8EEEA`, `#C9D4CE` | Navigation text | `color-nav-text` |
| `#15201C` | Body text, headings, values | `color-text-primary` |
| `#15201C` | The current-month outline, a dashed reference line | `chart-ink` |
| `#5B6660` | Muted text, labels, table headers | `color-text-secondary` |
| `#4A544F` | Ink of a grey pill | `color-secondary` |
| `#CBD2CC` | Button, input, chip, and segmented-control edge, a dashed placeholder | `color-border` |
| `#CBD2CC` | Chart baseline, a legend swatch's edge | `chart-axis` |
| `#8A948E` | Dashed schedule line, a "not updated" bar, a neutral column | `chart-neutral` |
| `#E2E5E0` | Card edge, table header rule | `color-divider` |
| `#EEF0EC` | Table row rule | `color-divider-subtle` |
| `#EEF0EC` | Progress-bar track | `chart-track` |
| `#0E5E50` | Primary button, link, slider, a selected card's edge | `color-primary` |
| `#0E5E50` | A single chart series, the largest part of a part-to-whole bar | `chart-series`, `chart-ramp-7` |
| `#0A463C` | Hovered link | `color-primary-light` |
| `#3A8573`, `#4A7F70` | Second part, a secondary series' label | `chart-ramp-6` |
| `#6BA898`, `#4F9C88` | Third part, a progress fill, a pension pot | `chart-ramp-5` |
| `#9BC6B8` | Fourth part | `chart-ramp-4` |
| `#D3E6DF`, `#CFE3DB` | Sixth part, the smallest pension pot | `chart-ramp-2` |
| `#E2EEE9`, `#ECF3F0` | Seventh and eighth part | `chart-ramp-1` |
| `#BFDDD1`, `#BDD9CF` | Edge of a highlighted step, fifth part | `chart-ramp-3` |
| `#12784A` | A change for the better: income up, debt down | `color-change-better` |
| `#2457C5` | The financial room as a figure or a bar, net income beside expenses | `color-info-text`, `chart-highlight`, `chart-money-in` |
| `#A9BFEA` | A forecast month of the financial room | `chart-forecast` |
| `#1D4AA8` | A figure pointed out, such as a multiplier | `color-info-text` |
| `#F1F5FC` | The financial-room row, a note panel | `color-info` |
| `#D9661F` | Expenses beside net income | `chart-money-out` |
| `#B4490F`, `#F2C4A6` | A month over budget, an expired contract, the edge of a caution card | `color-warning-text` |
| `#B42318` | A loss, a figure the product flags | `color-change-worse`, `color-amount-flagged` |

Where two board values sit in one row they differ by less than one shade, and the token takes
the first.

The boards' pills are the six pills in `#badge-and-chip-tones`, with their fills and inks
unchanged.

## App Icon

```meta
related: [.devbook/design/typography-and-layout.md#iconography]
```

The app icon is the euro sign, white on a money-green tile. It follows the shape of
Backlog's icon: a background layer and a foreground layer that MAUI composes at build time.

| File | Layer | Content | Copy into the app as |
|---|---|---|---|
| [`assets/app-icon-background.svg`](assets/app-icon-background.svg) | Background | A flat 456 × 456 tile in `color-green-600` (`#197B47`) | `Resources/AppIcon/appicon.svg` |
| [`assets/app-icon-foreground.svg`](assets/app-icon-foreground.svg) | Foreground | The euro sign in `#FFFFFF` on a transparent canvas | `Resources/AppIcon/appiconfg.svg` |
| [`assets/app-icon.svg`](assets/app-icon.svg) | Both | The two layers composed, as a reference picture only | not copied |

The project file declares the icon the way Backlog's does:

```xml
<MauiIcon Include="Resources\AppIcon\appicon.svg" ForegroundFile="Resources\AppIcon\appiconfg.svg" Color="#197B47" />
```

The names inside the app are lowercase with no hyphens, because MAUI's resource naming rules
require it. The names here are the design source.

**The glyph.** The euro sign is drawn as geometry: an open ring with radial terminals, and
two horizontal bars that cross its left side and stop at its centre. It is paths and
rectangles, not text, so no build machine's font substitution can change it. The ring and
the bars are separate elements, so the overlapping fills never depend on path winding.

**The colours.** The icon uses brand values, not UI tokens. Backlog's icon takes its tile
from the app's base surface. Finance's takes the brand green instead, because a dark tile
would hide a euro sign in the UI primary at small sizes.

| Part | Token | Value | Contrast |
|---|---|---|---|
| Tile | `color-green-600`, the brand tile | `#197B47` | n/a |
| Euro sign | white, used only in the icon | `#FFFFFF` | 5.30:1 on the tile |

**Safe area.** All ink sits within a radius of 135.3 of the canvas centre (228, 228). That is
inside the 139.5 safe radius Backlog's mark keeps, so a mask that rounds the tile never crops
the glyph. The glyph is optically centred on its bounding box, not on the ring.

**Sizes.** MAUI's Resizetizer generates every Windows icon size from the two SVG layers: the
`.ico` the window and taskbar use, and the package logos at their scale factors. The mark
MUST stay recognisable as a euro sign at these sizes. It was rendered and checked at 16, 32,
48, and 256 px, on a dark and a light background.

| Size | Where Windows shows it |
|---|---|
| 16 px | Title bar, small taskbar icons, File Explorer details view |
| 24 px and 32 px | Taskbar, Start menu list, Alt+Tab at standard scale |
| 48 px | Start menu tiles, File Explorer medium icons |
| 256 px | File Explorer large icons, the largest image in the `.ico` |

At 16 px each bar is just under one pixel thick. The two bars still read as two, because the
gap between them is as wide as a bar. `[TODO: clarify]` Whether a hand-tuned 16 px variant
is worth adding if the generated one looks soft on a real taskbar.

**Windows light and dark mode.** Finance itself is light only, but the Windows taskbar and
Start menu follow the user's Windows mode, which can be dark. The icon is one image for
both. The tile brings its own background, so the mark never depends on what is behind it.
The tile measures 3.08:1 against the Windows dark taskbar (`#202020`) and 4.77:1 against the
light one (`#F3F3F3`).

Rules:

- The icon is one image. It MUST NOT get a variant per Windows mode.
- Do not add a gradient, a shadow, or a second colour. Resizetizer rasterises the layers at
  every size, and a flat mark survives that best.
- If Finance adds a splash screen, it MUST reuse the foreground layer at the same geometry on
  a `color-green-600` background, as Backlog's splash reuses its mark.
- A change to `color-green-600` MUST be made in all three SVG files and in the `Color`
  attribute in the same change.
