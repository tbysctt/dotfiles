---
name: code-review
description: Checklist-driven code review for correctness, security, and tests. Use when reviewing a diff, PR, or recent changes without necessarily implementing fixes.
compatibility: opencode
---

## Review focus

- **Correctness** — Logic errors, edge cases, nil/empty handling, race conditions, broken invariants.
- **Security** — Injection, authz gaps, secret leakage, unsafe deserialization, path traversal.
- **Tests** — Missing coverage for new paths; flaky or weak assertions.
- **Maintainability** — Confusing names, dead code, unnecessary complexity (flag only when it hurts).
- **API / contracts** — Breaking changes, error handling, backwards compatibility.

## Output format

1. Findings first, ordered by severity (blocking → suggestion).
2. Each finding: location, what's wrong, why it matters, suggested fix.
3. Short summary of what looks solid.
4. Do not rewrite large swaths of code unless asked — prefer actionable comments.
