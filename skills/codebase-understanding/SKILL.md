---
name: codebase-understanding
description: Use when a human wants to understand existing code, implementation changes, file responsibilities, execution flows, tests, or architecture rationale.
---

# Codebase Understanding

Explain the real repository. Inspect implementation, call sites, tests, and design records before answering. Do not invent author intent. Start with the conclusion and keep explanations concise.

## Walkthrough Order

1. **Feature flow:** Begin with the user action, UI, API, domain logic, storage/external systems, and visible outcome. Highlight any data exposure risks.
2. **Each file:** In execution order, explain its responsibility and full flow in a few lines.
3. **Functions and classes:** About five short lines each: caller, arguments and realistic values, result/side effects, responsibility, and design reason.
4. **Meaningful operations:** Explain important calls, variable contents, true/false branch examples, input trust boundaries, and failure behavior. Skip punctuation and syntax trivia.
5. **Design rationale:** State where state lives, SSOT, alternatives, trade-offs, reused code, and impact on users and the system. Distinguish verified facts from hypotheses.
6. **Tests:** Translate important test names into plain language; cover behavior, boundaries, errors, state transitions, and race conditions.
7. **Open questions:** Only raise issues that materially affect user value, correctness, security, performance, or existing features.

For large study applications, prefer the sequence: authentication and registration, Kindle imports, question generation, async jobs, answers and reviews, saved mistakes, billing and tokens, deployment and operations. Follow the user's requested order otherwise.

## Style
Concise Japanese when speaking Japanese. No code copies when the human already has an editor open. Use headings and brief bullets. Explain why a design fits this specific codebase, not generic best practices. For new material design choices, defer to superpowers:human-led-design and human approval.
