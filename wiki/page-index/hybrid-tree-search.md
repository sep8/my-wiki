# Hybrid Tree Search

## Summary
PageIndex's default retrieval algorithm (per their docs): run [[llm-tree-search]] and a value-based vector search over [[tree-index]] nodes in parallel, dedup via a queue, let an LLM agent decide when enough context has been gathered. Inspired by AlphaGo's combination of policy and value networks.

## Explanation

### Value-based tree search (one of the two parallel paths)
A per-node value function predicts how likely a node is to contain the answer:
- **Chunk** each node into smaller pieces.
- **Vector search** the query against those chunks.
- **Score** each node by aggregating its chunks' similarity scores using the [[node-scoring]] formula.

Crucially, the system retrieves *nodes* based on chunks, but **returns the whole node**, not the chunks. This preserves semantic integrity (vs. classic vector RAG).

### The hybrid pipeline
- **Parallel retrieval** — value-based tree search and [[llm-tree-search]] run simultaneously.
- **Queue** — unique node IDs from either path are added.
- **Node consumer** — pulls nodes off the queue, extracts/summarizes their content.
- **LLM agent** — continually evaluates whether enough information has been gathered; can terminate early.

### Why hybrid
- Combines value-based speed with LLM-based depth.
- Higher recall than either alone (complementary strengths).
- Scales for long documents with many nodes.

PageIndex documents this as the default in their retrieval API. Note that the **retrieval API itself is now marked legacy** — see [[contradictions]] and [[chat-api]].

## Related
[[tree-search]] · [[llm-tree-search]] · [[node-scoring]] · [[tree-index]] · [[vector-based-rag]]
