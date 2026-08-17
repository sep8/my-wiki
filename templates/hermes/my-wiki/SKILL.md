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
