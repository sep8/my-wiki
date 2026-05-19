# GitHub Copilot instructions

This repo is a persistent, LLM-maintained knowledge wiki. The full schema,
layout, page conventions, topic rules, and workflow contracts live in
[`AGENTS.md`](../AGENTS.md) at the repo root. **Read it before doing
anything in this repo.**

Copilot-specific notes (everything else: defer to AGENTS.md):

- Reusable workflows are in `.github/prompts/*.prompt.md`. Invoke via slash in
  Copilot Chat (e.g. `/fetch-raw`, `/init-wiki`, `/new-wiki`, `/linting-wiki`,
  `/query-wiki`).
- Copilot does not auto-trigger skills the way Claude Code or Codex does, so
  the `query-wiki` auto-engage rule is reproduced inline below — apply it
  whenever the user asks a knowledge question without an explicit slash command.

## query-wiki auto-engage (Copilot)

When the user asks a substantive question whose subject overlaps a topic in
`wiki/` (e.g. transformers, attention, BERT, GPT-3, RLHF, alignment,
foundation models), prefer the wiki over re-deriving from training knowledge:

1. List `wiki/` subdirectories; read `wiki/<topic>/index.md` for candidates.
2. Pull the relevant pages; follow `[[brackets]]` one hop when load-bearing.
3. Check `wiki/<topic>/contradictions.md` — surface known tensions explicitly.
4. Answer with citations (`wiki/<topic>/<page>.md`, line numbers when pointing
   at a specific claim).
5. Note gaps where the wiki is silent — don't paper over with training data
   without flagging.
6. If the answer synthesizes something new, offer to file it back as a page.
7. Log non-trivial queries (write-back or new contradiction surfaced) in
   `wiki/log.md`.

Do NOT auto-engage for meta-questions about the tooling, casual chit-chat, or
coding tasks unrelated to the wiki's subject domain.
