# UI Runtime Flow

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

Each stage is a distinct upstream concern: agent transport produces messages, `MessageProcessor` owns state changes, the React renderer consumes `SurfaceModel` objects (never raw agent responses), and action dispatch flows back along the same path.

## Related

[[message-processor]], [[surface-model]], [[data-model]], [[generic-binder]], [[react-renderer]]
