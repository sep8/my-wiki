# Chat API (beta)

## Summary
PageIndex-hosted conversational endpoint (`POST https://api.pageindex.ai/chat/completions`). PageIndex provides the LLM — you just send messages and (optionally) `doc_id`s. OpenAI-compatible response shape. Supports streaming, intermediate tool-call metadata, multi-doc queries, and inline citations.

## Explanation

### Key parameters
| Parameter | Type | Notes |
|---|---|---|
| `messages` | Array | required |
| `doc_id` | string \| string[] | scope to one or many docs |
| `stream` | bool | SSE format |
| `temperature` | float 0–1 | |
| `enable_citations` | bool | inline `<doc=file.pdf;page=1>` markers |
| `stream_metadata` | bool | (JS SDK) include block-level intermediate events |

Auth header: `api_key: YOUR_PAGEINDEX_API_KEY`.

### Streaming intermediate events
Block types: `text_block_start/stop`, `mcp_tool_use_start/stop`, `mcp_tool_result_start/stop`. Lets clients show "now calling PageIndex tool …" UI in real time.

### Multi-doc
Pass `doc_id` as a list; the model can reason and compare across documents in one call.

### Relationship to other endpoints
- Recommended over the **legacy retrieval API** (`/retrieval/`) for most uses — see [[contradictions]].
- The local sources do not document the Chat API's internal search algorithm; do not assume the legacy Retrieval API's [[hybrid-tree-search]] default applies unchanged.
- Also accessible from [[python-sdk]] (`pi_client.chat_completions(...)`) and [[javascript-sdk]] (`client.api.chatCompletions(...)`).

## Related
[[pageindex]] · [[document-processing-api]] · [[pageindex-mcp]] · [[python-sdk]] · [[javascript-sdk]] · [[agentic-retrieval-loop]] · [[pageindex-chat]]
