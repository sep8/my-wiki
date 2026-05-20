# Contradictions & Cross-source Tensions — PageIndex

Cross-source tensions inside the local PageIndex corpus. None are deep contradictions; most are evolution / scope mismatches between docs of different vintages.

## 1. Default retrieval algorithm vs. legacy retrieval API

- **Claim A** ([[hybrid-tree-search]] tutorial, `tutorials-tree-search-hybrid.md`): "This hybrid approach is the default search method used in our retrieval API."
- **Claim B** ([[document-processing-api]] reference, `API Endpoints.md`): the `/retrieval/` endpoints are explicitly marked **legacy** and the docs "recommend using the Chat API instead."
- **Reconciliation:** both can be true. Hybrid is the default *within* the retrieval API; PageIndex now steers new users toward the Chat API (which itself can be assumed to use the same or a successor retrieval engine). Treat the Chat API as the current-day surface and the retrieval API as deprecated-but-functional.

## 2. "No vectors needed" vs. vector use in hybrid/semantic paths

- **Claim A** (marketing across `PageIndex.md`, `Introduction.md`, cookbooks): PageIndex is "vectorless" and "requires no vector database."
- **Claim B** ([[hybrid-tree-search]], [[doc-search-by-semantics]]): both pipelines use a vector DB + embeddings — for per-node value scoring (hybrid) and for per-document ranking (semantics).
- **Reconciliation:** the "vectorless" claim describes the **default in-document retrieval path** (pure [[llm-tree-search]] over the [[tree-index]]). Vectors *can* enter as a value function or as a doc-selection layer in larger setups, but PageIndex never serves chunks as the final answer context — it always returns whole nodes. So "no vectors needed *as the retrieval substrate*," not "no vectors anywhere ever."

## 3. Is OCR still needed?

- **Claim A** ([[pageindex-ocr]] blog, Aug 2025): PageIndex ships its own OCR model as "the first long-context OCR model" — implicitly, OCR is valuable.
- **Claim B** ([[vision-rag]] cookbook + "Do We Still Need OCR?" blog, Oct 2025): with modern VLMs reading page images directly, the OCR step may no longer be necessary.
- **Reconciliation:** the OCR product still serves cases that need machine-readable text downstream (indexing, search, accessibility, deterministic extraction). The "do we still need OCR?" framing argues against OCR as an *intermediate step for QA* specifically, where a VLM can substitute. The two coexist depending on the consumer of the output.

## 4. Naming: "PageIndex" → product, framework, tree, or company

The same word is used at multiple levels — the company-supplied framework, the JSON tree structure it produces, the cloud service, and the chat product. Not a contradiction, but a source of ambiguity when reading individual snippets. This wiki disambiguates: [[pageindex]] (overview/service), [[tree-index]] (the JSON structure), [[pageindex-chat]] (end-user product), [[vectify-ai]] (the team).
