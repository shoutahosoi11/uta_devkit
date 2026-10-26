#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "$0")/../.." && pwd)"
for file in skills/test-driven-development/test-design-guide.md skills/test-driven-development/SKILL.md skills/test-driven-development/writing-good-tests.md; do
  test -s "$root/$file"
done

guide="$root/skills/test-driven-development/test-design-guide.md"
skill="$root/skills/test-driven-development/SKILL.md"

if grep -Fq 'あなたはTDDのテスト設計者です' "$guide"; then
  printf '%s\n' 'FAIL: guide still contains the chat-only opening' >&2
  exit 1
fi

for heading in '## モード' '## チャットに貼る場合' '### 5.1 候補の洗い出し' '### 5.2 代表ケースの選定' '## 8. 出力例'; do
  grep -Fxq "$heading" "$guide"
done
grep -Fq '[writing-good-tests.md](writing-good-tests.md)' "$guide"

awk '
  /^```/ { in_code = !in_code; next }
  !in_code && /^## / { in_chat_section = ($0 == "## チャットに貼る場合") }
  index($0, "〈ここに実装したい内容を書く〉") {
    found++
    if (!in_chat_section || !in_code) invalid = 1
  }
  END { exit !(found > 0 && !invalid && !in_code) }
' "$guide" || {
  printf '%s\n' 'FAIL: the target placeholder must appear only in the chat template code block' >&2
  exit 1
}

grep -Fq '[test-design-guide.md](test-design-guide.md)' "$skill"
grep -Fq '**Two modes**' "$skill"
grep -Fq '**Scope check:**' "$skill"
grep -Fq 'Every public contract listed in the design' "$skill"
for old_rule in '今回はテスト設計のみを行う' 'Every new function/method has a test'; do
  if grep -Fq "$old_rule" "$skill"; then
    printf 'FAIL: obsolete skill rule: %s\n' "$old_rule" >&2
    exit 1
  fi
done
grep -Fq 'test-design-guide.md' "$root/AGENTS.md"
echo PASS
