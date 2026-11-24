# 09. Architecture Decisions

```meta
related: [.devbook/arc42/adr/README.md]
```

Finance records one decision per concern under [`adr/`](adr/README.md). That index lists every
concern with its standing choice; this chapter does not restate them.

## Organization Decisions

```meta
related: [.devbook/arc42/adr/runtime.md, .devbook/arc42/adr/orchestration.md]
```

The organization's consolidated decisions live in
[`JSdotNet/app-defaults`](https://github.com/JSdotNet/app-defaults/tree/main/defaults/arc42/adr).
These apply to Finance; a Finance record that applies one links it.

| Organization decision | Finance record |
| --- | --- |
| [0001: Platform and Build](https://github.com/JSdotNet/app-defaults/blob/main/defaults/arc42/adr/0001-platform-and-build.md) | [Runtime](adr/runtime.md), [Package management](adr/package-management.md), [Scripting](adr/scripting.md) |
| [0002: Aspire, Configuration and Infrastructure](https://github.com/JSdotNet/app-defaults/blob/main/defaults/arc42/adr/0002-aspire-configuration-and-infrastructure.md) | [Orchestration](adr/orchestration.md) |
| [0003: Solution Structure](https://github.com/JSdotNet/app-defaults/blob/main/defaults/arc42/adr/0003-solution-structure.md) | [Modularity](adr/modularity.md) |
| [0005: Application Layer](https://github.com/JSdotNet/app-defaults/blob/main/defaults/arc42/adr/0005-application-layer.md) | [Error handling](adr/error-handling.md) |
| [0007: Observability and Resilience](https://github.com/JSdotNet/app-defaults/blob/main/defaults/arc42/adr/0007-observability-and-resilience.md) | [Observability](adr/observability.md) |
| [0009: Frontend](https://github.com/JSdotNet/app-defaults/blob/main/defaults/arc42/adr/0009-frontend.md) | [Desktop stack](adr/desktop-stack.md), [Styling](adr/styling.md) |
| [0010: Testing](https://github.com/JSdotNet/app-defaults/blob/main/defaults/arc42/adr/0010-testing.md) | [Test stack](adr/test-stack.md) |
| [0013: Agent-Ready Repository](https://github.com/JSdotNet/app-defaults/blob/main/defaults/arc42/adr/0013-agent-ready-repository.md) | None yet |

The HTTP API, persistence and messaging, security, MCP, and in-application agent decisions
(0004, 0006, 0008, 0011, 0012) do not apply: Finance hosts no API, keeps no database, has no
users to authenticate, and runs no agent.
