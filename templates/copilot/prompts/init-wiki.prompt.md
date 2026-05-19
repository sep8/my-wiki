---
mode: agent
description: Bootstrap a topic — read raw/<topic>/ sources and create entity pages in wiki/<topic>/.
---

Run the `init-wiki` workflow as specified in [AGENTS.md](../../AGENTS.md).

Read the papers in `raw/<topic>/` (use the argument if given, otherwise infer
the topic from the papers and create both folders). For each key concept,
create a markdown file in `wiki/<topic>/` with:

  - a short summary
  - an explanation
  - related links using `[[brackets]]` (filename without path or extension)
  - any contradictions between papers

Also produce `wiki/<topic>/index.md` grouping the pages, and
`wiki/<topic>/contradictions.md` collecting cross-paper tensions.

When done, append one line to `wiki/log.md`:

    - YYYY-MM-DD  init-wiki  <topic>  — <N> pages from <source list>
