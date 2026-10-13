# 4. Operate and Monitor

```meta
status: candidate
type: stage
```

Running the system and feeding what it shows back into planning: alerts, scheduled reviews, and status.

## Scheduled Routines

```meta
status: candidate
type: workflow
stage: [operate, monitor]
date: 2026-10-13
```

Unattended routines from `delivery-schedule`, run on a cadence as local scheduled tasks on the
maintainer's machine, each landing a change as a pull request and its report as the run's last
message.

- **Used for** — six schedules selected under `components.schedule` in `.devbook/config.json`:
  `devbook-validate`, `merge-review`, `package-update`, `tech-update`, `prose-check`, and
  `weekly-update`, with cron overrides on `package-update` and `tech-update`.
- **Adopted by** — nobody yet. The 1.25 update on 2026-10-13 stamped the selection at 1.25.0
  and created all six as local routines on the maintainer's machine, titled
  `JSdotNet/finance · <title>` and working from the main checkout. None has run yet, and each
  still needs its worktree option switched on in the host's own page.
- **Evidence** — none yet. Promote to `trial` once a routine has published a pull request or a
  report here.
- **Limits** — a local routine runs only while the desktop app is open on the machine that
  created it. A routine's tools are approved on its first run, so that run is fired by hand. No
  schedule fires a flow.
