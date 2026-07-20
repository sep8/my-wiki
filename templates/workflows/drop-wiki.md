Remove a topic from the wiki entirely.

Required argument:
  <topic> — topic to remove

Procedure:

1. Confirm scope. List exactly what will be deleted:
     - `_raw/<topic>.md`        (manifest)
     - `raw/<topic>/`            (local sources, if present)
     - `wiki/<topic>/`           (all pages and indexes)
   Show file counts so the user knows what they're losing.

2. Check cross-topic references. Before deleting, grep across `wiki/` (and
   `wiki/shared/` if present) for `[[brackets]]` whose targets live in the
   doomed topic. Surface the orphan links the deletion would create.

3. Ask the user to confirm. Do NOT proceed without an explicit "yes" /
   "confirm" / "ok" in this conversation. If they decline, stop.

4. Delete:
     rm -f _raw/<topic>.md
     rm -rf raw/<topic>
     rm -rf wiki/<topic>

5. Sweep dangling links in remaining topics. For each cross-topic reference
   identified in step 2, either delete the line, replace it with a plain
   text mention, or flag it on the page for the user.

6. Append one line to `wiki/log.md`:

       - YYYY-MM-DD  drop-wiki  <topic>  — removed <N> pages, <M> sources; <K> cross-topic links swept

This workflow is irreversible. The git history still contains the deleted
pages if the repo was committed; otherwise the deletion is permanent.

See AGENTS.md for the wiki schema.
