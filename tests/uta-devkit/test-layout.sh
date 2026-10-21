#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
for f in "$root/LICENSE" "$root/.claude-plugin/plugin.json" "$root/.claude-plugin/marketplace.json" "$root/.codex-plugin/plugin.json" "$root/hooks/session-start" "$root/skills/human-led-design/SKILL.md" "$root/skills/test-driven-development/SKILL.md" "$root/skills/codebase-understanding/SKILL.md"; do
  test -s "$f" || { echo "Missing: $f" >&2; exit 1; }
done
for x in .opencode .pi .kimi-plugin .cursor-plugin .devin-plugin .antigravity-plugin .hermes-plugin .muse-plugin; do
  test ! -e "$root/$x" || { echo "Unsupported integration: $x" >&2; exit 1; }
done
python3 - "$root" <<'PY'
import json, pathlib, sys
root=pathlib.Path(sys.argv[1])
for path in [".claude-plugin/plugin.json",".claude-plugin/marketplace.json",".codex-plugin/plugin.json"]:
    json.loads((root/path).read_text())
PY
echo 'uta-devkit: PASS'
