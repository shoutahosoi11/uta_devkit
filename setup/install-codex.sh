#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
dest="${CODEX_SKILLS_DIR:-$HOME/.agents/skills}"
mkdir -p "$dest"
installed=0
skipped=0
for dir in "$root"/skills/*; do
  [[ -f "$dir/SKILL.md" ]] || continue
  target="$dest/${dir##*/}"
  if [[ -e "$target" || -L "$target" ]]; then
    printf 'SKIP existing: %s\n' "$target"
    skipped=$((skipped+1))
    continue
  fi
  ln -s "$dir" "$target"
  printf 'LINK %s -> %s\n' "$target" "$dir"
  installed=$((installed+1))
done
printf 'Installed %s, skipped %s. Restart Codex.\n' "$installed" "$skipped"
