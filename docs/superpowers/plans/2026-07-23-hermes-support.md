# Hermes Support Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make Hermes a formally supported my-wiki agent through an installable, profile-scoped bridge skill that reuses the existing canonical workflow templates without duplicating them.

**Architecture:** Keep `AGENTS.md`, `templates/workflows/*.md`, and `templates/skill/query-wiki/SKILL.md` as the sole workflow authorities. Add one small Hermes bridge skill whose only job is to map user intent to those canonical files. Extend `setup.sh` to copy that bridge into `${HERMES_HOME:-$HOME/.hermes}/skills/my-wiki/`, where Hermes can explicitly preload it with `--skills my-wiki`.

**Tech Stack:** Bash (`setup.sh`, shell test), Markdown, existing Hermes CLI conventions.

## Global Constraints

- Do not add dependencies, network calls, plugins, MCP servers, or custom Hermes slash commands.
- Do not copy the six workflow bodies or the query-wiki procedure into the Hermes skill.
- Hermes invocation must be documented as `hermes --skills my-wiki`; automatic skill selection is not required for correctness.
- Use `${HERMES_HOME:-$HOME/.hermes}` so callers can install to a named Hermes profile by setting `HERMES_HOME`.
- Do not generate repository-local `.hermes/` state; no `.gitignore` change is required.
- `drop-wiki` retains the explicit in-conversation confirmation requirement from `AGENTS.md` and its canonical workflow.
- Preserve `./setup.sh` default behavior: no arguments still installs only Claude shims.

---

### Task 1: Add the canonical Hermes bridge-skill template

**Files:**
- Create: `templates/hermes/my-wiki/SKILL.md`
- Test: `tests/test-setup.sh`

**Interfaces:**
- Consumes: the project root as Hermes's current working directory, root `AGENTS.md`, `templates/workflows/*.md`, and `templates/skill/query-wiki/SKILL.md`.
- Produces: an installed Hermes skill named `my-wiki`, loadable with `hermes --skills my-wiki`.

- [ ] **Step 1: Write a failing static-template assertion in `tests/test-setup.sh`**

Create the test file with this initial executable test. It intentionally fails until the bridge exists:

```bash
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
```

- [ ] **Step 2: Run the test to verify it fails**

Run:

```bash
bash tests/test-setup.sh
```

Expected: failure because `templates/hermes/my-wiki/SKILL.md` does not yet exist.

- [ ] **Step 3: Create `templates/hermes/my-wiki/SKILL.md` with this exact bridge content**

```markdown
---
name: my-wiki
description: Operate this llm-wiki repository: fetch raw sources, initialize or update topics, lint, drop, export, or answer questions from the local wiki.
---

# my-wiki

Use this skill only from the root of this repository. First verify that
`AGENTS.md`, `templates/workflows/`, and `wiki/` exist in the current working
directory. `AGENTS.md` is the repository-wide schema and safety contract.

## Workflow routing

When the user explicitly names a workflow or clearly asks for its operation,
read the corresponding canonical source before acting:

| Workflow / intent | Canonical instructions |
| --- | --- |
| `fetch-raw` — download or refresh public source manifests | `templates/workflows/fetch-raw.md` |
| `init-wiki` — bootstrap a topic from `raw/<topic>/` | `templates/workflows/init-wiki.md` |
| `new-wiki` — ingest a newly added raw source | `templates/workflows/new-wiki.md` |
| `linting-wiki` — audit a topic or all topics | `templates/workflows/linting-wiki.md` |
| `drop-wiki` — remove a topic | `templates/workflows/drop-wiki.md` |
| `export-topic` — vendor a curated topic into another repository | `templates/workflows/export-topic.md` |
| Knowledge question about an ingested topic | `templates/skill/query-wiki/SKILL.md` |

Do not restate or maintain a second copy of those workflow procedures here.
Follow the canonical file and `AGENTS.md` exactly. In particular, require
explicit in-conversation confirmation before any `drop-wiki` deletion.

## Explicit Hermes use

Start Hermes from this repository root with:

```bash
hermes --skills my-wiki
```

Then ask for the desired workflow in natural language or by its canonical name,
for example: `Run linting-wiki page-index.`
```

- [ ] **Step 4: Run the static-template assertions again**

Run:

```bash
bash tests/test-setup.sh
```

Expected: this initial set of bridge assertions passes. The overall script may still be expanded and fail in later tasks.

- [ ] **Step 5: Commit the bridge template and its initial test**

```bash
git add templates/hermes/my-wiki/SKILL.md tests/test-setup.sh
git commit -m "feat: add Hermes my-wiki bridge skill template"
```

---

### Task 2: Teach `setup.sh` to install the Hermes bridge skill

**Files:**
- Modify: `setup.sh:4-13,109-132`
- Test: `tests/test-setup.sh`

**Interfaces:**
- Consumes: optional shell variable `HERMES_HOME`; canonical template `templates/hermes/my-wiki/SKILL.md`.
- Produces: `${HERMES_HOME:-$HOME/.hermes}/skills/my-wiki/SKILL.md` and an installation message that names `hermes --skills my-wiki`.

- [ ] **Step 1: Expand `tests/test-setup.sh` with failing isolated-install tests**

Append these functions and invocations after the static assertions from Task 1. They use only temporary directories and never touch a real Hermes home directory:

```bash
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
```

- [ ] **Step 2: Run the tests to verify the Hermes install checks fail**

Run:

```bash
bash tests/test-setup.sh
```

Expected: failure at `./setup.sh hermes`, which currently reports `unknown agent`.

- [ ] **Step 3: Update the `setup.sh` usage comments and generated-shim comment**

At the top of `setup.sh`, make the usage block include Hermes and make the generated-directory wording distinguish the externally installed Hermes skill:

```bash
#   ./setup.sh hermes
#   ./setup.sh claude hermes # multiple
#   ./setup.sh all
#
# Source of truth lives in templates/. Generated repository directories
# (.claude/, .agents/, .github/copilot-instructions.md, .github/prompts/) are
# gitignored. The Hermes bridge is generated under $HERMES_HOME/skills/.
```

- [ ] **Step 4: Add `install_hermes()` immediately after `install_copilot()`**

Add this exact function:

```bash
install_hermes() {
  local hermes_home hermes_skill_dir
  hermes_home="${HERMES_HOME:-$HOME/.hermes}"
  hermes_skill_dir="$hermes_home/skills/my-wiki"

  echo "==> hermes"
  mkdir -p "$hermes_skill_dir"
  cp templates/hermes/my-wiki/SKILL.md "$hermes_skill_dir/SKILL.md"
  echo "    $hermes_skill_dir/SKILL.md"
  echo "    start in this repo with: hermes --skills my-wiki"
}
```

- [ ] **Step 5: Extend the `all` expansion and `case` dispatch**

Replace these existing statements:

```bash
[[ "${agents[*]}" == "all" ]] && agents=(claude codex copilot)
```

```bash
    copilot) install_copilot ;;
    *) echo "unknown agent: $a (expected: claude | codex | copilot | all)" >&2; exit 2 ;;
```

with:

```bash
[[ "${agents[*]}" == "all" ]] && agents=(claude codex copilot hermes)
```

```bash
    copilot) install_copilot ;;
    hermes)  install_hermes ;;
    *) echo "unknown agent: $a (expected: claude | codex | copilot | hermes | all)" >&2; exit 2 ;;
```

- [ ] **Step 6: Run setup regression tests and shell syntax validation**

Run:

```bash
bash -n setup.sh
bash tests/test-setup.sh
```

Expected: both commands exit 0.

- [ ] **Step 7: Verify idempotence with an isolated Hermes home**

Run:

```bash
home="$(mktemp -d)"
HERMES_HOME="$home" ./setup.sh hermes
HERMES_HOME="$home" ./setup.sh hermes
cmp -s templates/hermes/my-wiki/SKILL.md "$home/skills/my-wiki/SKILL.md"
rm -rf "$home"
```

Expected: both setup runs succeed and `cmp` exits 0.

- [ ] **Step 8: Commit setup support and its regression test**

```bash
git add setup.sh tests/test-setup.sh
git commit -m "feat: install Hermes wiki bridge skill"
```

---

### Task 3: Document Hermes as a supported agent

**Files:**
- Modify: `README.md:16-20,41-45,53-56,98-102,109-118`
- Modify: `AGENTS.md:11-21,35-41,91-99,152-157`
- Test: `tests/test-setup.sh`

**Interfaces:**
- Consumes: the setup interface from Task 2 and the canonical workflow names.
- Produces: user-facing bootstrap and invocation documentation that describes Hermes without inventing slash-command support.

- [ ] **Step 1: Add failing documentation assertions to `tests/test-setup.sh`**

Append:

```bash
grep -F './setup.sh hermes' "$repo_root/README.md"
grep -F 'hermes --skills my-wiki' "$repo_root/README.md"
grep -F './setup.sh hermes' "$repo_root/AGENTS.md"
grep -F 'hermes --skills my-wiki' "$repo_root/AGENTS.md"
```

- [ ] **Step 2: Run the test to verify the documentation assertions fail**

Run:

```bash
bash tests/test-setup.sh
```

Expected: failure because the current README and AGENTS bootstrap examples do not mention Hermes.

- [ ] **Step 3: Update README bootstrap examples and layout**

In the bootstrap command block after the existing Codex example, add:

```bash
./setup.sh hermes          # install the Hermes bridge skill
```

Update the `all` comment to:

```bash
./setup.sh all             # claude + codex + copilot + hermes
```

In the layout section, add this line after the generated agent shim explanation:

```text
$HERMES_HOME/skills/my-wiki/  Hermes bridge skill (generated locally; default HERMES_HOME is ~/.hermes)
```

- [ ] **Step 4: Add a concise README Hermes usage subsection**

Insert after the workflow introduction:

```markdown
### Hermes

`AGENTS.md` is loaded automatically when Hermes starts in this repository.
Install the bridge skill once per Hermes home/profile, then preload it explicitly:

```bash
./setup.sh hermes
hermes --skills my-wiki
```

Ask for any canonical workflow by name, for example `Run linting-wiki page-index.`
The bridge reads the existing templates under `templates/workflows/` and
`templates/skill/query-wiki/`; it does not provide custom Hermes slash commands.
To install into another profile, set `HERMES_HOME` before running setup.
```

- [ ] **Step 5: Add Hermes to README’s supported-agent table**

Add a row:

```markdown
| Hermes Agent   | Explicit preload (`--skills my-wiki`) | `$HERMES_HOME/skills/my-wiki/` |
```

Do not label automatic query triggering as supported; it has not been made a correctness requirement.

- [ ] **Step 6: Update `AGENTS.md` bootstrap, layout, and workflow table**

Make these exact documentation additions:

1. Add to the bootstrap block:
   ```bash
   ./setup.sh hermes          # install Hermes bridge skill
   ```
2. Update its `all` line to mention Hermes.
3. Add this layout entry after the generated repository-local shim entries:
   ```text
   $HERMES_HOME/skills/my-wiki/  Hermes bridge skill (generated locally; default ~/.hermes)
   ```
4. Add a Hermes column to the workflow table. For each of the six mutating/operational workflows, use:
   ```text
   Explicit request after `hermes --skills my-wiki`
   ```
   For `query-wiki`, use:
   ```text
   Explicit request after `hermes --skills my-wiki`
   ```
5. After the query-wiki platform notes, add:
   ```markdown
   Hermes automatically loads this repository's `AGENTS.md` when started from
   the repository root. Its generated `my-wiki` bridge is intentionally loaded
   with `hermes --skills my-wiki`; it routes each named workflow to the canonical
   templates rather than defining custom slash commands or duplicating workflow text.
   ```

- [ ] **Step 7: Run documentation and regression checks**

Run:

```bash
bash tests/test-setup.sh
bash -n setup.sh
git diff --check
```

Expected: all commands exit 0.

- [ ] **Step 8: Commit user-facing documentation**

```bash
git add README.md AGENTS.md tests/test-setup.sh
git commit -m "docs: document Hermes wiki support"
```

---

### Task 4: Perform an end-to-end local smoke check and review generated output

**Files:**
- Modify: none
- Test: `tests/test-setup.sh`

**Interfaces:**
- Consumes: Tasks 1–3.
- Produces: evidence that setup writes only the intended isolated Hermes artifact and that the bridge points to canonical templates.

- [ ] **Step 1: Run the complete local test suite**

Run:

```bash
bash tests/test-setup.sh
bash -n setup.sh
git diff --check
```

Expected: all commands exit 0.

- [ ] **Step 2: Inspect a generated isolated Hermes skill**

Run:

```bash
home="$(mktemp -d)"
HERMES_HOME="$home" ./setup.sh hermes
cat "$home/skills/my-wiki/SKILL.md"
rm -rf "$home"
```

Expected: exactly one generated file is printed; it contains workflow-template paths and no copied workflow body.

- [ ] **Step 3: Verify the default Claude behavior was preserved in a disposable clone/worktree**

Run from a clean temporary checkout or worktree so the repository’s current generated shims are not overwritten:

```bash
tmp_repo="$(mktemp -d)"
git clone --no-local . "$tmp_repo"
(
  cd "$tmp_repo"
  ./setup.sh
  test -f .claude/commands/fetch-raw.md
  test ! -e "$HOME/.hermes/skills/my-wiki/SKILL.md"
)
rm -rf "$tmp_repo"
```

Expected: the default invocation produces Claude files and does not install Hermes.

- [ ] **Step 4: Manually validate Hermes discovery in a fresh process**

Run:

```bash
home="$(mktemp -d)"
HERMES_HOME="$home" ./setup.sh hermes
HERMES_HOME="$home" hermes skills list
rm -rf "$home"
```

Expected: `my-wiki` appears in the skill list. If it does not appear, stop before release and investigate the current Hermes version’s skill-directory refresh/discovery requirements; do not claim the integration works until this is resolved.

- [ ] **Step 5: Commit any test-only correction found during smoke validation**

If smoke validation requires no correction, do not create an empty commit. If it reveals a deterministic test or documentation defect, commit only that correction with:

```bash
git add tests/test-setup.sh README.md AGENTS.md setup.sh templates/hermes/my-wiki/SKILL.md
git commit -m "test: verify Hermes setup smoke path"
```

## Final Acceptance Checklist

- [ ] `./setup.sh` still installs only Claude shims.
- [ ] `./setup.sh hermes` installs only `$HERMES_HOME/skills/my-wiki/SKILL.md` for Hermes.
- [ ] `./setup.sh all` includes Hermes in addition to Claude, Codex, and Copilot.
- [ ] The generated Hermes bridge lists all six workflow templates and the `query-wiki` template.
- [ ] The bridge does not duplicate workflow bodies and does not promise custom slash commands.
- [ ] README and AGENTS document `hermes --skills my-wiki` and profile targeting via `HERMES_HOME`.
- [ ] `bash tests/test-setup.sh`, `bash -n setup.sh`, and `git diff --check` pass.
- [ ] Fresh-process `hermes skills list` discovers the isolated generated bridge skill; otherwise the release is blocked pending a confirmed Hermes-compatible install path.
