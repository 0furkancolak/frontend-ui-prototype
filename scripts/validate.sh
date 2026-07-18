#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL="$ROOT/SKILL.md"

fail() {
  echo "Validation failed: $1" >&2
  exit 1
}

[[ -f "$SKILL" ]] || fail "SKILL.md is missing"
grep -q '^---$' "$SKILL" || fail "YAML frontmatter marker is missing"
grep -q '^name: frontend-ui-prototype$' "$SKILL" || fail "name must be frontend-ui-prototype"
grep -q '^description:' "$SKILL" || fail "description is missing"

for path in \
  "Makefile" \
  "README.md" \
  "agents/openai.yaml" \
  "references/intake.md" \
  "references/modes.md" \
  "references/product-extraction.md" \
  "references/design-md-research.md" \
  "references/design-tokens.md" \
  "references/visual-assets.md" \
  "references/single-file-prototype.md" \
  "references/quality-gate.md" \
  "templates/DESIGN.md" \
  "templates/index.html" \
  "templates/Makefile.prototype" \
  "tests/trigger-prompts.md" \
  "scripts/install.sh" \
  "scripts/uninstall.sh"; do
  [[ -f "$ROOT/$path" ]] || fail "$path is missing"
done

bash -n "$ROOT/scripts/install.sh"
bash -n "$ROOT/scripts/uninstall.sh"
bash -n "$ROOT/scripts/validate.sh"

python3 - "$SKILL" "$ROOT/templates/index.html" <<'PY'
from pathlib import Path
import sys

skill_path = Path(sys.argv[1])
html_path = Path(sys.argv[2])
text = skill_path.read_text(encoding="utf-8")
lines = text.splitlines()

if len(lines) > 500:
    raise SystemExit(f"Validation failed: SKILL.md has {len(lines)} lines; keep it under 500")

parts = text.split("---", 2)
if len(parts) < 3:
    raise SystemExit("Validation failed: invalid frontmatter")

frontmatter = parts[1]
description_lines = []
capture = False
for line in frontmatter.splitlines():
    if line.startswith("description:"):
        capture = True
        description_lines.append(line.split(":", 1)[1].strip())
        continue
    if capture:
        if line and not line.startswith((" ", "\t")):
            break
        description_lines.append(line.strip())

description = " ".join(x for x in description_lines if x)
if len(description) > 1536:
    raise SystemExit(
        f"Validation failed: description is {len(description)} characters; limit is 1536"
    )

html = html_path.read_text(encoding="utf-8").lower()
required = ["<!doctype html>", 'name="viewport"', "@tailwindcss/browser@4"]
for item in required:
    if item not in html:
        raise SystemExit(f"Validation failed: templates/index.html missing {item}")

if "@latest" in html or "/latest/" in html:
    raise SystemExit("Validation failed: templates/index.html contains an unpinned dependency")

print(f"SKILL.md lines: {len(lines)}")
print(f"Description characters: {len(description)}")
PY

make -C "$ROOT" -n validate >/dev/null

echo "frontend-ui-prototype is valid."
