# Document Search by Semantics

## Summary
For corpora covering diverse topics: chunk + embed all documents, vector-search chunks, then aggregate per-document scores via the [[node-scoring]] formula. Selects whole documents, not chunks — which are then passed to PageIndex for in-document retrieval.

## Explanation

### Pipeline
1. **Chunk & embed** — split docs into chunks, embed, store each vector with its `doc_id`.
2. **Vector search** — for each query, retrieve top-K chunks with their parent docs.
3. **Compute document score** using the [[node-scoring]] formula with N = chunks per doc:
   $$\text{DocScore} = \frac{1}{\sqrt{N+1}} \sum_{n=1}^{N} \text{ChunkScore}(n)$$
   Favors docs with few highly relevant chunks over docs with many weakly relevant ones.
4. **Retrieve with PageIndex** — take top-scoring docs, run normal in-doc retrieval against their `doc_id`s.

### Note
This is one of the places where PageIndex *uses* [[vector-based-rag]] — but only at the document-selection layer, never returning chunks to the user. The actual answer-supporting context still comes from the in-doc tree retrieval.

## Related
[[doc-search]] · [[node-scoring]] · [[vector-based-rag]] · [[hybrid-tree-search]]
