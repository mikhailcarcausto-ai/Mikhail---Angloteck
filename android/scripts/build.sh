#!/usr/bin/env bash
# Packages Android for upload:
#   dist/android-skill.zip        → claude.ai Skills / Claude Code
#   dist/claude-project/          → files to upload as Claude Project knowledge
# Also checks the Copilot instructions block fits the 8,000-character limit.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DIST="$ROOT/dist"
rm -rf "$DIST" && mkdir -p "$DIST/claude-project"

( cd "$ROOT/skill" && zip -qr "$DIST/android-skill.zip" android )
cp "$ROOT"/skill/android/references/*.md "$DIST/claude-project/"
cp "$ROOT/project/system-prompt.md" "$DIST/claude-project/_PASTE-AS-INSTRUCTIONS.md"
[ -f "$ROOT/private/memoria-android.md" ] && cp "$ROOT/private/memoria-android.md" "$DIST/claude-project/"

python3 - "$ROOT/copilot/instructions.md" <<'PY'
import re, sys
block = re.search(r"```\n(.*?)\n```", open(sys.argv[1], encoding="utf-8").read(), re.S).group(1)
n = len(block)
print(f"Copilot instructions: {n} chars (limit 8000)")
sys.exit(1 if n > 8000 else 0)
PY

echo "Built:"; ls -1 "$DIST" "$DIST/claude-project"
