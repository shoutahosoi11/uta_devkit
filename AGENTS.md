# uta-devkit — Agent Instructions

Target: **Codex and Claude Code only**.

- Be concise and conclusion-first, especially in Japanese. Preserve important causal explanations.
- For architecture, compare meaningful alternatives by unique properties, concrete user benefit/harm, system benefit/harm, and relative trade-offs. Human approval is required for material decisions.
- Prefer the smallest implementation that satisfies confirmed user needs.
- Inspect and reuse existing repository functions, business rules, validators and tests. Do not duplicate matching logic.
- Prefer simple, common English and existing domain vocabulary. Longer, meaningful function and variable names beat ambiguous abbreviations.
- Use test-driven development: follow `skills/test-driven-development/test-design-guide.md` to select tests before RED, then verify failure, implement minimally, and refactor when green. For test-design-only requests, do not modify files.
- Consider existing feature regressions, state location/lifetime, SSOT, mutation ownership, async failure and ordering where relevant.

See `skills/using-superpowers/SKILL.md` and `skills/human-led-design/SKILL.md`.
