# 2. Code and Test

```meta
rating: candidate
type: stage
```

Implementing and validating a change: the coding agent, TDD, code review, and QA evidence.

## Flow Skills

```meta
rating: candidate
type: workflow
stage: [specify, code, verify]
date: 2026-10-21
```

A change routes to the delivery flow named for what it changes: `flow-code` for anything
outside `.devbook/`, `flow-spec` for a devbook folder. That flow runs it phase by phase to a
pull request behind a Personal Validation gate.

- **Used for** — the phase maps in `.devbook/config.json`, one per flow. The 1.19 update wired
  them on 2026-10-06. The 1.25 update on 2026-10-13 and the 1.26 update on 2026-10-15 carried
  them unchanged, and the 1.26 update moved devbook and delivery to 1.26.0. Both flows run
  `devbook:validate` before `phase-update-base` and `devbook:update` after `phase-summary`.
  `.claude/settings.json` enables the `jsdotnet-ai-plugins` plugins for every session here.
- **Adopted by** — nobody yet. The changes so far, the 1.19 update in #5 included, were carried
  by Claude Code sessions by hand, not through a flow.
- **Evidence** — the pull request that wrote this chapter was the first change carried by
  `flow-spec` here.
- **Moves up when** — `flow-code` has carried a change to the application.
- **Limits** — the Personal Validation gate needs a person, so no schedule runs a flow.

Since 2026-10-21 the maps carry delivery profile C, the strong generalist. No phase names an
agent, and each sets a model and effort instead. A dash marks a phase the flow does not have:

| Phase | `flow-code` | `flow-spec` |
| --- | --- | --- |
| Scope | `devbook-openspec:spec`, per the OpenSpec Change Lane, on the engine's default | Engine's default |
| Plan | fable, high | — |
| Drafting | — | sonnet, medium; `arc42/` and `domain/` on opus, high |
| Implement | sonnet, high | — |
| Review | opus, high | — |
| Build and test | sonnet | — |
| Verify | sonnet, medium | — |
| Spec check | `devbook:verify-change` on fable, high | — |
| Report back | haiku | haiku |

Every other `flow-spec` phase runs on the engine's default. No gate stands before verify. One
approval gate, before `phase-create-pr`, holds every change until the maintainer asks for it to
be pushed and opened.

## Repository Procedures

```meta
rating: candidate
type: skill
stage: [code, verify]
related: [".devbook/ai/02-code-test.md#flow-skills"]
date: 2026-10-06
```

The procedures `devbook` seeds and this repository owns: `run`, `capture`, `diagnose`,
`estimate`, and `prototype`. Each has a fixed goal in its wrapper, and its procedure in
`.agents/skills/<name>.md`, or in `.claude/skills/run-finance/SKILL.md` for `run`.

- **Used for** — these jobs:
  - starting the application through Aspire for a flow's verify phase
  - taking evidence a reviewer can open
  - finding the cause of an observed issue
  - sizing work in story points
  - settling a design question with a throwaway prototype
- **Adopted by** — nobody yet. The run recipe absorbed the old `start` procedure in #5, and
  `debug` and `show` gave way to `diagnose` with devbook 1.19.0 on 2026-10-06.
- **Evidence** — none yet.
- **Moves up when** — a flow's verify phase has started the application through `run`.
- **Limits** — `estimate` compares against the repository's own reference rows, so it is only
  as good as the examples in `.agents/skills/estimate.md`.

## Scenario Journeys

```meta
rating: candidate
type: skill
stage: [verify]
related: [".devbook/ai/02-code-test.md#flow-skills"]
date: 2026-10-15
```

devbook's scenario skills make an end-to-end journey the source of a Playwright spec and of the
screenshots a reviewer opens. A journey is a `##` of `.devbook/domain/<context>/scenarios.md`, in
the context of the requirements it proves.

- **Used for** — `devbook:scenario-write` writes a journey and points each requirement it proves
  at its part with a `Proved by:` line; `devbook:scenario-derive` derives its spec;
  `devbook:scenario-run` runs it and writes `run.json` and one screenshot per shot into the
  journey's run folder beside its scenarios file. The tools are vendored into
  `.devbook/_tools/scenarios/`, last refreshed by the 1.34 update on 2026-11-03. No phase binds
  the skills, and `phase-verify` names no agent.
- **Adopted by** — nobody yet. No journey is committed: `.devbook/domain/finance/` has no
  `scenarios.md`.
- **Evidence** — none yet.
- **Moves up when** — a journey and its committed run have landed.
- **Limits** — a journey runs only through a Playwright suite, and this repository has none yet,
  nor a setup hook or profile for the runner to call.
