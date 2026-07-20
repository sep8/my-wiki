# Vector-based RAG

## Summary
The dominant RAG approach: split documents into fixed-size chunks, embed each chunk into a vector, store in a vector DB (Chroma, Pinecone, etc.), then at query time embed the query and retrieve top-k semantically similar chunks. PageIndex positions itself as an alternative.

## Explanation
**Preprocessing:** chunk → embed → store.
**Query:** embed query → vector DB similarity search → top-k chunks → feed as context.

Simple and effective for short texts, but the PageIndex paper identifies five recurring failure modes — see [[limitations-of-vector-rag]]. In short: semantic similarity is a proxy for relevance, not relevance itself, and hard chunking destroys structural context.

PageIndex still uses vector search in some hybrid configurations: see [[hybrid-tree-search]] (vector embeddings as a value function over tree nodes) and [[doc-search-by-semantics]] (vector search to rank documents, not chunks).

## Related
[[reasoning-based-rag]] · [[limitations-of-vector-rag]] · [[hybrid-tree-search]] · [[doc-search-by-semantics]] · [[context-rot]]
