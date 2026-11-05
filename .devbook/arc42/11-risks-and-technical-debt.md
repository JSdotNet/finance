# 11. Risks and Technical Debt

```meta
```

## Risks

```meta
related: [.devbook/arc42/adr/storage.md, .devbook/arc42/06-runtime-view.md#continue-on-another-pc]
```

| # | Risk | Mitigation direction |
| --- | --- | --- |
| R1 | Finance runs on two PCs at once, or starts before OneDrive finishes a download. | Document one-PC-at-a-time use. |
| R2 | OneDrive's Files On-Demand leaves a file as an online-only placeholder, and opening it offline fails. | Ask the user to keep the folder available offline. Report a clear error for an unreadable file. |
| R3 | The records grow beyond what loading everything at start handles comfortably. | Measure against Q6 in [10](10-quality-requirements.md#quality-scenarios). The file split in [08](08-crosscutting-concepts.md#persistence) allows lazy loading later. |
| R4 | Financial data sits unencrypted in OneDrive. Anyone with access to either account can read it. | Accepted for now. Revisit if the data or the threat changes. |
| R5 | MAUI Blazor Hybrid adds tooling weight, and Playwright's CDP attach to WebView2 may prove brittle. | `Finance.Web` gives a fallback test path. [The desktop stack record](adr/desktop-stack.md) weighs fallback stacks. |

- **R1 consequence:** OneDrive keeps both versions as a conflict copy, or Finance loads stale data.
- **R1 further measures:** Consider a marker file that says which PC has Finance open, and detecting conflict copies on load.

## Open Questions

```meta
related: [.devbook/arc42/05-building-block-view.md#integration-seam, .devbook/arc42/05-building-block-view.md#development-harness]
```

| # | Question | Owner |
| --- | --- | --- |
| O1 | How do the records split across files: one per aggregate, per period, or per collection? | ME, with the domain model |
| O2 | Is `Finance.Web` built, or does Playwright over CDP suffice? | ME |
| O3 | How is the desktop application packaged and installed: MSIX, an unpackaged folder, or something else? | ME |
| O4 | Which external API comes first, and does it need a decision record for credentials and scheduling? | ME, when a concrete need appears |
| O5 | Do production errors go to a local log file, and where? | ME |
| O6 | Are the planned project names in [05](05-building-block-view.md#level-1) the ones the code uses? | Settled by the first implementation |

## Technical Debt

```meta
```

No code exists yet, so Finance carries no technical debt. Debt records will go under `tdr/`
with an index, and this section will link to that index.
