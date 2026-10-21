# Styling

```meta
status: proposed
date: 2026-10-08
related: [.devbook/design/README.md, .devbook/design/color-scheme.md#per-stack-token-mapping, .devbook/design/typography-and-layout.md, .devbook/arc42/adr/desktop-stack.md, .devbook/arc42/08-crosscutting-concepts.md#user-interface]
```

Every colour, font, size, and spacing value in Finance's UI is a CSS custom property, declared
once in one `:root` block in a stylesheet of `Finance.UI`. Components use those properties only
and never write a raw value. `.devbook/design/` owns the token names and values.

```annotation
kind: question
author: "claude/chapter-review"
date: 2026-10-21
quote: "once in one `:root` block in a stylesheet of `Finance.UI`"
body: |
  [minor] Depends on an open question: design/color-scheme.md#per-stack-token-mapping and component-libraries.md carry a TODO on whether Finance reuses Backlog's component library (Backlog.UI.Components) as a shared package with Finance's values swapped in. If it does, the :root block lives in that package, not in Finance.UI. Settle the TODO, or state here that the record assumes Finance keeps its own library.
```

## Why

```meta
```

- One declaration means a change to a colour or a size is one edit, and every screen follows.
- A token name says what a value is for, such as `--color-primary`, where a hex value says
  nothing.
- CSS custom properties need no build step. A Razor class library can ship a plain stylesheet,
  so Finance adds no Sass compiler to its build.
- The values are live at runtime. Component-scoped `.razor.css` files read them with `var()`,
  and a chart library can read them from the page to build its theme.
- [The design folder](../../design/README.md) already declares every token as a CSS custom
  property, in [the token mapping](../../design/color-scheme.md#per-stack-token-mapping) and in
  [typography and layout](../../design/typography-and-layout.md). This record holds only the
  mechanism and links there for the values.
- Code review rejects a component style that writes a hex value, a font name, or a size
  directly.

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "Code review rejects a component style that writes a hex value"
body: |
  [minor] Enforcement by review alone is the very option modularity.md rejects (review misses a stray reference; a test fails the build instead). A raw hex, font name, or px value in a .razor.css or .css under Finance.UI is mechanically detectable. Name a check (a stylelint rule, or a file-based script under scripts/ per scripting.md) that fails the build, or say why review suffices here.
```

## Rejected

```meta
```

| Alternative | Why it lost |
| --- | --- |
| A Sass variables file compiled to CSS | It adds a compiler to the build of a Razor class library, and Sass variables vanish at compile time, so nothing can read them at runtime. |
| A component library's theme object as the source of the tokens | The values would live in C# in a vendor's shape, and the design folder's token names would no longer be the ones the code uses. |
| Values written in each component's own stylesheet | The same colour drifts across files, and a change means hunting through every component. |
| Inline styles built in C# | They bypass the stylesheet entirely, so neither review nor a token rename can find them. |

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "Inline styles built in C#"
body: |
  [minor] Gap: some values are data, not tokens, and Razor components routinely bind them inline, such as a bar width as a percentage or a chart height computed from the records. The rule that components never write a raw value, plus this rejection, would forbid them. Say whether computed geometry may be bound inline (for example as a custom property set on the element) while colours, fonts, and spacing stay tokens only.
```

## History

```meta
```

| Date | Change |
| --- | --- |
| 2026-10-08 | Proposed: CSS custom properties declared once in `Finance.UI`, with values owned by `.devbook/design/`, adopted from the organization's [ADR 0011](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/adrs/0011-centralized-frontend-styling-variables.md). |

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "| Date | Change |"
body: |
  [minor] The History table is headed Date | Change, but devbook-arc42.md fixes the header as Date | Change | Why, and build.mjs --check warns on it. Split the row's reason into its own Why column (here: adopted from the organization's ADR 0011 is the why).
```
