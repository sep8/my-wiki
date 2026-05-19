---
mode: ask
description: Answer a knowledge question using wiki/<topic>/ pages with citations.
---

Run the `query-wiki` workflow as specified in [AGENTS.md](../../AGENTS.md).

Copilot doesn't auto-trigger skills, so this prompt is the explicit entry
point. (The same rule is also embedded in `.github/copilot-instructions.md`
so Copilot can engage it implicitly when the user asks a wiki-domain question
without a slash command.)

Procedure:

1. Map the question to topics. List `wiki/` subdirectories. For each candidate
   topic, read `wiki/<topic>/index.md` to see what's covered.
2. Pull the relevant pages whose `[[name]]` matches concepts in the question.
   Follow `[[brackets]]` one hop when load-bearing. Don't read the whole
   topic — be surgical.
3. Check `contradictions.md` for the topic(s). Surface known tensions
   explicitly rather than picking a side silently.
4. Answer with citations using `wiki/<topic>/<page>.md` paths (with line
   numbers when pointing at a specific claim).
5. Note gaps. If the wiki doesn't cover something the question needs, say so
   plainly — don't paper over with training knowledge without flagging.
6. Offer to write back when valuable (comparison, worked example,
   clarification of a known contradiction).
7. Log non-trivial queries to `wiki/log.md`:

       - YYYY-MM-DD  query-wiki  <topic>  — <question summary> → <what changed>
