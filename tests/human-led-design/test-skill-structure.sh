#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "$0")/../.." && pwd)"
for file in skills/human-led-design/SKILL.md skills/human-led-design/constitution.md skills/human-led-design/templates/ADR.md skills/human-led-design/examples/search-state.md skills/human-led-design/examples/state-ssot.md skills/codebase-understanding/SKILL.md; do
  test -s "$root/$file"
done
grep -q 'REQUIRED SUB-SKILL: Use superpowers:human-led-design' "$root/skills/brainstorming/SKILL.md"
grep -q '## Response Style (All Replies)' "$root/skills/using-superpowers/SKILL.md"
grep -q 'SSOT' "$root/skills/human-led-design/SKILL.md"
grep -q 'ユーザーのメリット' "$root/skills/human-led-design/SKILL.md"
grep -q 'システムのデメリット' "$root/skills/human-led-design/SKILL.md"
grep -q '## Readable Naming and Reuse' "$root/skills/test-driven-development/SKILL.md"
grep -q '## Naming and Existing-Logic Reuse' "$root/skills/writing-plans/SKILL.md"
grep -q 'Reuse a compatible existing implementation' "$root/skills/subagent-driven-development/implementer-prompt.md"
grep -q 'Human-owned decisions take precedence' "$root/skills/executing-plans/SKILL.md"
grep -q 'Human-owned decisions take precedence' "$root/skills/subagent-driven-development/SKILL.md"
echo PASS
