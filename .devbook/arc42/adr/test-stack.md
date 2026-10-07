# Test Stack

```meta
status: proposed
date: 2026-10-08
related: [.devbook/arc42/08-crosscutting-concepts.md#testability, .devbook/arc42/adr/modularity.md, .devbook/arc42/adr/desktop-stack.md, .devbook/arc42/adr/orchestration.md]
```

Every Finance test project uses xUnit, with Moq for mocks, Bogus with deterministic seeds for
test data, and AwesomeAssertions for assertions. Architecture tests use NetArchTest. End-to-end
tests use Playwright for .NET against the application started by the AppHost.

| Need | Tool |
| --- | --- |
| Test framework, every test type | xUnit |
| Mocks of an interface | Moq |
| Test data | Bogus, with a fixed seed where a test asserts a generated value |
| Assertions | AwesomeAssertions |
| Architecture rules | NetArchTest |
| End to end | Playwright for .NET, over CDP into WebView2, under Aspire |

## Why

```meta
```

- These are the choices whose reversal rewrites every test. One stack for every test type
  means a developer reads any test without switching idioms.
- xUnit runs tests in parallel by default and has a small attribute model.
- Moq is used only where a test checks an interaction with a port. A test of the model uses
  real objects, so most tests need no mock at all.
- Bogus produces realistic amounts, dates, and names. A fixed seed keeps a test that asserts
  a generated value repeatable.
- AwesomeAssertions reads as a sentence and gives clear failure messages. It is the
  Apache-licensed continuation of FluentAssertions 7.
- NetArchTest states the rules of [the modularity record](modularity.md) as tests. A wrong
  project reference then fails the build instead of waiting for review.
- Playwright drives WebView2 over CDP, the Chrome DevTools Protocol, as
  [the desktop stack record](desktop-stack.md) relies on. The AppHost starts the application
  for it, so the test sees the same wiring a developer does.
- A new test library needs its own decision. The stack stays small on purpose.

## Rejected

```meta
```

| Alternative | Why it lost |
| --- | --- |
| NUnit or MSTest | Both would work. The organization's stack and its examples use xUnit, and switching later rewrites every test attribute. |
| FluentAssertions 8 or later | Version 8 moved to a paid commercial licence. AwesomeAssertions keeps the same API under Apache 2.0. |
| NSubstitute | Its syntax is terser, but the organization's stack names Moq, and mocks are rare here because the model is tested with real objects. |
| ArchUnitNET | It can express richer rules, but NetArchTest covers project references and forbidden dependencies, which is all Finance's boundaries need. |
| bUnit component tests instead of end-to-end tests | They render components without WebView2 or the MAUI shell, so they cannot show that the real application works. |
| WinAppDriver or UI Automation | They drive native controls, not the Razor UI inside WebView2, and they are slower and more brittle than Playwright. |

## History

```meta
```

| Date | Change |
| --- | --- |
| 2026-10-08 | Proposed: xUnit, Moq, Bogus, AwesomeAssertions, NetArchTest, and Playwright under Aspire, adopted from the organization's recommendations [testing shared](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/recommendations/testing-shared.md), [unit](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/recommendations/testing-unit.md), [end to end](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/recommendations/testing-end-to-end.md), and [architecture](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/recommendations/testing-architecture.md). |
