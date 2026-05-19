Read the papers in raw/<topic>/ and create entity pages under wiki/<topic>/.
If no topic is given, infer one from the papers and create the folders
raw/<topic>/ and wiki/<topic>/ (move PDFs into the raw subfolder as needed).

For each key concept, create a markdown file with:
  - a short summary
  - an explanation
  - related links using [[brackets]] (filename without path or extension)
  - any contradictions between papers

Also produce wiki/<topic>/index.md grouping the pages, and
wiki/<topic>/contradictions.md collecting cross-paper tensions.

When done, append one line to wiki/log.md:

    - YYYY-MM-DD  init-wiki  <topic>  — <N> pages from <source list>

See CLAUDE.md for the wiki schema (naming, linking, topic rules).
