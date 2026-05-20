# Cookbooks & Integration Examples

## Summary
PageIndex ships notebook-style cookbooks for two purposes: (a) **self-hosted patterns** that build retrieval loops by hand against the SDK, and (b) **MCP integrations** that connect [[pageindex-mcp]] to specific agent frameworks.

## Explanation

### Self-hosted pattern cookbooks
- **Vectorless RAG with PageIndex** — minimal end-to-end: build [[tree-index]], LLM tree search, answer. Uses GPT-4.1.
- **Agentic Vectorless RAG with PageIndex** — same idea but as an *agent* (OpenAI Agents SDK) with three function tools: `get_document`, `get_document_structure`, `get_page_content`. The agent chooses tool calls based on the question.
- **Agentic Retrieval with PageIndex Chat API (beta)** — uses [[chat-api]] as a retrieval primitive via prompting (no manual tree search).
- **Vision RAG with PageIndex** — [[vision-rag]]: PageIndex picks pages, VLM reads page images directly, no OCR text.

### MCP integration cookbooks
Per-framework Jupyter notebooks that walk through agentic, reasoning-based retrieval from an uploaded PDF using [[pageindex-mcp]]:

| Platform | Framework | Model in notebook |
|---|---|---|
| Anthropic | Claude Messages API *(Recommended)* | Claude Sonnet 4.6 |
| Anthropic | Claude Agent SDK *(Recommended)* | Claude Sonnet 4.6 |
| OpenAI | Responses API | GPT-5.5 |
| OpenAI | Agents SDK | GPT-5.5 |
| Google | Gemini Interactions API | Gemini 2.5 Pro |
| Google | ADK | Gemini 3.1 Pro |
| LangChain | LangChain / LangGraph | Claude Sonnet 4.6 |
| LangChain | DeepAgents | Claude Sonnet 4.6 |
| Pydantic | Pydantic AI | Claude Sonnet 4.6 |
| LlamaIndex | LlamaIndex | Claude Sonnet 4.6 |
| CAMEL AI | CAMEL AI | Claude Sonnet 4.6 |
| CrewAI | CrewAI | Claude Sonnet 4.6 |
| OpenRouter | OpenAI Agents SDK + OpenRouter | Kimi K2.6 (default), DeepSeek v4 Pro, GLM 5.1, MiniMax M2.7, Qwen 3.6 Max |

All require: a PageIndex API key + a model-provider API key, paste and run.

## Related
[[pageindex-mcp]] · [[chat-api]] · [[python-sdk]] · [[vision-rag]] · [[agentic-retrieval-loop]]
