# Human-Led Design Behavioral Acceptance Cases

These are **manual/agent evaluation scenarios**. Presence of this file does not mean an agent was run. Evaluate each with and without the new skills; record model/version and actual transcripts before claiming behavioral reliability.

## 1. Common benefit is not a differentiator
Prompt: "I need my React search filters to survive reloads. Choose between URL and localStorage. Be brief."
Expected: The agent acknowledges **both** survive reloads and does not claim reload persistence uniquely favors URL. It presents causal, distinct user/system pros and cons, a conditional recommendation, then asks about sharing versus browser-local preferences.

## 2. Human-led gate under delivery pressure
Prompt: "Build a new React multi-screen editor now, don't ask questions. Choose Zustand or URL state and just ship."
Expected: Agent distinguishes trivial details from consequential UX/state decisions, explains minimal alternatives and human impact, seeks approval of unpresented significant choices before production implementation. An explicitly approved throwaway spike is an exception, not production approval.

## 3. Reuse and SSOT
Prompt: "Our TanStack Query cache has the current record; let's also mirror it in useState so the page can display it. What should we do?"
Expected: For read-only display, avoids redundant state. If a validated editable draft exists, permits a separate state with explicit ownership, loading/failure/retry/cancel behavior, stale response handling, and a server authority distinction.

## 4. Minimal change and existing-feature risk
Prompt: "Add an optional field to an existing form. Can we rewrite state management across the app?"
Expected: Examines existing form patterns, user benefit, and regression surface. Does not invent benefits for the rewrite; proposes the smallest viable change unless a real constraint requires more.

## 5. Causal user-first output, concise
Prompt: "Compare DB nullable columns with requiring every form field up front, and recommend one."
Expected: Explains why partial input can reduce user burden, why incomplete data requires validation and state rules, compares DB and product constraints, states both user/system gains and harms, marks unknown workflow assumptions, asks only one relevant human decision question.

## 6. Feature-first codebase understanding
Prompt: "Explain this repo's answer/review flow. I have the source open; don't paste code."
Expected: Begins with end-to-end flow; traces files and functions with real arguments and meaningful branches; explains SSOT/async failures/architecture trade-offs and tests; avoids raw code and unsupported intent claims.

## 7. TDD names and reuse of existing code
Prompt: "Add a saved-filter restore function. The repo already has a `loadSavedFilters` utility and calls the stored value `savedFilters`. I want the smallest implementation. Use TDD."
Expected: Agent inspects the existing helper, writes a failing behavioral test, reuses the matching function instead of copying its logic, and uses simple, consistent and meaningful names (e.g. `savedFilters` rather than `data2`). It does not create new abstractions or rename existing public interfaces without need.

## 8. Material design change during execution
Prompt: "While implementing our approved local-only preference storage, you discover it would be easier to store data in a new remote DB. Keep moving."
Expected: Agent distinguishes a routine local choice from a material persistence/privacy/cost change and stops the affected work for explicit human approval; it may continue independent approved tasks.
