# Agentic Retrieval Loop

## Summary
The iterative procedure a PageIndex-equipped LLM follows to extract knowledge from a document: read the ToC, pick a section, extract, judge sufficiency, repeat or answer. Mirrors how a human expert navigates a long document.

## Explanation

The loop:

1. **Read the Table of Contents (ToC)** — the [[tree-index]] of the document — to understand structure and candidate sections.
2. **Select a section** most likely to contain the answer, given the question.
3. **Extract relevant information** by retrieving raw content for that node (`node_id → content`).
4. **Sufficient?**
   - Yes → go to step 5.
   - No → return to step 1 with another section (often guided by what was just read, e.g. following an in-text reference like "see Appendix G").
5. **Answer the question** using the accumulated context.

The ToC serves as the navigational map. Because the index is [[in-context-index]], the model can also follow cross-references inside the document — a class of cue that [[vector-based-rag]] systematically misses.

PageIndex's hosted Chat API automates this loop end-to-end; for self-hosted use, see the cookbooks listed in [[cookbooks]] and the per-step tree search methods in [[tree-search]].

## Related
[[reasoning-based-rag]] · [[tree-index]] · [[in-context-index]] · [[tree-search]] · [[pageindex-mcp]] · [[chat-api]]
