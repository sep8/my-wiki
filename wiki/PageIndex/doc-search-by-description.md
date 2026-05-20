# Document Search by Description

## Summary
Lightweight approach for small corpora without metadata. Generate an LLM-written one-sentence description per document (from its [[tree-index]]), then let another LLM call pick relevant `doc_id`s by comparing the query against descriptions.

## Explanation

### Pipeline
1. **Tree generation** — process all docs through PageIndex.
2. **Description generation** — for each doc, prompt an LLM with the tree structure and ask for a one-sentence distinguishing description.
3. **Selection** — prompt an LLM with `(query, [{doc_id, doc_name, doc_description}])` and have it return the relevant `doc_id` list as JSON (`thinking` + `answer`).
4. **Retrieve with PageIndex** — per-doc retrieval using selected `doc_id`s.

### When to prefer
- No structured metadata exists → can't use [[doc-search-by-metadata]].
- Corpus is small enough that listing all descriptions in one prompt is feasible (otherwise prefer [[doc-search-by-semantics]]).

## Related
[[doc-search]] · [[doc-search-by-metadata]] · [[doc-search-by-semantics]] · [[tree-index]]
