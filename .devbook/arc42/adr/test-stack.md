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

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "| Test framework, every test type | xUnit |"
body: |
  [minor] xUnit v2 and v3 are different packages (xunit vs xunit.v3) with a different runner model (Microsoft Testing Platform in v3), and moving between them touches every test project, which is the reversal cost this record exists for. Name the major version.
```

```annotation
author: "claude/chapter-review"
date: 2026-10-21
quote: "| End to end | Playwright for .NET, over CDP into WebView2, under Aspire |"
body: |
  [minor] 08 Testability allows end-to-end runs against Finance.Web if it is built (11 O2), and 05 draws Playwright reaching it over HTTP; this row names only CDP into WebView2. Mention the Finance.Web path as conditional on O2 so the two chapters agree.
```

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

```annotation
kind: flag
author: "claude/chapter-review"
date: 2026-10-21
quote: "A new test library needs its own decision."
body: |
  [major] The design folder already requires one: component-libraries.md (risk row) and accessibility.md#verification make accessibility checks Playwright with axe, a further library (Deque.AxeCore.Playwright or similar) this stack does not list. Add axe to the table and Why, or have the design folder drop the requirement; as written the two chapters disagree.
```

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

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "Version 8 moved to a paid commercial licence."
body: |
  [minor] Incomplete: FluentAssertions 8 is under the Xceed licence, which is free for non-commercial use, and Finance is a personal project. The rejection holds on other grounds (licence terms that can change again, the organization standard, an Apache-licensed fork with the same API); state those rather than a paid-licence reason that does not bind Finance today.
```

## History

```meta
```

| Date | Change |
| --- | --- |
| 2026-10-08 | Proposed: xUnit, Moq, Bogus, AwesomeAssertions, NetArchTest, and Playwright under Aspire, adopted from the organization's recommendations [testing shared](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/recommendations/testing-shared.md), [unit](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/recommendations/testing-unit.md), [end to end](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/recommendations/testing-end-to-end.md), and [architecture](https://github.com/JSdotNet/Project-Guidelines-MCP/blob/main/guide/recommendations/testing-architecture.md). |

```annotation
kind: suggestion
author: "claude/chapter-review"
date: 2026-10-21
quote: "| Date | Change |"
body: |
  [minor] The History table is headed Date | Change, but devbook-arc42.md fixes the header as Date | Change | Why, and build.mjs --check warns on it. Split the row's reason into its own Why column (here: adopted from the organization's testing recommendations is the why).
```
