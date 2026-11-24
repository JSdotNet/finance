# Orchestration

```meta
date: 2026-11-24
related: [.devbook/arc42/05-building-block-view.md#development-harness, .devbook/arc42/07-deployment-view.md#development, .devbook/arc42/adr/desktop-stack.md, .devbook/arc42/adr/observability.md]
```

Finance uses Aspire 17 in development only. `Finance.AppHost` starts the application and the
Aspire dashboard, and `Finance.ServiceDefaults` carries the shared wiring. Nothing from Aspire
ships to the user. The AppHost is a `Microsoft.NET.Sdk` project that references
`Aspire.Hosting.AppHost` and `Aspire.Hosting.Dotnet`, and adds each project by path with
`AddDotnetProject`, as the organization's
[ADR 0002: Aspire, Configuration and Infrastructure](https://github.com/JSdotNet/app-defaults/blob/main/defaults/arc42/adr/0002-aspire-configuration-and-infrastructure.md)
prescribes.

```csharp
var builder = DistributedApplication.CreateBuilder(args);
builder.AddDotnetProject("desktop", "../Finance.Desktop/Finance.Desktop.csproj");
builder.Build().Run();
```

## Why

```meta
```

- One command starts the application, its dashboard, and any test harness beside it, against
  a test data folder outside OneDrive.
- `Finance.ServiceDefaults` reaches the MAUI head through an `IMauiInitializeService`. The
  desktop application therefore gets its telemetry the same way a service would, without code
  of its own.
- Every port is assigned per run, and no project hard-codes one. A developer reads the ports
  from the dashboard or the AppHost output, so parallel runs and worktrees never collide.
- Secrets never go into an Aspire project. They live in user secrets or environment variables.
- The installed application runs without the AppHost. Finance has no services, so production
  needs nothing to orchestrate.
- Aspire 17 makes `Aspire.AppHost.Sdk`, `AddProject`, and `AddCSharpApp` obsolete. Finance has
  no AppHost yet, so it starts on the replacements and has nothing to migrate. Their obsolete
  diagnostics are never suppressed.
- `aspire run --watch` does not watch `AddDotnetProject` resources yet, so hot reload uses
  `dotnet watch` until it does.

The organization guideline also asks for service discovery, health checks per service,
resilience defaults on outbound calls, and Aspire-generated infrastructure. Finance has no
services, no outbound calls, and nothing deployed, so those parts do not apply. They come back
to this record when an external API is integrated.

## Rejected

```meta
```

| Alternative | Why it lost |
| --- | --- |
| No orchestration, with `launchSettings.json` only | It starts the application but not the dashboard or a test harness, and it gives no telemetry view during development. |
| Aspire in production as well | Finance hosts nothing, so there is nothing to orchestrate on the user's PC. Shipping Aspire would only add weight. |
| An AppHost on `Aspire.AppHost.Sdk` with `AddProject<Projects.*>` | Obsolete in Aspire 17; with warnings as errors the AppHost would not build. |
| A strongly typed resource extensions project for the AppHost | It pays off when infrastructure resources are shared across many projects. Finance's AppHost wires two project resources directly. |

## History

```meta
```

| Date | Change | Why |
| --- | --- | --- |
| 2026-11-24 | Proposed: Aspire 17, with the AppHost on `Microsoft.NET.Sdk` adding projects through `AddDotnetProject`. | Aspire 17 made the AppHost SDK and `AddProject` obsolete, and the organization's [ADR 0002](https://github.com/JSdotNet/app-defaults/blob/main/defaults/arc42/adr/0002-aspire-configuration-and-infrastructure.md) adopted it. |
| 2026-10-08 | Proposed: Aspire in development only, with `Finance.AppHost` and `Finance.ServiceDefaults` and no hard-coded ports. | Adopted from the organization's former ADR 0003 (Aspire for ASP.NET services), as Backlog applies it. |
