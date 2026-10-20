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
