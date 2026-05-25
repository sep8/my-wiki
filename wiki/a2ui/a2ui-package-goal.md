# A2UI Package Goal

## Summary

The target package should connect existing agents to A2UI so different domain agents can emit composable UI through one protocol.

## Explanation

The raw notes describe A2UI as a monorepo made of a specification, web core, renderers, agent SDKs, samples, and tools rather than one drop-in package. For a React MVP, the preferred runtime stack is `@a2ui/web_core` plus `@a2ui/react`, with optional markdown rendering.

The package should not reimplement the renderer. Its value is the integration layer around existing agents:

- agent adapter interface
- output normalization
- `MessageProcessor` lifecycle
- surface state exposure
- action round-trip
- prompt helpers
- validation and safety policy
- catalog composition

The basic architecture is:

```text
existing agent
  -> agent adapter
  -> normalize output to A2uiMessage[]
  -> MessageProcessor.processMessages(...)
  -> SurfaceModel[]
  -> @a2ui/react <A2uiSurface />
```

An MVP should focus on React and non-streaming output. Streaming, domain catalogs, validation retry, and deeper security policy can follow after the end-to-end loop is stable.

## Related

[[agent-adapter-boundary]], [[a2ui-runtime-flow]], [[message-processor]], [[react-renderer]], [[current-package-audit]]

## Contradictions

See [[contradictions]] for the renderer target tension between the studied Google runtime and the current local package.
