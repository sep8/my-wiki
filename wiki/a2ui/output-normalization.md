# Output Normalization

## Summary

Output normalization should accept practical agent response shapes and reduce them to validated `A2uiMessage[]` before touching the runtime.

## Explanation

The package should treat raw agent output as untrusted and format-variable. The normalizer should support:

- `A2uiMessage[]`
- `{ messages: A2uiMessage[] }`
- `{ a2uiMessages: A2uiMessage[] }`
- raw JSON strings
- markdown fenced JSON
- `<a2ui-json>...</a2ui-json>` tagged blocks
- A2A `DataPart` payloads with `application/json+a2ui`

Parsing and validation should be separate phases. Parsing can perform small syntax fixes, while validation enforces protocol, catalog, component graph, and safety constraints.

For a reusable package, strict mode should be the default. A repair mode can exist, but it should be explicit and report warnings because silently remapping unknown components or dropping invalid properties can make the UI mean something different from the agent's intended output.

## Related

[[agent-adapter-boundary]], [[schema-prompt-parser]], [[message-processor]], [[current-package-audit]]

## Contradictions

See [[contradictions]] for the strict-vs-repair design tension.
