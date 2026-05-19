---
mode: agent
description: Audit wiki/ for orphans, broken links, contradictions, stale claims, and index drift.
---

Run the `linting-wiki` workflow as specified in [AGENTS.md](../../AGENTS.md).

Audit the `wiki/` folder. By default, audit every topic subfolder
(`wiki/<topic>/`); if a topic is given, audit only that one.

Identify:
  1. Orphan pages — pages no other page in the same topic links to (excluding
     `index.md` and `contradictions.md`).
  2. Missing pages — concepts referenced with `[[brackets]]` that lack a file
     in the same topic folder.
  3. Broken links — `[[brackets]]` whose target exists in a different topic;
     note for promotion to `wiki/shared/` or relinking.
  4. Promotion candidates — concepts referenced by ≥2 topics.
  5. Contradictions — claims that conflict across pages.
  6. Stale claims — superseded by a newer source in `raw/<topic>/`.
  7. Index drift — `index.md` entries that don't match files on disk.

Suggest fixes and, where confident, apply them directly.

When done, append one line to `wiki/log.md`:

    - YYYY-MM-DD  linting-wiki  <topic|all>  — <N> issues found, <M> auto-fixed
