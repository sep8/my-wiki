# LangGraph Agents

## Summary

LangGraph is the custom-agent path for explicit orchestration graphs, state,
branching, and multi-step workflows.

## Registration Shape

The captured guide defines an agent registration object with:

- `id`, `name`, and `description` for identity and routing;
- `createGraph` for the LangGraph state graph;
- `workspace` for context and state annotations.

Unlike [[agent-utilities]], this registration object is assigned directly to
the `agent` property of an `arcgis-assistant-agent` element.

## Dependencies and Models

The captured guide targets LangGraph v1.2, LangChainJS v1.3, and Zod v4, all of
which must be installed explicitly. A custom LLM may be used through this path
when the application supplies its own backend for LLM access; see
[[model-options]].

Use LangGraph only when its additional control is useful, because the
application owns more orchestration and state design than with the utility
path.

## Related

[[custom-agents]], [[agent-utilities]], [[model-options]]

## Sources

- [Custom agents snapshot](<../../raw/agentic-mapping-app/ArcGIS Maps SDK for JavaScript.md>) ([upstream](https://developers.arcgis.com/javascript/latest/agentic-apps/ai-custom-agents/#langgraph), captured 2026-07-20)
- [FAQ snapshot](<../../raw/agentic-mapping-app/Frequently Asked Questions  ArcGIS Maps SDK for JavaScript.md>) ([upstream](https://developers.arcgis.com/javascript/latest/agentic-apps/ai-faq/), captured 2026-07-20)
