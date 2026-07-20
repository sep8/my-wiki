#!/usr/bin/env bash

set -euo pipefail

source_root="$(cd "$(dirname "$0")/.." && pwd -P)"
test_tmp_root="$(cd "${TMPDIR:-/tmp}" && pwd -P)"
test_fixture="$(mktemp -d "$test_tmp_root/setup-codex-test.XXXXXX")"
readonly source_root test_tmp_root test_fixture

cleanup() {
  local cleanup_target fixture_name fixture_parent
  cleanup_target="$test_fixture"
  fixture_name="$(basename "$cleanup_target")"
  fixture_parent="$(dirname "$cleanup_target")"

  if [[ -z "$cleanup_target" || "$cleanup_target" == "/" ||
        "$fixture_parent" != "$test_tmp_root" ||
        "$fixture_name" != setup-codex-test.* ]]; then
    printf 'refusing unsafe test cleanup: %s\n' "$cleanup_target" >&2
    return 1
  fi

  rm -rf -- "$cleanup_target"
}
trap cleanup EXIT HUP INT TERM

legacy_prompts=(
  drop-wiki.md
  export-topic.md
  fetch-raw.md
  init-wiki.md
  linting-wiki.md
  new-wiki.md
)

skill_names=(
  drop-wiki
  export-topic
  fetch-raw
  init-wiki
  linting-wiki
  new-wiki
  query-wiki
)

failures=0

fail() {
  printf 'not ok - %s\n' "$1" >&2
  failures=$((failures + 1))
}

prepare_repo() {
  local fixture_repo
  fixture_repo="$test_fixture/$1"
  mkdir -p "$fixture_repo"
  cp "$source_root/setup.sh" "$fixture_repo/setup.sh"
  cp -R "$source_root/templates" "$fixture_repo/templates"
  printf '%s\n' "$fixture_repo"
}

run_setup() {
  (cd "$1" && bash setup.sh codex >/dev/null)
}

legacy_prompts_are_intact() {
  local prompt_dir prompt_name
  prompt_dir="$1"
  for prompt_name in "${legacy_prompts[@]}"; do
    [[ -f "$prompt_dir/$prompt_name" ]] || return 1
  done
}

write_legacy_prompts() {
  local prompt_dir prompt_name
  prompt_dir="$1"
  mkdir -p "$prompt_dir"
  for prompt_name in "${legacy_prompts[@]}"; do
    printf 'legacy %s\n' "$prompt_name" > "$prompt_dir/$prompt_name"
  done
}

skill_checksums() {
  local fixture_repo skill_name
  fixture_repo="$1"
  for skill_name in "${skill_names[@]}"; do
    cksum "$fixture_repo/.agents/skills/$skill_name/SKILL.md"
  done
}

normal_repo="$(prepare_repo normal)"
write_legacy_prompts "$normal_repo/.codex/prompts"
printf '%s\n' 'preserve me' > "$normal_repo/.codex/prompts/custom.md"
mkdir -p "$normal_repo/.codex/custom"
printf '%s\n' 'preserve me too' > "$normal_repo/.codex/custom/keep.txt"

run_setup "$normal_repo"

for legacy_prompt in "${legacy_prompts[@]}"; do
  if [[ -e "$normal_repo/.codex/prompts/$legacy_prompt" ||
        -L "$normal_repo/.codex/prompts/$legacy_prompt" ]]; then
    fail "known legacy prompt was not removed: $legacy_prompt"
  fi
done
[[ -f "$normal_repo/.codex/prompts/custom.md" ]] || fail 'unknown prompt was not preserved'
[[ -f "$normal_repo/.codex/custom/keep.txt" ]] || fail 'unknown .codex directory was not preserved'

for skill_name in "${skill_names[@]}"; do
  [[ -f "$normal_repo/.agents/skills/$skill_name/SKILL.md" ]] ||
    fail "missing generated Skill: $skill_name"
done

generated_skill_count=0
for generated_skill in "$normal_repo"/.agents/skills/*/SKILL.md; do
  [[ -f "$generated_skill" ]] || continue
  generated_skill_count=$((generated_skill_count + 1))
done
[[ "$generated_skill_count" -eq 7 ]] ||
  fail "expected exactly 7 generated Skills, found $generated_skill_count"

first_checksums="$(skill_checksums "$normal_repo")"
run_setup "$normal_repo"
second_checksums="$(skill_checksums "$normal_repo")"
[[ "$first_checksums" == "$second_checksums" ]] || fail 'repeat setup changed generated Skills'
[[ -f "$normal_repo/.codex/prompts/custom.md" ]] || fail 'repeat setup removed unknown prompt'

slash_invocation_pattern='(^|[^.[:alnum:]_/-])/(drop-wiki|export-topic|fetch-raw|init-wiki|linting-wiki|new-wiki)([^[:alnum:]_-]|$)'
dollar_invocation_pattern='(^|[^[:alnum:]_-])\$(drop-wiki|export-topic|fetch-raw|init-wiki|linting-wiki|new-wiki)([^[:alnum:]_-]|$)'
if grep -E "$slash_invocation_pattern" "$normal_repo"/.agents/skills/*/SKILL.md >/dev/null; then
  fail 'generated Skills contain slash-prefixed workflow guidance'
fi
if grep -E "$dollar_invocation_pattern" "$normal_repo"/.agents/skills/*/SKILL.md >/dev/null; then
  fail 'generated Skills contain dollar-prefixed workflow guidance'
fi

codex_symlink_repo="$(prepare_repo codex-symlink)"
codex_symlink_target="$test_fixture/codex-symlink-target"
write_legacy_prompts "$codex_symlink_target/prompts"
ln -s "$codex_symlink_target" "$codex_symlink_repo/.codex"
run_setup "$codex_symlink_repo"
[[ -L "$codex_symlink_repo/.codex" ]] || fail '.codex directory symlink was replaced or removed'
legacy_prompts_are_intact "$codex_symlink_target/prompts" ||
  fail 'setup cleaned through a .codex directory symlink'

prompts_symlink_repo="$(prepare_repo prompts-symlink)"
prompts_symlink_target="$test_fixture/prompts-symlink-target"
mkdir -p "$prompts_symlink_repo/.codex"
write_legacy_prompts "$prompts_symlink_target"
ln -s "$prompts_symlink_target" "$prompts_symlink_repo/.codex/prompts"
run_setup "$prompts_symlink_repo"
[[ -L "$prompts_symlink_repo/.codex/prompts" ]] ||
  fail '.codex/prompts symlink was replaced or removed'
legacy_prompts_are_intact "$prompts_symlink_target" ||
  fail 'setup cleaned through a .codex/prompts symlink'

if [[ "$failures" -ne 0 ]]; then
  printf 'FAIL: %s setup-codex regression(s)\n' "$failures" >&2
  exit 1
fi

printf '%s\n' 'ok - setup-codex safety, generation, and surface checks passed'
