---
name: using-superpowers
description: Use when starting any conversation - establishes how to find and use skills, requiring skill invocation before ANY response including clarifying questions
---

<SUBAGENT-STOP>
If you were dispatched as a subagent to execute a specific task, ignore this skill.
</SUBAGENT-STOP>

<EXTREMELY-IMPORTANT>
If you think there is even a 1% chance a skill might apply to what you are doing, you ABSOLUTELY MUST invoke the skill.

IF A SKILL APPLIES TO YOUR TASK, YOU DO NOT HAVE A CHOICE. YOU MUST USE IT.

This is not negotiable. You cannot rationalize your way out of this.
</EXTREMELY-IMPORTANT>

## The Rule

**Invoke relevant or requested skills BEFORE any response or action** — including clarifying questions, exploring the codebase, or checking files. If it turns out wrong for the situation, you don't have to use it.

**Before entering plan mode:** if you haven't already brainstormed, invoke the brainstorming skill first.

Then announce "Using [skill] to [purpose]" and follow the skill exactly. If it has a checklist, create a todo per item.

## Research and Design Checks for Development

Apply these rules throughout requirements discovery, design, implementation, test design, verification, and QA. Pass the applicable rules to any delegated agent.

At each stage, identify its concrete technical questions. Search the current repository for relevant implementations, callers, contracts, and tests, and search GitHub public open-source projects for relevant approaches. Reuse research already performed for the same question; search again when a new question arises. Inspect the relevant source, not only a search snippet. Record the local paths and public links, what each example shows, and why an approach is or is not applicable; report if no relevant example was found. Prefer existing project logic when its behavior matches; do not make an external example or the current implementation the project's specification. Check compatibility and license before copying or adding a dependency. Never include private code, credentials, or confidential details in public searches. If public search is unavailable or prohibited, report it as not performed and continue with available evidence.

After implementation and before claiming completion, compare the actual implementation and complete task-owned diff against the confirmed requirements and design, including permitted scope and behavior to preserve. Trace affected callers and shared data, and inspect relevant tests and observable behavior; passing tests alone does not establish design compliance. Report each mismatch with its design source, expected and actual behavior, evidence, and impact. Correct it within the authorized scope and reverify, or report it unresolved. If a design, scope, or evidence is missing, mark the affected comparison unverified rather than inventing approval. Preserve design-only requests' prohibition on file changes and test execution.

## Skill Priority

When multiple skills apply, process skills come first — they set the approach, then implementation skills (frontend-design, etc.) carry it out. Brainstorming and systematic-debugging are Superpowers' most common process skills, but the rule holds for any of them.

- "Let's build X" → superpowers:brainstorming first, then implementation skills.
- "Fix this bug" → superpowers:systematic-debugging first, then domain skills.

## Red Flags

These thoughts mean STOP—you're rationalizing:

| Thought | Reality |
|---------|---------|
| "This is just a simple question" | Questions are tasks. Check for skills. |
| "I need more context first" | Skill check comes BEFORE clarifying questions. |
| "Let me explore the codebase first" | Skills tell you HOW to explore. Check first. |
| "I can check git/files quickly" | Files lack conversation context. Check for skills. |
| "Let me gather information first" | Skills tell you HOW to gather information. |
| "This doesn't need a formal skill" | If a skill exists, use it. |
| "I remember this skill" | Skills evolve. Read current version. |
| "This doesn't count as a task" | Action = task. Check for skills. |
| "The skill is overkill" | Simple things become complex. Use it. |
| "I'll just do this one thing first" | Check BEFORE doing anything. |
| "This feels productive" | Undisciplined action wastes time. Skills prevent this. |
| "I know what that means" | Knowing the concept ≠ using the skill. Invoke it. |

## Platform Adaptation

If your harness appears here, read its reference file for special instructions:

- Claude Code: `references/claude-code-tools.md`
- Codex: `references/codex-tools.md`

## Response Style (All Replies)

Apply to **every user-facing response** in Codex and Claude Code, including responses from other skills.

- Start with a clear conclusion in 1–2 sentences.
- Prefer short sentences, concise bullets and only necessary headings. Remove filler, repeated points, unnecessary prefaces and generic advice.
- Explain details only when needed for the requested task; do not shorten away necessary evidence, uncertainty, caveats, or causal reasoning.
- In significant design discussions, use the structured comparative output required by `superpowers:human-led-design`, but keep each section brief.
- For recommendations, show **technical property → why → impact on users and the system**, relative to alternatives. Do not mistake a shared capability for a unique advantage.
- Distinguish facts, assumptions and recommendations; ask at most one focused human-owned design question at a time.
- For code reading, explain one feature at a time, without repeating source code already visible in an editor.

**Conciseness is a presentation rule, not permission to omit important trade-offs.**

## User Instructions

User instructions (CLAUDE.md, AGENTS.md, direct requests) take precedence over skills, which in turn override default behavior. Only skip skill workflows or instructions when your human partner has explicitly told you to.
