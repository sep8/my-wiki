# Custom Agents

## Summary

Custom agents extend `arcgis-assistant` with application-specific analysis,
external services, organization data, or domain workflows.

## Choosing an Implementation

- Start with [[agent-utilities]] for straightforward tool calling, routing,
  standard workflow patterns, and less boilerplate.
- Use [[langgraph-agents]] when the workflow needs custom graph design,
  advanced branching, explicit state, or deeper multi-step control.

Both approaches need a clear, unique name and a routing-oriented description.
Registration uses an `arcgis-assistant-agent` child element whose `agent`
property receives the registration object. Agent-utility instances expose that
object through `.registration`; the LangGraph approach defines the registration
object directly.

Human-in-the-loop interrupts can obtain missing information or require
confirmation before consequential tool execution.

## Related

[[assistant-and-orchestration]], [[agent-utilities]], [[langgraph-agents]],
[[model-options]]

## Sources

- [Custom agents snapshot](<../../raw/agentic-mapping-app/ArcGIS Maps SDK for JavaScript.md>) ([upstream](https://developers.arcgis.com/javascript/latest/agentic-apps/ai-custom-agents/), captured 2026-07-20)
- [FAQ snapshot](<../../raw/agentic-mapping-app/Frequently Asked Questions  ArcGIS Maps SDK for JavaScript.md>) ([upstream](https://developers.arcgis.com/javascript/latest/agentic-apps/ai-faq/), captured 2026-07-20)
