# A2UI Runtime Flow

## Summary

A2UI runtime turns agent-produced protocol messages into stateful UI surfaces, then turns user interaction back into agent actions.

## Explanation

The core runtime loop is:

```text
agent output
  -> A2uiMessage[]
  -> MessageProcessor
  -> SurfaceGroupModel
  -> SurfaceModel
  -> DataModel + ComponentModel
  -> GenericBinder + DataContext
  -> framework renderer
  -> user action
  -> action handler
  -> agent input
```

The package boundary should preserve this layering. The agent adapter gets output from an existing model, service, or agent framework. A normalizer converts that output into A2UI messages. `MessageProcessor` owns state changes. The React renderer consumes `SurfaceModel` objects, not raw agent responses.

This division is important because it keeps agent transport, state management, rendering, and action dispatch separately testable.

## Related

[[message-processor]], [[surface-model]], [[data-model]], [[generic-binder]], [[react-renderer]], [[agent-adapter-boundary]]
