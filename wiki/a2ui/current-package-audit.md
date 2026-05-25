# Current Package Audit

## Summary

The current local package already has useful protocol, core, model adapter, and React layers, but its reusable package boundary should become less chat-app-specific and more runtime-oriented.

## Explanation

The current workspace has four reusable packages:

- `@agentic-ui-experience/a2ui-protocol`: protocol types, schema validation, fixtures, and SDK compatibility helpers.
- `@agentic-ui-experience/a2ui-core`: prompting, model calls, normalization, validation, sessions, chat, and action round-trip.
- `@agentic-ui-experience/a2ui-openai`: OpenAI model adapter.
- `@agentic-ui-experience/a2ui-react`: React hook, chat UI, protocol panel, and surface bridge.

Strong parts:

- protocol definitions are centralized.
- model transport is abstracted through `ModelClient`.
- product modules are a useful domain extension point.
- prompt building avoids model-generated HTML/JSX/CSS.
- action round-trip is already implemented.
- rendering is delegated to an A2UI SDK.

Main gaps:

- renderer target needs a decision: current SDK bridge vs Google `@a2ui/react` plus `MessageProcessor`.
- normalization is too heuristic for a generic package default.
- prompt building is hard-coded to the basic catalog.
- output parsing is narrower than the Python SDK patterns.
- React APIs are shaped around chat endpoints instead of lower-level agent/runtime primitives.

Best next package change: implement a reusable output normalizer and let existing model output processing call it before deeper renderer migration work.

## Related

[[a2ui-package-goal]], [[agent-adapter-boundary]], [[output-normalization]], [[react-renderer]], [[contradictions]]
