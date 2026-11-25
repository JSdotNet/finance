# Test Stack

```meta
date: 2026-11-25
related: [.devbook/arc42/08-crosscutting-concepts.md#testability, .devbook/arc42/adr/modularity.md, .devbook/arc42/adr/desktop-stack.md, .devbook/arc42/adr/orchestration.md]
```

Finance tests follow the organization's
[ADR 0010: Testing](https://github.com/JSdotNet/app-defaults/blob/main/defaults/arc42/adr/0010-testing.md).
The .NET tests use xUnit v3 on Microsoft Testing Platform, with NSubstitute for test doubles.
The end-to-end suite is a Playwright Test (`@playwright/test`) suite run through Aspire.

| Need | Tool |
| --- | --- |
| Test framework for the .NET tests | xUnit v3 on Microsoft Testing Platform |
| Test doubles of an interface | NSubstitute |
| Test data | Bogus builders, with a fixed seed where a test asserts a generated value |
| Time | `FakeTimeProvider` |
| Assertions | AwesomeAssertions |
| Architecture rules | NetArchTest |
| End to end | `@playwright/test` under Aspire, over CDP into WebView2, or against `Finance.Web` if it is built |
| Accessibility checks | `@axe-core/playwright`, in the end-to-end suite |

## Why

```meta
```

- These are the choices whose reversal rewrites every test. One stack per test type means a
  developer reads any test without switching idioms.
- xUnit v3 runs each test project as an executable on Microsoft Testing Platform, so a test
  project runs with `dotnet run` as well as `dotnet test`.
- NSubstitute is used only where a test checks an interaction with a port. A test of the
  model uses real objects, so most tests need no test double at all.
- Bogus produces realistic amounts, dates, and names. A fixed seed keeps a test that asserts
  a generated value repeatable.
- AwesomeAssertions reads as a sentence and gives clear failure messages. It is the
  Apache-licensed continuation of FluentAssertions 7. ADR 0010 names no assertion library.
- NetArchTest states the rules of [the modularity record](modularity.md) as tests. A wrong
  project reference then fails the build instead of waiting for review.
- `@playwright/test` connects to WebView2 over CDP, the Chrome DevTools Protocol, as
  [the desktop stack record](desktop-stack.md) relies on. Its global setup runs
  `aspire start` detached, so two worktrees never share a port.
- Whether `Finance.Web` is built stays open in
  [11. Risks and Technical Debt](../11-risks-and-technical-debt.md#open-questions). If it is,
  the same suite drives it over HTTP.
- The devbook journeys run on the same `@playwright/test` suite, so there is no second
  end-to-end runner.
- `@axe-core/playwright` runs the accessibility scan that
  [the design folder's verification](../../design/accessibility.md#verification) asks for,
  inside that suite.
- Finance hosts no API and keeps no database, so ADR 0010's in-process integration tests and
  throwaway containers do not apply. `Finance.Storage` is tested against a real temporary
  folder instead.
- A new test library needs its own decision. The stack stays small on purpose.

## Rejected

```meta
```

| Alternative | Why it lost |
| --- | --- |
| NUnit or MSTest | Both would work. ADR 0010 names xUnit v3, and switching later rewrites every test attribute. |
| xUnit v2 on VSTest | ADR 0010 moves to Microsoft Testing Platform, and Finance has no tests to keep on VSTest. |
| Moq | ADR 0010 drops it for NSubstitute, and Finance has no tests written against it. |
| Playwright for .NET | ADR 0010's suite, and the devbook journeys, run on `@playwright/test`. A .NET suite would be a second runner. |
| FluentAssertions 8 or later | Version 8 moved to the Xceed licence, free only for non-commercial use, and its terms can change again. AwesomeAssertions keeps the same API under Apache 2.0. |
| ArchUnitNET | It can express richer rules, but NetArchTest covers project references and forbidden dependencies, which is all Finance's boundaries need. |
| bUnit component tests instead of end-to-end tests | They render components without WebView2 or the MAUI shell, so they cannot show that the real application works. |
| WinAppDriver or UI Automation | They drive native controls, not the Razor UI inside WebView2, and they are slower and more brittle than Playwright. |

## History

```meta
```

| Date | Change | Why |
| --- | --- | --- |
| 2026-11-25 | Proposed: xUnit v3 on Microsoft Testing Platform, NSubstitute instead of Moq, `@playwright/test` instead of Playwright for .NET, and `@axe-core/playwright`. | The organization's [ADR 0010](https://github.com/JSdotNet/app-defaults/blob/main/defaults/arc42/adr/0010-testing.md) consolidated the testing guidance; Finance has no tests to migrate. |
| 2026-10-08 | Proposed: xUnit, Moq, Bogus, AwesomeAssertions, NetArchTest, and Playwright under Aspire. | Adopted from the organization's former recommendations: [testing shared](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/recommendations/testing-shared.md), [unit](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/recommendations/testing-unit.md), [end to end](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/recommendations/testing-end-to-end.md), and [architecture](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/recommendations/testing-architecture.md). |
