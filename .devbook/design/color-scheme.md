# Color Scheme

```meta
status: draft
related: [.devbook/design/design-principles.md#dark-mode-only, .devbook/design/accessibility.md#contrast]
```

> The dark colour palette and semantic design tokens for Finance. Finance is dark mode only,
> like Backlog, so every token has exactly one value. The token set is Backlog's, adapted
> around a money-green primary. This file is the single source of token values. Every other
> file in `.devbook/design/` and all product code reference token names only.

```annotation
kind: suggestion
author: "claude/prose-check"
date: 2026-10-21
quote: "The dark colour palette and semantic design tokens for Finance."
body: |
  [minor] Prose (restated heading): The verbless lead restates the title; start at "Finance is dark mode only".
```

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
- **The Finance App Design.** The artifact named in `README.md#provenance` was compared
  with this file on 2026-10-21. Its boards are drawn light, so their colours are translated
  by role onto this dark palette, and `#finance-app-design-mapping` lists every one. The
  comparison added `color-info-text`, `color-warning-text`, three chart ramp steps, and four
  chart roles.

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
and its text is `color-text-primary`. The four `-text` tokens are the foregrounds, for a
status line, a figure, an icon, or an outline with no semantic surface behind it. They are
never painted as a background. Backlog had no warning or info foreground; the Finance App
Design sets caution figures in orange and the financial room in blue, so Finance adds both.

| Token | Value | Usage |
|---|---|---|
| `color-success` | `#24330F` | Success banners, confirmation panels |
| `color-success-text` | `#A9D274` | Success text and icons, and money coming in (see `#amount-tokens`) |
| `color-warning` | `#3D2E00` | Warning banners, caution panels |
| `color-warning-text` | `#F0A46E` | A figure over its budget, an expired contract, the edge of a caution card |
| `color-error` | `#3D0A0D` | Error banners, validation summaries |
| `color-error-text` | `#EC8E97` | Error text, icons, and invalid input outlines |
| `color-info` | `#0B2540` | Informational notices, a highlighted total row |
| `color-info-text` | `#8DB4F2` | The financial room and other figures the product points out, not as a status |

```annotation
kind: question
author: "claude/chapter-review"
date: 2026-10-21
quote: "The financial room and other figures"
body: |
  [minor] Vocabulary: "the financial room" is used as a product concept here, in #chart-roles and in #finance-app-design-mapping (with "net income" and "pension pot"), but .devbook/domain/finance/domain.md defines no term yet, and devbook-design.md says design/ uses the ubiquitous language from the domain term chapters. Will "financial room" be a domain term? Settle: name it in domain/ when it is modelled, or describe the usage here generically ("a figure the product points out") without the domain noun.
```

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

**Two foregrounds added.** `color-warning-text` (25°, 81%, 69%) and `color-info-text`
(217°, 80%, 75%) carry the orange and blue the Finance App Design sets figures in. Each is
the hue of its own surface, lightened until it clears 4.5:1 on every surface and on that
surface. Blue sits 69° from the primary and orange 123°, so neither reads as another green.

```annotation
author: "claude/chapter-review"
date: 2026-10-21
quote: "Two foregrounds added."
body: |
  [minor] "Each is the hue of its own surface" holds for info (color-info #0B2540 is 211 deg, color-info-text 217 deg) but not for warning: color-warning #3D2E00 computes to hue 45 deg (amber) and color-warning-text #F0A46E to 25 deg (orange), a 20 deg gap. Settle: say warning-text was taken from the board orange rather than the surface hue, or re-derive it near 45 deg and re-measure #measured-pairs.
```

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

```annotation
kind: suggestion
author: "claude/prose-check"
date: 2026-10-21
quote: "Two tokens are new."
body: |
  [minor] Prose (stale name): The section says only two tokens are new and every other keeps Backlog's name, but the same file adds color-warning-text and color-info-text; correct the count or name all four.
```

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

```annotation
kind: question
author: "claude/chapter-review"
date: 2026-10-21
quote: "Totals and balances"
body: |
  [major] #finance-app-design-mapping maps "#12784A A change for the better: income up, debt down" to color-success-text and "#B42318 A loss" to color-error-text, but this chapter defines colour only by direction of money (in / out / flagged). A debt going down is not money coming in, a change for the worse (income down) has no token at all, and a loss is painted red although this chapter keeps red for "a figure that needs action". Is a change (a delta) an amount with a direction, and which sign and token does it take? Settle: add change tokens (e.g. color-change-better / color-change-worse referencing palette tokens) with their sign rule, or remap those board rows onto the three existing amount tokens.
```

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

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "Filled means the product acts on it."
body: |
  [medium] The rule says filled means "the product acts on it ... a filled chip in a list is always the one to look at", but settled ("Finished and correct") is filled while live ("the product may act on it") is outlined. #finance-app-design-mapping now sends the boards' most frequent pills (Active, In contract, Renews yearly, On track, Funded, Paid off) to settled, so most rows would carry a filled chip and the attention signal is lost. This chapter carries no status, so it is binding as written. Settle: make settled outlined (filled only for alert and fault), or restate what filled means.
```

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
| `chart-ramp-1` | `color-green-600` | 3.07:1 |
| `chart-ramp-2` | `color-green-500` | 4.38:1 |
| `chart-ramp-3` | `color-green-400` | 7.57:1 |
| `chart-ramp-4` | `color-green-300` | 9.25:1 |
| `chart-ramp-5` | `color-green-200` | 11.46:1 |
| `chart-ramp-6` | `color-green-100` | 13.69:1 |
| `chart-ramp-7` | `color-green-50` | 15.14:1 |
| `chart-highlight` | `color-info-text` | 7.69:1 |
| `chart-forecast` | `#4F7FD0` | 4.09:1 |
| `chart-money-in` | `color-info-text` | 7.69:1 |
| `chart-money-out` | `color-warning-text` | 7.92:1 |
| `chart-track` | `color-green-900` | 1.29:1 |
| `chart-grid` | `color-divider` | 1.55:1 |
| `chart-axis` | `color-border-strong` | 5.95:1 |
| `chart-ink` | `color-text-primary` | 15.42:1 |
| `chart-ink-muted` | `color-text-secondary` | 10.88:1 |

The ramp ran four steps, `green-500` to `green-200`. The Finance App Design splits net
income into eight parts, so it now runs seven, `green-600` to `green-50`, and the old
`chart-ramp-1` to `chart-ramp-4` are now `chart-ramp-2` to `chart-ramp-5`. `chart-forecast`
is the one chart value with no palette token of its own: the info hue, 218°, 58%, 56%,
darker than `chart-highlight` so a forecast reads as less certain than a fact.

Rules:

- **Charts are green, with one highlight.** A part-to-whole chart uses the ordinal ramp. One
  part the chart is about, such as the financial room, MAY take `chart-highlight` instead,
  with its forecast months in `chart-forecast`. The highlight is blue, the only second hue a
  chart may carry. This is Backlog's single-hue rule, widened for the Finance App Design.
- **Money in and money out may share a plot.** A chart comparing income with spending draws
  them as `chart-money-in` and `chart-money-out`, each with a legend label. Any other two
  measures are drawn as two charts, never as two series on one plot.
- **A higher ramp step is lighter**, so "more" always means "stands out more" on the dark
  surface. The largest part takes the highest step.
- Every ramp step clears the 3:1 a non-text mark owes its background. The steps are taken
  from the ramp rather than mixed toward the surface, so each value is one this file
  already names. A chart with more parts than steps folds the smallest into "Other".
- The track is deliberately below 3:1, because it shows the absence of data. Gridlines are
  decorative, and the baseline takes `chart-axis`, because a baseline carries meaning.
- A chart MUST NOT be the only way to read its numbers. The same figures MUST be available
  as text or a table.

```annotation
kind: flag
author: "claude/chapter-review"
date: 2026-10-21
quote: "Money in and money out may share a plot."
body: |
  [major] chart-money-out resolves to color-warning-text (#F0A46E), the same value #semantic reserves for "a figure over its budget, an expired contract", so every income-vs-expenses chart paints ordinary spending in the caution colour. #amount-tokens says the opposite on purpose ("Money going out is not red ... would make the ordinary case an alarm"). Income also changes hue between views: color-amount-positive is the yellow-green color-success-text in a table, but chart-money-in is the blue color-info-text in a chart. And the rule above ("The highlight is blue, the only second hue a chart may carry") is contradicted by this rule admitting orange as a third hue. Settle: give chart-money-in/out roles that match #amount-tokens (e.g. money-in = color-amount-positive, money-out = a neutral such as color-text-secondary or chart-axis), or keep blue/orange and state explicitly why a chart may use the warning hue for routine spending, and reword the single-second-hue rule.
```

```annotation
kind: flag
author: "claude/chapter-review"
date: 2026-10-21
quote: "A higher ramp step is lighter"
body: |
  [major] chart-ramp-7 is color-green-50 (#F0F9F4, 15.14:1 on color-background-alt, re-computed), and this rule gives the highest step to the largest part, so the biggest segment of every part-to-whole bar (net income split, pension pots; #finance-app-design-mapping row #0E5E50 -> chart-ramp-7) is a near-white block. design-principles.md#dark-mode-only (Media) says charts MUST be authored for dark surfaces "with no glaring white blocks". Settle: stop the ramp at green-200 or green-100 and fold more parts into "Other", or reverse which end the largest part takes, or write an explicit exception into the Media rule.
```

## Contrast Rules

```meta
status: draft
related: [.devbook/design/accessibility.md#contrast]
```

WCAG 2.2 Level AA is the minimum. Primary body text targets AAA.

| Pairing | Minimum | Notes |
|---|---|---|
| `color-text-primary` on `color-background` | **7:1** (AAA target) | Content must be as legible as possible. |
| `color-text-secondary` on any surface | **4.5:1** | Supporting text and chrome. |
| Text on a semantic surface | **4.5:1** | Semantic surfaces are backgrounds. |
| `color-success-text`, `color-warning-text`, `color-error-text`, `color-info-text`, `color-primary` as text, on any surface | **4.5:1** | They appear as text on all three surfaces. |
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

```annotation
author: "claude/chapter-review"
date: 2026-10-21
quote: "Every binding pair, measured. All pass."
body: |
  [minor] All 43 listed ratios were re-computed with the WCAG formula and match. But #contrast-rules binds the four -text foregrounds, color-primary and color-text-secondary "on any surface", and two surfaces that carry them are not measured: color-primary-subtle (selected row, active nav link) and color-info (highlighted total row; demo-template .data tr.highlight). Computed, they all pass: color-success-text on primary-subtle 7.30:1, color-error-text on primary-subtle 5.34:1, color-text-secondary on primary-subtle 8.44:1, color-success-text on color-info 8.99:1, color-text-secondary on color-info 10.39:1; color-border-strong as a filled badge edge on success / warning / error is 4.94 / 4.84 / 6.16:1. Settle: add these rows so "every binding pair" holds.
```

```annotation
kind: suggestion
author: "claude/prose-check"
date: 2026-10-21
quote: "Every binding pair, measured."
body: |
  [minor] Prose (telegraphic): Two fragments; write "Every binding pair is measured below, and all pass."
```

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
| `color-warning-text` on `color-background` | 4.5:1 | **9.12:1** |
| `color-warning-text` on `color-background-alt` | 4.5:1 | **7.92:1** |
| `color-warning-text` on `color-background-raised` | 4.5:1 | **5.95:1** |
| `color-warning-text` on `color-warning` | 4.5:1 | **6.44:1** |
| `color-info-text` on `color-background` | 4.5:1 | **8.86:1** |
| `color-info-text` on `color-background-alt` | 4.5:1 | **7.69:1** |
| `color-info-text` on `color-background-raised` | 4.5:1 | **5.78:1** |
| `color-info-text` on `color-info` | 4.5:1 | **7.35:1** |
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

```annotation
kind: suggestion
author: "claude/prose-check"
date: 2026-10-21
quote: "Elevation is expressed mainly by a"
body: |
  [minor] Prose (restated heading): The first sentence restates the heading; "mainly" is a hedge on a rule, and typography-and-layout.md#shadows-and-elevation repeats the sentence, so keep it in one file.
```

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

```annotation
author: "claude/chapter-review"
date: 2026-10-21
quote: "Names keep their stem."
body: |
  [minor] arc42/adr/styling.md says design/ "already declares every token as a CSS custom property, in the token mapping and in typography and layout", but this table lists four tokens and typography-and-layout.md lists none as CSS properties; the rest follow only from the stem rule. Settle: say here that the table is illustrative and every token maps by the stem rule (and align the ADR wording in its own change), or list the full property set.
```

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
| `color-warning-text` | `#F0A46E` |
| `color-error` | `#3D0A0D` |
| `color-error-text` | `#EC8E97` |
| `color-info` | `#0B2540` |
| `color-info-text` | `#8DB4F2` |
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

These twenty-six palette tokens, the eleven ramp tokens in `#primary-ramp`, and the derived
tokens in `#amount-tokens` and `#chart-roles` are the whole colour palette.

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "These twenty-six palette tokens"
body: |
  [minor] chart-forecast is the raw literal #4F7FD0, not a palette or ramp token, yet #dark-palette says "These are the only colour values the product uses", #amount-tokens says derived tokens add no new colour, this chapter says anything else is a literal that MUST be replaced, and README.md#provenance says every board value was given a token. Settle: declare it as a palette token (e.g. color-info-muted, with its measured ratio) and reference that from #chart-roles, or name chart-forecast here as the one sanctioned literal.
```

## Finance App Design Mapping

```meta
status: draft
related: [.devbook/design/README.md#provenance, .devbook/design/design-principles.md#dark-mode-only]
```

Every colour the eleven boards of the Finance App Design use, and the token that takes its
place. The boards are drawn on a light page, and Finance is dark mode only, so no board value
is carried over as it is. Each is mapped **by role**: the token that does the same job on the
dark surfaces. A value with two jobs has a row per job. "Dark value" is what Finance paints.

```annotation
kind: suggestion
author: "claude/prose-check"
date: 2026-10-21
quote: "Every colour the eleven boards of the Finance App Design use"
body: |
  [minor] Prose (telegraphic): The opening sentence has no verb; write "This table lists every colour the boards use and the token that replaces it."
```

| Board value | Its job on the boards | Token | Dark value |
|---|---|---|---|
| `#F4F5F2` | Page background, a group row in a table | `color-background` | `#121214` |
| `#FAFBF9` | A step box set into a card | `color-background` | `#121214` |
| `#FFFFFF` | Card, input, button, and segmented-control surface | `color-background-alt` | `#202023` |
| `#FFFFFF` | Navigation brand text, hovered link text | `color-text-primary` | `#F8F9FA` |
| `#FFFFFF` | Text on a primary button or a selected chip | `color-text-inverse` | `#121214` |
| `#0F1F1A` | Navigation sidebar | `color-background-alt` | `#202023` |
| `#0F1F1A` | Selected segment or chip | `color-primary-subtle` | `#0C3B22` |
| `#1B3029` | Hovered navigation link | `color-background-raised` | `#353539` |
| `#E3F1EC` | Active navigation link, a highlighted step | `color-primary-subtle` | `#0C3B22` |
| `#E8EEEA` | Navigation text | `color-text-primary` | `#F8F9FA` |
| `#15201C` | Body text, headings, values | `color-text-primary` | `#F8F9FA` |
| `#15201C` | The current-month outline, a dashed reference line | `chart-ink` | `#F8F9FA` |
| `#C9D4CE` | Navigation link text | `color-text-secondary` | `#CED4DA` |
| `#5B6660` | Muted text, labels, table headers | `color-text-secondary` | `#CED4DA` |
| `#4A544F` | Ink of a grey pill | `color-secondary` | `#ADB5BD` |
| `#CBD2CC` | Button, input, chip, and segmented-control edge, a dashed placeholder | `color-border` | `#808086` |
| `#CBD2CC` | Chart baseline, a legend swatch's edge | `chart-axis` | `#9C9CA2` |
| `#8A948E` | Dashed schedule line, a "not updated" bar, a neutral column | `chart-axis` | `#9C9CA2` |
| `#E2E5E0` | Card edge, table header rule | `color-divider` | `#3F3F44` |
| `#EEF0EC` | Table row rule | `color-divider` | `#3F3F44` |
| `#EEF0EC` | Progress-bar track | `chart-track` | `#0C3B22` |
| `#0E5E50` | Primary button, link, slider, a selected card's edge | `color-primary` | `#59C58B` |
| `#0E5E50` | A single chart series | `chart-series` | `#59C58B` |
| `#0E5E50` | The largest part of a part-to-whole bar | `chart-ramp-7` | `#F0F9F4` |
| `#0A463C` | Hovered link | `color-primary-light` | `#88D3AB` |
| `#3A8573` | Second part | `chart-ramp-6` | `#DAF1E5` |
| `#4A7F70` | A secondary series' label | `chart-ramp-6` | `#DAF1E5` |
| `#6BA898` | Third part | `chart-ramp-5` | `#B5E3CA` |
| `#4F9C88` | A progress fill, a pension pot | `chart-ramp-5` | `#B5E3CA` |
| `#9BC6B8` | Fourth part, a light swatch's edge | `chart-ramp-4` | `#88D3AB` |
| `#BDD9CF` | Fifth part | `chart-ramp-3` | `#59C58B` |
| `#D3E6DF` | Sixth part | `chart-ramp-2` | `#26975B` |
| `#CFE3DB` | The smallest pension pot | `chart-ramp-2` | `#26975B` |
| `#E2EEE9` | Seventh part | `chart-ramp-1` | `#197B47` |
| `#ECF3F0` | Eighth part | `chart-ramp-1` | `#197B47` |
| `#BFDDD1` | Edge of a highlighted step | `color-primary-dark` | `#26975B` |
| `#12784A` | A change for the better: income up, debt down | `color-success-text` | `#A9D274` |
| `#2457C5` | The financial room, as a figure | `color-info-text` | `#8DB4F2` |
| `#2457C5` | The financial room, as a bar | `chart-highlight` | `#8DB4F2` |
| `#2457C5` | Net income beside expenses | `chart-money-in` | `#8DB4F2` |
| `#A9BFEA` | A forecast month of the financial room | `chart-forecast` | `#4F7FD0` |
| `#1D4AA8` | A figure pointed out, such as a multiplier | `color-info-text` | `#8DB4F2` |
| `#F1F5FC` | The financial-room row, a note panel | `color-info` | `#0B2540` |
| `#D9661F` | Expenses beside net income | `chart-money-out` | `#F0A46E` |
| `#B4490F` | A month over budget, an expired contract | `color-warning-text` | `#F0A46E` |
| `#F2C4A6` | Edge of a caution card | `color-warning-text` | `#F0A46E` |
| `#B42318` | A loss, a figure the product flags | `color-error-text` | `#EC8E97` |

Two board values map to one token where they differ by less than one shade: `#ECF3F0`
and `#E2EEE9` both take `chart-ramp-1`, and `#CFE3DB` and `#D3E6DF` both take
`chart-ramp-2`. The board splits net income into eight parts and the ramp has seven steps,
so its two smallest parts share a step; a chart built on the tokens folds them into "Other".

```annotation
kind: suggestion
author: "claude/prose-check"
date: 2026-10-21
quote: "Two board values map to one token where they differ"
body: |
  [minor] Prose (overlong sentence): The sentence carries two pairs of hex values and a rule; split it, or move the pairs into the table.
```

**Pills.** The boards colour pills with a fill and an ink of their own. Each pill takes a tone
from `#badge-and-chip-tones` instead, and the tokens that tone derives from replace these
fills and inks: `#E3F1EC` on `#0E5E50`, `#FDEBDD` on `#8A3A0F`, `#FBE4E2` on
`#9A1C12`, `#E6EDFA` on `#1D4AA8`, `#EEF0EC` on `#4A544F`, and `#F1E8F7` on `#6B2E8F`.

```annotation
kind: suggestion
author: "claude/prose-check"
date: 2026-10-21
quote: "Each pill takes a tone"
body: |
  [minor] Prose (overlong sentence): The sentence runs a six-pair hex list into the clause; split off the list as a bulleted or tabled list.
```

| Board pill | Tone |
|---|---|
| `ok`: Active, In contract, Renews yearly; On track, Funded, Paid off | `settled` |
| `warn`: Check, Monthly cancellable, Price doubled; Behind | `alert` |
| `bad`: Out of contract | `fault` |
| `info`: Switch window open; a goal part-way, such as 81% | `live` |
| `off`: Not linked | `quiet` |
| `off`: Cancelled | `archived` |
| An area: Energy, Pension, Subscription, Debt | `quiet` |

The area pills are categories, not states, so they spend no colour; their word tells them
apart. The board gives each area its own hue, purple included, and a seventh tone is not
allowed.

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
