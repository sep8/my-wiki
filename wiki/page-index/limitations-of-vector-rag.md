# Limitations of Vector-based RAG

## Summary
The five failure modes of classic [[vector-based-rag]] that PageIndex's [[reasoning-based-rag]] is designed to address.

## Explanation

1. **Query–knowledge space mismatch.** Vector search assumes most-similar text = most-relevant text. Queries express *intent*, not content — they often don't lexically resemble the answer.
2. **Semantic similarity ≠ relevance.** Especially severe in domain-specific corpora (financial filings, legal docs, technical manuals) where many passages share near-identical semantics but differ critically in relevance.
3. **Hard chunking breaks semantic and contextual integrity.** Fixed-size chunks (e.g. 512 or 1000 tokens) cut through sentences, paragraphs, and sections, fragmenting meaning.
4. **Cannot integrate chat history.** Each query is treated independently; the retriever doesn't know what was asked or answered before.
5. **Poor handling of in-document references.** Cues like "see Appendix G" or "refer to Table 5.3" share no semantic similarity with the referenced content, so vector retrieval misses them without extra preprocessing (e.g. a knowledge graph).

PageIndex's counter-arguments for each are in [[reasoning-based-rag]] and the [[agentic-retrieval-loop]].

## Related
[[vector-based-rag]] · [[reasoning-based-rag]] · [[tree-index]] · [[context-rot]]
