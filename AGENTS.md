# uta-devkit — Agent Instructions

Target: **Codex and Claude Code only**.

- Be concise and conclusion-first, especially in Japanese. Preserve important causal explanations.
- For architecture, compare meaningful alternatives by unique properties, concrete user benefit/harm, system benefit/harm, and relative trade-offs. Human approval is required for material decisions.
- Prefer the smallest implementation that satisfies confirmed user needs.
- Inspect and reuse existing repository functions, business rules, validators and tests. Do not duplicate matching logic.
- For development stages, search relevant local implementations and public GitHub open-source approaches; reuse prior research for the same question and report sources or unavailable searches. Follow the research and design-check rules in `skills/using-superpowers/SKILL.md`.
- After implementation, compare the complete task-owned changes and affected behavior with confirmed requirements and design; report discrepancies and unverified items with evidence.
- Prefer simple, common English and existing domain vocabulary. Longer, meaningful function and variable names beat ambiguous abbreviations.
- Use test-driven development: follow `skills/test-driven-development/test-design-guide.md` to produce the A–D design before RED, then proceed in D's order one case at a time through RED → GREEN → REFACTOR. For design-only requests, stop at A–D and do not modify files.
- Consider existing feature regressions, state location/lifetime, SSOT, mutation ownership, async failure and ordering where relevant.

See `skills/using-superpowers/SKILL.md` and `skills/human-led-design/SKILL.md`.
