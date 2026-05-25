# MessageProcessor

## Summary

`MessageProcessor` is the A2UI v0.9 browser runtime entry point: it consumes A2UI messages and maintains the active surface group.

## Explanation

`processMessages()` accepts either an `A2uiMessage[]` or `{ messages: A2uiMessage[] }`. Each message must contain exactly one update type:

- `createSurface`: creates a surface with a registered catalog id.
- `updateComponents`: creates or patches component models by stable component id.
- `updateDataModel`: writes data into a JSON Pointer path.
- `deleteSurface`: removes and disposes a surface.

The processor owns a `SurfaceGroupModel`, which is a registry of active [[surface-model]] instances. It also wires a group-level action handler so UI actions can be sent back to the application or agent.

Important runtime constraints:

- `createSurface` must happen before component or data updates for that surface.
- `catalogId` must match a registered catalog.
- each component needs a stable `id`.
- first creation of a component must include its `component` type.
- changing a component type recreates the component model.

The processor can also report client capabilities, including supported catalog ids and optional inline catalog schemas. This is a key input for catalog-aware agent prompts.

## Related

[[a2ui-runtime-flow]], [[surface-model]], [[basic-catalog]], [[schema-prompt-parser]], [[react-renderer]]
