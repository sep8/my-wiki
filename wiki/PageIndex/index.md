# PageIndex — Index

A vectorless, reasoning-based RAG framework by [[vectify-ai]] that turns documents into a JSON ToC tree and lets LLMs navigate it agentically.

## Start here
- [[pageindex]] — what PageIndex is, at a glance.
- [[reasoning-based-rag]] — the core idea vs. [[vector-based-rag]].
- [[agentic-retrieval-loop]] — the iterative retrieval procedure.

## Concepts
- [[tree-index]] — the JSON hierarchical ToC structure.
- [[in-context-index]] — index lives in the LLM context, not an external store.
- [[context-rot]] — why long context alone doesn't solve retrieval.
- [[limitations-of-vector-rag]] — the five failure modes PageIndex targets.
- [[claude-code-agentic-rag]] — the cited precedent for moving away from vector RAG.

## Tree search (within one document)
- [[tree-search]] — overview.
- [[llm-tree-search]] — LLM picks nodes from the tree.
- [[hybrid-tree-search]] — LLM + value-based vector scoring in parallel.
- [[node-scoring]] — the shared aggregation formula.

## Document search (across many documents)
- [[doc-search]] — overview.
- [[doc-search-by-metadata]] — query→SQL, for structured corpora (closed beta).
- [[doc-search-by-semantics]] — vector search at the doc level.
- [[doc-search-by-description]] — LLM-written one-sentence descriptions.

## Products & APIs
- [[chat-api]] — PageIndex-hosted conversational endpoint (beta, OpenAI-compatible).
- [[document-processing-api]] — upload, tree, OCR, list, delete.
- [[pageindex-mcp]] — MCP server for agent frameworks.
- [[pageindex-chat]] — end-user web product.
- [[pageindex-ocr]] — long-context OCR model.

## SDKs
- [[python-sdk]] — `pip install pageindex`.
- [[javascript-sdk]] — `npm install @pageindex/sdk`.

## Specialized pipelines
- [[vision-rag]] — VLM reads page images directly, no OCR.
- [[cookbooks]] — self-hosted patterns + MCP integration notebooks.

## Meta
- [[vectify-ai]] — the team and blog history.
- [[contradictions]] — cross-source tensions.
