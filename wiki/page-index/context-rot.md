# Context Rot

## Summary
The empirical observation (from Chroma's "context rot" study, referenced by PageIndex) that LLM performance deteriorates as the input context grows longer — even when the model nominally supports the longer window. One of the core motivations for retrieval (and for PageIndex's [[reasoning-based-rag]] vs. just "stuff the whole doc in").

## Explanation
Modern LLMs advertise increasingly long context windows, but real-world tasks show degradation well before the advertised limit. PageIndex cites this as the reason you still need RAG even with long-context models — and as a reason to prefer *selective* retrieval (tree navigation) over chunk-and-stuff.

The [[in-context-index]] design is calibrated to this: the JSON [[tree-index]] is small enough to live in context without rotting, while raw section text is pulled in *only when chosen* by reasoning.

## Related
[[reasoning-based-rag]] · [[in-context-index]] · [[tree-index]] · [[vector-based-rag]]
