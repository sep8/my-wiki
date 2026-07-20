# In-context Index

## Summary
PageIndex's term for an index that lives *inside* the LLM's active context window (the JSON [[tree-index]]) — as opposed to an external store like a vector database. The model can directly reference, navigate, and reason over it during inference.

## Explanation
A vector database is an *external, static* embeddings index — retrieval queries hit the store, return chunks, and the model never "sees" the index itself. An **in-context index** is the inverse: the structural index (here, the document's ToC tree) is small enough to sit in context, so the model can:

- traverse it recursively,
- retrieve targeted raw content by `node_id`,
- decide *where to look next* via reasoning rather than via precomputed similarity scores.

This is the architectural shift that enables [[reasoning-based-rag]]: the index becomes a first-class object of model reasoning, not a black-box retrieval substrate.

## Related
[[tree-index]] · [[reasoning-based-rag]] · [[agentic-retrieval-loop]] · [[context-rot]]
