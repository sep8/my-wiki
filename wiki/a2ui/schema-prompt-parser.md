# Schema Prompt Parser

## Summary

The Python SDK shows how agent-side A2UI generation should combine catalog-aware prompting, explicit JSON delimiters, conservative parsing, validation, and optional retry.

## Explanation

The SDK flow is:

```text
CatalogConfig
  -> A2uiSchemaManager
  -> generate_system_prompt(...)
  -> LLM output with <a2ui-json>...</a2ui-json>
  -> parse_response(...)
  -> parse_and_fix(...)
  -> catalog validator
  -> A2A DataPart or client message
```

Prompt generation includes the server-to-client message schema, common types, catalog schema, and examples. This is important: telling an agent only about components is not enough. It must also know the legal message envelope and topology rules.

The parser prefers explicit boundaries. It extracts `<a2ui-json>` blocks, strips optional markdown fences, parses JSON, and performs only conservative syntax repair such as replacing smart quotes and removing trailing commas. Semantic repair is left to validation or retry.

Validation goes beyond JSON Schema. It checks component id uniqueness, root component presence, child references, self-reference, circular references, recursion limits, function call depth, and relaxed JSON Pointer paths.

## Related

[[output-normalization]], [[basic-catalog]], [[message-processor]], [[agent-adapter-boundary]]

## Contradictions

See [[contradictions]] for the tension between conservative parser repair and the current package's more heuristic normalizer.
