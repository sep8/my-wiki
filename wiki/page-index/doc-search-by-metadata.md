# Document Search by Metadata

## Summary
For corpora cleanly distinguished by structured attributes (financial reports by company+period, legal docs by case type, medical records by patient). Approach: store doc metadata + PageIndex `doc_id` in SQL, use an LLM "query → SQL" step to pick docs, then retrieve in-document with PageIndex.

## Explanation

### Pipeline
1. **Tree generation** — upload all docs to get `doc_id`s.
2. **SQL table** — store `(doc_id, metadata fields)`.
3. **Query → SQL** — LLM transforms a user request into a SQL query that fetches relevant docs.
4. **Retrieve with PageIndex** — per-doc retrieval using returned `doc_id`s.

### Status
Per PageIndex docs, metadata support is in **closed beta** — early access requires filling out their form.

## Related
[[doc-search]] · [[doc-search-by-semantics]] · [[doc-search-by-description]] · [[tree-index]]
