---
mode: agent
description: Export one curated wiki topic into a code repository for coding-agent use.
---

Run the `export-topic` workflow as specified in [AGENTS.md](../../AGENTS.md).

Execute the script directly:

    ./scripts/export-topic.sh <topic> <target-repo> [dest-dir] [options]

Default destination inside the target repo:

    docs/llm-wiki/<topic>/

Options:

    --force          replace an existing exported topic directory
    --with-skill     install .agents/skills/query-vendored-wiki in the target repo
    --update-agents  append the generated instruction block to target-repo/AGENTS.md

Copy only curated `wiki/<topic>/` pages. Do not copy `raw/` sources unless the
user explicitly asks for source archival.
