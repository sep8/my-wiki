# PageIndex

## Summary
PageIndex is a vectorless, reasoning-based RAG framework by [[vectify-ai]] that turns a document into a tree-structured index (a hierarchical Table of Contents) and lets an LLM perform agentic reasoning over that structure for traceable, explainable retrieval — without vector databases or chunking.

## Explanation
PageIndex replaces similarity search with structural navigation. Documents are processed into a JSON [[tree-index]] whose nodes carry titles, summaries, and pointers to raw content. At query time, the LLM reads this index inside its context window (an [[in-context-index]]) and uses [[agentic-retrieval-loop]] to decide *where to look next* rather than ranking pre-embedded chunks.

The framework is offered as a cloud service. Two main integration paths:
- **Bring your own LLM/agent** via [[pageindex-mcp]] — your model calls PageIndex as a tool.
- **Use PageIndex's LLM** via the [[chat-api]] — no model setup required.

The framework is open source on GitHub (`VectifyAI/PageIndex`) and also powers a hosted chat product, [[pageindex-chat]].

## Related
[[reasoning-based-rag]] · [[vector-based-rag]] · [[tree-index]] · [[agentic-retrieval-loop]] · [[tree-search]] · [[document-processing-api]] · [[python-sdk]] · [[javascript-sdk]]
