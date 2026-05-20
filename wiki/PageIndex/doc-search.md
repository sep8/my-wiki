# Document Search

## Summary
PageIndex's per-query retrieval works inside a single document by default. To scope across many documents, PageIndex recommends one of three workflows: by [[doc-search-by-metadata]], by [[doc-search-by-semantics]], or by [[doc-search-by-description]]. For massive-scale (millions of docs), the "PageIndex File System" blog post is the reference.

## Explanation
All three workflows share the same shape: filter/rank documents → get their `doc_id`s → hand them to the standard PageIndex retrieval for in-document reasoning.

| Workflow | When to use |
|---|---|
| [[doc-search-by-metadata]] | Docs cleanly distinguished by structured attributes (company, date, case type, patient). Query → SQL. |
| [[doc-search-by-semantics]] | Docs cover diverse topics; vector search at the document level. |
| [[doc-search-by-description]] | Small corpus, no metadata; LLM-generated one-sentence descriptions. |

The "PageIndex File System" extends the tree idea to massive corpora — referenced but not detailed in the local sources.

## Related
[[doc-search-by-metadata]] · [[doc-search-by-semantics]] · [[doc-search-by-description]] · [[pageindex]] · [[tree-search]]
