---
name: systematic-debugging
description: Structured debugging workflow — reproduce, isolate, fix, verify. Use when investigating bugs, failing tests, unexpected behavior, or intermittent errors.
compatibility: opencode
---

## Process

1. **Reproduce** — Get a reliable failing case (command, test, or steps). Note expected vs actual.
2. **Isolate** — Narrow to the smallest component, input, or recent change that triggers it. Read relevant code and logs before editing.
3. **Hypothesize** — State one concrete cause; gather evidence that confirms or rules it out.
4. **Fix** — Make the smallest change that addresses the root cause. Avoid drive-by refactors.
5. **Verify** — Re-run the reproduction and related tests. Confirm the failure is gone and nothing obvious regressed.

## Rules

- Do not claim a fix without verification.
- Prefer adding or adjusting a test when the bug is non-trivial.
- If blocked, report what you know, what you tried, and the next best probe.
