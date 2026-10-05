# Color Scheme

```meta
status: draft
related: [.devbook/design/design-principles.md#dark-mode-only, .devbook/design/accessibility.md#contrast]
```

> The dark colour palette and semantic design tokens for Finance. Finance is dark mode only,
> like Backlog, so every token has exactly one value. The token set is Backlog's, adapted
> around a money-green primary. This file is the single source of token values. Every other
> file in `.devbook/design/` and all product code reference token names only.

## Provenance

```meta
status: draft
```

- **Source.** Backlog's `color-scheme.md`, adapted on 2026-10-06. Backlog took its token set
  from the JSdotNet design style guide (`01-color-palette`), dark column only.
- **What changed.** The primary is a money green instead of Backlog's gold. The success and
  info colours, the borders, and the chart roles were re-derived around it.
- **What stayed.** The token groups and their names, the dark surface ramp, the text tokens,
  the error and warning colours, the badge tone scale, the single-hue chart rule, the
  elevation-by-colour rule, and every contrast threshold.
- **How the ratios were measured.** Every ratio in this file is computed with the WCAG 2.2
  relative-luminance formula, which is unchanged from WCAG 2.1, from the hex values below.

The palette is `draft` until the user has reviewed the green.

## Primary Ramp

```meta
status: draft
```

The primary is one hue, 148°, in eleven steps. A token picks a step from this ramp rather
than holding a green of its own.

| Token | Value | HSL | vs `#FFFFFF` | vs `#121214` |
|---|---|---|---|---|
| `color-green-50` | `#F0F9F4` | 147°, 43%, 96% | 1.07:1 | 17.43:1 |
| `color-green-100` | `#DAF1E5` | 149°, 45%, 90% | 1.19:1 | 15.77:1 |
| `color-green-200` | `#B5E3CA` | 147°, 45%, 80% | 1.42:1 | 13.19:1 |
| `color-green-300` | `#88D3AB` | 148°, 46%, 68% | 1.76:1 | 10.65:1 |
| `color-green-400` | `#59C58B` | 148°, 48%, 56% | 2.15:1 | 8.72:1 |
| `color-green-500` | `#26975B` | 148°, 60%, 37% | 3.71:1 | 5.04:1 |
| `color-green-600` | `#197B47` | 148°, 66%, 29% | 5.30:1 | 3.53:1 |
| `color-green-700` | `#15663B` | 148°, 66%, 24% | 7.01:1 | 2.67:1 |
| `color-green-800` | `#10502E` | 148°, 67%, 19% | 9.51:1 | 1.97:1 |
| `color-green-900` | `#0C3B22` | 148°, 66%, 14% | 12.62:1 | 1.48:1 |
| `color-green-950` | `#082616` | 148°, 65%, 9% | 16.16:1 | 1.16:1 |

`#121214` is `color-background`. The `#FFFFFF` column matters for the app icon, whose white
glyph sits on `color-green-600`. See `#app-icon`.

**Why this green.** "Money green" names the green of banknote ink and of the dollar bill: a
deep green, not a bright one. Hue 148° sits between pure green and emerald. It is cool
enough to be read as a brand colour rather than a status, and it leaves the yellow-green
side of the wheel free for `color-success`. In the UI, `color-green-400` is the primary:
saturated enough to read as money green on a dark surface, and 8.72:1 on the base.
`color-green-600` is the brand tile of the app icon, deep enough to carry a white glyph.

Product code MUST use the palette tokens below. The ramp tokens are for this file, for the
chart roles, and for the app icon, and a component MUST NOT reference one directly.

## Dark Palette

```meta
status: draft
related: [.devbook/design/design-principles.md#dark-mode-only]
```

These are the only colour values the product uses.

### Brand

```meta
```

| Token | Value | Usage |
|---|---|---|
| `color-primary` | `#59C58B` (green-400) | Primary actions, active navigation, links, key highlights |
| `color-primary-light` | `#88D3AB` (green-300) | Hover states |
| `color-primary-dark` | `#26975B` (green-500) | Pressed states |
| `color-primary-subtle` | `#0C3B22` (green-900) | Tinted background: a selected row, a highlighted panel |
| `color-secondary` | `#ADB5BD` | Secondary buttons, less prominent labels |

### Semantic

```meta
```

Semantic colours are **surfaces first**. A banner or panel is painted in the surface token,
and its text is `color-text-primary`. `color-success-text` and `color-error-text` are the two
foregrounds, for a status line, an icon, or an input outline with no semantic surface behind
it. They are never painted as a background. Warning and info have no text token, because no
rule paints either as text, as in Backlog.

| Token | Value | Usage |
|---|---|---|
| `color-success` | `#24330F` | Success banners, confirmation panels |
| `color-success-text` | `#A9D274` | Success text and icons, and money coming in (see `#amount-tokens`) |
| `color-warning` | `#3D2E00` | Warning banners, caution panels |
| `color-error` | `#3D0A0D` | Error banners, validation summaries |
| `color-error-text` | `#EC8E97` | Error text, icons, and invalid input outlines |
| `color-info` | `#0B2540` | Informational notices |

### Neutral and Text

```meta
```

| Token | Value | Usage |
|---|---|---|
| `color-text-primary` | `#F8F9FA` | Body text, headings, content |
| `color-text-secondary` | `#CED4DA` | Supporting text, metadata, placeholders, chrome |
| `color-text-disabled` | `#6C757D` | Disabled controls only |
| `color-text-inverse` | `#121214` | Text and icons on a `color-primary` fill |
| `color-text-link` | `#59C58B` | Links. The same value as `color-primary`, always underlined |

### Background and Surface

```meta
```

| Token | Value | Usage |
|---|---|---|
| `color-background` | `#121214` | Page and window background (base surface) |
| `color-background-alt` | `#202023` | Sidebar, card, alternating rows (surface +1) |
| `color-background-raised` | `#353539` | Dialog, popover, dropdown (surface +2) |
| `color-background-overlay` | `rgba(0,0,0,0.60)` | Modal backdrop |

### Border

```meta
```

| Token | Value | Usage |
|---|---|---|
| `color-border` | `#808086` | Input outlines, control and card boundaries |
| `color-border-strong` | `#9C9CA2` | Emphasized borders, chart axes, the edge of a filled badge |
| `color-border-focus` | `#59C58B` | Keyboard focus ring. The same value as `color-primary` |
| `color-divider` | `#3F3F44` | Decorative separators: table row rules, section lines, chart gridlines |

## Why These Values

```meta
status: draft
related: [.devbook/design/accessibility.md#contrast]
```

**Neutrals stay neutral.** The surfaces and text are Backlog's plain greys, not tinted
green. Finance colours amounts green and red, and a green-tinted page would shift how both
read. Backlog made the same call when it replaced the guide's blue-tinted slate with neutral
greys.

**One saturated hue.** Finance adds no accent colour beside the green. Backlog's system has
one brand hue, and its single-hue chart rule depends on that. A second brand hue, such as
gold, would also sit too close to the warning amber. `color-secondary` stays Backlog's
neutral grey.

**Success is a different green.** Success is green by convention, and the primary is green
too. `color-success-text` is a yellow-green, far enough round the wheel that the two read as
different colours side by side:

| Token | HSL |
|---|---|
| `color-primary` | 148°, 48%, 56% |
| `color-success-text` | 86°, 51%, 64% |

That is a hue gap of 62°. Hue is not the only thing that separates them. These rules make the
difference readable without colour:

- A success message always carries the `check-circle` icon and a word.
- Money coming in always carries a `+` sign.
- A link is always underlined. A positive amount is never a link style.
- The primary never means "succeeded". It means "this is the action" or "this is selected".

Backlog's `color-success` (`#1A3A22`) and `color-success-text` (`#72C086`) are hue 135°,
too close to the new primary, so both were re-derived toward yellow-green.

**Info moved to blue.** Backlog's info surface is a dark teal (hue 187°). Next to a hue-148°
primary it read as one more green, so Finance's info is blue, hue about 210°.

**Error and warning kept.** `color-error`, `color-error-text`, and `color-warning` are
Backlog's values unchanged.

**Readable borders.** Backlog's `color-border` (`#545459`) measures 2.49:1 against its base
and misses the 3:1 that WCAG 1.4.11 asks of a control boundary. Finance splits the job in
two. `color-border` now passes 3:1 on every surface, and it draws the edges that identify a
control. `color-divider` draws the lines that only decorate, such as table rules and
gridlines. Those owe no contrast, because a reader does not need them to find a control.
`color-border-strong` moved up with it, from Backlog's `#737379` to `#9C9CA2`, so it stays
stronger than the border.

**Additions to Backlog's names.** Two tokens are new. `color-primary-subtle` gives selection
a tinted background that is not the hover colour. `color-divider` is the decorative line
above. Every other token keeps Backlog's name.

## Amount Tokens

```meta
status: draft
related: [.devbook/design/design-principles.md#exact-amounts, .devbook/design/typography-and-layout.md#amounts]
```

An amount's colour says which way the money moves. Each token is a reference to a palette
token, so it adds no new colour.

| Token | Value | Used for |
|---|---|---|
| `color-amount-positive` | `color-success-text` | Money coming in, written with a `+` sign |
| `color-amount-negative` | `color-text-primary` | Money going out, written with a `−` sign (U+2212) |
| `color-amount-flagged` | `color-error-text` | A figure the product flags as a problem |

Rules:

- **The sign carries the meaning.** Every amount that has a direction MUST print its sign.
  Colour is an addition for a reader who sees it, per `accessibility.md#contrast`.
- **Money going out is not red.** Most rows in a personal ledger are spending. Painting each
  one red would make the ordinary case an alarm, so outgoing amounts stay in the body text
  colour. Dutch banking apps use the same convention: incoming amounts green with a plus,
  outgoing ones plain with a minus.
- **Red is kept for problems.** `color-amount-flagged` is for a figure that needs action,
  such as a balance below zero. `[TODO: clarify]` Which figures count as problems is the
  domain's call. List them here once `.devbook/domain/` models them.
- **No green or red surfaces.** An amount is coloured text on an ordinary surface. A row is
  never filled green or red because of its amount.
- **Totals and balances** follow the same rule as single amounts: a positive total is
  `color-amount-positive`, a negative total is `color-amount-negative`, unless the product
  flags it.

The contrast of each token is the contrast of the palette token it references. See
`#measured-pairs`.

## Badge and Chip Tones

```meta
```

A badge is a short value with a tone. Each family of badges maps its own values onto one
shared tone scale, so a reader learns the scale once. The values are the caller's, and the
tone is this file's. The scale is Backlog's.

| Tone | Meaning | Derivation |
|---|---|---|
| `quiet` | Nothing has happened to it yet: draft, unset | `color-secondary` ink on `color-background-alt` |
| `live` | In progress, and the product may act on it | `color-primary-light` ink, `color-primary-dark` edge, no fill |
| `alert` | Wants attention, but is not a fault | `color-warning` surface |
| `fault` | Failed, blocked, or contradicted | `color-error` surface |
| `settled` | Finished and correct | `color-success` surface |
| `archived` | Out of force, and spends no colour | `color-border-strong` edge only |

Rules:

- A badge MUST take its tone from this scale. A family that needs a seventh tone would be a
  second palette, which `design-principles.md#dark-mode-only` does not allow.
- **Filled means the product acts on it.** `alert`, `fault`, and `settled` are filled.
  Everything else is outlined, so a filled chip in a list is always the one to look at.
- `live` and `settled` are both green, so they also differ in shape: `live` is an outline in
  the primary green, and `settled` is a filled yellow-green surface. Their text differs too.
- A filled chip takes `color-border-strong` as its edge, because the semantic surfaces are
  too close to the page to act as a boundary.
- Badge text is small, so it MUST clear 4.5:1. `color-text-disabled` is not available to a
  badge. An out-of-force value takes `archived`.
- Colour MUST NOT be the only carrier. Every badge prints its value as text.

## Chart Roles

```meta
status: draft
related: [.devbook/design/component-libraries.md#recommendation]
```

A chart sits on `color-background-alt`. Every ratio below is measured against it.

| Token | Value | Measured |
|---|---|---|
| `chart-surface` | `color-background-alt` | n/a |
| `chart-series` | `color-primary` | 7.57:1 |
| `chart-ramp-1` | `color-green-500` | 4.38:1 |
| `chart-ramp-2` | `color-green-400` | 7.57:1 |
| `chart-ramp-3` | `color-green-300` | 9.25:1 |
| `chart-ramp-4` | `color-green-200` | 11.46:1 |
| `chart-track` | `color-green-900` | 1.29:1 |
| `chart-grid` | `color-divider` | 1.55:1 |
| `chart-axis` | `color-border-strong` | 5.95:1 |
| `chart-ink` | `color-text-primary` | 15.42:1 |
| `chart-ink-muted` | `color-text-secondary` | 10.88:1 |

Rules:

- **Charts are single-hue.** A part-to-whole chart uses the ordinal ramp. Two different
  measures are drawn as two charts, never as two series on one plot. This is Backlog's rule.
- **A higher ramp step is lighter**, so "more" always means "stands out more" on the dark
  surface.
- Every ramp step clears the 3:1 a non-text mark owes its background. The steps are taken
  from the ramp rather than mixed toward the surface, so each value is one this file
  already names.
- The track is deliberately below 3:1, because it shows the absence of data. Gridlines are
  decorative, and the baseline takes `chart-axis`, because a baseline carries meaning.
- A chart MUST NOT be the only way to read its numbers. The same figures MUST be available
  as text or a table.
- `[TODO: clarify]` Charts that compare money in with money out may need a diverging pair.
  If they do, derive it from `color-amount-positive` and a neutral, and record it here. Do
  not add a hue.

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
| `color-success-text`, `color-error-text`, `color-primary` as text, on any surface | **4.5:1** | They appear as text on all three surfaces. |
| `color-text-inverse` on every primary state | **4.5:1** | Covers rest, hover, and pressed. |
| Large text (24 px and up, or 18.66 px bold and up) | **3:1** | Headings only. |
| `color-border-focus` vs adjacent surface | **3:1** | Non-text contrast for focus. |
| `color-border` vs adjacent surface | **3:1** | Non-text contrast for control boundaries. |

Rules:

- `color-text-disabled` is exempt. It signals that a control is unavailable.
- `color-divider` is exempt, because it never identifies a control.
- State MUST NOT be shown by colour alone. Pair colour with text, an icon, a sign, or shape.
- On a `color-primary` fill, label text uses `color-text-inverse`.

## Measured Pairs

```meta
status: draft
```

Every binding pair, measured. All pass.

| Pairing | Required | Measured |
|---|---|---|
| `color-text-primary` on `color-background` | 7:1 | **17.75:1** |
| `color-text-primary` on `color-background-alt` | 4.5:1 | **15.42:1** |
| `color-text-primary` on `color-background-raised` | 4.5:1 | **11.58:1** |
| `color-text-secondary` on `color-background` | 4.5:1 | **12.52:1** |
| `color-text-secondary` on `color-background-alt` | 4.5:1 | **10.88:1** |
| `color-text-secondary` on `color-background-raised` | 4.5:1 | **8.17:1** |
| `color-secondary` on `color-background-alt` | 4.5:1 | **7.83:1** |
| `color-primary` on `color-background` | 4.5:1 | **8.72:1** |
| `color-primary` on `color-background-alt` | 4.5:1 | **7.57:1** |
| `color-primary` on `color-background-raised` | 4.5:1 | **5.69:1** |
| `color-primary` on `color-primary-subtle` | 4.5:1 | **5.88:1** |
| `color-text-primary` on `color-primary-subtle` | 4.5:1 | **11.97:1** |
| `color-text-inverse` on `color-primary` | 4.5:1 | **8.72:1** |
| `color-text-inverse` on `color-primary-light` | 4.5:1 | **10.65:1** |
| `color-text-inverse` on `color-primary-dark` | 4.5:1 | **5.04:1** |
| `color-success-text` on `color-background` | 4.5:1 | **10.83:1** |
| `color-success-text` on `color-background-alt` | 4.5:1 | **9.41:1** |
| `color-success-text` on `color-background-raised` | 4.5:1 | **7.07:1** |
| `color-success-text` on `color-success` | 4.5:1 | **7.82:1** |
| `color-error-text` on `color-background` | 4.5:1 | **7.91:1** |
| `color-error-text` on `color-background-alt` | 4.5:1 | **6.87:1** |
| `color-error-text` on `color-background-raised` | 4.5:1 | **5.17:1** |
| `color-error-text` on `color-error` | 4.5:1 | **7.12:1** |
| `color-text-primary` on `color-success` | 4.5:1 | **12.81:1** |
| `color-text-primary` on `color-warning` | 4.5:1 | **12.54:1** |
| `color-text-primary` on `color-error` | 4.5:1 | **15.97:1** |
| `color-text-primary` on `color-info` | 4.5:1 | **14.73:1** |
| `color-border-focus` vs `color-background` | 3:1 | **8.72:1** |
| `color-border-focus` vs `color-background-alt` | 3:1 | **7.57:1** |
| `color-border-focus` vs `color-background-raised` | 3:1 | **5.69:1** |
| `color-border` vs `color-background` | 3:1 | **4.77:1** |
| `color-border` vs `color-background-alt` | 3:1 | **4.14:1** |
| `color-border` vs `color-background-raised` | 3:1 | **3.11:1** |
| `color-border-strong` vs `color-background` | 3:1 | **6.85:1** |
| `color-border-strong` vs `color-background-raised` | 3:1 | **4.47:1** |

The binding pair, the one closest to its threshold, is `color-border` on
`color-background-raised` at 3.11:1. A later change to a surface or border value MUST
re-measure it first.

## Elevation by Color

```meta
related: [.devbook/design/typography-and-layout.md#shadows-and-elevation]
```

Elevation is expressed mainly by a **lighter surface colour**, not by heavy shadows. This is
Backlog's rule.

| Level | Surface token | Typical use |
|---|---|---|
| Base (0) | `color-background` | Window and page |
| Raised (+1) | `color-background-alt` | Sidebar, cards, panels, list rows |
| Overlay (+2) | `color-background-raised` | Dropdown, popover, dialog, command palette |
| Scrim | `color-background-overlay` | Behind modals and drawers |

Rules:

- An elevated surface MUST use the raised surface token as its main elevation cue. Shadows
  are secondary and about 30% less opaque than their raw token, per
  `typography-and-layout.md#shadows-and-elevation`.
- Do not stack more than two surface steps in one view. If a layout needs more depth,
  reconsider the layout.

## Per-Stack Token Mapping

```meta
related: [.devbook/design/component-libraries.md, .devbook/arc42/04-solution-strategy.md#local-first-desktop-application]
```

Finance renders its UI in WebView2, so the tokens are CSS custom properties. The MAUI shell
around it uses only the icon colour.

| Logical token | CSS custom property |
|---|---|
| `color-primary` | `--color-primary: #59C58B;` |
| `color-background` | `--color-background: #121214;` |
| `color-text-primary` | `--color-text-primary: #F8F9FA;` |
| `color-border-focus` | `--color-border-focus: #59C58B;` |

Rules:

- **One declaration.** The tokens are declared once, in one `:root` block in the UI
  library's stylesheet, which every host links. Components never declare a colour.
- **Dark only.** The stylesheet MUST define only the dark values. There is no
  `prefers-color-scheme` block and no light theme. `:root` also sets `color-scheme: dark`,
  so the browser's own controls and scrollbars render dark too.
- **Names keep their stem.** Write the CSS property as `--` plus the token name. A C# or XAML
  reference adapts the casing (`ColorPrimary`) and keeps the stem.
- **No raw literals.** A component references `var(--color-...)`, never a hex value.
- The ramp tokens (`color-green-*`) are declared too, because the chart roles and the palette
  tokens reference them. Components still MUST NOT use them directly.
- `[TODO: clarify]` Whether Finance shares Backlog's component library, and with it Backlog's
  stylesheet with these values swapped in, or keeps its own. See
  `component-libraries.md#risks-and-gaps`.

## Full Token Reference

```meta
status: draft
```

Every colour token and its single value. Anything else in product code is a literal and
MUST be replaced by a token.

| Token | Value |
|---|---|
| `color-primary` | `#59C58B` |
| `color-primary-light` | `#88D3AB` |
| `color-primary-dark` | `#26975B` |
| `color-primary-subtle` | `#0C3B22` |
| `color-secondary` | `#ADB5BD` |
| `color-success` | `#24330F` |
| `color-success-text` | `#A9D274` |
| `color-warning` | `#3D2E00` |
| `color-error` | `#3D0A0D` |
| `color-error-text` | `#EC8E97` |
| `color-info` | `#0B2540` |
| `color-text-primary` | `#F8F9FA` |
| `color-text-secondary` | `#CED4DA` |
| `color-text-disabled` | `#6C757D` |
| `color-text-inverse` | `#121214` |
| `color-text-link` | `#59C58B` |
| `color-background` | `#121214` |
| `color-background-alt` | `#202023` |
| `color-background-raised` | `#353539` |
| `color-background-overlay` | `rgba(0,0,0,0.60)` |
| `color-border` | `#808086` |
| `color-border-strong` | `#9C9CA2` |
| `color-border-focus` | `#59C58B` |
| `color-divider` | `#3F3F44` |

These twenty-four palette tokens, the eleven ramp tokens in `#primary-ramp`, and the derived
tokens in `#amount-tokens` and `#chart-roles` are the whole colour palette.

## App Icon

```meta
status: draft
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

**Windows light and dark mode.** Finance itself is dark only, but the Windows taskbar and
Start menu follow the user's Windows mode, which can be light. The icon is one image for
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
