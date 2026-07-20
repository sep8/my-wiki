Export one curated wiki topic into a code repository so coding agents can use
it as local project knowledge.

Arguments:
  <topic> <target-repo>
  <topic> <target-repo> [dest-dir]

Default destination inside the target repo:

    docs/llm-wiki/<topic>/

Run the script directly:

    ./scripts/export-topic.sh <topic> <target-repo> [dest-dir] [options]

Options:

    --force          replace an existing exported topic directory
    --with-skill     install .agents/skills/query-vendored-wiki in the target repo
    --update-agents  append the generated instruction block to target-repo/AGENTS.md

Recommended flow:

1. Confirm `wiki/<topic>/index.md` exists.
2. Run the script with the requested target repo.
3. Prefer `--with-skill` when the target coding agent supports `.agents/skills/`.
4. Prefer `--update-agents` only when the user wants the script to edit the
   target repo's `AGENTS.md`; otherwise tell them the snippet path.

The export copies only curated pages from `wiki/<topic>/`. It does not copy
`raw/<topic>/`, `_raw/<topic>.md`, or the whole llm-wiki repository.
