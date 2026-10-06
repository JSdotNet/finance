# AI Adoption Map

```meta
status: candidate
index: root
type: adoption-map
```

How this repository is built with AI, organized by the DevOps loop. The practices live one
chapter each in the usage files below; this file is the map. The tools themselves are
registered in `.devbook/tech/`, never here.

## Usage files

| File | Covers |
| --- | --- |
| `01-plan.md` | Specifying work: chapters, backlog items, and their approval |
| `02-code-test.md` | Implementing and validating a change |
| `03-build-release.md` | Getting a change through CI and into a release |
| `04-operate-monitor.md` | Running the system and feeding what it shows back into planning |

## The loop

```mermaid
flowchart LR
  plan --> code --> build --> test --> release --> deploy --> operate --> monitor --> plan
  flows["Flow Skills · candidate"]
  procs["Repository Procedures · candidate"]
  routines["Scheduled Routines · candidate"]
  plan -.- flows
  code -.- flows
  test -.- flows
  code -.- procs
  test -.- procs
  operate -.- routines
  monitor -.- routines
  classDef candidate fill:#e6e6e6,stroke:#7a7a7a,color:#333;
  class flows,procs,routines candidate;
```

Three usages are recorded, all `candidate`: the 1.19 update on 2026-10-06 wired the delivery
flows, the repository's procedures, and a schedule selection, and nobody works through them
yet. `build`, `release`, and `deploy` are empty, and that is the finding, not a gap to fill
with a tool name.

## Status ladder

`candidate` → `trial` → `adopted` → `hold` → `retired`, per `devbook-ai.md`. Promote a
chapter when its **Adopted by** line says the team actually works this way, and record what
is dropped as `retired` rather than deleting it.
