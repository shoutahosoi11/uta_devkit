---
name: human-led-design
description: Use when a software feature or change has unresolved user-value, UX, architecture, state ownership, persistence, API, or data-flow decisions.
---

# Human-Led Design

## Core Rule

**The human owns product value and significant design decisions. The agent owns research, comparisons, and implementation after approval.** Read [constitution.md](constitution.md). Use this skill within superpowers:brainstorming, before its design-approval gate. Do not restart brainstorming or replace superpowers:writing-plans.

User outcomes come first. System performance, reliability, security, maintenance, existing-feature impact, and cost are real constraints, not goals to optimize independently. Favor the smallest change that solves the validated user problem.

## 1. Establish Context

- Identify the user, their concrete problem, success criteria, and confirmed facts versus hypotheses.
- Inspect the actual repository, relevant call sites, existing behavior, data stores, tests, and constraints. Never invent codebase facts.
- Reuse existing implementation when it meets the goal. Identify important regressions or interface changes; do not recite irrelevant checks.
- Explain the intended design as a short component/responsibility and data-flow sketch. For stateful work, follow **State Management Review** below.

## 2. Sort Decisions

**Human decision (consult + explicit approval):**
- User problem, UX/behavior, business rules, priorities and accepted trade-offs.
- Material component ownership, persistent data model, SSOT, API contracts, system boundaries, new dependencies, irreversible or costly architecture choices.
- Any choice whose best answer depends on what the user values more.

**Agent decision (autonomous, document if material):**
- Mechanical implementation details, naming, tests, and existing-pattern reuse that do not change approved user behavior or architecture.
- Clear technical improvements with no meaningful product trade-off.

A technical choice is *not* automatically a human decision just because two implementations exist. Escalate when the difference materially affects users, system constraints, existing functions, or future reversibility. Present the highest-impact decision first, **one question at a time**.

## 3. Compare Causally and Relatively

For every meaningful alternative, reason through:

**Different technical/structural property → why it produces the effect → user benefit and harm → system benefit and harm.**

- Evaluate **both user and system**, with user consequences first. If no material effect is identifiable, do not invent one. Keep the full comparison in the design analysis; communicate only differences that matter for the current human decision.
- Name concrete alternatives and describe the **differences relative to other feasible options**.
- Separate **shared requirement satisfaction** from **differentiating advantages**. An ability shared by URL and localStorage (e.g., reload persistence) is not by itself a reason to choose URL.
- Explain project-specific conditions. Compare implementation scope, reuse, dependencies, and existing-feature impact *when relevant*, without making every answer a long checklist.
- Distinguish **verified technical fact**, **reasoned prediction**, and **unverified user-value hypothesis**. Do not promote a hypothesis into a confirmed requirement.
- Include costs, safety, privacy, security, accessibility, performance, and operational trade-offs when they could change the decision.
- When a simpler solution achieves the same user outcome within constraints, prefer it. Avoid speculative abstractions, additional state, or technologies without demonstrated benefit.

## 4. State Management Review (only when relevant)

Review the following aspects of proposed state/data flow. Explain only the parts that materially affect this decision; use a simple example or short mapping instead of dumping the entire checklist:

1. **Location and lifetime:** where each state is owned/stored (component, URL, cache, DB, browser), why there, and when it expires or is destroyed.
2. **SSOT and duplication:** what is authoritative; is the displayed value derived from existing data? If replicated or cached, what synchronizes and invalidates it?
3. **Ownership and mutation:** who may read/change it, on which user event/system event, and with what authorization.
4. **Transitions and failures:** idle/loading/success/error, retries, cancellation, rollbacks, and what users see at each point.
5. **Concurrency and order:** stale/out-of-order responses, simultaneous writes, races, idempotency, and conflict resolution.
6. **Existing functionality:** only when implicated, identify impacted screens, APIs, state transitions, and regression tests.

Distinguish the authoritative server record from a client-side query cache: a UI cache can be the single source for *rendering* without being the authoritative persisted record. An editable draft may be a deliberately distinct state, not an accidental duplicate.

## 5. Decision Communication (example-first, concise)

**Do not force the old seven-heading design template or a full pros/cons matrix into a user-facing proposal.** The checks above are required for sound decisions, not headings that must be printed.

Before presenting a design, review the actual user problem, existing behavior, concrete user/system benefits and harms, meaningful alternatives, constraints, state/SSOT, error and concurrency handling, and regression impact as applicable. **Keep this analysis rigorous; make the explanation easy to follow.** Do not omit an unresolved material risk or choice just to make the response short.

Use this default communication flow, without numbering or a heading for every step:

1. **結論 (1–2 sentences):** What is being proposed or decided?
2. **具体例:** Walk through one realistic user action and visible before/after result. Explain ambiguous terms in ordinary words (for example, what "bulk import" means, or exactly when a deletion happens). Label hypothetical values as examples.
3. **重要な比較:** Compare only the alternatives' differentiating properties and meaningful trade-offs; explain why each changes the user's experience and the system's behavior. Mention drawbacks where they could change the decision.
4. **推奨理由:** Why does this choice fit this repository and confirmed user needs, what does it sacrifice, and what condition would change the recommendation? If evidence is insufficient, say so.
5. **質問（必要な場合のみ）:** Ask **one** specific question only when a material human-owned decision is still unresolved. Never ask merely to complete a template or re-ask something already decided.

- Prefer a concrete example over abstract terms, long taxonomies, repeated matrices, or vague references such as "at deletion time." If a user would need to ask "when?", "whose data?", or "what operation?", make the example more specific.
- For narrow questions, answer just that question. For complex decisions, present the highest-impact choice first and split the rest into later decisions, rather than flooding the user with every branch.
- Do not hide a consequential authorization, privacy, security, data-loss, reliability, cost, or existing-feature trade-off; explain it plainly when it affects the choice.
- Detailed tables, state diagrams, and full design documents are available **on request** or when truly necessary for informed approval. A concise explanation is not approval of unpresented material decisions.
- Only after explicit human approval, record significant decisions, rejected alternatives and reasons, consequences, and reversal conditions in an ADR using [templates/ADR.md](templates/ADR.md). For small changes, record the approved decision in the design/chat. Never label a proposal "approved" without approval.

**No implementation before explicit approval of material design decisions and the design itself.** Reading, exploration and non-production analysis are allowed. A human-approved throwaway spike is allowed, but must not silently become production code. Skipping discovery questions never implies approval of unpresented significant choices.

## 6. Handoff and Learning

After approval, hand the approved design to superpowers:writing-plans; the normal TDD, implementation, verification, and review skills remain in charge. If implementation reveals a new material choice, pause for a new human decision. Give a concise design-to-code walkthrough on request using superpowers:codebase-understanding.

Only propose reusable updates to this skill/constitution after concrete observed problems. Edit them **only with human approval**, test against cases that previously failed, and avoid storing project-specific rules here.

## Calibrated Examples

- [Search state: URL versus localStorage](examples/search-state.md): a shared benefit is **not** a distinguishing reason.
- [Query cache versus editable state](examples/state-ssot.md): SSOT, races, rendering versus server authority.

Examples establish explanation quality and output structure; **never copy their recommendation to another codebase without checking the actual requirements.