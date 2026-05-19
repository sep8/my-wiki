# llm-wiki

A personal, LLM-maintained knowledge wiki. Sources go into `raw/`; an LLM
agent reads them and writes interconnected concept pages into `wiki/`. The
wiki is the durable, compounding artifact — not the chat history.

Inspired by Karpathy's
[LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f).

## Layout

```
AGENTS.md           agent-agnostic schema and workflow contracts (read first)
CLAUDE.md           stub pointing at AGENTS.md
README.md           this file
setup.sh            generates agent shims from templates/
templates/          source of truth for shims (tracked)
  workflows/          5 workflow prompts (fetch / init / new / lint / drop)
  skill/              query-wiki skill
  copilot/            Copilot-specific instructions + prompts
_raw/               public source manifests (per topic) + fetch.sh
  <topic>.md          - [label](url) → filename per line
  fetch.sh            downloads manifests into raw/<topic>/ (idempotent)
raw/                fetched sources, gitignored — regenerate with fetch.sh
wiki/               LLM-generated pages
  log.md              append-only chronological record
  <topic>/            entity pages, index.md, contradictions.md
  shared/             (optional) concepts referenced by ≥2 topics
```

Agent shim directories (`.claude/`, `.codex/`, `.agents/`, `.github/prompts/`,
`.github/copilot-instructions.md`) are **gitignored** — regenerate per machine
with `./setup.sh`.

## Bootstrap on a new machine

```bash
git clone <repo>
cd <repo>

./setup.sh              # default: claude
./setup.sh codex        # codex only
./setup.sh claude codex # multiple
./setup.sh all          # claude + codex + copilot

./_raw/fetch.sh         # download all public sources listed in _raw/
```

Re-run `./setup.sh` after editing `templates/`.

## Workflows

All five workflows are exposed as slash commands in every supported agent
(Claude Code, Codex CLI, GitHub Copilot). See [AGENTS.md](./AGENTS.md) for
detailed contracts.

| Workflow       | What it does                                                              |
| -------------- | ------------------------------------------------------------------------- |
| `/fetch-raw`   | Download public sources listed in `_raw/<topic>.md` into `raw/<topic>/`   |
| `/init-wiki`   | Bootstrap a topic from its `raw/` sources — create entity pages + index   |
| `/new-wiki`    | Ingest a newly-added source under an existing topic                       |
| `/linting-wiki`| Audit for orphans, broken links, drift, contradictions, stale claims      |
| `/drop-wiki`   | Delete a topic entirely (with confirmation + cross-topic link sweep)      |
| `/query-wiki`  | Answer a knowledge question from the wiki with citations (auto-engaged)   |

`query-wiki` is the consumption-side workflow: Claude Code and Codex
auto-trigger it when you ask a question in a covered domain; Copilot engages
it via inline instructions.

## Adding a new topic

```bash
# 1. Create a manifest of public sources
cat > _raw/my-topic.md <<'EOF'
# my-topic

- [Paper A](https://arxiv.org/pdf/xxxx.pdf) → paper-a.pdf
- [Paper B](https://example.com/paper-b.pdf) → paper-b.pdf
EOF

# 2. Download sources
./_raw/fetch.sh my-topic

# 3. In your agent (Claude / Codex / Copilot Chat):
/init-wiki my-topic
```

For non-public sources (private docs, internal PDFs), skip the manifest and
drop files directly into `raw/<topic>/` — they stay local since `raw/` is
gitignored.

## Supported agents

| Agent          | Auto-trigger query? | Shim location                                          |
| -------------- | ------------------- | ------------------------------------------------------ |
| Claude Code    | yes (skill)         | `.claude/commands/`, `.claude/skills/query-wiki/`      |
| Codex CLI      | yes (skill)         | `.codex/prompts/`, `.agents/skills/query-wiki/`        |
| GitHub Copilot | inline instructions | `.github/copilot-instructions.md`, `.github/prompts/`  |

Adding a new agent: drop a new section into `templates/` and a case into
`setup.sh`.
