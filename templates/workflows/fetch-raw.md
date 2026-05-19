Download source files for a topic into raw/<topic>/ from the manifest at
_raw/<topic>.md.

Usage:
  /fetch-raw                 — fetch all topics with manifests
  /fetch-raw <topic>         — fetch one topic

Run the bash script directly:

    ./_raw/fetch.sh [<topic> ...]

The script is idempotent — files already present in raw/<topic>/ are skipped.

Manifest format (one entry per line in _raw/<topic>.md):

    - [label](url) → filename.pdf

If the user is adding a new topic, create _raw/<topic>.md first with the
source URLs, then run the script. See AGENTS.md for the wiki schema.
