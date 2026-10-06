---
name: run-finance
description: "Build and launch this repository's application the way this repository says to, and leave it running. Use when: running or starting the app locally, 'run it', 'start the app', resuming work on a branch, or a flow needs a runtime at app.start."
goal: "Leave this repository's application running and healthy, and report the command that started it, the health verdict, and its entry points. Never hand the person a command to run themselves."
---

# Run the Application

Build and launch the app from what this file declares, not from a command guessed per
session. **Edit this file** — it is yours: the facts are examples to replace, the procedure a
starting point. Whoever invokes `run` expects only what the goal says: a running application
and the three facts reported.

This is the seed a host without Claude Code's `/run-skill-generator` lands at
`.claude/skills/run-<id>/SKILL.md`. Where the generator ran, its recipe is this file instead;
keep `## Healthy` and `## Entry points` in it either way — a flow's validation reads them.

## Setup

<!-- What a clean checkout needs before the first launch. Replace the example. -->

- The .NET SDK named in `global.json` and a running container runtime.
- `dotnet restore` from the repository root.
- Environment: none beyond the AppHost's own user secrets.

## Launch

<!-- The command, where it runs from. Replace the example. -->

```bash
aspire start
```

- From the repository root. AppHost: `src/Orders.AppHost/Orders.AppHost.csproj`

1. **Check whether it is already running** before starting a second copy — worktrees share
   ports. Reuse a running instance and say so.
2. **Run the declared command** in the background. Never substitute a different command when
   the declared one fails; report the failure.
3. **Wait for the signals under Healthy.** Stop waiting on a fatal error, or after two
   minutes of silence. Do not report a partially-started app as healthy.
4. **Re-read the entry points** every launch — a port changes.
5. **Open the front end** from the table under Entry points, on the area the branch changes
   (see Go to). Use the host's inline browser when it has one; otherwise give the plain URL.

Report in a couple of lines: the command, the health verdict, the entry points, the opened URL. Leave the app
running — `show`, `debug`, and a flow's later stages work against it.

## Healthy

<!-- What a good start looks like, and which warnings are known and benign. -->

- Every AppHost resource reaches `Running`; the database resource reports `Healthy`.
- `GET /health` on the API returns `200`.
- Benign: one `Detected container runtime restart` warning on first start.

## Entry points

<!-- What `show` opens and a stage validates against. -->

| Entry point | URL |
| --- | --- |
| Aspire dashboard | `https://localhost:17090` |
| Web front end | `https://localhost:7080` |
| API | `https://localhost:7081/api` |

## Go to

<!-- Area — route — the source path it owns. Used to land on what the current branch changes.
     Replace these rows; delete the section if the app has one entry point. -->

| Area | Route | Owns |
| --- | --- | --- |
| _example_ | `/orders` | `src/Orders.Web/Pages/Orders/` |

Match `git diff --name-only` against the `Owns` column and open the first area that hits.

## Sign in

<!-- A pointer only — where the credential lives, never its value. Delete if there is no sign-in. -->

- Local development uses the seeded `qa@example.test` account; its password is the
  `ORDERS_QA_PASSWORD` environment variable, provisioned from the team's secret store.
- Never type a password, token, or key into a form yourself: open the page, name where the
  credential lives, and let the user sign in.

## Never

- Restart a running instance without saying so.
- Run destructive setup — a database drop, a volume prune, `git clean` — as part of running.
  Propose it instead.
- Put a secret in this file. It is committed.
