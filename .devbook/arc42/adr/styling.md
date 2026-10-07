# Styling

```meta
status: proposed
date: 2026-10-08
related: [.devbook/design/README.md, .devbook/design/color-scheme.md#per-stack-token-mapping, .devbook/design/typography-and-layout.md, .devbook/arc42/adr/desktop-stack.md, .devbook/arc42/08-crosscutting-concepts.md#user-interface]
```

Every colour, font, size, and spacing value in Finance's UI is a CSS custom property, declared
once in one `:root` block in a stylesheet of `Finance.UI`. Components use those properties only
and never write a raw value. `.devbook/design/` owns the token names and values.

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

## Rejected

```meta
```

| Alternative | Why it lost |
| --- | --- |
| A Sass variables file compiled to CSS | It adds a compiler to the build of a Razor class library, and Sass variables vanish at compile time, so nothing can read them at runtime. |
| A component library's theme object as the source of the tokens | The values would live in C# in a vendor's shape, and the design folder's token names would no longer be the ones the code uses. |
| Values written in each component's own stylesheet | The same colour drifts across files, and a change means hunting through every component. |
| Inline styles built in C# | They bypass the stylesheet entirely, so neither review nor a token rename can find them. |

## History

```meta
```

| Date | Change |
| --- | --- |
| 2026-10-08 | Proposed: CSS custom properties declared once in `Finance.UI`, with values owned by `.devbook/design/`, adopted from the organization's [ADR 0011](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/adrs/0011-centralized-frontend-styling-variables.md). |
