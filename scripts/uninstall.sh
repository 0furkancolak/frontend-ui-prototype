#!/usr/bin/env bash
set -euo pipefail

SKILL_NAME="frontend-ui-prototype"
SCOPE="global"
PROJECT_DIR=""
REMOVE_CLAUDE=true
REMOVE_CODEX=true

usage() {
  cat <<'EOF'
Usage:
  ./scripts/uninstall.sh
  ./scripts/uninstall.sh --claude-only
  ./scripts/uninstall.sh --codex-only
  ./scripts/uninstall.sh --project /path/to/project
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project)
      [[ $# -ge 2 ]] || { echo "Missing value for --project" >&2; exit 1; }
      SCOPE="project"
      PROJECT_DIR="$(cd "$2" && pwd)"
      shift 2
      ;;
    --claude-only)
      REMOVE_CLAUDE=true
      REMOVE_CODEX=false
      shift
      ;;
    --codex-only)
      REMOVE_CLAUDE=false
      REMOVE_CODEX=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ "$SCOPE" == "global" ]]; then
  CLAUDE_TARGET="$HOME/.claude/skills/$SKILL_NAME"
  CODEX_TARGET="$HOME/.agents/skills/$SKILL_NAME"
else
  CLAUDE_TARGET="$PROJECT_DIR/.claude/skills/$SKILL_NAME"
  CODEX_TARGET="$PROJECT_DIR/.agents/skills/$SKILL_NAME"
fi

remove_target() {
  local target="$1"
  if [[ -L "$target" ]]; then
    rm "$target"
    echo "Removed symlink: $target"
  elif [[ -e "$target" ]]; then
    echo "Skipped non-symlink target: $target" >&2
  else
    echo "Not installed: $target"
  fi
}

if [[ "$REMOVE_CLAUDE" == true ]]; then
  remove_target "$CLAUDE_TARGET"
fi

if [[ "$REMOVE_CODEX" == true ]]; then
  remove_target "$CODEX_TARGET"
fi
