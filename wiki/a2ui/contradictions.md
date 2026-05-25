# A2UI Contradictions

## Renderer Package Target

Claim: The studied Google A2UI runtime model uses `@a2ui/web_core` plus `@a2ui/react`.

Sources: `raw/a2ui/modules/message-processor.md`, `raw/a2ui/modules/react-renderer.md`

Conflicting claim: The current package audit says the local package currently renders through `@a2ui-sdk/react`, not directly through the Google `@a2ui/react` and `MessageProcessor` boundary.

Sources: `raw/a2ui/modules/current-package-audit.md`

Reconciliation: Treat this as an implementation decision, not a factual conflict. New generic package APIs should first improve adapter, normalization, validation, and action boundaries, then explicitly decide whether to keep the existing renderer SDK or migrate to the Google `@a2ui/react` runtime stack.

## Normalization Strictness

Claim: The current normalizer remaps unknown components, strips properties, patches icons/actions, and invents fallbacks.

Sources: `raw/a2ui/modules/current-package-audit.md`

Conflicting claim: The Python SDK parser only performs conservative syntax repair and leaves semantic validation to the schema and integrity validator.

Sources: `raw/a2ui/modules/python-schema-prompt-parser.md`

Reconciliation: Use strict parsing and validation as the reusable package default. Keep heuristic repair as an explicit opt-in mode with warnings, and leave domain fallback policy to the application.
