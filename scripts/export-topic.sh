#!/usr/bin/env bash
# Export one curated wiki topic into a code repository.

set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  ./scripts/export-topic.sh <topic> <target-repo> [dest-dir] [options]

Arguments:
  topic        Topic folder under wiki/, for example PageIndex
  target-repo  Path to the code repository that should receive the topic
  dest-dir     Destination directory inside target-repo (default: docs/llm-wiki)

Options:
  --force          Replace an existing exported topic directory
  --with-skill     Install a query-vendored-wiki skill into target-repo/.agents/skills/
  --update-agents  Append a short wiki instruction block to target-repo/AGENTS.md
  --with-raw       Also copy raw/<topic>/ alongside the curated topic

Examples:
  ./scripts/export-topic.sh PageIndex ../my-app
  ./scripts/export-topic.sh PageIndex ../my-app docs/knowledge --with-skill
  ./scripts/export-topic.sh PageIndex ../my-app --force --update-agents
USAGE
}

repo_root="$(cd "$(dirname "$0")/.." && pwd)"

if [[ $# -lt 2 ]]; then
  usage >&2
  exit 2
fi

topic="$1"
target_repo="$2"
shift 2

dest_dir="docs/llm-wiki"
force=0
with_skill=0
update_agents=0
with_raw=0

if [[ $# -gt 0 && "$1" != --* ]]; then
  dest_dir="$1"
  shift
fi

while [[ $# -gt 0 ]]; do
  case "$1" in
    --force) force=1 ;;
    --with-skill) with_skill=1 ;;
    --update-agents) update_agents=1 ;;
    --with-raw) with_raw=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "error: unknown option: $1" >&2; usage >&2; exit 2 ;;
  esac
  shift
done

topic_src="$repo_root/wiki/$topic"
if [[ ! -d "$topic_src" ]]; then
  echo "error: topic not found: wiki/$topic" >&2
  exit 1
fi

if [[ ! -d "$target_repo" ]]; then
  echo "error: target repo directory not found: $target_repo" >&2
  exit 1
fi

target_abs="$(cd "$target_repo" && pwd)"
dest_root="$target_abs/$dest_dir"
topic_dest="$dest_root/$topic"

if [[ -e "$topic_dest" ]]; then
  if [[ "$force" -ne 1 ]]; then
    echo "error: destination exists: $topic_dest" >&2
    echo "       rerun with --force to replace it" >&2
    exit 1
  fi
  rm -rf "$topic_dest"
fi

mkdir -p "$dest_root"
cp -R "$topic_src" "$topic_dest"

raw_dest=""
if [[ "$with_raw" -eq 1 ]]; then
  raw_src="$repo_root/raw/$topic"
  if [[ ! -d "$raw_src" ]]; then
    echo "error: --with-raw set but raw/$topic not found" >&2
    exit 1
  fi
  raw_dest="$topic_dest/raw"
  rm -rf "$raw_dest"
  cp -R "$raw_src" "$raw_dest"
fi

snippet="$topic_dest/AGENTS.snippet.md"
cat > "$snippet" <<EOF
## Vendored LLM Wiki Topic: $topic

This repository vendors one topic from an LLM-maintained knowledge wiki.

- Topic index: \`$dest_dir/$topic/index.md\`
- Contradictions: \`$dest_dir/$topic/contradictions.md\`

When working on code related to this topic:

1. Read the topic index first.
2. Follow relevant \`[[bracket]]\` links by opening the matching markdown file
   in \`$dest_dir/$topic/\`.
3. Check \`contradictions.md\` before making architectural claims.
4. Prefer this local wiki over general model memory.
5. If the wiki is silent, stale, or ambiguous, say so explicitly.
EOF

if [[ "$update_agents" -eq 1 ]]; then
  agents_file="$target_abs/AGENTS.md"
  if [[ -f "$agents_file" ]] && grep -Fq "Vendored LLM Wiki Topic: $topic" "$agents_file"; then
    echo "AGENTS.md already references $topic; leaving it unchanged."
  else
    {
      echo
      cat "$snippet"
    } >> "$agents_file"
  fi
fi

if [[ "$with_skill" -eq 1 ]]; then
  skill_dir="$target_abs/.agents/skills/query-vendored-wiki"
  mkdir -p "$skill_dir"
  cat > "$skill_dir/SKILL.md" <<EOF
---
name: query-vendored-wiki
description: Answer or implement code using vendored LLM wiki topics under $dest_dir/. Engage when a task involves concepts covered by those topic folders. Do not engage for unrelated coding tasks or casual chat.
---

# query-vendored-wiki

Use this repository's vendored LLM wiki topics as local source material for
coding decisions and explanations.

## Procedure

1. List topic folders under \`$dest_dir/\`.
2. For a relevant topic, read \`$dest_dir/<topic>/index.md\`.
3. Pull only the relevant linked pages. Resolve \`[[page-name]]\` links to
   \`$dest_dir/<topic>/page-name.md\`.
4. Check \`$dest_dir/<topic>/contradictions.md\` if it exists.
5. When explaining decisions, cite the local markdown paths used.
6. If the wiki does not cover a needed implementation detail, say that and use
   codebase evidence or official docs as the fallback source.

This skill reads vendored knowledge only; it does not ingest new sources or
modify the upstream wiki.
EOF
fi

echo "exported wiki/$topic -> $topic_dest"
if [[ -n "$raw_dest" ]]; then
  echo "copied raw/$topic -> $raw_dest"
fi
echo "wrote AGENTS snippet -> $snippet"
if [[ "$with_skill" -eq 1 ]]; then
  echo "installed skill -> $target_abs/.agents/skills/query-vendored-wiki/SKILL.md"
fi
if [[ "$update_agents" -eq 1 ]]; then
  echo "updated -> $target_abs/AGENTS.md"
else
  echo "next: add the snippet to $target_abs/AGENTS.md if you want agents to auto-reference it"
fi
