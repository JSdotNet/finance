# 4. Operate and Monitor

```meta
rating: candidate
type: stage
```

Running the system and feeding what it shows back into planning: alerts, scheduled reviews, and status.

## Scheduled Routines

```meta
rating: candidate
type: workflow
layer: [upkeep]
date: 2026-11-24
```

Unattended routines from `delivery-schedule`, run on a cadence as local scheduled tasks on the
maintainer's machine, each landing a change as a pull request and its report as the run's last
message. Most run inside two machine-level bundles that cover every repository on the machine.

- **Used for** — six schedules selected under `components.schedule` in `.devbook/config.json`.
  Four run in the bundle `All repos · Sunday devbook review`, Sundays at 04:00:
  `devbook-validate`, `tech-update`, `prose-check`, and `weekly-update`. `package-update` runs in
  `All repos · Saturday code health`, on Saturdays. `merge-review` is still a per-repository
  routine, `JSdotNet/finance · <title>`. The cron overrides in config no longer decide when a
  bundled job fires. Beside them, Dependabot takes the minor and patch updates for npm at
  `/.devbook/_tools/scenarios` and github-actions at `/`, weekly on Saturday at 04:00
  Europe/Amsterdam, one grouped pull request per ecosystem. It ignores majors, which are left to
  `package-update` in the Saturday bundle. Security updates follow the repository setting and
  sit outside the groups.
- **Adopted by** — nobody yet. The 1.25 update on 2026-10-13 stamped the selection at 1.25.0
  and created all six as local routines on the maintainer's machine, titled
  `JSdotNet/finance · <title>` and working from the main checkout. In November 2026 the two
  bundles, machine-level routines from the `delivery-schedule` plugin of `JSdotNet/devbook`,
  replaced five of them. Each routine still needs its worktree option switched on in the host's
  own page.
- **Evidence** — the Sunday bundle's `prose-check` job has published one draft pull request
  here, JSdotNet/finance#35 "docs(devbook): prose check 2026-11-18", still open and unmerged.
- **Moves up when** — a routine has published a pull request or a report here.
- **Limits** — a local routine runs only while the desktop app is open on the machine that
  created it. A routine's tools are approved on its first run, so that run is fired by hand. No
  schedule fires a flow.
