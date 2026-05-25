# SurfaceModel

## Summary

`SurfaceModel` is the state aggregate for one A2UI surface, holding component state, data state, catalog metadata, and action/error event emitters.

## Explanation

A surface is not a DOM element or React component. It is the renderer-consumable runtime model created by [[message-processor]].

Each surface owns:

- `dataModel`: the reactive JSON store
- `componentsModel`: the surface-local component registry
- `catalog`: the component and function catalog
- `theme`
- `sendDataModel`: whether client data can be sent back to the agent
- `onAction` and `onError` event sources

`dispatchAction(payload, sourceComponentId)` standardizes event actions into a client action with name, surface id, source component id, timestamp, and context. Local `functionCall` actions are handled in the client runtime path and do not necessarily become server events.

Disposal matters. When a surface is deleted, it should dispose its data model, component model, action listeners, and error listeners to avoid leaks during long agent sessions.

## Related

[[message-processor]], [[data-model]], [[data-context]], [[generic-binder]], [[react-renderer]]
