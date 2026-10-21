# 1. Plan

```meta
status: candidate
type: stage
```

Specifying work: devbook chapters, backlog items, and their approval before anything is built.

## Backlog Plan Entries

```meta
status: trial
type: workflow
stage: [plan]
related: [".devbook/ai/02-code-test.md#flow-skills"]
date: 2026-10-21
```

Work is planned in the Backlog app as a plan of numbered entries, and each `prompt` entry is
carried into this repository by `backlog-tools:run-plan-item`, which checks the entry is still
outstanding, does it through the delivery flow its change belongs to, and reports the pull
request back to the entry.

- **Used for** — the `finance-setup` plan, run on 2026-10-21. Its first entry, `machine-tools`,
  brought the maintainer's machine level for the trial: the `jsdotnet-devbook` plugins at
  1.28.0 with `devbook-collaboration` newly installed, `backlog-tools` at 0.20.0, and the
  OpenSpec CLI at 1.14.3, each at user scope.
- **Adopted by** — the maintainer, for the `finance-setup` plan only. Its entries run unattended
  through `execute-plan`, each in its own worktree off `plan/finance-setup`, and each lands as a
  draft pull request into that branch that a person validates.
- **Evidence** — the pull request that wrote this chapter is the first entry carried this way.
  Promote to `adopted` once a plan has merged into `main` through its `plan/` branch.
- **Limits** — the trial's settings live in the committed `.devbook/config.json`, never in a
  personal overlay. An entry changing only the machine leaves no trace in the repository but
  this record.

## OpenSpec Change Lane

```meta
status: candidate
type: workflow
stage: [plan]
related: [".devbook/ai/02-code-test.md#flow-skills", ".devbook/ai/01-plan.md#backlog-plan-entries"]
date: 2026-10-21
```

A change to the devbook folders is proposed as an OpenSpec change under `openspec/changes/`,
drafted against the `devbook` schema, and merged into the chapters once approved.

- **Used for** — the change folder, adopted as `changes` by the devbook 1.28 update on
  2026-10-21, and the lane `devbook-openspec:init` set up on it: the OpenSpec CLI's skills and
  commands for Claude Code and GitHub Copilot, the `devbook` schema in
  `openspec/schemas/devbook/`, and `openspec/config.yaml`. `flow-code`'s `phase-scope` runs
  `devbook-openspec:spec` and then `devbook-openspec:status --replan`, the tracker binding is
  `devbook-openspec:tracker` instead of GitHub, and no grill step is bound.
- **Adopted by** — nobody yet. The `finance-change-lane` entry of the `finance-setup` plan wired
  it; no change has been proposed through it.
- **Evidence** — none yet. Promote to `trial` once a change has been proposed, approved, and
  archived through the lane.
- **Limits** — OpenSpec's anonymous usage statistics are off on the maintainer's machine, a
  setting kept in the personal devbook overlay rather than here.

## Design Artifacts as Token Source

```meta
status: trial
type: workflow
stage: [plan]
related: [".devbook/design/README.md#provenance", ".devbook/ai/01-plan.md#backlog-plan-entries"]
date: 2026-10-21
```

The product's screens are sketched with Claude as a design artifact, a canvas of HTML boards
with their own inline CSS, and `flow-spec` then carries that CSS into `design/` as named
tokens, mapping every board value onto a token and listing the mapping.

- **Used for** — the Finance App Design, eleven boards drawn on 2026-10-08, turned into tokens
  by the `finance-tokens` entry of the `finance-setup` plan on 2026-10-21. Type, spacing, and
  radius came over; its light colours were translated by role, because `design/` is dark mode
  only.
- **Adopted by** — the maintainer, for this one design so far.
- **Evidence** — the pull request that wrote this chapter. Promote to `adopted` once a screen
  built on the tokens has been reviewed against its board.
- **Limits** — the artifact link could not be read from the account the plan ran under, so
  the run read a local copy of the artifact's files. A board's inline CSS is a sketch, not a
  token set, and an off-scale value is mapped rather than copied.
