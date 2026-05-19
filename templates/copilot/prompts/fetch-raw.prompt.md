---
mode: agent
description: Download public sources listed in _raw/<topic>.md into raw/<topic>/.
---

Run the `fetch-raw` workflow as specified in [AGENTS.md](../../AGENTS.md).

Execute the bash script directly:

    ./_raw/fetch.sh [<topic> ...]

  - No args → fetch all topics with manifests under `_raw/`.
  - With topic args → fetch only those.

The script is idempotent — files already present in `raw/<topic>/` are skipped.

Manifest format (one entry per line in `_raw/<topic>.md`):

    - [label](url) → filename.pdf

If a new topic is being added, create `_raw/<topic>.md` first with the source
URLs, then run the script.
