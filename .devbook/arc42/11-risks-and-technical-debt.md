# 11. Risks and Technical Debt

```meta
status: draft
```

The risks the current architecture carries, the questions it leaves open, and its debt.

## Risks

```meta
status: draft
related: [.devbook/arc42/adr/storage.md, .devbook/arc42/06-runtime-view.md#continue-on-another-pc]
```

| # | Risk | Mitigation direction |
| --- | --- | --- |
| R1 | Finance runs on two PCs at once, or starts before OneDrive finishes a download. OneDrive then keeps both versions as a conflict copy, or Finance loads stale data. | Document one-PC-at-a-time use. Consider a marker file that says which PC has Finance open, and detecting conflict copies on load. |
| R2 | OneDrive's Files On-Demand leaves a file as an online-only placeholder, and opening it offline fails. | Ask the user to keep the data folder always available offline, and report a clear error when a file cannot be read. |
| R3 | The records grow beyond what loading everything at start handles comfortably. | Measure against Q6 in [10](10-quality-requirements.md#quality-scenarios). The file split in [08](08-crosscutting-concepts.md#persistence) allows lazy loading later. |
| R4 | Financial data sits unencrypted in the OneDrive folder. Anyone with access to the Windows or OneDrive account can read it. | Accepted for now. Revisit if the data or the threat changes. |
| R5 | MAUI Blazor Hybrid adds tooling weight, and Playwright's CDP attach to WebView2 may prove brittle. | The optional `Finance.Web` harness gives a fallback test path. The fallback stacks are weighed in [the desktop stack record](adr/desktop-stack.md). |

```annotation
author: "claude/chapter-review"
date: 2026-10-21
quote: "allows lazy loading later"
body: |
  [minor] R3 rests on a file split that does not exist yet: 08#persistence says the split "is not decided yet", and O1 is open. Lazy loading also runs against 06#start-and-load and 08#user-interface, which keep the whole model in memory from the start. Settle: rephrase as a requirement on O1 (choose a split that permits lazy loading) and link O1.
```

```annotation
author: "claude/chapter-review"
date: 2026-10-21
quote: "The fallback stacks are weighed in"
body: |
  [minor] adr/desktop-stack.md weighs no fallback. Its Rejected table discards WinUI 3, WPF, Electron, Blazor WebAssembly, and a server app, most of them because Playwright cannot drive them, so none of them is a fallback for a brittle CDP attach. Settle: name Finance.Web (O2) as the one fallback here, or add a Proposed section to the desktop stack record that weighs a real fallback.
```

```annotation
kind: question
author: "claude/chapter-review"
date: 2026-10-21
quote: "Accepted for now. Revisit if the data or the threat changes."
body: |
  [major] Who accepted R4? domain/finance/context.md#user still asks the user whether the files need encryption or a password on open, so the risk has not been accepted by its owner. See the flag on 08#privacy-and-security. Settle: once the domain question is answered, say who accepted it and link the decision record that holds the choice.
```

## Open Questions

```meta
status: draft
related: [.devbook/arc42/05-building-block-view.md#integration-seam, .devbook/arc42/05-building-block-view.md#development-harness]
```

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
body: |
  [minor] Questions that other chapters leave open have no row here. (1) The CI workflow: 07#development says it "is not designed yet", and whether the end-to-end level can run on a hosted Windows runner is unknown. (2) Protection of the data (encryption, a password on open), open in domain/finance/context.md#user. (3) How PC B finds the same data folder, given the path is per machine (08#configuration). (4) R1 mitigation: a marker file or conflict-copy detection, which needs a design decision. Settle: add rows with owners, or link each from the risk that raises it.
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
status: draft
```

No code exists yet, so Finance carries no technical debt. Debt records will go under `tdr/`
with an index, and this section will link to that index.
