#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
bridge="$repo_root/templates/hermes/my-wiki/SKILL.md"

[[ -f "$bridge" ]]
grep -Fqx 'name: my-wiki' "$bridge"
grep -F 'templates/workflows/fetch-raw.md' "$bridge"
grep -F 'templates/workflows/init-wiki.md' "$bridge"
grep -F 'templates/workflows/new-wiki.md' "$bridge"
grep -F 'templates/workflows/linting-wiki.md' "$bridge"
grep -F 'templates/workflows/drop-wiki.md' "$bridge"
grep -F 'templates/workflows/export-topic.md' "$bridge"
grep -F 'templates/skill/query-wiki/SKILL.md' "$bridge"

workdir="$(mktemp -d)"
trap 'rm -rf "$workdir"' EXIT

hermes_home="$workdir/hermes-home"
(
  cd "$repo_root"
  HERMES_HOME="$hermes_home" ./setup.sh hermes >"$workdir/hermes.out"
)

installed="$hermes_home/skills/my-wiki/SKILL.md"
[[ -f "$installed" ]]
cmp -s "$bridge" "$installed"
grep -F 'hermes --skills my-wiki' "$workdir/hermes.out"

all_home="$workdir/all-home"
(
  cd "$repo_root"
  HERMES_HOME="$all_home" ./setup.sh all >"$workdir/all.out"
)
[[ -f "$all_home/skills/my-wiki/SKILL.md" ]]
[[ -f "$repo_root/.claude/commands/fetch-raw.md" ]]
[[ -f "$repo_root/.agents/skills/fetch-raw/SKILL.md" ]]
[[ -f "$repo_root/.github/copilot-instructions.md" ]]

set +e
(
  cd "$repo_root"
  ./setup.sh unknown-agent >"$workdir/unknown.out" 2>&1
)
status=$?
set -e
[[ $status -eq 2 ]]
grep -F 'claude | codex | copilot | hermes | all' "$workdir/unknown.out"

grep -F './setup.sh hermes' "$repo_root/README.md"
grep -F 'hermes --skills my-wiki' "$repo_root/README.md"
grep -F './setup.sh hermes' "$repo_root/AGENTS.md"
grep -F 'hermes --skills my-wiki' "$repo_root/AGENTS.md"
