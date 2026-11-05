# Component Libraries

```meta
related: [.devbook/arc42/04-solution-strategy.md#local-first-desktop-application, .devbook/design/color-scheme.md#per-stack-token-mapping, .devbook/design/accessibility.md#keyboard-navigation]
```

> The component-library recommendation for Finance's one channel: a .NET MAUI Blazor Hybrid
> desktop app that renders Razor components in WebView2. The stack is fixed by
> [the desktop stack record](../arc42/adr/desktop-stack.md). This file recommends the
> component layer on top of it. It adds no dependency: a package is adopted through the
> package-update workflow and then recorded in `.devbook/tech/`. No packages were installed.
> Where a claim is a judgement rather than a fact, the text says so.

## Evaluation Criteria

```meta
```

| # | Criterion | Why it matters |
|---|---|---|
| C1 | One light theme | Finance ships one light theme, the Finance App Design's, with a dark sidebar. A library must take the light tokens without a dark default to undo. See `design-principles.md#one-light-theme`. |
| C2 | Theming through CSS custom properties | The tokens are CSS custom properties. A library that keeps its own palette has to be overridden everywhere. See `color-scheme.md#per-stack-token-mapping`. |
| C3 | Data tables and amounts | Money is shown in columns that must right-align tabular figures. See `typography-and-layout.md#amounts`. |
| C4 | Accessible reorder | Reordering needs a keyboard path. See `interaction-guidelines.md#keyboard-accessible-reordering`. |
| C5 | Accessibility (WCAG 2.2 AA) | Semantics, focus, and announcements must be right. See `accessibility.md`. |
| C6 | Maintenance, license, offline | Prefer maintained, permissively licensed packages whose assets ship inside the app, because Finance works offline. |
| C7 | Charts | Overviews of money over time are likely, and a chart must follow `color-scheme.md#chart-roles`. |

## Key Finding

```meta
```

The design tokens are the shared layer, not a component suite. Backlog reached the same
conclusion and built its own Razor class library on top of its tokens. A third-party suite
brings its own visual language, Fluent or Material, and making it look like Backlog's system
means overriding that language on every component. A first-party library starts from the
tokens and has nothing to override.

The cost is that accessibility semantics, keyboard support, and reorder are Finance's own
work rather than inherited. Backlog's experience is that this cost is real but bounded.
That is a judgement, drawn from Backlog's record, not a measurement for Finance.

## Recommendation

```meta
related: [.devbook/design/color-scheme.md#chart-roles, .devbook/design/interaction-guidelines.md#drag-and-drop-reordering]
```

| Layer | Recommendation | Rationale |
|---|---|---|
| Base controls | **A first-party Razor class library**, the UI project `Finance.UI`, styled only by the tokens | Same choice and same reasons as Backlog. Nothing to override, and every component reviewable in one place. |
| Data tables | **QuickGrid** (`Microsoft.AspNetCore.Components.QuickGrid`), styled by the tokens | First-party from the ASP.NET Core team, MIT, unstyled, with sorting and virtualization. |
| Charts | **Apache ECharts**, vendored into `Finance.UI`'s `wwwroot` | Backlog's recommendation. Broad chart coverage, Apache-2.0, and a theme object that can take the chart-role tokens. |
| Reorder | **Hand-rolled on pointer events** in the UI library, with the keyboard path built in | WebView2 in the MAUI desktop head aborts a native HTML5 drag, per Backlog's measurement. |
| Icons | **Lucide** SVGs, vendored into the UI library | See `typography-and-layout.md#iconography`. |
| Fonts | Hanken Grotesk and IBM Plex Mono as `woff2` files in the UI library | See `typography-and-layout.md#font-families`. |

- **Data tables:** QuickGrid renders a real `<table>`. Finance has to add cell-level arrow-key navigation, which QuickGrid does not include.
- **Charts:** The `aria` option of ECharts can generate a text description.
- **Reorder:** The abort comes a few milliseconds after the drag starts, so no `dragover` or `drop` event arrives. A library built on drag events has nothing to hook. Finance runs on the same stack.

Every asset MUST ship inside the app. A CDN is acceptable only during development, and only
with a visible fallback when it fails.

## Candidate Comparison

```meta
```

Rating: ✔ strong · ◑ partial or with work · ✘ weak or absent · — not applicable.

| Candidate | Role | C1 Light theme | C2 CSS tokens | C3 Tables | C4 Reorder | C5 A11y | C6 Maintenance and license |
|---|---|---|---|---|---|---|---|
| **First-party Razor class library** | Base controls | ✔ | ✔ | ◑ (with QuickGrid) | ◑ (built by hand) | ◑ (built by hand) | ✔ (ours) |
| **QuickGrid** | Tables | ✔ (unstyled) | ✔ | ✔ | — | ◑ (semantic table, no cell navigation) | ✔ MIT, first-party |
| **FluentUI-Blazor** | Base controls | ✔ | ◑ (Fluent tokens to map) | ✔ (data grid) | ◑ | ✔ | ✔ MIT |
| **MudBlazor** | Base controls | ✔ (`MudTheme`) | ◑ (Material palette to map) | ✔ (data grid) | ◑ (drop container, drag events) | ◑ | ✔ MIT |
| **Radzen Blazor** | Base controls, charts | ✔ | ◑ | ✔ (data grid) | ◑ | ◑ | ✔ MIT |
| **Apache ECharts** | Charts | ✔ (theme objects) | ◑ (values passed from tokens) | — | — | ◑ (`aria` option, needs a text alternative) | ✔ Apache-2.0 |
| **Chart.js** | Charts | ✔ | ◑ | — | — | ✘ (canvas, no built-in description) | ✔ MIT |

The ratings for the third-party suites are a judgement from their documentation and from
Backlog's evaluation. None was tried in Finance.

## Risks and Gaps

```meta
```

| Risk or gap | Impact | Mitigation |
|---|---|---|
| A first-party library inherits no accessibility work | Keyboard support, focus order, and announcements are all Finance's own work | Test them: Playwright with axe, per `accessibility.md#verification`. |
| QuickGrid has no cell navigation | A keyboard user can tab to a row's controls but cannot move cell by cell | Add arrow-key navigation in the table component, or accept row-level navigation and record it. |
| Chart libraries are canvas-based | A canvas exposes nothing to a screen reader | Every chart has the same figures as a table or text, per `accessibility.md#amount-announcements`. |
| Assets fetched from a CDN | Breaks offline use, and tells a third party when Finance is used | Vendor every asset into `wwwroot`. Finance MUST NOT repeat Backlog's CDN gap. |
| Two apps, two copies of one library | Backlog and Finance would each keep a near-identical set of components | `[TODO: clarify]` Whether Finance reuses Backlog's `Backlog.UI.Components` or keeps its own `Finance.UI`. |
| Number formatting spread across components | Two components format the same amount differently | One amount formatter in the UI library, per `typography-and-layout.md#amounts`. |

- **Assets fetched from a CDN:** Backlog shipped Mermaid from a CDN and recorded it as a gap.
- **Two apps, two copies of one library:** Reuse could be a shared package with Finance's token values. Sharing saves work, but Backlog is dark and Finance light, so only the components would be shared, not the stylesheet. It also couples Finance's releases to Backlog's.
