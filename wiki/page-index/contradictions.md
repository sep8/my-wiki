# Contradictions & Cross-source Tensions — PageIndex

Cross-source tensions inside the local PageIndex corpus. None are deep contradictions; most are evolution / scope mismatches between docs of different vintages.

## 1. Default retrieval algorithm vs. legacy retrieval API

- **Claim A** ([[hybrid-tree-search]] tutorial, `tutorials-tree-search-hybrid.md`): "This hybrid approach is the default search method used in our retrieval API."
- **Claim B** ([[document-processing-api]] reference, `API Endpoints.md`): the `/retrieval/` endpoints are explicitly marked **legacy** and the docs "recommend using the Chat API instead."
- **Reconciliation:** both can be true. Hybrid is the documented default *within* the legacy Retrieval API, while PageIndex now steers new users toward the Chat API. The local sources do not disclose the Chat API's internal search algorithm, so the legacy hybrid default should not be projected onto it.

## 2. "No vectors needed" vs. vector use in hybrid/semantic paths

- **Claim A** (marketing across `PageIndex.md`, `Introduction.md`, cookbooks): PageIndex is "vectorless" and "requires no vector database."
- **Claim B** ([[hybrid-tree-search]], [[doc-search-by-semantics]]): both pipelines use a vector DB + embeddings — for per-node value scoring (hybrid) and for per-document ranking (semantics).
- **Reconciliation:** the "vectorless" claim describes the base architecture and a supported pure [[llm-tree-search]] path, not every PageIndex workflow. The legacy Retrieval API documents hybrid search as its default, and semantic document selection also uses vectors. So "no vector database required" is accurate for the vectorless path, but not as a universal statement about every available configuration.

## 3. Is OCR still needed?

- **Claim A** ([[pageindex-ocr]] blog, Aug 2025): PageIndex ships its own OCR model as "the first long-context OCR model" — implicitly, OCR is valuable.
- **Claim B** ([[vision-rag]] cookbook + "Do We Still Need OCR?" blog, Oct 2025): with modern VLMs reading page images directly, the OCR step may no longer be necessary.
- **Reconciliation:** the OCR product still serves cases that need machine-readable text downstream (indexing, search, accessibility, deterministic extraction). The "do we still need OCR?" framing argues against OCR as an *intermediate step for QA* specifically, where a VLM can substitute. The two coexist depending on the consumer of the output.

## 4. Naming: "PageIndex" → product, framework, tree, or company

The same word is used at multiple levels — the company-supplied framework, the JSON tree structure it produces, the cloud service, and the chat product. Not a contradiction, but a source of ambiguity when reading individual snippets. This wiki disambiguates: [[pageindex]] (overview/service), [[tree-index]] (the JSON structure), [[pageindex-chat]] (end-user product), [[vectify-ai]] (the team).

## 5. Document-search tutorials vs. current retrieval surface

- **Claim A** (`doc-search-metadata.md`, `doc-search-semantics.md`, `doc-search-description.md`): after selecting documents, pass their `doc_id`s to the PageIndex Retrieval API.
- **Claim B** (`API Endpoints.md`): the Retrieval API is legacy, retained for backward compatibility, and the Chat API is recommended for most use cases.
- **Reconciliation:** the metadata, semantic, and description-based document-selection strategies remain useful, but their final integration step is stale. Feed the selected documents into a current surface such as [[chat-api]] or [[pageindex-mcp]] unless maintaining a legacy integration.
