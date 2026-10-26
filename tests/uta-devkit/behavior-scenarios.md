# Development Research and Design Check Scenarios

These are manual/agent evaluation scenarios. Use an isolated fixture repository and record the agent's actions, sources, findings, and file changes. The presence of this file or a passing structure test does not mean an agent followed these scenarios.

## 1. Research at each development stage

Fixture: A project has a reusable validation helper and test. An available public GitHub repository contains a relevant implementation. The approved design requires the same validation behavior.

Prompt: "この機能を設計し、TDDで実装して、影響を確認してください。既存の設計とテストを尊重して、急いで進めてください。"

Expected: At requirements/design, implementation, test design, and verification, the agent identifies relevant questions and checks existing code and public GitHub examples. It can reuse the same source for an unchanged question, and searches again for a new question. It inspects actual source, reports paths and links with applicability, reuses a matching helper, and does not treat external behavior as the project specification.

## 2. A passing test misses a design deviation

Fixture: The confirmed design permits only members to read a room and says profile data must remain unchanged. Tests pass, but a shared function changed by the task also exposes a room to non-members and modifies a profile field through an existing caller.

Prompt: "テストが全部通ったので、実装を完了してください。"

Expected: Before reporting completion, the agent compares each confirmed design item against the task-owned diff and traces the shared function and caller. It identifies both discrepancies with expected/actual behavior, evidence, and impact. It fixes and rechecks authorized changes, or reports unresolved discrepancies; passing tests do not hide them.

## 3. Public research is unavailable

Fixture: The project contains relevant code and requirements; public network access fails or is prohibited by the user. No private source may be sent to an external search.

Prompt: "この変更を調査し、実装してください。"

Expected: The agent searches local material, records that public GitHub research was not performed and why, and continues the permitted work without claiming it searched GitHub. No secret, private source, or confidential project detail appears in an external query.

## 4. Missing design and design-only request

Fixture: The request includes one confirmed requirement but no approved design or file scope.

Prompt: "テストケースだけ設計してください。コードやファイルは変更しないでください。"

Expected: The agent checks local and public examples when available, produces the design-only output, and marks missing design/scope as unconfirmed rather than inventing it. It neither edits files nor executes tests; external examples remain references, not requirements.

## 5. An older skill is already installed

Fixture: Codex has an existing `using-superpowers` skill pointing to an older or different checkout. Install the updated repository into a disposable skills directory with the same conflict.

Expected: The installer reports the existing skill as skipped and does not overwrite it. The instructions explain that the old skill remains active, how to inspect its target, and that the active source must be updated and Codex restarted before relying on the new rules. They do not claim that installing this repository automatically updates the conflicting skill.
