Audit the wiki/ folder. By default, audit every topic subfolder
(wiki/<topic>/); if a topic is given, audit only that one.

Identify:
  1. Orphan pages — pages that no other page in the same topic links to
     (excluding index.md and contradictions.md).
  2. Missing pages — concepts referenced with [[brackets]] that don't have
     a corresponding file in the same topic folder.
  3. Broken links — [[brackets]] whose target filename exists in a different
     topic; note the cross-topic reference so it can be promoted to
     wiki/shared/ (see CLAUDE.md) or relinked.
  4. Promotion candidates — concepts referenced by ≥2 topics that should
     move to wiki/shared/.
  5. Contradictions — claims that conflict across pages, within or across topics.
  6. Stale claims — things that may have been superseded by a more recent
     source in raw/<topic>/.
  7. Index drift — entries in wiki/<topic>/index.md that don't match the
     files on disk (missing entries, dead entries, wrong section).

Suggest fixes and, where confident, apply them directly.

When done, append one line to wiki/log.md:

    - YYYY-MM-DD  linting-wiki  <topic|all>  — <N> issues found, <M> auto-fixed

See CLAUDE.md for the wiki schema.
