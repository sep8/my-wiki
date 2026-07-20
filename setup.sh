#!/usr/bin/env bash
# Install agent shims (commands / skills) for one or more agents.
#
# Usage:
#   ./setup.sh                  # default: claude
#   ./setup.sh claude
#   ./setup.sh codex
#   ./setup.sh copilot
#   ./setup.sh claude codex     # multiple
#   ./setup.sh all
#
# Source of truth lives in templates/. Generated dirs (.claude/, .agents/,
# .github/copilot-instructions.md, .github/prompts/) are gitignored.

set -euo pipefail

repo_root="$(cd "$(dirname "$0")" && pwd)"
cd "$repo_root"

codex_legacy_prompt_filenames=(
  drop-wiki.md
  export-topic.md
  fetch-raw.md
  init-wiki.md
  linting-wiki.md
  new-wiki.md
)
readonly codex_legacy_prompt_filenames

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

codex_workflow_description() {
  case "$1" in
    fetch-raw)
      echo "Download public wiki sources from topic manifests. Use when the user asks to fetch or refresh raw topic sources."
      ;;
    init-wiki)
      echo "Build a curated wiki topic from raw sources. Use when the user asks to initialize or bootstrap a wiki topic."
      ;;
    new-wiki)
      echo "Ingest a newly added source into an existing wiki topic. Use when the user asks to update the wiki from new raw material."
      ;;
    linting-wiki)
      echo "Audit wiki topics for link, index, contradiction, promotion, and freshness issues. Use when the user asks to lint or audit the wiki."
      ;;
    drop-wiki)
      echo "Remove a wiki topic after confirmation and repair affected links. Use when the user explicitly asks to delete or drop a topic."
      ;;
    export-topic)
      echo "Export one curated wiki topic into another repository. Use when the user asks to vendor or export wiki knowledge."
      ;;
    *)
      echo "error: missing Codex skill description for workflow '$1'" >&2
      return 1
      ;;
  esac
}

install_codex() {
  echo "==> codex"
  mkdir -p .agents/skills/query-wiki

  local workflow_path workflow_name skill_dir description
  for workflow_path in templates/workflows/*.md; do
    workflow_name="$(basename "$workflow_path" .md)"
    skill_dir=".agents/skills/$workflow_name"
    description="$(codex_workflow_description "$workflow_name")"
    mkdir -p "$skill_dir"
    {
      printf '%s\n' '---'
      printf 'name: %s\n' "$workflow_name"
      printf 'description: "%s"\n' "$description"
      printf '%s\n\n' '---'
      cat "$workflow_path"
    } > "$skill_dir/SKILL.md"
  done

  cp templates/skill/query-wiki/SKILL.md .agents/skills/query-wiki/SKILL.md

  if [[ ! -L .codex && -d .codex &&
        ! -L .codex/prompts && -d .codex/prompts ]]; then
    local legacy_prompt_filename legacy_prompt_path
    for legacy_prompt_filename in "${codex_legacy_prompt_filenames[@]}"; do
      legacy_prompt_path=".codex/prompts/$legacy_prompt_filename"
      if [[ -L "$legacy_prompt_path" || -f "$legacy_prompt_path" ]]; then
        rm -f -- "$legacy_prompt_path"
      fi
    done
    rmdir .codex/prompts 2>/dev/null || true
    rmdir .codex 2>/dev/null || true
  fi

  echo "    .agents/skills/          ← $(ls templates/workflows | wc -l | tr -d ' ') workflow skills"
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
