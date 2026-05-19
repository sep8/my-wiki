---
mode: agent
description: Ingest a newly added source under raw/<topic>/ and update affected wiki pages.
---

Run the `new-wiki` workflow as specified in [AGENTS.md](../../AGENTS.md).

A new source has been added under `raw/<topic>/`. Read it alongside the
existing pages in `wiki/<topic>/`.

  - Update any existing entity pages affected by this new source.
  - Create new entity pages for any new concepts it introduces.
  - Add the source to `wiki/<topic>/index.md` if a paper list is maintained there.
  - Flag any contradictions with previously compiled knowledge, either inline
    on the affected pages or in `wiki/<topic>/contradictions.md`.

If the new source doesn't fit any existing topic, propose a new topic folder
(`raw/<new-topic>/` and `wiki/<new-topic>/`) before writing anything.

When done, append one line to `wiki/log.md`:

    - YYYY-MM-DD  new-wiki  <topic>  — ingested <source>; touched <N> pages, created <M>
