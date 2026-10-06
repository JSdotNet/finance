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
date: 2026-10-06
```

Unattended routines from `delivery-schedule`, run on a cadence as local scheduled tasks on the
maintainer's machine, each landing a change as a pull request and its report as the run's last
message.

- **Used for** — six schedules selected under `components.schedule` in `.devbook/config.json`:
  `devbook-validate`, `merge-review`, `package-update`, `tech-update`, `prose-check`, and
  `weekly-update`, with cron overrides on `package-update` and `tech-update`.
- **Adopted by** — nobody yet. The selection is stamped at 1.18.0, but none of the six
  routines has been created on a machine: a routine is created from the main checkout, and the
  1.19 update ran in a worktree.
- **Evidence** — none yet. Promote to `trial` once the routines exist and one has published a
  pull request here.
- **Limits** — a local routine runs only while the desktop app is open on the machine that
  created it. No schedule fires a flow.
