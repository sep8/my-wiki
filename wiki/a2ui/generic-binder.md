# GenericBinder

## Summary

`GenericBinder` compiles raw A2UI component properties into renderer-ready props using the component's Zod schema and the current `DataContext`.

## Explanation

The binder reads a component schema to classify properties as:

- dynamic values
- actions
- structural child lists
- validation checks
- static values
- objects or arrays containing those behaviors

This schema-driven approach is the reason custom catalogs should use A2UI common schemas. If a property is plain `z.string()`, `{ path: "/x" }` is not treated as a data binding. If it uses a dynamic string schema, the binder can resolve and subscribe to it.

Key behaviors:

- dynamic props become resolved values and reactive subscriptions.
- action props become callable functions that dispatch standardized actions.
- structural child lists can turn an array path into repeated child render contexts.
- `checks` are evaluated reactively and produce `isValid` plus `validationErrors`.
- two-way setters such as `setValue(...)` are generated for dynamic props bound to paths.

Dynamic structural children are central to composable UI. An agent can define one card template and bind it to `/restaurants`, letting the renderer create one child context per item instead of generating many duplicate component definitions.

## Related

[[data-context]], [[data-model]], [[basic-catalog]], [[react-renderer]]
