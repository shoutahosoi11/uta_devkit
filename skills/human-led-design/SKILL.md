---
name: human-led-design
description: Use when a feature needs human-understood end-to-end implementation flow, or has unresolved user-value, UX, architecture, state ownership, persistence, API, or data-flow decisions.
---

# Human-Led Design

## Core Rule

**The human owns product value and significant design decisions. The agent owns research, comparisons, and implementation after approval.** Read [constitution.md](constitution.md). Use this skill within superpowers:brainstorming, before its design-approval gate. Do not restart brainstorming or replace superpowers:writing-plans.

User outcomes come first. System performance, reliability, security, maintenance, existing-feature impact, and cost are real constraints, not goals to optimize independently. Favor the smallest change that solves the validated user problem.

## 0. AI-Initiated Human-First Design (mandatory opening)

**The agent must initiate the human's thinking by asking a concrete question. Do not wait for the human to volunteer a design, and do not first propose a finished architecture or start implementation.** The human should understand a rough relay through real code and make the meaningful pre-implementation design choices. One question per turn, not a questionnaire.

1. **Ground the first question (agent):** Read the feature request and inspect only relevant repository entry points, reusable functions, contracts, and tests. State one concrete user input/action and the intended response or screen change. Show 2-5 verified existing functions/files with a short role and input/output if relevant; if not yet found, say "未確認". Do not invent function names or insist on an unverified reuse.
2. **Prompt the human first (agent -> human; mandatory):** Ask, proactively and explicitly:
   「まず自分ならどうつなぐか考えてみて。ユーザーの［操作・入力］から［結果］まで、既存の［確認できた関数］をどこで呼んで、どこを新しく書くと実現できそう？ ざっくり2〜3行でOK。」
   The human sketches a relay such as `user action -> UI -> reused/new API client -> handler -> business logic -> DB/job -> response -> UI`. Use only applicable steps; asynchronous acknowledgement and later completion may be separate. Mark each handoff **reuse/import existing / modify existing / write new / unknown**, plus the main data passed. Do not pre-answer the full relay. If the human already gave a relay, reflect it without asking again.
3. **Check understanding (agent):** Compare the human's relay to inspected code, explain only consequential missing/misplaced handoffs (one at a time), and ask them to correct or complete the flow. Confirm they roughly understand input, existing function calls, new code, server/data boundaries, and the returned user-visible result. No line-by-line code or exact syntax is required.
4. **Prompt the human for an initial design policy (agent -> human; mandatory):** Once the relay is understood, ask:
   「この機能はまずどこまで作れば十分だと思う？ どんな型・関数・処理の分け方にしたい？ 気になる点を1つだけでも教えて。」
   Accept an initial guess rather than a complete architecture. The agent must help when stuck: offer **one very short, clearly labeled AI suggestion** for a minimal design policy and **one** relevant issue from the actual feature, in about one sentence each, then ask the human to accept, change, or challenge them. Do **not** replace this prompt with a long AI proposal or a repeat of the same question.
5. **Prompt the human to choose the next design discussion (agent -> human):** Ask only what remains unresolved, e.g., 「このつなぎ方で、一番先に決めたいのはどこ？」 If no concern arises, proactively surface **one** high-impact issue with one concrete input/output example. Debate it, then move to the next material issue. The agent supplies research, alternatives, and risks; the human chooses the consequential trade-offs.
6. **Move to the design gate, not implementation:** Once the relevant questions are resolved, summarize and request explicit design approval under **Pre-Implementation Gates** below. The relay and preliminary policy are understanding aids, not approval.

**Stuck handling applies at every human-thinking step:** give a tiny hint or a 1-2 line example rooted in verified code, then ask one short question. If needed, offer two options with their key difference in one line; the user can select or edit one. Do not force the human to know vocabulary, flood them with lists, or make the process an exam. For purely mechanical changes, use a brief relay check instead of the full interview.

**Illustrative example only (not a claim about any repo):**
- Scenario: user taps "Save problem" with `problemId`; UI should show saved status.
- Agent first shows verified reusable API client and auth functions, then **asks the human** where they would be called and what new save logic is needed.
- Human relay: button -> **reuse** client -> **reuse** auth -> **new** save use case -> **extend/reuse** DB access -> response -> **update** UI.
- Agent checks the real call chain. Then **asks the human** how much to implement now and what to discuss (e.g., saving the same problem twice). Only after discussion and approval does planning begin.

**Anti-pattern:** Agent asks "add save functionality?", chooses a data model and API, displays a seven-section design, and writes tests without first eliciting the human's own relay and design questions.

## 1. Establish Context

- Identify the user, their concrete problem, success criteria, and confirmed facts versus hypotheses.
- Inspect the actual repository, relevant call sites, existing behavior, data stores, tests, and constraints. Never invent codebase facts.
- Reuse existing implementation when it meets the goal. Identify important regressions or interface changes; do not recite irrelevant checks.
- Explain the intended design as a short component/responsibility and data-flow sketch. For stateful work, follow **State Management Review** below.

## 2. Sort Decisions

**Human decision (consult + explicit approval):**
- The human's rough user-input-to-response relay, initial scope/model hypothesis, and the design questions to debate (with succinct agent scaffolding when needed).
- User problem, UX/behavior, business rules, priorities and accepted trade-offs.
- Material component ownership, persistent data model, SSOT, API contracts, system boundaries, new dependencies, irreversible or costly architecture choices.
- Any choice whose best answer depends on what the user values more.

**Agent decision (autonomous, document if material):**
- Mechanical implementation details, naming, tests, and existing-pattern reuse that do not change approved user behavior or architecture.
- Clear technical improvements with no meaningful product trade-off.

A technical choice is *not* automatically a human decision just because two implementations exist. Escalate when the difference materially affects users, system constraints, existing functions, or future reversibility. Present the highest-impact decision first, **one question at a time**.

## 2.5 Pre-Implementation Design Questions (agent prompts; human decides)

After the human understands the relay, **the agent must ask targeted questions to determine what needs to be decided before implementation**, one relevant decision at a time. The human does not have to discover every issue unaided. Start from the human's concern; surface important overlooked ones without turning this into a checklist readout.

Review the following **internally** and prompt only the material unresolved items:
- **Scope and style:** what is sufficient now vs future work; existing project conventions, pure function vs stateful component, and whether a new abstraction is justified.
- **Domain and data model:** what the values represent, whether different meanings should have distinct types (e.g., identifier versus calculated points), valid ranges, representation and mutability.
- **Function/interface and responsibility:** which existing functions to call/import, which new functions own each step, their key inputs/outputs, and API/data boundaries.
- **Invalid/unspecified behavior:** missing, malformed, duplicated, or out-of-range input; errors or user-visible responses; type-level prevention versus runtime validation and trust boundaries.
- **State and consistency when applicable:** where truth lives, who can change it, concurrency/retries, history recomputation vs incremental mutation, security and existing-feature impact.
- **Testable behavior:** observable examples, boundary/error cases, regression promises, and unresolved requirements that must become explicit decisions and tests.

For each material decision: explain the concrete case in plain language, offer the smallest feasible alternatives and differentiating trade-offs, ask **one** concise question, and await the human's choice. The human should be able to say "we chose X because Y, instead of Z because W" in ordinary terms. An AI recommendation is not approval. Prefer solving only the current published/confirmed scope; never silently implement speculative future behavior.

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

## 6. Pre-Implementation Gates (both require human approval)

**Gate A — Design agreement (before writing the implementation plan):**
Summarize compactly: (1) current scope and what is deliberately deferred; (2) one input -> processing relay -> observable response using **verified existing filenames/functions** and **proposed new** ones; (3) important domain values/types, boundaries, ownership/state and source of truth when applicable; (4) invalid/unspecified behavior and failures; (5) main design alternatives and why the chosen one fits. Mark any still-open material question and resolve it before proceeding. **Explicitly ask the human to approve or correct the design.** Neither a first draft of the relay nor silence is design approval.

**Gate B — Test list and implementation plan (after Gate A, before production code):**
Use `superpowers:writing-plans` and the repository's `skills/test-driven-development/test-design-guide.md` to prepare a plan. Show the human (a) files/functions to reuse, create or change; (b) concrete user-visible cases and expected results, including relevant normal, boundary, error and regression cases (and type-level tests when useful); (c) case-by-case RED -> GREEN -> REFACTOR order; (d) verification commands and relevant risks. Separate tests that must first fail from characterization checks that already pass. **Ask for explicit approval of both the test list and implementation plan.** Do not code, edit production files, or start TDD until Gate A and Gate B are approved. A broad "start the feature" request is not approval of a plan the user has never seen.

Keep user-facing summaries short, with one decision/question at a time. For a trivial non-architectural change, use a smaller but still clear plan and approval. If a new material design choice appears in implementation, stop and return to Gate A, then update Gate B. Record significant approved design choices and rejected alternatives in an ADR as specified above.

## 7. Handoff and Learning

Once both gates are approved, implement through the normal TDD, verification, and review skills. The agent owns the actual RED -> GREEN -> REFACTOR execution; the human owns the confirmed behavior and consequential design choices. Give a concise design-to-code walkthrough on request using superpowers:codebase-understanding.

Only propose reusable updates to this skill/constitution after concrete observed problems. Edit them **only with human approval**, test against cases that previously failed, and avoid storing project-specific rules here.

## Calibrated Examples

- [Search state: URL versus localStorage](examples/search-state.md): a shared benefit is **not** a distinguishing reason.
- [Query cache versus editable state](examples/state-ssot.md): SSOT, races, rendering versus server authority.

Examples establish explanation quality and output structure; **never copy their recommendation to another codebase without checking the actual requirements.