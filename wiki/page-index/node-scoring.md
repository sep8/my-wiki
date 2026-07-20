# Node Scoring Formula

## Summary
The aggregation formula PageIndex uses to score a tree node (or whole document) from the similarity scores of its constituent chunks. Used in [[hybrid-tree-search]] (per-node) and [[doc-search-by-semantics]] (per-document).

## Explanation

Given N chunks belonging to a node (or document), each with a `ChunkScore(n)` from vector similarity:

$$
\text{NodeScore} = \frac{1}{\sqrt{N+1}} \sum_{n=1}^{N} \text{ChunkScore}(n)
$$

### Design rationale
- **Sum** aggregates relevance across all related chunks.
- **+1** under the square root keeps the formula well-defined for nodes with zero chunks.
- **Square-root denominator** (vs. dividing by N for a mean) lets the score grow with the number of relevant chunks but with *diminishing returns* — so large nodes don't dominate by sheer volume.
- Net effect: favors nodes with *fewer, highly relevant* chunks over those with *many weakly relevant* ones.

### Two applications, same formula
- In [[hybrid-tree-search]] it ranks **nodes within one document**.
- In [[doc-search-by-semantics]] it ranks **documents within a corpus** (substituting "document" for "node").

## Related
[[hybrid-tree-search]] · [[doc-search-by-semantics]] · [[tree-search]] · [[vector-based-rag]]
