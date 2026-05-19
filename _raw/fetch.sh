#!/usr/bin/env bash
# Download sources listed in _raw/<topic>.md into raw/<topic>/.
# Usage: ./_raw/fetch.sh <topic>            # one topic
#        ./_raw/fetch.sh                    # all topics
# Manifest format: `- [label](url) → filename` (one per line).

set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$repo_root"

fetch_one() {
  local topic="$1"
  local manifest="_raw/${topic}.md"
  local dest="raw/${topic}"

  if [[ ! -f "$manifest" ]]; then
    echo "no manifest: $manifest" >&2
    return 1
  fi

  mkdir -p "$dest"
  echo "==> $topic"

  # Match lines like: - [label](url) → filename
  # Capture url and filename.
  grep -E '^\- \[.+\]\(.+\) → .+$' "$manifest" | while IFS= read -r line; do
    url=$(printf '%s' "$line" | sed -E 's/^- \[[^]]+\]\(([^)]+)\) → .+$/\1/')
    name=$(printf '%s' "$line" | sed -E 's/^- \[[^]]+\]\([^)]+\) → (.+)$/\1/')
    out="${dest}/${name}"
    if [[ -f "$out" ]]; then
      echo "  skip (exists): $name"
    else
      echo "  fetch: $name <- $url"
      curl -fsSL --retry 3 -o "$out" "$url" || {
        echo "  FAILED: $url" >&2
        rm -f "$out"
      }
    fi
  done
}

if [[ $# -eq 0 ]]; then
  shopt -s nullglob
  for m in _raw/*.md; do
    topic=$(basename "$m" .md)
    fetch_one "$topic"
  done
else
  for topic in "$@"; do
    fetch_one "$topic"
  done
fi
