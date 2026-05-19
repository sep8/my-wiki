---
mode: agent
description: Delete a topic entirely — manifest, raw sources, and wiki pages.
---

Run the `drop-wiki` workflow as specified in [AGENTS.md](../../AGENTS.md).

Usage: `/drop-wiki <topic>`

Procedure:

1. **Confirm scope.** List exactly what will be deleted:
   - `_raw/<topic>.md` (manifest)
   - `raw/<topic>/` (local sources, if present)
   - `wiki/<topic>/` (all pages and indexes)
   Show file counts.

2. **Check cross-topic references.** Grep `wiki/` for `[[brackets]]` whose
   targets live in the doomed topic. Surface orphan links the deletion
   would create.

3. **Ask the user to confirm.** Do NOT proceed without explicit confirmation.

4. **Delete:**
   ```
   rm -f _raw/<topic>.md
   rm -rf raw/<topic>
   rm -rf wiki/<topic>
   ```

5. **Sweep dangling links** in remaining topics — delete, replace with plain
   text, or flag on the page.

6. **Append to `wiki/log.md`:**

       - YYYY-MM-DD  drop-wiki  <topic>  — removed <N> pages, <M> sources; <K> cross-topic links swept

Irreversible (outside git history).
