#!/usr/bin/env bash
# Install agent shims (commands / skills / prompts) for one or more agents.
#
# Usage:
#   ./setup.sh                  # default: claude
#   ./setup.sh claude
#   ./setup.sh codex
#   ./setup.sh copilot
#   ./setup.sh claude codex     # multiple
#   ./setup.sh all
#
# Source of truth lives in templates/. Generated dirs (.claude/, .codex/,
# .agents/, .github/copilot-instructions.md, .github/prompts/) are gitignored.

set -euo pipefail

repo_root="$(cd "$(dirname "$0")" && pwd)"
cd "$repo_root"

if [[ ! -d templates ]]; then
  echo "error: templates/ not found at $repo_root" >&2
  exit 1
fi

install_claude() {
  echo "==> claude"
  mkdir -p .claude/commands .claude/skills/query-wiki
  cp templates/workflows/*.md .claude/commands/
  cp templates/skill/query-wiki/SKILL.md .claude/skills/query-wiki/SKILL.md
  echo "    .claude/commands/        ← $(ls templates/workflows | wc -l | tr -d ' ') workflows"
  echo "    .claude/skills/query-wiki/SKILL.md"
}

install_codex() {
  echo "==> codex"
  mkdir -p .codex/prompts .agents/skills/query-wiki
  cp templates/workflows/*.md .codex/prompts/
  cp templates/skill/query-wiki/SKILL.md .agents/skills/query-wiki/SKILL.md
  echo "    .codex/prompts/          ← $(ls templates/workflows | wc -l | tr -d ' ') workflows"
  echo "    .agents/skills/query-wiki/SKILL.md  (Codex auto-discovers)"
}

install_copilot() {
  echo "==> copilot"
  mkdir -p .github/prompts
  cp templates/copilot/copilot-instructions.md .github/copilot-instructions.md
  cp templates/copilot/prompts/*.prompt.md .github/prompts/
  echo "    .github/copilot-instructions.md"
  echo "    .github/prompts/         ← $(ls templates/copilot/prompts | wc -l | tr -d ' ') prompts"
}

agents=("$@")
[[ ${#agents[@]} -eq 0 ]] && agents=(claude)
[[ "${agents[*]}" == "all" ]] && agents=(claude codex copilot)

for a in "${agents[@]}"; do
  case "$a" in
    claude)  install_claude ;;
    codex)   install_codex ;;
    copilot) install_copilot ;;
    *) echo "unknown agent: $a (expected: claude | codex | copilot | all)" >&2; exit 2 ;;
  esac
done

echo
echo "done. shims are gitignored — re-run ./setup.sh on each machine you clone to."
