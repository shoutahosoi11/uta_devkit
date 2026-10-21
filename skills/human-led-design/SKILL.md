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

For every meaningful alternative, explain:

**Different technical/structural property → why it produces the effect → user benefit and harm → system benefit and harm.**

- Evaluate **both user and system**, with user consequences first. If no material effect is identifiable, write "No meaningful difference identified"; never invent a benefit to fill a box.
- Name concrete alternatives and describe the **differences relative to other feasible options**.
- Separate **shared requirement satisfaction** from **differentiating advantages**. An ability shared by URL and localStorage (e.g., reload persistence) is not by itself a reason to choose URL.
- Explain project-specific conditions. Compare implementation scope, reuse, dependencies, and existing-feature impact *when relevant*, without making every answer a long checklist.
- Distinguish **verified technical fact**, **reasoned prediction**, and **unverified user-value hypothesis**. Do not promote a hypothesis into a confirmed requirement.
- Include costs, safety, privacy, security, accessibility, performance, and operational trade-offs when they could change the decision.
- When a simpler solution achieves the same user outcome within constraints, prefer it. Avoid speculative abstractions, additional state, or technologies without demonstrated benefit.

## 4. State Management Review (only when relevant)

Explain the proposed state/data-flow diagram or concise mapping:

1. **Location and lifetime:** where each state is owned/stored (component, URL, cache, DB, browser), why there, and when it expires or is destroyed.
2. **SSOT and duplication:** what is authoritative; is the displayed value derived from existing data? If replicated or cached, what synchronizes and invalidates it?
3. **Ownership and mutation:** who may read/change it, on which user event/system event, and with what authorization.
4. **Transitions and failures:** idle/loading/success/error, retries, cancellation, rollbacks, and what users see at each point.
5. **Concurrency and order:** stale/out-of-order responses, simultaneous writes, races, idempotency, and conflict resolution.
6. **Existing functionality:** only when implicated, identify impacted screens, APIs, state transitions, and regression tests.

Distinguish the authoritative server record from a client-side query cache: a UI cache can be the single source for *rendering* without being the authoritative persisted record. An editable draft may be a deliberately distinct state, not an accidental duplicate.

## 5. Mandatory Decision Output (keep concise)

Use these headings **in this order** for substantive design discussion; skip inapplicable subsections only when explicitly marked optional. For a narrow question, cover only the decision at hand.

### 1. ユーザーの課題
Who is affected, what problem is solved, desired outcome, and known facts versus hypotheses.

### 2. 既存システムと制約
Only relevant existing behavior, reusable components, hard constraints, and important impact surface. Show the design/state/data flow when relevant.

### 3. 選択肢
For **each named option**, show:
- **技術的性質:** how this differs from the other options.
- **ユーザーのメリット:** property → causal reason → concrete improvement for users.
- **ユーザーのデメリット:** property/constraint → causal reason → concrete user harm or risk.
- **システムのメリット:** property → causal reason → reliability/maintenance/performance/implementation improvement.
- **システムのデメリット:** property → causal reason → complexity/cost/risk.
- **既存機能への影響:** **only when relevant**, describe what might change or regress.

For a category without a meaningful effect, state that briefly, rather than inventing one.

### 4. 選択肢間の比較
Separate common outcomes from unique/relative advantages. Show the smallest change satisfying the confirmed goal and what each option sacrifices.

### 5. AIの推奨
State recommendation **or that the evidence is insufficient**, its comparative and project-specific rationale, concrete user/system gains and losses, accepted trade-off, assumptions, and **what condition would reverse the recommendation**.

### 6. 人間への質問
Ask exactly one material question that resolves the next human-owned trade-off. Do not ask about implementation details the agent can decide.

### 7. ADR（承認後のみ）
After human approval, record decision, options rejected and why, known consequences, and reversal conditions using [templates/ADR.md](templates/ADR.md). For significant decisions, save an ADR in the consuming project's own docs; for small changes, record the decision in the approved design/chat. Never mark a proposal as approved.

**No implementation before explicit approval of material design decisions and the design itself.** Reading, exploration and non-production analysis are allowed. A human-approved throwaway spike is allowed, but must not silently become production code. Skipping discovery questions never implies approval of unpresented significant choices.

## 6. Handoff and Learning

After approval, hand the approved design to superpowers:writing-plans; the normal TDD, implementation, verification, and review skills remain in charge. If implementation reveals a new material choice, pause for a new human decision. Give a concise design-to-code walkthrough on request using superpowers:codebase-understanding.

Only propose reusable updates to this skill/constitution after concrete observed problems. Edit them **only with human approval**, test against cases that previously failed, and avoid storing project-specific rules here.

## Calibrated Examples

- [Search state: URL versus localStorage](examples/search-state.md): a shared benefit is **not** a distinguishing reason.
- [Query cache versus editable state](examples/state-ssot.md): SSOT, races, rendering versus server authority.

Examples establish explanation quality and output structure; **never copy their recommendation to another codebase without checking the actual requirements.