#!/usr/bin/env bash
set -euo pipefail

SKILL_NAME="frontend-ui-prototype"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCOPE="global"
PROJECT_DIR=""
INSTALL_CLAUDE=true
INSTALL_CODEX=true
FORCE=false

usage() {
  cat <<'EOF'
Usage:
  ./scripts/install.sh
  ./scripts/install.sh --claude-only
  ./scripts/install.sh --codex-only
  ./scripts/install.sh --project /path/to/project
  ./scripts/install.sh --force

Options:
  --project PATH   Install project-scoped symlinks.
  --claude-only    Install only for Claude Code.
  --codex-only     Install only for Codex.
  --force          Replace an existing target for this skill.
  -h, --help       Show help.
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
      INSTALL_CLAUDE=true
      INSTALL_CODEX=false
      shift
      ;;
    --codex-only)
      INSTALL_CLAUDE=false
      INSTALL_CODEX=true
      shift
      ;;
    --force)
      FORCE=true
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

if [[ ! -f "$ROOT/SKILL.md" ]]; then
  echo "SKILL.md not found at $ROOT" >&2
  exit 1
fi

install_link() {
  local target="$1"
  local parent
  parent="$(dirname "$target")"
  mkdir -p "$parent"

  if [[ -L "$target" ]]; then
    local current
    current="$(readlink "$target")"
    if [[ "$current" == "$ROOT" ]]; then
      echo "Already installed: $target -> $ROOT"
      return
    fi
  fi

  if [[ -e "$target" || -L "$target" ]]; then
    if [[ "$FORCE" == true ]]; then
      rm -rf "$target"
    else
      echo "Target already exists: $target" >&2
      echo "Use --force to replace only this skill target." >&2
      exit 1
    fi
  fi

  ln -s "$ROOT" "$target"
  echo "Installed: $target -> $ROOT"
}

if [[ "$SCOPE" == "global" ]]; then
  CLAUDE_TARGET="$HOME/.claude/skills/$SKILL_NAME"
  CODEX_TARGET="$HOME/.agents/skills/$SKILL_NAME"
else
  CLAUDE_TARGET="$PROJECT_DIR/.claude/skills/$SKILL_NAME"
  CODEX_TARGET="$PROJECT_DIR/.agents/skills/$SKILL_NAME"
fi

if [[ "$INSTALL_CLAUDE" == true ]]; then
  install_link "$CLAUDE_TARGET"
fi

if [[ "$INSTALL_CODEX" == true ]]; then
  install_link "$CODEX_TARGET"
fi

echo
echo "Validation:"
"$ROOT/scripts/validate.sh"
echo
echo "Claude Code invocation: /frontend-ui-prototype"
echo "Codex invocation: \$frontend-ui-prototype"
echo "If a newly created top-level skills directory is not detected, restart the client."
echo "Codex Agent Skills need a recent Codex CLI; check with 'codex --help' or /skills if not detected."
