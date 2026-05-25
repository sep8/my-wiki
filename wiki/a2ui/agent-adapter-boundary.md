# Agent Adapter Boundary

## Summary

The agent adapter should be a small transport boundary that returns unknown output, leaving normalization and validation to shared package code.

## Explanation

A reusable A2UI package should not assume fixed chat endpoints or one model vendor. A minimal adapter can be generic:

```ts
export interface A2UIAgentAdapter<TInput = unknown, TContext = unknown> {
  send(input: TInput, context?: TContext): Promise<unknown>;
}
```

The adapter calls an existing agent and returns the raw response. Package code then handles:

- parsing raw strings, JSON, structured payloads, and A2A DataParts
- validating the resulting A2UI messages
- calling `MessageProcessor.processMessages(...)`
- exposing surfaces to the UI layer
- sending user actions back to the adapter

Action round-trip should send the standardized client action plus optional client data model:

```text
{ version: "v0.9", action, clientDataModel? }
```

This boundary lets the same runtime work with OpenAI, custom HTTP agents, A2A, local agents, or app-specific orchestration.

## Related

[[a2ui-package-goal]], [[output-normalization]], [[message-processor]], [[schema-prompt-parser]]
