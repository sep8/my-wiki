# Assistant and Orchestration

## Summary

`arcgis-assistant` provides the chat interface and orchestration layer. It has
no useful agent capability by itself: at least one ArcGIS or custom agent must
be registered.

## Request Flow

For each prompt, the assistant's orchestration agent determines intent and
routes relevant work to agents according to their descriptions and
capabilities. An agent can return text or cause a tool or action to interact
with the map. The assistant then presents the response or executes the map
action.

An agent's description is therefore part of routing behavior, not merely UI
copy. It should identify the agent's purpose, capabilities, and representative
prompts. Names should be short and unique to avoid registration conflicts.

At SDK v5.1 the orchestrator-agent boundary changed to structured request and
result objects; see [[version-5-1-contract]].

## Related

[[arcgis-agents]], [[custom-agents]], [[version-5-1-contract]]

## Sources

- [Introduction snapshot](<../../raw/agentic-mapping-app/Intro to building agentic mapping applications  ArcGIS Maps SDK for JavaScript.md>) ([upstream](https://developers.arcgis.com/javascript/latest/agentic-apps/ai-introduction/), captured 2026-07-20)
- [FAQ snapshot](<../../raw/agentic-mapping-app/Frequently Asked Questions  ArcGIS Maps SDK for JavaScript.md>) ([upstream](https://developers.arcgis.com/javascript/latest/agentic-apps/ai-faq/), captured 2026-07-20)
