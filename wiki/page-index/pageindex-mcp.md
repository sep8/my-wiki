# PageIndex MCP

## Summary
A Model Context Protocol server that exposes PageIndex retrieval as tools to any MCP-compatible agent framework. API-key authenticated, production-oriented, open source (`VectifyAI/pageindex-mcp`). Shares the same `doc_id`s, plan, and API key as the REST [[document-processing-api]] and [[chat-api]].

## Explanation

### Connection config
```json
{
  "mcpServers": {
    "pageindex": {
      "type": "http",
      "url": "https://api.pageindex.ai/mcp",
      "headers": { "Authorization": "Bearer your_api_key" }
    }
  }
}
```

### Tools exposed (per the JS SDK's `client.tools` wrapper, which mirrors MCP)
- `pageindex_find_relevant_documents` — search docs by keyword/semantic query.
- `pageindex_get_document_structure` — fetch the hierarchical [[tree-index]] for a doc.
- `pageindex_get_page_content` — read text from specific pages (`"5"`, `"3,7,10"`, or `"5-10"`).

### Officially supported integrations (per cookbook)
Anthropic (Claude Messages API, Claude Agent SDK), OpenAI (Responses API, Agents SDK), Google (Gemini Interactions API, ADK), LangChain / LangGraph, DeepAgents, Pydantic AI, LlamaIndex, CAMEL AI, CrewAI, OpenRouter (Kimi / DeepSeek / GLM / MiniMax / Qwen). PageIndex marks Claude Messages API and Claude Agent SDK as "Recommended."

### Distinct from
**PageIndex Chat** ([[pageindex-chat]]) — that's the end-user product; MCP is for developer integration and does *not* share files or usage with Chat.

## Related
[[pageindex]] · [[chat-api]] · [[document-processing-api]] · [[python-sdk]] · [[javascript-sdk]] · [[agentic-retrieval-loop]] · [[cookbooks]]
