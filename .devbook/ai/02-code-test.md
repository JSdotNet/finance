# 2. Code and Test

```meta
status: candidate
type: stage
```

Implementing and validating a change: the coding agent, TDD, code review, and QA evidence.

## Flow Skills

```meta
status: candidate
type: workflow
stage: [plan, code, test]
date: 2026-10-06
```

A change routes to the delivery flow named for what it changes — `flow-code` for anything
outside `.devbook/`, `flow-spec` for a devbook folder — which runs it phase by phase to a pull
request behind a Personal Validation gate.

- **Used for** — the phase maps in `.devbook/config.json`, one per flow, wired at the 1.19
  update on 2026-10-06. Both flows run `devbook:validate` before `phase-update-base` and
  `devbook:update` after `phase-summary`. `flow-code` hands scope and plan to
  `architecture:architect`, implementation to `csharp-coding:coding`, and verification to
  `qa:qa`, and runs `devbook:verify-change` as its spec check. `flow-spec` drafts each folder
  through its own agent: `architecture:architect` for `arc42/` and `tech/`,
  `domain-design:domain-architect` for `domain/`, `ux-design:ux-designer` for `design/`, and
  `documentation:documentation` for `ai/`. `.claude/settings.json` enables those
  `jsdotnet-ai-plugins` plugins for every session here.
- **Adopted by** — nobody yet. The changes so far, the 1.19 update in #5 included, were carried
  by Claude Code sessions by hand, not through a flow.
- **Evidence** — the pull request that wrote this chapter was the first change carried by
  `flow-spec` here. Promote to `trial` once `flow-code` has carried a change to the application.
- **Limits** — the Personal Validation gate needs a person, so no schedule runs a flow.

## Repository Procedures

```meta
status: candidate
type: skill
stage: [code, test]
related: [".devbook/ai/02-code-test.md#flow-skills"]
date: 2026-10-06
```

The procedures `devbook` seeds and this repository owns: `run`, `capture`, `diagnose`,
`estimate`, and `prototype`. Each has a fixed goal in its wrapper, and its procedure in
`.agents/skills/<name>.md`, or in `.claude/skills/run-finance/SKILL.md` for `run`.

- **Used for** — starting the application through Aspire for a flow's verify phase, taking
  evidence a reviewer can open, finding the cause of an observed issue, sizing work in story
  points, and settling a design question with a throwaway prototype.
- **Adopted by** — nobody yet. The run recipe absorbed the old `start` procedure in #5, and
  `debug` and `show` gave way to `diagnose` with devbook 1.19.0 on 2026-10-06.
- **Evidence** — none yet. Promote to `trial` once a flow's verify phase has started the
  application through `run`.
- **Limits** — `estimate` compares against the repository's own reference rows, so it is only
  as good as the examples in `.agents/skills/estimate.md`.
