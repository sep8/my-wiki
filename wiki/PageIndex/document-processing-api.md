# Document Processing API

## Summary
The REST surface for uploading documents, getting OCR / [[tree-index]] results, listing, and deleting. Base URL `https://api.pageindex.ai`. All endpoints take an `api_key` header.

## Explanation

### Endpoints

| Method | Path | Purpose |
|---|---|---|
| `POST` | `/doc/` | Upload PDF (multipart `file`); returns `{ doc_id }` |
| `GET` | `/doc/{doc_id}/` | Status + results — `?type=tree` or `?type=ocr`, `?summary=true`, `?format=page\|node\|raw` |
| `GET` | `/doc/{doc_id}/metadata` | Name, status, page count, createdAt |
| `GET` | `/docs` | Paginated list — `?limit=` (1–100, default 50), `?offset=` |
| `DELETE` | `/doc/{doc_id}/` | Permanent delete |
| `POST` | `/markdown/` | Upload `.md`/`.markdown` → tree directly (skips PDF→OCR). Options: `if_add_node_id`, `if_add_node_summary`, `if_add_node_text`, `if_add_doc_description` |
| `POST` | `/retrieval/` | **Legacy** — submit query, returns `{ retrieval_id }` |
| `GET` | `/retrieval/{retrieval_id}/` | **Legacy** — status + `retrieved_nodes` |

### Tree response shape
`{ doc_id, status, retrieval_ready, result: [Node, ...] }` where each Node has `title, node_id, page_index, text, nodes`. `page_index` is 1-based.

### OCR formats
- `page` (default) — list of `{ page_index, markdown, images[base64] }`.
- `node` — organized by document structure.
- `raw` — single concatenated markdown string.

### Readiness signal
Before retrieval, poll the tree endpoint until `retrieval_ready: true`. SDK helpers wrap this (`pi_client.is_retrieval_ready(doc_id)`).

## Related
[[tree-index]] · [[chat-api]] · [[python-sdk]] · [[javascript-sdk]] · [[pageindex-ocr]]
