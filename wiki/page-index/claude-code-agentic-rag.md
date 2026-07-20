# Claude Code → Agentic RAG (precedent)

## Summary
PageIndex's authors cite Anthropic's Claude Code as a precedent: Claude Code moved *away* from vector-based RAG for code retrieval, instead letting the model use grep/file-navigation tools agentically. PageIndex argues the same principle applies to *document* retrieval — hence [[reasoning-based-rag]].

## Explanation
The argument structure used in the foundational PageIndex blog:
- Claude Code achieved "superior precision and speed without relying on vector databases" by giving the LLM tools to navigate code directly.
- Code is structured, with cross-references and naming conventions — and vector similarity poorly captures that structure.
- Long-form documents (financial reports, legal filings, technical manuals) are similar in this respect.
- Therefore: replace embeddings + similarity with structural index ([[tree-index]]) + reasoning ([[agentic-retrieval-loop]]).

Referenced posts: "From Claude Code to Agentic RAG" (Vectify blog, Sep 2025) and Lance Martin's "vibe-code" blog post.

## Related
[[reasoning-based-rag]] · [[vector-based-rag]] · [[pageindex]] · [[vectify-ai]]
