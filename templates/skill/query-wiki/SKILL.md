---
name: query-wiki
description: Answer the user's question using topic folders under wiki/. Engage when the user asks a substantive question whose subject matter overlaps a topic already ingested in wiki/ (e.g., transformers, attention, BERT, GPT-3, RLHF, alignment, foundation models). Do NOT engage for meta-questions about the wiki tooling itself, for trivial chit-chat, or for coding tasks unrelated to the wiki's subject domain.
---

# query-wiki

Answer the user's question from the local wiki. The wiki is a compounding artifact —
prefer it over re-deriving knowledge from training data, and write valuable
explorations back into it.

## Procedure

1. **Map the question to topics.** List `wiki/` subdirectories. For each candidate
   topic, read `wiki/<topic>/index.md` to see what's covered.

2. **Pull the relevant pages.** Read the pages whose `[[name]]` matches concepts
   in the question. Follow `[[brackets]]` one hop when a referenced concept is
   load-bearing for the answer. Don't read the whole topic — be surgical.

3. **Check `contradictions.md`** for the topic(s) involved. If the question
   touches a known tension, surface it explicitly rather than picking a side
   silently.

4. **Answer with citations.** Cite using `wiki/<topic>/<page>.md` paths (and
   line numbers when pointing at a specific claim). The user should be able to
   click through to verify.

5. **Note gaps.** If the wiki doesn't cover something the question needs, say so
   plainly — don't paper over with general training knowledge without flagging it.

6. **Write back when valuable.** If the answer synthesizes something not already
   on a page — a comparison, a worked example, a clarification of a known
   contradiction — offer to file it as a new page or append to an existing one.
   Don't write back trivial answers.

7. **Log non-trivial queries.** If a query led to a write-back or surfaced a new
   contradiction, append a line to `wiki/log.md`:

       - YYYY-MM-DD  query-wiki  <topic>  — <question summary> → <what changed>

   Skip the log for casual lookups that didn't change anything.

## What this skill does NOT do

- It doesn't ingest new sources — that's `/new-wiki`.
- It doesn't audit the wiki — that's `/linting-wiki`.
- It doesn't answer from training data alone when the topic is covered locally;
  the wiki is the source of truth for ingested material.
