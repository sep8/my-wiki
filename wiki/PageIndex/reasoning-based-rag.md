# Reasoning-based RAG

## Summary
A retrieval paradigm where the LLM *reasons* over a structured representation of a document (e.g. a [[tree-index]]) to decide which sections are relevant, instead of retrieving by static embedding similarity. The approach PageIndex builds on.

## Explanation
Traditional [[vector-based-rag]] assumes "most semantically similar text = most relevant text." Reasoning-based RAG rejects that assumption. The model:

1. Reads a structural index (Table of Contents / [[tree-index]]) of the document.
2. *Infers* which section is likely to contain the answer, based on the query's intent.
3. Pulls the raw content of that section, judges sufficiency, and iterates if needed.

This mirrors how a human expert navigates a long report — using the ToC, jumping to the appendix when a cross-reference says so, refining based on what was just read. See [[agentic-retrieval-loop]] for the iterative procedure.

PageIndex's authors argue this directly addresses the five [[limitations-of-vector-rag]]: query/knowledge mismatch, similarity ≠ relevance, hard chunking breaking context, no chat history, and inability to follow in-document references.

A related precedent: [[claude-code-agentic-rag]] — Claude Code moved away from vector RAG for code search and uses agentic grep-style retrieval instead.

## Related
[[pageindex]] · [[vector-based-rag]] · [[tree-index]] · [[agentic-retrieval-loop]] · [[in-context-index]] · [[limitations-of-vector-rag]] · [[claude-code-agentic-rag]]
