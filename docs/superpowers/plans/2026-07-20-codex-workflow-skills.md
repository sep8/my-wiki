# Codex Workflow Skills Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make `./setup.sh codex` generate six repo-local Codex workflow Skills and stop generating `.codex/prompts/`.

**Architecture:** Keep `templates/workflows/*.md` as the shared workflow bodies. `setup.sh` adds required Skill frontmatter while copying each body into `.agents/skills/<workflow>/SKILL.md`, alongside the existing `query-wiki` skill. Migration cleanup removes only known generated prompt files and preserves unknown `.codex` content.

**Tech Stack:** Bash 3-compatible shell, Markdown/YAML `SKILL.md`, repository documentation, Skill Creator validation script.

## Global Constraints

- Do not create or modify files under `~/.codex` or any other user-level configuration directory.
- Stop generating `.codex/prompts/` completely.
- Keep `templates/workflows/*.md` as the single workflow-content source.
- Preserve Claude Code and GitHub Copilot generation behavior.
- Preserve unknown user-created files under the repository's `.codex/` directory.
- Generated Skill names must use lowercase hyphen-case and match their workflow filenames.

---

### Task 1: Generate repo-local Codex workflow Skills

**Files:**
- Modify: `setup.sh:1-66`
- Read: `templates/workflows/*.md`
- Generate: `.agents/skills/<workflow>/SKILL.md` (gitignored)

**Interfaces:**
- Consumes: workflow Markdown files named `<workflow>.md` and `templates/skill/query-wiki/SKILL.md`.
- Produces: seven discoverable repo-local Skills under `.agents/skills/`; six generated workflow skills plus `query-wiki`.

- [ ] **Step 1: Verify the current setup does not produce workflow Skills**

Run:

```bash
./setup.sh codex
test ! -f .agents/skills/linting-wiki/SKILL.md
```

Expected: `./setup.sh codex` succeeds and the `test` command succeeds, proving the workflow Skill is absent before implementation.

- [ ] **Step 2: Add a Bash 3-compatible workflow description function**

Add this function above `install_codex()` in `setup.sh`:

```bash
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
```

- [ ] **Step 3: Replace Codex prompt generation with Skill generation**

Replace `install_codex()` with:

```bash
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

  if [[ -d .codex/prompts ]]; then
    for workflow_path in templates/workflows/*.md; do
      rm -f ".codex/prompts/$(basename "$workflow_path")"
    done
    rmdir .codex/prompts 2>/dev/null || true
    rmdir .codex 2>/dev/null || true
  fi

  echo "    .agents/skills/          ← $(ls templates/workflows | wc -l | tr -d ' ') workflow skills"
  echo "    .agents/skills/query-wiki/SKILL.md  (Codex auto-discovers)"
}
```

- [ ] **Step 4: Update setup comments to match generated outputs**

Change the opening comments from “commands / skills / prompts” to “commands / skills” and remove `.codex/` from the list of generated shim directories. Keep `.codex` ignored elsewhere for Codex local state.

- [ ] **Step 5: Run the setup and inspect one generated Skill**

Run:

```bash
bash -n setup.sh
./setup.sh codex
sed -n '1,12p' .agents/skills/linting-wiki/SKILL.md
```

Expected: Bash syntax passes, setup reports six workflow skills, and the generated file begins with valid `name` and `description` frontmatter followed by the original linting workflow.

- [ ] **Step 6: Commit the generator change**

```bash
git add setup.sh
git commit -m "feat: generate repo-local Codex workflow skills"
```

### Task 2: Document Codex Skill invocation and locations

**Files:**
- Modify: `README.md:10-114`
- Modify: `AGENTS.md:9-100`
- Modify: `.gitignore:15-31`

**Interfaces:**
- Consumes: the generated layout from Task 1.
- Produces: agent-agnostic documentation that distinguishes Claude/Copilot slash commands from Codex `$skill-name` invocation.

- [ ] **Step 1: Verify obsolete Codex prompt documentation exists**

Run:

```bash
rg -n '\.codex/prompts|Codex CLI.*\/linting-wiki|all workflows are exposed as slash commands' README.md AGENTS.md .gitignore
```

Expected: matches identify the old `.codex/prompts/` location and slash-command claims.

- [ ] **Step 2: Update README workflow guidance**

Make these exact semantic changes in `README.md`:

```markdown
- Remove `.codex/` from generated agent shim directories.
- State that Claude Code and Copilot use slash commands, while Codex uses repo-local Skills.
- Show Codex examples such as `$linting-wiki page-index` and `$fetch-raw page-index`.
- Change the Codex supported-agent location to `.agents/skills/`.
```

Keep the existing workflow table, but use neutral workflow names in its first column instead of implying one command syntax applies to every agent.

- [ ] **Step 3: Update AGENTS.md surface mappings**

Apply these mappings in the workflow table:

```markdown
| Workflow       | Claude Code                 | Codex CLI                    | GitHub Copilot              |
| `fetch-raw`    | `/fetch-raw [topic]`        | `$fetch-raw [topic]`         | `/fetch-raw [topic]`        |
| `init-wiki`    | `/init-wiki [topic]`        | `$init-wiki [topic]`         | `/init-wiki [topic]`        |
| `new-wiki`     | `/new-wiki`                 | `$new-wiki`                  | `/new-wiki`                 |
| `linting-wiki` | `/linting-wiki [topic]`     | `$linting-wiki [topic]`      | `/linting-wiki [topic]`     |
| `drop-wiki`    | `/drop-wiki <topic>`        | `$drop-wiki <topic>`         | `/drop-wiki <topic>`        |
| `export-topic` | `/export-topic ...`         | `$export-topic ...`          | `/export-topic ...`         |
```

Also describe `.agents/skills/` as containing the generated Codex workflow skills and `query-wiki`; remove `.codex/` from the generated-layout and bootstrap text.

- [ ] **Step 4: Keep `.codex/` ignored as local state, not as a generated shim**

Change `.gitignore` so `.codex/` appears under `# Agent local state`, while `.claude/`, `.agents/`, and `.github/` generated paths remain under `# Agent shims`.

- [ ] **Step 5: Verify obsolete documentation is gone**

Run:

```bash
rg -n '\.codex/prompts|Codex CLI.*\/linting-wiki|all workflows are exposed as slash commands' README.md AGENTS.md .gitignore
```

Expected: no matches.

- [ ] **Step 6: Commit documentation changes**

```bash
git add README.md AGENTS.md .gitignore
git commit -m "docs: describe repo-local Codex workflow skills"
```

### Task 3: Validate migration, preservation, and idempotency

**Files:**
- Verify: `setup.sh`
- Verify: `.agents/skills/*/SKILL.md` (gitignored)
- Verify: `.codex/` migration behavior (gitignored)

**Interfaces:**
- Consumes: Tasks 1 and 2.
- Produces: evidence that repeated setup is safe, generated skills are valid, known legacy prompts are removed, and unknown local files survive.

- [ ] **Step 1: Seed a uniquely named unknown Codex file**

Run:

```bash
mkdir -p .codex/prompts
cp templates/workflows/fetch-raw.md .codex/prompts/__setup-preserve-test__.md
cp templates/workflows/fetch-raw.md .codex/prompts/fetch-raw.md
```

Expected: one unknown test file and one known legacy prompt exist.

- [ ] **Step 2: Run Codex setup twice**

Run:

```bash
./setup.sh codex
./setup.sh codex
```

Expected: both runs succeed and report six workflow skills.

- [ ] **Step 3: Verify cleanup and preservation**

Run:

```bash
test ! -f .codex/prompts/fetch-raw.md
test -f .codex/prompts/__setup-preserve-test__.md
test "$(find .agents/skills -mindepth 2 -maxdepth 2 -name SKILL.md | wc -l | tr -d ' ')" = "7"
```

Expected: the known prompt is removed, the unknown file remains, and seven Skills exist.

- [ ] **Step 4: Validate every generated Skill**

Run:

```bash
for skill in .agents/skills/*; do
  python3 /Users/ming8525/.codex/skills/.system/skill-creator/scripts/quick_validate.py "$skill"
done
```

Expected: seven `Skill is valid!` results.

- [ ] **Step 5: Remove the temporary preservation fixture**

Run:

```bash
rm .codex/prompts/__setup-preserve-test__.md
rmdir .codex/prompts 2>/dev/null || true
rmdir .codex 2>/dev/null || true
```

Expected: only the test fixture is removed; `.codex/` disappears if it has no other user files.

- [ ] **Step 6: Run final repository checks**

Run:

```bash
bash -n setup.sh
git diff --check
rg -n '\.codex/prompts|Codex CLI.*\/linting-wiki|all workflows are exposed as slash commands' README.md AGENTS.md .gitignore setup.sh
```

Expected: syntax and whitespace checks pass; the final search returns no obsolete references.
