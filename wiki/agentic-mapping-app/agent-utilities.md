# Agent Utilities

## Summary

The AI components package provides higher-level utilities for building agents
with consistent patterns and less orchestration boilerplate.

## Agent Types

| Type | Role | Distinct property |
| --- | --- | --- |
| `LLMAgent` | Uses an LLM to decide when to call tools | `tools` |
| `FunctionAgent` | Runs deterministic application code | `execute` |
| `WorkflowAgent` | Coordinates agents through a workflow pattern | `workflow` |

Workflow patterns in the captured API include sequential, router, conditional,
parallel, loop, and switch. Middleware and tools add external calls, data
processing, and human-in-the-loop behavior.

Every type also needs a unique `name` and a routing-oriented `description`.
`LLMAgent` additionally uses prompt and model-tier configuration in the source
example.

## Dependencies and Registration

The utilities do not require a third-party orchestration framework. Zod v4 is
optional for structured outputs and schemas, but must be installed explicitly
if used rather than assumed to arrive through `@arcgis/ai-components`.

Register the constructed agent by assigning its `.registration` value to an
`arcgis-assistant-agent` element under the assistant.

## Related

[[custom-agents]], [[langgraph-agents]], [[model-options]]

## Source

[Custom agents](<../../raw/agentic-mapping-app/ArcGIS Maps SDK for JavaScript.md>) ([upstream](https://developers.arcgis.com/javascript/latest/agentic-apps/ai-custom-agents/#agent-utilities), captured 2026-07-20).
