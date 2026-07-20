# Version 5.1 Orchestrator-Agent Contract

## Summary

At SDK v5.1, the assistant changed from message-only exchanges to structured
orchestrator-agent inputs and outputs for more reliable routing, shared state,
and multi-step work.

## Contract Shape

The orchestrator sends an `agentExecutionContext` with fields such as the user
request, assigned task, messages, prior steps, and shared state. An agent
returns an `AgentResult` with an output message, status, summary, and optional
shared-state patch.

The orchestrator still normalizes missing or invalid fields for compatibility,
but the source recommends explicit structured responses. Agents that assumed a
message-only contract may fail after upgrading.

TODO: Refresh the raw FAQ capture before documenting exact migration steps; its
migration instruction ends after “update existing agents to” and is incomplete.

## Related

[[assistant-and-orchestration]], [[custom-agents]]

## Source

[AI components FAQ](<../../raw/agentic-mapping-app/Frequently Asked Questions  ArcGIS Maps SDK for JavaScript.md>) ([upstream](https://developers.arcgis.com/javascript/latest/agentic-apps/ai-faq/), captured 2026-07-20).
