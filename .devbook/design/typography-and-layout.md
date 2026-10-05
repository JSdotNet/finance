# Typography and Layout

```meta
related: [.devbook/design/color-scheme.md, .devbook/design/design-principles.md#low-chrome-content-first, .devbook/design/accessibility.md]
```

> Type scale, fonts, spacing, density, layout, radius, elevation, z-index, and iconography
> tokens for Finance, plus how amounts of money are set. Adapted from Backlog's
> `typography-and-layout.md`, which drew on the JSdotNet design style guide. This file
> declares the non-colour token values. Colour values live in `color-scheme.md`, and every
> other file references token names.

## Font Families

```meta
```

| Token | Value | Usage |
|---|---|---|
| `font-family-base` | `'Inter', 'Segoe UI Variable', 'Segoe UI', sans-serif` | Body text, labels, inputs, amounts |
| `font-family-heading` | `'Poppins', 'Segoe UI Variable', 'Segoe UI', sans-serif` | H1 to H4, display text |
| `font-family-mono` | `'Fira Code', 'Cascadia Mono', Consolas, monospace` | Raw data views, diagnostics, logs |

Rules:

- Every family MUST end in a Windows system fallback, so text stays legible if a bundled
  font fails to load. Finance runs on Windows only, so the fallbacks name Windows fonts
  rather than Backlog's cross-platform chain.
- The fonts MUST ship as `woff2` files in the UI library's own `wwwroot`, loaded with
  `@font-face`. Finance is offline-first, so a web font service is not an option. Backlog
  declared these fonts and never loaded them; Finance MUST NOT repeat that.
- Inter is the amount font because it has tabular figures. See `#amounts`.

## Type Scale

```meta
related: [.devbook/design/accessibility.md#target-sizes-and-text]
```

A modular scale on a 16 px (1 rem) base. Use `rem` in the WebView2 UI. MUST NOT introduce
sizes outside this scale.

| Token | rem | px | Usage |
|---|---|---|---|
| `font-size-xs` | `0.75rem` | 12 | Helper text, badges, fine print |
| `font-size-sm` | `0.875rem` | 14 | Secondary body, table cells, form hints (minimum readable size) |
| `font-size-base` | `1rem` | 16 | Default body text |
| `font-size-lg` | `1.125rem` | 18 | Lead paragraphs, emphasized body |
| `font-size-xl` | `1.25rem` | 20 | Card titles, section sub-labels |
| `font-size-2xl` | `1.5rem` | 24 | H4, a headline amount |
| `font-size-3xl` | `1.875rem` | 30 | H3 |
| `font-size-4xl` | `2.25rem` | 36 | H2 |
| `font-size-5xl` | `3rem` | 48 | H1, display |

Backlog's `font-size-2xs` (10 px) is not carried over. It existed only for Backlog's DEV and
BETA flags.

### Weights, Line Heights, Letter Spacing

```meta
```

| Weight token | Value | Line-height token | Value | Letter-spacing token | Value |
|---|---|---|---|---|---|
| `font-weight-light` | 300 | `line-height-none` | 1 | `letter-spacing-tight` | -0.025em |
| `font-weight-normal` | 400 | `line-height-tight` | 1.25 | `letter-spacing-normal` | 0 |
| `font-weight-medium` | 500 | `line-height-normal` | 1.5 | `letter-spacing-wide` | 0.05em |
| `font-weight-semibold` | 600 | `line-height-relaxed` | 1.75 | `letter-spacing-widest` | 0.1em |
| `font-weight-bold` | 700 | | | | |

Rules:

- Body text MUST NOT go below `font-size-sm` (14 px).
- `font-weight-light` (300) is allowed only at `font-size-3xl` and above.
- Use `font-weight-semibold` (600) for emphasis in body text, not `font-weight-bold`.
- Body text uses `line-height-normal` or `line-height-relaxed`. Headings use
  `line-height-tight`.

### Heading Defaults

```meta
```

| Element | Size | Weight | Line height | Family |
|---|---|---|---|---|
| H1 | `font-size-5xl` | `font-weight-bold` | `line-height-tight` | `font-family-heading` |
| H2 | `font-size-4xl` | `font-weight-bold` | `line-height-tight` | `font-family-heading` |
| H3 | `font-size-3xl` | `font-weight-semibold` | `line-height-tight` | `font-family-heading` |
| H4 | `font-size-2xl` | `font-weight-semibold` | `line-height-tight` | `font-family-heading` |
| H5 | `font-size-xl` | `font-weight-semibold` | `line-height-normal` | `font-family-base` |
| H6 | `font-size-lg` | `font-weight-semibold` | `line-height-normal` | `font-family-base` |
| Body | `font-size-base` | `font-weight-normal` | `line-height-normal` | `font-family-base` |
| Small | `font-size-sm` | `font-weight-normal` | `line-height-normal` | `font-family-base` |
| Mono | `font-size-sm` | `font-weight-normal` | `line-height-relaxed` | `font-family-mono` |

This is the page ramp, for page and section headings. Inside a card or a list row, a
compact ramp from `font-size-lg` down to `font-size-sm` applies, because a 48 px heading
inside a card is a layout, not a heading. A page surface MUST use the table above.

## Amounts

```meta
status: draft
related: [.devbook/design/design-principles.md#exact-amounts, .devbook/design/color-scheme.md#amount-tokens, .devbook/design/accessibility.md#amount-announcements]
```

Every amount of money in Finance is set the same way, by one formatter in the UI library.

| Token | Value | Usage |
|---|---|---|
| `font-variant-amount` | `tabular-nums lining-nums` | Every amount, everywhere |

| Rule | Requirement |
|---|---|
| Tabular figures | An amount MUST use `font-family-base` with `font-variant-amount`, so every digit has the same width and columns line up. |
| Two decimals | An amount MUST show two decimals, including `,00`. A rounded figure is allowed only under `design-principles.md#exact-amounts`. |
| Right-aligned | Amounts in a column or a list MUST be right-aligned, so the decimal separators line up. |
| Sign first | An amount with a direction MUST start with its sign: `+` for money in, `−` (U+2212 MINUS SIGN) for money out. The hyphen-minus `-` and accounting brackets MUST NOT be used. Zero has no sign. |
| Currency symbol | The amount MUST show `€` where the currency is the subject. In a column where every value is in euros, the symbol MAY move to the column header instead. |
| Never truncated | An amount MUST NOT be truncated or wrapped. The label beside it gives up room first. |
| Colour | Colour follows `color-scheme.md#amount-tokens`, and it never replaces the sign. |
| Headline figure | A headline total or balance MAY be set at `font-size-2xl` and `font-weight-semibold`. It keeps every rule above. |

The formatter writes the sign, then the amount as the culture formats a positive currency
value. Under the Dutch culture (`nl-NL`) that gives these forms:

| Value | Shown |
|---|---|
| Money in, 1234.56 | `+€ 1.234,56` |
| Money out, 1234.56 | `−€ 1.234,56` |
| Zero | `€ 0,00` |
| A balance, no direction | `€ 1.234,56` |

`[TODO: clarify]` Whether amounts follow the Windows display culture, or Finance fixes
`nl-NL`. Following Windows is the default until the user decides. All amounts are in euros
until the domain models another currency.

## Spacing Scale

```meta
```

A 4 px (0.25 rem) base with a geometric progression. Always use a scale token. MUST NOT use
one-off values such as `13px`.

| Token | rem | px | Common usage |
|---|---|---|---|
| `spacing-0` | 0 | 0 | Explicit zero |
| `spacing-xs` | 0.25rem | 4 | Icon-to-label gap, badge padding |
| `spacing-sm` | 0.5rem | 8 | Input and button vertical padding, inline gaps, toast gap |
| `spacing-md` | 1rem | 16 | Default component padding, form field spacing |
| `spacing-lg` | 1.5rem | 24 | Small section padding, card header and footer |
| `spacing-xl` | 2rem | 32 | Medium section padding, modal padding |
| `spacing-2xl` | 3rem | 48 | Large section padding, page vertical rhythm |
| `spacing-3xl` | 4rem | 64 | Large whitespace |
| `spacing-4xl` | 6rem | 96 | Wide-window page margins |

## Density

```meta
related: [.devbook/design/design-principles.md#low-chrome-content-first]
```

Default to a **comfortable but compact** density.

| Rule | Requirement |
|---|---|
| Component padding | `spacing-md` inside components, `spacing-lg` or `spacing-xl` for outer sections. |
| List and table rows | Rows use `spacing-sm` vertical padding and MUST keep a pointer target of at least 44 px. See `accessibility.md#target-sizes-and-text`. |
| Line length | Running text SHOULD stay within about 72 to 90 characters per line. |
| No cramped controls | Controls MUST keep their minimum target size at compact density. |

## Layout Grid and Breakpoints

```meta
```

| Concept | Value |
|---|---|
| Column count | 12 |
| Default gutter | `spacing-md` (16 px) |
| Narrow container max-width | 640 px |
| Default container max-width | 1280 px |
| Wide container max-width | 1536 px |
| Breakpoints | `sm` ≥ 640 · `md` ≥ 768 · `lg` ≥ 1024 · `xl` ≥ 1280 · `2xl` ≥ 1536 |

Finance is one desktop window, so the breakpoints are window widths. The layout targets the
`lg` range and up with a navigation rail beside the content. Below `lg`, the rail collapses
to icons with labels in tooltips, and every feature MUST stay usable. At 200% zoom the
content MUST reflow without loss, per `accessibility.md#target-sizes-and-text`.

`[TODO: clarify]` The minimum window size Finance enforces.

## Border Radius and Width

```meta
```

| Radius token | Value | Usage | Width token | Value |
|---|---|---|---|---|
| `border-radius-none` | 0 | Tables | `border-width` | 1px (default) |
| `border-radius-sm` | 0.25rem (4px) | Badges, chips, tags | `border-width-2` | 2px (focus, selected) |
| `border-radius-md` | 0.5rem (8px) | Inputs, buttons, cards (default) | `border-width-4` | 4px (accent stripes, progress) |
| `border-radius-lg` | 1rem (16px) | Large cards, panels, modals | | |
| `border-radius-xl` | 1.5rem (24px) | Feature cards | | |
| `border-radius-full` | 9999px | Pills, avatars | | |

Rules: interactive controls use `border-radius-md`. Focus rings and selected states use
`border-width-2`.

## Shadows and Elevation

```meta
related: [.devbook/design/color-scheme.md#elevation-by-color]
```

Elevation is shown mainly by surface colour (see `color-scheme.md#elevation-by-color`).
Shadows are secondary and MUST be about 30% less opaque than the raw values below on the
dark surfaces.

| Token | Value | Usage |
|---|---|---|
| `shadow-none` | none | Flat surfaces |
| `shadow-sm` | 0 1px 2px rgba(0,0,0,0.05) | Subtle lift: inputs, inline chips |
| `shadow-md` | 0 4px 6px rgba(0,0,0,0.10) | Default card elevation |
| `shadow-lg` | 0 10px 15px rgba(0,0,0,0.15) | Dropdowns, popovers |
| `shadow-xl` | 0 20px 25px rgba(0,0,0,0.20) | Modals, drawers, toasts |
| `shadow-inner` | inset 0 2px 4px rgba(0,0,0,0.06) | Pressed states, inset inputs |

### Z-Index Scale

```meta
```

| Token | Value | Layer |
|---|---|---|
| `z-index-base` | 0 | Document flow |
| `z-index-raised` | 10 | Sticky headers, table headers |
| `z-index-dropdown` | 100 | Dropdown menus, popovers |
| `z-index-overlay` | 200 | Side drawers, slide-over panels |
| `z-index-modal` | 300 | Modal dialogs |
| `z-index-toast` | 400 | Toasts, save-state notifications |
| `z-index-tooltip` | 500 | Tooltips (always on top) |

MUST NOT use arbitrary z-index values such as `9999`. Use only the scale.

## Iconography

```meta
related: [.devbook/design/accessibility.md#iconography-accessibility, .devbook/design/color-scheme.md#app-icon]
```

The icon library is **Lucide**: outline icons with a 2 px stroke on a 24 × 24 grid. A
substitute is allowed only if it is a stroke-based SVG at about 2 px weight, added to a
project-local registry. The app icon is not part of this set. It is specified in
`color-scheme.md#app-icon`.

| Token | Size | Usage |
|---|---|---|
| `icon-xs` | 12px | Inline badge indicator |
| `icon-sm` | 16px | Inline text icons, dense table actions, refresh spinner |
| `icon-md` | 20px | Default in buttons, inputs, navigation items, drag handle |
| `icon-base` | 24px | Standalone icon on the base grid |
| `icon-lg` | 32px | Section headers |
| `icon-xl` | 48px | Empty-state illustrations |
| `icon-2xl` | 64px | Large empty states only |

Rules:

- Icons inherit colour through `currentColor`. Product code MUST NOT hard-code `fill` or
  `stroke`. The default icon colour is `color-text-primary`, and supporting icons use
  `color-text-secondary`.
- Size icons with explicit width and height, never with `font-size`.
- An icon MUST meet 3:1 contrast against its background and MUST NOT be the only carrier of
  meaning. See `accessibility.md#iconography-accessibility`.
- An icon-only control needs an accessible name and a target of at least 44 × 44 px.
- Standard icons: `check-circle` (success), `alert-triangle` (warning), `x-circle` (error),
  `info` (info), `loader-2` (loading), `grip-vertical` (drag handle).
- The icons MUST be bundled with the UI library, not fetched at run time.

## Metadata Lines

```meta
related: [.devbook/design/color-scheme.md#badge-and-chip-tones, .devbook/design/accessibility.md#iconography-accessibility]
```

A metadata line is the run of small facts set beside or under a title, such as a date, a
count, or a tag. It is one pattern wherever it appears.

| Rule | Requirement |
|---|---|
| Size | A metadata line is set at `font-size-xs` in `color-text-secondary`. It MUST NOT compete with its title. |
| Order | Facts are ordered by what a reader asks first: what the item belongs to, then how far along it is, then when it happens. |
| Emphasis | A fact that makes the item urgent MAY take `color-text-primary`. At most two facts on a line may be brought forward. |
| Glyphs | A glyph decorates the words and never replaces them. The glyph is `aria-hidden`, and its meaning is in text or a visually hidden span. |
| Absent facts | An absent fact is left out, never shown as a placeholder or a dash. |
| Tags | Tags are chips, set smaller than the title, so a chip cannot outshout the title. |
| Truncation | The metadata line gives up room before the title. Truncated text MUST stay in the DOM, so a screen reader still reads it. |
| Amounts | An amount on a metadata line keeps every rule in `#amounts`, and is never the part that gets truncated. |
